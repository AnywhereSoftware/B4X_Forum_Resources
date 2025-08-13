### SithasoDaisy: Click Events and event.PreventDefault by Mashiane
### 04/26/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/147625/)

Hi  
  
It is **safe,** that in all \_click events, you **add** an **event.PreventDefault**  
  
As an example…  
  

```B4X
'Close input dialog  
Private Sub mdlTasks_Cancel_Click (e As BANanoEvent)  
    e.PreventDefault  
    mdltasks.Hide  
End Sub
```

  
  
This will prevent possible "jumps" of your app to undesirable places.  
  
Thanks [USER=74838]@Sascha[/USER]