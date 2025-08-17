###  LZStringCompress, the method compress and decompress data through sockets by tummosoft
### 07/23/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/162216/)

**LZStringCompress, the method compress and decompress data through sockets**  
  
LZStringCompress is a String encoding library, helping to speed up communication between the server and applications such as Android and Webapp faster and with a certain level of security.  
Instead of string communication which will cause data insecurity, using LZStringCompress will help improve the speed of your applications in case of large text volumes.  
LZStringCompress is currently a wrapper for Javascript, B4J, B4A platforms.  
Please download the libraries and examples below:  
  

```B4X
Sub Compress() As String  
    Dim cpr As LZStringCompress  
    cpr.Initialize  
    Dim text As String = File.ReadString(File.DirApp & "\www", "testfile.txt")  
    Dim cprText As String = cpr.Compress4Socket(text)  
    Return cprText  
End Sub
```

  
  

```B4X
<script>  
    async function getData() {  
  const url = "http://127.0.0.1:51042/compress";  
  try {  
    const response = await fetch(url);  
    if (!response.ok) {  
      throw new Error(`Response status: ${response.status}`);  
    }  
    var gzipsource = await response.text();      
    var puretext = LZString.decompressFromEncodedURIComponent(gzipsource);  
    var decompress = document.getElementById('decompress');  
    decompress.innerHTML = puretext;  
  } catch (error) {  
    console.error(error.message);  
  }  
}  
</script>
```