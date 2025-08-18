### QR Code Generator (for Server) by tchart
### 12/13/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/125513/)

Reposting to make this easier to find (original post <https://www.b4x.com/android/forum/threads/solved-jserver-html-js.123679/post-772727>)  
  
This is a QR code generator for B4J projects. It doesnt require jShell so it will work on B4J server projects.  
  
It is a wrapper for this library <https://github.com/nayuki/QR-Code-generator>   
  
One of the methods returns base64 encoded png that you can embed in your response HTML (see here if you are not familar with base64 images in HTML - <https://www.base64-image.de/tutorial>). Most of the libraries/code on the forum only writes an image.  
  
There are three methods in the library;  

- EncodeTextToSvgString - returns the QRcode as a SVG string
- EncodeTextToBase64 - returns the QRcode as a base64 image (as a string) you can embed
- EncodeTextToPNG - writes the QRcode as a png file

Example code using base64 encoding;  
  

```B4X
Dim qr As qrcodegen  
qr.Initialize  
  
Dim base64 As String = qr.EncodeTextToBase64(input(0),5)  
      
resp.Write($"<img src="data:image/jpeg;base64,${base64}" width="200" height="200" alt="base64 test">"$)
```

  
  
Or to write out to a png file;  
  

```B4X
Dim qr As qrcodegen  
qr.Initialize  
qr.EncodeTextToPNG("Hello World",File.DirTemp,"output.png")
```