package createjs;

/**
 * A SpriteContainer is a nestable display list that enables aggressively optimized rendering of bitmap content.
 * In order to accomplish these optimizations, SpriteContainer enforces a few restrictions on its content.
 * 
 * Restrictions:
 *     - only Sprite, SpriteContainer, BitmapText and DOMElement are allowed to be added as children.
 *     - a spriteSheet MUST be either be passed into the constructor or defined on the first child added.
 *     - all children (with the exception of DOMElement) MUST use the same spriteSheet.
 * 
 * <h4>Example</h4>
 * 
 *      var data = {
 *          images: ["sprites.jpg"],
 *          frames: {width:50, height:50},
 *          animations: {run:[0,4], jump:[5,8,"run"]}
 *      };
 *      var spriteSheet = new createjs.SpriteSheet(data);
 *      var container = new createjs.SpriteContainer(spriteSheet);
 *      container.addChild(spriteInstance, spriteInstance2);
 *      container.x = 100;
 * 
 * <strong>Note:</strong> SpriteContainer is not included in the minified version of EaselJS.
 */
extern class SpriteContainer extends Container
{
	/**
	 * The SpriteSheet that this container enforces use of.
	 */
	var spriteSheet : SpriteSheet;

	function new(?spriteSheet:SpriteSheet) : Void;

	/**
	 * Adds a child to the top of the display list.
	 * Only children of type SpriteContainer, Sprite, Bitmap, BitmapText, or DOMElement are allowed.
	 * The child must have the same spritesheet as this container (unless it's a DOMElement).
	 * If a spritesheet hasn't been defined, this container uses this child's spritesheet.
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
	 * The child must have the same spritesheet as this container (unless it's a DOMElement).
	 * If a spritesheet hasn't been defined, this container uses this child's spritesheet.
	 * 
	 * <h4>Example</h4>
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
	 * Returns a string representation of this object.
	 */
	override function toString() : String;
}