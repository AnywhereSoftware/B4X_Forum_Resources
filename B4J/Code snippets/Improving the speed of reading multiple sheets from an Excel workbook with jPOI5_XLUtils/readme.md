### Improving the speed of reading multiple sheets from an Excel workbook with jPOI5/XLUtils by walt61
### 04/15/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/147456/)

Especially noticeable when reading from a not-very-small workbook, even if it just contains multiple sheets with some tens of thousands of rows.  
  
**Slow method** that opens the workbook multiple times (and, I guess, reads it/interprets its XML completely each time to load it into memory):  

```B4X
Dim reader As XLReaderResult  
reader = XL.Reader.ReadSheetByName("C:\myfile.xlsx", "", "Sheet1")  
' … your processing for Sheet1 here …  
reader = XL.Reader.ReadSheetByName("C:\myfile.xlsx", "", "Sheet2")  
' … your processing for Sheet2 here …  
reader = XL.Reader.ReadSheetByName("C:\myfile.xlsx", "", "Sheet3")  
' … your processing for Sheet3 here …
```

  
  
**Significantly faster method** that opens the workbook only once:  

```B4X
Dim writer As XLWorkbookWriter = XL.CreateWriterFromTemplate("C:\myfile.xlsx", "")  
Dim reader As XLReaderResult  
reader = XL.Reader.SheetToResult(writer.PoiWorkbook.GetSheetByName("Sheet1"))  
' … your processing for Sheet1 here …  
reader = XL.Reader.SheetToResult(writer.PoiWorkbook.GetSheetByName("Sheet2"))  
' … your processing for Sheet2 here …  
reader = XL.Reader.SheetToResult(writer.PoiWorkbook.GetSheetByName("Sheet3"))  
' … your processing for Sheet3 here …  
writer.PoiWorkbook.Close
```