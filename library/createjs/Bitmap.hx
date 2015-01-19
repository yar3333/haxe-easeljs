package createjs;

/**
 * A Bitmap represents an Image, Canvas, or Video in the display list. A Bitmap can be instantiated using an existing
 * HTML element, or a string.
 * 
 * <h4>Example</h4>
 * 
 *      var bitmap = new createjs.Bitmap("imagePath.jpg");
 * 
 * <strong>Notes:</strong>
 * <ol>
 *     <li>When a string path or image tag that is not yet loaded is used, the stage may need to be redrawn before it
 *      will be displayed.</li>
 *     <li>Bitmaps with an SVG source currently will not respect an alpha value other than 0 or 1. To get around this,
 *     the Bitmap can be cached.</li>
 *     <li>Bitmaps with an SVG source will taint the canvas with cross-origin data, which prevents interactivity. This
 *     happens in all browsers except recent Firefox builds.</li>
 *     <li>Images loaded cross-origin will throw cross-origin security errors when interacted with using a mouse, using
 *     methods such as `getObjectUnderPoint`, or using filters, or caching. You can get around this by setting
 *     `crossOrigin` flags on your images before passing them to EaselJS, eg: `img.crossOrigin="Anonymous";`</li>
 * </ol>
 */
extern class Bitmap extends DisplayObject
{
	/**
	 * The image to render. This can be an Image, a Canvas, or a Video. Not all browsers (especially
	 * mobile browsers) support drawing video to a canvas.
	 */
	var image : Dynamic;
	/**
	 * Specifies an area of the source image to draw. If omitted, the whole image will be drawn.
	 * Note that video sources must have a width / height set to work correctly with `sourceRect`.
	 */
	var sourceRect : Rectangle;

	function new(imageOrUri:Dynamic) : Void;

	/**
	 * Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	 * This does not account for whether it would be visible within the boundaries of the stage.
	 * 
	 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	 */
	override function isVisible() : Bool;
	/**
	 * Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
	 * Returns true if the draw was handled (useful for overriding functionality).
	 * 
	 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	 */
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool) : Bool;
	/**
	 * Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	 * You should <b>not</b> cache Bitmap instances as it can degrade performance.
	 * 
	 * <strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
	 * To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
	 * method.
	 */
	override function cache(x:Float, y:Float, width:Float, height:Float, ?scale:Float) : Void;
	/**
	 * Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	 * You should <b>not</b> cache Bitmap instances as it can degrade performance.
	 * 
	 * <strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
	 * To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
	 * method.
	 */
	override function updateCache(compositeOperation:String) : Void;
	/**
	 * Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	 * You should <b>not</b> cache Bitmap instances as it can degrade performance.
	 * 
	 * <strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
	 * To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
	 * method.
	 */
	override function uncache() : Void;
	/**
	 * Returns a clone of the Bitmap instance.
	 */
	override function clone(?recursive:Bool) : DisplayObject;
	/**
	 * Returns a string representation of this object.
	 */
	override function toString() : String;
}