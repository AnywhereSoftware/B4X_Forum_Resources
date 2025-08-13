### [PyBridge] Create barcodes by Erel
### 02/16/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165642/)

Based on: <https://python-barcode.readthedocs.io/en/stable/getting-started.html>  
  
Usage:  

```B4X
Wait For (CreateBarcode("code128", "abcdef")) Complete (Result As B4XBitmap)  
ImageView1.SetBitmap(Result)
```

  
  
  

```B4X
'dependencies: pip install python-barcode "python-barcode[images]"  
'Types: ['codabar', 'code128', 'code39', 'ean', 'ean13', 'ean13-guard', 'ean14', 'ean8', 'ean8-guard', 'gs1', 'gs1_128', 'gtin', 'isbn', 'isbn10', 'isbn13', 'issn', 'itf', 'jan', 'nw-7', 'pzn', 'upc', 'upca']  
Private Sub CreateBarcode (CodeType As String, Code As String) As ResumableSub  
    Dim BytesIO As PyWrapper = Py.ImportModuleFrom("io", "BytesIO")  
    Dim Barcode As PyWrapper = Py.ImportModule("barcode")  
    Dim ImageWriter As PyWrapper = Py.ImportModuleFrom("barcode.writer", "ImageWriter")  
    Barcode.GetField("PROVIDED_BARCODES").Print2("Types:", "", False)  
    Dim EAN As PyWrapper = Barcode.Run("get_barcode_class").Arg(CodeType)  
    Dim rv As PyWrapper = BytesIO.Call  
    EAN.Call.Arg(Code).ArgNamed("writer", ImageWriter.Call).Run("write").Arg(rv)  
    Wait For (rv.Fetch) Complete (rv As PyWrapper)  
    Return Py.ImageFromBytes(rv.Value)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/161773)  
  
Ctrl + click on the Python shell link at the top of B4XMainPage and run:  
pip install python-barcode "python-barcode[images]"