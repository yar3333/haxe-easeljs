package easeljs.display;

/**
* Display one or more lines of dynamic text (not user editable) in the display list. Line wrapping support (using the
*	lineWidth) is very basic, wrapping on spaces and tabs only. Note that as an alternative to Text, you can position HTML
*	text above or below the canvas relative to items in the display list using the {{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}}
*	method, or using {{#crossLink "DOMElement"}}{{/crossLink}}.
*	
*	<b>Please note that Text does not support HTML text, and can only display one font style at a time.</b> To use
*	multiple font styles, you will need to create multiple text instances, and position them manually.
*	
*	<h4>Example</h4>
*	     var text = new createjs.Text("Hello World", "20px Arial", "#ff7700");
*	     text.x = 100;
*	     text.textBaseline = "alphabetic";
*	
*	CreateJS Text supports web fonts (the same rules as Canvas). The font must be loaded and supported by the browser
*	before it can be displayed.
*	
*	<strong>Note:</strong> Text can be expensive to generate, so cache instances where possible. Be aware that not all
*	browsers will render Text exactly the same.
*/
@:native("easeljs.Text")
extern class Text extends DisplayObject
{
}
