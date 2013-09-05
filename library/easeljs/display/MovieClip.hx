package easeljs.display;

/**
* The MovieClip class associates a TweenJS Timeline with an EaselJS {{#crossLink "Container"}}{{/crossLink}}. It allows
*	you to create objects which encapsulate timeline animations, state changes, and synched actions. Due to the
*	complexities inherent in correctly setting up a MovieClip, it is largely intended for tool output and is not included
*	in the main EaselJS library.
*	
*	Currently MovieClip only works properly if it is tick based (as opposed to time based) though some concessions have
*	been made to support time-based timelines in the future.
*	
*	<h4>Example</h4>
*	This example animates two shapes back and forth. The grey shape starts on the left, but we jump to a mid-point in
*	the animation using {{#crossLink "MovieClip/gotoAndPlay"}}{{/crossLink}}.
*	
*	     var stage = new createjs.Stage("canvas");
*	     createjs.Ticker.addEventListener("tick", stage);
*	
*	     var mc = new createjs.MovieClip(null, 0, true, {start:20});
*	     stage.addChild(mc);
*	
*	     var child1 = new createjs.Shape(
*	         new createjs.Graphics().beginFill("#999999")
*	             .drawCircle(30,30,30));
*	     var child2 = new createjs.Shape(
*	         new createjs.Graphics().beginFill("#5a9cfb")
*	             .drawCircle(30,30,30));
*	
*	     mc.timeline.addTween(
*	         createjs.Tween.get(child1)
*	             .to({x:0}).to({x:60}, 50).to({x:0}, 50));
*	     mc.timeline.addTween(
*	         createjs.Tween.get(child2)
*	             .to({x:60}).to({x:0}, 50).to({x:60}, 50));
*	
*	     mc.gotoAndPlay("start");
*	
*	It is recommended to use <code>tween.to()</code> to animate and set properties (use no duration to have it set
*	immediately), and the <code>tween.wait()</code> method to create delays between animations. Note that using the
*	<code>tween.set()</code> method to affect properties will likely not provide the desired result.
*/
@:native("easeljs.MovieClip")
extern class MovieClip extends Container
{
}
