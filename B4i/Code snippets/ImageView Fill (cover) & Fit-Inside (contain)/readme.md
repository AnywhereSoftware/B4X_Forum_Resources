### ImageView Fill (cover) & Fit-Inside (contain) by Brandsum
### 02/12/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/113910/)

```B4X
'scale = cover,contain  
Public Sub SetImageToImageView(iv As ImageView,bmp As Bitmap, scale As String)  
    Dim no As NativeObject=iv  
    Select scale  
        Case "cover": no.SetField("contentMode",2)  
        Case "contain": no.SetField("contentMode",1)  
    End Select  
    iv.Bitmap = bmp  
End Sub
```

  
  
[B4A Version](https://www.b4x.com/android/forum/threads/imageview-fill-cover-fit-inside-contain.113909/)