package ;

import hant.CmdOptions;
import haxe.CallStack;
import haxe.io.Path;
import haxe.Json;
import neko.Lib;
import sys.FileSystem;
import sys.io.File;
using StringTools;
using Tools;
using Lambda;

class Main
{
	static function main():Void
	{
		var parser = new CmdOptions();
		parser.add("srcJsonFilePath", "out/data.json", [ "-src", "--source" ], "Source yuidoc json file path. Default is 'out/data.json'.");
		parser.add("destDir", "library", null, "Output directory.");
		parser.add("removePathPrefix", "", [ "-rpp", "--remove-path-prefix" ], "Source files path prefix to remove.");
		parser.add("publicPrefix", false, [ "--public-prefix" ], "Write 'public' before class member declarations.");
		parser.addRepeatable("ignoreFiles", String, [ "-ifile", "--ignore-file" ], "Path to source file to ignore.");
		parser.addRepeatable("ignoreClasses", String, [ "-iclass", "--ignore-class" ], "Class name to ignore.");
		parser.add("noDescriptions", false, [ "-nd", "--no-descriptions" ], "Do not generate descriptions.");
		parser.add("nativePackage", "", [ "-np", "--native-package" ], "Native package for @:native meta.");
		parser.add("generateDeprecated", false, [ "--generate-deprecated" ], "Generate deprecated classes/members.");
		
		var args = Sys.args();
		
		if (args.length > 0)
		{
			var options = parser.parse(args);
			generateLibrary(
				  options.get("srcJsonFilePath")
				, options.get("destDir")
				, options.get("removePathPrefix")
				, options.get("publicPrefix")
				, options.get("ignoreFiles")
				, options.get("ignoreClasses")
				, options.get("noDescriptions")
				, options.get("nativePackage")
				, options.get("generateDeprecated")
			);
		}
		else
		{
			Lib.println("yuidoc2haxe - generated haxe externs from the yuidoc's json.");
			Lib.println("Usage: yuidoc2haxe [<options>] <outputDirectory>");
			Lib.println("  Where options:");
			Lib.println(parser.getHelpMessage("    "));
		}
	}
	
