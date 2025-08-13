### Set of random contrast colors by peacemaker
### 01/02/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/164916/)

```B4X
'generate X pcs contrast one to another color codes  
Sub GenerateColorCodes(X As Int) As List  
    Dim Colors As List  
    Colors.Initialize  
  
    Do While Colors.Size < X  
        'random color  
        Dim RandomColor As Int = B4XPages.MainPage.xui.Color_RGB(Rnd(0, 256), Rnd(0, 256), Rnd(0, 256))  
       
        'non-used yet ?  
        If Colors.IndexOf(RandomColor) = -1 Then  
            Dim IsContrasting As Boolean = True  
           
            For Each c As Int In Colors  
                If Not(IsColorContrasting(RandomColor, c, x)) Then  
                    IsContrasting = False  
                    Exit  
                End If  
            Next  
           
            If IsContrasting Then  
                Colors.Add(RandomColor)  
            End If  
        End If  
    Loop  
  
    Return Colors  
End Sub  
  
'check the contrast between 2 colors  
Sub IsColorContrasting(color1 As Int, color2 As Int, X As Int) As Boolean  
    Dim r1 As Int = Bit.And(Bit.ShiftRight(color1, 16), 255)  
    Dim g1 As Int = Bit.And(Bit.ShiftRight(color1, 8), 255)  
    Dim b1 As Int = Bit.And(color1, 255)  
  
    Dim r2 As Int = Bit.And(Bit.ShiftRight(color2, 16), 255)  
    Dim g2 As Int = Bit.And(Bit.ShiftRight(color2, 8), 255)  
    Dim b2 As Int = Bit.And(color2, 255)  
  
    'colors brightness  
    Dim brightness1 As Float = 0.299 * r1 + 0.587 * g1 + 0.114 * b1  
    Dim brightness2 As Float = 0.299 * r2 + 0.587 * g2 + 0.114 * b2  
  
    'difference, the threshold depends on the needed colors qty X  
    Return Abs(brightness1 - brightness2) > 150/X  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/160290)