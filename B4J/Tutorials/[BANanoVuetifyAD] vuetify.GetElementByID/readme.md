### [BANanoVuetifyAD] vuetify.GetElementByID by micro
### 05/30/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131193/)

Hi to all  
it's probably not the right way, so I'm asking you where I'm wrong   
This Sub is in pgIndex (about is another code module)  

```B4X
Sub btnlogOff_click(e As BANanoEvent)  
    If about.login = True Then  
        Dim bt As BANanoElement = vuetify.GetElementByID("btnlogOff")  
        bt.SetAttr("color", "#ff0000")'<<< with about.login = True it should be #008000 (green)  
       vuetify.Authenticated = False  
       about.login = False  
       vuetify.NavigateTo("/adlogin")  
   End If  
End Sub
```

  
in practice I can not change the properties of btnlogOff  
Thanks to all