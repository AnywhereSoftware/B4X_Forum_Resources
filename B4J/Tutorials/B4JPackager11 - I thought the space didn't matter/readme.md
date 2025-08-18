### B4JPackager11 - I thought the space didn't matter by Mark Read
### 05/10/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/140458/)

This is not really a tip or a tutorial, more of a warning for others.  
  
I made a small B4J program and wanted to distribute the program on a Windows 10 PC. As I was using jSerial, I followed the instructions [here](https://www.b4x.com/android/forum/threads/integrated-b4jpackager11-the-simple-way-to-distribute-standalone-ui-apps.117880/) for special case 5 and added the line to my program.  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 1000  
    #MainFormHeight: 800  
    'line below is required as jSerial is being used  
    'https://www.b4x.com/android/forum/threads/integrated-b4jpackager11-the-simple-way-to-distribute-standalone-ui-apps.117880/  
    #CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, ..\ temp\build\bin\ jssc.dll  
#End Region
```

  
  
I noticed that there was a space before "jssc.dll" and thought I could delete it as it was not required - Wrong! On running my program on another PC, jssc.dll could not be found. It seems that removing the space causes the file to be placed in a sub directory called jssc.dll. Leaving the space, places the file in "bin" directory as required. A silly mistake.  
  
I thought I was being clever but I should have realised, if Erel puts a space somewhere, it is required. He doesn't make typo's. :eek:. Of course, this applys to all of who post code. Everyone tries not to make typo's. Many thanks.