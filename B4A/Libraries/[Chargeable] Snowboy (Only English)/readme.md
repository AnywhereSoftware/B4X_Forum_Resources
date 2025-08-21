### [Chargeable] Snowboy (Only English) by somed3v3loper
### 09/22/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/109826/)

Hello all ,  
I did this wrap for a specific job but as there were other requests , I create a thread here for any one interested .  
  
Please note that it is not a complete wrap and I could not manage to add any other language   
Here is a sample  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Snowboy Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Dim rp  As RuntimePermissions  
    Dim snb As snowboy  
      
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
      
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    rp.CheckAndRequest(rp.PERMISSION_READ_EXTERNAL_STORAGE)  
End Sub  
Sub Activity_PermissionResult (Permission As String, Result As Boolean)  
    If Permission = rp.PERMISSION_READ_EXTERNAL_STORAGE And Result= True Then  
        rp.CheckAndRequest(rp.PERMISSION_RECORD_AUDIO)  
    Else If Permission = rp.PERMISSION_RECORD_AUDIO And Result= True Then  
        Log("Lets snowboy")  
        snowboy  
    End If  
End Sub  
Sub snowboy  
      
    snb.DEFAULT_WORK_SPACE=File.DirInternal&"/snowboy/"  
    snb.copyResFromAssetsToSD  
  
    snb.ACTIVE_UMDL="jarvis.pmdl"  
          
    snb.Initialize("sn",Array As String("snowboy.umdl","jarvis.pmdl"))  
  
    snb.setProperVolume  
    snb.SetSensitivity("0.8,0.80")  
  
    Log(snb.NumHotwords)  
  
    snb.ApplyFrontend(True)  
    snb.startRecording  
End Sub  
Sub sn_error(msg As String)  
    Log("error: "&msg)  
End Sub  
Sub sn_detected(res As String)  
    Log("detected "&res)  
End Sub  
Sub Activity_Resume  
  
End Sub  
  
Sub activity_longclick  
  
    Log("stopRecording")  
End Sub  
Sub Activity_Pause (UserClosed As Boolean)  
    snb.stopRecording  
End Sub
```

  
  
If you think this is enough for you please send a donation to [email]thinkshuja@gmail.com[/email] and let me know here , PM or via email