###  Compress and decompress strings using Gzip by tummosoft
### 04/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170752/)

This is a library for compressing and decompressing strings. It uses the Gzip algorithm and can be used with B4A and B4J code.  
  

```B4X
Dim gzipUtil As GzipString  
Dim gzipsource As String = "This event will be called once, before the page becomes visible."  
Dim gzipBT() As Byte  
gzipBT = gzipUtil.gzipCompress(gzipsource)  
Dim StringDecompress As String = gzipUtil.gzipDecompress(gzipBT)
```