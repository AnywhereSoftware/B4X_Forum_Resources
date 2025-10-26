### [Web] [Server] EndsMeet v1.50 by aeric
### 10/19/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167395/)

Version: 1.50  
GitHub: <https://github.com/pyhoon/EndsMeet>  
  
Create a server app with 4 lines of code:  

```B4X
Sub Process_Globals  
    Public App As EndsMeet  
End Sub  
  
' <link>Open in browser|http://127.0.0.1:8080</link>  
Sub AppStart (Args() As String)  
    App.Initialize  
    App.Get("", "Index")  
    App.Start  
    StartMessageLoop  
End Sub
```

  
  
Project template: <https://www.b4x.com/android/forum/threads/project-template-endsmeet-server-v1-00.158071/>