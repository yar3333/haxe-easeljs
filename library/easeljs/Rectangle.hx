package easeljs;

/**
 * Represents a rectangle as defined by the points (x, y) and (x+width, y+height).
 */
@:native("createjs.Rectangle")
extern class Rectangle
{
	/**
	 * X position.
	 */
	var x : Float;
	/**
	 * Y position.
	 */
	var y : Float;
	/**
	 * Width.
	 */
	var width : Float;
	/**
	 * Height.
	 */
	var height : Float;

	function new(?x:Float, ?y:Float, ?width:Float, ?height:Float) : Void;

	/**
	 * Copies all properties from the specified rectangle to this rectangle.
	 */
	function copy(rectangle:Rectangle) : Rectangle;
	/**
	 * Returns a string representation of this object.
	 */
	function toString() : String;
}