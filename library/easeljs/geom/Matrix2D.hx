package easeljs.geom;

/**
 * Represents an affine transformation matrix, and provides tools for constructing and concatenating matrices.
 * 
 * This matrix can be visualized as:
 * 
 * 	[ a  c  tx
 * 	  b  d  ty
 * 	  0  0  1  ]
 * 
 * Note the locations of b and c.
 */
@:native('createjs.Matrix2D')
extern class Matrix2D
{
	/**
	 * Position (0, 0) in a 3x3 affine transformation matrix.
	 */
	var a : Float;
	/**
	 * Position (0, 1) in a 3x3 affine transformation matrix.
	 */
	var b : Float;
	/**
	 * Position (1, 0) in a 3x3 affine transformation matrix.
	 */
	var c : Float;
	/**
	 * Position (1, 1) in a 3x3 affine transformation matrix.
	 */
	var d : Float;
	/**
	 * Position (2, 0) in a 3x3 affine transformation matrix.
	 */
	var tx : Float;
	/**
	 * Position (2, 1) in a 3x3 affine transformation matrix.
	 */
	var ty : Float;
	/**
	 * Multiplier for converting degrees to radians. Used internally by Matrix2D.
	 */
	static var DEG_TO_RAD : Float;
	/**
	 * An identity matrix, representing a null transformation.
	 */
	static var identity : Matrix2D;

	function new(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float) : Void;

	/**
	 * Sets the specified values on this instance.
	 */
	function setValues(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float) : Matrix2D;
	/**
	 * Appends the specified matrix properties to this matrix. All parameters are required.
	 * This is the equivalent of multiplying `(this matrix) * (specified matrix)`.
	 */
	function append(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float) : Matrix2D;
	/**
	 * Prepends the specified matrix properties to this matrix.
	 * This is the equivalent of multiplying `(specified matrix) * (this matrix)`.
	 * All parameters are required.
	 */
	function prepend(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float) : Matrix2D;
	/**
	 * Appends the specified matrix to this matrix.
	 * This is the equivalent of multiplying `(this matrix) * (specified matrix)`.
	 */
	function appendMatrix(matrix:Matrix2D) : Matrix2D;
	/**
	 * Prepends the specified matrix to this matrix.
	 * This is the equivalent of multiplying `(specified matrix) * (this matrix)`.
	 * For example, you could calculate the combined transformation for a child object using:
	 * 
	 * 	var o = myDisplayObject;
	 * 	var mtx = o.getMatrix();
	 * 	while (o = o.parent) {
	 * 		// prepend each parent's transformation in turn:
	 * 		o.prependMatrix(o.getMatrix());
	 * 	}
	 */
	function prependMatrix(matrix:Matrix2D) : Matrix2D;
	/**
	 * Generates matrix properties from the specified display object transform properties, and appends them to this matrix.
	 * For example, you can use this to generate a matrix representing the transformations of a display object:
	 * 
	 * 	var mtx = new Matrix2D();
	 * 	mtx.appendTransform(o.x, o.y, o.scaleX, o.scaleY, o.rotation);
	 */
	function appendTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, ?regX:Float, ?regY:Float) : Matrix2D;
	/**
	 * Generates matrix properties from the specified display object transform properties, and prepends them to this matrix.
	 * For example, you could calculate the combined transformation for a child object using:
	 * 
	 * 	var o = myDisplayObject;
	 * 	var mtx = new createjs.Matrix2D();
	 * 	do  {
	 * 		// prepend each parent's transformation in turn:
	 * 		mtx.prependTransform(o.x, o.y, o.scaleX, o.scaleY, o.rotation, o.skewX, o.skewY, o.regX, o.regY);
	 * 	} while (o = o.parent);
	 * 	
	 * 	Note that the above example would not account for {{#crossLink "DisplayObject/transformMatrix:property"}}{{/crossLink}}
	 * 	values. See {{#crossLink "Matrix2D/prependMatrix"}}{{/crossLink}} for an example that does.
	 */
	function prependTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, ?regX:Float, ?regY:Float) : Matrix2D;
	/**
	 * Applies a clockwise rotation transformation to the matrix.
	 */
	function rotate(angle:Float) : Matrix2D;
	/**
	 * Applies a skew transformation to the matrix.
	 */
	function skew(skewX:Float, skewY:Float) : Matrix2D;
	/**
	 * Applies a scale transformation to the matrix.
	 */
	function scale(x:Float, y:Float) : Matrix2D;
	/**
	 * Translates the matrix on the x and y axes.
	 */
	function translate(x:Float, y:Float) : Matrix2D;
	/**
	 * Sets the properties of the matrix to those of an identity matrix (one that applies a null transformation).
	 */
	inline function identity_() : Matrix2D return untyped this["identity"]();
	/**
	 * Inverts the matrix, causing it to perform the opposite transformation.
	 */
	function invert() : Matrix2D;
	/**
	 * Returns true if the matrix is an identity matrix.
	 */
	function isIdentity() : Bool;
	/**
	 * Returns true if this matrix is equal to the specified matrix (all property values are equal).
	 */
	function equals(matrix:Matrix2D) : Bool;
	/**
	 * Transforms a point according to this matrix.
	 */
	function transformPoint(x:Float, y:Float, ?pt:Dynamic) : Point;
	/**
	 * Decomposes the matrix into transform properties (x, y, scaleX, scaleY, and rotation). Note that these values
	 * may not match the transform properties you used to generate the matrix, though they will produce the same visual
	 * results.
	 */
	function decompose(?target:Dynamic) : Dynamic;
	/**
	 * Copies all properties from the specified matrix to this matrix.
	 */
	function copy(matrix:Matrix2D) : Matrix2D;
	/**
	 * Returns a clone of the Matrix2D instance.
	 */
	function clone() : Matrix2D;
	/**
	 * Returns a string representation of this object.
	 */
	function toString() : String;
}