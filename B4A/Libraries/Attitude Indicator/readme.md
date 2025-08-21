### Attitude Indicator by Johan Schoeman
### 04/05/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/115905/)

A wrap for [**this Github project**](https://github.com/kplatfoot/android-rotation-sensor-sample). Attached the B4A sample project, B4A library files (jar and xml), and the wrapper source code. Copy the library files to your additional library folder.  
  
Sample code:  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: b4aSensorRotation  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
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
  
    Private ai1 As AttitudeIndicator  
    Private Label1 As Label  
    Private Label2 As Label  
    Private Label3 As Label  
    Private Label4 As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main")  
      
    ai1.EarthColor = Colors.ARGB(255, 0x86, 0x5b, 0x4b)  
    ai1.PitchLadderColor = Colors.ARGB(255, 0xff, 0xff, 0xff)  
    ai1.BottomPitchLadderColor = Colors.ARGB(255, 0xff, 0xff, 0x00)  
    ai1.MinPlaneColor = Colors.ARGB(255, 0xe8, 0xd4, 0xbb)  
    ai1.SkyColor = Colors.ARGB(255, 0x36, 0xb4, 0xdd)  
      
End Sub  
  
Sub Activity_Resume  
      
    ai1.startListening  
      
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
      
    ai1.stopListening  
  
End Sub  
  
  
Sub ai1_orientation_changed(pitch As Float, roll As Float)  
      
'    Log("pitch = " & pitch)  
'    Log("roll = " & roll)  
    Label3.Text = NumberFormat(pitch, 0,2)  
    Label4.text = NumberFormat(roll, 0, 2)  
      
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/91276)