### OpenCV 3.x by JordiCP
### 06/27/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/79816/)

**[SIZE=5]OpenCV[/SIZE] (Open Source Computer Vision Library**) is a really huge project/framework actively developed, mainly written in C++ . It is released under a BSD license.  
[INDENT]Read more here: <http://opencv.org/>[/INDENT]  
[INDENT]OpenCV versions: <https://opencv.org/releases/>[/INDENT]  
  
  
**OpenCV library for B4A:** wraps the official OpenCV 3.x release for Android (in fact not all, about 95% of it)  

- Feel free to test and use it. You can even [[SIZE=5]![](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)[/SIZE]](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5W6262V2ZKLF2)
- License: You can use it for your projects, but you are not allowed to distribute nor sell this library. Of course you can distribute apps that use it (remember that OpenCV itself has BSD license as stated before)
- Supported hardware is: armeabi-v7a and arm64-v8
- **Versions**

- 1.05 (2020/12/22)

- **Link to the B4A library files:** [**HERE**](https://drive.google.com/drive/folders/1rBrClHiCVVjDKItDTT0Kx4MUaNActv82?usp=sharing) :)

- 1.04 (2020/05/17)

- This version wraps OpenCV 3.4.1 Android release and fixes some bugs (mostly some instance methods and some not exposed classes) of the previous version.
- One of the major additions is the **DNN**module and related classes.

- [LINK to example](https://drive.google.com/open?id=17K-za2khfTwOLeajDDgXtYSHsgoNmDCX) (too large to be uploaded here)
- [Result video](https://www.b4x.com/android/forum/threads/opencv-3-x.79816/post-737497)

- Link to the B4A library files: (no longer available, removed from my Drive by mistake)

- 1.00 (2017/09/27)

- First B4A library wrapper (OpenCv320forB4A V1.00) which replicates (95%) the official OpenCV 3.20 Java API for Android.
- (removed link. Use 1.04)

  

- Please note that my support will be limited to issues with the wrapper itself, not to help translating OpenCV code from other languages to B4A ?‍♂️

  
  
========================================================================  
  
(There may be some inaccuracies in what I expose in this post, related to the OpenCV project, since I am relatively new to it and don't know all about its internals. If you find any, please let me know and I will correct it)  
  
A bit of explanation  
[SPOILER]  
There exist 'official' OpenCV wrappers for different languages and platforms. Android is one of them.  
The official OpenCV 3.20 for Android API includes a lot of classes, organized in modules. But it does not include "all" the original OpenCV modules (since there are other 'experimental', non-free, or platform specific modules which may be present in other platforms but not for Android). Also, there are build options to "tune" it…  
  
I have played quite a lot with it this last year, with a huge project which I started with inline Java, and also translating examples or testing features. But what I have used is just a small percent of the classes and methods exposed. So, there may be some (let's hope not too many) things to fix.  
[/SPOILER]  
  
How to learn OpenCVforB4A  
[SPOILER]  
If you have worked before with OpenCV, the learning curve will be easy.  
If it was using Java with OpenCV for Android, then it will be immediate, since all the methods have exactly the same syntax (except for initializers, polimorphism, and some special cases where simply I did my best).  
Anyhow, the ways that I can think of, are (will add links later, also suggestions as online tutorials,.. are welcome)  

- Attached examples.
- B4A OpenCV Tutorials. I will write a couple of them with what I consider the most important building pieces (for instance the Mat class, which in B4A is OCVMat) and modules
- Internet examples: there are A LOT of examples over there, written in C++, Java, Python, JavaCV. I would look for examples in the language that is easier to understand for you and then try to translate. Some tips about it (based on my experience)

[INDENT]

- OpenCV syntax has changed as new versions. So there is an 'old' syntax in which nearly everything started with "cv…". Since version 3.X, there was 'cleaner' organization (project was written in C++ instead of C), and there were major syntax changes.
- JavaCV: Translating from JavaCV to OpenCV should be quite easy but not always direct. JavaCV uses a mix of the old OpenCV syntax with some of its own, and at the beginning it can be a bit confusing, but then it is also easy.
- Python: there is a lot of material…

[/INDENT]  
[/SPOILER]  
  
First steps. Prepare for some crashes…  
[SPOILER]  

- In OpenCV nearly everything takes part in the native code.
- When we call a Sub/method/algorithm, it performs some internal checks to see if all the input data is correct. This check is perfomed in the native side. If something is not correct (wrong OCVMat dimensions, some incoherent parameters,…) it throws an exception and crashes. If we are lucky, perhaps we see in the log some clues about the check that made it crash.
- On the good side, it is very easy to achieve results with OpenCV (check the examples). The real difficult part, as with many other things, is to fine-tune it: OpenCV has a collection of really powerful 'primitive' objects and operations, and really complex algorithms that can do many things. But it is the user who has to glue all of them to achieve the desired results.

[/SPOILER]  
  
  
(from the previous Beta announcement)  
[SPOILER]  

- **IMPORTANT**: you must take this into account:

[INDENT]

- OpenCV (the included binary modules) is a free(\*) project, but subject to license terms as described here: <http://opencv.org/>

- *[SIZE=3](\*): There are some modules in the OpenCV project which are on-free, but here I am refering to the ones included in the library[/SIZE]*

- My work: (the B4A library) is free to test and use, but you can [![](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id= 5W6262V2ZKLF2) for it :). I'll keep donators updated with "advanced" material and examples
- If you are interested, please PM me with your mail address and I will send you a link with the library and some basic examples. (be patient if you don't receive it immediately, I'll do it as soon as possible).

[/INDENT]  

- There is no documentation. In short, the syntax is nearly-exactly the same as the OpenCV3.20 Java API, adding "OCV" prefix and only the minimum modifications to adapt to B4A, For reference (taking into account described syntax changes) you can look at <http://docs.opencv.org/java/3.1.0/> (which is not the latest one, but the API is nearly the same).
- It would be preferable if you have worked before with OpenCV and/or can translate examples from Java/C++ and/or simply are interested in it.
- I recommend starting with the examples and try to understand what is done. Just experimenting can lead to crash after crash of the native libraries with nearly no useful information, and can be very discouraging.
- I forgot, the included binaries are for ameabi-v7a and arm64-v8 devices

[/SPOILER]  
———————————————————————  
Some screenshots taken from the examples  
[SPOILER]  
Canny operator - Features2D - Color space conversion  
[SPOILER]  
![](https://www.b4x.com/android/forum/attachments/55977)  
[/SPOILER]  
2D-FFT  
[SPOILER]  
![](https://www.b4x.com/android/forum/attachments/55978)  
[/SPOILER]  
Color Blob detection  
[SPOILER]  
![](https://www.b4x.com/android/forum/attachments/55979)  
[/SPOILER]  
[/SPOILER]