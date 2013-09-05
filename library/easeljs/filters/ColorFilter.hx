package easeljs.filters;

/**
* Applies a color transform to DisplayObjects.
*	
*	<h4>Example</h4>
*	This example draws a red circle, and then transforms it to Blue. This is accomplished by multiplying all the channels
*	to 0 (except alpha, which is set to 1), and then adding 255 to the blue channel.
*	
*	     var shape = new createjs.Shape().set({x:100,y:100});
*	     shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
*	
*	     shape.filters = [
*	         new createjs.ColorFilter(0,0,0,1, 0,0,255,0)
*	     ];
*	     shape.cache(-50, -50, 100, 100);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
*/
@:native("easeljs.ColorFilter")
extern class ColorFilter extends Filter
{
}
