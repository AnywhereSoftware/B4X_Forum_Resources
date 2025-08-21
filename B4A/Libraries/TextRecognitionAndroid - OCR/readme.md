### TextRecognitionAndroid - OCR by Johan Schoeman
### 08/15/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/121018/)

A wrap for [**this Github project**](https://github.com/Sainathhiwale/TextRecognitionAndroid).  
  
1. Jar and XML attached - copy them to your additional libs folder  
2. B4A sample project attached  
3. resource.zip - extract the folder and copy the folder and its contents to be on the same folder level as that of the /Files folder of the B4A project  
  
Click on the active preview to bring back the Blocks, Lines, and Words (events will be raised is the B4A project)  
Watch the B4A Log when you click the active preview with text inside the active preview.  
  
Sure you will figure it out.  
  
Note that it does not show the graphic overlay!  
Take note of the B4A manifest file when starting a new project.  
  
**"…..Google Play Services must be active on a device……"**  
  
Edit: Update in post #14 of this thread  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: AndroidTextRecognition  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalRes: ..\resource  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
    Dim rp As RuntimePermissions  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private atr1 As AnroidTextRecognition  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
  
    Activity.LoadLayout("Layout")  
  
End Sub  
  
Sub Activity_Resume  
  
  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
  
  
End Sub  
  
Sub Button1_Click  
  
    Dim Result As Boolean = True                                                                   
    If Not(rp.Check(rp.PERMISSION_CAMERA)) Then                                                   
        rp.CheckAndRequest(rp.PERMISSION_CAMERA)                                                   
        Wait For Activity_PermissionResult (Permission As String, Result As Boolean)               
    End If                                                                                         
    If Result Then                                                                                 
        atr1.startScanning  
    End If  
End Sub  
  
Sub atr1_text_scanned_blocks(Blocks As Object)  
  
    Dim scannedBlocks As List = Blocks  
    For i = 0 To scannedBlocks.Size - 1  
        Log("scannedBlocks(" & i & ") = " & scannedBlocks.Get(i))  
    Next  
    Log(" ")  
  
End Sub  
  
Sub atr1_text_scanned_lines(Lines As Object)  
    Dim scannedLines As List = Lines  
    For i = 0 To scannedLines.Size - 1  
        Log("scannedLines(" & i & ") = " & scannedLines.Get(i))  
    Next  
    Log(" ")  
  
End Sub  
  
Sub atr1_text_scanned_words(Words As Object)  
    Dim scannedWords As List = Words  
    For i = 0 To scannedWords.Size - 1  
        Log("scannedWords(" & i & ") = " & scannedWords.Get(i))  
    Next  
    Log(" ")  
  
End Sub
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/98243)