package easeljs;

/**
 * The MovieClip class associates a TweenJS Timeline with an EaselJS {{#crossLink "Container"}}{{/crossLink}}. It allows
 * you to create objects which encapsulate timeline animations, state changes, and synched actions. Due to the
 * complexities inherent in correctly setting up a MovieClip, it is largely intended for tool output and is not included
 * in the main EaselJS library.
 * 
 * Currently MovieClip only works properly if it is tick based (as opposed to time based) though some concessions have
 * been made to support time-based timelines in the future.
 * 
 * <h4>Example</h4>
 * This example animates two shapes back and forth. The grey shape starts on the left, but we jump to a mid-point in
 * the animation using {{#crossLink "MovieClip/gotoAndPlay"}}{{/crossLink}}.
 * 
 *      var stage = new createjs.Stage("canvas");
 *      createjs.Ticker.addEventListener("tick", stage);
 * 
 *      var mc = new createjs.MovieClip(null, 0, true, {start:20});
 *      stage.addChild(mc);
 * 
 *      var child1 = new createjs.Shape(
 *          new createjs.Graphics().beginFill("#999999")
 *              .drawCircle(30,30,30));
 *      var child2 = new createjs.Shape(
 *          new createjs.Graphics().beginFill("#5a9cfb")
 *              .drawCircle(30,30,30));
 * 
 *      mc.timeline.addTween(
 *          createjs.Tween.get(child1)
 *              .to({x:0}).to({x:60}, 50).to({x:0}, 50));
 *      mc.timeline.addTween(
 *          createjs.Tween.get(child2)
 *              .to({x:60}).to({x:0}, 50).to({x:60}, 50));
 * 
 *      mc.gotoAndPlay("start");
 * 
 * It is recommended to use <code>tween.to()</code> to animate and set properties (use no duration to have it set
 * immediately), and the <code>tween.wait()</code> method to create delays between animations. Note that using the
 * <code>tween.set()</code> method to affect properties will likely not provide the desired result.
 */
@:native("createjs.MovieClip")
extern class MovieClip extends Container
{
	/**
	 * The MovieClip will advance independently of its parent, even if its parent is paused.
	 * This is the default mode.
	 */
	static var INDEPENDENT : String;
	/**
	 * The MovieClip will only display a single frame (as determined by the startPosition property).
	 */
	static var SINGLE_FRAME : String;
	/**
	 * The MovieClip will be advanced only when its parent advances and will be synched to the position of
	 * the parent MovieClip.
	 */
	static var SYNCHED : String;
	/**
	 * Controls how this MovieClip advances its time. Must be one of 0 (INDEPENDENT), 1 (SINGLE_FRAME), or 2 (SYNCHED).
	 * See each constant for a description of the behaviour.
	 */
	var mode : String;
	/**
	 * Specifies what the first frame to play in this movieclip, or the only frame to display if mode is SINGLE_FRAME.
	 */
	var startPosition : Float;
	/**
	 * Indicates whether this MovieClip should loop when it reaches the end of its timeline.
	 */
	var loop : Bool;
	/**
	 * The current frame of the movieclip.
	 */
	var currentFrame : Float;
	/**
	 * The TweenJS Timeline that is associated with this MovieClip. This is created automatically when the MovieClip
	 * instance is initialized. Animations are created by adding <a href="http://tweenjs.com">TweenJS</a> Tween
	 * instances to the timeline.
	 * 
	 * <h4>Example</h4>
	 *      var tween = createjs.Tween.get(target).to({x:0}).to({x:100}, 30);
	 *      var mc = new createjs.MovieClip();
	 *      mc.timeline.addTween(tween);
	 * 
	 * Elements can be added and removed from the timeline by toggling an "_off" property
	 * using the <code>tweenInstance.to()</code> method. Note that using <code>Tween.set</code> is not recommended to
	 * create MovieClip animations. The following example will toggle the target off on frame 0, and then back on for
	 * frame 1. You can use the "visible" property to achieve the same effect.
	 * 
	 *      var tween = createjs.Tween.get(target).to({_off:false})
	 *          .wait(1).to({_off:true})
	 *          .wait(1).to({_off:false});
	 */
	var timeline : Timeline;
	/**
	 * If true, the MovieClip's position will not advance when ticked.
	 */
	var paused : Bool;
	/**
	 * If true, actions in this MovieClip's tweens will be run when the playhead advances.
	 */
	var actionsEnabled : Bool;
	/**
	 * If true, the MovieClip will automatically be reset to its first frame whenever the timeline adds
	 * it back onto the display list. This only applies to MovieClip instances with mode=INDEPENDENT.
	 * <br><br>
	 * For example, if you had a character animation with a "body" child MovieClip instance
	 * with different costumes on each frame, you could set body.autoReset = false, so that
	 * you can manually change the frame it is on, without worrying that it will be reset
	 * automatically.
	 */
	var autoReset : Bool;
	/**
	 * An array of bounds for each frame in the MovieClip. This is mainly intended for tool output.
	 */
	var frameBounds : Array<Dynamic>;

	function new(?mode:String, ?startPosition:Float, ?loop:Bool, ?labels:Dynamic) : Void;

	/**
	 * Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	 * This does not account for whether it would be visible within the boundaries of the stage.
	 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	 */
	override function isVisible() : Bool;
	/**
	 * Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
	 * Returns true if the draw was handled (useful for overriding functionality).
	 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	 */
	override function draw(ctx:js.html.CanvasRenderingContext2D, ignoreCache:Bool) : Bool;
	/**
	 * Sets paused to false.
	 */
	function play() : Void;
	/**
	 * Sets paused to true.
	 */
	function stop() : Void;
	/**
	 * Advances this movie clip to the specified position or label and sets paused to false.
	 */
	function gotoAndPlay(positionOrLabel:Dynamic) : Void;
	/**
	 * Advances this movie clip to the specified position or label and sets paused to true.
	 */
	function gotoAndStop(positionOrLabel:Dynamic) : Void;
	/**
	 * Returns a sorted list of the labels defined on this MovieClip. Shortcut to TweenJS: Timeline.getLabels();
	 */
	function getLabels() : Array[Object];
	/**
	 * Returns the name of the label on or immediately before the current frame. See TweenJS: Timeline.getCurrentLabel()
	 * for more information.
	 */
	function getCurrentLabel() : String;
	/**
	 * Returns a string representation of this object.
	 */
	override function toString() : String;
}