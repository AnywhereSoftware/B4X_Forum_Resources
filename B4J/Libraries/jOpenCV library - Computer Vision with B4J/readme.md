### jOpenCV library - Computer Vision with B4J by JordiCP
### 06/28/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/128902/)

**OpenCV** (Open Source Computer Vision Library) is a library of programming functions mainly aimed at real-time computer vision. Originally developed by Intel, it was later supported by Willow Garage then Itseez (which was later acquired by Intel).  
  
Read more here: <http://opencv.org/>  
OpenCV versions: <https://opencv.org/releases/>  
[SPOILER=A few random notes about OpenCV (how it is structured, modules, …)]  
OpenCV can be divided in modules, which group related functionalities. Each module contains several classes. The main modules (which many of the others use as building blocks), are Core, imgProc, …. They provide the 'primitive' objects and algorithms on top of which more complex algorithms are build.  
  
Some of these modules that are platform dependant: for instance, Highgui and Videocapture are for desktop builds, android JavaCameraView for Android, and others.  
  
There is another classification of modules: main modules (those that are in the main repository) and contrib modules. Contrib modules are those that for several reasons (not mature enough yet, or other…) are not part of the main repository, but most of them are also actively maintained, so they are suitable for development.  
There's also a subgroup of the contrib modules: the non-free modules (usually their name starts with 'x'), which adhere to a totally different license if you want to work with them.  
  
Releases, builds and customizations:  

