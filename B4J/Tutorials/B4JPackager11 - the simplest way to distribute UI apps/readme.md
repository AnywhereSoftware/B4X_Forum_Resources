### B4JPackager11 - the simplest way to distribute UI apps by Erel
### 02/28/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/99835/)

Better to start with the integrated packager: <https://www.b4x.com/android/forum/threads/integrated-b4jpackager11-the-simple-way-to-distribute-standalone-ui-apps.117880/>  
B4JPackager11 is a B4J non-ui program that builds a package with your app jar and an embedded modularized Java runtime.  
  
It works with OpenJDK 11 and B4J v6.8+.  
  
Lets start with the output.  
  
It looks like this:  
  
![](https://www.b4x.com/basic4android/images/SS-2018-11-28_16.43.14.png)  
  
- run.exe is the executable (starting from v1.14 the executable name is based on the jar name). The executable file depends on the other folders. You can distribute the executable and the folders and it will work without any other dependencies.  
- run\_debug.bat starts the program with a console that shows the program output.  
It also creates a template Inno Setup script in the parent folder which you can use to build an installer. The installer will be a single.  
On Mac and Linux it doesn't create an executable. It instead creates a bash script file that can be used to start the program.  
  
There are two ways to run B4JPackager11:  
  
**Directly from B4J** - Start with this method.  
  
Just set the InputJar path and run it.  
  
There are several additional parameters that you can configure:  
- NetFrameworkCSC - Path to to the C# compiler which is part of .Net Framework.  
- IconFile - Path to the executable icon file (.ico file).  
- ExcludedModules - List of excluded modules. javafx.web is excluded by default. You need to remove it from the list if you are using WebView.  
- IncludedModules - List of included modules. Should be empty in most cases as the tool tries to discover the dependent modules automatically.  
- AdditionalModuleInfoString - A string that will be added to the module.info file. This is required in some cases such as with jPOI: <https://www.b4x.com/android/forum/threads/105311/#content>  
  
**Command line with a json file**  
  
You can create a json file with the input jar and optionally other settings and run it from the command line:  

```B4X
<java 11>\bin\java -jar B4JPackager11.jar <json file>
```

  
  
The json file should look like this:  

```B4X
{  
   InputJar: "C:/Users/H/Documents/B4X/X2/Angry Birds/B4J/Objects/AngryBirds.jar"  
}
```

  
Use forward slashes as I did above.  
  
If you want to remove javafx.web from the excluded modules:  

```B4X
{  
   InputJar: "C:/Users/H/Documents/B4X/X2/Angry Birds/B4J/Objects/AngryBirds.jar",  
   ExcludedModules: []  
}
```

  
  
**Platforms**  
  
You must build the package on the target platform.  
Windows - Java 11+ should already be installed. Note that Java 11+ is 64 bit only.  
Mac - use MacSigner <https://www.b4x.com/android/forum/threads/macsigner-building-notarized-mac-packages.130890/#content>  
Linux - <https://www.b4x.com/b4j/files/java/linux_jdk-14.0.1.zip>  
  
**Notes**  
  
- All files in the packager temp folder are deleted when it runs.  
- MediaPlayer will fail to play files from File.DirAssets. Copy them when the program starts.  
  
**Updates**  
  
- V1.21 - Integrated version. Adds support for Java 14.  
- V1.15 - Updated the inno script template based on Peter's suggestions: <https://www.b4x.com/android/forum/threads/b4jpacker11-add-3-lines-and-change-1-line-in-the-inno-setup-file-by-default-maybe.114539/>  
- V1.14 - The executable name is set to be the same as the input jar name. Internally it also creates a copy of javaw.exe with the same name. This sets the process name in task manager. Note that the description will still be "OpenJDK …".  
- V1.13 - Allows configuring VM arguments. It can be done with the VMArgs global variable or a VMArgs key in the json file.  
- V1.12 - Skips automatic inclusion for services based on inner classes as it breaks the jdeps tool.  
- V1.11 - Adds a check that InputJar points to a jar file.  
- V1.10 - Adds support for command line arguments. Usage example: <https://www.b4x.com/android/forum/threads/associating-files-with-your-app.106984/>  
(Currently only supported on Windows)  
- V1.05 - Fixes the "failed to delete temp folder" issue when the folder is open in Windows Explorer.  
- V1.04 - New AdditionalModuleInfoString field. This is required when packaging for an app that uses jPOI.  
- v1.02 - Configures the Inno Setup script to 64 bit.  
- v1.01 - Fixes a localization issue.