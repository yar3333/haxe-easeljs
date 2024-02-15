OPTIONS+= -src out/data.json
OPTIONS+= --remove-path-prefix native
OPTIONS+= --native-package createjs
OPTIONS+= --apply-native-package

OPTIONS+= -ifile easeljs/version_movieclip.js
OPTIONS+= -ifile easeljs/version.js
OPTIONS+= -ifile createjs/utils/indexOf.js 
OPTIONS+= -ifile createjs/utils/extend.js 
OPTIONS+= -ifile createjs/utils/promote.js 

OPTIONS+= -iitem initialize
OPTIONS+= -iitem Filter._applyFilter
OPTIONS+= -iclass Graphics.*

OPTIONS+= --type-map HTMLElement-js.html.Element
OPTIONS+= --type-map HTMLCanvasElement-js.html.CanvasElement
OPTIONS+= --type-map CanvasRenderingContext2D-js.html.CanvasRenderingContext2D
OPTIONS+= --type-map Image-Dynamic
OPTIONS+= --type-map HtmlMouseEvent-js.html.MouseEvent

convert:
	yuidoc -p -o out native
	haxelib run yuidoc2haxe $(OPTIONS) library
	rm -r out
	haxelib run refactor process library *.hx postprocess.rules