- For each OpenCV official release, 2 branches are updated: the 4.x branch and 3.x branch. Many of the new features and bug-fixes are propagated to both branches, so for this part, they go in parallel. One of the biggest difference between them is that since 4.5 version, they are under a different license.
- The current jOpenCV library 'follows' the OpenCV 3.x releases, so the 3.x license applies as stated later in this post.
- Each OpenCV official release build includes the main repository modules for the specific platform. They do not include contrib modules nor some 3rd party support options (such as ffmpeg)
- The included modules are: ( related documentation: <https://docs.opencv.org/3.4.4/javadoc/index.html>)

- Calib3d: useful for camera calibration
- Core: basic and derived Mat classes and a lot of useful methods
- DNN: deep Neural Networks. OpenCV provides ways to read and perform inference using several networks/modes: Tensorflow, Yolo, …
- features2d
- highgui : for desktop builds. This module deals with windows showing images from Mats,
- imgcodecs
- Imgproc: classes for image processing
- ml : Machine Learning. Try/use several ML classes. There will be a nice example using classes from this module.
- objdetect
- photo: many photo related classes
- utils: misc.utils
- video:
- videoio: Provides de VideoCapture class, which is used to capture streams from files, videoCameras, internet URLs,…

[/SPOILER]  
  
  
  
**[SIZE=5]jOpenCV[/SIZE]** is a B4J library that wraps a customized **OpenCV 3.x** build for Windows x64, with additional **FFmpeg** support and some other add-ons, trying to keep the OpenCV Java syntax, adapted to B4J in order to ease the learning process.  
  

- Current version **344.01** (numeration schema means that it wraps OpenCV 3.4.4 and it is the first release)

- OS/Platform: Windows/x64
- Build options: with TBB (increases speed for some algorithms) and FFmpeg support
- Contrib modules included in the build: aruco and face.
- Download the library files here: [[SIZE=5]**>> Download jOpenCV library files**[/SIZE]](https://drive.google.com/drive/folders/1iRZ3RbYzNd04QYMMgv96DebvTeQrxw2z?usp=sharing)
- Download ZIP file with some examples: [**[SIZE=5]>>>Download examples[/SIZE]**](https://drive.google.com/drive/folders/1ya9KNJdEnZUNXJJun9TYHu2Fep5N96If?usp=sharing)

  

- Cost:

- This library is **FREE** to test and use :)
- However, you should consider to [![](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5W6262V2ZKLF2)what you think is fair.

- While OpenCV is open source, I have spent lots of hours over the last years understanding OpenCV in general and working with this library specifically. It will help keeping me motivated updating and fixing bugs.

  

- License: since jOpenCV is based on the OpenCV 3.x branch and includes 3rd party FFmpeg support, the following licenses apply:

- OpenCV 3.x is licensed under the 3-clause BSD license. See [HERE](https://opencv.org/license/)
- FFmpeg is licensed under the GNU Lesser General Public License (LGPL) version 2.1 or later . See [HERE](https://ffmpeg.org/legal.html)

  

- Set-up

- Copy jOpenCV.jar and jOpenCV.xml to your additional libraries folder.
- In order to work, the current release needs 3 DLLs (can be more in future releases). Copy the DLLs to a folder. Projects using jOpenCV should copy the DLLs to the project's Objects dir. This can be done with the appropiate #CustomBuildActions. Check the examples example to check how it is done.
- Take into account that future versions of this lib will also imply future versions of at least one of the DLLs (specially b4jcv\_xxx\_yy.dll, so be sure to follow these steps for each new release.

  
**Important disclaimers:**   

- Even if you donate, it doesn't imply that I have to give personalized support, since my time is limited. That's one of the reasons why I made this lib free. The other reason is the satisfaction to see more people using together this platform and OpenCV, since I'm a big fan of both.. To be clear, I'll try to actively maintain this lib specially regarding bugs and new features, if my time allows it.
- If you need support translating examples or building something new, please always start a new thread in order to keep this one clean only for library-related issues or bugs. Post the code as clean as possible (with code tags please), and try to explain exactly your problem. If you just copy-paste a bunch of code expecting an automatic translation service, chances that someone will spend his time to help you will decrease.
- Many of the classes / methods have been tested in samples and projects of my own, so I can say that the lib works very well. However, the amount of classes is so large that I haven't tested them all. So it is very possible that you may find some missing methods or strange crashes when using one of these. If this is the case, pls report and I'll try to fix it :)

  
**Relevant links for the original OpenCV project:**  

- OpenCV main page: <https://opencv.org/>
- OpenCV Tutorials (make sure that you select the same version in which the jOpenCV library is based, otherwise they may not apply): <https://docs.opencv.org/3.4.4/d9/df8/tutorial_root.html>
- OpenCV Java documentation page: <https://docs.opencv.org/3.4.4/javadoc/index.html>
- OpenCV releases (useful to keep track of how its evolution): <https://github.com/opencv/opencv/wiki/ChangeLog#version451>

  
**Where to start / How to learn**  

- As a general resource, take a look at OpenCV tutorials linked above.
- jOpenCV examples, which will be published (link to the samples will be added here)
- j**OpenCV tutorials**

- [[SIZE=4]**Tutorial 1** - Syntax rules, Helper methods and Basic types.[/SIZE]](https://www.b4x.com/android/forum/threads/jopencv-tutorial-1-syntax-rules-helper-methods-and-basic-types.128933/#post-808970)
- [[SIZE=4]**Tutorial 2** - Image & Video (with VideoCapture) acquisition, and conversions to/from Mat objects.[/SIZE]](https://www.b4x.com/android/forum/threads/jopencv-tutorial-2-image-video-with-videocapture-acquisition-and-conversions-to-from-mat-objects.128934/#post-808972)

**Some notes / tips from my experience.  
[SPOILER][/SPOILER][SPOILER][/spoiler]**[SPOILER]  

- OpenCV allows you to do many many things. But results (specially at the beginning) can be a bit discouraging.

- First, because of errors / crashes: if the method inputs are not exactly the expected, asserts will fail and you'll get runtime crashes. Just follow the tutorials and try to run the first examples in debug mode to see what is happening.
- Also, perhaps you may find an example written in Python that does some sort of detection. You spend a time translating it, and then see that it only works partially with your input images/videos. It is because many times, these articles/examples work but they are purely academic or for illustration purposes.

- They will give you the clue of the strategy used to solve that specific image processing problem, but perhaps you'll need to fine-tune it or add more steps, in order to work for a broader range of real-world scenarios.

- Related to the above point, you must take into account that image pre-conditioning play an important role in computer vision problems
- Also related, sometimes you can get your detection project to work with a let's say 80% reliability. That is really great as a proof of concept, to show your friends, or even to set up a home invention. But going from there to a 90-95% or even 99% reliability , if the final application requires it, can take a lot of additional effort, much bigger than the current implementation.
- Evolution: as computer processing power has increased and algorithms evolved, new state-of-the-art 'detection, recognition, classification algorithms models and frameworks are appearing every day. Among them, specially DNNs (Deep Neural Networks). Support for DNNs has been progressively added to OpenCV releases. But if you see a Youtube Video performing imaging classification using YOLO-v5 (to say something), this will possibly require a later OpenCV version ( and also possibly CUDA support, so things can get complicated)

- That's one of the reasons why it is very important to read the OpenCV release notes for the current wrapped version, and check that the modules / classes / features that you want to use are already implemented in the that version.

[/SPOILER]  
  
**Worth reading if you have already used** [**B4A OpenCV 3.x library**](https://www.b4x.com/android/forum/threads/opencv-3-x.79816/)  
[SPOILER]  
If you have already used my OpenCV 3.x for B4A library wrapper, you'll notice that syntax is almost the same. But there are some slight differences due to the platform change (Android <-> Windows) and also to the fact that they wrap different OpenCV versions.  
Differences to take into account:  

- JavaCameraView does not exist in jOpenCV. Instead, video should be captured with VideoCapture (which accepts many other sources)
- Utils to convert from Bitmap to OCVMat and the other way round are different since the underlying object is different.
- Polymorphism: (this part will be a bit annoying but not difficult at all to translate). Numeric suffixes for those methods that accept several signatures are not necessarily the same between B4A and B4J versions. The reason behind is that B4A OpenCV wraps the 3.41 version and jOpenCV wraps the 3.4.4 version. A lot of things changed between them, and the Java bindings for 3.4.4 are much more complete for several classes, meaning that some existing methods now have several additional signatures. The order in which the Java bindings were generated in the complex OpenCV build process is totally different that in previous version, so it would be difficult to manually reenumerate them to be compatible. I'll try to stick to the current numeration in the future if possible, but the B4A version will be different. If you have arrived here and understand it, congratulations ?

[/SPOILER]