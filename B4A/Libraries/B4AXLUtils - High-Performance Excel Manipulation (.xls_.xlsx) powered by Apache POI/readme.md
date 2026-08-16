### B4AXLUtils - High-Performance Excel Manipulation (.xls/.xlsx) powered by Apache POI by fernando1987
### 08/08/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171131/)

Hi All,  
  
I would like to present **B4AXLUtils** (based on the powerful ExcelUtils project). This library delivers a native B4A interface to seamlessly create, read, modify, and style Microsoft Excel spreadsheets (both legacy .xls and modern .xlsx formats) directly on Android devices—**fast, efficiently, and with zero dependency on external GUI apps**.  
  
It is built on top of the robust **Apache POI 5.x** architecture and optimized via JavaObject to guarantee premium performance on mobile hardware.  
  
[MEDIA=googledrive]1M0d0jjloidTDnC\_PAGaZ0F\_\_D\_rJVot8[/MEDIA]  
[HEADING=3]🛠️ Dependencies and Configuration[/HEADING]  
To use this library in your B4A project, please ensure you check the following libraries in the B4A IDE manager:  
  

- **Core**
- **JavaObject**
- **XUI**

[HEADING=2]Architecture Design[/HEADING]  
The library splits its features into four main classes (components) that encapsulate the native Excel API structure:  
  

1. **ExcelManager**: Manages the core Workbook, global file I/O operations, mass read/write tasks, and automatic database exports.
2. **ExcelSheet**: Governs worksheet-level attributes, range styling, native filters, frozen panes, and automatic column widths.
3. **ExcelRow**: Controls individual rows and handles sequential data population.
4. **ExcelCell**: Handles the cell as an atomic entity (applying specific fonts, formulas, numeric formatting, colors, and hyperlinks).

[HEADING=2]📂 Main Methods Reference[/HEADING]  

---

  
[HEADING=2]Excel Generation Suite[/HEADING]  
[HEADING=3]ExcelManager[/HEADING]  
*POI-based workbook structure manager.*  
  

- **Events**:

- SaveCompleted (Success As Boolean)

- **Properties**:

- ActiveSheetIndex As Int [read only]
- ActiveSheetName As String [read only]

- **Functions**:

- CreateSheet (Name As String) As ExcelSheet
- GetSheet (Name As String) As ExcelSheet
- GetSheetAt (Index As Int) As ExcelSheet
- GetSheetName (Index As Int) As String
- Save (Directory As String, FileName As String)

[HEADING=3]ExcelSheet[/HEADING]  
*Worksheet layout, locking, formatting, and graphics patriarch placement.*  
  

- **Properties**:

- SheetName As String [read only]
- SheetIndex As Int [read only]

- **Functions**:

- GetRow (RowIndex As Int) As ExcelRow
- ProtectSheet (Password As String)
- SetRangeStyle (RowStart As Int, RowEnd As Int, ColStart As Int, ColEnd As Int, Bold As Boolean, Border As Boolean, Centered As Boolean, BGColor As Short, Italic As Boolean, Strike As Boolean, TextColor As Short, Size As Int)
- AddPictureExact (PictureIndex As Int, Col As Int, Row As Int, ScaleX As Double, ScaleY As Double): Positioned image anchored to MOVE\_DONT\_RESIZE.
- AutoSizeColumns (ColStart As Int, ColEnd As Int)

[HEADING=3]ExcelRow[/HEADING]  
*Excel worksheet row manager.*  
  

- **Functions**:

- GetCell (ColIdx As Int) As ExcelCell
- CreateCellTyped (ColIdx As Int, CellType As Int) As ExcelCell

[HEADING=3]ExcelCell[/HEADING]  
*Excel worksheet cell value, formulas, styles, comments, and smart data type detection.*  
  

- **Properties**:

- CellType As Int, CellTypeName As String [read only], Formula As String [write only]
- Value As Object, SmartValue As Object [write only], Date As Long
- Bold As Boolean [write only], Underline As Boolean [write only]
- TextColor As Short [write only], TextSize As Short [write only], BackgroundColor As Short [write only]

- **Functions**:

- clear () As Void
- setCurrency (Value As Double, Symbol As String) As Void
- setCurrencyISO (Value As Double, ISO As String) As Void
- setDateFormatted (Value As Long, FormatStr As String) As Void

---

  
[HEADING=2][/HEADING]  
[HEADING=2]💻 Practical Code Example[/HEADING]  

```B4X
 Sub GenerateExcelReport  
Dim excel As ExcelManager  
 excel.Initialize(Me, "ExcelEvents")  
 excel.CreateWorkbook  
  
' 1. Create the working sheet section  
Dim sheet As ExcelSheet = excel.CreateSheet("Equipment Control")  
sheet.Freeze(0, 1) ' Freeze header row  
  
' 2. Design the column headers  
Dim headerRow As ExcelRow = sheet.GetRow(0)  
headerRow.SetValues(Array("ITEM", "CONTRACT_NO", "CLIENT", "CONSUMPTION"))  
  
' Apply corporate styling to the header (Row 0, Columns 0 to 3)  
sheet.SetRangeStyle(0, 0, 0, 3, True, True, True, excel.CORP_NAVY, False, False, excel.COLOR_WHITE, 11)  
  
' 3. Populating data records  
Dim dataList As List = Array( _  
    Array(1, "095432109876", "Javier Arevalo", 145.20), _  
    Array(2, "091122334455", "Xiomara Alarcon", 89.00) _  
)  
  
For i = 0 To dataList.Size - 1  
    Dim row As ExcelRow = sheet.GetRow(i + 1)  
    Dim currentRecord() As Object = dataList.Get(i)  
   
    row.GetCell(0).setValue(currentRecord(0))  
    row.GetCell(1).setValue(currentRecord(1)) ' Automatically protected as STRING due to its length[cite: 1]  
    row.GetCell(2).setValue(currentRecord(2))  
   
    Dim amountCell As ExcelCell = row.GetCell(3)  
    amountCell.setValue(currentRecord(3))  
   
    ' Individual formatting and currency mask  
    sheet.SetRangeDataFormat(i + 1, i + 1, 3, 3, "$#,##0.00")  
    sheet.SetRangeStyle(i + 1, i + 1, 0, 3, False, False, True, excel.COLOR_NONE, False, False, excel.COLOR_BLACK, 10)  
Next  
  
' 4. Auto-fit columns seamlessly  
sheet.AutoSizeColumns(0, 3)  
  
' 5. Save file to storage  
excel.Save(File.DirInternal, "Equipment_Report.xlsx")  
  
End Sub  
  
Sub ExcelEvents_SaveCompleted(Success As Boolean)  
  
If Success Then  
  
Log("✅ Excel file generated successfully!")  
  
Else  
  
Log("❌ Error saving the file.")  
  
End If  
  
End Sub
```