### HBRecorder (Screen recorder) by somed3v3loper
### 10/10/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/110351/)

This [project](https://github.com/HBiSoft/HBRecorder) in B4A (not complete )  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Dim hbRecorder As hbrecorder  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_READ_EXTERNAL_STORAGE)  
    Wait For Activity_PermissionResult(perm As String,res As Boolean)  
    If perm=Starter.rp.PERMISSION_READ_EXTERNAL_STORAGE And res=True Then  
    Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_WRITE_EXTERNAL_STORAGE)  
    Wait For Activity_PermissionResult(perm As String,res As Boolean)  
        If perm=Starter.rp.PERMISSION_WRITE_EXTERNAL_STORAGE And res=True Then  
    Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_RECORD_AUDIO)  
        Wait For Activity_PermissionResult(perm As String,res As Boolean)  
        If perm=Starter.rp.PERMISSION_RECORD_AUDIO And res=True Then  
            hbRecorder.Initialize("rec")  
            hbRecorder.enableCustomSettings  
  
                hbRecorder.OutputPath= Starter.rp.GetSafeDirDefaultExternal("HBRecorder")  
            hbRecorder.AudioBitrate=128000  
            hbRecorder.AudioSamplingRate=44100  
            If hbRecorder.isBusyRecording Then  
                Log("busy")  
            Else  
                Log("Not busy")  
            End If  
        End If  
    End If  
     
    End If  
    hbRecorder.shouldShowNotification(True)  
    hbRecorder.NotificationTitle="Title"  
    hbRecorder.NotificationSmallIcon="icon"  
    hbRecorder.NotificationDescription="Description"  
     
    hbRecorder.startRecordingScreen        
End Sub  
Sub rec_resultarrived(arg As Int,data As Intent)  
    If data.IsInitialized Then  
        Log("rec_resultarrived")  
         
        hbRecorder.recordHDVideo(False)  
        hbRecorder.isAudioEnabled(False)  
        hbRecorder.startScreenRecording(arg ,data)  
    End If  
  
End Sub  
Sub rec_hbrecorderonerror(errcode As Int)  
    Log("rec_hbrecorderonerror: "&errcode)  
End Sub  
Sub rec_hbrecorderoncomplete  
    Log("rec_HBRecorderOnComplete")  
End Sub  
  
Sub Activity_click  
    Log("Clicked"&hbRecorder.isBusyRecording)  
    hbRecorder.stopScreenRecording  
End Sub
```

  
  
Manifest  

```B4X
AddApplicationText(  
    <service android:name="com.hbisoft.hbrecorder.ScreenRecordService">  
        <intent-filter >  
            <action android:name="com.hbisoft.hbrecorder.ScreenRecordService" />  
        </intent-filter >  
    </service>)
```