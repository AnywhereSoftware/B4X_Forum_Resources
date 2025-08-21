### Resize Bitmap with a maximum Byte limit by Star-Dust
### 02/01/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/86793/)

Sometimes the images we use in our Apps are overly large. In some cases, images are entered by the user and therefore we do not know the size. And to manage them we need them to fall within a certain Byte limit.  
  
How to reduce them within the limit?  
  
Here is a code that allows you to redimension the images while maintaining the proportion and returning within the Byte limit that serves us  
  

```B4X
Dim B As Bitmap = ResizeBitmapMaxByte(LoadBitmap(File.DirAssets,"test.png"),10240) ' 10 k  
  
' Sub for resize  
Sub ResizeBitmapMaxByte(Original As Bitmap, MaxByte As Long) As Bitmap  
    Dim ByteSize As Long  
    Dim ObjectBitmap As JavaObject = Original  
    Dim Api_Lelvel As JavaObject  
  
    Api_Lelvel.InitializeStatic("android.os.Build.VERSION")  
    If Api_Lelvel.GetField("SDK_INT") >= 19 Then  'kitkat  
        ByteSize = ObjectBitmap.RunMethod("getAllocationByteCount", Null)  
    else if Api_Lelvel.GetField("SDK_INT") >= 12 Then   'Android 3.1 Honeycomb  
        ByteSize = ObjectBitmap.RunMethod("getByteCount", Null)  
    Else     'earlier Android versions  
        ByteSize = ObjectBitmap.RunMethod("getRowBytes", Null) * Original.Height  
    End If  
  
    Dim Ratio As Float = Sqrt(MaxByte/ByteSize)  
  
    If Ratio<1 Then  
        Dim r As Reflector  
        Dim b As Bitmap  
        Dim Width As Int = (Original.Width * Ratio)  
        Dim Height As Int = (Original.Height * Ratio)  
  
        b = r.RunStaticMethod("android.graphics.Bitmap", "createScaledBitmap", _  
            Array As Object(Original, Width , Height, False), _  
            Array As String("android.graphics.Bitmap", "java.lang.int", "java.lang.int", "java.lang.boolean"))  
        Return b  
    Else  
        Return Original  
    End If  
End Sub
```