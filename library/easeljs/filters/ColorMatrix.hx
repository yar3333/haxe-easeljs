package easeljs.filters;

/**
* Provides helper functions for assembling a matrix for use with the {{#crossLink "ColorMatrixFilter"}}{{/crossLink}},
*	or can be used directly as the matrix for a ColorMatrixFilter. Most methods return the instance to facilitate
*	chained calls.
*	
*	<h4>Example</h4>
*	     myColorMatrix.adjustHue(20).adjustBrightness(50);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for an example of how to apply filters, or {{#crossLink "ColorMatrixFilter"}}{{/crossLink}}
*	for an example of how to use ColorMatrix to change a DisplayObject's color.
*/
@:native("easeljs.ColorMatrix")
extern class ColorMatrix extends Array
{
}
