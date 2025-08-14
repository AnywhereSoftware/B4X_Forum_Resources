###  WebGL Library by max123
### 08/12/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/164553/)

Hi all,  
  
after a long develop making it to work exactly as I wanted …  
  
… since I promised a fully functional 3D library to some users who requested it …  
  
… I'm very happy today to release the B4J WebGL library.  
  
This library fully exposes the super powerful THREEJS JavaScript library (You will have to download separately).  
  
The B4J WebGL library fully exposes:  

1. WebGL 1.0
2. WebGL 2.0
3. WebGPU

renderers, fully rendered by hardware of your graphic card. WebGPU even permits to run some tasks on graphic card GPU.  
  
**Note that because JavaFX WebView does not exposes WebGL functionality, the 3D view cannot be embedded on top of JavaFX, instead it is exposed over HTTP and accessible over external browser.** If someone know a way to integrate WebGL on JavaFX WebView or a replacement of it, I will provide to update the library to work on top of JavaFX Forms, but unless this happen the only way to work with it is to use external browser.  
  
If you need something that involves 3D and is not a problem that it show on external browser (even on remote devices) this is probably the library for you, because of it's incredible powerful you can develop with it any sort of 3D, from simples to very complex scenes, from realistic scenes to realistic or unrealistic effects with even an addon of advanced post-processing and more physic engines.  
  
**B4J WebGL Library is completely FREE, and come out of the box with all you need to develop professional 3D that even works on the web.   
If you plain to use it in your projects, please consider to make a donation … Because the develop required a lot of work, time and knowledge,**   
**I would be grateful if you do it.**  
  
