###  Bytes To File by Erel
### 05/24/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/70111/)

**This code is no longer needed. Use File.WriteBytes / ReadBytes.**  
  
Write an array of bytes to a file and read a file into an array of bytes.  
  

```B4X
Sub BytesToFile (Dir As String, FileName As String, Data() As Byte)  
   Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)  
   out.WriteBytes(Data, 0, Data.Length)  
   out.Close  
End Sub  
  
Sub FileToBytes (Dir As String, FileName As String) As Byte()  
   Return Bit.InputStreamToBytes(File.OpenInput(Dir, FileName))  
End Sub
```

  
  
Note that you can convert complex objects (and simple objects) to bytes and vice versa with B4XSerializator from the RandomAccessFile library  
  
Tags: Bytes, Serialization  
  
Working with bytes? Check BytesBuilder: <https://www.b4x.com/android/forum/threads/b4x-bytesbuilder-simplifies-working-with-arrays-of-bytes.89008/>