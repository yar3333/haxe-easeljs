package easeljs;

/**
 * Represents a point on a 2 dimensional x / y coordinate system.
 * 
 * <h4>Example</h4>
 * 
 *      var point = new createjs.Point(0, 100);
 */
@:native("createjs.Point")
extern class Point
{
	/**
	 * X position.
	 */
	var x : Float;
	/**
	 * Y position.
	 */
	var y : Float;

	function new(?x:Float, ?y:Float) : Void;

	/**
	 * Copies all properties from the specified point to this point.
	 */
	function copy(point:Point) : Point;
	/**
	 * Returns a clone of the Point instance.
	 */
	function clone() : Point;
	/**
	 * Returns a string representation of this object.
	 */
	function toString() : String;
}