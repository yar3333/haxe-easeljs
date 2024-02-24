package easeljs.display;

import haxe.extern.EitherType;
import js.html.ImageElement;

/**
    https://createjs.com/docs/easeljs/classes/SpriteSheet.html
**/
typedef SpriteSheetData =
{
    /**
        Strings is URLs to images.
    **/
    var images: Array<EitherType<ImageElement, String>>;
    
    /**
        For each frame: [ x, y, width, height, imageIndex, regX, regY ]
    **/
    var frames: Array<Array<Float>>;

    @:optional var animations: Dynamic<EitherType<Int, Array<Dynamic>>>;
    
    @:optional var framerate: Float;
}