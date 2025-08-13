### [B4j] Jave2 FFMPeg Library by stevel05
### 09/03/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/142548/)

After using FFMpeg from the command line, I came across [Jave2 (Java Audio Video Encoder)](https://github.com/a-schild/jave2) a java wrapper based on FFMpeg. Useful to integrate FFMpeg into your app without having to use jShell. The library jars are quite large, so if you only want to use it for the odd conversion it might be better to use the Shell option. With the library, users of your app won't have to install FFMpeg on their machines.  
  
There are 2 b4xlibs attached and a test project for each (you will have to change at least the source and target filenames to use the test projects). if you want to get real-time messages (progress information) you need to use the Threaded version of the library.  
  
There are some examples on the [jave2 github page](https://github.com/a-schild/jave2), but not many. If you don't know FFMpeg, you can search the internet for the examples you need. It should be easy enough to implement them with the library.  
  
**Setup**  

- Download jave-core and whichever nativebin file(s) you wish to use from their [Maven Repository](https://mvnrepository.com/artifact/ws.schild/jave-all-deps/3.3.1) into your B4j additional libraries folder.
- Download slf4j-api-2.0.0.jar and slf4j-nop-2.0.0.jar from the slf4j [Maven Repository](https://repo1.maven.org/maven2/org/slf4j/) into your B4j additional libraries folder if you don't already have them.

  
**External Dependencies**  

- **Non Thread version** - None
- **Threaded version** - [Threading](https://www.b4x.com/android/forum/threads/threading-library.6775/)

**Comments**  
[INDENT]Use the threaded version if you are going to convert large files, otherwise the Gui will be blocked.[/INDENT]  
[INDENT]The test apps use nativebin-win64. You will need to change that in the #AdditionalJar directive if you want to use something different.[/INDENT]  
  
**Update  
FFMpeg-Threaded-b4xlib v 0.12 - 25 Aug 2022**   

- Listener is created automatically if needed. Changed Initialization parameters
- Added Complete event that can be used with Wait For to queue conversions for the threaded calls
- Test app also updated.

  
I hope you find it useful.