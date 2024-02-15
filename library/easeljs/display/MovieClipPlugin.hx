package easeljs.display;

import tweenjs.Tween;
import tweenjs.TweenStep;

#if tweenjs

/**
 * This plugin works with <a href="http://tweenjs.com" target="_blank">TweenJS</a> to prevent the startPosition
 * property from tweening.
 */
@:native('createjs.MovieClipPlugin')
extern class MovieClipPlugin
{
	static var priority : Int;
	static var ID : String;

	function new() : Void;

	static function install() : Void;
	static function init(tween:Tween, prop:String, value:Dynamic) : Void;
	static function step(tween:Tween, step:TweenStep, props:Dynamic) : Void;
	static function change(tween:Tween, step:TweenStep, value:Dynamic, ratio:Float, end:Dynamic) : Dynamic;
}

#end
