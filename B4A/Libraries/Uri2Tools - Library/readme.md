###  Uri2Tools - Library. by T201016
### 03/22/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/139314/)

Hi,  
I provide the **Uri2Tools** library version 1.0 (2022.03.22)  
The code requires Android 6.0 or 8.1  
  
The library uses the following libraries:  
- B4XCollections v1.12  
- ContentResolver v1.50  
- Core v11.20  
- FileProvider v1.0  
- SQL v1.50  
- Storage v1.0  
  
I would like to thank the authors for providing them :)  
  
Uri2Tools provides information such as:  
- Dir (i.e. full path name of the file)  
- FileName (i.e. the name of the file)  
- FullPath (i.e. the full path name of the file)  
- NamePath (i.e. the name of the folder)  
- MimeType (i.e. file type "mime\_type")  
- Modified (ie the date of last modification "last\_modified")  
- RealName (i.e. the real file name)  
- Size (i.e. file size)  
- SizeUnit (i.e. file size (example: 32MB))  
- Success (i.e. the status of the operation's success (Load ("\* / \*", "Choose file"))  
  
in addition, it provides information:  
- GetSDKversion (i.e. a working version of the SDK on the phone)  
- DirRootExternal (i.e. the name of the full path on the device)  
- ExtSDCard (i.e. the name of the full path of the external memory)  
- OnlyDevice (i.e. checks if the phone has additional external memory)  
  
I hope the library will be a useful programming aid :)  
Greetings.  
  

```B4X
#Region Copyright  
    '******************************************************************************  
    ' This file is part of the B4A Project - URI2Tools (Library)  
    '  
    ' "Copyright © 2010 - 2021 Anywhere Software , B4A, Registered version 11.20"  
    '  
    '  
    '******************************************************************************  
#End Region  
  
#Region  Project Attributes  
    #ApplicationLabel: URI2Tools  
    #VersionCode: 1  
    #VersionName: 1.0  
    #LibraryAuthor: T201016  
    #LibraryVersion: 1.0  
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
  
    Private FileHandler As URI2Tools  
    Private Storage As Uri2Storage  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    FileHandler.Initialize  
    Wait For (FileHandler.Load("*/*","Choose file")) Complete (result As LoadResult)  
    
    'result as LoadResult  
    MsgboxAsync(result.Dir,"ResultLoad (DIR)")  
    MsgboxAsync(result.FileName,"ResultLoad (FILENAME)")  
    MsgboxAsync(result.FullPath,"ResultLoad (FULLPATH)")  
    MsgboxAsync(result.NamePath,"ResultLoad (NAMEPATH)")  
    MsgboxAsync(result.MimeType,"ResultLoad (MIMETYPE)")  
    MsgboxAsync(result.Modified,"ResultLoad (MODIFIED)")  
    MsgboxAsync(result.RealName,"ResultLoad (REALNAME)")  
    MsgboxAsync("Size: " & result.Size & CRLF & "Size Unit: " & result.SizeUnit,"ResultLoad (SIZE)")  
    MsgboxAsync(result.Success,"ResultLoad (SUCCESS)")  
    
    'result as Storage  
    Storage.Initialize  
    MsgboxAsync(Storage.GetSDKversion,"GetSDKversion")  
    MsgboxAsync(Storage.MapStorage.DirRootExternal,"DirRootExternal")  
    MsgboxAsync(Storage.MapStorage.ExtSDCard,"ExtSDCard")  
    MsgboxAsync(Storage.MapStorage.OnlyDevice,"OnlyDevice")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub
```