### [BANano] Dynamsoft Barcode Reader by xulihang
### 05/18/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/130839/)

I've created the [B4X version](https://www.b4x.com/android/forum/threads/b4x-b4xpages-dynamsoft-barcode-reader-cross-platform-barcode-qr-code-scanning-library.130728/) of this Barcode SDK and here is the BANano version.  
  
[Dynamsoft Barcode Reader](https://www.dynamsoft.com/barcode-reader/overview/) is written in C++. They provide a JavaScript version which uses WebAssembly.  
  
The library can read local images or do a live scan.  
  
Decode an image:  
  

```B4X
Private Sub decodeButton_Click (event As BANanoEvent)  
    resultContainer.Element.SetHTML("Decoding…")  
    Dim results As List=BANano.Await(reader.decode(codeImage.Src))  
    Dim sb As StringBuilder  
    sb.Initialize      
    Dim index As Int  
    For Each tr As TextResult In results          
        index=index+1  
        sb.Append(index).Append(". ")          
        sb.Append(tr.Text)  
        sb.Append("<br/>")          
    Next  
    resultContainer.Element.SetHTML(sb.ToString)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/113633)  
  
Start live scan and get the result in callback:  
  

```B4X
Private Sub scanButton_Click (event As BANanoEvent)  
    scanner.show  
End Sub  
  
private Sub scanner_onUnduplicatedRead(txt As String,result As TextResult)  
    resultLabel.Text=result.Text  
    SKModal1.Open      
End Sub  
  
private Sub scanner_onFrameRead(results() As TextResult)  
  
End Sub
```

  
![](https://www.b4x.com/android/forum/attachments/113632)  
  
A live demo: <https://pwa.xulihang.me/barcodereader/>  
  
The whole project is uploaded.