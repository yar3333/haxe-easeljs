package easeljs.utils;

/**
* The SpriteSheetBuilder allows you to generate sprite sheets at run time from any display object. This can allow
*	you to maintain your assets as vector graphics (for low file size), and render them at run time as sprite sheets
*	for better performance.
*	
*	Sprite sheets can be built either synchronously, or asynchronously, so that large sprite sheets can be generated
*	without locking the UI.
*	
*	Note that the "images" used in the generated sprite sheet are actually canvas elements, and that they will be sized
*	to the nearest power of 2 up to the value of <code>maxWidth</code> or <code>maxHeight</code>.
*/
@:native("easeljs.SpriteSheetBuilder")
extern class SpriteSheetBuilder extends EventDispatcher
{
}
