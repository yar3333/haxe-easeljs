package easeljs;

/**
 * This is passed as the parameter to all mouse/pointer/touch related events on {{#crossLink "DisplayObject"}}{{/crossLink}}
 * instances.
 */
@:native("createjs.MouseEvent")
extern class MouseEvent extends createjs.Event
{
	/**
	 * The normalized x position on the stage. This will always be within the range 0 to stage width.
	 */
	var stageX : Float;
	/**
	 * The normalized y position on the stage. This will always be within the range 0 to stage height.
	 */
	var stageY : Float;
	/**
	 * The raw x position relative to the stage. Normally this will be the same as the stageX value, unless
	 * stage.mouseMoveOutside is true and the pointer is outside of the stage bounds.
	 */
	var rawX : Float;
	/**
	 * The raw y position relative to the stage. Normally this will be the same as the stageY value, unless
	 * stage.mouseMoveOutside is true and the pointer is outside of the stage bounds.
	 */
	var rawY : Float;
	/**
	 * The native MouseEvent generated by the browser. The properties and API for this
	 * event may differ between browsers. This property will be null if the
	 * EaselJS property was not directly generated from a native MouseEvent.
	 */
	var nativeEvent : js.html.MouseEvent;
	/**
	 * The unique id for the pointer (touch point or cursor). This will be either -1 for the mouse, or the system
	 * supplied id value.
	 */
	var pointerID : Float;
	/**
	 * Indicates whether this is the primary pointer in a multitouch environment. This will always be true for the mouse.
	 * For touch pointers, the first pointer in the current stack will be considered the primary pointer.
	 */
	var primary : Bool;

	function new(type:String, bubbles:Bool, cancelable:Bool, stageX:Float, stageY:Float, nativeEvent:easeljs.MouseEvent, pointerID:Float, primary:Bool, rawX:Float, rawY:Float) : Void;

	/**
	 * Returns a string representation of this object.
	 */
	override function toString() : String;
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
}