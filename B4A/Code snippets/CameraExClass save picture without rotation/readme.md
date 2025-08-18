### CameraExClass save picture without rotation by Hamied Abou Hulaikah
### 06/02/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/140947/)

Hello everyone  
Anyone use CameraExClass.SavePictureToFile function, the image will be saved rotated horizontally.  
I changed this function to save picture as it without rotation, as the following:  

```B4X
Public Sub SavePictureToFile(Data() As Byte, Dir As String, FileName As String)  
      
    Dim inp As InputStream  
    inp.InitializeFromBytesArray(Data,0,Data.Length)  
      
    Dim B As Bitmap  
    B.Initialize2(inp)  
    Dim bm2 As BitmapExtended  
    B=bm2.rotateBitmap(B,90)  
      
    Dim out As OutputStream=File.OpenOutput(Dir, FileName, False)  
    B.WriteToStream(out,100,"PNG")  
    out.Close  
      
End Sub
```

  
It depend on [BitmapExtended](https://www.b4x.com/android/forum/threads/bitmapextended-library.11689/) library.