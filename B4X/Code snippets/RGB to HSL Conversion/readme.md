### RGB to HSL Conversion by John Naylor
### 11/24/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/136294/)

I couldn't find anything on the forum to do this so I'll leave it here in case anyone needs it in the future.  
  
It takes Red, Green, Blue inputs and returns Hue, Saturation, and Lightness values.  
  
The return type  

```B4X
Type HSL (hue As Double , saturation As Double, lightness As Double)
```

  
  
Function itself  
  

```B4X
Sub RGBToHSL(r As Double , g As Double, b As Double) As HSL  
   
    Dim hsl As HSL  
    Dim rgb As List  
  
    r = r / 255  
    g = g / 255  
    b = b / 255  
  
    rgb.Initialize2 (Array As Double (r, g, b))  
      
    Dim cmin As Double = MathMin(rgb)  
    Dim cmax As Double = MathMax(rgb)  
    Dim delta As Double = cmax - cmin  
    Dim h As Double = 0  
    Dim s As Double = 0  
    Dim l As Double = 0  
      
    ' Calculate hue  
  
    If delta = 0 Then                        'No difference  
        h = 0  
      
    Else If cmax = r Then                    'Red Is max  
        h = (g - b) / delta Mod 6  
      
    else if cmax = g Then                    'Green is max  
        h = (b - r) / delta + 2  
          
    Else                                    'Blue is max  
        h = (r - g) / delta + 4  
          
    End If  
  
    h = Round(h * 60)  
      
    If (h < 0) Then h = h + 360                'Make negative hues positive  
  
    l = (cmax + cmin) / 2                    'Calculate lightness  
  
    s = IIf (delta = 0, 0 , delta / (1 - Abs(2 * l - 1)))        'Calculate saturation  
      
    'Multiply l And s by 100  
    s = NumberFormat (s * 100, 0, 1).Replace (",", "")  
    l = NumberFormat (l * 100, 0, 1).Replace (",", "")  
  
    hsl.hue = h  
    hsl.saturation = s  
    hsl.lightness = l  
  
    Return hsl  
      
End Sub  
  
Sub MathMin (l As List) As Double        'Get the min value in an unsorted list  
      
    Dim x As Double = 1  
      
    For Each i As Double In l  
        If i < x Then x = i  
    Next  
      
    Return x  
End Sub  
  
Sub MathMax (l As List) As Double        'Get the max value in an unsorted list  
      
    Dim x As Double = 0  
      
    For Each i As Double In l  
        If i > x Then x = i  
    Next  
      
    Return x  
End Sub
```