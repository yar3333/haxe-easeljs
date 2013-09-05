package easeljs.utils;

/**
* The Ticker provides  a centralized tick or heartbeat broadcast at a set interval. Listeners can subscribe to the tick
*	event to be notified when a set time interval has elapsed.
*	
*	Note that the interval that the tick event is called is a target interval, and may be broadcast at a slower interval
*	during times of high CPU load. The Ticker class uses a static interface (ex. <code>Ticker.getPaused()</code>) and
*	should not be instantiated.
*	
*	<h4>Example</h4>
*	     createjs.Ticker.addEventListener("tick", handleTick);
*	     function handleTick(event) {
*	         // Actions carried out each frame
*	         if (!event.paused) {
*	             // Actions carried out when the Ticker is not paused.
*	         }
*	     }
*	
*	To update a stage every tick, the {{#crossLink "Stage"}}{{/crossLink}} instance can also be used as a listener, as
*	it will automatically update when it receives a tick event:
*	
*	     createjs.Ticker.addEventListener("tick", stage);
*/
@:native("easeljs.Ticker")
extern class Ticker
{
}
