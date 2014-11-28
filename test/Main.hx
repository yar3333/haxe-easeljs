import easeljs.Bitmap;
import easeljs.ColorFilter;
import easeljs.Stage;
import js.Browser;
import js.html.CanvasElement;
import js.html.Image;

class Main
{
	static public function main()
	{
		var canvas : CanvasElement = cast Browser.document.getElementById("nanoFL_canvas");
		
		var stage = new Stage(canvas);
		
		var img = new Image();
		img.onload = function(_)
		{
			var bmp = new Bitmap(img);
			
			bmp.filters = [ new ColorFilter(1, 1, 1, 1, 255, 0, 0) ];
			bmp.cache(0, 0, 100, 100);
			
			stage.addChild(bmp);
			
			stage.update();
			
		};
		img.src = 'фон1 copy 2.png';
	}
}
