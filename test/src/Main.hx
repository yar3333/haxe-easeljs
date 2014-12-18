import easeljs.Shape;
import easeljs.Stage;
import easeljs.Matrix2D;
import haxe.Timer;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;

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
			.rect(-100, -50, 100, 50)
			.endStroke();
			
		shape.x = 200;
		shape.y = 200;
		
		var timer = new Timer(50);
		timer.run = function()
		{
			var matrix = shape.getMatrix();
			
			var m = new Matrix2D()
				//.translate(-200, -200)
				.rotate(1);
				//.translate(200, 200);
			
			matrix.prependMatrix(m);
			//matrix.appendMatrix(m);
			shape.set(matrix.decompose());
			
			stage.update();
		};
	}
}
