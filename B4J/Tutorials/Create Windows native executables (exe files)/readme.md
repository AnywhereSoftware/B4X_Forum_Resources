### Create Windows native executables (exe files) by Erel
### 03/26/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/35863/)

This tutorial is no longer relevant. Use B4JPackager11: [B4JPackager11 - the simplest way to distribute UI apps](https://www.b4x.com/android/forum/threads/99835)  
[SPOILER]When you compile in Release mode the complete app is packed as an executable jar file.  
  
You can distribute this jar file and run it on Windows, Mac or Linux.  
  
However there are cases where you want to convert this jar file to a native executable. For example if you want to set a custom icon.  
  
You can use a free tool named Launch4j to convert the jar file to a native Windows executable.  
  
1. Download Launch4j: <http://sourceforge.net/projects/launch4j/files/launch4j-3/>  
2. Compile your app in Release mode.  
3. Set the icon and other required parameters:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-12-19_15.34.01.png)  
  
![](http://www.b4x.com/basic4android/images/SS-2013-12-19_15.34.24.png)  
  
4. Click on the Build Wrapper button.  
  
![](http://www.b4x.com/basic4android/images/SS-2014-01-21_09.43.59.png)  
  
The output will be a standard Windows executable.  
  
For example:  
![](http://www.b4x.com/basic4android/images/SS-2013-12-19_15.36.28.png)  
  
**Another distribution option: <https://www.b4x.com/android/forum/threads/ui-apps-packaging-self-contained-installers.56854/>**  
B4J Packager will create a single installer file that includes an embedded Java Runtime.[/SPOILER]