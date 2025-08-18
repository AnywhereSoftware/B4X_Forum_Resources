### Check if your app runs as Admin (Windows) (with Admin Rights) by Magma
### 06/02/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/140940/)

Hi there…  
  
a snippet for all guys need it… i think is more useful than to check if current user is Admin….  
Check if you app runs with Admin Rights…  
  
How to use it…  
1) Copy - Paste the code at the module you want to have it…  
  

```B4X
Sub CheckifRunAsAdmin As ResumableSub  
    Dim runasadmin As Boolean=False  
  
    Dim js As Shell  
    Dim params As List  
    params.Initialize  
  
    params.Add("session")  
    
    js.Initialize("js", "net.exe", params)  
    js.WorkingDirectory=File.DirApp  
    js.Run(-1)  
    Wait for (js) js_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success=True Then  
        Dim searchfor1 As String  
        searchfor1="5"  
        Dim a As Int=StdOut.IndexOf(searchfor1)  
        If a>0 Then  
            runasadmin=True  
        End If  
    End If  
  
    Return runasadmin  
End Sub
```

  
  
How to use it…  

```B4X
    'Check if run as Admin  
    Wait for (CheckifRunAsAdmin) complete (ca As Boolean)  
    Main.isAdministrator=ca  
    If ca=False Then  
        Log("Not run as Admin!")  
        'show dialog  
  
        Else  
        Log("Is running as Admin!")  
    End If
```

  
  
**Happy coding!**