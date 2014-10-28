OPTIONS+= -src out/data.json
OPTIONS+= --remove-path-prefix native/src
OPTIONS+= -ifile easeljs/version_movieclip.js
OPTIONS+= -ifile easeljs/version.js
OPTIONS+= -ifile createjs/utils/IndexOf.js 
OPTIONS+= -iitem initialize
OPTIONS+= -iitem Stage.hitArea
OPTIONS+= --native-package createjs
OPTIONS+= --type-map HTMLElement-js.html.Element
OPTIONS+= --type-map HTMLCanvasElement-js.html.CanvasElement
OPTIONS+= --type-map CanvasRenderingContext2D-js.html.CanvasRenderingContext2D
OPTIONS+= --type-map Image-Dynamic
OPTIONS+= --type-map HtmlMouseEvent-js.html.MouseEvent
OPTIONS+= --type-map Timeline-tweenjs.Timeline
OPTIONS+= --type-map Tween-tweenjs.Tween

convert:
	yuidoc -p -o out native/src
	haxelib run yuidoc2haxe $(OPTIONS) library
	haxelib run refactor processFile library/easeljs/Ticker.hx postprocessTicker.rules
