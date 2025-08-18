### Check if current Windows user is Administrator by Magma
### 06/02/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/140939/)

Hi there…  
  
a snippet for all guys need it…  
  
How to use it…  
1) First download zip-extract isadmin.bat and put it at your Assets (\Files)  
2) Copy - Paste the code at the module you want to have it…  
  

```B4X
Sub CheckifAdmin As ResumableSub  
    Dim isadmin As Boolean=False  
    If File.Exists(File.DirApp,"isadmin.bat")=False Then  
        File.Copy(File.DirAssets,"isadmin.bat",File.DirApp,"isadmin.bat")  
    End If  
  
    Dim js As Shell  
    Dim params As List  
    params.Initialize  
  
    js.Initialize("js", "isadmin.bat", params)  
    js.WorkingDirectory=File.DirApp  
    js.Run(-1)  
    Wait for (js) js_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success=True Then  
        Dim searchfor1 As String  
        searchfor1="is admin"  
        Dim a As Int=StdOut.IndexOf(searchfor1)  
        If a>0 Then  
            isadmin=True  
        End If  
    End If  
  
Return isadmin  
End Sub
```

  
  
How to use it…  

```B4X
    'Check if Admin  
    Wait for (CheckifAdmin) complete (ca As Boolean)  
    Main.isAdministrator=ca  
    If ca=False Then  
        Log("Not Admin!")  
        'show dialog, exit app  
  
        Else  
        Log("Is Admin!")  
        'continue…  
  
    End If
```

  
  
**Happy coding!**