### [updated] GoogleDrive via REST API V3 - Small Testproject by fredo
### 10/30/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/95778/)

**Updated Oct 30, 2023**

  
Attached is a small project (version 19) to get a grip on Google Drive.  
  
[Most work was done by mw71](https://www.b4x.com/android/forum/threads/googledrive-via-api-v3.80775/), but this brings it all together from scattered informations to a usable entrypoint.  
[INDENT][/INDENT]  
[INDENT][SPOILER="The prehistory"][/SPOILER][/INDENT]  
[SPOILER="The prehistory"]  
[INDENT][/INDENT]  
> [INDENT]' ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~–[/INDENT]  
> [INDENT]' Previous Info sources on B4X (sorted by date DEC)[/INDENT]  
> [INDENT]' ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~–[/INDENT]  
> [INDENT]' 2018-06-01, Erel, OAUTH2, v2.10 –> <https://www.b4x.com/android/forum/threads/class-b4x-google-oauth2.79426/#content>[/INDENT]  
> [INDENT]' 2017-08-26, mw71, testconnect, –> <https://www.b4x.com/android/forum/threads/problems-with-oauth.80174/page-2#post-526872>'[/INDENT]  
> [INDENT]' 2017-08-18, mw71, googledrive\_playing –> <https://www.b4x.com/android/forum/threads/problems-with-oauth.80174/#post-524978>[/INDENT]  
> [INDENT]' 2017-06-20, mw71, Testconnect –> <https://www.b4x.com/android/forum/threads/googledrive-via-api-v3.80775/#post-512176>[/INDENT]  
> [INDENT]' 2017-06-18, mw71, GDrive via APIv3 –> <https://www.b4x.com/android/forum/threads/googledrive-via-api-v3.80775/>[/INDENT]  
> [INDENT]' 2017-06-04, mw71, upload file –> <https://www.b4x.com/android/forum/threads/http-patch-request.80261/#post-508444>[/INDENT]  
> [INDENT][/INDENT]  
>  ' ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~– ~~~–  
>  ' 2023-10-28, JohnC, changes in libs and modules –> <https://www.b4x.com/android/forum/threads/googledrive-via-rest-api-v3-small-testproject.95778/post-964342>

  
  
[INDENT][/INDENT]  
[/SPOILER]  
[INDENT][/INDENT]  
[INDENT][/INDENT]  
[INDENT][SPOILER="The Setup"][/SPOILER][/INDENT]  
[SPOILER="The Setup"]  
[INDENT]Libraries:[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/147364)[/INDENT]  
  
[INDENT]Modules:[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/147365)[/INDENT]  
[INDENT]Manifest:[/INDENT]  
[INDENT][/INDENT]  

```B4X
'This code will be applied to the manifest file during compilation.  
  
'You do not need to modify it in most cases.  
  
'See this link for for more information: https://www.b4x.com/forum/showthread.php?p=78136  
  
AddManifestText(  
  
<uses-sdk android:minSdkVersion="20" android:targetSdkVersion="33"/>  
  
<supports-screens android:largeScreens="true"  
  
    android:normalScreens="true"  
  
    android:smallScreens="true"  
  
    android:anyDensity="true"/>)  
  
SetApplicationAttribute(android:icon, "@drawable/icon")  
  
SetApplicationAttribute(android:label, "$LABEL$")  
  
'End of default text.  
  
AddActivityText(Main,  
  
  <intent-filter>  
  
        <action android:name="android.intent.action.VIEW" />  
  
        <category android:name="android.intent.category.DEFAULT" />  
  
        <category android:name="android.intent.category.BROWSABLE" />  
  
        <data android:scheme="$PACKAGE$" />  
  
    </intent-filter>  
  
    )
```

  
  
[INDENT]Notes:[/INDENT]  
[INDENT]1. The module GoogleOauth2 contains ["Sub Testconnect" from mw71](https://www.b4x.com/android/forum/threads/problems-with-oauth.80174/page-2#post-526872)[/INDENT]  
[INDENT]2. Read ***and understand*** the project specific setup below[/INDENT]  
[INDENT][/INDENT]  
[/SPOILER]  
[INDENT][/INDENT]  
[INDENT][/INDENT]  
[INDENT][SPOILER="Setup the API project and get the "Client Id""][/SPOILER][/INDENT]  
[SPOILER="Setup the API project and get the "Client Id""]  
[INDENT]Create a new project in the [Google AP developer console](https://console.developers.google.com/projectcreate)[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/70603)[/INDENT]  
  
[INDENT]Select "Google Drive API" in the dashboard[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/70604)[/INDENT]  
  
[INDENT]Enable the API[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/70605)[/INDENT]  
  
[INDENT]Create credentials[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/70606)[/INDENT]  
[INDENT]As alerted by (1) on first entry you may create the credentials via button (2) right now. It is recommended to create credentials via button (3)[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/70615) ![](https://www.b4x.com/android/forum/attachments/70616) ![](https://www.b4x.com/android/forum/attachments/70618)[/INDENT]  
[INDENT][/INDENT]  
[INDENT]You need to fill in "SHA-1" and "Package name". Both are available in your B4A IDE:[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/70610) ![](https://www.b4x.com/android/forum/attachments/70611)[/INDENT]  
  
  
[INDENT]Then receive your client ID:[/INDENT]  
[INDENT]![](https://www.b4x.com/android/forum/attachments/70619)[/INDENT]  
  
  
> …then scroll down to the "**Advanced Settings**" and check-mark the "**Enable Custom URI Scheme**" (then it says it may take 5 mins to a few hours for the change to take effect). @John  
>   
> ![](https://www.b4x.com/android/forum/attachments/147367)

  
  
[INDENT][/INDENT]  
[/SPOILER]  
[INDENT][/INDENT]  
[INDENT][/INDENT]  
[INDENT]The program sequence is as follows:[/INDENT]  
[INDENT]1. "GoogleDrive" is initialized in Main with the "ClientId" for Oauth2[/INDENT]  
[INDENT]1.1 "GoogleDrive" initializes "GoogleOauth2" and informs about the "Scope= ….drive"[/INDENT]  
  
[INDENT]2. Main calls "ConnectToDrive" and waits for message from "GD\_Connected".[/INDENT]  
[INDENT]2.1 "GoogleDrive" requests an AccessToken via "GoogleOauth2"[/INDENT]  
[INDENT]2.2 "GoogleDrive" executes a "TestConnect" and reports via "GD\_Connected" to waiting Main[/INDENT]  
  
[INDENT]3. Main displays the AccessToken in Label1[/INDENT]  
  
[INDENT]With the AccessToken several actions can be can performed with the drive:[/INDENT]  
[INDENT]<https://developers.google.com/drive/api/v3/reference/files#methods>[/INDENT]  
[INDENT]*If you need a "ClientSecret" at some point create a new OAuth2 ClientId with the ApplicationType "Web application"*[/INDENT]  
[INDENT][/INDENT]  
[INDENT][/INDENT]  
   
[SPOILER="The code to use this"]  

```B4X
' ——————————————————————————  
Sub btnStart_Click As ResumableSub  
   Log("#-btnStart_Click ———————————–")  
   Label1.Text = "(Trying to connect to Google Drive…)"  
   GD.Initialize(Me, "GD", ClientIdOauth, ClientSecret) ', AppApiKey)  
   GD.ConnectToDrive  
   wait for GD_Connected(mapRet As Map)  
   ' ww~~– ww~~– ────────────────────  
   '  
   'Log("#-  x129, GD_Connected, mapRet=" & mapToPrettyString(mapRet) )  
   Label1.Text = "Access_token= " & mapRet.GetDefault("access_token", "?")  
   '  
   GD.ShowFileList("")  
   wait for GD_FileListResult(lstFiles As List)  
   ' ww~~– ww~~– ────────────────────  
   '  
   Log("#-GD_FileListResult, lstFiles=" & lstToPrettyString(lstFiles) )  
   ListView1.Clear  
   Dim lblX As Label  
   lblX = ListView1.SingleLineLayout.Label  
   lblX.TextSize = 12  
   lblX.TextColor = Colors.Green  
   For i=0 To lstFiles.Size -1  
       ListView1.AddSingleLine(lstFiles.Get(i))  
   Next  
   '  
   btnCreaFolder.Enabled = True  
   btnUpload.Enabled = True  
   btnDownload.Enabled = True  
   btnSearch.Enabled = True  
   '  
   Return Null  
End Sub  
' ——————————————————————————  
Sub btnCreaFolder_Click As ResumableSub  
   Log("#-")  
   Log("#- —*** —*** —*** —*** —*** —*** —*** —*** ")  
   Log("#-Sub btnCreaFolder_Click")  
   Dim strFolderParentID As String = ""  
   edtFolderToCreate.Text = "Testfolder_01"  
   Label3.Text = $"(Trying to create folder ${edtFolderToCreate.Text})"$  
   GD.CreateFolder(edtFolderToCreate.Text, strFolderParentID)  
   wait for GD_FolderCreated(strFileId As String)  
   ' ww~~– ww~~– ────────────────────  
   '  
   Label3.Text = "FileId= " & strFileId  
   Log("#-  x178, strFileId=" & strFileId)  
   Return Null  
End Sub  
' ——————————————————————————  
Sub btnUpload_Click As ResumableSub  
   Log("#-")  
   Log("#- —*** —*** —*** —*** —*** —*** —*** —*** ")  
   Log("#-Sub btnUpload_Click")  
   Dim strFolderParentID As String = ""  
   Dim strFilenameInGdrive As String = "testdatafile4"  
   EditText2.Text = strFilenameInGdrive  
   Dim strFileToUpload As String     = "testdata2.json"  
   Label2.Text = $"(Trying to upload ${strFileToUpload})"$  
   GD.UploadFile("", File.DirAssets, strFileToUpload, strFolderParentID, strFilenameInGdrive)  
   wait for GD_FileUploadDone(strFileId As String)  
   ' ww~~– ww~~– ────────────────────  
   '  
   Label2.Text = "FileId= " & strFileId  
   Log("#-  x130, strFileId=" & strFileId)  
  
   edtFileToDownload.Text = strFileId  
  
   Return Null  
End Sub  
' ——————————————————————————  
Sub btnSearch_Click As ResumableSub  
   Log("#-")  
   Log("#- —*** —*** —*** —*** —*** —*** —*** —*** ")  
   Log("#-Sub btnSearch_Click")  
   Label4.Text = $"(Trying to search for ${EditText2.Text.Trim})"$  
   GD.SearchForFileID(EditText2.Text.Trim, EditText1.Text.Trim)  
   wait for GD_FileFound(strFileId As String)  
   ' ww~~– ww~~– ────────────────────  
   '  
   Label4.Text = "FileId= " & strFileId  
   Log("#-  x170, strFileId=" & strFileId)  
   Return Null  
End Sub  
' ——————————————————————————  
Sub btnDownload_Click As ResumableSub  
   Log("#-")  
   Log("#- —*** —*** —*** —*** —*** —*** —*** —*** ")  
   Log("#-Sub btnDownload_Click")  
  
   Label5.Text = $"(Trying to download ${edtFileToDownload.Text.Trim})"$  
   GD.DownloadFile(edtFileToDownload.Text.Trim, File.DirDefaultExternal, "aaa_file_" & edtFileToDownload.Text.Trim)  
   wait for GD_FileDownloaded(strRet As String)  
   ' ww~~– ww~~– ────────────────────  
   '  
   Label5.Text = "strRet= " & strRet  
   Log("#-  x203, strRet=" & strRet)  
  
End Sub  
' ——————————————————————————
```

  
  
  
[/SPOILER]  
[INDENT][/INDENT]  
[INDENT][/INDENT]  
During the first run you might see a warning if the app hasn't been verified:  
  
![](https://www.b4x.com/android/forum/attachments/147369)  
  
  
*Just click "Advanced" and "Go to grive…"*  
  
Now you're ready to test:  
  
![](https://www.b4x.com/android/forum/attachments/70633)  
  
[SPOILER="Some helpful readings…"]  
[INDENT]

- [Google Drive basics of files and folders](https://developers.google.com/drive/api/v3/about-files)
- [Professional Blog](http://www.daimto.com/google-development-beginners/) (some specific to C#, but the mechanism explanations are easy to understand)
- [Some GoogleDrive error hints](https://developers.google.com/drive/api/v3/handle-errors)

[/INDENT]  
[/SPOILER]  
  
[SPOILER="Methods"]  

```B4X
'           Sub ConnectToDrive  
'            Sub ShowFileList(ParentFolderID As String)  
'            Sub CreateFolder(FolderName As String, ParentFolderID As String)  
'            Sub UploadFile(FileId As String, LocalPath As String, LocalFilename As String, ParentFolderID As String, Name As String)  
'            Sub DownloadFile(FileID As String, LocalPath As String, LocalFilename As String)  
'            Sub SearchForFileID(SearchFile As String, ParentFolderID As String)  
'            Sub SearchForFolderID(SearchFolder As String, ParentFolderID As String)
```

  
  
[/SPOILER]  
  
If something is fundamentally wrong, please explain and enclose a corresponding test project.  
  
*Questions should be asked in the Android questions forum including errormessages or code in code-tags.  
  
**Edit: Testproject updated to 19 due to module, lib and setupcondition bits.***  
  
Info: If you have trouble with apostrophes in the name of files or folders then this will help (thanks to [USER=13742]@Dave O[/USER]): <https://www.b4x.com/android/forum/threads/minor-fix-to-googledrive-api-for-folder-names-with-apostrophes.130495/>