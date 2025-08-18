###  Tip - ROBOCOPY error related to shared files folder by Erel
### 11/10/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/124408/)

You download a project from the forum and when you run it, you get an error message similar to:  
  

```B4X
B4A Version: 10.2  
Java Version: 8  
Parsing code.    (0.11s)  
Building folders structure.    (0.02s)  
Running custom action.    Error  
——————————————————————————-  
   ROBOCOPY     ::     Robust File Copy for Windows                               
——————————————————————————-  
  Started : Tuesday, November 10, 2020 8:05:40 AM  
   Source : C:\Users\H\DOWNLO~1\projects\Shared Files\  
     Dest : C:\Users\H\DOWNLO~1\projects\B4A\Files\  
    Files : *.*  
          
  Options : *.* /DCOPY:DA /COPY:DAT /R:1000000 /W:30  
——————————————————————————  
2020/11/10 08:05:40 ERROR 2 (0x00000002) Accessing Source Directory C:\Users\H\DOWNLO~1\projects\Shared Files\  
The system cannot find the file specified.
```

  
  
**Fix** - Go to the top of B4XMainPage and delete this line:  

```B4X
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
```

  
  
**Why it happens?**  
  
It happens with B4XPages projects, when the developer uses File - Export as zip to create the zip file instead of clicking on:  

```B4X
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
```

  
The Zipper tool is more sophisticated and it preserves the B4XPages project structure.