package easeljs.filters;

/**
* Applies a box blur to DisplayObjects. Note that this filter is fairly CPU intensive, particularly if the quality is
*	set higher than 1.
*	
*	<h4>Example</h4>
*	This example creates a red circle, and then applies a 5 pixel blur to it. It uses the {{#crossLink "Filter/getBounds"}}{{/crossLink}}
*	method to account for the spread that the blur causes.
*	
*	     var shape = new createjs.Shape().set({x:100,y:100});
*	     shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
*	
*	     var blurFilter = new createjs.BlurFilter(5, 5, 1);
*	     shape.filters = [blurFilter];
*	     var bounds = blurFilter.getBounds();
*	
*	     shape.cache(-50+bounds.x, -50+bounds.y, 100+bounds.width, 100+bounds.height);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
*/
@:native("easeljs.BlurFilter")
extern class BlurFilter extends Filter
{
}
