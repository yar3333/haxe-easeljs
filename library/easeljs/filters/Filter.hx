package easeljs.filters;

/**
* Base class that all filters should inherit from. Filters need to be applied to objects that have been cached using
*	the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method. If an object changes, please cache it again, or use
*	{{#crossLink "DisplayObject/updateCache"}}{{/crossLink}}. Note that the filters must be applied before caching.
*	
*	<h4>Example</h4>
*	     myInstance.filters = [
*	         new createjs.ColorFilter(0, 0, 0, 1, 255, 0, 0),
*	         new createjs.BlurFilter(5, 5, 10)
*	     ];
*	     myInstance.cache(0,0, 100, 100);
*	
*	Note that each filter can implement a {{#crossLink "Filter/getBounds"}}{{/crossLink}} method, which returns the
*	margins that need to be applied in order to fully display the filter. For example, the {{#crossLink "BlurFilter"}}{{/crossLink}}
*	will cause an object to feather outwards, resulting in a margin around the shape.
*	
*	<h4>EaselJS Filters</h4>
*	EaselJS comes with a number of pre-built filters. Note that individual filters are not compiled into the minified
*	version of EaselJS. To use them, you must include them manually in the HTML.
*	<ul><li>{{#crossLink "AlphaMapFilter"}}{{/crossLink}} : Map a greyscale image to the alpha channel of a display object</li>
*	     <li>{{#crossLink "AlphaMaskFilter"}}{{/crossLink}}: Map an image's alpha channel to the alpha channel of a display object</li>
*	     <li>{{#crossLink "BlurFilter"}}{{/crossLink}}: Apply vertical and horizontal blur to a display object</li>
*	     <li>{{#crossLink "ColorFilter"}}{{/crossLink}}: Color transform a display object</li>
*	     <li>{{#crossLink "ColorMatrixFilter"}}{{/crossLink}}: Transform an image using a {{#crossLink "ColorMatrix"}}{{/crossLink}}</li>
*	</ul>
*/
@:native("easeljs.Filter")
extern class Filter
{
}
