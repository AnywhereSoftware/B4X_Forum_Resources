### B4AXLUtils - High-Performance Excel Manipulation (.xls/.xlsx) powered by Apache POI by fernando1987
### 05/27/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171131/)

Hi All,  
  
I would like to present **B4AXLUtils** (based on the powerful ExcelUtils project). This library delivers a native B4A interface to seamlessly create, read, modify, and style Microsoft Excel spreadsheets (both legacy .xls and modern .xlsx formats) directly on Android devices—**fast, efficiently, and with zero dependency on external GUI apps**.  
  
It is built on top of the robust **Apache POI 5.x** architecture and optimized via JavaObject to guarantee premium performance on mobile hardware.  
  
[MEDIA=googledrive]1M0d0jjloidTDnC\_PAGaZ0F\_\_D\_rJVot8[/MEDIA]  
[HEADING=3]🛠️ Dependencies and Configuration[/HEADING]  
To use this library in your B4A project, please ensure you check the following libraries in the B4A IDE manager:  
  

- **Core**
- **JavaObject**
- **SQL**

[HEADING=2]Architecture Design[/HEADING]  
The library splits its features into four main classes (components) that encapsulate the native Excel API structure:  
  

1. **ExcelManager**: Manages the core Workbook, global file I/O operations, mass read/write tasks, and automatic database exports.
2. **ExcelSheet**: Governs worksheet-level attributes, range styling, native filters, frozen panes, and automatic column widths.
3. **ExcelRow**: Controls individual rows and handles sequential data population.
4. **ExcelCell**: Handles the cell as an atomic entity (applying specific fonts, formulas, numeric formatting, colors, and hyperlinks).

[HEADING=2]📂 Main Methods Reference[/HEADING]  
[HEADING=3]1. ExcelManager[/HEADING]  

- **CreateWorkbook**: Initializes an empty in-memory workbook using the modern .xlsx standard.
- **ReadWorkbook** (Directory As String, FileName As String) As ExcelManager Loads an existing spreadsheet file, auto-detecting whether it is a .xls or .xlsx structure. *Return format:* **Dim xl As ExcelManager = Manager.ReadWorkbook(File.DirInternal, "data.xlsx")**
- **SearchAndReplace** (SearchText As String, ReplaceText As String) As ExcelManager Performs a global search-and-replace routine across every single sheet in the workbook. *Return format:* **Dim xl As ExcelManager = Manager.SearchAndReplace("{DATE}", "2026-05-27")**
- **CreateSheet** (Name As String) As ExcelSheet Adds a brand-new worksheet to the current book with the given name. *Return format:* **Dim sheet As ExcelSheet = Manager.CreateSheet("Summary")**
- **TableToExcel** (Rs As ResultSet, SheetName As String) Dumps a SQL ResultSet automatically into an elegant sheet, rendering clear headers, borders, and custom-tailored column widths optimized for Android devices.
- **TableToExcelWithItem** (Rs As ResultSet, SheetName As String) Identical to the method above, but prepends an incremental "ITEM" column on the far left for numbered row tracking.

[HEADING=3]2. ExcelSheet[/HEADING]  

- **GetRow** (RowIdx As Int) As ExcelRow Returns the requested row wrapper. If the row is missing from the physical sheet structure, it initializes it automatically on the fly. *Return format:* **Dim row As ExcelRow = Sheet.GetRow(5)**
- **LastRowWithData** As Int Finds the true last row index containing useful data, completely ignoring rows with empty formatting or white spaces. *Return format:* **Dim lastRow As Int = Sheet.LastRowWithData**
- **SetRangeStyle** (F1 As Int, F2 As Int, C1 As Int, C2 As Int, Bold As Boolean, Center As Boolean, Border As Boolean, ColorBG As Short, Italic As Boolean, Underline As Boolean, TextColor As Short, TextSize As String) Applies a comprehensive visual style layout to a block of cells. It leverages an inner style cache to heavily prevent memory bloat
- **AutoSizeColumns** (StartCol As Int, EndCol As Int) Scans text length across the given columns and resizes them perfectly, bypassing any GUI environment constraints
- **CreateTable2** (FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int, StyleName As String) Converts a regular cell range into a native Excel Smart Table with built-in styling and filtering enabled (e.g., "TableStyleMedium9")

[HEADING=3]3. ExcelRow[/HEADING]  

- **GetCell** (Index As Int) As ExcelCell Retrieves the cell at the selected column index. If it does not exist yet, it creates it dynamically. *Return format:* **Dim cell As ExcelCell = Row.GetCell(2)**
- **SetValues** (Values() As Object) Quickly populates the whole row using a one-dimensional array of objects while safely handling type conversions

[HEADING=3]4. ExcelCell[/HEADING]  

- **setValue** (Val As Object) Sets the cell data value. It intelligently processes Strings, Numbers, Booleans, and Dates
> **Precision Engineering Note:** If a number exceeds 10 digits (e.g., long contract IDs or bank account numbers), the library forces it as a STRING data type. This safely stops Excel from converting your precise IDs into scientific notation (E+11).

- **getValue** As Object Extracts the raw typed value from the cell cleanly. *Return format:* **Dim myData As Object = Cell.getValue**
- **getFormulaValue** As Object Evaluates and returns the calculated output of an active cell formula by executing the Apache POI evaluation engine. *Return format:* **Dim res As Object = Cell.getFormulaValue**
- **setFormula** (Formula As String) Sets a standard mathematical formula without the leading = sign (e.g., "SUM(B1:B10)").

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