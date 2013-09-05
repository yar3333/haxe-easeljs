package easeljs.ui;

/**
* Global utility for working with multi-touch enabled devices in EaselJS. Currently supports W3C Touch API (iOS and
*	modern Android browser) and the Pointer API (IE).
*	
*	Ensure that you {{#crossLink "Touch/disable"}}{{/crossLink}} touch when cleaning up your application.
*	Note that you do not have to check if touch is supported to enable it, as it will fail gracefully if it is not
*	supported.
*	
*	<h4>Example</h4>
*	
*	     var stage = new createjs.Stage("canvasId");
*	     createjs.Touch.enable(stage);
*	
*	<strong>Note:</strong> It is important to disable Touch on a stage that you are no longer using:
*	
*	     createjs.Touch.disable(stage);
*/
@:native("easeljs.Touch")
extern class Touch
{
}
