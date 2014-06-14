package easeljs;

/**
 * The Graphics class exposes an easy to use API for generating vector drawing instructions and drawing them to a
 * specified context. Note that you can use Graphics without any dependency on the Easel framework by calling {{#crossLink "DisplayObject/draw"}}{{/crossLink}}
 * directly, or it can be used with the {{#crossLink "Shape"}}{{/crossLink}} object to draw vector graphics within the
 * context of an Easel display list.
 * 
 * <h4>Example</h4>
 * 
 *      var g = new createjs.Graphics();
 * 	    g.setStrokeStyle(1);
 * 	    g.beginStroke(createjs.Graphics.getRGB(0,0,0));
 * 	    g.beginFill(createjs.Graphics.getRGB(255,0,0));
 * 	    g.drawCircle(0,0,3);
 * 
 * 	    var s = new createjs.Shape(g);
 * 	    	s.x = 100;
 * 	    	s.y = 100;
 * 
 * 	    stage.addChild(s);
 * 	    stage.update();
 * 
 * Note that all drawing methods in Graphics return the Graphics instance, so they can be chained together. For example,
 * the following line of code would generate the instructions to draw a rectangle with a red stroke and blue fill, then
 * render it to the specified context2D:
 * 
 *      myGraphics.beginStroke("#F00").beginFill("#00F").drawRect(20, 20, 100, 50).draw(myContext2D);
 * 
 * <h4>Tiny API</h4>
 * The Graphics class also includes a "tiny API", which is one or two-letter methods that are shortcuts for all of the
 * Graphics methods. These methods are great for creating compact instructions, and is used by the Toolkit for CreateJS
 * to generate readable code. All tiny methods are marked as protected, so you can view them by enabling protected
 * descriptions in the docs.
 * 
 * <table>
 *     <tr><td><b>Tiny</b></td><td><b>Method</b></td><td><b>Tiny</b></td><td><b>Method</b></td></tr>
 *     <tr><td>mt</td><td>{{#crossLink "Graphics/moveTo"}}{{/crossLink}} </td>
 *     <td>lt</td> <td>{{#crossLink "Graphics/lineTo"}}{{/crossLink}}</td></tr>
 *     <tr><td>a/at</td><td>{{#crossLink "Graphics/arc"}}{{/crossLink}} / {{#crossLink "Graphics/arcTo"}}{{/crossLink}} </td>
 *     <td>bt</td><td>{{#crossLink "Graphics/bezierCurveTo"}}{{/crossLink}} </td></tr>
 *     <tr><td>qt</td><td>{{#crossLink "Graphics/quadraticCurveTo"}}{{/crossLink}} (also curveTo)</td>
 *     <td>r</td><td>{{#crossLink "Graphics/rect"}}{{/crossLink}} </td></tr>
 *     <tr><td>cp</td><td>{{#crossLink "Graphics/closePath"}}{{/crossLink}} </td>
 *     <td>c</td><td>{{#crossLink "Graphics/clear"}}{{/crossLink}} </td></tr>
 *     <tr><td>f</td><td>{{#crossLink "Graphics/beginFill"}}{{/crossLink}} </td>
 *     <td>lf</td><td>{{#crossLink "Graphics/beginLinearGradientFill"}}{{/crossLink}} </td></tr>
 *     <tr><td>rf</td><td>{{#crossLink "Graphics/beginRadialGradientFill"}}{{/crossLink}} </td>
 *     <td>bf</td><td>{{#crossLink "Graphics/beginBitmapFill"}}{{/crossLink}} </td></tr>
 *     <tr><td>ef</td><td>{{#crossLink "Graphics/endFill"}}{{/crossLink}} </td>
 *     <td>ss</td><td>{{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} </td></tr>
 *     <tr><td>s</td><td>{{#crossLink "Graphics/beginStroke"}}{{/crossLink}} </td>
 *     <td>ls</td><td>{{#crossLink "Graphics/beginLinearGradientStroke"}}{{/crossLink}} </td></tr>
 *     <tr><td>rs</td><td>{{#crossLink "Graphics/beginRadialGradientStroke"}}{{/crossLink}} </td>
 *     <td>bs</td><td>{{#crossLink "Graphics/beginBitmapStroke"}}{{/crossLink}} </td></tr>
 *     <tr><td>es</td><td>{{#crossLink "Graphics/endStroke"}}{{/crossLink}} </td>
 *     <td>dr</td><td>{{#crossLink "Graphics/drawRect"}}{{/crossLink}} </td></tr>
 *     <tr><td>rr</td><td>{{#crossLink "Graphics/drawRoundRect"}}{{/crossLink}} </td>
 *     <td>rc</td><td>{{#crossLink "Graphics/drawRoundRectComplex"}}{{/crossLink}} </td></tr>
 *     <tr><td>dc</td><td>{{#crossLink "Graphics/drawCircle"}}{{/crossLink}} </td>
 *     <td>de</td><td>{{#crossLink "Graphics/drawEllipse"}}{{/crossLink}} </td></tr>
 *     <tr><td>dp</td><td>{{#crossLink "Graphics/drawPolyStar"}}{{/crossLink}} </td>
 *     <td>p</td><td>{{#crossLink "Graphics/decodePath"}}{{/crossLink}} </td></tr>
 * </table>
 * 
 * Here is the above example, using the tiny API instead.
 * 
 *      myGraphics.s("#F00").f("#00F").r(20, 20, 100, 50).draw(myContext2D);
 */
