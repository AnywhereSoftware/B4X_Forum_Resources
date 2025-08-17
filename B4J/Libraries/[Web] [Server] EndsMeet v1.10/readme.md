### [Web] [Server] EndsMeet v1.10 by aeric
### 07/08/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167395/)

Version: 1.10  
GitHub: <https://github.com/pyhoon/EndsMeet>  
  
Create a server app with 4 lines of code:  

```B4X
Sub Process_Globals  
    Public app As EndsMeet  
End Sub  
  
' <link>Open in browser|http://127.0.0.1:8080</link>  
Sub AppStart (Args() As String)  
    app.Initialize  
    app.Get("", "Index")  
    app.Start  
    StartMessageLoop  
End Sub
```

  
  
Project template: <https://www.b4x.com/android/forum/threads/project-template-endsmeet-server-v1-00.158071/>