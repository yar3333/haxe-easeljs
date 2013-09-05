package easeljs.display;

/**
* A Shape allows you to display vector art in the display list. It composites a {{#crossLink "Graphics"}}{{/crossLink}}
*	instance which exposes all of the vector drawing methods. The Graphics instance can be shared between multiple Shape
*	instances to display the same vector graphics with different positions or transforms.
*	
*	If the vector art will not
*	change between draws, you may want to use the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method to reduce the
*	rendering cost.
*	
*	<h4>Example</h4>
*	     var graphics = new createjs.Graphics().beginFill("#ff0000").drawRect(0, 0, 100, 100);
*	     var shape = new createjs.Shape(graphics);
*	
*	     //Alternatively use can also use the graphics property of the Shape class to renderer the same as above.
*	     var shape = new createjs.Shape();
*	     shape.graphics.beginFill("#ff0000").drawRect(0, 0, 100, 100);
*/
@:native("easeljs.Shape")
extern class Shape extends DisplayObject
{
}
