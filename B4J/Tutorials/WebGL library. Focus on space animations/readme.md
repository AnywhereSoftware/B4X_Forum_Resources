### WebGL library. Focus on space animations. by max123
### 03/04/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/170485/)

Hi everyone,  
  
this time I want to focus on space scenes created with the WebGL library. Once again, it proves it's incredible power for anything 3D whether it's a game, an animation, a simulation, an interactive scene, or whatever else you can imagine.  
  
This is my first time experimenting with Three.js Post-Processing, and I’m discovering how powerful this system really is. It offers a wide range of high-impact effects that you can use at your convenience. By browsing the official Three.js website and trying out the numerous examples, you can see many Post-Processing effects in action. That’s where I drew inspiration for this and other projects.  
  
Specifically, I applied the Unreal Bloom Pass to the entire scene to create a glowing effect, perfect for fire, explosions, or light flares (featured only on Scene 1).  
<https://threejs.org/docs/#BloomPass>  
  
This demo project contains 3 different scenes as explained below:  

1. This is the most complex one, showing a minimalistic animation of a spaceship traveling through space.
Notice that the stars are simple white spheres illuminated by the Bloom effect, but they could easily be replaced with
instanced meshes (one or more models repeated via instancing).
Controls: Use the mouse to rotate, zoom, or pan the scene. Use the keyboard UP and DOWN arrow keys to move the spaceship forward or backward.
This was added simply to adjust the framing without moving the camera (rather than as a game control). For example, moving the ship
forward gives the impression that the camera is moving backward and vice versa.2. Demonstrates how to create and move stars easily, creating the optical illusion of traveling through infinite space. The scene can be rotated, zoomed, or panned with the mouse.
3. An attempt to build something similar to a galaxy using mathematical calculations and simple points (which are actually squares). The scene can be rotated, zoomed, or panned with the mouse.

Banckground musics for Scene 1 (All rights reserved) was gentlement offered by our community friend and music producer [USER=28307]@ivanomonti[/USER]  
  
Note that may the video skip some frames, but this is due to (even if smal) overhead I had recording the video at 60 FPS wirh the help of a great free OBS Studio  
that permitted me to record the full desktop over hardware driver using AMD HEVC. **Note that I done this (rendering and record at full screen 1920x1200) on a Ryzen7 4 Core 8 Thread machine  
with an integrated Vega 10 Graphic card and 16GB of ram minipc 13x13x5 centimeters**.  
Normally the scenes, while not record, if not too much complex works at full 60 fps at 1920x1200 on 24 Inch monitor, I archived up 120 fps on my Xiaiomi Rermi Note 14 using the B4A WebGL I developed, the scene of starship with bloom effect here works at 45-50 fps but this depends on smartphone graphic card capabilities.  
  
Here is the video showing the scenes in action. Ensure to put the resolution to 1080p 60 fps.  
[MEDIA=youtube]1ohrm3RjiW0[/MEDIA]  
  
  
I have attached the B4J complete project file for what you see in the video.  
  
As usual, for any project requiring additional assets (which is almost all of them, except the simplest ones), just take the downloaded Zip file as it is without unzipping it,  
place it in the Assets directory, and refresh the IDE. The code will handle unzipping and copying those files to the correct location within the Three.js distribution.  
  
The assets file contains the spaceship model, the background images, and the .mp3 file playing in the background.  
The audio you hear was not added during video editing; it is played directly by the code. Since browsers require user interaction to play audio,  
it will start the first time you click on the scene after it has fully loaded.  
  
Now I expect that some peoples do something with this library, games, animations, everything…. where the imagination arrive.  
  
I had a long time while searched to known what peoples expects, I received a lots of likes, but at the end no one used the library to do something,  
so at certain point I stopped to improve it. Some time ago I decided to restart developing it because is impossible that peoples don't use it  
that is free to use and super powerful on all my tests. I worked on it two years searching to get it as simple possible to be used, and now the library  
is at Art State, completely finished and works on Desktop and on Android devices. If peoples don't start to use it, I will stop to mantain on this Forum,  
so if your think that this library can do the difference, this is your time, start using it with simple things like the five original demos from library download page.  
  
