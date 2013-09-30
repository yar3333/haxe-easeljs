OPTIONS+= -src out/data.json
OPTIONS+= --remove-path-prefix native/src
OPTIONS+= -ifile easeljs/version_movieclip.js
OPTIONS+= -ifile easeljs/version.js
OPTIONS+= -iitem initialize
OPTIONS+= -iitem Stage.hitArea
OPTIONS+= --native-package createjs
OPTIONS+= --type-map HTMLElement-js.html.Element
OPTIONS+= --type-map HTMLCanvasElement-js.html.CanvasElement
OPTIONS+= --type-map CanvasRenderingContext2D-js.html.CanvasRenderingContext2D
OPTIONS+= --type-map Image-js.html.Image

convert:
	yuidoc -p -o out native/src
	neko yuidoc2haxe.n $(OPTIONS) library
