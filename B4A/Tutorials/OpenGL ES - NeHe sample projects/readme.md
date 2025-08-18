### OpenGL ES - NeHe sample projects by Johan Schoeman
### 01/23/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/137850/)

Attached sample project is a wrap for [**this Github Project**.](https://github.com/nea/nehe-android-ports/tree/master/lesson09)  
  
Attached are the following:  
  
1. NeheLesson09.zip - it contains the library files (Jar and XML). Copy the Jar and XML to your additional library folder once you have extracted the files from the zip file. It also contains the sample B4A project (note that folder demoRes should be on the same folder level as the /Files and /Objects folders of the B4A project.  
2. srcLesson09.zip - the wrapper and the project that has been wrapped (the Java code)  
  
The sample code is very simple:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: b4aNeHeLesson09  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalRes: ..\demoRes  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
  
    Private l09 As Lesson09  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
End Sub  
  
Sub Activity_Resume  
     
    l09.RESUME  
  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
     
    l09.PAUSE  
  
  
End Sub
```

  
  
Designer code:  

```B4X
'All variants script  
AutoScaleAll  
  
l09.Left = 1%x  
l09.Top = 1%x  
l09.Width = 98%x  
l09.Height = l09.Width
```

  
  
A nice display of colorful "rotating" starts - enjoy!  
  
**Touch the very left and very right bottom corners of the view and see the display of the stars changing….**  
  
No plan to support this project - change the Java code to your liking to do whatever you want it to do.  
  
I will post more projects in this thread for some of the other "NeHe Lessons"  
  
  
![](https://www.b4x.com/android/forum/attachments/124585)