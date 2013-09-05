package easeljs.display;

/**
* <b>This class is still experimental, and more advanced use is likely to be buggy. Please report bugs.</b>
*	
*	A DOMElement allows you to associate a HTMLElement with the display list. It will be transformed
*	within the DOM as though it is child of the {{#crossLink "Container"}}{{/crossLink}} it is added to. However, it is
*	not rendered to canvas, and as such will retain whatever z-index it has relative to the canvas (ie. it will be
*	drawn in front of or behind the canvas).
*	
*	The position of a DOMElement is relative to their parent node in the DOM. It is recommended that
*	the DOM Object be added to a div that also contains the canvas so that they share the same position
*	on the page.
*	
*	DOMElement is useful for positioning HTML elements over top of canvas content, and for elements
*	that you want to display outside the bounds of the canvas. For example, a tooltip with rich HTML
*	content.
*	
*	<h4>Mouse Interaction</h4>
*	
*	DOMElement instances are not full EaselJS display objects, and do not participate in EaselJS mouse
*	events or support methods like hitTest. To get mouse events from a DOMElement, you must instead add handlers to
*	the htmlElement (note, this does not support EventDispatcher)
*	
*	     var domElement = new createjs.DOMElement(htmlElement);
*	     domElement.htmlElement.onclick = function() {
*	         console.log("clicked");
*	     }
*/
@:native("easeljs.DOMElement")
extern class DOMElement extends DisplayObject
{
}
