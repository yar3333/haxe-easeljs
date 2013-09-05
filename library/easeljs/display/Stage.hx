package easeljs.display;

/**
* A stage is the root level {{#crossLink "Container"}}{{/crossLink}} for a display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
*	method is called, it will render its display list to its target canvas.
*	
*	<h4>Example</h4>
*	This example creates a stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
*	and redraw the stage using {{#crossLink "Stage/update"}}{{/crossLink}}.
*	
*	     var stage = new createjs.Stage("canvasElementId");
*	     var image = new createjs.Bitmap("imagePath.png");
*	     stage.addChild(image);
*	     createjs.Ticker.addEventListener("tick", handleTick);
*	     function handleTick(event) {
*	         image.x += 10;
*	         stage.update();
*	     }
*/
@:native("easeljs.Stage")
extern class Stage extends Container
{
}
