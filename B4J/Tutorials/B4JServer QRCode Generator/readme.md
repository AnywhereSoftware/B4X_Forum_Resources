### B4JServer QRCode Generator by aeric
### 02/24/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/146340/)

[SIZE=7]**QRCode Generator using ZXing Library**[/SIZE]  
[SIZE=5]Can be use for B4JServer, Web API Server and Non-UI app (does not depend on XUI or jFX)  
  
![](https://www.b4x.com/android/forum/attachments/139609)[/SIZE]  
  

```B4X
Dim img As String = File.Combine(Main.AssetFolder, "img")  
Dim generate As ZXing  
generate.Initialize  
generate.QrCode(value, 400, File.Combine(img, "image.png"), "png")
```

  
  
**Additional Libraries:**  
[**core-3.5.1.jar**](https://repo1.maven.org/maven2/com/google/zxing/core/3.5.1/core-3.5.1.jar)  
[**javase-3.5.1.jar**](https://repo1.maven.org/maven2/com/google/zxing/javase/3.5.1/javase-3.5.1.jar)  
[**jZXing.jar**](https://www.b4x.com/android/forum/attachments/jzxing-zip.139610/) (attached)  
  

---

  
  
**jZXing  
Author:** Aeric Poon  
**Version:** 1.00  

- **ZXing**

- **Functions:**

- **Initialize** As String
- **IsInitialized** As Boolean
- **QrCode** (text As String, size As Int, filepath As String, filetype As String) As String
Java Code Reference: [<https://www.digitalocean.com/community/tutorials/java-qr-code-generator-zxing-example>](https://www.digitalocean.com/community/tutorials/java-qr-code-generator-zxing-example)