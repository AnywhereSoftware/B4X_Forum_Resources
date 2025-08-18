### [XLUtils] Writing Excel Workbooks by Erel
### 05/06/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130356/)

Main concepts and reading MS Excel workbooks with XLUtils: <https://www.b4x.com/android/forum/threads/xlutils-jpoi-5-read-and-write-ms-excel-workbooks.129969/#content>  
  
Writing workbooks is also simple but does require a bit more code.  
  
There are several types that we will use, in addition to XLUtils:  
*XLWorkbookWriter* - Represents the complete workbook. Created with xl.CreateWriterBlank - creates a new empty workbook, or xl.CreateWriterTemplate - creates a new workbook with a copy of another workbook as a template.  
*XLSheetWriter* - Represents a single sheet. Created with XLWorkbookWriter.CreateSheetWriterByName or XLWorkbookWriter.CreateSheetWriterByIndex.  
*XLStyle* - Represents a cell style. Makes it easy to build and combine complex styles. Takes care, under the hood, to reuse styles when possible. Created with XLWorkbookWriter.CreateStyle.  
Modifying the style doesn't affect previous calls to Sheet.SetStyle.  
  
The "Products" example creates a table from scratch:  
  
![](https://www.b4x.com/android/forum/attachments/112678)  
  
Note that the table is created without the title and near the end, the cells are shifted down one row.  

```B4X
Private Sub CreateWorkbook  
    xl.Initialize  
    Dim Workbook As XLWorkbookWriter = xl.CreateWriterBlank  
    Dim sheet1 As XLSheetWriter = Workbook.CreateSheetWriterByName("Sheet1")  
    Dim TitleStyle As XLStyle = Workbook.CreateStyle  
    TitleStyle.ForegroundColor(xl.COLOR_GREY_80_PERCENT).FontBoldColor(12, xl.COLOR_WHITE).HorizontalAlignment("CENTER")  
    sheet1.PutString(xl.AddressName("A1"), "Product").SetStyles(sheet1.LastAccessed, Array(TitleStyle, Workbook.CreateStyle.BorderLeft("THIN"))) 'title style + border  
    sheet1.PutString(xl.AddressName("B1"), "Price").SetStyle(sheet1.LastAccessed, TitleStyle)  
    sheet1.PutString(xl.AddressName("C1"), "Quantity").SetStyle(sheet1.LastAccessed, TitleStyle)  
    sheet1.PutString(xl.AddressName("D1"), "Total").SetStyles(sheet1.LastAccessed, Array(TitleStyle, Workbook.CreateStyle.BorderRight("THIN")))  
  
    Dim RowStyles As List = Array(Workbook.CreateStyle.ForegroundColor(xl.COLOR_LIGHT_TURQUOISE), Workbook.CreateStyle.ForegroundColor(xl.COLOR_WHITE))  
    Dim ProductStyle As XLStyle = Workbook.CreateStyle.BorderLeft("THIN")  
    Dim PriceStyle As XLStyle = Workbook.CreateStyle.DataFormat("$#,##0.0")  
    Dim QuantityStyle As XLStyle = Workbook.CreateStyle.DataFormat("#,##0")  
    Dim TotalStyle As XLStyle = Workbook.CreateStyle.DataFormat("$#,##0").BorderRight("THIN")  
  
    For i = 1 To 25  
        Dim Row1Based As Int = 1 + i 'starting from row 2.  
        Dim RowStyle As XLStyle = RowStyles.Get(Row1Based Mod RowStyles.Size)  
        sheet1.PutString(xl.AddressOne("A", Row1Based), "Product #" & i).SetStyles(sheet1.LastAccessed, Array(ProductStyle, RowStyle))  
        sheet1.PutNumber(xl.AddressOne("B", Row1Based), Rnd(0, 100000) / 100).SetStyles(sheet1.LastAccessed, Array(PriceStyle, RowStyle))  
        sheet1.PutNumber(xl.AddressOne("C", Row1Based), Rnd(0, 5000)).SetStyles(sheet1.LastAccessed, Array(QuantityStyle, RowStyle))  
        sheet1.PutFormula(xl.AddressOne("D", Row1Based), $"${xl.AddressOneToString("B", Row1Based)} * ${xl.AddressOneToString("C", Row1Based)}"$)  
        sheet1.SetStyles(sheet1.LastAccessed, Array(TotalStyle, RowStyle))  
    Next  
    'add bottom border  
    Dim LastTableRow1 As Int = sheet1.LastAccessed.Row0Based + 1  
    'Using AddStyles instead of SetStyles to keep the already set style.  
    sheet1.AddStylesToRange(xl.CreateXLRange(xl.AddressOne("A",LastTableRow1), xl.AddressOne("D", LastTableRow1)), Array(Workbook.CreateStyle.BorderBottom("THIN")))  
  
    'add sum field:  
    sheet1.PutFormula(xl.AddressOne("D", LastTableRow1 + 2), $"SUM(D2:${xl.AddressOneToString("D", LastTableRow1)})"$)  
    Dim BoldStyle As XLStyle = Workbook.CreateStyle.FontBold(Workbook.DefaultFontSize)  
    sheet1.SetStyles(sheet1.LastAccessed, Array(TotalStyle, BoldStyle))  
    'The TotalStyle includes right border, so we need to remove it:  
    sheet1.AddStyle(sheet1.LastAccessed, Workbook.CreateStyle.BorderRight("NONE"))  
      
    sheet1.PutString(xl.AddressOne("C", LastTableRow1 + 2), "Total:").SetStyle(sheet1.LastAccessed, BoldStyle)  
  
    'add auto filters - range with the data. The filters will appear above the data.  
    sheet1.SetAutoFilter(xl.CreateXLRange(xl.AddressName("A2"), xl.AddressOne("D", LastTableRow1)))  
      
    'We forgot to add a title:  
    'shift the rows down  
    sheet1.ShiftRows(0, sheet1.LastAccessed.Row0Based, 1)  
    'merge the cells  
    sheet1.AddMergedRegion(xl.CreateXLRange(xl.AddressName("A1"), xl.AddressName("D1")))  
    'set the title  
    sheet1.PutString(xl.AddressName("A1"), "Important Products List")  
    sheet1.SetStyle(sheet1.LastAccessed, Workbook.CreateStyle.Font(15).HorizontalAlignment("CENTER"))  
      
    'Set the columns widths to fit the content  
    'To make sure that the "total" column is measured correctly we need to first evaluate the formulas:  
    Workbook.EvaluateFormulas  
    For col0 = xl.AddressName("A").Col0Based To xl.AddressName("D").Col0Based  
        sheet1.AutoSizeColumn(col0)  
    Next  
    sheet1.CreateFreezePane(0, 2) 'lock the two upmost rows.  
      
      
    'make the columns a bit wider to make room for the filter arrows:  
    For col0  = 0 To 3  
        sheet1.PoiSheet.SetColumnWidth(col0, sheet1.PoiSheet.GetColumnWidth(col0) + 1200)  
    Next  
      
    'save the workbook  
    Dim f As String = Workbook.SaveAs(File.DirApp, "Products.xlsx", True)  
    Wait For (xl.OpenExcel(f)) Complete (Success As Boolean)  
    StopMessageLoop 'non-ui  
End Sub
```

  
  
I think that the code is quite self-explanatory. Feel free to ask any question you have.  
  
**Tips & Notes**  
  
- Workbook.SaveAs - the third parameter is RenameIfNeeded. If true, it will change the file name after it failed to save. This will happen when the workbook is already open in Excel. It returns the modified file name. You can use it with xl.OpenExcel to show the workbook with Excel, if Excel is installed.  
- Colors should be indexed colors = XL.COLOR constants.  
- The underlying POI types are accessible and are useful in some cases.  
- Make sure to use the latest version of XLUtils: <https://www.b4x.com/android/forum/threads/xlutils-jpoi-5-read-and-write-ms-excel-workbooks.129969/#content>