Any modern browser should support WebGL renderers, but to be sure your browsers support it, you can visit: [https://webglreport.com](https://webglreport.com/)  
To get more on THREEJS library you can visit: <https://threejs.org/>  
To get some examples on what you can develop with this library you can visit: <https://threejs.org/examples/>  
scroll down a long list (of 100 and more examples) and test them on your browser, these are just simple examples to show the threejs library functionalities, they are very good point to start, on every example you can get (by clicking on the bottom-right symbol) the code to get the scene. **All these example codes will work on B4J WebGL library.**  
  
The B4J WebGL library is a bridge to help write JavaScript code and have some useful methods to do it, it is small and minimalistic (with few commands) and very simple to use, but you need at least some JavaScript knowledge, the more you are expert here, the more you are able to get best results in small time.  
  
With this library you can:  

- Develop offline and online 3D games
- Develop realistic 3D scenes with static and/or animated models
- Import any sort of 3D CAD models, without or with textures applied, without or with animations and with full control of these
- Export to many CAD models
- Import and export GLTF models and scenes, as JSON or binary files. <https://en.wikipedia.org/wiki/GlTF>
- Add an integrated GUI to iteract in realtime with the scene. <https://github.com/georgealways/lil-gui>
- Create 3D programs
- Create realistic 3D simulations with even help of integrated (more than one) physics engines or external one
- Create realistic 3D presentations eg. to show your products in 3D on the web
- Create 3D cartoons
- Create special effects with help of powerful integrated post processing
- Create Virtual Reality scenes, use cubic cameras, support of VR devices and simple cyano-magenta 3D glasses
- In general develop any sort of 3D applications

**WHAT'S UNDER THE HOOD**  
  
- It's **cross platform**. Because it uses external browser, the 3D scene is rendered on any device with any operating system, Windows, Mac, iOS, Android, probably Android TV and Android Auto, Linux, including all Single Board Computers such the Jetson Nano, ODROID, Raspberry PI and more… here may you have to enable the 3D driver. You only need to know if your browser support WebGL extension. All created scenes will works local and even over the web by pointing the public ip address.  
- The library do not only manage 3D renderings, but is even able to manage **3D spatial audio**.  
- The library offers **more than one physical 3D engine**, support **collisions**, **cloth simulator** and more.  
- The library has more controls and camera views, orbit mouse control, first person, fly control and more, and with my addon class I wrote (a bit experimental, I will release next), it **support up 4 gamepads** fully recognized by the browser using the Gamepad Web API. For advanced users who use microcontrollers such ESP32, if interested I will explain in another detailed post how to use ESP32 as a BLE Gamepad and/or Mouse and/or Keyboard, regularly known by every operating system and browser and thus being able to create custom (and wireless) controls capable of controlling anything inside threejs and in general inside JS code.  
- The threejs library already have a lots of classes to help you to do anything, but even **can be expanded** by creating more custom classes and/or integrate any JS code or JS external libraries and ES6 exported modules.  
- The library have some useful methods to transform **JS arrays to B4X List** **and viceversa** and to transform **JS objects to B4X maps and viceversa**.  
- The library have a **Console** command to output on JS console and **Alert** command to show JS alert boxes.  
- The official threejs site offer a very good, clear and detailed documentation on methods of most classes, sometime with code and sometime even with iteractive inline 3D views. Refer to the official [Documentation](https://threejs.org/docs/index.html#manual/en/introduction/Creating-a-scene). Scroll down the long list on the left or search on top what you need. You will noticed that docs even support more languages, I'm happy to see it even support italian.  
- If you encounter some issues during development you can ask to [Mentor ChatGPT](https://chatgpt.com/g/g-jGjqAMvED-three-js-mentor) that is expert on THREEJS, or just join to **Discord** or **StackOverflow** officials threejs forums. You can find more infos on threejs site.  
- The web is full of threejs tutorials, even there are online developer tools where you can write threejs code and see the final results. One of most popular is [codepen](https://codepen.io/collection/AKNpyq). All these codes will work on B4J WebGL library.  
- The web is full of sites where you can find free or paid detailed 3D models, without or with textures, without or with animations. One of most popular is [sketchfab](https://sketchfab.com/).  
- Come with a **full and advanced debugger** (like B4X IDE but to debug JS), just press F12 to show your browser DevTools, here you can inspect your JS code, inspect variables and constants, put breakpoints, advance line by line, view a full HTML code, view any resource file used and track any HTTP request. You can refer to DevTools documentation of your browser to get more infos.  
- **More secure**. All is managed internally using XmlHttpRequests and modern techniques where the security is at top level.  
- Come with **step by step simple setup guide** and with **5 demo projects**, fully commented and disposed as small tutorial to start with it.  
  
**How to setup WebGL library** **(Step by step)**  

1. Download the attached jWebGL.zip file
2. Extract jWebGL.jar and jWebGL.xml files to your Additional Libraries folder
3. You will have to put the THREEJS library in a place where the system have permissions to read and write, the best place on any system is DirData. To know where DirData points on your system you can use:

   ```B4X
   Log(File.DirData("B4XWebGL"))
   ```

   where B4XWebGL is not mandatory, but it is just to mantain compatibility with my example demos distribuited with this library. You can change it's name but then you need to change it on all example demos and on all your projects. I advise you to leave this name unchanged. This line show me on the log the follow on Windows 11: C:\Users\MyUserName\AppData\Roaming\B4XWebGL. Finally go to this position (eg. C:\Users\MyUserName\AppData\Roaming\ in my case) create a new folder and call it B4XWebGL
4. Go to THREEJS github page and download the distribution zip file. Note that I have tested it on version r164, but because it's community is very active, it will continue to evolve, improve, fix small bugs etc… You can just download the latest version (at moment I wrote this, the r171) or search old versions on the history. Searching very old versions (like r120-r130) helped on old devices that not fully support WebGL, but break some compatibility with new code. Here the github page where you can download the latest library version: <https://github.com/mrdoob/three.js>
5. After you download the zip file named three.js-dev.zip, open it, you will find a three.js-dev folder inside, **double click and open it**
6. Select all files and folders of threejs distibution, you will have to copy/paste inside the already created B4XWebGL folder
7. Ensure you have Archiver 1.1 library installed
8. **Done setup complete !!!** **At this point you are able to use B4J WebGL library :p**
9. Extract the Demos.zip examples in a place where you have your projects.
10. Open the B4J IDE, open the first demo project example jWebGL\_Demo1
11. Compile it, you will end up with a small form with a button, press it to start the process
12. After you press the button, you will see some infos in the log, and at the end of log you will see 2 lines in magenta color, one to access the created scene, and one to get the library main page
13. OK now it's time to show our 3D scene created in the jWebGL\_Demo1 project, copy from the log the magenta line to show the scene, paste it on your browser and if all it's ok, you will end up to see a brown cube at center of the screen with textures applied
14. You can use mouse LEFT button to rotate it, RIGHT button to translate, MIDDLE button (or wheel) to zoom
15. **Compliments !!! This is your HelloWorld 3D scene with WebGL library !!! :cool:**
16. Now copy from the log the line to view the library main page, paste it on your browser of development machine (or other devices in local network) here you will see the library main page and some useful infos and links you can view. You have even a link with files in the threejs distribution you placed inside B4XWebGL folder, examples, textures and more. They are all served over HTTP, you can access them from browser …. you can even test all threejs demos inside the /examples folder, they are the same that threejs site examples, but they are offline now, all served over HTTP on your local network

A **big** **thank you** to [USER=1]@Erel[/USER] that sent me the latest version of B4J Server (4.02), that offers the possibility to get server logs without ciclically open every 10 seconds the server log file and get here if there are modifications…. it works really well. It even permits to set the correct log timestamp you can pass as GMT string.  
  
The five demo projects I've provided are just simple demos, but disposed as small tutorial to start manage this, largely commented to explain a bit how you can start with WebGL library.  
  
So now you can test all demos one by one, all works the same manner as previousely explained (from step 10). Just remember to terminate the current project before you start others  
(because in these demo projects I used the same HTTP port for all projects) or the server will be unable to bind and serve the new scene because the port is already open and used by another process. Note that you can use more concurrent projects open in the browser at same time, just use a different HTTP port for any project.  
  
These demo projects are pretty simples, they are just to show you a starting point, but absolutely you cannot see the library power from here.  
From demo 4 you will start to see and know that if you want to make something complex, this library permits to do it.  
  
The space for upload is limited so I cannot post demos with complex scenes where I use animated detailed 3D models with textures, mipmapping and more …  
  
**As promised when first time I released this library, to get more complex demos, you can refer to my [Overview](https://www.b4x.com/android/forum/threads/massimo-meli-overview.144941/#post-918893) in the Tutorials section.**  
  
You will be noticed that every time you access files over HTTP, the B4J WebGL library offer you a way to get the server logs for any request file, they are passed as string to the \_ServerLog Event, you can use them to show the log where you want, in a TextArea, collect all to a ListView and more…. in the demo projects I just show them in the IDE log with different color based on the HTTP Response code that the message contains …. 202, 304, 404.  
  
Note that every time you request an HTML file, you will see the server log for that file and for any file that HTML or JS code request, so class imports, textures, models, sounds, videos and more. The log help you to know what file a project request, if file is found or not, if it is already on the cache of your browser. Note that the log is even accessible if you compile the app and launch it from terminal, just they are single color.  
  
**A clean development system.**  
  
After you tested some or all threejs provided examples, may you want a clean development system ….  
To do this, open the B4XWebGL folder where the threejs distribution is placed, here you can remove all unused files, just used for examples.  
**You can remove some files but please do not change (or delete) the default folder structure**.  
Files you can remove are in /examples folder, open the /textures sub folder, here you can delete all folders and files inside or just what you don't plain to use in your projects, at same way, open the /models folder, here you have a lots of models that consume a lots of space, another time you can remove all folders and files or just what you do not plain to use.  
You can do the same with /sounds folder.  
In the /fonts folder you can add more fonts and/or delete the existing if you plain to not use them.  
You can even remove all html files examples that consume more space and even remove the /screenshots folder that contains the screenshots for examples.  
  
**Do not delete the /textures, /models and /sounds folders, here you need to put your personal textures, models and audio data to use in your projects**.  
  
After this you will have a clean development tool. You can put manually your personal textures, models and sounds you plain to use on one or more projects.  
It is best practice to create sub folders where place all files divided by type, eg. in /textures create a folder /grass with all grass textures, /patterns with all patterns textures, /woods with all wood textures and so on … This will help you when you use these files and open them in your projects.  
  
You can even put files in your assets and copy them to the right position by code, to do this you can refer to ProjectFolder, it refer to the library folder (/examples), here an example code:  

```B4X
   Dim Separator As String = GetSystemProperty("file.separator","")  
   Dim FilePath As String = $"textures${Separator}crate.gif"$  
    If File.Exists(gl.ProjectFolder, FilePath) = False Then  
        Wait For (File.CopyAsync(File.DirAssets, "crate.gif", gl.ProjectFolder, FilePath)) Complete (Success As Boolean)  
        Log("crate.gif copy from assets. Success: " & Success & "   " & File.Combine(gl.ProjectFolder, FilePath))  
        If Not (Success) Then  
            LogError("You should place crate.gif in DirAsset")  
            ExitApplication  
        End If  
    Else  
        Log("crate.gif texture already exist: " & File.Combine(gl.ProjectFolder, FilePath))  
    End If
```

  
This is an old thing…… don't more use this code… now just use this from v1.24 of library, it do the same exact thing, you can even decide to overwrite or not an existing file:  

```B4X
    Dim Separator As String = GetSystemProperty("file.separator","")  
    Wait For (gl.CopyResourceFile($"textures${Separator}crate.gif"$, False)) Complete (Success As Boolean)  
    If Not(Success) Then  
        LogError("You should place crate.gif in DirAssets")  
        ExitApplication  
    End If
```

  
  
An useful thing is to know how to use [Blender](https://www.blender.org/) (free), [Freecad](https://www.freecad.org/) (free), or any other free or paid CAD to create customized objects and scenes, export them and then import into your scene created with this library.  
  
I'm happy to inform you, that I'm under development for the same library on B4A. Here because Android WebView fully support WebGL extensions, the library is more powerful because it permits to integrate WebGL view inside our app (windowed or fullscreen, and even resizable with 3D rendering update) without use of external browser. This even expand a lots the possibilities, because after a page with rendering is loaded, we cannot only change some things from JS side, but we can even change anything from Android side on B4A, eg move a SeekBar or use Timers to change something in the 3D scene …. and this is awesome and powerful.  
  
That's all …  
  
If you create something (not commercial), don't forget to put here some feedback and share the code on this forum, so other users can get your scene and study your code.  
If you create something functional (commercial or not) please put in the About of your app the link to this thread and don't forget to credit threejs.  
  
Enjoy with real 3D world !!!  
  
**Updated to 1.24**  
- Changed some small things in library initialization. This was necessary to make it compatible with B4A WebGL library I will release next days.  
 Now the code (apart inizializialization line necessary to adapt to Android) it is fully compatible between B4J and B4A WebGL library as I wanted.  
 Now full projects can be copy/pasted from B4J to B4A IDE and viceversa and will work the same without adaptions and write more code.  
- Removed some redundants commands, this will avoid confusion, simplifies the code and improve the library flexibility  
- Added new useful commands to simplify the copy of project resources (Remember you can just do it manually but it is good practice do it in the code expecially if you distribuite the code. This is not true on B4A WebGL library where you can only copy resources by code)  

```B4X
CopyResourceFile (Destination As String, ForceOverwrite As Boolean)  ' Asynchronously copy single resource file from Assets to the destination folder inside ProjectFolder  
CopyResourcesFromZipFile (ResourcesList As List, ZipFileName As String, BufferSize As Int)  ' Asynchronously copy all resources from zip file placed in Assets to multiple folders inside ProjectFolder  
CopyResourcesFromZipFileToSingleFolder (DestFolder As String, ZipFileName As String, BufferSize As Int)  ' Asynchronously copy all resources from zip file placed in Assets to a single folder inside ProjectFolder
```

  
- Updated accordly all demo projects. To avoid confusion about small code changes in the library initialization, you will just remove old demo projects and use the new zip file.  
  
**Updated to 1.25**  
- added an option to overwrite resources using CopyResourceFile, CopyResourcesFromZipFile and CopyResourcesFromZipFileToSingleFolder. If Overwrite is True, always resources will be overwritten, if False, the library just check for first file existence, if this exists do nothing, if this do not exists will copy relative resources. If you still develop and change files from time to time you can set it always True, put it False otherwise or in final production.