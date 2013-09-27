package ;

typedef Item =
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
	, params : Array<Param>
	//, return : { description:String, type:String }
	, access : String // "protected"
	, deprecated : Bool
	//, static : Int
}