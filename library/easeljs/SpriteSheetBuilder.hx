package easeljs;

typedef SpriteSheetBuilderCompleteEvent =
{
	var target : Dynamic;
	var type : String;
}

typedef SpriteSheetBuilderCompleteEvent =
{
	var target : Dynamic;
	var type : String;
	var progress : Float;
}

/**
 * The SpriteSheetBuilder allows you to generate sprite sheets at run time from any display object. This can allow
 * you to maintain your assets as vector graphics (for low file size), and render them at run time as sprite sheets
 * for better performance.
 * 
 * Sprite sheets can be built either synchronously, or asynchronously, so that large sprite sheets can be generated
 * without locking the UI.
 * 
 * Note that the "images" used in the generated sprite sheet are actually canvas elements, and that they will be sized
 * to the nearest power of 2 up to the value of <code>maxWidth</code> or <code>maxHeight</code>.
 */
@:native("createjs.SpriteSheetBuilder")
extern class SpriteSheetBuilder extends createjs.EventDispatcher
{
	/**
	 * The maximum width for the images (not individual frames) in the generated sprite sheet. It is recommended to use
	 * a power of 2 for this value (ex. 1024, 2048, 4096). If the frames cannot all fit within the max dimensions, then
	 * additional images will be created as needed.
	 */
	var maxWidth : Float;
	/**
	 * The maximum height for the images (not individual frames) in the generated sprite sheet. It is recommended to use
	 * a power of 2 for this value (ex. 1024, 2048, 4096). If the frames cannot all fit within the max dimensions, then
	 * additional images will be created as needed.
	 */
	var maxHeight : Float;
	/**
	 * The sprite sheet that was generated. This will be null before a build is completed successfully.
	 */
	var spriteSheet : SpriteSheet;
	/**
	 * The scale to apply when drawing all frames to the sprite sheet. This is multiplied against any scale specified
	 * in the addFrame call. This can be used, for example, to generate a sprite sheet at run time that is tailored to
	 * the a specific device resolution (ex. tablet vs mobile).
	 */
	var scale : Float;
	/**
	 * The padding to use between frames. This is helpful to preserve antialiasing on drawn vector content.
	 */
	var padding : Float;
	/**
	 * A number from 0.01 to 0.99 that indicates what percentage of time the builder can use. This can be
	 * thought of as the number of seconds per second the builder will use. For example, with a timeSlice value of 0.3,
	 * the builder will run 20 times per second, using approximately 15ms per build (30% of available time, or 0.3s per second).
	 * Defaults to 0.3.
	 */
	var timeSlice : Float;
	/**
	 * A value between 0 and 1 that indicates the progress of a build, or -1 if a build has not
	 * been initiated.
	 */
	var progress : Float;

	function new() : Void;

	/**
	 * Adds a frame to the {{#crossLink "SpriteSheet"}}{{/crossLink}}. Note that the frame will not be drawn until you
	 * call {{#crossLink "SpriteSheetBuilder/build"}}{{/crossLink}} method. The optional setup params allow you to have
	 * a function run immediately before the draw occurs. For example, this allows you to add a single source multiple
	 * times, but manipulate it or its children to change it to generate different frames.
	 * 
	 * Note that the source's transformations (x, y, scale, rotate, alpha) will be ignored, except for regX/Y. To apply
	 * transforms to a source object and have them captured in the sprite sheet, simply place it into a {{#crossLink "Container"}}{{/crossLink}}
	 * and pass in the Container as the source.
	 */
	function addFrame(source:DisplayObject, ?sourceRect:Rectangle, ?scale:Float, ?setupFunction:Dynamic, ?setupParams:Array<Dynamic>, ?setupScope:Dynamic) : Float;
	/**
	 * Adds an animation that will be included in the created sprite sheet.
	 */
	function addAnimation(name:String, frames:Array<Dynamic>, ?next:String, ?frequency:Float) : Void;
	/**
	 * This will take a MovieClip, and add its frames and labels to this builder. Labels will be added as an animation
	 * running from the label index to the next label. For example, if there is a label named "foo" at frame 0 and a label
	 * named "bar" at frame 10, in a MovieClip with 15 frames, it will add an animation named "foo" that runs from frame
	 * index 0 to 9, and an animation named "bar" that runs from frame index 10 to 14.
	 * 
	 * Note that this will iterate through the full MovieClip with actionsEnabled set to false, ending on the last frame.
	 */
	function addMovieClip(source:MovieClip, ?sourceRect:Rectangle, ?scale:Float) : Void;
	/**
	 * Builds a SpriteSheet instance based on the current frames.
	 */
	function build() : SpriteSheet;
	/**
	 * Asynchronously builds a {{#crossLink "SpriteSheet"}}{{/crossLink}} instance based on the current frames. It will
	 * run 20 times per second, using an amount of time defined by <code>timeSlice</code>. When it is complete it will
	 * call the specified callback.
	 */
	function buildAsync(?timeSlice:Float) : Void;
	/**
	 * Stops the current asynchronous build.
	 */
	function stopAsync() : Void;
	/**
	 * Returns a string representation of this object.
	 */
	override function toString() : String;

	/**
	 * Dispatched when a build completes.
	 */
	inline function addCompleteEventListener(handler:SpriteSheetBuilderCompleteEvent->Void) : Dynamic return addEventListener("complete", handler);
	/**
	 * Dispatched when an asynchronous build has progress.
	 */
	inline function addCompleteEventListener(handler:SpriteSheetBuilderCompleteEvent->Void) : Dynamic return addEventListener("complete", handler);
}