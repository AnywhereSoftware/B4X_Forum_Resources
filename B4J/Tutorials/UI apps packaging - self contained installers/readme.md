### UI apps packaging - self contained installers by Erel
### 05/25/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/56854/)

**It is recommended to use B4JPackager11:** [Integrated B4JPackager11 - The simple way to distribute standalone UI apps](https://www.b4x.com/android/forum/threads/117880)   
  
[SPOILER="Older tool"]  
B4J Packager is a small utility that uses javapackager to create a single file installer for Mac or Windows, that includes the app files **and the Java runtime**.  
  
This means that from the end user perspective your app doesn't depend on any additional runtime. It makes deployments very simple.  
The installer size will be around 40mb as it includes the JRE.  
  
![](https://www.b4x.com/basic4android/images/SS-2015-08-02_17.14.48.png?1)  
  
The Windows installer (exe) is built on a Windows computer and the Mac installer (dmg) is built on a Mac computer.  
**You need to install Inno Setup on the Windows computer: <http://www.jrsoftware.org/isinfo.php>**  
  
You can either run the attached source code from the IDE or download the jar file: [www.b4x.com/b4j/files/B4JPackager.jar](https://www.b4x.com/b4j/files/B4JPackager.jar)  
  
The source code depends on the following additional libraries: Archiver (B4A library) and jControlFX  
  
Using this tool is quite simple. First you need to set the path to javapackager.  
On Windows the path will be similar to:  
C:\Program Files\Java\jdk1.8.0\_51\bin\javapackager.exe  
On Mac:  
/Library/Java/JavaVirtualMachines/jdk1.8.0\_51.jdk/Contents/Home/bin/javapackager  
  
Compile your app in release mode and then set the path to the Jar file and fill the other fields.  
The icon on Windows is an ico file and on Mac is an icns file.  
  
Click on the Build button. The building process can take a minute or two.  
The installer will be created under the bundles folder (the folder will be opened).  
  
**Notes & tips:**  
  
1. Make sure to test your app after it is installed. It will be installed under Program Files.  
Program Files is a read-only folder. Any attempt to write to File.DirApp will fail (you should use File.DirData instead).  
  
2. javapackager documentation:  
Windows - <https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javapackager.html#BGBIJBHF>  
Linux / Mac - <https://docs.oracle.com/javase/8/docs/technotes/tools/unix/javapackager.html>  
  
3. It is recommended to run the packager from the IDE (at least in the beginning) as it prints important information in the logs.  
You can also run it from the command line with: java -jar B4JPackager.jar  
4. The installers will use the app package name to identify the app. Make sure to change it from the default value. Otherwise all applications will be installed in the same folder.  
5. **Java 9 is currently not supported. Make sure that both B4J and the path to javapackager point to Java 8.**  
6. If running on a Mac then you probably should change the package to pkg. See this discussion: <https://www.b4x.com/android/forum/threads/using-b4jpackager-bundler-dmg-installer-dmg-failed-to-produce-a-bundle.87897/>  
  
**Change log:**  
  
v1.50  
  
- Adds support for newer versions of Java 8.  
- javapackager is run in verbose mode.  
- The logs are updated while the process is running.[/SPOILER]