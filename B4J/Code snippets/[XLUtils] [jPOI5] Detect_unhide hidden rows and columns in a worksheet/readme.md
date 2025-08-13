### [XLUtils] [jPOI5] Detect/unhide hidden rows and columns in a worksheet by walt61
### 09/24/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143120/)

```B4X
Dim i As Int  
Dim theSheet As PoiSheet = …  
Dim joTheSheet As JavaObject = theSheet  
Dim theSheetWriter As XLSheetWriter = …  
Dim theSheetLastRow1 As Int = theSheet.LastRowNumber + 1 ' One-based index of the last row in the sheet  
Dim theSheetLastCol0 As Int = theSheet.GetRow(0).Cells.Size - 1 ' Zero-based index of the last column in the sheet's first row  
  
For i = 0 To theSheetLastCol0  
    Dim columnIsHidden As Boolean = joTheSheet.RunMethod("isColumnHidden", Array(i))  
    If columnIsHidden Then joTheSheet.RunMethod("setColumnHidden", Array(i, False)) ' Unhide the column  
Next  
  
For i = 1 To theSheetLastRow1  
    Dim joRow As JavaObject = theSheetWriter.GetRow(XL.AddressName("A" & i))  
    Dim rowIsHidden As Boolean = joRow.RunMethod("getZeroHeight", Null)  
    If rowIsHidden Then joRow.RunMethod("setZeroHeight", Array(False)) ' Unhide the row  
Next
```