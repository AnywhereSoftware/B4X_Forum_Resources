### SVGAPlayer Library by Addo
### 06/05/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/140984/)

**Hi , This is my first wrapper that I ever Created on This Forum.**  
First of all I Want to thanks [USER=97072]@OliverA[/USER] who have been great support to me that give me the motive to start creating wrappers.  
also I want to Thanks [USER=2353]@moster67[/USER] for his Tutorial that gives the spark into my brain.  
after many situations that I had to deal with and many fails and greed from a few members here in order to get a github project to be wrapped , I decided to learn the whole thing .  
matter of fact wrapping a library from github to b4x is kind of simple but although needs a good knowledge in java.  
I have successfully wrapped a library that I needed to use for a personal needs. and I decided to share it for free.  
as this was my first wrapper in this forum I will post it for free. a small donation are very welcome.  
  
This Library is based on this [Github](https://github.com/svga/SVGAPlayer-Android) Library  
  
**What is SVGAPlayer ?**  
  
SVGAPlayer is a light-weight animation renderer. You use [tools](http://svga.io/designer.html) to export svga file from Adobe Animate CC or Adobe After Effects, and then use SVGAPlayer to render animation on mobile application.  
  
SVGAPlayer-Android render animation natively via Android Canvas Library, brings you a high-performance, low-cost animation experience.  
  
  
**Events**  

- **Click**
- **LongClick**
- **OnComplete**

- **This event will be fired when Parsing Svga File is completed.**

- **onError**

- **This event will be raised whenever something unexpected happened**

**Designer Properties**  

- **fillMode**

- **You can choose between this List {Forward|Backward|Clear}**

- **Loop**

- **You Can set the animation loops count of the SVGAIMAGEVIEW From the designer.**

- **clearsAfterDetached: Boolean**

- **Defaults to false.Clears canvas and the internal data of SVGAVideoEntity after SVGAImageView detached.**

**Functions**  

- **PlaySvga**

- **This function will be used to play svgaFile from assets folder, in a new version i will add the ability to add svga from URL which is already implemented in the library**

- **SetfillMode**
- **GetfillMode**
- **SetLoop**
- **GetLoop**
- **SetclearsAfterDetached**
- **GetclearsAfterDetached**
- **StartAnimation**
- **StopAnimation**

  
**A demo can be downloaded here Since upload size is limited in the forum.**  
  
[**[SIZE=6]Download B4A Demo[/SIZE]**](https://drive.google.com/file/d/1aJk_6GqSwosxxSGc2HHT-xoVa3voJaoW/view?usp=sharing)  
  
**[SIZE=7]Requirments[/SIZE]  
[SIZE=5]okhttp library  
wire-runtime-jvm-4.3.0.jar {in Additonal Folder}[/SIZE]**  
[SIZE=5]**svglib-release.aar**[/SIZE]**[SIZE=5]**[SIZE=5] {in Additonal Folder}[/SIZE]  
[SIZE=5]kotlin-stdlib-1.6.10.jar **{in Additonal Folder} newer b4a versions has already kotlin stdlib in the library folder.**[/SIZE]**[/SIZE]  
[SIZE=5]Demo is Using XcustomlistView You can make your own how ever you like.[/SIZE]  
  
[SIZE=5]As a Thanks to [USER=97072]@OliverA[/USER] you can donate for this library at his [/SIZE]**[**[SIZE=5]paypal address[/SIZE]**](http://paypal.me/TammyAckermann)**[SIZE=5] if you like. Thanks and have a great day everyone.[/SIZE]**