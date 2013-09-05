package createjs.events;

/**
* EventDispatcher provides methods for managing queues of event listeners and dispatching events.
*	
*	You can either extend EventDispatcher or mix its methods into an existing prototype or instance by using the
*	EventDispatcher {{#crossLink "EventDispatcher/initialize"}}{{/crossLink}} method.
*	
*	Together with the CreateJS Event class, EventDispatcher provides an extended event model that is based on the
*	DOM Level 2 event model, including addEventListener, removeEventListener, and dispatchEvent. It supports
*	bubbling / capture, preventDefault, stopPropagation, stopImmediatePropagation, and handleEvent.
*	
*	EventDispatcher also exposes a {{#crossLink "EventDispatcher/on"}}{{/crossLink}} method, which makes it easier
*	to create scoped listeners, listeners that only run once, and listeners with associated arbitrary data. The 
*	{{#crossLink "EventDispatcher/off"}}{{/crossLink}} method is merely an alias to
*	{{#crossLink "EventDispatcher/removeEventListener"}}{{/crossLink}}.
*	
*	Another addition to the DOM Level 2 model is the {{#crossLink "EventDispatcher/removeAllEventListeners"}}{{/crossLink}}
*	method, which can be used to listeners for all events, or listeners for a specific event. The Event object also 
*	includes a {{#crossLink "Event/remove"}}{{/crossLink}} method which removes the active listener.
*	
*	<h4>Example</h4>
*	Add EventDispatcher capabilities to the "MyClass" class.
*	
*	     EventDispatcher.initialize(MyClass.prototype);
*	
*	Add an event (see {{#crossLink "EventDispatcher/addEventListener"}}{{/crossLink}}).
*	
*	     instance.addEventListener("eventName", handlerMethod);
*	     function handlerMethod(event) {
*	         console.log(event.target + " Was Clicked");
*	     }
*	
*	<b>Maintaining proper scope</b><br />
*	Scope (ie. "this") can be be a challenge with events. Using the {{#crossLink "EventDispatcher/on"}}{{/crossLink}}
*	method to subscribe to events simplifies this.
*	
*	     instance.addEventListener("click", function(event) {
*	         console.log(instance == this); // false, scope is ambiguous.
*	     });
*	     
*	     instance.on("click", function(event) {
*	         console.log(instance == this); // true, "on" uses dispatcher scope by default.
*	     });
*	
*	If you want to use addEventListener instead, you may want to use function.bind() or a similar proxy to manage scope.
*/
@:native("createjs.EventDispatcher")
extern class EventDispatcher
{
}
