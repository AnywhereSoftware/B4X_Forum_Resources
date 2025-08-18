### B4ABuilder / B4JBuilder - Command line compilation by Erel
### 04/18/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/50154/)

B4A v4.30 includes a new tool named B4ABuilder.exe (and B4J includes a similar tool named B4JBuilder.exe).  
  
This tool allows you to compile your projects from the command line. This can be useful if you need to build multiple projects or to build the same project with multiple configurations.  
  
It supports two tasks: Compiling to APK and library compilation (same option as in the IDE).  
  
Using this tool is quite simple.  
If you just run B4ABuilder.exe you will get the list of commands:  
  
![](https://www.b4x.com/android/forum/attachments/111847)  
  
Add -Task=build to build the project in the current folder:  
  
![](http://www.b4x.com/basic4android/images/SS-2015-02-02_16.51.46.png)  
  
You can change the base folder with the BaseFolder parameter.  
  
The builder will exit with a code of 0 if the operation completed successfully. If not the exit code will be 1.  
  
**Edit: There is an open issue with BaseFolder. Don't use this parameter for now.**