###  Animate TextColor by epiCode
### 04/02/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/147186/)

Just like setColorAnimated but for Text Color:  
Fades from existing color to TargetColor:  
  
  

```B4X
Sub FadeColorAsync(targetView As B4XView, targetColor As Int, duration As Int)  
    Dim startTime As Long = DateTime.Now  
    Dim startColor As Int = targetView.TextColor  
    Dim deltaR As Int = Bit.ShiftRight(Bit.And(targetColor, 0xFF0000), 16) - Bit.ShiftRight(Bit.And(startColor, 0xFF0000), 16)  
    Dim deltaG As Int = Bit.ShiftRight(Bit.And(targetColor, 0xFF00), 8) - Bit.ShiftRight(Bit.And(startColor, 0xFF00), 8)  
    Dim deltaB As Int = Bit.And(targetColor, 0xFF) - Bit.And(startColor, 0xFF)  
    Dim progress As Float  
      
    Do While True  
        progress = (DateTime.Now - startTime) / duration  
        If progress >= 1 Then ' fading is complete  
            targetView.TextColor = targetColor  
            Exit  
            Else ' fading is in progress  
            targetView.textColor = Colors.RGB( _  
                Bit.ShiftRight(Bit.And(startColor, 0xFF0000), 16) + deltaR * progress, _  
                Bit.ShiftRight(Bit.And(startColor, 0xFF00), 8) + deltaG * progress, _  
                Bit.And(startColor, 0xFF) + deltaB * progress _  
            )  
        End If  
        Sleep(50) ' wait 50 milliseconds before updating color again - Decrease for smoother transition - increase for performance.  
    Loop  
End Sub
```