### OreoHotspot (No password or SSID change) by somed3v3loper
### 10/07/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/110273/)

This was done for a job but it seems that the guy I made it for needed to change password and SSID which failed and I couldn't get any further response or donation :D  
  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Dim oreo As OreoHotspot  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    oreo.Initialize("oreo")  
  
'     
    If oreo.checkSystemWritePermission Then  
  
            oreo.StartTethering  
  
    Else  
        oreo.openAndroidPermissionsMenu  
    End If     
  
  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
Sub oreo_onfailed(err As String)  
    Log(err)  
    ToastMessageShow("oreo_onfailed : "&err,True)  
End Sub  
Sub oreo_onstopped  
    ToastMessageShow("oreo_onstopped",True)  
End Sub  
  
Sub oreo_onstarted  
  
    ToastMessageShow("onstarted",True)  
End Sub  
Sub Activity_Pause (UserClosed As Boolean)  
    If UserClosed Then  
        oreo.stopTethering  
    End If  
      
End Sub
```

  
  
[DOWNLOAD](https://drive.google.com/open?id=1FvNIL7N1PEL5jlWlSMAeJxIrx6wnIYEd)