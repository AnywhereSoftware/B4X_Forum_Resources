###  InputStream - Skip N Bytes by Erel
### 03/11/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/128498/)

This sub will skip N bytes from the stream. Usage example: you have an InputStream and you don't want the first 100 bytes.  

```B4X
'Returns the number of bytes skipped  
Sub SkipNBytes (Input As InputStream, N As Int) As Int  
    Dim buffer(Min(N, 8000)) As Byte  
    Dim count As Int  
    Do While count < N  
        Dim read As Int = Input.ReadBytes(buffer, 0, Min(buffer.Length, N - count))  
        If read = -1 Then Return count  
        count = count + read  
    Loop  
    Return count  
End Sub
```

  
  
It will skip the N bytes exactly unless there are less than N bytes in the stream. It returns the actual number of bytes skipped.