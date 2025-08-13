### Make a simple 3D game with WebGL library, with gravity and collisions in less than 300 lines of code. by max123
### 04/19/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166075/)

Hi all,  
  
this code will show how to make a simple 3D game, with gravity and collisions by code without use any physics engine.  
  
I want to remember that with WebGL library you can use more than one integrated (or non integrated) physics engines, like [cannon-es](https://pmndrs.github.io/cannon-es/), [ammo.js](https://github.com/kripken/ammo.js?tab=readme-ov-file), [rapier](https://rapier.rs/) and more others, this simplifies the work while creating 3D scenes where you have to simulate gravity, collisions, joints, cloth and more. Note that you can show online demos of each physic engine in the links I've provided, all these demos will work on WebGL library.  
  
The main goal of this tutorial is to show how you can do some physics, like gravity and collisions by yourself without use any physics engines at all.  
  
The base code of this tutorial is not mine, but I found it on the web, take a look here:  
[MEDIA=youtube]sPereCgQnWQ[/MEDIA]  
  
After I followed all this clear video tutorial, I started from his code and changed it by adding some other things, like the sky background, the fog, OrbitControls and more.  
I advice you to follow the good video tutorial that explain in a simple way this code line by line.  
  
To have this project working, ensure you have the latest jWebGL library (v1.24) from here and follow the simple onetime library configuration:  
<https://www.b4x.com/android/forum/threads/b4j-webgl-library.164553/>  
  
This simple game even will work on Android with B4A WebGL library I release next days, at least, it worked well on Android Emulator and Android x86 on VirtualBox.  
Unfortunately I only have old physical android devices that do not support WebGL, so I cannot try it other ways, but if it works on Emulator with Android 13 I think it will work on your device.  
  
Using android there is just a small thing here, differently than desktop side, you cannot access the keyboard to control the game, but you can do it if you use a bluetooth or USB keyboard connected with OTG cable. Or may you can just use Android keyboard, but it will take up a good part of the screen, or may just put some buttons that simulate the keyboard pressed keys.  
For OrbitControls there's no problems on Android, instead of mouse it will be all touch, so just use one finger to rotate, 2 fingers to zoom in/out, move two fingers to pan.  
  
A variant of this simple game can use my GamepadControls (a bit experimental JS class) that permits to recognize up 4 gamepads and read all buttons and analog sticks of each.  
It will work both with BT BLE and USB gamepads and even with custom gamepads (over BT BLE) created with ESP32 with ESP32BLEGamepad or similar libraries.  
  
**The goal of this tutorial**  

- Show you how simple is creating a simple 3D game using WebGL library, it will work on desktop (PC, RPI, even Android over browser) and on Android natively and even exposed over HTTP at same time, and multiclient
- Show you how to control things in realtime using the keyboard and mouse to rotate, zoom, pan the scene
- Show you how use a cubic map (6 images) to get the sky or any other 3D background environment
- Show you how to use shadows, this is a simple variant on next tutorials I will show how to use more detailed shadows
- Show you how position the light in a way that reflect the sun position in the background sky, you can show the light helper that help you to know the light position and direction
- Show you how calculate gravity and collisions by code without use of any physic engine
- Show you how create a custom geometry class
- Show you how it is simple now import in the project some resources by just zip these, copy/paste the zip file (in this case sky.zip) to Asset folder and use just one library command to do all work in a simple way

**How to use the game**  
  
You are a green cube, you have to avoid other random generated cubes, use keyboard WASD keys to move the cube up, left, bottom, right, combination of these can be used, so you can eg. move vertical up-right, up-left, down-right, down-left. While you are on the blue plane (suppose the ground) points will increase. You can even use SPACE bar to jump (even repeatedly), this will avoid collisions with other cubes, but while you jump, you do not collect points. When you collide with any other cube you reach the GAME OVER.  
  
You can use the mouse to zoom, rotate and pan the scene, in particular, if you want to see it better, try to move your green cube outside the ground panel, right or left, so that it falls. At this point, since a collision with other cubes cannot occur, the game will no longer make sense, but you can rotate the scene at your leisure without having to refresh the page. I purposely omitted that if the green cube falls, the end of the game is not called, precisely to be able to do this. Normally you have to put it in a way that if green cube falls from blue ground it call a GAME OVER.  
  
Now here we just used cubes to simplify the code, but you can even use static or animated 3D models about 30 formats are supported, but the more optimized are GLTF.  
You can find a tons of static and animated models, free or paid 3D models on more sites on the web, one of most common is <https://sketchfab.com/>  
  
Next I will show you how to make simple FPS and Flight simulator games with more complex scenes, so stay tuned.  
  
I hope you like.  
Enjoy it !!!