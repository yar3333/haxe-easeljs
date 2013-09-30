package ;

class KlassTools
{
	public static function getExtends(klass:Klass) : String
	{
		return Reflect.field(klass, "extends");
	}
	
	public static function isStatic(klass:Klass) : Bool
	{
		return Reflect.field(klass, "static") == 1;
	}
}

class ItemTools
{
	public static function getDefault(item:Item) : String
	{
		return Reflect.field(item, "default");
	}
	
	public static function getClass(item:Item) : String
	{
		return Reflect.field(item, "class");
	}
	
	public static function getReturn(item:Item) : { description:String, type:String }
	{
		return Reflect.field(item, "return");
	}
	
	public static function setReturn(item:Item, ret:{ description:String, type:String }) : Void
	{
		return Reflect.setField(item, "return", ret);
	}
	
	public static function isStatic(item:Item) : Bool
	{
		return Reflect.hasField(item, "static") && Reflect.field(item, "static") == 1;
	}
}

class ParamTools
{
	public static function isOptional(param:Param) : Bool
	{
		return Reflect.hasField(param, "optional") && Reflect.field(param, "optional") || ~/^\s*optional\b/i.match(param.description);
	}
}
