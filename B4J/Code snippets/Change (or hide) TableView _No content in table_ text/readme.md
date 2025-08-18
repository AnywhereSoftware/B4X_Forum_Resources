### Change (or hide) TableView "No content in table" text by LucaMs
### 02/09/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/127478/)

**[SIZE=5]Author: [USER=9800]@stevel05[/USER]:[/SIZE]  
  
Description**: allows you to change the default text in TableViews when there are no rows, it is empty.  
  

```B4X
Public Sub SetTVPlaceholder(TV As TableView,Text As String)  
    Dim TVJO As JavaObject = TV  
    Dim L As Label  
    L.Initialize("")  
    L.Text = Text  
    TVJO.RunMethod("setPlaceholder",Array(L))  
End Sub
```

  
  
  
  
Default (italian) text…………………………………………………Custom……………………………………………………………………….My favorite, the one I was looking for.  
![](https://www.b4x.com/android/forum/attachments/107718)![](https://www.b4x.com/android/forum/attachments/107720)![](https://www.b4x.com/android/forum/attachments/107722)