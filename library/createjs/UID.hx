package createjs;

/**
 * Global utility for generating sequential unique ID numbers. The UID class uses a static interface (ex. <code>UID.get()</code>)
 * and should not be instantiated.
 */
extern class UID
{
	/**
	 * Returns the next unique id.
	 */
	static function get() : Int;
}