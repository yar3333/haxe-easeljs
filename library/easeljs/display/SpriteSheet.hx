package easeljs.display;

/**
* Encapsulates the properties and methods associated with a sprite sheet. A sprite sheet is a series of images (usually
*	animation frames) combined into a larger image (or images). For example, an animation consisting of eight 100x100
*	images could be combined into a single 400x200 sprite sheet (4 frames across by 2 high).
*	
*	The data passed to the SpriteSheet constructor defines three critical pieces of information:<ol>
*	   <li> The image or images to use.</li>
*	   <li> The positions of individual image frames. This data can be represented in one of two ways:
*	   As a regular grid of sequential, equal-sized frames, or as individually defined, variable sized frames arranged in
*	   an irregular (non-sequential) fashion.</li>
*	   <li> Likewise, animations can be represented in two ways: As a series of sequential frames, defined by a start and
*	   end frame [0,3], or as a list of frames [0,1,2,3].</li>
*	</OL>
*	
*	<h4>SpriteSheet Format</h4>
*	
*	     data = {
*	         // DEFINING FRAMERATE:
*	         // this specifies the framerate that will be set on the SpriteSheet. See Spritesheet.framerate
*	         // for more information.
*	         framerate: 20,
*	
*	         // DEFINING IMAGES:
*	         // list of images or image URIs to use. SpriteSheet can handle preloading.
*	         // the order dictates their index value for frame definition.
*	         images: [image1, "path/to/image2.png"],
*	
*	         // DEFINING FRAMES:
*		        // the simple way to define frames, only requires frame size because frames are consecutive:
*		        // define frame width/height, and optionally the frame count and registration point x/y.
*		        // if count is omitted, it will be calculated automatically based on image dimensions.
*		        frames: {width:64, height:64, count:20, regX: 32, regY:64},
*	
*		        // OR, the complex way that defines individual rects for frames.
*		        // The 5th value is the image index per the list defined in "images" (defaults to 0).
*		        frames: [
*		        	// x, y, width, height, imageIndex, regX, regY
*		        	[0,0,64,64,0,32,64],
*		        	[64,0,96,64,0]
*		        ],
*	
*	         // DEFINING ANIMATIONS:
*	
*		        // simple animation definitions. Define a consecutive range of frames (begin to end inclusive).
*		        // optionally define a "next" animation to sequence to (or false to stop) and a playback "speed"
*		        animations: {
*		        	// start, end, next, speed
*		        	run: [0,8],
*		        	jump: [9,12,"run",2]
*		        }
*	
*	         // the complex approach which specifies every frame in the animation by index.
*	         animations: {
*	         	run: {
*	         		frames: [1,2,3,3,2,1]
*	         	},
*	         	jump: {
*	         		frames: [1,4,5,6,1],
*	         		next: "run",
*	         		speed: 2
*	         	},
*	         	stand: { frames: [7] }
*	         }
*	
*		        // the above two approaches can be combined, you can also use a single frame definition:
*		        animations: {
*		        	run: [0,8,true,2],
*		        	jump: {
*		        		frames: [8,9,10,9,8],
*		        		next: "run",
*		        		speed: 2
*		        	},
*		        	stand: 7
*		        }
*	     }
*	
*	<h4>Example</h4>
*	To define a simple sprite sheet, with a single image "sprites.jpg" arranged in a regular 50x50 grid with two
*	animations, "run" looping from frame 0-4 inclusive, and "jump" playing from frame 5-8 and sequencing back to run:
*	
*	     var data = {
*	         images: ["sprites.jpg"],
*	         frames: {width:50, height:50},
*	         animations: {run:[0,4], jump:[5,8,"run"]}
*	     };
*	     var spriteSheet = new createjs.SpriteSheet(data);
*	     var animation = new createjs.Sprite(spriteSheet, "run");
*/
@:native("easeljs.SpriteSheet")
extern class SpriteSheet extends EventDispatcher
{
}
