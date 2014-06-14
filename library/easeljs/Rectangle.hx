package easeljs;

/**
 * Represents a rectangle as defined by the points (x, y) and (x+width, y+height).
 * 
 * <h4>Example</h4>
 * 
 *      var rect = new createjs.Rectangle(0, 0, 100, 100);
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
	 * Returns a clone of the Rectangle instance.
	 */
	function clone() : Rectangle;
	/**
	 * Returns a string representation of this object.
	 */
	function toString() : String;
}