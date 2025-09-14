### Rename result.jar using #Macro or #CustomBuildAction by aeric
### 09/12/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168616/)

Note #1: To use the following snippets, remove the blank space in between cmd and .exe due to forum script check.  
  

```B4X
#Macro: Title, Rename, ide://run?file=%WINDIR%\System32\cmd .exe&Args=/c&Args=ren&Args=result.jar&Args=libget-non-ui.jar
```

  
  

```B4X
#If Release  
#CustomBuildAction: 2, C:\Windows\System32\cmd .exe, /c del libget-non-ui.jar  
#CustomBuildAction: 2, C:\Windows\System32\cmd .exe, /c ren result.jar libget-non-ui.jar  
#End If
```

  
  
Note #2: An error will occur as the IDE unable to call the result.jar after renamed.  
This is useful if the app exit eventually.  
  
Example for [[Tool] Additional Libraries Downloader](https://www.b4x.com/android/forum/threads/tool-additional-libraries-downloader.166880/), I want to rename result.jar to libget-non-ui.jar after it is compiled as release.  

```B4X
Sub AppStart (Args() As String)  
    Log("libget-non-ui (v2.50) started…")  
    If Args.Length = 0 Then  
        Log("Project's path not provided")  
        Log("libget-non-ui ended")  
        ExitApplication  
    End If  
    If Args.Length = 2 Then  
        CheckLibrary(Args(0), Args(1))  
    Else  
        CheckLibrary(Args(0), "False")  
    End If  
    StartMessageLoop  
End Sub
```