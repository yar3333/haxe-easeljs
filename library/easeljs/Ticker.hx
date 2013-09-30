package easeljs;

typedef TickerTickEvent =
{
	var target : Dynamic;
	var type : String;
	var paused : Bool;
	var delta : Float;
	var time : Float;
	var runTime : Float;
}

/**
 * The Ticker provides  a centralized tick or heartbeat broadcast at a set interval. Listeners can subscribe to the tick
 * event to be notified when a set time interval has elapsed.
 * 
 * Note that the interval that the tick event is called is a target interval, and may be broadcast at a slower interval
 * during times of high CPU load. The Ticker class uses a static interface (ex. <code>Ticker.getPaused()</code>) and
 * should not be instantiated.
 * 
 * <h4>Example</h4>
 *      createjs.Ticker.addEventListener("tick", handleTick);
 *      function handleTick(event) {
 *          // Actions carried out each frame
 *          if (!event.paused) {
 *              // Actions carried out when the Ticker is not paused.
 *          }
 *      }
 * 
 * To update a stage every tick, the {{#crossLink "Stage"}}{{/crossLink}} instance can also be used as a listener, as
 * it will automatically update when it receives a tick event:
 * 
 *      createjs.Ticker.addEventListener("tick", stage);
 */
@:native("createjs.Ticker")
extern class Ticker
{
	/**
	 * In this mode, Ticker uses the requestAnimationFrame API, but attempts to synch the ticks to target framerate. It
	 * uses a simple heuristic that compares the time of the RAF return to the target time for the current frame and
	 * dispatches the tick when the time is within a certain threshold.
	 * 
	 * This mode has a higher variance for time between frames than TIMEOUT, but does not require that content be time
	 * based as with RAF while gaining the benefits of that API (screen synch, background throttling).
	 * 
	 * Variance is usually lowest for framerates that are a divisor of the RAF frequency. This is usually 60, so
	 * framerates of 10, 12, 15, 20, and 30 work well.
	 * 
	 * Falls back on TIMEOUT if the requestAnimationFrame API is not supported.
	 */
	static var RAF_SYNCHED : String;
	/**
	 * In this mode, Ticker passes through the requestAnimationFrame heartbeat, ignoring the target framerate completely.
	 * Because requestAnimationFrame frequency is not deterministic, any content using this mode should be time based.
	 * You can leverage {{#crossLink "Ticker/getTime"}}{{/crossLink}} and the tick event object's "delta" properties
	 * to make this easier.
	 * 
	 * Falls back on TIMEOUT if the requestAnimationFrame API is not supported.
	 */
	static var RAF : String;
	/**
	 * In this mode, Ticker uses the setTimeout API. This provides predictable, adaptive frame timing, but does not
	 * provide the benefits of requestAnimationFrame (screen synch, background throttling).
	 */
	static var TIMEOUT : String;
	/**
	 * Specifies the timing api (setTimeout or requestAnimationFrame) and mode to use. See
	 * {{#crossLink "Ticker/TIMEOUT"}}{{/crossLink}}, {{#crossLink "Ticker/RAF"}}{{/crossLink}}, and
	 * {{#crossLink "Ticker/RAF_SYNCHED"}}{{/crossLink}} for mode details.
	 */
	static var timingMode : String;
	/**
	 * Specifies a maximum value for the delta property in the tick event object. This is useful when building time
	 * based animations and systems to prevent issues caused by large time gaps caused by background tabs, system sleep,
	 * alert dialogs, or other blocking routines. Double the expected frame duration is often an effective value
	 * (ex. maxDelta=50 when running at 40fps).
	 * 
	 * This does not impact any other values (ex. time, runTime, etc), so you may experience issues if you enable maxDelta
	 * when using both delta and other values.
	 * 
	 * If 0, there is no maximum.
	 */
	static var maxDelta : Float;

	/**
	 * Starts the tick. This is called automatically when the first listener is added.
	 */
	static function init() : Void;
	/**
	 * Stops the Ticker and removes all listeners. Use init() to restart the Ticker.
	 */
	static function reset() : Void;
	/**
	 * Sets the target time (in milliseconds) between ticks. Default is 50 (20 FPS).
	 * 
	 * Note actual time between ticks may be more than requested depending on CPU load.
	 */
	static function setInterval(interval:Float) : Void;
	/**
	 * Returns the current target time between ticks, as set with {{#crossLink "Ticker/setInterval"}}{{/crossLink}}.
	 */
	static function getInterval() : Float;
	/**
	 * Sets the target frame rate in frames per second (FPS). For example, with an interval of 40, <code>getFPS()</code>
	 * will return 25 (1000ms per second divided by 40 ms per tick = 25fps).
	 */
	static function setFPS(value:Float) : Void;
	/**
	 * Returns the target frame rate in frames per second (FPS). For example, with an interval of 40, <code>getFPS()</code>
	 * will return 25 (1000ms per second divided by 40 ms per tick = 25fps).
	 */
	static function getFPS() : Float;
	/**
	 * Returns the average time spent within a tick. This can vary significantly from the value provided by getMeasuredFPS
	 * because it only measures the time spent within the tick execution stack. 
	 * 
	 * Example 1: With a target FPS of 20, getMeasuredFPS() returns 20fps, which indicates an average of 50ms between 
	 * the end of one tick and the end of the next. However, getMeasuredTickTime() returns 15ms. This indicates that 
	 * there may be up to 35ms of "idle" time between the end of one tick and the start of the next.
	 * 
	 * Example 2: With a target FPS of 30, getFPS() returns 10fps, which indicates an average of 100ms between the end of
	 * one tick and the end of the next. However, getMeasuredTickTime() returns 20ms. This would indicate that something
	 * other than the tick is using ~80ms (another script, DOM rendering, etc).
	 */
	static function getMeasuredTickTime(?ticks:Float) : Float;
	/**
	 * Returns the actual frames / ticks per second.
	 */
	static function getMeasuredFPS(?ticks:Float) : Float;
	/**
	 * Changes the "paused" state of the Ticker, which can be retrieved by the {{#crossLink "Ticker/getPaused"}}{{/crossLink}}
	 * method, and is passed as the "paused" property of the <code>tick</code> event. When the ticker is paused, all
	 * listeners will still receive a tick event, but the <code>paused</code> property will be false.
	 * 
	 * Note that in EaselJS v0.5.0 and earlier, "pauseable" listeners would <strong>not</strong> receive the tick
	 * callback when Ticker was paused. This is no longer the case.
	 * 
	 * <h4>Example</h4>
	 *      createjs.Ticker.addEventListener("tick", handleTick);
	 *      createjs.Ticker.setPaused(true);
	 *      function handleTick(event) {
	 *          console.log("Paused:", event.paused, createjs.Ticker.getPaused());
	 *      }
	 */
	static function setPaused(value:Bool) : Void;
	/**
	 * Returns a boolean indicating whether Ticker is currently paused, as set with {{#crossLink "Ticker/setPaused"}}{{/crossLink}}.
	 * When the ticker is paused, all listeners will still receive a tick event, but this value will be false.
	 * 
	 * Note that in EaselJS v0.5.0 and earlier, "pauseable" listeners would <strong>not</strong> receive the tick
	 * callback when Ticker was paused. This is no longer the case.
	 * 
	 * <h4>Example</h4>
	 *      createjs.Ticker.addEventListener("tick", handleTick);
	 *      createjs.Ticker.setPaused(true);
	 *      function handleTick(event) {
	 *          console.log("Paused:", createjs.Ticker.getPaused());
	 *      }
	 */
	static function getPaused() : Bool;
	/**
	 * Returns the number of milliseconds that have elapsed since Ticker was initialized. For example, you could use
	 * this in a time synchronized animation to determine the exact amount of time that has elapsed.
	 */
	static function getTime(?runTime:Bool) : Float;
	/**
	 * Similar to getTime(), but returns the time included with the current (or most recent) tick event object.
	 */
	function getEventTime(runTime:Bool) : Float;
	/**
	 * Returns the number of ticks that have been broadcast by Ticker.
	 */
	static function getTicks(pauseable:Bool) : Float;
	/**
	 * Adds the specified event listener. Note that adding multiple listeners to the same function will result in
	 * multiple callbacks getting fired.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      displayObject.addEventListener("click", handleClick);
	 *      function handleClick(event) {
	 *         // Click happened.
	 *      }
	 */
	function addEventListener(type:String, listener:Dynamic, ?useCapture:Bool) : Dynamic;
	/**
	 * A shortcut method for using addEventListener that makes it easier to specify an execution scope, have a listener
	 * only run once, associate arbitrary data with the listener, and remove the listener.
	 * 
	 * This method works by creating an anonymous wrapper function and subscribing it with addEventListener.
	 * The created anonymous function is returned for use with .removeEventListener (or .off).
	 * 
	 * <h4>Example</h4>
	 * 
	 * 		var listener = myBtn.on("click", handleClick, null, false, {count:3});
	 * 		function handleClick(evt, data) {
	 * 			data.count -= 1;
	 * 			console.log(this == myBtn); // true - scope defaults to the dispatcher
	 * 			if (data.count == 0) {
	 * 				alert("clicked 3 times!");
	 * 				myBtn.off("click", listener);
	 * 				// alternately: evt.remove();
	 * 			}
	 * 		}
	 */
	function on(type:String, listener:Dynamic, ?scope:Dynamic, ?once:Bool, ?data:Dynamic, ?useCapture:Bool) : Dynamic;
	/**
	 * Removes the specified event listener.
	 * 
	 * <b>Important Note:</b> that you must pass the exact function reference used when the event was added. If a proxy
	 * function, or function closure is used as the callback, the proxy/closure reference must be used - a new proxy or
	 * closure will not work.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      displayObject.removeEventListener("click", handleClick);
	 */
	function removeEventListener(type:String, listener:Dynamic, ?useCapture:Bool) : Void;
	/**
	 * A shortcut to the removeEventListener method, with the same parameters and return value. This is a companion to the
	 * .on method.
	 */
	function off(type:String, listener:Dynamic, ?useCapture:Bool) : Void;
	/**
	 * Removes all listeners for the specified type, or all listeners of all types.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      // Remove all listeners
	 *      displayObject.removeAllEvenListeners();
	 * 
	 *      // Remove all click listeners
	 *      displayObject.removeAllEventListeners("click");
	 */
	function removeAllEventListeners(?type:String) : Void;
	/**
	 * Dispatches the specified event to all listeners.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      // Use a string event
	 *      this.dispatchEvent("complete");
	 * 
	 *      // Use an Event instance
	 *      var event = new createjs.Event("progress");
	 *      this.dispatchEvent(event);
	 */
	function dispatchEvent(eventObj:Dynamic, ?target:Dynamic) : Bool;
	/**
	 * Indicates whether there is at least one listener for the specified event type and `useCapture` value.
	 */
	function hasEventListener(type:String) : Bool;
	function toString() : String;

	/**
	 * Dispatched each tick. The event will be dispatched to each listener even when the Ticker has been paused using
	 * {{#crossLink "Ticker/setPaused"}}{{/crossLink}}.
	 * 
	 * <h4>Example</h4>
	 *      createjs.Ticker.addEventListener("tick", handleTick);
	 *      function handleTick(event) {
	 *          console.log("Paused:", event.paused, event.delta);
	 *      }
	 */
	inline function addTickEventListener(handler:TickerTickEvent->Void) : Dynamic return addEventListener("tick", handler);
}