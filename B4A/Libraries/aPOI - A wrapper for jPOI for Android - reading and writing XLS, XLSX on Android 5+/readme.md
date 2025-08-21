### aPOI - A wrapper for jPOI for Android - reading and writing XLS, XLSX on Android 5+ by DonManfred
### 03/01/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/110652/)

This is a wrap for [this Github project](https://github.com/andruhon/android5xlsx) which is itself a wrap for jPOI.  
  
Reading and Writing XLSX on Android 5 Reading and Writing XLSX and XLS on Android 5 with Apache POI  
  
It was quite a challenging task to use Apache POI on android with Dalvik VM. It is much easier to use Apache POI on Android 5+ with ART VM and Build Tools 21+  
  
Please refer to <https://github.com/andruhon/AndroidReadXLSX> if you need to read XLSX on Android 4 with Dalvik VM.  
  
#Contents I've repacked poi-ooxml to contain all dependencies in order to read and write XLSX (XLS as well, obviously) All javax classes from the STAX library and calls to them are renamed to aavax, to avoid –core-library warning and conflicts.  
  

- poi-3.12-android-a.jar //Repacked POI with all dependencies
- poi-ooxml-schemas-3.12-20150511-a.jar //original schemas jar

  
Download the additional jars: [[SIZE=7]HERE[/SIZE]](https://www.dropbox.com/s/6d3dmzsibe218b9/aPOIjars.zip?dl=0)  
  
**aPOI  
Author:** DonManfred  
**Version:** 0.08  

- **XLSSheet**

- **Functions:**

- **addHyperlink** (hyperlink As org.apache.poi.xssf.usermodel.XSSFHyperlink)
- **addMergedRegion** (region As org.apache.poi.ss.util.CellRangeAddress) As Int
- **addRelation** (id As String, part As org.apache.poi.POIXMLDocumentPart)
- **addValidationData** (dataValidation As org.apache.poi.ss.usermodel.DataValidation)
- **autoSizeColumn** (column As Int)
- **autoSizeColumn2** (column As Int, useMergedCells As Boolean)
- **createComment** As org.apache.poi.xssf.usermodel.XSSFComment
- **createDrawingPatriarch** As org.apache.poi.xssf.usermodel.XSSFDrawing
- **createFreezePane** (colSplit As Int, rowSplit As Int)
- **createPivotTable** (source As org.apache.poi.ss.util.AreaReference, position As org.apache.poi.ss.util.CellReference) As org.apache.poi.xssf.usermodel.XSSFPivotTable
- **createPivotTable2** (source As org.apache.poi.ss.util.AreaReference, position As org.apache.poi.ss.util.CellReference, sourceSheet As org.apache.poi.ss.usermodel.Sheet) As org.apache.poi.xssf.usermodel.XSSFPivotTable
- **createRow** (rownum As Int) As XSSFRow
- **createSplitPane** (xSplitPos As Int, ySplitPos As Int, leftmostColumn As Int, topRow As Int, activePane As Int)
- **createTable** As org.apache.poi.xssf.usermodel.XSSFTable
- **disableLocking**
- **enableLocking**
- **findEndOfRowOutlineGroup** (row As Int) As Int
- **getCellComment** (row As Int, column As Int) As org.apache.poi.xssf.usermodel.XSSFComment
- **getColumnOutlineLevel** (columnIndex As Int) As Int
- **getColumnStyle** (column As Int) As org.apache.poi.ss.usermodel.CellStyle
- **getColumnWidth** (columnIndex As Int) As Int
- **getColumnWidthInPixels** (columnIndex As Int) As Float
- **getHyperlink** (row As Int, column As Int) As org.apache.poi.xssf.usermodel.XSSFHyperlink
- **getMargin** (margin As Short) As Double
- **getMergedRegion** (index As Int) As org.apache.poi.ss.util.CellRangeAddress
- **getRow** (rownum As Int) As org.apache.poi.xssf.usermodel.XSSFRow
- **getSharedFormula** (sid As Int) As org.openxmlformats.schemas.spreadsheetml.x2006.main.CTCellFormula
- **groupColumn** (fromColumn As Int, toColumn As Int)
- **groupRow** (fromRow As Int, toRow As Int)
- **hasComments** As Boolean
- **isColumnBroken** (column As Int) As Boolean
- **isColumnHidden** (columnIndex As Int) As Boolean
- **IsInitialized** As Boolean
- **isRowBroken** (row As Int) As Boolean
- **isSelected** As Boolean
- **iterator** As java.util.Iterator
- **protectSheet** (password As String)
- **removeArrayFormula** (cell As org.apache.poi.ss.usermodel.Cell) As org.apache.poi.ss.usermodel.CellRange
- **removeColumnBreak** (column As Int)
- **removeHyperlink** (row As Int, column As Int)
- **removeMergedRegion** (index As Int)
- **removeMergedRegions** (indices As java.util.Set)
- **removeRow** (row As org.apache.poi.ss.usermodel.Row)
- **removeRowBreak** (row As Int)
- **rowIterator** As java.util.Iterator
- **setArrayFormula** (formula As String, range As org.apache.poi.ss.util.CellRangeAddress) As org.apache.poi.ss.usermodel.CellRange
- **setAutoFilter** (range As org.apache.poi.ss.util.CellRangeAddress) As org.apache.poi.xssf.usermodel.XSSFAutoFilter
- **setCellComment** (cellRef As String, comment As org.apache.poi.xssf.usermodel.XSSFComment)
- **setColumnGroupCollapsed** (columnNumber As Int, collapsed As Boolean)
- **setColumnHidden** (columnIndex As Int, hidden As Boolean)
- **setColumnWidth** (columnIndex As Int, width As Int)
- **setDefaultColumnStyle** (column As Int, style As org.apache.poi.ss.usermodel.CellStyle)
- **setMargin** (margin As Short, size As Double)
- **setRowGroupCollapsed** (rowIndex As Int, collapse As Boolean)
- **setSheetPassword** (password As String, hashAlgo As org.apache.poi.poifs.crypt.HashAlgorithm)
- **SetZoom** (scale As Int)
- **SetZoom2** (numerator As Int, denominator As Int)
- **shiftRows** (startRow As Int, endRow As Int, n As Int, copyRowHeight As Boolean, resetOriginalRowHeight As Boolean)
- **shiftRows2** (startRow As Int, endRow As Int, n As Int)
- **showInPane** (toprow As Int, leftcol As Int)
- **showInPane2** (toprow As Short, leftcol As Short)
- **ungroupColumn** (fromColumn As Int, toColumn As Int)
- **ungroupRow** (fromRow As Int, toRow As Int)
- **validateSheetPassword** (password As String) As Boolean

- **Properties:**

- **ActiveCell** As String
- **Autobreaks** As Boolean
- **ColumnBreak** As Int [write only]
- **ColumnBreaks** As Int() [read only]
- **CTWorksheet** As org.openxmlformats.schemas.spreadsheetml.x2006.main.CTWorksheet [read only]
- **DataValidationHelper** As org.apache.poi.ss.usermodel.DataValidationHelper [read only]
- **DataValidations** As java.util.List [read only]
- **DefaultColumnWidth** As Int
- **DefaultRowHeight** As Short
- **DefaultRowHeightInPoints** As Float
- **DisplayFormulas** As Boolean
- **DisplayGridlines** As Boolean
- **DisplayGuts** As Boolean
- **DisplayRowColHeadings** As Boolean
- **DisplayZeros** As Boolean
- **DrawingPatriarch** As org.apache.poi.xssf.usermodel.XSSFDrawing [read only]
- **EvenFooter** As org.apache.poi.ss.usermodel.Footer [read only]
- **EvenHeader** As org.apache.poi.ss.usermodel.Header [read only]
- **FirstFooter** As org.apache.poi.ss.usermodel.Footer [read only]
- **FirstHeader** As org.apache.poi.ss.usermodel.Header [read only]
- **FirstRowNum** As Int [read only]
- **FitToPage** As Boolean
- **Footer** As org.apache.poi.ss.usermodel.Footer [read only]
- **ForceFormulaRecalculation** As Boolean
- **Header** As org.apache.poi.ss.usermodel.Header [read only]
- **HorizontallyCenter** As Boolean
- **LastRowNum** As Int [read only]
- **LeftCol** As Short [read only]
- **lockAutoFilter** As Boolean
- **lockDeleteColumns** As Boolean
- **lockDeleteRows** As Boolean
- **lockFormatCells** As Boolean
- **lockFormatColumns** As Boolean
- **lockFormatRows** As Boolean
- **lockInsertColumns** As Boolean
- **lockInsertHyperlinks** As Boolean
- **lockInsertRows** As Boolean
- **lockObjects** As Boolean
- **lockPivotTables** As Boolean
- **lockScenarios** As Boolean
- **lockSelectLockedCells** As Boolean
- **lockSelectUnlockedCells** As Boolean
- **lockSort** As Boolean
- **NumHyperlinks** As Int [read only]
- **NumMergedRegions** As Int [read only]
- **OddFooter** As org.apache.poi.ss.usermodel.Footer [read only]
- **OddHeader** As org.apache.poi.ss.usermodel.Header [read only]
- **PaneInformation** As org.apache.poi.hssf.util.PaneInformation [read only]
- **PhysicalNumberOfRows** As Int [read only]
- **PivotTables** As java.util.List [read only]
- **PrintGridlines** As Boolean
- **PrintSetup** As org.apache.poi.xssf.usermodel.XSSFPrintSetup [read only]
- **Protect** As Boolean [read only]
- **RepeatingColumns** As org.apache.poi.ss.util.CellRangeAddress
- **RepeatingRows** As org.apache.poi.ss.util.CellRangeAddress
- **RightToLeft** As Boolean [write only]
- **RowBreak** As Int [write only]
- **RowBreaks** As Int() [read only]
- **RowSumsBelow** As Boolean
- **RowSumsRight** As Boolean
- **ScenarioProtect** As Boolean [read only]
- **Selected** As Boolean [write only]
- **SheetConditionalFormatting** As org.apache.poi.xssf.usermodel.XSSFSheetConditionalFormatting [read only]
- **SheetLocked** As Boolean [read only]
- **TabColor** As Int [write only]
- **Tables** As java.util.List [read only]
- **TopRow** As Short [read only]
- **VerticallyCenter** As Boolean

- **XSSFCell**

- **Functions:**

- **Initialize** (cell As org.apache.poi.xssf.usermodel.XSSFCell)
- **IsInitialized** As Boolean
- **isPartOfArrayFormulaGroup** As Boolean
- **removeCellComment**
- **removeHyperlink**
- **setAsActiveCell**
- **toString** As String

- **Properties:**

- **ArrayFormulaRange** As org.apache.poi.ss.util.CellRangeAddress [read only]
- **BooleanCellValue** As Boolean
- **CachedFormulaResultType** As Int [read only]
- **CellComment** As org.apache.poi.xssf.usermodel.XSSFComment
- **CellErrorValue** As Byte [write only]
- **CellFormula** As String
- **CellStyle** As org.apache.poi.xssf.usermodel.XSSFCellStyle
- **CellType** As Int
- **ColumnIndex** As Int [read only]
- **CTCell** As org.openxmlformats.schemas.spreadsheetml.x2006.main.CTCell
- **DateCellValue** As Long
- **ErrorCellString** As String [read only]
- **ErrorCellValue** As Byte [read only]
- **Hyperlink** As org.apache.poi.xssf.usermodel.XSSFHyperlink
- **NumericCellValue** As Double
- **RawValue** As String [read only]
- **Reference** As String [read only]
- **RichStringCellValue** As org.apache.poi.xssf.usermodel.XSSFRichTextString [read only]
- **RichTextStringCellValue** As org.apache.poi.ss.usermodel.RichTextString [write only]
- **Row** As org.apache.poi.xssf.usermodel.XSSFRow [read only]
- **RowIndex** As Int [read only]
- **Sheet** As org.apache.poi.xssf.usermodel.XSSFSheet [read only]
- **StringCellValue** As String

- **XSSFRow**

- **Functions:**

- **compareTo** (row As org.apache.poi.xssf.usermodel.XSSFRow) As Int
- **createCell** (columnIndex As Int) As org.apache.poi.xssf.usermodel.XSSFCell
- **createCell2** (columnIndex As Int, type As Int) As org.apache.poi.xssf.usermodel.XSSFCell
- **getCell** (cellnum As Int) As XSSFCell
- **isFormatted** As Boolean
- **IsInitialized** As Boolean
- **removeCell** (cell As org.apache.poi.ss.usermodel.Cell)
- **toString** As String

- **Properties:**

- **CTRow** As org.openxmlformats.schemas.spreadsheetml.x2006.main.CTRow [read only]
- **FirstCellNum** As Short [read only]
- **Height** As Short
- **HeightInPoints** As Float
- **LastCellNum** As Short [read only]
- **OutlineLevel** As Int [read only]
- **PhysicalNumberOfCells** As Int [read only]
- **RowNum** As Int
- **RowStyle** As org.apache.poi.xssf.usermodel.XSSFCellStyle
- **Sheet** As org.apache.poi.xssf.usermodel.XSSFSheet [read only]
- **ZeroHeight** As Boolean

- **XSSFWorkbook**

- **Functions:**

- **addPicture** (arg0 As Byte(), arg1 As Int) As Int
- **addPicture2** (is As java.io.InputStream, format As Int) As Int
- **close**
- **createCellStyle** As org.apache.poi.xssf.usermodel.XSSFCellStyle
- **createDataFormat** As org.apache.poi.xssf.usermodel.XSSFDataFormat
- **createFont** As org.apache.poi.xssf.usermodel.XSSFFont
- **createName** As org.apache.poi.xssf.usermodel.XSSFName
- **createSheet** As org.apache.poi.xssf.usermodel.XSSFSheet
- **createSheet2** (name As String) As org.apache.poi.xssf.usermodel.XSSFSheet
- **getCellStyleAt** (idx As Short) As org.apache.poi.xssf.usermodel.XSSFCellStyle
- **getFontAt** (idx As Short) As org.apache.poi.xssf.usermodel.XSSFFont
- **getName** (name As String) As org.apache.poi.xssf.usermodel.XSSFName
- **getNameAt** (nameIndex As Int) As org.apache.poi.xssf.usermodel.XSSFName
- **getPrintArea** (sheetIndex As Int) As String
- **getRelationById** (id As String) As org.apache.poi.POIXMLDocumentPart
- **getRelationId** (arg0 As org.apache.poi.POIXMLDocumentPart) As String
- **getSheet** (sheet As String) As org.apache.poi.xssf.usermodel.XSSFSheet
- **getSheetAt** (index As Int) As XLSSheet
- **getSheetIndex** (sheet As String) As Int
- **getSheetIndex2** (sheet As org.apache.poi.ss.usermodel.Sheet) As Int
- **getSheetName** (sheetIx As Int) As String
- **Initialize** (EventName As String, filename As String)
- **Initialize2** (EventName As String)
- **isSheetHidden** (sheetIx As Int) As Boolean
- **isSheetVeryHidden** (sheetIx As Int) As Boolean
- **linkExternalWorkbook** (name As String, workbook As org.apache.poi.ss.usermodel.Workbook) As Int
- **lockRevision**
- **lockStructure**
- **lockWindows**
- **removeName** (nameIndex As Int)
- **removeName2** (name As String)
- **removePrintArea** (area As Int)
- **removeSheetAt** (index As Int)
- **setPrintArea** (sheetIndex As Int, startColumn As Int, endColumn As Int, startRow As Int, endRow As Int)
- **setPrintArea2** (arg0 As Int, arg1 As String)
- **setRepeatingRowsAndColumns** (sheetIndex As Int, startColumn As Int, endColumn As Int, startRow As Int, endRow As Int)
- **setRevisionsPassword** (password As String, hashAlgo As org.apache.poi.poifs.crypt.HashAlgorithm)
- **setSheetName** (sheetIndex As Int, sheetname As String)
- **unLock**
- **unLockRevision**
- **unLockStructure**
- **unLockWindows**
- **write** (outputstream As java.io\_OutputStream)

- **Properties:**

- **ActiveSheet** As Int [write only]
- **ActiveSheetIndex** As Int [read only]
- **AllEmbedds** As java.util.List [read only]
- **AllPictures** As java.util.List [read only]
- **CalculationChain** As org.apache.poi.xssf.model.CalculationChain [read only]
- **CreationHelper** As org.apache.poi.xssf.usermodel.XSSFCreationHelper [read only]
- **CTWorkbook** As org.openxmlformats.schemas.spreadsheetml.x2006.main.CTWorkbook [read only]
- **CustomXMLMappings** As java.util.Collection [read only]
- **ExternalLinksTable** As java.util.List [read only]
- **FirstVisibleTab** As Int
- **ForceFormulaRecalculation** As Boolean
- **Hidden** As Boolean
- **iterator** As java.util.Iterator [read only]
- **MacroEnabled** As Boolean [read only]
- **MapInfo** As org.apache.poi.xssf.model.MapInfo [read only]
- **MissingCellPolicy** As org.apache.poi.ss.usermodel.Row.MissingCellPolicy
- **NumberOfFonts** As Short [read only]
- **NumberOfNames** As Int [read only]
- **NumberOfSheets** As Int [read only]
- **NumCellStyles** As Short [read only]
- **Package** As org.apache.poi.openxml4j.opc.OPCPackage [read only]
- **PackagePart** As org.apache.poi.openxml4j.opc.PackagePart [read only]
- **PackageRelationship** As org.apache.poi.openxml4j.opc.PackageRelationship [read only]
- **Parent** As org.apache.poi.POIXMLDocumentPart [read only]
- **PivotTables** As java.util.List [read only]
- **Properties** As org.apache.poi.POIXMLProperties [read only]
- **Relations** As java.util.List [read only]
- **RevisionLocked** As Boolean [read only]
- **SharedStringSource** As org.apache.poi.xssf.model.SharedStringsTable [read only]
- **StructureLocked** As Boolean [read only]
- **StylesSource** As org.apache.poi.xssf.model.StylesTable [read only]
- **Theme** As org.apache.poi.xssf.model.ThemesTable [read only]
- **WindowsLocked** As Boolean [read only]

  
Example code:  

```B4X
    File.Copy(File.DirAssets,"book1.xlsx",File.DirInternal,"book1.xlsx")  
    xls.Initialize("",File.Combine(File.DirInternal,"book1.xlsx"))  
    Log($"ActiveSheetIndex=${xls.ActiveSheetIndex}"$)  
    Dim sheet As XLSSheet = xls.getSheetAt(xls.ActiveSheetIndex)  
    Log($"ActiveSheet.ActiveCell=${sheet.ActiveCell}"$)  
    Log($"ActiveSheet.hasComments=${sheet.hasComments}"$)  
    Dim firstrow As Int = sheet.FirstRowNum  
    Dim lastrow As Int = sheet.LastRowNum  
    Log($"Row FirstRow=${firstrow}, LastRow=${lastrow}"$)  
    For i= firstrow To lastrow  
        Dim row As XSSFRow =sheet.getRow(i)  
        'Log(row)  
        Dim firstcell As Int = row.FirstCellNum  
        Dim lastcell As Int = row.LastCellNum  
        Log($"Row #${i} FirstCell=${row.FirstCellNum}, LastCell=${row.LastCellNum}"$)  
'        If i = 1 Then  
'            Dim cell As XSSFCell =row.getCell(13)  
'            cell.StringCellValue = "Test.pdf"  
'        End If  
        For o= firstcell To lastcell-1  
            Dim cell As XSSFCell =row.getCell(o)  
            Log($"Cell #${o}"$)  
            'Log(cell.IsInitialized)  
            If cell.IsInitialized Then  
                Log($"CellValueType=${cell.CellType}"$)  
                'Log("Raw:"&cell.RawValue)  
                If cell.CellType = 1 Then  
                    Log(cell.StringCellValue)  
                else if cell.CellType = 0 Then  
                    Log(cell.NumericCellValue)  
                End If  
            '    Log(cell)  
            End If  
            'Log(row)  
  
        Next  
    Next  
  
  
    Dim row As XSSFRow = sheet.createRow(30)  
    Dim cell As XSSFCell =row.createCell(0)  
    cell.NumericCellValue = 29  
    Dim cell As XSSFCell =row.createCell(1)  
    cell.StringCellValue = "Erel Rocks"  
    Dim cell As XSSFCell =row.createCell(2)  
    cell.StringCellValue = "B4X :-)"  
    Dim cell As XSSFCell =row.createCell(3)  
    cell.NumericCellValue = 99  
    Dim cell As XSSFCell =row.createCell(4)  
    cell.NumericCellValue = 2019  
    Dim cell As XSSFCell =row.createCell(5)  
    cell.StringCellValue = "aPOI"  
    Dim cell As XSSFCell =row.createCell(6)  
    cell.NumericCellValue = 9.9  
  
    Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_WRITE_EXTERNAL_STORAGE)  
    wait for Activity_PermissionResult (Permission As String, Result As Boolean)  
    If Result Then  
        Dim outstream As OutputStream = File.OpenOutput(File.DirRootExternal,"excelout.xlsx",False)  
        xls.write(outstream)  
        outstream.Close  
    End If
```

  
  
Note that the b4a wrap is far from being complete! Only a few Objects are wrapped as yet.  
The Sheet, SheetRows and SheetColumns.  
  
i guess there are hundrets of Objects missing.  
For simple reading and writing it should work. I hope :D