	static function generateLibrary(
		  srcJsonFilePath : String
		, destDir : String
		, removePathPrefix : String
		, publicPrefix : Bool
		, ignoreFiles : Array<String>
		, ignoreClasses : Array<String>
		, noDescriptions : Bool
		, nativePackage : String
		, generateDeprecated : Bool
		
	) {
		destDir = Path.addTrailingSlash(destDir.replace("\\", "/"));
		removePathPrefix = Path.addTrailingSlash(removePathPrefix.replace("\\", "/"));
		ignoreFiles = ignoreFiles.map(function(p) return p.replace("\\", "/"));
		
		var itemDeclarationPrefx = publicPrefix ? "public " : "";
		
		var fileContent = File.getContent(srcJsonFilePath);
		var root : YuiDoc = Json.parse(fileContent);
		for (className in Reflect.fields(root.classes))
		{
			Lib.print(className);
			
			var klass : Klass = Reflect.field(root.classes, className);
			
			if (ignoreClasses.has(klass.module + "." + className) || ignoreClasses.has(className) || (!generateDeprecated && klass.deprecated))
			{
				Lib.println("...SKIP");
			}
			else
			{
				Lib.println("");
			}
			
			var file = Std.string(klass.file).replace("\\", "/");
			if (file.startsWith(removePathPrefix)) file = file.substr(removePathPrefix.length);
			if (ignoreFiles.has(file)) continue;
			file = Path.withoutExtension(file) + ".hx";
			file = destDir + file;
			
			
			var properties = [];
			var methods = [];
			var events = [];
			
			for (i in 0...root.classitems.length)
			{
				var item = root.classitems[i];
				
				var file = Std.string(item.file).replace("\\", "/");
				if (file.startsWith(removePathPrefix)) file = file.substr(removePathPrefix.length);
				if (ignoreFiles.has(file)) continue;
				
				if (item.access == "private") continue;
				if (item.access == "protected") continue;
				
				if (item.module == klass.module && item.getClass() == klass.name)
				{
					if (!generateDeprecated && item.deprecated) continue;
					
					var reProperty = new EReg("^property\\s+([_a-z][_a-z0-9]*)\\s*$", "i");
					
					if (reProperty.match(Std.string(item.description)))
					{
						if (item.itemtype == null) item.itemtype = "property";
						if (item.name == null) item.name = reProperty.matched(1);
					}
					
					if (item.name == null)
					{
						if (Std.string(item.description).indexOf("Docced in superclass") >= 0) continue;
						if (FileSystem.exists(item.file))
						{
							var nativeLine = File.getContent(item.file).replace("\r", "").split("\n")[item.line-1];
							if (nativeLine.indexOf("@ignore") >= 0) continue;
							if (nativeLine.indexOf("docced in super class") >= 0) continue;
						}
					}
					
					if (item.name == null)
					{
						throw "Unknow name for item = " + item;
					}
					
					if (item.name.startsWith("_")) continue; // protected
					
					fillItemFieldsFromSuperClass(root, item);
					
					if (item.itemtype == null)
					{
						if (item.getReturn() != null)
						{
							item.itemtype = "method";
						}
					}
					
					var itemCode = "";
					
					switch (item.itemtype)
					{
						case "property":
						
						case "method":
							methods.push(item);
							
						case "event":
							events.push(item);
						
						case _:
							throw "Unknow itemtype for item = " + item;
					}
				}
			}
			
			var eventsDeclarationCode = events.filter(function(item) return item.params != null).map(function(item)
			{
				var eventClassName = item.getClass() + capitalize(item.name) + "Event";
				
				return "typedef " + eventClassName + " =\n{\n" + item.params.map(function(p)
				{
					return "\tvar " + p.name +" : " + p.type + ";";
				}
				).join("\n");
			}
			).join("\n");
			
			var propertiesCode = properties.map(function(item)
			{
				if (item.type == null)
				{
					throw "Unknow type for property = " + item;
				}
				return "\t" + itemDeclarationPrefx + "var " + item.name + " : " + getHaxeType(item.type) + ";";
			}
			).join("\n");
			
			
			var methodsCode = methods.map(function(item)
			{
				var ret = item.getReturn();
				if (ret == null)
				{
					throw "Unknow return for method = " + item;
				}
				if (ret.type == null)
				{
					throw "Unknow return type for method = " + item;
				}
				try
				{
					return "\t" + itemDeclarationPrefx + "function " + item.name + paramsToString(item.params) + " : " + getHaxeType(ret.type) + ";";
				}
				catch (e:Dynamic)
				{
					throw "Unknow param type for method = " + item;
				}
			}
			).join("\n");
			
			var eventsCode = events.map(function(item)
			{
				var eventClassName = item.getClass() + capitalize(item.name) + "Event";
				
				if (item.params == null)
				{
					var reLinkToEvent = ~/See\s+the\s+[{][{]#crossLink\s+"([_a-z][_a-z0-9]*)"[}][}][{][{]\/crossLink[}][}]\s+class\s+for\s+a\s+listing\s+of\s+event\s+properties/i;
					if (reLinkToEvent.match(item.description))
					{
						eventClassName = reLinkToEvent.matched(1);
					}
					else
					{
						eventClassName = "Dynamic";
						Lib.println("WARNING: Unknow params for event '" + item.name + "' (" + item.file + " : " + item.line + ")");
					}
				}
				
				return "\t" + itemDeclarationPrefx + "inline function add" + capitalize(item.name) + "EventListener(handler:" + eventClassName + "->Void) addEventListener(\"" + item.name + "\", handler);";
			}
			).join("\n");
			
			var result = [];
			result.push("package " + klass.module.toLowerCase() + ";");
			result.push("");
			if (eventsDeclarationCode!="") result.push(eventsDeclarationCode);
			result.push("@:native(\"" + (nativePackage != "" ? nativePackage + "." : "") + klass.name + "\")");
			result.push("extern class " + klass.name + (klass.getExtends() != null && klass.getExtends() != "" ? " extends " + klass.getExtends() : ""));
			result.push("{");
			if (propertiesCode != "") result.push(propertiesCode);
			if (methodsCode != "") result.push(methodsCode);
			if (eventsCode != "") result.push(eventsCode);
			result.push("}");
			
			FileSystem.createDirectory(destDir + klass.module.toLowerCase());
			File.saveContent(destDir + klass.module.toLowerCase() + "/" + klass.name + ".hx", result.join("\n"));
		}
	}
	
	static function fillItemFieldsFromSuperClass(root:YuiDoc, item:Item)
	{
		var klass : Klass = Reflect.field(root.classes, item.getClass());
		var superKlassName = klass.getExtends();
		while (superKlassName != null && superKlassName != "")
		{
			var superKlass : Klass = Reflect.field(root.classes, superKlassName);
			
			if (superKlass == null)
			{
				if (![ "Array" ].has(superKlassName))
				{
					Lib.println("Warning: class '" + superKlassName + "' is not found.");
				}
				return;
			}
			
			var superItem = getKlassItem(root, superKlass, item.name);
			if (superItem != null)
			{
				if (item.getReturn() == null) item.setReturn(superItem.getReturn());
			}
			superKlassName = superKlass.getExtends();
		}
	}
	
	static function getKlassItem(root:YuiDoc, klass:Klass, itemName:String) : Item
	{
		for (item in root.classitems)
		{
			if (!Reflect.hasField(item, "module"))
			{
				throw "Unknow module for item = " + item;
			}
			
			if (!Reflect.hasField(klass, "module"))
			{
				throw "Unknow module for class = " + klass;
			}
			
			if (item.module == klass.module && item.getClass() == klass.name)
			{		
				return item;
			}
		}
		return null;
	}
	
	static function getHaxeType(type:String) : String
	{
		type = type.replace(" ", "");
		if (type.startsWith("{") && type.endsWith("}")) type = type.substr(1, type.length - 2);
		
		if (type.indexOf("|") >= 0) return "Dynamic";
		
		if (type == "Boolean") return "Bool";
		if (type == "Number") return "Float";
		if (type == "Object") return "Dynamic";
		if (type == "Function") return "Dynamic";
		if (type == "HTMLElement") return "js.html.Element";
		if (type == "HTMLCanvasElement") return "js.html.CanvasElement";
		if (type == "Image") return "js.html.Image";
		
		return type;
	}
	
	static function paramsToString(params:Array<Param>)
	{
		if (params != null)
		{
			return "(" + params.map(function(p)
				return p.name + ":" + getHaxeType(p.type)
			).join(", ") + ")";
		}
		return "()";
	}
	
	static function getItemDescription(item:Item)
	{
		
	}
	
	static function capitalize(s:String)
	{
		if (s == "") return "";
		return s.substr(0, 1).toUpperCase + s.substr(2);
	}
}