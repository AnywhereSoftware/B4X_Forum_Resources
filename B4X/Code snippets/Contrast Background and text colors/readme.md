###  Contrast Background and text colors by stevel05
### 01/13/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/112963/)

**Subname: ContrastColor  
  
Description:**  
If you have an app in which the user can change the background colour you need to be able to change the text colour of controls accordingly. I found a code snippet that returns black or white depending on the luminosity of a colour which seems to do the trick so I thought I'd share it. the code was found [here](https://stackoverflow.com/a/41335343)  
  

```B4X
Public Sub ContrastColor(Color As Int) As Int  
    'From https://stackoverflow.com/a/41335343  
    'Counting the perceptive luminance - human eye favors green color…  
    '                                        Red                                           Green                                       Blue  
    Dim A As Double = 1 - (0.299 * Bit.And(Bit.ShiftRight(Color,16),0xFF) + 0.587 * Bit.And(Bit.ShiftRight(Color,8),0XFF) + 0.114 * Bit.And(Color,0xFF)) / 255  
    If A < 0.5 Then  
        Return XUI.Color_Black  
    Else  
        Return XUI.Color_White  
    End If  
End Sub
```

  
  
The Sub requires an Int which is fine for B4a, B4i and XUI, If you want to use it in B4j without XUI then you can convert a Paint object to an int using [ICODE]fx.Colors.To32Bit[/ICODE] and [ICODE]fx.Colors.From32Bit[/ICODE] and change the Return Type and objects as necessary.  
  
Tags: Contrast, Color, B4j, B4a,B4i, XUI