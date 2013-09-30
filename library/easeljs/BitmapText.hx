package easeljs;

/**
 * Displays text using bitmap glyphs defined in a sprite sheet. Multi-line text is supported
 * using new line characters, but automatic wrapping is not supported. See the 
 * {{#crossLink "BitmapText/spriteSheet:attribute"}}{{/crossLink}}
 * property for more information on defining glyphs.
 */
@:native("createjs.BitmapText")
extern class BitmapText extends DisplayObject
{
	/**
	 * The text to display.
	 */
	var text : String;
	/**
	 * A SpriteSheet instance that defines the glyphs for this bitmap text. Each glyph/character
	 * should have a single frame animation defined in the sprite sheet named the same as
	 * corresponding character. For example, the following animation definition:
	 * 
	 * 		"A": {frames: [0]}
	 * 
	 * would indicate that the frame at index 0 of the spritesheet should be drawn for the "A" character. The short form
	 * is also acceptable:
	 * 
	 * 		"A": 0
	 * 
	 * Note that if a character in the text is not found in the sprite sheet, it will also
	 * try to use the alternate case (upper or lower).
	 * 
	 * See SpriteSheet for more information on defining sprite sheet data.
	 */
	var spriteSheet : String;
	/**
	 * The height of each line of text. If 0, then it will use a line height calculated
	 * by checking for the height of the "1", "T", or "L" character (in that order). If
	 * those characters are not defined, it will use the height of the first frame of the
	 * sprite sheet.
	 */
	var lineHeight : Float;
	/**
	 * This spacing (in pixels) will be added after each character in the output.
	 */
	var letterSpacing : Float;
	/**
	 * If a space character is not defined in the sprite sheet, then empty pixels equal to
	 * spaceWidth will be inserted instead. If  0, then it will use a value calculated
	 * by checking for the width of the "1", "E", or "A" character (in that order). If
	 * those characters are not defined, it will use the width of the first frame of the
	 * sprite sheet.
	 */
	var spaceWidth : Float;

	function new(?text:String, ?spriteSheet:easeljs.SpriteSheet) : Void;

	/**
	 * Draws the display object into the specified context ignoring it's visible, alpha, shadow, and transform.
	 * Returns true if the draw was handled (useful for overriding functionality).
	 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	 */
	override function draw(ctx:js.html.CanvasRenderingContext2D, ignoreCache:Bool) : Bool;
	/**
	 * Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	 * This does not account for whether it would be visible within the boundaries of the stage.
	 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	 */
	override function isVisible() : Bool;
}