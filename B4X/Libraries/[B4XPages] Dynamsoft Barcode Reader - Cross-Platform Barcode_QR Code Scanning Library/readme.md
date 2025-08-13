###  [B4XPages] Dynamsoft Barcode Reader - Cross-Platform Barcode/QR Code Scanning Library by xulihang
### 10/12/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/130728/)

[Dynamsoft Barcode Reader](https://www.dynamsoft.com/barcode-reader/overview/) is a barcode reading SDK written in C++ and has Java/Objective-C packages, so it is possible to wrap it as a B4X library using JavaObject and NativeObject.  
  
It is a commercial SDK that has good performance and customizability.  
  
The current version is very basic. I only wrapped the basic decode method and a TextResult class (storing the barcode content and localization results).  
  
The library is made for B4A, B4i and B4J.  
  
How to use:  
  
1. Initialize  
  

```B4X
Sub Class_Globals  
    Private reader As DBR  
End Sub  
Private Sub init  
    reader.Initialize("license")  
    'request your license here: https://www.dynamsoft.com/customer/license/trialLicense?ver=latest  
End Sub
```

  
  
2. Read barcodes from an image  
  

```B4X
Private Sub Decode(bm as B4XBitmap)  
    Dim results As List=reader.decodeImage(bm)  
    Dim sb As StringBuilder  
    sb.Initialize  
    For Each result As TextResult In results  
        sb.Append("Text: ").Append(result.Text).Append(CRLF)  
    Next  
    Log(sb.ToString)  
End Sub
```

  
  
  
Additional libraries are required:  
  
1. Download the jar/aar/framework files from its [website](https://www.dynamsoft.com/barcode-reader/downloads/).  
2. Use AdditionalLib/AdditionalJar to reference dependant libraries.  
  
For B4A:  
  

```B4X
#AdditionalJar: DynamsoftBarcodeReader-9.2.10.aar
```

  
  
For B4i:  
  

```B4X
#AdditionalLib: DynamsoftBarcodeReader.framework.3  
#AdditionalLib: libc++.tbd
```

  
  
For B4J:  
  

```B4X
#AdditionalJar: dynamsoft-barcodereader-9.4.0
```

  
  
  
I've created a demo using B4XPages and packaged a b4xlib. You can find the source code here: <https://github.com/tony-xlh/BarcodeReader-B4X>  
  
The b4xlib is attatched.  
  
  
![](https://www.b4x.com/android/forum/attachments/113363)  
  
v1.1.0 2022/10/12  
  
Update Dynamsoft Barcode Reader to 9.x.  
  
v1.0 2021/05/14  
Released