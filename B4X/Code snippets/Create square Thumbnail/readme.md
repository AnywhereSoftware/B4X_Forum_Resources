###  Create square Thumbnail by Alexander Stolte
### 05/28/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/118299/)

```B4X
Sub CreateSquareThumbnail(Input As B4XBitmap) As B4XBitmap  
    If Input.Width <> Input.Height Then  
        'if the image is not square then we crop it to be a square.  
        Dim l As Int = Min(Input.Width, Input.Height)  
        Return Input.Crop(Input.Width / 2 - l / 2, Input.Height / 2 - l / 2, l, l)  
    Else  
        Return Input  
    End If  
End Sub
```

  

```B4X
CreateSquareThumbnail(xui.LoadBitmapResize(File.DirAssets,"Snapchat-248558753.jpg",150dip,150dip,True))
```