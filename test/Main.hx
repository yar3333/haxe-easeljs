import easeljs.Shape;
import easeljs.Stage;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;

class MyShape extends Shape
{
	override public function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool 
	{
		trace("draw cacheCanvas = " + (cacheCanvas != null) + "; ignoreCache = " + ignoreCache);
		
		if (cacheCanvas == null)
		{
			trace("cache");
			cache(0, 0, 100, 100);
		}
		
		trace("inner draw cacheCanvas = " + (cacheCanvas != null) + "; ignoreCache = " + ignoreCache);
		return super.draw(ctx, ignoreCache);
	}
}

class Main
{
	static public function main()
	{
		var canvas : CanvasElement = cast Browser.document.getElementById("nanoFL_canvas");
		
		var stage = new Stage(canvas);
		
		var shape = new MyShape();
		stage.addChild(shape);
		
		shape.graphics
			.beginStroke("red")
			.moveTo(0, 0)
			.lineTo(100, 100)
			.endStroke();
		
		trace("update");
		stage.update();
	}
}
