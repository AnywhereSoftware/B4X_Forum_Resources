###  B4X lib automatic build by Alessandro71
### 04/12/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/116238/)

Trying to find an automated way to build a B4X library, I found this method, I'd like to share for improvements and suggestions.  
I'm using B4J as the development environment for the sake of simplicity.  
I've created a Non-UI application, just to have a framework to test the code in.  
My first hurdle was finding a way to properly backup a library project, since it must contains a manifest.txt, which is not backed up with the usual "export to zip" method.  
So I opted for adding the manifest.txt in the files section: it will be marked as unused in the logs, but it will be included in the backup.  
In the Main module, I modified the Project Region as follows  

```B4X
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
  
    'create B4X library  
    #CustomBuildAction: 1, c:\windows\system32\cmd.exe, /c "copy ..\Files\manifest.txt .."  
    #CustomBuildAction: 1, C:\Progra~1\Java\jdk1.8.0_131\bin\jar.exe, -cMf ..\libraryname.b4xlib ..\manifest.txt ..\module.bas  
#End Region
```

  
Compiling the code, as usual, will also produce the b4xlib file in the project root directory.  
You may need to customize the jar.exe PATH according to your environment, and also add a copy command to move the b4xlib file to your Libraries folder.