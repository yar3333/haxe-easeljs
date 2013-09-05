package easeljs.display;

/**
* Displays a frame or sequence of frames (ie. an animation) from a SpriteSheet instance. A sprite sheet is a series of
*	images (usually animation frames) combined into a single image. For example, an animation consisting of 8 100x100
*	images could be combined into a 400x200 sprite sheet (4 frames across by 2 high). You can display individual frames,
*	play frames as an animation, and even sequence animations together.
*	
*	See the {{#crossLink "SpriteSheet"}}{{/crossLink}} class for more information on setting up frames and animations.
*	
*	<h4>Example</h4>
*	     var instance = new createjs.Sprite(spriteSheet);
*	     instance.gotoAndStop("frameName");
*	
*	Until {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}} is called,
*	only the first defined frame defined in the sprite sheet will be displayed.
*/
@:native("easeljs.Sprite")
extern class Sprite extends DisplayObject
{
}
