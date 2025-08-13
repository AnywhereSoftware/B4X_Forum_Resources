### Android SFTP based on JSch tutorial by Erel
### 04/18/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/26994/)

[JSch](http://www.jcraft.com/jsch/) is an open source Java implementation of SSH2. It supports many features.  
  
Currently the Basic4android JSch library supports the SFTP protocol which is SSH File Transfer Protocol or Secured File Transfer Protocol.  
  
SFTP is similar to FTP with the difference that the communication is done over a secured channel.  
  
A good tutorial about SSH authentication is available here: [SSH Host Key Protection | Symantec Connect Community](http://www.symantec.com/connect/articles/ssh-host-key-protection)  
  
When the client first connects to the SSH server he needs to approve the host key (unless it is in the list of approved keys).  
  
![](http://www.b4x.com/basic4android/images/SS-2013-03-05_12.08.04.png)  
  
The SFtp object raises a PromptYesNo event for this question:  

```B4X
Sub sftp1_PromptYesNo (Message As String)  
   Dim res As Int = Msgbox2(Message, "", "Yes", "", "No", Null)  
   'The next line might be a bit confusing. It is a condition.  
   'The value will be True if res equals to DialogResponse.POSITIVE.  
   sftp1.SetPromptResult(res = DialogResponse.POSITIVE)  
End Sub
```

  
The network thread will wait until you call SetPromptResult or after 60 seconds. In the later case the result will be False.  
  
If you want to automatically accept the host key (which should only be done in a secured local network) then you can write:  

```B4X
Sub sftp1_PromptYesNo (Message As String)  
   sftp1.SetPromptResult(True)  
End Sub
```

  
  
Sftp should be declared as a process global variable and initialized in Activity\_Create (or Service\_Create):  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
      sftp1.Initialize("sftp1", "username", "password", "example.com", 22)  
      sftp1.SetKnownHostsStore(File.DirInternal, "hosts.txt")  
   End If  
   Activity.LoadLayout("1")  
End Sub
```

  
  
Calling SetKnownHostsStore sets a file that will save the known keys. Without it the user will need to approve the key each time.  
  
In Activity\_Resume we need to call SFtp.Activity\_Resume:  

```B4X
Sub Activity_Resume  
   sftp1.Activity_Resume  
End Sub
```

  
The purpose of this call is to redisplay the visible prompt if it was visible when the activity was paused. This is relevant for example when the user changes the orientation while the dialog is visible.  
  
SFtp can also show a message to the user in some cases. This is done with the ShowMessage event:  

```B4X
Sub sftp1_ShowMessage (Message As String)  
   Msgbox(Message, "")  
End Sub
```

  
  
The other methods work in the same way as the FTP object: [Android FTP tutorial](http://www.b4x.com/forum/showthread.php?p=57940)  
  
The library is attached. The open source project is embedded in the jar file.  
  
Updates:  
1.31 - New Rmdir method - deletes empty folders.  
1.30 - Based on the latest version of Jsch (0.1.54).