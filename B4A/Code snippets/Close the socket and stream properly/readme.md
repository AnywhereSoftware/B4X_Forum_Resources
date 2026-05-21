### Close the socket and stream properly. by Filippo
### 05/18/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171044/)

This approach prevents another process from attempting to close the socket and the stream at the same time.  
  

```B4X
Private myclient As Socket  
Private astream As AsyncStreams  
Private IsClosing As Boolean  
  
Public Sub CloseConnection  
    If IsClosing Then Return  
    IsClosing = True  
    If astream.IsInitialized Then astream.Close  
    If myclient.IsInitialized Then myclient.Close  
    IsClosing = False  
End Sub
```