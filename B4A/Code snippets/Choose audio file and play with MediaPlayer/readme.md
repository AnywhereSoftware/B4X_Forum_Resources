### Choose audio file and play with MediaPlayer by fredo
### 11/10/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/111253/)

Although the use case (see title) sounds trivial, it took some time to get the result. The search returned many hits on the topic, from which the last valid "Single Point of Truth" could be found.  
  
The obstacles were the *read permission* and the *path provided* by the ContentChooser.  
  
Thanks to Erel's "[GetPathFromContentResult](https://www.b4x.com/android/forum/threads/get-the-path-to-media-files-returned-from-contentchooser.39313/)()" the path format expected by the MediaPlayer could be determined.  
  
  
[SPOILER="code"]  

```B4X
' ————————  
' Mainfest  
' ————————  
'This code will be applied to the manifest file during compilation.  
'You do not need to modify it in most cases.  
'See this link for for more information: https://www.b4x.com/forum/showthread.php?p=78136  
AddManifestText(  
<uses-sdk android:minSdkVersion="15" android:targetSdkVersion="28"/>  
<supports-screens android:largeScreens="true"  
    android:normalScreens="true"  
    android:smallScreens="true"  
    android:anyDensity="true"/>)  
SetApplicationAttribute(android:icon, "@drawable/icon")  
SetApplicationAttribute(android:label, "$LABEL$")  
CreateResourceFromFile(Macro, Themes.DarkTheme)  
'End of default text.  
  
AddPermission(android.permission.WRITE_EXTERNAL_STORAGE)  
AddPermission(android.permission.READ_EXTERNAL_STORAGE)  
  
  
' ————————  
' Main  
' ————————  
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: True     
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
    Private mp As MediaPlayer  
End Sub  
  
Sub Globals  
    Private LabelDir As Label  
    Private LabelFile As Label  
    Private LabelFilePath As Label  
    Private Action_Play As Label  
    Private Action_Stop As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout1")  
    mp.Initialize  
End Sub  
  
Sub Activity_Resume  
End Sub  
Sub Activity_Pause (UserClosed As Boolean)  
End Sub  
  
Sub Button1_Click As ResumableSub  
    Dim cc As ContentChooser  
    cc.Initialize("cc")  
    cc.Show("audio/*", "Choose audio file")  
    wait for cc_Result (Success As Boolean, Dir As String, FileName As String)  
  
    If Success Then  
        LabelDir.Text  = Dir  
        LabelFile.Text = FileName  
        Log("#-  x51, LabelDir.Text  = " & LabelDir.Text)   ' ContentDir  
        Log("#-  x52, LabelFile.Text = " & LabelFile.Text)  ' content://com.android.providers.media.documents/document/audio%3A128  
  
        Private rp As RuntimePermissions  
        rp.CheckAndRequest(rp.PERMISSION_READ_EXTERNAL_STORAGE)  
        Wait For Activity_PermissionResult (permission As String, Result As Boolean)  
        If Result = False Then  
            Return Null  
        End If  
          
        Dim FilePath As String = GetPathFromContentResult(LabelFile.Text, "audio")  
        LabelFilePath.Text = FilePath ' /storage/emulated/0/Music/Gong - Time Is The Key/01-Ard Na Greine.mp3  
          
        mp.Load("", FilePath)  
          
    Else  
        LabelDir.Text = "ContentChoose failed"  
        LabelFile.Text = ""  
        LabelFilePath.Text = ""  
    End If  
      
    Action_Play.Visible = Success  
    Return Null  
End Sub  
  
Sub Action_Play_Click  
    mp.Play  
    Action_Stop.Visible = True  
End Sub  
Sub Action_Stop_Click  
    mp.Stop  
    Action_Stop.Visible = False  
End Sub  
  
Sub GetPathFromContentResult(UriString As String, MediaType As String) As String  
    ' Erel –> https://www.b4x.com/android/forum/threads/get-the-path-to-media-files-returned-from-contentchooser.39313/  
    If UriString.StartsWith("/") Then Return UriString 'If the user used a file manager to choose the image  
    Dim Cursor1 As Cursor  
    Dim Uri1 As Uri  
    Dim Proj() As String = Array As String("_data")  
    Dim cr As ContentResolver  
    cr.Initialize("")  
    If UriString.StartsWith("content://com.android.providers.media.documents") Then  
        Dim i As Int = UriString.IndexOf("%3A")  
        Dim id As String = UriString.SubString(i + 3)  
  
        Uri1.Parse($"content://media/external/${MediaType}/media"$) ' MediaType: images, audio  
  
        Cursor1 = cr.Query(Uri1, Proj, "_id = ?", Array As String(id), "")  
    Else  
        Uri1.Parse(UriString)  
        Cursor1 = cr.Query(Uri1, Proj, "", Null, "")  
    End If  
    Cursor1.Position = 0  
    Dim res As String  
    res = Cursor1.GetString("_data")  
    Cursor1.Close  
    Return res  
End Sub
```

  
[/SPOILER]  
  
The question remains whether it is possible to use the content path   
[INDENT]
> content://com.android.providers.media.documents/document/audio%3A124

[/INDENT]  
directly.