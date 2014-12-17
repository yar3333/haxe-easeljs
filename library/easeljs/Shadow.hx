package easeljs;

/**
 * This class encapsulates the properties required to define a shadow to apply to a {{#crossLink "DisplayObject"}}{{/crossLink}}
 * via its <code>shadow</code> property.
 * 
 * <h4>Example</h4>
 * 
 *      myImage.shadow = new createjs.Shadow("#000000", 5, 5, 10);
 */
@:native("createjs.Shadow")
extern class Shadow
{
	/**
	 * property color
	 */
	var color : String;
	/**
	 * property offsetX
	 */
	var offsetX : Float;
	/**
	 * property offsetY
	 */
	var offsetY : Float;
	/**
	 * property blur
	 */
	var blur : Float;
	/**
	 * An identity shadow object (all properties are set to 0).
	 */
	static var identity : Shadow;

	function new(color:String, offsetX:Float, offsetY:Float, blur:Float) : Void;

	/**
	 * Returns a string representation of this object.
	 */
	function toString() : String;
	/**
	 * Returns a clone of this Shadow instance.
	 */
	function clone() : Shadow;
}