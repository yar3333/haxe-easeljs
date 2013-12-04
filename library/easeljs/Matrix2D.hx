package easeljs;

/**
 * Represents an affine transformation matrix, and provides tools for constructing and concatenating matrixes.
 */
@:native("createjs.Matrix2D")
extern class Matrix2D
{
	/**
	 * An identity matrix, representing a null transformation.
	 */
	static var identity : Matrix2D;
	/**
	 * Multiplier for converting degrees to radians. Used internally by Matrix2D.
	 */
	static var DEG_TO_RAD : Float;
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
	 * Property representing the alpha that will be applied to a display object. This is not part of matrix
	 * operations, but is used for operations like getConcatenatedMatrix to provide concatenated alpha values.
	 */
	var alpha : Float;
	/**
	 * Property representing the shadow that will be applied to a display object. This is not part of matrix
	 * operations, but is used for operations like getConcatenatedMatrix to provide concatenated shadow values.
	 */
	var shadow : Shadow;
	/**
	 * Property representing the compositeOperation that will be applied to a display object. This is not part of
	 * matrix operations, but is used for operations like getConcatenatedMatrix to provide concatenated
	 * compositeOperation values. You can find a list of valid composite operations at:
	 * <a href="https://developer.mozilla.org/en/Canvas_tutorial/Compositing">https://developer.mozilla.org/en/Canvas_tutorial/Compositing</a>
	 */
	var compositeOperation : String;

	function new(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float) : Void;

	/**
	 * Concatenates the specified matrix properties with this matrix. All parameters are required.
	 */
	function prepend(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float) : Matrix2D;
	/**
	 * Appends the specified matrix properties with this matrix. All parameters are required.
	 */
	function append(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float) : Matrix2D;
	/**
	 * Prepends the specified matrix with this matrix.
	 */
	function prependMatrix(matrix:Matrix2D) : Matrix2D;
	/**
	 * Appends the specified matrix with this matrix.
	 */
	function appendMatrix(matrix:Matrix2D) : Matrix2D;
	/**
	 * Generates matrix properties from the specified display object transform properties, and prepends them with this matrix.
	 * For example, you can use this to generate a matrix from a display object: var mtx = new Matrix2D();
	 * mtx.prependTransform(o.x, o.y, o.scaleX, o.scaleY, o.rotation);
	 */
	function prependTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, ?regX:Float, ?regY:Float) : Matrix2D;
	/**
	 * Generates matrix properties from the specified display object transform properties, and appends them with this matrix.
	 * For example, you can use this to generate a matrix from a display object: var mtx = new Matrix2D();
	 * mtx.appendTransform(o.x, o.y, o.scaleX, o.scaleY, o.rotation);
	 */
	function appendTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, ?regX:Float, ?regY:Float) : Matrix2D;
	/**
	 * Applies a rotation transformation to the matrix.
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
	inline function identity_() : Matrix2D return Reflect.callMethod(this, "identity", [  ]);
	/**
	 * Inverts the matrix, causing it to perform the opposite transformation.
	 */
	function invert() : Matrix2D;
	/**
	 * Returns true if the matrix is an identity matrix.
	 */
	function isIdentity() : Bool;
	/**
	 * Transforms a point according to this matrix.
	 */
	function transformPoint(x:Float, y:Float, ?pt:Dynamic) : Point;
	/**
	 * Decomposes the matrix into transform properties (x, y, scaleX, scaleY, and rotation). Note that this these values
	 * may not match the transform properties you used to generate the matrix, though they will produce the same visual
	 * results.
	 */
	function decompose(target:Dynamic) : Matrix2D;
	/**
	 * Reinitializes all matrix properties to those specified.
	 */
	function reinitialize(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float, ?alpha:Float, ?shadow:Shadow, ?compositeOperation:String) : Matrix2D;
	/**
	 * Copies all properties from the specified matrix to this matrix.
	 */
	function copy(matrix:Matrix2D) : Matrix2D;
	/**
	 * Appends the specified visual properties to the current matrix.
	 */
	function appendProperties(alpha:Float, shadow:Shadow, compositeOperation:String) : Matrix2D;
	/**
	 * Prepends the specified visual properties to the current matrix.
	 */
	function prependProperties(alpha:Float, shadow:Shadow, compositeOperation:String) : Matrix2D;
	/**
	 * Returns a clone of the Matrix2D instance.
	 */
	function clone() : Matrix2D;
	/**
	 * Returns a string representation of this object.
	 */
	function toString() : String;
}