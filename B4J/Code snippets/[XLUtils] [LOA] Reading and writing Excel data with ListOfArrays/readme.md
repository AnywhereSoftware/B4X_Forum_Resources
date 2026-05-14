### [XLUtils] [LOA] Reading and writing Excel data with ListOfArrays by Erel
### 05/10/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170983/)

[XLUtils v2.10](https://www.b4x.com/android/forum/threads/xlutils-jpoi-5-read-and-write-ms-excel-workbooks.129969) adds support for reading data as ListOfArrays, and writing data from ListOfArrays.  
Note that it depends on [ListOfArrays v0.94+](https://www.b4x.com/android/forum/threads/b4x-loa-listofarrays-lightweight-powerful-and-flexible-collection.170543/#content).  
  
Very simple to use.  
  
Excel workbook:  
  
![](https://www.b4x.com/android/forum/attachments/171431)  
Reading:  

```B4X
'Read the sheet:  
Dim res As XLReaderResult = xl.Reader.ReadSheetByIndex("C:\Users\H\Downloads\Countries of the world.xlsx", "", 0)  
'Select a range to be read as a LOA:  
Dim loa As ListOfArrays = res.GetListOfArrays(xl.CreateXLRange(xl.AddressName("B4"), res.BottomRight), True)
```

  
  
Lets play with the data:  

```B4X
'There are extra white spaces in the country names column. Need to clean…  
Dim ls As LOASet = loa.CreateLOASet  
Do While ls.NextRow  
    Dim CountryName As String = ls.GetValue("Country")  
    ls.SetValue("Country", CountryName.Trim)  
Loop  
loa.Sort("Population", False)  
'print a few columns:  
Log(loa.ToListOfArrays(Array("Country", "Region", "Population", "Testing Dates")).ToString(5))  
'get data of single country:  
Dim Zim As ListOfArrays = loa.GetRowsByValue("Country", "Zimbabwe")  
Log(Zim.ToString(0))
```

  
  
Writing:  

```B4X
Dim writer As XLWorkbookWriter = xl.CreateWriterBlank 'new empty workbook  
Dim sheet As XLSheetWriter = writer.CreateSheetWriterByName("Cool Table") 'add a sheet  
Dim TableRange As XLRange = sheet.PutLOA(loa, xl.AddressName("B2"), Array("Testing Dates")) 'write the LOA, starting from B2  
'make the table a bit prettier:  
For c = TableRange.FirstAddress.Col0Based To TableRange.SecondAddress.Col0Based  
    sheet.AutoSizeColumn©  
Next  
Dim table As XLTable = sheet.CreateTable(TableRange, "Countries", "TableStyleMedium2") 'set it to be an Excel table.  
table.ShowRowStripes = True  
table.AddAutoFilter  
Dim f As String = writer.SaveAs("C:\Users\H\Downloads", "Test.xlsx", False)  
xl.OpenExcel(f)
```

  
  
Output:  
![](https://www.b4x.com/android/forum/attachments/171432)