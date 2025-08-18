### 3D Spinning Cube by Johan Schoeman
### 12/26/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/92442/)

It is mostly based on [**this posting**](https://www.ntu.edu.sg/home/ehchua/programming/android/Android_3D.html#zz-3.). It is a 3D spinning cube. The code is very simple (the lib does all the hard lifting). You can change the images of the 6 x faces of the cube by replacing image1.png to image6.png in the /DemoRes/drawable folder of the B4A project (too lazy now to add code to the project to allow adding the images from B4A). It can be \*.png or \*.jpg files - as long as you keep the naming convention of image1.\* to image6.\*  
  
1. Download the B4A project  
2. Download DemoRes.zip and once unzipped you need to copy the DemoRes folder and its contents to be on the same folder level as that of the /Files and /Objects folders of the B4A project  
3. Download the B4A lib files, extract them from the zipped file, and copy them to your additional library folder.  
4. Note the CustomView in the Designer.  
  
I have edited the images with GIMP just to make the interfaces more visible.  
  
This was done just for the fun of it…..:)  
  
  
B4A sample code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: b4aOpenGlesPhotoCube  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalRes: ..\DemoRes  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private gls1 As glSurfaceView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main")  
  
End Sub  
  
Sub Activity_Resume  
     
    gls1.RESUME  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
     
    gls1.PAUSE  
  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/67287)