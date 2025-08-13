### aSyncStream and flush by Star-Dust
### 04/17/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/146655/)

Many output streams buffer writes to improve performance. Rather than sending each byte to its destination as it’s written, the bytes are accumulated in a memory buffer ranging in size from several bytes to several thousand bytes. When the buffer fills up, all the data is sent at once. The flush() method forces the data to be written whether or not the buffer is full.  
  
How to force flush in aSyncStream?  

```B4X
Private socket As Socket  
Private astream As AsyncStreams  
Private r As Reflector  
Private aout As JavaObject  
  
Sub Button1_Click  
    socket.Initialize("socket")  
    s.Connect(Addr,Port,3000)  
End Sub  
  
Private Sub socket_Connected (Successful As Boolean)  
    If Successful Then  
        astream.Initialize(socket.InputStream,socket.OutputStream,"astream")  
              
        r.Target=astream  
        r.Target=r.GetField("aout")  
        'Log(r.GetField("working"))  
        aout=r.GetField("out")  
  
        astream.Write("MyText".GetBytes("UTF8"))  
        aout.RunMethod("flush",Null) ' force send  
    End If  
End Sub  
  
Private Sub astream_NewData (Buffer() As Byte)  
    Log("* " & Buffer.Length)  
End Sub  
  
Private Sub astream_Terminated  
   
End Sub  
  
Private Sub astream_Error  
   
End Sub
```

  
For more details you can see [**HERE**](https://github.com/AnywhereSoftware/B4A/blob/master/Libs_RandomAccessFile/src/anywheresoftware/b4a/randomaccessfile/AsyncStreams.java) the source made available by [USER=1]@Erel[/USER]