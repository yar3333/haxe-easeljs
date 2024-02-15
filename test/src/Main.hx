import haxe.Timer;
import js.Browser;
import js.html.CanvasElement;
import easeljs.geom.Matrix2D;
import easeljs.display.Shape;
import easeljs.display.Stage;

class Main
{
	static public function main()
	{
		var canvas : CanvasElement = cast Browser.document.getElementById("nanoFL_canvas");
		
		var stage = new Stage(canvas);
		
		var shape = new Shape();
		stage.addChild(shape);
		
		shape.graphics
			.beginStroke("red")
			.rect(-100, -50, 200, 100)
			.endStroke();
			
		shape.x = 200;
		shape.y = 200;
		
		var timer = new Timer(50);
		timer.run = function()
		{
			var matrix = shape.getMatrix();
			var m = new Matrix2D().appendTransform(0, 0, 1, 1, 1, 0, 0);
			matrix.appendMatrix(m);
			shape.set(matrix.decompose());
			stage.update();
		};
	}
}
