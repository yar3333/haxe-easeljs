package easeljs.display;

/**
* The Graphics class exposes an easy to use API for generating vector drawing instructions and drawing them to a
*	specified context. Note that you can use Graphics without any dependency on the Easel framework by calling {{#crossLink "DisplayObject/draw"}}{{/crossLink}}
*	directly, or it can be used with the {{#crossLink "Shape"}}{{/crossLink}} object to draw vector graphics within the
*	context of an Easel display list.
*	
*	<h4>Example</h4>
*	     var g = new createjs.Graphics();
*		    g.setStrokeStyle(1);
*		    g.beginStroke(createjs.Graphics.getRGB(0,0,0));
*		    g.beginFill(createjs.Graphics.getRGB(255,0,0));
*		    g.drawCircle(0,0,3);
*	
*		    var s = new createjs.Shape(g);
*		    	s.x = 100;
*		    	s.y = 100;
*	
*		    stage.addChild(s);
*		    stage.update();
*	
*	Note that all drawing methods in Graphics return the Graphics instance, so they can be chained together. For example,
*	the following line of code would generate the instructions to draw a rectangle with a red stroke and blue fill, then
*	render it to the specified context2D:
*	
*	     myGraphics.beginStroke("#F00").beginFill("#00F").drawRect(20, 20, 100, 50).draw(myContext2D);
*	
*	<h4>Tiny API</h4>
*	The Graphics class also includes a "tiny API", which is one or two-letter methods that are shortcuts for all of the
*	Graphics methods. These methods are great for creating compact instructions, and is used by the Toolkit for CreateJS
*	to generate readable code. All tiny methods are marked as protected, so you can view them by enabling protected
*	descriptions in the docs.
*	
*	<table>
*	    <tr><td><b>Tiny</b></td><td><b>Method</b></td><td><b>Tiny</b></td><td><b>Method</b></td></tr>
*	    <tr><td>mt</td><td>{{#crossLink "Graphics/moveTo"}}{{/crossLink}} </td>
*	    <td>lt</td> <td>{{#crossLink "Graphics/lineTo"}}{{/crossLink}}</td></tr>
*	    <tr><td>a/at</td><td>{{#crossLink "Graphics/arc"}}{{/crossLink}} / {{#crossLink "Graphics/arcTo"}}{{/crossLink}} </td>
*	    <td>bt</td><td>{{#crossLink "Graphics/bezierCurveTo"}}{{/crossLink}} </td></tr>
*	    <tr><td>qt</td><td>{{#crossLink "Graphics/quadraticCurveTo"}}{{/crossLink}} (also curveTo)</td>
*	    <td>r</td><td>{{#crossLink "Graphics/rect"}}{{/crossLink}} </td></tr>
*	    <tr><td>cp</td><td>{{#crossLink "Graphics/closePath"}}{{/crossLink}} </td>
*	    <td>c</td><td>{{#crossLink "Graphics/clear"}}{{/crossLink}} </td></tr>
*	    <tr><td>f</td><td>{{#crossLink "Graphics/beginFill"}}{{/crossLink}} </td>
*	    <td>lf</td><td>{{#crossLink "Graphics/beginLinearGradientFill"}}{{/crossLink}} </td></tr>
*	    <tr><td>rf</td><td>{{#crossLink "Graphics/beginRadialGradientFill"}}{{/crossLink}} </td>
*	    <td>bf</td><td>{{#crossLink "Graphics/beginBitmapFill"}}{{/crossLink}} </td></tr>
*	    <tr><td>ef</td><td>{{#crossLink "Graphics/endFill"}}{{/crossLink}} </td>
*	    <td>ss</td><td>{{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} </td></tr>
*	    <tr><td>s</td><td>{{#crossLink "Graphics/beginStroke"}}{{/crossLink}} </td>
*	    <td>ls</td><td>{{#crossLink "Graphics/beginLinearGradientStroke"}}{{/crossLink}} </td></tr>
*	    <tr><td>rs</td><td>{{#crossLink "Graphics/beginRadialGradientStroke"}}{{/crossLink}} </td>
*	    <td>bs</td><td>{{#crossLink "Graphics/beginBitmapStroke"}}{{/crossLink}} </td></tr>
*	    <tr><td>es</td><td>{{#crossLink "Graphics/endStroke"}}{{/crossLink}} </td>
*	    <td>dr</td><td>{{#crossLink "Graphics/drawRect"}}{{/crossLink}} </td></tr>
*	    <tr><td>rr</td><td>{{#crossLink "Graphics/drawRoundRect"}}{{/crossLink}} </td>
*	    <td>rc</td><td>{{#crossLink "Graphics/drawRoundRectComplex"}}{{/crossLink}} </td></tr>
*	    <tr><td>dc</td><td>{{#crossLink "Graphics/drawCircle"}}{{/crossLink}} </td>
*	    <td>de</td><td>{{#crossLink "Graphics/drawEllipse"}}{{/crossLink}} </td></tr>
*	    <tr><td>dp</td><td>{{#crossLink "Graphics/drawPolyStar"}}{{/crossLink}} </td>
*	    <td>p</td><td>{{#crossLink "Graphics/decodePath"}}{{/crossLink}} </td></tr>
*	</table>
*	
*	Here is the above example, using the tiny API instead.
*	
*	     myGraphics.s("#F00").f("#00F").r(20, 20, 100, 50).draw(myContext2D);
*/
@:native("easeljs.Graphics")
extern class Graphics
{
}
