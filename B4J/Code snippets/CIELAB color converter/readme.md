### CIELAB color converter by madru
### 01/20/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/126692/)

Hi,  
maybe useful for a few people :)  
  
tested on B4J & A  
  
<https://en.wikipedia.org/wiki/CIELAB_color_space>  
  

```B4X
Type albValue (xx As Double,yy As Double ,zz As Double)  
  
Sub LABtoRGBInt(l As Double, a As Double,b As Double) As Int  
    Dim ml(4) As String= XYZToRGB(LABtoXYZ(l,a,b))  
    Return ml(3)  
End Sub  
  
Sub LABtoRGBval(l As Double, a As Double,b As Double) As Object  
    Dim ml(4) As String= XYZToRGB(LABtoXYZ(l,a,b))  
    Return ml  
End Sub  
  
Sub LABtoXYZ(l As Double, a As Double,b As Double) As albValue  
     
    Dim X, Y, Z As  Double  
    Y = ((L + 16.0) / 116.0)  
    X = ((A / 500.0) + Y)  
    Z = (Y - (B / 200.0))  
  
    Dim Pow_X As Double = Power(X, 3.0)  
    Dim Pow_Y As Double= Power(Y, 3.0)  
    Dim Pow_Z As Double= Power(Z, 3.0)  
  
    Dim Less As Double  = (216 / 24389)  
  
    If (Pow_X > Less) Then  
        X = Pow_X  
    Else  
        X = ((X - (16.0 / 116.0)) / 7.787)  
    End If  
    If (Pow_Y > Less) Then  
        Y = Pow_Y  
    Else  
        Y = ((Y - (16.0 / 116.0)) / 7.787)  
    End If  
    If (Pow_Z > Less) Then  
        Z = Pow_Z  
    Else  
        Z = ((Z - (16.0 / 116.0)) / 7.787)  
    End If  
  
    Dim r As albValue  
    r.xx=X * 95.047  
    r.yy=Y * 100.0  
    r.zz=Z * 108.883  
     
    Return r  
  
  
End Sub  
  
Sub XYZToRGB(xyz As albValue) As Object  
     
    Dim X, Y, Z As  Double  
    Dim R, G, B As  Double  
    Dim Pow As Double = (1.0 / 2.4)  
    Dim Less As Double = 0.0031308  
  
    X = (xyz.xx / 100)  
    Y = (xyz.yy / 100)  
    Z = (xyz.zz / 100)  
  
    'Wiki  
'    R = ((X * 3.24071) + (Y * -1.53726) + (Z * -0.498571))  
'    G = ((X * -0.969258) + (Y * 1.87599) + (Z * 0.0415557))  
'    B = ((X * 0.0556352) + (Y * -0.203996) + (Z * 1.05707))  
     
    'nVIDIA  
    R = ((X * 3.240479) + (Y * -1.53715) + (Z * -0.498535))  
    G = ((X * -0.969256) + (Y * 1.875991) + (Z * 0.041556))  
    B = ((X * 0.055648) + (Y * -0.204043) + (Z * 1.057311))  
  
    If (R > Less) Then  
        R = ((1.055 * Power(R, Pow)) - 0.055)  
    Else  
        R =R* 12.92  
    End If  
    If (G > Less) Then  
        G = ((1.055 * Power(G, Pow)) - 0.055)  
    Else  
        G =G* 12.92  
    End If  
    If (B > Less) Then  
        B = ((1.055 * Power(B, Pow)) - 0.055)  
    Else  
        B =B* 12.92  
    End If  
     
    R = R * 255  
    G = G * 255  
    B = B * 255  
     
    If R > 255 Then R = 255  
    If G > 255 Then G = 255  
    If B > 255 Then B = 255  
    If R < 0 Then R = 0  
    If G < 0 Then G = 0  
    If B < 0 Then B = 0  
     
    Dim r2 As String = r  
    Dim g2 As String = G  
    Dim b2 As String = b  
     
    Dim r1,g1,b1 As Int  
    r1=NumberFormat(r2,0,0)  
    g1=NumberFormat(g2,0,0)  
    b1=NumberFormat(b2,0,0)  
  
    Dim mycolint As Int = xui.Color_RGB(r1,g1,b1)  
  
  
    Dim rgb(4) As String  
    rgb(0)=r1  
    rgb(1)=g1  
    rgb(2)=b1  
    rgb(3)=mycolint  
     
    Return rgb  
End Sub
```