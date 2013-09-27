convert:
	yuidoc -p -o out native/src
	neko yuidoc2haxe.n -ifile easeljs/version_movieclip.js -ifile easeljs/version.js -rpp native/src -src out/data.json --public-prefix --native-package createjs library
