package easeljs.display;

/**
* A Bitmap represents an Image, Canvas, or Video in the display list. A Bitmap can be instantiated using an existing
*	HTML element, or a string.
*	
*	<h4>Example</h4>
*	     var bitmap = new createjs.Bitmap("imagePath.jpg");
*	
*	<strong>Notes:</strong>
*	<ol>
*	    <li>When a string path or image tag that is not yet loaded is used, the stage may need to be redrawn before it
*	     will be displayed.</li>
*	    <li>Bitmaps with an SVG source currently will not respect an alpha value other than 0 or 1. To get around this,
*	    the Bitmap can be cached.</li>
*	    <li>Bitmaps with an SVG source will taint the canvas with cross-origin data, which prevents interactivity. This
*	    happens in all browsers except recent Firefox builds.</li>
*	</ol>
*/
@:native("easeljs.Bitmap")
extern class Bitmap extends DisplayObject
{
}
