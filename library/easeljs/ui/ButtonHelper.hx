package easeljs.ui;

/**
* The ButtonHelper is a helper class to create interactive buttons from {{#crossLink "MovieClip"}}{{/crossLink}} or
*	{{#crossLink "Sprite"}}{{/crossLink}} instances. This class will intercept mouse events from an object, and
*	automatically call {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}},
*	to the respective animation labels, add a pointer cursor, and allows the user to define a hit state frame.
*	
*	The ButtonHelper instance does not need to be added to the stage, but a reference should be maintained to prevent
*	garbage collection.
*	
*	Note that over states will not work unless you call {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}}.
*	
*	<h4>Example</h4>
*	
*	     var helper = new createjs.ButtonHelper(myInstance, "out", "over", "down", false, myInstance, "hit");
*	     myInstance.addEventListener("click", handleClick);
*	     function handleClick(event) {
*	         // Click Happened.
*	     }
*/
@:native("easeljs.ButtonHelper")
extern class ButtonHelper
{
}
