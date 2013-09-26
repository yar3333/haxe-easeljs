convert:
	yuidoc -p -o out native/src
	neko yuidoc2haxe.n out/data.json library native/src
