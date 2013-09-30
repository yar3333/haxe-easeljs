package ;

typedef Klass = 
{
	  name : String //"Event"
	, shortname : String // "Event"
	, classitems : Array<Item> // []
	, plugins : Array<Dynamic> // []
	, extensions : Array<Dynamic> // []
	, plugin_for : Array<Dynamic> // []
	, extension_for : Array<Dynamic> // []
	, module : String // "CreateJS"
	, namespace : String // ""
	, file : String // "native\\src\\createjs\\events\\Event.js"
	, line : Int // 46
	, description : String // "Contains properties and methods shared by all events for use with\n{{#crossLink \"EventDispatcher\"}}{{/crossLink}}.\n\nNote that Event objects are often reused, so you should never\nrely on an event object's state outside of the call stack it was received in.",
	//, extends : String
	, is_constructor : Int // 1
	, params : Array<Param>
	//, static : Int
	, deprecated : Bool
	, uses : Array<String>
}
