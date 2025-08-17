### WebGL library, working with static and animated models by max123
### 04/11/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166523/)

Hello everyone,  
  
a proverb says 'when the going gets tough, the tough get going'.  
  
On this direction, up to now I have posted simple demonstrations of what you can do with the WebGL library.  
If you are passionate about 3D graphics, what you will see from this time and in the next demonstrations I ensure will impress you and make you understand once again the power of this library.  
  
In this demo in particular I will show you how to load static and/or animated detailed 3D models that do realistic actions. Every model have textures applied and auto mapped.  
  
Each model will have none, just one, or many animations, actions that the model (let's call it an Actor) can perform (let's call it an Action).  
  
When you load an Actor with animations you can decide what Action it should perform, for example, a man could walk, run, sit and many other things.  
In this sense it is possible to decide various things via code, first of all what action an Actor should perform, at what speed, whether to use a loop and other things.  
  
What is important to note is that each Action of an Actor is completely independent from the actions of the other actors in the scene, so we could for example speed up, or slow down the action of an actor without influencing that of the other actors at all.  
  
Someone will wonder how Actors can have one or more animations… This is a legitimate question.  
This is generally done on a CAD program before exporting a 3D model. CAD programs allow you to create a skeleton of the model so that you can then make it do various actions and animate them.  
  
You don't necessarily have to use a CAD to do this, there are some websites where you can choose from hundreds of Actors and hundreds of Actions and then download the models depending on what you need. For example, if you want a girl dancing salsa, you will choose the actor from different possible girl models, then you will select a dance action and precisely salsa, finally you will download the model with one or more animations. One of the most popular sites to do this is [https://www.mixamo.com](https://www.mixamo.com/#/?page=1&type=Character), you can also find really good detailed static or animated, free or paid 3D models on <https://sketchfab.com>, may just tap the Animations only models filter, so only animated models will be searched.  
  
The user can list by code all actions saved in the model, so decide what actions the model exposes, and play them.  
  
This demo code also shows how to simulate a cloth by code, with a custom class that simplifies the work, in this case I used a cloth with the B4X logo on it, it is simply a texture. If it is in PNG format, you can also use the Alpha channel for transparency. Note that the cloth and the wind are calculated via software in real time and it is possible to modify various parameters, such as the strength or direction of the wind.  
  
In this demo project there are 2 demo scenes, **DemoScene1** and **DemoScene2**. Make sure to uncomment only one of the two calls for the scene and comment the other accordingly.  
- DemoScene1 shows you the complete scene with all the characters you can animate. (Note: it will take some seconds to load, because detailed models and a lots of polygons used).  
- DemoScene2 shows you the scene only with the cloth and without loading the actors.  
  
The scene allows you to iteract through the menus at the top, here we have:  
- **Animate** is used to start the animation of the actions for the actors  
- **Wind** is used to activate or deactivate the wind  
- **Ball** is used to show/hide the red ball that hits the cloth  
- **Pin** is used to detach/attach the cloth to the crosspiece that holds it  
  
**How to use it:  
  
For peoples that never used B4J WebGL library, please download it from [here](https://www.b4x.com/android/forum/threads/b4j-webgl-library.164553/) and ensure to follow the steps to setup.**  
  
This project require about 185MB for detailed 3D models and textures.  
- Download the [resources.zip](https://drive.google.com/file/d/1CiIyfK4T3tq4rx0Z2IFPCVyfy7-W4z26/view?usp=sharing) and the [textures.zip](https://drive.google.com/file/d/1iZU4M1Xv3fk9cVvDjsxIdn-D___hhQQB/view?usp=sharing) files from my Drive.  
- Copy both zip files to the project Asset folder. You can open the zip files to view the content.  
- Compile the project. As always you will end up in a small form with a button. Press it to start the process.  
- The library will show you on the log some informations, even about needed files that are unzipped, copied to the right folders.  
 after that, the log show you (in magenta color) the link to access the scene.  
- Copy/paste the link to your browser and load the page.  
- In the DemoScene1 where all models are loaded, the page take some time to load, because big and detailed models.  
- After the page is fully loaded, you may have low or high framerate depending of your computer and expecially video card.  
- OrbitControls is used here, like most of all others demos I released until now, use the mouse (left click) to rotate the scene, (right click) to translate, whell to zoom in-out or (center click) to fine zoom.  
- You will see here that all Actors are static, they do not move… the animation is not actived by code, just because we decided to only start them by user command.  
- Press on **Animate** link on top, you will see all Actors will start to animate and do Actions you decided by code, the animations repeats in loop, decided by code, some even works as ping-pong loop.  
- You can switch on/off the wind by clicking on **Wind** link, you can even change some wind parameters on the top-right GUI.  
- Press on **Ball** to toggle the red ball visibility.  
- Press on **Pin** to detach/attach the cloth to the crosspiece that holds it. This does various things cyclically every time it is pressed: detaches one side of the cloth, detaches both sides of the cloth, attaches the cloth.  
- The GUI offer a realtime change for some parameters, in particular you can change the animation speed indipendent for any Actor in the scene. You can even put it to zero, so the animation will stop completely until you set an highter value.  
- If you want to speed up the page load (and may even increase the framerate) you can comment in the code the calls to load some big models.  
  
The models for this scene come from Sketchfab, Mixamo, Florasynth, web sites, see links in the scene web page.  
  
I developed it for you, I even edited the Cloth.js class for my needs.  
Please let me know if this works for you.  
I hope you like it.  
  
Enjoy