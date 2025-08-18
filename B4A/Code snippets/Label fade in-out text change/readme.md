### Label fade in-out text change by LucasHeer
### 05/22/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/140711/)

I needed a way to fade my title label in and out to a new text, quick and dirty, not sure if there is a better way:  
![](https://www.b4x.com/android/forum/attachments/129452)  
  

```B4X
Private Sub animate_label(lbl As B4XView, text As String) As ResumableSub  
    Dim animDelay As Int = 200  
    Dim startTime As Long = DateTime.Now  
    Dim textAlpha As Int = 0  
      
    Do While True  
        Dim difTime As Long = Max(1, DateTime.Now - startTime)  
        textAlpha = Max(0,Abs((difTime / animDelay) * 255 - 255))  
        lbl.TextColor = Colors.ARGB(textAlpha, 255,255,255)  
        If(textAlpha = 0 Or difTime > animDelay) Then  
            Exit  
        End If  
        Sleep(1)  
    Loop  
    lbl.Text = text  
    startTime = DateTime.Now  
    Do While True  
        Dim difTime As Long = Max(1, DateTime.Now - startTime)  
        textAlpha = Min(255,(difTime / animDelay) * 255)  
        lbl.TextColor = Colors.ARGB(textAlpha, 255,255,255)  
        If(textAlpha = 255 Or difTime > animDelay) Then  
            Exit  
        End If  
        Sleep(1)  
    Loop  
End Sub
```