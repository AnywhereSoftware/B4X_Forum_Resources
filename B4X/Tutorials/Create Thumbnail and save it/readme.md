###  Create Thumbnail and save it by Alexander Stolte
### 05/27/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/118300/)

```B4X
SavePictureToFile(XUIImageToJPEGByteArray(CreateThumbnail(xui.LoadBitmapResize(File.DirAssets,"Snapchat-248558753.jpg",150dip,150dip,True)),150dip,150dip,50),File.DirRootExternal,"test.jpg")
```

  
"quality" on "[XUIImageToJPEGByteArray](https://www.b4x.com/android/forum/threads/b4x-xui-image-to-jpeg-byte-array-with-resize-quality-options.91774/#content)" results on a:  
910kb image  
quality = 50 = 17,69KB  
quality = 100 = 100KB  
  

```B4X
Public Sub SavePictureToFile(Data() As Byte, Dir As String, FileName As String)  
    Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)  
    out.WriteBytes(Data, 0, Data.Length)  
    out.Close  
End Sub
```

  
[XUIImageToJPEGByteArra](https://www.b4x.com/android/forum/threads/b4x-xui-image-to-jpeg-byte-array-with-resize-quality-options.91774/#content)y:  
<https://www.b4x.com/android/forum/threads/b4x-xui-image-to-jpeg-byte-array-with-resize-quality-options.91774/#content>  
<https://www.b4x.com/android/forum/threads/b4x-create-square-thumbnail.118299/>