**IMPORTANT NOTES**:  

- The project requires resource files that, due to size limits, I cannot upload directly here. You can download the Zip assets file from my Google Drive here: [Resources](https://drive.google.com/file/d/1jOJzC-eW32E9UTNJIqYg5H_N89OAyijQ/view?usp=sharing)
- To get this project, ensure to have the latest B4J WebGL library update 1.26 from here: [jWebGL](https://www.b4x.com/android/forum/threads/b4j-webgl-library.164553/)

**Credits:**  
Starship Model "D.S.S. Harbinger battle cruiser" (<https://skfb.ly/YXLW>) by Comrade1280 is licensed under Creative Commons Attribution (<http://creativecommons.org/licenses/by/4.0/>).  
Background music by our community friend Ivano Monti <https://www.youtube.com/channel/UCS4OIcwNYLRMWVAhz4xsJ6A>  
Spacescape tool by Alex Peterson: <http://alexcpeterson.com/spacescape/>  
  
**To-do list**:  
  
Future updates: I plan to replace the spherical stars with meteorite models (either downloaded or self-modeled) using instancing.  
I’ll use 4 or 5 different random models and random scaling to make the scene feel more dynamic.  
  
Planets: I will likely add some planets to the scene.  
  
Spatial Audio: I intend to replace the background music with real engine sounds using 3D spatial audio. This means the sound will be  
louder when the camera is behind the ship and quieter when viewed from the front.  
  
**How I made a spaceship scene ?**  

- I used a simple, free, and powerful program that allows to create things like space, stars, and nebulae by overlapping various layers.
It then lets export the high-resolution result as six images that form the faces of a cube (skybox) for the scene's background.
This program is called Spacescape, created by Alex Peterson. Here the link if you want to try it: [Spacescape](http://alexcpeterson.com/spacescape)
I then imported these images and used them as a background with this code:

```B4X
envMap = new THREE.CubeTextureLoader()  
    .setPath( 'textures/cubeMaps/Nebula1/' )  
    .load([  
    'Nebula_left.jpg', 'Nebula_right.jpg',  
    'Nebula_up.jpg', 'Nebula_down.jpg',  
    'Nebula_front.jpg', 'Nebula_back.jpg',  
]);  
  
envMap.mapping = THREE.EquirectangunarReflectionMapping;  
envMap.encoding = THREE.sRGBEncoding;  
  
// Scene  
scene = new THREE.Scene();  
//scene.background = new THREE.Color(0xcce0ff); // Don't use just a simple color  
scene.background = envMap; // We use Environment map instead of a single color  
scene.environment = envMap;
```

This ensures that as you rotate the scene, you have a seamless, continuous space background. Note that you can find various packages
online many of them free, containing sets of 6 images that can be used to build different types of environments.- I downloaded the spaceship model from the web: "D.S.S. Harbinger battle cruiser" (<https://skfb.ly/YXLW>) by Comrade1280.
The model is very well made and detailed (many thanks to the author for sharing it for free). The model was slightly tilted along one axis,
so I had to import it into Blender, rotate perpendicular to the ground plane, and re-export it before importing into the scene.
It can be downloaded with either low or high-resolution textures and in various formats. As with most of my projects, I opted for the
compressed GLTF format (.glb). This format is optimized and self-contained, including all textures and material information such as
glossiness, opacity, reflectance, brightness, and other parameters (as well as animations, if needed) in a single file.- The background has stars, but they are static. To give the illusion that the spaceship is traveling at a certain speed, I created moving stars.
You can see how I achieved this in the code for the first scene, or even better, in the second scene's code, which focuses solely on this effect
as a tutorial.
Here are the two specific functions that handle this:

```B4X
function addStars() {  
    // The loop will move from z position of -1000 to z position 1000, adding a random particle at each position.  
    for ( var z= -1000; z < 1000; z += 0.5 ) {  
  
        // Make a sphere (exactly the same as before).  
        var geometry = new THREE.SphereGeometry(Math.random() * 0.3 + 0.1, 8, 8)  
        var material = new THREE.MeshLambertMaterial( {color: 0xffffff} );  
        var sphere = new THREE.Mesh(geometry, material)  
  
        // This time we give the sphere random x and y positions between -500 and 500  
        sphere.position.x = Math.random() * 1000 - 500;  
        sphere.position.y = Math.random() * 1000 - 500;  
        sphere.position.z = z;                  // Then set the z position to where it is in the loop (distance of camera)  
        sphere.scale.x = sphere.scale.y = 2;  // Scale it up a bit  
        scene.add( sphere );  // Add the sphere to the scene  
  
        stars.push(sphere);   // Finally push it to the stars array  
    }  
  
    function animateStars() {  
        // Loop through each star  
        for(var i = 0; i < stars.length; i++) {  
            star = stars;  
            star.position.z += i * 0.0020;     // And move it forward dependent on the mouseY position  
            if(star.position.z > 1000) star.position.z -= 2000; // If the particle is too close move it to the back  
        }  
    }
```

- As you can see, the spaceship is well modeled, but the engine fire was missing from the back, there was only an orange circle. Since I had no idea how
to create a fire effect, I asked an AI for help. After explaining in detail what I wanted to achieve, it guided me through the steps and provided the
specific code for the thrusters, such as the createThruster(x, y, z, color = 0xffaa55) function and the logic for the random particle update as follow:

```B4X
// Update all particles  
thruster.updateParticles = function () {  
    const pos = geometry.attributes.position.array;  
    const speed = geometry.attributes.speed.array;  
  
    for (let i = 0; i < pos.length; i += 3) {  
        pos += speed; // <– To +Z  
        pos *= 1.02;  
        pos *= 1.02;  
  
        if (pos > 2) {  
            pos = (Math.random() - 0.5) * 0.05;  
            pos = (Math.random() - 0.5) * 0.05;  
            pos = 0;  
        }  
    }  
    geometry.attributes.position.needsUpdate = true;  
};
```

- The AI explained how it works and gave me a general overview of how to use Post-Processing effects in Three.js.
Essentially, to use Post-Processing, you need to create a Composer. This object can hold one or more effects in a chain and is responsible for rendering both the effects and the entire scene.
Here is the relevant code snippet:

```B4X
// POST-PROCESSING (composer + bloom)  
const renderPass = new RenderPass(scene, camera);  
  
bloomPass = new UnrealBloomPass(  // Next we move these with GUI and/or by code (eg. the threshold to simulate explosions)  
    new THREE.Vector2( window.innerWidth, window.innerHeight ),  
    2.0, // intensity  
    0.1, // radius  
    0.22 // threshold  
);  
  
composer = new EffectComposer(renderer);  
composer.addPass(renderPass);  
  
composer.addPass(bloomPass);
```

And then, when rendering each frame (within the animate() function), instead of updating the Renderer as usual, you must update the Composer.
The Composer will process one or more effects previously added to the chain, following the exact order in which they were included. Therefore,
if you use multiple effects, the order of the chain is crucial.- I didn't like the fact that the background was static, so I made it so that the Bloom effect Threshold parameter change at random intervals
for a random duration. Since the effect is applied to the entire scene (including the background), it creates the impression of stars exploding
in distant galaxies. The nebulae light up, and the spaceship receives a matching glow effect. This resulted in a very realistic look, as you can
see in the video.
Please note that I used a global Bloom effect on the entire scene here, which has a certain computational cost during rendering.
However, it is also possible to use an Selective Bloom to apply the effect only to specific objects without affecting others.
To see how it works, you can check out this demo where you can switch any sphere light ON/OFF by just clicking with mouse on it: <https://threejs.org/examples/?q=SELE#webgl_postprocessing_unreal_bloom_selective>