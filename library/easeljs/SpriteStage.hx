package easeljs;

/**
 * A sprite stage is the root level {{#crossLink "Container"}}{{/crossLink}} for an aggressively optimized display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
 * method is called, it will render its display list to its target canvas. WebGL content is fully compatible with the existing Context2D renderer.
 * On devices or browsers that don't support WebGL, content will automatically be rendered via canvas 2D.
 * 
 * Restrictions:
 *     - only Sprite, SpriteContainer, BitmapText, Bitmap and DOMElement are allowed to be added to the display list.
 *     - a child being added (with the exception of DOMElement) MUST have an image or spriteSheet defined on it.
 *     - a child's image/spriteSheet MUST never change while being on the display list.
 * 
 * <h4>Example</h4>
 * This example creates a sprite stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
 * and redraw the stage using {{#crossLink "SpriteStage/update"}}{{/crossLink}}.
 * 
 *      var stage = new createjs.SpriteStage("canvasElementId", false, false);
 *      stage.updateViewport(800, 600);
 *      var image = new createjs.Bitmap("imagePath.png");
 *      stage.addChild(image);
 *      createjs.Ticker.addEventListener("tick", handleTick);
 *      function handleTick(event) {
 *          image.x += 10;
 *          stage.update();
 *      }
 * 
 * <strong>Note:</strong> SpriteStage is not included in the minified version of EaselJS.
 */
@:native("createjs.SpriteStage")
extern class SpriteStage extends Stage
{
	/**
	 * The number of properties defined per vertex in p._verticesBuffer.
	 * x, y, textureU, textureV, alpha
	 */
	static var NUM_VERTEX_PROPERTIES : Float;
	/**
	 * The number of points in a box...obviously :)
	 */
	static var POINTS_PER_BOX : Float;
	/**
	 * The number of vertex properties per box.
	 */
	static var NUM_VERTEX_PROPERTIES_PER_BOX : Float;
	/**
	 * The number of indices needed to define a box using triangles.
	 * 6 indices = 2 triangles = 1 box
	 */
	static var INDICES_PER_BOX : Float;
	/**
	 * The maximum size WebGL allows for element index numbers: 16 bit unsigned integer
	 */
	static var MAX_INDEX_SIZE : Float;
	/**
	 * The amount used to increment p._maxBoxesPointsPerDraw when the maximum has been reached.
	 * If the maximum size of element index WebGL allows for (SpriteStage.MAX_INDEX_SIZE) was used,
	 * the array size for p._vertices would equal 1280kb and p._indices 192kb. But since mobile phones
	 * with less memory need to be accounted for, the maximum size is somewhat arbitrarily divided by 4,
	 * reducing the array sizes to 320kb and 48kb respectively.
	 */
	static var MAX_BOXES_POINTS_INCREMENT : Float;
	/**
	 * Indicates whether WebGL is being used for rendering. For example, this would be false if WebGL is not
	 * supported in the browser.
	 */
	var isWebGL : Bool;

	function new(canvas:Dynamic, preserveDrawingBuffer:Bool, antialias:Bool) : Void;

	/**
	 * Adds a child to the top of the display list.
	 * Only children of type SpriteContainer, Sprite, Bitmap, BitmapText, or DOMElement are allowed.
	 * Children also MUST have either an image or spriteSheet defined on them (unless it's a DOMElement).
	 * 
	 * <h4>Example</h4>
	 *      container.addChild(bitmapInstance);
	 * 
	 *  You can also add multiple children at once:
	 * 
	 *      container.addChild(bitmapInstance, shapeInstance, textInstance);
	 */
	override function addChild(child:DisplayObject) : DisplayObject;
	/**
	 * Adds a child to the display list at the specified index, bumping children at equal or greater indexes up one, and
	 * setting its parent to this Container.
	 * Only children of type SpriteContainer, Sprite, Bitmap, BitmapText, or DOMElement are allowed.
	 * Children also MUST have either an image or spriteSheet defined on them (unless it's a DOMElement).
	 * 
	 * <h4>Example</h4>
	 * 
	 *      addChildAt(child1, index);
	 * 
	 * You can also add multiple children, such as:
	 * 
	 *      addChildAt(child1, child2, ..., index);
	 * 
	 * The index must be between 0 and numChildren. For example, to add myShape under otherShape in the display list,
	 * you could use:
	 * 
	 *      container.addChildAt(myShape, container.getChildIndex(otherShape));
	 * 
	 * This would also bump otherShape's index up by one. Fails silently if the index is out of range.
	 */
	override function addChildAt(child:DisplayObject, index:Int) : DisplayObject;
	/**
	 * Clears the target canvas. Useful if {{#crossLink "Stage/autoClear:property"}}{{/crossLink}} is set to `false`.
	 */
	override function clear() : Void;
	/**
	 * Draws the stage into the specified context (using WebGL) ignoring its visible, alpha, shadow, and transform.
	 * If WebGL is not supported in the browser, it will default to a 2D context.
	 * Returns true if the draw was handled (useful for overriding functionality).
	 * 
	 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	 */
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool) : Bool;
	/**
	 * Update the WebGL viewport. Note that this does NOT update the canvas element's width/height.
	 */
	function updateViewport(width:Float, height:Float) : Void;
	/**
	 * Clears an image's texture to free it up for garbage collection.
	 */
	function clearImageTexture(image:Dynamic) : Void;
	/**
	 * Returns a string representation of this object.
	 */
	override function toString() : String;
}