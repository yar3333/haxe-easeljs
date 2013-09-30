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
		parser.add("removePathPrefix", "", [ "-pprefix", "--remove-path-prefix" ], "Source files path prefix to remove.");
		parser.addRepeatable("typeMap", String, [ "-tm", "--type-map" ], "Map basic types in form 'from-to'. For example: Boolean-Bool");
		parser.add("publicPrefix", false, [ "--public-prefix" ], "Write 'public' before class member declarations.");
		parser.addRepeatable("ignoreFiles", String, [ "-ifile", "--ignore-file" ], "Path to source file to ignore.");
		parser.addRepeatable("ignoreClasses", String, [ "-iclass", "--ignore-class" ], "Class name to ignore. Masks with '*' is supported.");
		parser.addRepeatable("ignoreItems", String, [ "-iitem", "--ignore-items" ], "Class member to ignore. Masks with '*' is supported.");
		parser.add("noDescriptions", false, [ "-nd", "--no-descriptions" ], "Do not generate descriptions.");
		parser.add("nativePackage", "", [ "-np", "--native-package" ], "Native package for @:native meta.");
		parser.add("generateDeprecated", false, [ "--generate-deprecated" ], "Generate deprecated classes/members.");
		parser.add("noNewLineOnBracket", false, [ "--no-new-line-on-bracket" ], "Ouput code style. Generate '{' on the same line.");
		parser.add("lessSpaces", false, [ "--less-spaces" ], "Ouput code style. Generate less spaces.");
		parser.add("sortItems", false, [ "--sort-items" ], "Ouput code style. Sort items alphabetically.");
		parser.add("constructorFirst", false, [ "--constructor-first" ], "Ouput code style. Place constructor first.");
		
		var args = Sys.args();
		
		if (args.length > 0)
		{
			var options = parser.parse(args);
			generateLibrary(
				  options.get("srcJsonFilePath")
				, options.get("destDir")
				, options.get("removePathPrefix")
				, options.get("typeMap")
				, options.get("publicPrefix")
				, options.get("ignoreFiles")
				, options.get("ignoreClasses")
				, options.get("ignoreItems")
				, options.get("noDescriptions")
				, options.get("nativePackage")
				, options.get("generateDeprecated")
				, options.get("noNewLineOnBracket")
				, options.get("lessSpaces")
				, options.get("sortItems")
				, options.get("constructorFirst")
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
		, _typeMap : Array<String>
		, publicPrefix : Bool
		, ignoreFiles : Array<String>
		, ignoreClasses : Array<String>
		, ignoreItems : Array<String>
		, noDescriptions : Bool
		, nativePackage : String
		, generateDeprecated : Bool
		, noNewLineOnBracket : Bool
		, lessSpaces : Bool
		, sortItems : Bool
		, constructorFirst : Bool
		
	) {
		destDir = Path.addTrailingSlash(destDir.replace("\\", "/"));
		removePathPrefix = Path.addTrailingSlash(removePathPrefix.replace("\\", "/"));
		var typeMap = new Map<String,String>(); for (s in _typeMap) typeMap.set(s.split("-")[0], s.split("-")[1]);
		ignoreFiles = ignoreFiles.map(function(p) return p.replace("\\", "/"));
		var bracket = noNewLineOnBracket ? " {\n" : "\n{";
		var space = lessSpaces ? "" : " ";
		
		var itemDeclarationPrefx = publicPrefix ? "public " : "";
		
		var fileContent = File.getContent(srcJsonFilePath);
		var root : YuiDoc = Json.parse(fileContent);
		for (className in Reflect.fields(root.classes))
		{
			Lib.print(className);
			
			var klass : Klass = Reflect.field(root.classes, className);
			
			if (isIgnore(ignoreClasses, klass.module, className) || (!generateDeprecated && klass.deprecated))
			{
				Lib.println("...SKIP");
				continue;
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
			
			var items = getKlassItems(root, klass, removePathPrefix, ignoreFiles, ignoreItems, generateDeprecated);
			
			var eventsDeclarationCode = items.events.filter(function(item) return item.params != null).map(function(item)
			{
				var eventClassName = item.getClass() + capitalize(item.name) + "Event";
				
				return "typedef " + eventClassName + " =" + bracket + "\n" + item.params.map(function(p)
				{
					return "\tvar " + p.name + space + ":" + space + getHaxeType(root, item.module, typeMap, p.type) + ";";
				}
				).join("\n") + "\n}\n";
			}
			).join("\n");
			
			var propertiesCode = items.properties.map(function(item) return getPropertyCode(root, items.properties.concat(items.methods), item, itemDeclarationPrefx, space, typeMap)).join("\n");
			
			if (sortItems) items.methods.sort(function(a, b) return a.name<b.name ? -1 : (a.name>b.name ? 1 : 0));
			var methodsCode = items.methods.map(function(item) return getMethodCode(root, items.properties.concat(items.methods), item, itemDeclarationPrefx, space, typeMap)).join("\n");
			
			var eventsCode = items.events.map(function(item)
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
				
				return getDescriptionCode(item) + "\t" + itemDeclarationPrefx + (item.isStatic() ? "static " : "") + "inline function add" + capitalize(item.name) + "EventListener(handler:" + eventClassName + "->Void) : Dynamic return addEventListener(\"" + item.name + "\", handler);";
			}
			).join("\n");
			
			var result = [];
			result.push("package " + klass.module.toLowerCase() + ";");
			result.push("");
			
			if (eventsDeclarationCode != "") result.push(eventsDeclarationCode);
			
			var klassDescriptionCode = getDescriptionCode(klass, "").rtrim();
			if (klassDescriptionCode != "") result.push(klassDescriptionCode);
			
			result.push("@:native(\"" + (nativePackage != "" ? nativePackage + "." : "") + klass.name + "\")");
			result.push("extern class " + klass.name + (klass.getExtends() != null && klass.getExtends() != "" ? " extends " + getHaxeType(root, klass.module, typeMap, klass.getExtends()) : "") + bracket);
			
			var innerClassCode = "";
			if (constructorFirst)
			{
				if (klass.is_constructor == 1)	innerClassCode += getConstructorCode(root, items.properties.concat(items.methods), klass, itemDeclarationPrefx, space, typeMap);
			}
			if (propertiesCode != "")			innerClassCode += propertiesCode + "\n\n";
			if (!constructorFirst)
			{
				if (klass.is_constructor == 1)	innerClassCode += getConstructorCode(root, items.properties.concat(items.methods), klass, itemDeclarationPrefx, space, typeMap);
			}
			if (methodsCode != "")				innerClassCode += methodsCode + "\n\n";
			if (eventsCode != "")				innerClassCode += eventsCode + "\n\n";
			result.push(innerClassCode.rtrim());
			
			result.push("}");
			
			FileSystem.createDirectory(destDir + klass.module.toLowerCase());
			File.saveContent(destDir + klass.module.toLowerCase() + "/" + klass.name + ".hx", result.join("\n").replace("\n", "\r\n"));
		}
	}
	
	static function getKlassItems(
		  root : YuiDoc
		, klass : Klass
		, removePathPrefix : String
		, ignoreFiles : Array<String>
		, ignoreItems : Array<String>
		, generateDeprecated : Bool
	)
	: { properties:Array<Item>, methods:Array<Item>, events:Array<Item> }
	{
		var properties = new Array<Item>();
		var methods = new Array<Item>();
		var events = new Array<Item>();
		
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
				
				if (isIgnore(ignoreItems, item.getClass(), item.name)) continue;
				
				fillItemFieldsFromSuperClass(root, item);
				
				if (item.itemtype == null)
				{
					if (item.getReturn() != null)
					{
						item.itemtype = "method";
					}
				}
				
				switch (item.itemtype)
				{
					case "property":
						properties.push(item);
					
					case "method":
						methods.push(item);
						
					case "event":
						events.push(item);
					
					case _:
						throw "Unknow itemtype for item = " + item;
				}
			}
		}
		
		if (klass.uses != null)
		{
			for (mixKlassName in klass.uses)
			{
				var mixKlass : Klass = Reflect.field(root.classes, mixKlassName);
				if (mixKlass != null)
				{
					var mixMethods = getKlassItems(root, mixKlass, removePathPrefix, ignoreFiles, ignoreItems, generateDeprecated).methods;
					for (mixMethod in mixMethods)
					{
						if (!methods.exists(function(m) return m.name == mixMethod.name))
						{
							methods.push(mixMethod);
						}
					}
				}
			}
		}
		
		return { properties:properties, methods:methods, events:events };
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
			
			var superItem = getKlassItem(root, superKlass, item.name, item.isStatic());
			if (superItem != null)
			{
				if (item.getReturn() == null)
				{
					item.setReturn(superItem.getReturn());
				}
				else
				if (item.getReturn().type != superItem.getReturn().type)
				{
					item.getReturn().type = superItem.getReturn().type;
				}
			}
			
			superKlassName = superKlass.getExtends();
		}
	}
	
	static function getKlassItem(root:YuiDoc, klass:Klass, itemName:String, isStatic:Bool) : Item
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
			
			if (item.module == klass.module && item.getClass() == klass.name && item.name == itemName && item.isStatic() == isStatic)
			{		
				return item;
			}
		}
		return null;
	}
	
	static function getHaxeType(root:YuiDoc, curModule:String, typeMap:Map<String,String>, type:String) : String
	{
		type = type.replace(" ", "");
		if (type.startsWith("{") && type.endsWith("}")) type = type.substr(1, type.length - 2);
		
		if (typeMap.exists(type)) return typeMap.get(type);
		
		if (type.indexOf("|") >= 0) return "Dynamic";
		
		type = getFullKlassName(root, curModule, type);
		
		var ltype = type.toLowerCase();
		
		if (ltype == "boolean") return "Bool";
		if (ltype == "number") return "Float";
		if (ltype == "object") return "Dynamic";
		if (ltype == "function") return "Dynamic";
		if (ltype == "array") return "Array<Dynamic>";
		if (ltype == "*") return "Dynamic";
		
		return type;
	}
	
	static function getParamsCode(root:YuiDoc, curModule:String, typeMap:Map<String,String>, params:Array<Param>)
	{
		if (params != null)
		{
			return "(" + params.map(function(p) return (p.optional ? "?" : "") + p.name + ":" + getHaxeType(root, curModule, typeMap, p.type)).join(", ") + ")";
		}
		return "()";
	}
	
	static function getDescriptionCode(item:{ description:String }, prefix="\t")
	{
		if (item.description == null || item.description == "") return "";
		return prefix + "/**\n" + item.description.split("\n").map(function(s) return prefix + " * " + s).join("\n") + "\n" + prefix + " */\n";
	}
	
	static function capitalize(s:String)
	{
		if (s == "") return "";
		return s.substr(0, 1).toUpperCase() + s.substr(2);
	}
	
	static function isIgnore(ignores:Array<String>, prefix:String, name:String)
	{
		return ignores.exists(function(s)
		{
			if (s.indexOf("*") < 0)
			{
				var n = s.lastIndexOf(".");
				return n >= 0 ? s.substr(0, n) == prefix && s.substr(n + 1) == name : s == name;
			}
			else
			{
				var re = new EReg(s.replace(".", "\\.").replace("*", ".+"), "");
				return re.match((prefix != null && prefix != "" ? prefix + "." : "") + name);
			}
		});
	}
	
	static function getConstructorCode(root:YuiDoc, items:Array<Item>, klass:Klass, itemDeclarationPrefx:String, space:String, typeMap:Map<String,String>) : String
	{
		return getMethodCode(root, items, cast { name:"new", "return":{ type:"Void" }, params:klass.params }, itemDeclarationPrefx, space, typeMap) + "\n\n";
	}
	
	static function getPropertyCode(root:YuiDoc, items:Array<Item>, item:Item, itemDeclarationPrefx:String, space:String, typeMap:Map<String,String>)
	{
		if (item.type == null)
		{
			throw "Unknow type for property = " + item;
		}
		
		var haxeType = getHaxeType(root, item.module, typeMap, item.type);
		
		if (item.isStatic() || !items.exists(function(i) return i.name == item.name && i.isStatic()))
		{
			return getDescriptionCode(item) 
				+ "\t" 
				+ itemDeclarationPrefx 
				+ (item.isStatic() ? "static " : "") 
				+ "var " + item.name + space + ":" + space + haxeType + ";";
		}
		else
		{
			
			
			return getDescriptionCode(item) 
				+ "\t" 
				+ itemDeclarationPrefx 
				+ "var " + item.name + "_(get, set)" + space + ":" + space + haxeType + ";\n"
				+ "inline function get_" + item.name + "_()" + space + ":" + space + haxeType + " return Reflect.field(this, \"" + item.name + "\");\n"
				+ "inline function set_" + item.name + "_(v:" + haxeType + ")" + space + ":" + space + haxeType + " return Reflect.setField(this, \"" + item.name + "\", v);";
		}
	}
	
	static function getMethodCode(root:YuiDoc, items:Array<Item>, item:Item, itemDeclarationPrefx:String, space:String, typeMap:Map<String,String>)
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
			if (item.isStatic() || !items.exists(function(i) return i.name == item.name && i.isStatic()))
			{
				return getDescriptionCode(item) 
					+ "\t" 
					+ (isMethodOverride(root, item) ? "override " : "") 
					+ itemDeclarationPrefx 
					+ (item.isStatic() ? "static " : "") 
					+ "function " + item.name + getParamsCode(root, item.module, typeMap, item.params) + space + ":" + space + getHaxeType(root, item.module, typeMap, ret.type) + ";";
			}
			else
			{
				return getDescriptionCode(item) 
					+ "\t" 
					+ itemDeclarationPrefx 
					+ "inline "
					+ "function " + item.name + "_" + getParamsCode(root, item.module, typeMap, item.params) + space + ":" + space + getHaxeType(root, item.module, typeMap, ret.type) 
					+ " return Reflect.callMethod(this, \"" + item.name + "\", [ " + (item.params != null ? item.params.map(function(p) return p.name).join(", ") : "") + " ]);";
			}
		}
		catch (e:Dynamic)
		{
			throw "Unknow param type for method = " + item;
		}
	}
	
	static function isMethodOverride(root:YuiDoc, item:Item) : Bool
	{
		if (item.name == "new" || item.isStatic()) return false;
		
		var klass : Klass = Reflect.field(root.classes, item.getClass());
		var superKlassName = klass.getExtends();
		while (superKlassName != null && superKlassName != "")
		{
			var superKlass : Klass = Reflect.field(root.classes, superKlassName);
			
			if (superKlass == null) return false;
			
			var superItem = getKlassItem(root, superKlass, item.name, item.isStatic());
			if (superItem != null) return true;
			
			superKlassName = superKlass.getExtends();
		}
		return false;
	}
	
	static function getFullKlassName(root:YuiDoc, curModule:String, klassName:String) : String
	{
		var klass : Klass = Reflect.field(root.classes, klassName);
		if (klass == null) return klassName;
		return (klass.module != curModule && klass.module != null && klass.module != "" ? klass.module.toLowerCase() + "." : "") + klassName;
	}
}