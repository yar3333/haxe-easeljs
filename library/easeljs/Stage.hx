package easeljs;

/**
 * A stage is the root level {{#crossLink "Container"}}{{/crossLink}} for a display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
 * method is called, it will render its display list to its target canvas.
 * 
 * <h4>Example</h4>
 * This example creates a stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
 * and redraw the stage using {{#crossLink "Stage/update"}}{{/crossLink}}.
 * 
 *      var stage = new createjs.Stage("canvasElementId");
 *      var image = new createjs.Bitmap("imagePath.png");
 *      stage.addChild(image);
 *      createjs.Ticker.addEventListener("tick", handleTick);
 *      function handleTick(event) {
 *          image.x += 10;
 *          stage.update();
 *      }
 */
@:native("createjs.Stage")
extern class Stage extends Container
{
	/**
	 * Indicates whether the stage should automatically clear the canvas before each render. You can set this to <code>false</code>
	 * to manually control clearing (for generative art, or when pointing multiple stages at the same canvas for
	 * example).
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var stage = new createjs.Stage("canvasId");
	 *      stage.autoClear = false;
	 */
	var autoClear : Bool;
	/**
	 * The canvas the stage will render to. Multiple stages can share a single canvas, but you must disable autoClear for all but the
	 * first stage that will be ticked (or they will clear each other's render).
	 * 
	 * When changing the canvas property you must disable the events on the old canvas, and enable events on the
	 * new canvas or mouse events will not work as expected. For example:
	 * 
	 *      myStage.enableDOMEvents(false);
	 *      myStage.canvas = anotherCanvas;
	 *      myStage.enableDOMEvents(true);
	 */
	var canvas : Dynamic;
	/**
	 * The current mouse X position on the canvas. If the mouse leaves the canvas, this will indicate the most recent
	 * position over the canvas, and mouseInBounds will be set to false.
	 */
	var mouseX : Float;
	/**
	 * The current mouse Y position on the canvas. If the mouse leaves the canvas, this will indicate the most recent
	 * position over the canvas, and mouseInBounds will be set to false.
	 */
	var mouseY : Float;
	/**
	 * Indicates whether the mouse is currently within the bounds of the canvas.
	 */
	var mouseInBounds : Bool;
	/**
	 * If true, tick callbacks will be called on all display objects on the stage prior to rendering to the canvas.
	 */
	var tickOnUpdate : Bool;
	/**
	 * If true, mouse move events will continue to be called when the mouse leaves the target canvas. See
	 * {{#crossLink "Stage/mouseInBounds:property"}}{{/crossLink}}, and {{#crossLink "MouseEvent"}}{{/crossLink}}
	 * x/y/rawX/rawY.
	 */
	var mouseMoveOutside : Bool;
	/**
	 * NOTE: this name is not final. Feedback is appreciated.
	 * 
	 * The stage assigned to this property will have mouse interactions relayed to it after this stage handles them.
	 * This can be useful in cases where you have multiple canvases layered on top of one another and want your mouse
	 * events to pass through. For example, this would relay mouse events from topStage to bottomStage:
	 * 
	 *      topStage.nextStage = bottomStage;
	 * 
	 * Note that each stage handles the interactions independently. As such, you could have a click register on an
	 * object in the top stage, and another click register in the bottom stage. Consider using a single canvas with
	 * cached {{#crossLink "Container"}}{{/crossLink}} instances instead of multiple canvases.
	 * 
	 * MouseOver, MouseOut, RollOver, and RollOut interactions will not be passed through. They must be enabled using
	 * {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}} for each stage individually.
	 * 
	 * In most instances, you will also want to disable DOM events for the next stage to avoid duplicate interactions.
	 * myNextStage.enableDOMEvents(false);
	 */
	var nextStage : Stage;
	/**
	 * Default event handler that calls the Stage {{#crossLink "Stage/update"}}{{/crossLink}} method when a {{#crossLink "DisplayObject/tick:event"}}{{/crossLink}}
	 * event is received. This allows you to register a Stage instance as a event listener on {{#crossLink "Ticker"}}{{/crossLink}}
	 * directly, using:
	 * 
	 *      Ticker.addEventListener("tick", myStage");
	 * 
	 * Note that if you subscribe to ticks using this pattern, then the tick event object will be passed through to
	 * display object tick handlers, instead of <code>delta</code> and <code>paused</code> parameters.
	 */
	var handleEvent : Dynamic;

	function new(canvas:Dynamic) : Void;

	/**
	 * Each time the update method is called, the stage will tick all descendants (see: {{#crossLink "DisplayObject/tick"}}{{/crossLink}})
	 * and then render the display list to the canvas. Any parameters passed to `update()` will be passed on to any
	 * {{#crossLink "DisplayObject/tick:event"}}{{/crossLink}} event handlers.
	 * 
	 * Some time-based features in EaselJS (for example {{#crossLink "Sprite/framerate"}}{{/crossLink}} require that
	 * a tick event object (or equivalent) be passed as the first parameter to update(). For example:
	 * 
	 *      Ticker.addEventListener("tick", handleTick);
	 * 	    function handleTick(evtObj) {
	 * 	     	// do some work here, then update the stage, passing through the event object:
	 * 	    	myStage.update(evtObj);
	 * 	    }
	 */
	function update(?params:Dynamic) : Void;
	/**
	 * Clears the target canvas. Useful if {{#crossLink "Stage/autoClear:property"}}{{/crossLink}} is set to `false`.
	 */
	function clear() : Void;
	/**
	 * Returns a data url that contains a Base64-encoded image of the contents of the stage. The returned data url can
	 * be specified as the src value of an image element.
	 */
	function toDataURL(backgroundColor:String, mimeType:String) : String;
	/**
	 * Enables or disables (by passing a frequency of 0) mouse over ({{#crossLink "DisplayObject/mouseover:event"}}{{/crossLink}}
	 * and {{#crossLink "DisplayObject/mouseout:event"}}{{/crossLink}}) and roll over events ({{#crossLink "DisplayObject/rollover:event"}}{{/crossLink}}
	 * and {{#crossLink "DisplayObject/rollout:event"}}{{/crossLink}}) for this stage's display list. These events can
	 * be expensive to generate, so they are disabled by default. The frequency of the events can be controlled
	 * independently of mouse move events via the optional `frequency` parameter.
	 * 
	 * <h4>Example</h4>
	 *      var stage = new createjs.Stage("canvasId");
	 *      stage.enableMouseOver(10); // 10 updates per second
	 */
	function enableMouseOver(?frequency:Float) : Void;
	/**
	 * Enables or disables the event listeners that stage adds to DOM elements (window, document and canvas). It is good
	 * practice to disable events when disposing of a Stage instance, otherwise the stage will continue to receive
	 * events from the page.
	 * 
	 * When changing the canvas property you must disable the events on the old canvas, and enable events on the
	 * new canvas or mouse events will not work as expected. For example:
	 * 
	 *      myStage.enableDOMEvents(false);
	 *      myStage.canvas = anotherCanvas;
	 *      myStage.enableDOMEvents(true);
	 */
	function enableDOMEvents(?enable:Bool) : Void;
	/**
	 * Returns a clone of this Stage.
	 */
	override function clone(?recursive:Bool) : DisplayObject;
	/**
	 * Returns a string representation of this object.
	 */
	override function toString() : String;

	/**
	 * Dispatched when the user moves the mouse over the canvas.
	 * See the {{#crossLink "MouseEvent"}}{{/crossLink}} class for a listing of event properties.
	 */
	inline function addStagemousemoveEventListener(handler:MouseEvent->Void) : Dynamic return addEventListener("stagemousemove", handler);
	/**
	 * Dispatched when the user presses their left mouse button on the canvas. See the {{#crossLink "MouseEvent"}}{{/crossLink}}
	 * class for a listing of event properties.
	 */
	inline function addStagemousedownEventListener(handler:MouseEvent->Void) : Dynamic return addEventListener("stagemousedown", handler);
	/**
	 * Dispatched when the user the user releases the mouse button anywhere that the page can detect it (this varies slightly between browsers).
	 * See the {{#crossLink "MouseEvent"}}{{/crossLink}} class for a listing of event properties.
	 */
	inline function addStagemouseupEventListener(handler:MouseEvent->Void) : Dynamic return addEventListener("stagemouseup", handler);
	/**
	 * Dispatched when the mouse moves from within the canvas area (mouseInBounds == true) to outside it (mouseInBounds == false).
	 * This is currently only dispatched for mouse input (not touch). See the {{#crossLink "MouseEvent"}}{{/crossLink}}
	 * class for a listing of event properties.
	 */
	inline function addMouseleaveEventListener(handler:MouseEvent->Void) : Dynamic return addEventListener("mouseleave", handler);
	/**
	 * Dispatched when the mouse moves into the canvas area (mouseInBounds == false) from outside it (mouseInBounds == true).
	 * This is currently only dispatched for mouse input (not touch). See the {{#crossLink "MouseEvent"}}{{/crossLink}}
	 * class for a listing of event properties.
	 */
	inline function addMouseenterEventListener(handler:MouseEvent->Void) : Dynamic return addEventListener("mouseenter", handler);
	/**
	 * Dispatched each update immediately before the tick event is propagated through the display list. Does not fire if
	 * tickOnUpdate is false.
	 */
	inline function addTickstartEventListener(handler:Dynamic->Void) : Dynamic return addEventListener("tickstart", handler);
	/**
	 * Dispatched each update immediately after the tick event is propagated through the display list. Does not fire if
	 * tickOnUpdate is false. Precedes the "drawstart" event.
	 */
	inline function addTickendEventListener(handler:Dynamic->Void) : Dynamic return addEventListener("tickend", handler);
	/**
	 * Dispatched each update immediately before the canvas is cleared and the display list is drawn to it.
	 */
	inline function addDrawstartEventListener(handler:Dynamic->Void) : Dynamic return addEventListener("drawstart", handler);
	/**
	 * Dispatched each update immediately after the display list is drawn to the canvas and the canvas context is restored.
	 */
	inline function addDrawendEventListener(handler:Dynamic->Void) : Dynamic return addEventListener("drawend", handler);
}