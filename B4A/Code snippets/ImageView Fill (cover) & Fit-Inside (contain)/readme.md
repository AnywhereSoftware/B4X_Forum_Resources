### ImageView Fill (cover) & Fit-Inside (contain) by Brandsum
### 02/12/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/113909/)

```B4X
'scale = cover,contain  
Public Sub SetImageToImageView(iv As ImageView,bmp As Bitmap, scale As String)  
    Dim jo As JavaObject=iv  
    jo.RunMethod("setImageBitmap",Array(bmp))  
    Select scale  
        Case "cover": jo.RunMethod("setScaleType",Array("CENTER_CROP"))  
        Case "contain": jo.RunMethod("setScaleType",Array("CENTER_INSIDE"))  
    End Select  
End Sub
```

  
  
[B4I Version](https://www.b4x.com/android/forum/threads/imageview-fill-cover-fit-inside-contain.113910/)