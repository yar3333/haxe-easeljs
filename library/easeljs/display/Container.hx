package easeljs.display;

/**
* A Container is a nestable display list that allows you to work with compound display elements. For  example you could
*	group arm, leg, torso and head {{#crossLink "Bitmap"}}{{/crossLink}} instances together into a Person Container, and
*	transform them as a group, while still being able to move the individual parts relative to each other. Children of
*	containers have their <code>transform</code> and <code>alpha</code> properties concatenated with their parent
*	Container.
*	
*	For example, a {{#crossLink "Shape"}}{{/crossLink}} with x=100 and alpha=0.5, placed in a Container with <code>x=50</code>
*	and <code>alpha=0.7</code> will be rendered to the canvas at <code>x=150</code> and <code>alpha=0.35</code>.
*	Containers have some overhead, so you generally shouldn't create a Container to hold a single child.
*	
*	<h4>Example</h4>
*	     var container = new createjs.Container();
*	     container.addChild(bitmapInstance, shapeInstance);
*	     container.x = 100;
*/
@:native("easeljs.Container")
extern class Container extends DisplayObject
{
}
