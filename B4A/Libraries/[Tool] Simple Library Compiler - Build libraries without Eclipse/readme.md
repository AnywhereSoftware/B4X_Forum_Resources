### [Tool] Simple Library Compiler - Build libraries without Eclipse by Erel
### 01/20/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/29918/)

The purpose of Simple Library Compiler (SLC) is to make it easier to build libraries. SLC is responsible for taking the Java source code files and generating the Jar and XML files.  
  
As I see it, it can be useful in two cases:  
- Creating wrappers for 3rd party SDKs.  
- Modifying and extending existing open source libraries.  
  
Do note that you still need to provide the source code. This tool only helps with the building steps.  
  
![](http://www.b4x.com/basic4android/images/SS-2013-06-04_19.25.38.png)  
  
**How to use**  
  
Using SLC is quite simple. The main project folder should include a folder named src and optionally a folder named libs.  
The Java source code files should be under the 'src' folder. Java files are saved based on the package name. So if the package is com.example then the structure will be:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-06-04_19.29.16.png)  
  
Under 'libs' folder you can put any additional libraries that should be referenced during compilation.  
The 'bin' folder will be created during the build.  
  
When you press on the Compile button the code will be compiled and the Jar file and XML files will be outputted to the "additional libraries folder" that is set in Basic4android configuration.  
  
**Wrapper example**  
  
The attached zip file includes a very simpler wrapper that wraps [Flurry Analytics](http://www.flurry.com/flurry-analytics.html) library.  
  
The source code:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-06-04_19.37.03.png)  
  
In order to compile it (and use it) you should download their SDK and copy FlurryAgent.jar to the project 'libs' folder and to the 'additional libraries folder'.  
  
**Tips**  
  
- A simple example is included in the package (FirstLib). It is recommended to start with it.  
- You can use a text editor such as [Notepad++](http://notepad-plus-plus.org/) to write the Java code.  
- Tutorials about libraries development are available in this forum: <http://www.b4x.com/android/forum/forums/libraries-developers-questions.32/>  
- There is no installer. You should just unzip the package and run the program.  
- If you need to include any additional files, such as .so files, in the jar then you can create a folder named 'additional'. Any file or folder inside this folder will be added to the jar file.  
- **Command line mode** - You can also run this tool from the command line. It expects two arguments: library name and project path.  
  
- B4J\_SimpleLibraryCompiler is included in the zip file. It creates B4J libraries.  
- In order to write the library code with Eclipse you need to reference Java 7 and also reference jfxrt.jar:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-12-02_10.01.50.png)  
  
V1.15 - Adds support for lambdas.  
V1.14 - Fixes an issue with running SLC from command line.  
V1.13 - Added a field to set the path to Java 8 compiler (javac.exe). Should be similar to: C:\Program Files\Java\jdk1.8.0\_211\bin\javac.exe  
V1.12 (B4A) - source and target raised to Java 8.  
V1.11 - SLC tools compiled with .Net Framework 4.  
V1.10 - Adds support for the new structure of Additional libraries folder.  
March 2018 - New zip with doclet v1.07.  
V1.06 - Fixes the missing "bin\classes" issue.  
V1.05 - Fixes an issue with old compiled class files not being deleted.  
V1.03 - Fixes an issue related to B4A v5.  
V1.02 - Allows usages of Java 7 features.  
V1.01 - Fixes an issue with ignore field.  
  
Download link: [www.b4x.com/android/files/SimpleLibraryCompiler.zip](https://www.b4x.com/android/files/SimpleLibraryCompiler.zip)  
  
**You should use Java 8 with SLC (at least when generating the XML).**