package ;

import haxe.CallStack;
import haxe.io.Path;
import haxe.Json;
import neko.Lib;
import sys.FileSystem;
import sys.io.File;
using StringTools;

typedef YuiDoc =
{
	  project : Dynamic
	, files: Dynamic
	, classes: Dynamic<ClassData>
	, classitems: Array<ClassItem>
}

typedef ClassData = 
{
	  name : String //"Event"
	, shortname : String // "Event"
	, classitems : Array<ClassItem> // []
	, plugins : Array<Dynamic> // []
	, extensions : Array<Dynamic> // []
	, plugin_for : Array<Dynamic> // []
	, extension_for : Array<Dynamic> // []
	, module : String // "CreateJS"
	, namespace : String // ""
	, file : String // "native\\src\\createjs\\events\\Event.js"
	, line : Int // 46
	, description : String // "Contains properties and methods shared by all events for use with\n{{#crossLink \"EventDispatcher\"}}{{/crossLink}}.\n\nNote that Event objects are often reused, so you should never\nrely on an event object's state outside of the call stack it was received in.",
	, params : Array<Param>
	, is_constructor : Int // 1
}

typedef ClassItem =
{
	  file: String // "native\\src\\createjs\\events\\Event.js"
    , line: Int // 74
	, description: String // "The object that generated an event."
	, itemtype: String // "property", "method", "event"
	, name: String // "target"
	, type: String // "Object"
	//, "default": String // "null"
	, readonly: String // ""
	//, "class": String // "Event"
	, module: String // "CreateJS"
}

typedef Param = 
{
	  name : String //"bubbles",
	, description : String // "Indicates whether the event will bubble through the display list.",
	, type : String // "Boolean"
}

class Main
{
	static function main():Void
	{
		var args = Sys.args();
		
		if (args.length >= 2 &&  args.length <= 3)
		{
			generateLibrary(args[0], args[1], args.length >= 3 ? args[2] : "");
			
		}
		else
		{
			Lib.println("yuidoc2haxe - generated haxe externs from the yuidoc's json.");
			Lib.println("Usage: yuidoc2haxe <srcJsonFilePath> <destDir> [<pathPrefixToRemove>]");
			Lib.println("");
		}
	}
	
	static function generateLibrary(srcJsonFilePath:String, destDir:String, pathPrefixToRemove:String)
	{
		destDir = Path.addTrailingSlash(destDir.replace("\\", "/"));
		pathPrefixToRemove = Path.addTrailingSlash(pathPrefixToRemove.replace("\\", "/"));
		
		var fileContent = File.getContent(srcJsonFilePath);
		var root : YuiDoc = Json.parse(fileContent);
		for (className in Reflect.fields(root.classes))
		{
			Lib.println("className = " + className);
			
			var klass : ClassData = Reflect.field(root.classes, className);
			
			var file = Path.withoutExtension(Std.string(klass.file).replace("\\", "/")) + ".hx";
			if (file.startsWith(pathPrefixToRemove)) file = file.substr(pathPrefixToRemove.length);
			file = destDir + file;
			Lib.println("file = " + file);
			
			var result = "package " + klass.module.toLowerCase() + ";\n\n";
			result += "@:native('createjs." + klass.module.toLowerCase() + "." + klass.name + "') extern class " + klass.name + "\n{";
			
			for (item in root.classitems)
			{
				if (item.file.replace("\\", "/").endsWith("src/easeljs/version.js")) continue;
				if (item.file.replace("\\", "/").endsWith("src/easeljs/version_movieclip.js")) continue;
				
				if (item.module == klass.module && Reflect.field(item, "class") == klass.name)
				{
					var reProperty = new EReg("^property\\s+([_a-z][_a-z0-9]*)\\s*$", "i");
					
					if (reProperty.match(Std.string(item.description)))
					{
						if (item.itemtype == null) item.itemtype = "property";
						if (item.name == null) item.name = reProperty.matched(1);
					}
					
					if (item.name == null)
					{
						if (Std.string(item.description).indexOf("Docced in superclass") >= 0) continue;
						
						var nativeLine = File.getContent(item.file).replace("\r", "").split("\n")[item.line-1];
						if (nativeLine.indexOf("@ignore") >= 0) continue;
						if (nativeLine.indexOf("docced in super class") >= 0) continue;
					}
					
					if (item.name == null)
					{
						throw "Unknow name for item = " + item;
					}
					
					if (item.name.startsWith("_")) continue; // protected
					
					Lib.println("  item.name = " + item.name);
					
					if (item.itemtype == null)
					{
						if (Reflect.hasField(item, "return"))
						{
							item.itemtype = "method";
						}
					}
					
					switch (item.itemtype)
					{
						case "property":
							if (item.type == null)
							{
								throw "Unknow type for item = " + item;
							}
							result += "\n\tvar " + item.name + " : " + getHaxeType(item.type) + ";";
						case "method":
						case "event":
						case _:
							throw "Unknow itemtype for item = " + item;
					}
				}
			}
			
			result += "\n}";
			
			FileSystem.createDirectory(destDir + klass.module.toLowerCase());
			File.saveContent(destDir + klass.module.toLowerCase() + "/" + klass.name + ".hx", result);
		}
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
}