@:native("createjs.Graphics")
extern class Graphics
{
	/**
	 * Exposes the Command class used internally by Graphics. Useful for extending the Graphics class or injecting
	 * functionality.
	 */
	static var Command : Dynamic;
	/**
	 * Map of Base64 characters to values. Used by {{#crossLink "Graphics/decodePath"}}{{/crossLink}}.
	 */
	static var BASE_64 : Dynamic;
	/**
	 * Maps numeric values for the caps parameter of {{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} to
	 * corresponding string values. This is primarily for use with the tiny API. The mappings are as follows: 0 to
	 * "butt", 1 to "round", and 2 to "square".
	 * For example, to set the line caps to "square":
	 * 
	 *      myGraphics.ss(16, 2);
	 */
	static var STROKE_CAPS_MAP : Array<Dynamic>;
	/**
	 * Maps numeric values for the joints parameter of {{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} to
	 * corresponding string values. This is primarily for use with the tiny API. The mappings are as follows: 0 to
	 * "miter", 1 to "round", and 2 to "bevel".
	 * For example, to set the line joints to "bevel":
	 * 
	 *      myGraphics.ss(16, 0, 2);
	 */
	static var STROKE_JOINTS_MAP : Array<Dynamic>;

	function new() : Void;

	/**
	 * Returns a CSS compatible color string based on the specified RGB numeric color values in the format
	 * "rgba(255,255,255,1.0)", or if alpha is null then in the format "rgb(255,255,255)". For example,
	 * 
	 *      createjs.Graphics.getRGB(50, 100, 150, 0.5);
	 *      // Returns "rgba(50,100,150,0.5)"
	 * 
	 * It also supports passing a single hex color value as the first param, and an optional alpha value as the second
	 * param. For example,
	 * 
	 *      createjs.Graphics.getRGB(0xFF00FF, 0.2);
	 *      // Returns "rgba(255,0,255,0.2)"
	 */
	static function getRGB(r:Float, g:Float, b:Float, ?alpha:Float) : String;
	/**
	 * Returns a CSS compatible color string based on the specified HSL numeric color values in the format "hsla(360,100,100,1.0)",
	 * or if alpha is null then in the format "hsl(360,100,100)".
	 * 
	 *      createjs.Graphics.getHSL(150, 100, 70);
	 *      // Returns "hsl(150,100,70)"
	 */
	static function getHSL(hue:Float, saturation:Float, lightness:Float, ?alpha:Float) : String;
	/**
	 * Returns true if this Graphics instance has no drawing commands.
	 */
	function isEmpty() : Bool;
	/**
	 * Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
	 * Returns true if the draw was handled (useful for overriding functionality).
	 * 
	 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	 */
	function draw(ctx:js.html.CanvasRenderingContext2D) : Void;
	/**
	 * Draws only the path described for this Graphics instance, skipping any non-path instructions, including fill and
	 * stroke descriptions. Used for <code>DisplayObject.mask</code> to draw the clipping path, for example.
	 */
	function drawAsPath(ctx:js.html.CanvasRenderingContext2D) : Void;
	/**
	 * Moves the drawing point to the specified position. A tiny API method "mt" also exists.
	 */
	function moveTo(x:Float, y:Float) : Graphics;
	/**
	 * Draws a line from the current drawing point to the specified position, which become the new current drawing
	 * point. A tiny API method "lt" also exists.
	 * 
	 * For detailed information, read the
	 * <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#complex-shapes-(paths)">
	 * whatwg spec</a>.
	 */
	function lineTo(x:Float, y:Float) : Graphics;
	/**
	 * Draws an arc with the specified control points and radius.  For detailed information, read the
	 * <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-arcto">
	 * whatwg spec</a>. A tiny API method "at" also exists.
	 */
	function arcTo(x1:Float, y1:Float, x2:Float, y2:Float, radius:Float) : Graphics;
	/**
	 * Draws an arc defined by the radius, startAngle and endAngle arguments, centered at the position (x, y). For
	 * example, to draw a full circle with a radius of 20 centered at (100, 100):
	 * 
	 *      arc(100, 100, 20, 0, Math.PI*2);
	 * 
	 * For detailed information, read the
	 * <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-arc">whatwg spec</a>.
	 * A tiny API method "a" also exists.
	 */
	function arc(x:Float, y:Float, radius:Float, startAngle:Float, endAngle:Float, anticlockwise:Bool) : Graphics;
	/**
	 * Draws a quadratic curve from the current drawing point to (x, y) using the control point (cpx, cpy). For detailed
	 * information, read the <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-quadraticcurveto">
	 * whatwg spec</a>. A tiny API method "qt" also exists.
	 */
	function quadraticCurveTo(cpx:Float, cpy:Float, x:Float, y:Float) : Graphics;
	/**
	 * Draws a bezier curve from the current drawing point to (x, y) using the control points (cp1x, cp1y) and (cp2x,
	 * cp2y). For detailed information, read the
	 * <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-beziercurveto">
	 * whatwg spec</a>. A tiny API method "bt" also exists.
	 */
	function bezierCurveTo(cp1x:Float, cp1y:Float, cp2x:Float, cp2y:Float, x:Float, y:Float) : Graphics;
	/**
	 * Draws a rectangle at (x, y) with the specified width and height using the current fill and/or stroke.
	 * For detailed information, read the
	 * <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-rect">
	 * whatwg spec</a>. A tiny API method "r" also exists.
	 */
	function rect(x:Float, y:Float, w:Float, h:Float) : Graphics;
	/**
	 * Closes the current path, effectively drawing a line from the current drawing point to the first drawing point specified
	 * since the fill or stroke was last set. A tiny API method "cp" also exists.
	 */
	function closePath() : Graphics;
	/**
	 * Clears all drawing instructions, effectively resetting this Graphics instance. Any line and fill styles will need
	 * to be redefined to draw shapes following a clear call. A tiny API method "c" also exists.
	 */
	function clear() : Graphics;
	/**
	 * Begins a fill with the specified color. This ends the current sub-path. A tiny API method "f" also exists.
	 */
	function beginFill(color:String) : Graphics;
	/**
	 * Begins a linear gradient fill defined by the line (x0, y0) to (x1, y1). This ends the current sub-path. For
	 * example, the following code defines a black to white vertical gradient ranging from 20px to 120px, and draws a
	 * square to display it:
	 * 
	 *      myGraphics.beginLinearGradientFill(["#000","#FFF"], [0, 1], 0, 20, 0, 120).drawRect(20, 20, 120, 120);
	 * 
	 * A tiny API method "lf" also exists.
	 */
	function beginLinearGradientFill(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, x1:Float, y1:Float) : Graphics;
	/**
	 * Begins a radial gradient fill. This ends the current sub-path. For example, the following code defines a red to
	 * blue radial gradient centered at (100, 100), with a radius of 50, and draws a circle to display it:
	 * 
	 *      myGraphics.beginRadialGradientFill(["#F00","#00F"], [0, 1], 100, 100, 0, 100, 100, 50).drawCircle(100, 100, 50);
	 * 
	 * A tiny API method "rf" also exists.
	 */
	function beginRadialGradientFill(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, r0:Float, x1:Float, y1:Float, r1:Float) : Graphics;
	/**
	 * Begins a pattern fill using the specified image. This ends the current sub-path. A tiny API method "bf" also
	 * exists.
	 */
	function beginBitmapFill(image:Dynamic, ?repetition:String, ?matrix:Matrix2D) : Graphics;
	/**
	 * Ends the current sub-path, and begins a new one with no fill. Functionally identical to <code>beginFill(null)</code>.
	 * A tiny API method "ef" also exists.
	 */
	function endFill() : Graphics;
	/**
	 * Sets the stroke style for the current sub-path. Like all drawing methods, this can be chained, so you can define
	 * the stroke style and color in a single line of code like so:
	 * 
	 *      myGraphics.setStrokeStyle(8,"round").beginStroke("#F00");
	 * 
	 * A tiny API method "ss" also exists.
	 */
	function setStrokeStyle(thickness:Float, ?caps:Dynamic, ?joints:Dynamic, ?miterLimit:Float, ?ignoreScale:Bool) : Graphics;
	/**
	 * Begins a stroke with the specified color. This ends the current sub-path. A tiny API method "s" also exists.
	 */
	function beginStroke(color:String) : Graphics;
	/**
	 * Begins a linear gradient stroke defined by the line (x0, y0) to (x1, y1). This ends the current sub-path. For
	 * example, the following code defines a black to white vertical gradient ranging from 20px to 120px, and draws a
	 * square to display it:
	 * 
	 *      myGraphics.setStrokeStyle(10).
	 *          beginLinearGradientStroke(["#000","#FFF"], [0, 1], 0, 20, 0, 120).drawRect(20, 20, 120, 120);
	 * 
	 * A tiny API method "ls" also exists.
	 */
	function beginLinearGradientStroke(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, x1:Float, y1:Float) : Graphics;
	/**
	 * Begins a radial gradient stroke. This ends the current sub-path. For example, the following code defines a red to
	 * blue radial gradient centered at (100, 100), with a radius of 50, and draws a rectangle to display it:
	 * 
	 *      myGraphics.setStrokeStyle(10)
	 *          .beginRadialGradientStroke(["#F00","#00F"], [0, 1], 100, 100, 0, 100, 100, 50)
	 *          .drawRect(50, 90, 150, 110);
	 * 
	 * A tiny API method "rs" also exists.
	 */
	function beginRadialGradientStroke(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, r0:Float, x1:Float, y1:Float, r1:Float) : Graphics;
	/**
	 * Begins a pattern fill using the specified image. This ends the current sub-path. Note that unlike bitmap fills,
	 * strokes do not currently support a matrix parameter due to limitations in the canvas API. A tiny API method "bs"
	 * also exists.
	 */
	function beginBitmapStroke(image:Dynamic, ?repetition:String) : Graphics;
	/**
	 * Ends the current sub-path, and begins a new one with no stroke. Functionally identical to <code>beginStroke(null)</code>.
	 * A tiny API method "es" also exists.
	 */
	function endStroke() : Graphics;
	/**
	 * Maps the familiar ActionScript <code>curveTo()</code> method to the functionally similar {{#crossLink "Graphics/quadraticCurveTo"}}{{/crossLink}}
	 * method.
	 */
	function curveTo(cpx:Float, cpy:Float, x:Float, y:Float) : Graphics;
	/**
	 * Maps the familiar ActionScript <code>drawRect()</code> method to the functionally similar {{#crossLink "Graphics/rect"}}{{/crossLink}}
	 * method.
	 */
	function drawRect(x:Float, y:Float, w:Float, h:Float) : Graphics;
	/**
	 * Draws a rounded rectangle with all corners with the specified radius.
	 */
	function drawRoundRect(x:Float, y:Float, w:Float, h:Float, radius:Float) : Graphics;
	/**
	 * Draws a rounded rectangle with different corner radii. Supports positive and negative corner radii. A tiny API
	 * method "rc" also exists.
	 */
	function drawRoundRectComplex(x:Float, y:Float, w:Float, h:Float, radiusTL:Float, radiusTR:Float, radiusBR:Float, radiusBL:Float) : Graphics;
	/**
	 * Draws a circle with the specified radius at (x, y).
	 * 
	 *      var g = new createjs.Graphics();
	 * 	    g.setStrokeStyle(1);
	 * 	    g.beginStroke(createjs.Graphics.getRGB(0,0,0));
	 * 	    g.beginFill(createjs.Graphics.getRGB(255,0,0));
	 * 	    g.drawCircle(0,0,3);
	 * 
	 * 	    var s = new createjs.Shape(g);
	 * 		s.x = 100;
	 * 		s.y = 100;
	 * 
	 * 	    stage.addChild(s);
	 * 	    stage.update();
	 * 
	 * A tiny API method "dc" also exists.
	 */
	function drawCircle(x:Float, y:Float, radius:Float) : Graphics;
	/**
	 * Draws an ellipse (oval) with a specified width (w) and height (h). Similar to {{#crossLink "Graphics/drawCircle"}}{{/crossLink}},
	 * except the width and height can be different. A tiny API method "de" also exists.
	 */
	function drawEllipse(x:Float, y:Float, w:Float, h:Float) : Graphics;
	/**
	 * Provides a method for injecting arbitrary Context2D (aka Canvas) API calls into a Graphics queue. The specified
	 * callback function will be called in sequence with other drawing instructions. The callback will be executed in the
	 * scope of the target canvas's Context2D object, and will be passed the data object as a parameter.
	 * 
	 * This is an advanced feature. It can allow for powerful functionality, like injecting output from tools that
	 * export Context2D instructions, executing raw canvas calls within the context of the display list, or dynamically
	 * modifying colors or stroke styles within a Graphics instance over time, but it is not intended for general use.
	 * 
	 * Within a Graphics queue, each path begins by applying the fill and stroke styles and settings, followed by
	 * drawing instructions, followed by the fill() and/or stroke() commands. This means that within a path, inject() can
	 * update the fill & stroke styles, but for it to be applied in a predictable manner, you must have begun a fill or
	 * stroke (as appropriate) normally via the Graphics API. For example:
	 * 
	 * 	function setColor(color) {
	 * 		this.fillStyle = color;
	 * 	}
	 * 
	 * 	// this will not draw anything - no fill was begun, so fill() is not called:
	 * 	myGraphics.inject(setColor, "red").drawRect(0,0,100,100);
	 * 
	 * 	// this will draw the rect in green:
	 * 	myGraphics.beginFill("#000").inject(setColor, "green").drawRect(0,0,100,100);
	 * 
	 * 	// this will draw both rects in blue, because there is only a single path
	 * 	// so the second inject overwrites the first:
	 * 	myGraphics.beginFill("#000").inject(setColor, "green").drawRect(0,0,100,100)
	 * 		.inject(setColor, "blue").drawRect(100,0,100,100);
	 * 
	 * 	// this will draw the first rect in green, and the second in blue:
	 * 	myGraphics.beginFill("#000").inject(setColor, "green").drawRect(0,0,100,100)
	 * 		.beginFill("#000").inject(setColor, "blue").drawRect(100,0,100,100);
	 */
	function inject(callback:Dynamic, data:Dynamic) : Graphics;
	/**
	 * Draws a star if pointSize is greater than 0, or a regular polygon if pointSize is 0 with the specified number of
	 * points. For example, the following code will draw a familiar 5 pointed star shape centered at 100, 100 and with a
	 * radius of 50:
	 * 
	 *      myGraphics.beginFill("#FF0").drawPolyStar(100, 100, 50, 5, 0.6, -90);
	 *      // Note: -90 makes the first point vertical
	 * 
	 * A tiny API method "dp" also exists.
	 */
	function drawPolyStar(x:Float, y:Float, radius:Float, sides:Float, pointSize:Float, angle:Float) : Graphics;
	/**
	 * Decodes a compact encoded path string into a series of draw instructions.
	 * This format is not intended to be human readable, and is meant for use by authoring tools.
	 * The format uses a base64 character set, with each character representing 6 bits, to define a series of draw
	 * commands.
	 * 
	 * Each command is comprised of a single "header" character followed by a variable number of alternating x and y
	 * position values. Reading the header bits from left to right (most to least significant): bits 1 to 3 specify the
	 * type of operation (0-moveTo, 1-lineTo, 2-quadraticCurveTo, 3-bezierCurveTo, 4-closePath, 5-7 unused). Bit 4
	 * indicates whether position values use 12 bits (2 characters) or 18 bits (3 characters), with a one indicating the
	 * latter. Bits 5 and 6 are currently unused.
	 * 
	 * Following the header is a series of 0 (closePath), 2 (moveTo, lineTo), 4 (quadraticCurveTo), or 6 (bezierCurveTo)
	 * parameters. These parameters are alternating x/y positions represented by 2 or 3 characters (as indicated by the
	 * 4th bit in the command char). These characters consist of a 1 bit sign (1 is negative, 0 is positive), followed
	 * by an 11 (2 char) or 17 (3 char) bit integer value. All position values are in tenths of a pixel. Except in the
	 * case of move operations which are absolute, this value is a delta from the previous x or y position (as
	 * appropriate).
	 * 
	 * For example, the string "A3cAAMAu4AAA" represents a line starting at -150,0 and ending at 150,0.
	 * <br />A - bits 000000. First 3 bits (000) indicate a moveTo operation. 4th bit (0) indicates 2 chars per
	 * parameter.
	 * <br />n0 - 110111011100. Absolute x position of -150.0px. First bit indicates a negative value, remaining bits
	 * indicate 1500 tenths of a pixel.
	 * <br />AA - 000000000000. Absolute y position of 0.
	 * <br />I - 001100. First 3 bits (001) indicate a lineTo operation. 4th bit (1) indicates 3 chars per parameter.
	 * <br />Au4 - 000000101110111000. An x delta of 300.0px, which is added to the previous x value of -150.0px to
	 * provide an absolute position of +150.0px.
	 * <br />AAA - 000000000000000000. A y delta value of 0.
	 * 
	 * A tiny API method "p" also exists.
	 */
	function decodePath(str:String) : Graphics;
	/**
	 * Returns a clone of this Graphics instance.
	 */
	function clone() : Graphics;
	/**
	 * Returns a string representation of this object.
	 */
	function toString() : String;
}