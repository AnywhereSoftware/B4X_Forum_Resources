### [PyBridge] QRCodes and barcodes scanning with pyzbar by Erel
### 06/25/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167538/)

![](https://www.b4x.com/android/forum/attachments/164936)  
  
Based on: <https://github.com/NaturalHistoryMuseum/pyzbar>  
  
Installation:  
pip install pyzbar  
pip install Pillow  
  
The decoding code:  

```B4X
Private Sub Decode(ImagePath As String) As ResumableSub  
    Dim img As PyWrapper = PILImage.Run("open").Arg(ImagePath)  
    Dim decoded As PyWrapper = pyzbar.Run("decode").Arg(img)  
    Dim decoded2 As PyWrapper = Py.Map_(Py.Lambda("d: (d.type, d.data, (d.rect.left, d.rect.top, d.rect.width, d.rect.height))"), decoded).ToList  
    decoded.Print  
    Wait For (decoded2.Fetch) Complete (decoded2 As PyWrapper)  
    Dim res As List = B4XCollections.CreateList(Null)  
    If decoded2.IsSuccess Then  
        For Each d() As Object In decoded2.Value.As(List)  
            Dim r() As Object = d(2)  
            res.Add(CreateDecodedBarcode(d(1), d(0), r(0), r(1), r(2), r(3)))  
        Next  
        If res.Size = 0 Then  
            TextArea1.Text = "No codes found!"  
        End If  
    Else  
        TextArea1.Text = "Error: " & decoded2.ErrorMessage  
    End If  
    Return res  
End Sub
```

  
It returns a list of decoded barcodes.  
  
Note that for some of the codes, the width returned is 0.   
This can also be used in server solutions.