### XLUtils  / jPOI 5 - Read and write MS Excel workbooks by Erel
### 08/04/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/129969/)

As written [here](https://www.b4x.com/android/forum/threads/excel-time.129613/), I plan to make it easier to read and write Excel workbooks.  
The solution is based on three components:  
- Apache POI - <https://poi.apache.org/>  
Large open source project that provides APIs for Microsoft documents. Note that the files are accessed directly, it doesn't depend on the Excel program.  
- jPOI - This is a wrapper for Apache POI.  
- XLUtils - A b4xlib (B4J only) that adds more features and utilities.  
  
jPOI is not a new library, however a new version is included here based on POI 5.0.0. The updated library is not 100% backward compatible with the previous version. It fixes several mistakes in the previous wrapper.  
It should be simple to update.  
  
Installation:  
  
- **Download POI dependencies** and put them in the additional libraries folder: [www.b4x.com/b4j/files/poi5\_dependencies.zip](https://www.b4x.com/b4j/files/poi5_dependencies.zip)  
- Download XLUtils. It includes the updated jPOI. Put them in the additional libraries as well.  
  
A few concepts that you need to understand:  
  
- 0 based / 1 based indices - jPOI works with 0 based rows and columns. Cell A1 = (0, 0). Working with the indices can be annoying as no one knows the index of column M (and if you do then you surely don't know the index of column AQ).  
XLUtils includes a type named XLAddress. It makes it easy to switch between the 0 based indices and the addresses "names", as they appear in Excel.  
You can create an address in three ways:  

```B4X
'identical result:  
address = xl.AddressZero(0, 0)  
address = xl.AddressName("A1")  
address = xl.AddressOne("A", 1)  
'another example:  
address = xl.AddressZero(3, 4)  
address = xl.AddressName("D5")  
address = xl.AddressOne("D", 5)
```

  
  
- XLReader - Tool to read data from a workbook. Can read the complete workbook, a single sheet or one or more ranges.  
Ranges are strings such as: "sheet1!F2:M100" or named ranges. Named ranges are set in Excel (search for name manager in Excel). This is a very useful feature.  
  
![](https://www.b4x.com/android/forum/attachments/112058)  
  
  
- Empty or missing cells - In some cases Excel omits blank cells. There are no PoiCells behind empty cells. XLReader will fill such cells, when needed, with empty strings. Later when you read the data you can use result.GetDefault to replace empty cells with other values.  
- Dates - Dates are stored as ticks, a Long typed number.  
- Formulas - Excel stores a cached value together with the formula itself. PoiCell.ValueCached will return the cached value for formula cells. XLReader will also return the cached value.  
  
  
**XLReader - XL.Reader**  
  
XLReader is useful when you want to read data from an Excel workbook. You can read a workbook, a sheet or one or more ranges in a single line of code:  

```B4X
'three examples  
Dim result As XLReaderResult = XL.Reader.ReadRange(File.DirAssets, "Countries of the world.xlsx", "Sheet1!B3:E1000") 'read specific range  
Dim result As XLReaderResult = XL.Reader.ReadRange(File.DirAssets, "Countries of the world.xlsx", "Countries") 'named range  
Dim result As XLReaderResult = XL.Reader.ReadSheetByName(File.DirAssets, "Countries of the world.xlsx", "Sheet1") 'complete sheet
```

  
Call result.LogResult(True) to log useful information about the result.  
  
XLReader will fill missing cells when needed. The actual behavior depends on whether reading a complete sheet or a range.  
This is less important unless you access the underlying read data directly.  
  
The recommended way to extract data from XLReaderResult is with the Get or GetDefault methods.  
XLReaderResult.Get expects a XLAddress object and it returns the cell value. If the cell is empty or missing, it will return the value of XLReaderResult.DefaultEmptyCellValue (empty string by default).  
GetDefault will return the passed default value if the cell is empty or missing.  

```B4X
Dim Number As Int = result.Get(xl.AddressName("A4"))  
Dim Number As Int = result.GetDefault(xl.AddressName("A4"), 12)
```

  
XLReaderResult also includes a TopLeft and BottomRight addresses fields. They can be used to find the end of document.  
  
An example of reading data from a workbook and showing some of the data with B4XTable is attached.  
  
The code:  

```B4X
Dim result As XLReaderResult = XL.Reader.ReadRange(File.DirAssets, "Countries of the world.xlsx", "Sheet1!B3:E1000")  
B4XTable1.AddColumn(result.Get(XL.AddressName("B4")), B4XTable1.COLUMN_TYPE_TEXT)  
B4XTable1.AddColumn(result.Get(XL.AddressName("D4")), B4XTable1.COLUMN_TYPE_NUMBERS)  
B4XTable1.AddColumn(result.Get(XL.AddressName("E4")), B4XTable1.COLUMN_TYPE_NUMBERS)  
Dim TableData As List  
TableData.Initialize  
For Row1Based = 6 To result.BottomRight.Row0Based + 1  
    Dim Country As String = result.Get(XL.AddressOne("B", Row1Based))  
    If Country = "" Then Exit 'Not really needed in this case, but it is good practice.  
    Dim Population As Int = result.Get(XL.AddressOne("D", Row1Based))  
    Dim Area As Int = result.Get(XL.AddressOne("E", Row1Based))  
    TableData.Add(Array(Country, Population, Area))  
Next  
B4XTable1.SetData(TableData)
```

  
  
![](https://www.b4x.com/android/forum/attachments/112060)  
  
Don't forget to download POI dependencies (link is above).  
  
Tips:  
  
- Building in debug mode is significantly faster as the POI jars are quite large and they are merged in release mode.  
- More tutorials and examples: <https://www.b4x.com/android/forum/pages/results/?query=xlutils>  
  
Updates:  
  
- V2.09 - New bidi attribute for paragraph tags.  
- V2.08 - New FieldCode tag for Word documents: <https://www.b4x.com/android/forum/threads/xlutils-jpoi-5-read-and-write-ms-excel-workbooks.129969/post-996012>  
- V2.07 - Fixes an issue with xl.AddressToString and columns with 'Z' address. Thanks [USER=99040]@angel\_[/USER] !  
- V2.06 - Fixes an issue that caused a compilation error in non-ui apps.  
- V2.04 - Word - new SetMargins method. This method, as SetLandscapeOrientation, depends on poi-ooxml-full (XL\_FULL). See <https://www.b4x.com/android/forum/threads/xlutils-jpoi-5-read-and-write-ms-excel-workbooks.129969/post-832993>  
- V2.03 - Word - Adds support for setting the page orientation to landscape: <https://www.b4x.com/android/forum/threads/xlutils-jpoi-5-read-and-write-ms-excel-workbooks.129969/post-832993>  
- V2.02 - Word - bookmarks, page breaks and urls: <https://www.b4x.com/android/forum/threads/xlutils-word-bookmarks-urls-and-page-breaks.131826/>  
- V2.01 - Adds support for merging cells in Word tables: <https://www.b4x.com/android/forum/threads/xlutils-creating-ms-word-documents.131732/post-831464>  
- V2.00 - Adds support for creating MS Word documents: <https://www.b4x.com/android/forum/threads/xlutils-creating-ms-word-documents.131732/>  
- V1.14 - Support for reading hyperlinks: <https://www.b4x.com/android/forum/threads/xlutils-jpoi-5-read-and-write-ms-excel-workbooks.129969/post-828352>  
- V1.13 - Support for generating PDF documents with XL.PowerShellConvertToPdf: <https://www.b4x.com/android/forum/threads/xlutils-generate-pdf-reports.131119/>  
- v1.12 - New methods and properties: XLSheetWriter.SetFitToPage, PrintSetup and PrintArea.  
- v1.11 - Support for tables: <https://www.b4x.com/android/forum/threads/xlutils-creating-tables.130567/>  
- v1.10 - Styling implementation was rewritten. XLStyle.BoldFont renamed to FontBold.  
- v1.05 - Adds support for conditional formatting: <https://www.b4x.com/android/forum/threads/xlutils-conditional-formatting.130454/>  
- v1.04 - XLStyle.LinkFont renamed to XLStyle.FontLink to be consistent with the other font related methods. New XLWorkbookWriter.RemoveSheetAt method.  
- XLUtils v1.03 - Adds support for outlining and links: <https://www.b4x.com/android/forum/threads/xlutils-hyperlinks-and-outlining-grouping.130413/>  
- XLUtils v1.02 + jPOI 5.01 are attached. Many changes.  
  
Tutorial about writing workbooks: <https://www.b4x.com/android/forum/threads/xlutils-writing-excel-workbooks.130356/>