package easeljs.display;

/**
* DisplayObject is an abstract class that should not be constructed directly. Instead construct subclasses such as
*	{{#crossLink "Container"}}{{/crossLink}}, {{#crossLink "Bitmap"}}{{/crossLink}}, and {{#crossLink "Shape"}}{{/crossLink}}.
*	DisplayObject is the base class for all display classes in the EaselJS library. It defines the core properties and
*	methods that are shared between all display objects, such as transformation properties (x, y, scaleX, scaleY, etc),
*	caching, and mouse handlers.
*/
@:native("easeljs.DisplayObject")
extern class DisplayObject extends EventDispatcher
{
}
