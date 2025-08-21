### Change Icon and Assets Files based on the Build Configuration by Erel
### 03/30/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/40875/)

This tutorial explains how the new conditional compilation feature can be used to change the app icon and the assets files based on the chosen build configuration.  
See this tutorial for more information about build configurations: <http://www.b4x.com/android/forum/threads/40746/#content>  
  
We have an app with two build configurations: Trial and Full. We want to change the icon and the included files based on the chosen configuration.  
  
The first step is to create two folders in the project folder, fullonly and trialonly:  
  
![](http://www.b4x.com/basic4android/images/SS-2014-05-11_11.13.10.png)  
  
We use Robocopy, a windows built-in utility (replaces xcopy), to copy the correct files to a subfolder named extra. Robocopy mirrors the source folder. This means that files in the target folder that don't belong to the source folder will be deleted.  
  
The next step is to copy the icon file (which is in the main project folder) to the project icon file.  
  
This is the complete code:  

```B4X
#IgnoreWarnings: 17  
  
#If FULL  
   #CustomBuildAction: 1, c:\windows\system32\robocopy.exe, ..\fullonly ..\files\extra /MIR  
   #CustomBuildAction: 1, c:\windows\system32\cmd.exe, /c copy ..\full_icon.png res\drawable\icon.png  
#End If  
  
#If TRIAL  
   #CustomBuildAction: 1, c:\windows\system32\robocopy.exe, ..\trialonly ..\files\extra /MIR  
   #CustomBuildAction: 1, c:\windows\system32\cmd.exe, /c copy ..\trial_icon.png res\drawable\icon.png  
#End If  
  
Sub Activity_Create(FirstTime As Boolean)  
   Activity.SetBackgroundImage(LoadBitmap(File.DirAssets, "extra/logo.png"))  
End Sub
```

  
  
**Notes**  
  
- **The file names and the name of the "extra" folder must be lower-case**.  
- The files **do not** need to be read-only.  
- #IgnoreWarnings 17 removes the warnings related to the usage of files not added to the project.  
- In debug mode the icon file will only be updated after a "full installation". The files will be updated whenever needed.  
- Note how the file is accessed. The subfolder must be part of the file, not File.DirAssets.