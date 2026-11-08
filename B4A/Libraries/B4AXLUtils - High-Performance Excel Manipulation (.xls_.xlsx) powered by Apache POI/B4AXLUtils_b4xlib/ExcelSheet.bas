B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' Class Module: ExcelSheet
Sub Class_Globals
#If B4A Or B4J
	Private nativeSheet As JavaObject
#End If
	Private managerRef As ExcelManager
	Private xui As XUI
End Sub

' Initializes the ExcelSheet instance.
Public Sub Initialize (Manager As ExcelManager, sJavaObj As Object)
	managerRef = Manager
#If B4A Or B4J
	nativeSheet = sJavaObj
#End If
End Sub

' Returns the ExcelRow instance at the specified index, creating it if it doesn't exist.
' <code>Dim row As ExcelRow = sheet.GetRow(5)</code>
Public Sub GetRow(RowIdx As Int) As ExcelRow
	Dim rowObj As ExcelRow
#If B4A Or B4J
	Dim r As JavaObject = nativeSheet.RunMethod("getRow", Array(RowIdx))
	If r.IsInitialized = False Then r = nativeSheet.RunMethod("createRow", Array(RowIdx))
	rowObj.Initialize(managerRef, Me, r)
#End If
	Return rowObj
End Sub

' Protects the worksheet with a password.
' <code>sheet.ProtectSheet("pass123")</code>
Public Sub ProtectSheet(Password As String)
#If B4A Or B4J
	nativeSheet.RunMethod("protectSheet", Array(Password))
#End If
End Sub

' === SAFE ADJUSTMENT ENGINEERING FOR ANDROID ===

' Finds the 0-based index of the last row containing actual cell data.
' <code>Dim lastRow As Int = sheet.LastRowWithData</code>
Public Sub LastRowWithData As Int
#If B4A Or B4J
	Dim lastRow As Int = nativeSheet.RunMethod("getLastRowNum", Null)
	For i = lastRow To 0 Step -1
		Dim r As JavaObject = nativeSheet.RunMethod("getRow", Array(i))
		If r.IsInitialized Then
			If RowHasData(r) Then Return i
		End If
	Next
#End If
	Return -1
End Sub

' Helper to determine if a POI Row contains any non-blank cells.
Private Sub RowHasData(r As Object) As Boolean
#If B4A Or B4J
	Dim joRow As JavaObject = r
	Dim lastCell As Int = joRow.RunMethod("getLastCellNum", Null)
	For j = 0 To lastCell - 1
		Dim cell As JavaObject = joRow.RunMethod("getCell", Array(j))
		If cell.IsInitialized Then
			Dim cellTypeEnum As JavaObject = cell.RunMethod("getCellType", Null)
			Dim typeName As String = cellTypeEnum.RunMethod("name", Null)
            
			If typeName <> "BLANK" And typeName <> "ERROR" Then
				If typeName = "STRING" Then
					If cell.RunMethod("getStringCellValue", Null).As(String).Trim <> "" Then Return True
				Else
					Return True
				End If
			End If
		End If
	Next
#End If
	Return False
End Sub

' Returns the 0-based index of the last column containing actual cell data.
' <code>Dim lastCol As Int = sheet.LastColumnWithData</code>
Public Sub LastColumnWithData As Int
#If B4A Or B4J
	Dim lastRowIdx As Int = nativeSheet.RunMethod("getLastRowNum", Null)
	Dim maxColFound As Int = -1
    
	For i = 0 To lastRowIdx
		Dim r As JavaObject = nativeSheet.RunMethod("getRow", Array(i))
		If r.IsInitialized Then
			Dim lastCellInRow As Int = GetLastCellInRowWithData(r)
			If lastCellInRow > maxColFound Then maxColFound = lastCellInRow
		End If
	Next
    
	Return maxColFound
#Else
	Return -1
#End If
End Sub

' Helper to find the last cell in a row containing data (ignoring empty styled cells).
Private Sub GetLastCellInRowWithData(Row As Object) As Int
#If B4A Or B4J
	Dim joRow As JavaObject = Row
	Dim lastCellNum As Int = joRow.RunMethod("getLastCellNum", Null)
	If lastCellNum <= 0 Then Return -1
    
	For i = lastCellNum - 1 To 0 Step -1
		Dim cell As JavaObject = joRow.RunMethod("getCell", Array(i))
		If cell.IsInitialized Then
			Dim cellTypeEnum As JavaObject = cell.RunMethod("getCellType", Null)
			Dim typeName As String = cellTypeEnum.RunMethod("name", Null)
            
			If typeName <> "BLANK" And typeName <> "ERROR" Then
				If typeName = "STRING" Then
					If cell.RunMethod("getStringCellValue", Null).As(String).Trim <> "" Then Return i
				Else
					Return i
				End If
			End If
		End If
	Next
#End If
	Return -1
End Sub

#If B4A Or B4J
' Returns the native POI Sheet JavaObject.
Public Sub getNativeSheet As JavaObject
	Return nativeSheet
End Sub
#End If

' === COMPREHENSIVE STYLE ENGINE (CACHE OPTIMIZED) ===

' Applies a cached CellStyle style across a range of cells.
' <code>sheet.SetRangeStyle(0, 10, 0, 5, True, True, True, excel.PASTEL_CORAL, False, False, excel.COLOR_RED, 12)</code>
Public Sub SetRangeStyle(StartRow As Int, EndRow As Int, StartCol As Int, EndCol As Int, _
                        Bold As Boolean, _
                        Center As Boolean, _
                        Border As Boolean, _
                        ColorBG As Short, _
                        Italic As Boolean, _
                        Underline As Boolean, _
                        TextColor As Short, _
                        TextSize As String)
#If B4A Or B4J
	Dim style As JavaObject = GetCachedStyle(Bold, Center, Border, ColorBG, Italic, Underline, TextColor, TextSize)
    
	For r = StartRow To EndRow
		Dim rowObj As ExcelRow = GetRow(r)
		For c = StartCol To EndCol
			rowObj.GetCell(c).getObject.RunMethod("setCellStyle", Array(style))
		Next
	Next
#End If
End Sub

' Helper to retrieve or create a cached style from the workbook manager.
Private Sub GetCachedStyle(Bold As Boolean, Center As Boolean, Border As Boolean, ColorBG As Short, _
                          Italic As Boolean, Underline As Boolean, TextColor As Short, _
                          FontSize As Int) As JavaObject
#If B4A Or B4J
	Return managerRef.GetCachedStyleInternal(Bold, Center, Border, ColorBG, Italic, Underline, TextColor, FontSize, 0)
#Else
	Return Null
#End If
End Sub

' Auto-adjusts column widths between StartCol and EndCol to fit cell contents dynamically.
' <code>sheet.AutoSizeColumns(0, 5)</code>
Public Sub AutoSizeColumns(StartCol As Int, EndCol As Int)
#If B4A Or B4J
	Try
		Dim lastRowNum As Int = nativeSheet.RunMethod("getLastRowNum", Null)
		If lastRowNum < 0 Then Return
		
		Dim maxLen As Map
		maxLen.Initialize
        
		For c = StartCol To EndCol
			maxLen.Put(c, 8) ' Set a minimum width of 8 characters
		Next

		For rowIndex = 0 To lastRowNum
			Dim row As JavaObject = nativeSheet.RunMethod("getRow", Array(rowIndex))
			If row.IsInitialized Then
				For col = StartCol To EndCol
					Dim cell As JavaObject = row.RunMethod("getCell", Array(col))
					If cell.IsInitialized Then
						Dim sValue As String = cell.RunMethod("toString", Null)
						Dim currentMax As Int = maxLen.Get(col)
                        
						If sValue.Length > currentMax Then
							maxLen.Put(col, sValue.Length)
						End If
					End If
				Next
			End If
		Next

		For i = StartCol To EndCol
			Dim colWidth As Int = maxLen.Get(i)
			Dim finalWidth As Int = (colWidth + 3) * 256 ' POI units: (chars + margin) * 256
			If finalWidth > 255 * 256 Then finalWidth = 255 * 256 ' Bound to Excel column width limits
			nativeSheet.RunMethod("setColumnWidth", Array(i, finalWidth))
		Next
	Catch
		Log("❌ Error in AutoSizeColumns: " & LastException)
	End Try
#End If
End Sub

' Applies a data formatting mask across a range of cells, utilizing cached styles.
' <code>sheet.SetRangeDataFormat(1, 100, 3, 3, "$#,##0.00")</code>
Public Sub SetRangeDataFormat(StartRow As Int, EndRow As Int, StartCol As Int, EndCol As Int, FormatStr As String)
#If B4A Or B4J
	If FormatStr = "" Then Return
    
	Dim wb As JavaObject = managerRef.getNativeWorkbook
	Dim dataFormat As JavaObject = wb.RunMethod("createDataFormat", Null)
	Dim formatIdx As Object = dataFormat.RunMethod("getFormat", Array(FormatStr))
    
	For r = StartRow To EndRow
		Dim rowObj As ExcelRow = GetRow(r)
		For c = StartCol To EndCol
			Dim cellJO As JavaObject = rowObj.GetCell(c).getObject
			Dim currentStyle As JavaObject = cellJO.RunMethod("getCellStyle", Null)
			
			' Retain existing cell style attributes and only override the data format mask in cache
			Dim newStyle As JavaObject = managerRef.GetModifiedStyle(currentStyle, "DATAFORMAT", formatIdx)
			cellJO.RunMethod("setCellStyle", Array(newStyle))
		Next
	Next
#End If
End Sub

' Sets a clickable hyperlink address to the cell.
' <code>sheet.AddHyperlink(1, 1, "https://www.google.com", "Go to Google")</code>
Public Sub AddHyperlink(Row As Int, Col As Int, Address As String, Text As String)
#If B4A Or B4J
	Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
	Dim link As JavaObject = helper.RunMethod("createHyperlink", Array(1)) ' URL Type = 1
    
	link.RunMethod("setAddress", Array(Address))
    
	Dim cell As ExcelCell = GetRow(Row).GetCell(Col)
	cell.setValue(Text)
    
	cell.Object.RunMethod("setHyperlink", Array(link))
#End If
End Sub

' Merges a rectangular block of cells.
' <code>sheet.MergeCells(0, 1, 0, 5)</code>
Public Sub MergeCells(FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int)
#If B4A Or B4J
	Dim region As JavaObject = InitializeNewInstanceSafe("org.apache.poi.ss.util.CellRangeAddress", _
        Array(FirstRow, LastRow, FirstCol, LastCol))
    
	nativeSheet.RunMethod("addMergedRegion", Array(region))
#End If
End Sub

' Freezes rows and columns splits.
' <code>sheet.Freeze(1, 1)</code>
Public Sub Freeze(ColSplit As Int, RowSplit As Int)
#If B4A Or B4J
	nativeSheet.RunMethod("createFreezePane", Array(ColSplit, RowSplit))
#End If
End Sub

' Enables Excel autofilter across a range of cells.
' <code>sheet.SetAutoFilter(0, 100, 0, 5)</code>
Public Sub SetAutoFilter(FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int)
#If B4A Or B4J
	Dim region As JavaObject = InitializeNewInstanceSafe("org.apache.poi.ss.util.CellRangeAddress", _
        Array(FirstRow, LastRow, FirstCol, LastCol))
    
	nativeSheet.RunMethod("setAutoFilter", Array(region))
#End If
End Sub

' Enables Excel autofilter using a range string definition.
' <code>sheet.SetAutoFilter2("A1:F100")</code>
Public Sub SetAutoFilter2(Range As String)
#If B4A Or B4J
	Try
		Dim craStatic As JavaObject = InitializeStaticSafe("org.apache.poi.ss.util.CellRangeAddress")
		Dim region As JavaObject = craStatic.RunMethod("valueOf", Array(Range))
		nativeSheet.RunMethod("setAutoFilter", Array(region))
	Catch
		Log("❌ Error in SetAutoFilter2 (Range): " & LastException)
	End Try
#End If
End Sub

' Password protects the worksheet.
' <code>
'   sheet.Protect("secretPassword")
' </code>
Public Sub Protect(Password As String)
#If B4A Or B4J
	nativeSheet.RunMethod("protectSheet", Array(Password))
#End If
End Sub

' Auto-adjusts a column width based on characters lengths.
' <code>
'   sheet.AutoSizeColumnPOI(0)
' </code>
Public Sub AutoSizeColumnPOI(Column As Int)
#If B4A Or B4J
	Try
		Dim MaxLength As Int = 5
		Dim LastRow As Int = nativeSheet.RunMethod("getLastRowNum", Null)
        
		For i = 0 To LastRow
			Dim row As JavaObject = nativeSheet.RunMethod("getRow", Array(i))
			If row.IsInitialized Then
				Dim cell As JavaObject = row.RunMethod("getCell", Array(Column))
				If cell.IsInitialized Then
					Dim cellValue As String = cell.RunMethod("toString", Null)
					MaxLength = Max(MaxLength, cellValue.Length)
				End If
			End If
		Next
        
		nativeSheet.RunMethod("setColumnWidth", Array(Column, (MaxLength + 2) * 256))
	Catch
		Log("❌ Error in AutoSizeColumnPOI: " & LastException)
		nativeSheet.RunMethod("setColumnWidth", Array(Column, 15 * 256))
	End Try
#End If
End Sub

#If B4A Or B4J
' Returns the native POI Sheet JavaObject.
Public Sub SheetJO As JavaObject
	Return nativeSheet
End Sub
#End If

' Helper to convert numeric column index to Excel column letter (e.g. 0 -> "A").
Private Sub ColumnToLetter(col As Int) As String
	Dim result As String = ""
	col = col + 1
	Do While col > 0
		Dim rem As Int = (col - 1) Mod 26
		result = Chr(65 + rem) & result
		col = (col - rem - 1) / 26
	Loop
	Return result
End Sub

' Creates a structured table mapping.
' <code>sheet.CreateTable(0, 10, 0, 5)</code>
Public Sub CreateTable(FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int)
#If B4A Or B4J
	Dim startRef As String = ColumnToLetter(FirstCol) & (FirstRow + 1)
	Dim endRef As String = ColumnToLetter(LastCol) & (LastRow + 1)
	Dim fullRef As String = startRef & ":" & endRef
    
	Dim table As JavaObject = nativeSheet.RunMethod("createTable", Null)
	Dim version As JavaObject = InitializeStaticSafe("org.apache.poi.ss.SpreadsheetVersion")
    
	Dim area As JavaObject = InitializeNewInstanceSafe("org.apache.poi.ss.util.AreaReference", _
        Array(fullRef, version.GetField("EXCEL2007")))
    
	table.RunMethod("setArea", Array(area))
#End If
End Sub

' Creates a styled structured table mapping.
' <code>sheet.CreateTable2(0, 10, 0, 5, "TableStyleMedium2")</code>
Public Sub CreateTable2(FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int, StyleName As String)
#If B4A Or B4J
	Dim startRef As String = ColumnToLetter(FirstCol) & (FirstRow + 1)
	Dim endRef As String = ColumnToLetter(LastCol) & (LastRow + 1)
	Dim fullRef As String = startRef & ":" & endRef

	Dim table As JavaObject = nativeSheet.RunMethod("createTable", Null)
	Dim version As JavaObject = InitializeStaticSafe("org.apache.poi.ss.SpreadsheetVersion")
    
	Dim area As JavaObject = InitializeNewInstanceSafe("org.apache.poi.ss.util.AreaReference", _
        Array(fullRef, version.GetField("EXCEL2007")))
    
	table.RunMethod("setArea", Array(area))
	table.RunMethod("setHeaderRowCount", Array(1))
    
	Dim ctTable As JavaObject = table.RunMethod("getCTTable", Null)
	Dim style As JavaObject = ctTable.RunMethod("addNewTableStyleInfo", Null)
    
	style.RunMethod("setName", Array(StyleName))
	style.RunMethod("setShowRowStripes", Array(True))
	style.RunMethod("setShowColumnStripes", Array(False))
    
	nativeSheet.RunMethod("setAutoFilter", Array(area))
#End If
End Sub

' Unprotects the worksheet.
' <code>sheet.Unprotect</code>
Public Sub Unprotect
#If B4A Or B4J
	nativeSheet.RunMethod("protectSheet", Array(Null))
#End If
End Sub

' Inserts a workbook image at the top-left corner of the specified cell, spanning exactly one cell range.
' <code>sheet.AddPictureToCell(picIdx, 1, 1)</code>
Public Sub AddPictureToCell(PictureIndex As Int, Col As Int, Row As Int)
#If B4A Or B4J
	Try
		Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
		Dim anchor As JavaObject = helper.RunMethod("createClientAnchor", Null)
        
		anchor.RunMethod("setCol1", Array(Col))
		anchor.RunMethod("setRow1", Array(Row))
		anchor.RunMethod("setCol2", Array(Col + 1))
		anchor.RunMethod("setRow2", Array(Row + 1))
        
		Dim anchorTypeEnum As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.ClientAnchor$AnchorType")
		anchor.RunMethod("setAnchorType", Array(anchorTypeEnum.GetField("MOVE_AND_RESIZE")))
        
		Dim drawing As JavaObject = nativeSheet.RunMethod("createDrawingPatriarch", Null)
		drawing.RunMethod("createPicture", Array(anchor, PictureIndex))
	Catch
		Log("❌ Error in AddPictureToCell: " & LastException)
	End Try
#End If
End Sub

' Inserts an image starting at the specified cell (Col, Row) scaled exactly to a custom width and height in pixels.
' <code>sheet.AddPictureExact(picIdx, 1, 1, 200, 100)</code>
Public Sub AddPictureExact(PictureIndex As Int, Col As Int, Row As Int, ScaleX As Double, ScaleY As Double)
#If B4A Or B4J
	Try
		Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
		Dim anchor As JavaObject = helper.RunMethod("createClientAnchor", Null)
        
		anchor.RunMethod("setCol1", Array(Col))
		anchor.RunMethod("setRow1", Array(Row))
        
		' Set anchor type to MOVE_DONT_RESIZE to prevent logo stretching on column auto-sizing
		Try
			Dim anchorTypeClass As String = "org.apache.poi.ss.usermodel.ClientAnchor$AnchorType"
			Dim enumJO As JavaObject = InitializeStaticSafe(anchorTypeClass)
			Dim moveDontResize As JavaObject = enumJO.GetField("MOVE_DONT_RESIZE")
			anchor.RunMethod("setAnchorType", Array(moveDontResize))
		Catch
			Try
				anchor.RunMethod("setAnchorType", Array(2)) ' Fallback to POI 3.x integer constant
			Catch
				Log("⚠️ Could not set anchor type: " & LastException)
			End Try
		End Try
        
		Dim drawing As JavaObject = nativeSheet.RunMethod("createDrawingPatriarch", Null)
		Dim pict As JavaObject = drawing.RunMethod("createPicture", Array(anchor, PictureIndex))
        
		Dim meJO As JavaObject = Me
		meJO.RunMethod("fixResizePicture", Array(pict, ScaleX, ScaleY))
	Catch
		Log("❌ Error in AddPictureExact: " & LastException)
	End Try
#End If
End Sub

' Inserts an image starting at the specified cell (Col, Row) scaled exactly to a custom width and height in pixels.
' This helper automatically loads the image file to calculate the correct scaling factor.
' <code>sheet.AddPictureExact2(picIdx, 1, 1, File.DirAssets, "logo.png", 200, 100)</code>
Public Sub AddPictureExact2(PictureIndex As Int, Col As Int, Row As Int, Dir As String, FileName As String, WidthPixels As Int, HeightPixels As Int)
#If B4A Or B4J
	Try
		Dim bmp As B4XBitmap = xui.LoadBitmap(Dir, FileName)
		Dim scaleX As Double = WidthPixels / bmp.Width
		Dim scaleY As Double = HeightPixels / bmp.Height
		AddPictureExact(PictureIndex, Col, Row, scaleX, scaleY)
	Catch
		Log("❌ Error in AddPictureExact2: " & LastException)
	End Try
#End If
End Sub

' Adds a dropdown select combobox list constraint to a cell range.
' <code>sheet.AddComboBox(Array As String("A", "B", "C"), 1, 20, 1, 1)</code>
Public Sub AddComboBox(Options() As String, FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int)
#If B4A Or B4J
	Try
		Dim helper As JavaObject = nativeSheet.RunMethod("getDataValidationHelper", Null)
		Dim constraint As JavaObject = helper.RunMethod("createExplicitListConstraint", Array(Options))
        
		Dim addressList As JavaObject = InitializeNewInstanceSafe("org.apache.poi.ss.util.CellRangeAddressList", Array(FirstRow, LastRow, FirstCol, LastCol))
        
		Dim validation As JavaObject = helper.RunMethod("createValidation", Array(constraint, addressList))
		validation.RunMethod("setShowErrorBox", Array(True))
		validation.RunMethod("setEmptyCellAllowed", Array(True))
        
		nativeSheet.RunMethod("addValidationData", Array(validation))
	Catch
		Log("❌ Error in Validation: " & LastException)
	End Try
#End If
End Sub

' Activates/switches active worksheet focus by name.
' <code>
'   sheet.SetActiveSheetByName("Summary")
' </code>
Public Sub SetActiveSheetByName(Name As String)
#If B4A Or B4J
	nativeSheet = managerRef.getNativeWorkbook.RunMethod("getSheet", Array(Name))
#End If
End Sub

' Activates/switches active worksheet focus by index.
' <code>
'   sheet.SetActiveSheetByIndex(0)
' </code>
Public Sub SetActiveSheetByIndex(Index As Int)
#If B4A Or B4J
	nativeSheet = managerRef.getNativeWorkbook.RunMethod("getSheetAt", Array(Index))
#End If
End Sub

' Clones an existing sheet by index and names the clone sheet.
' <code>
'   sheet.CloneSheet(0, "Sales_Copy")
' </code>
Public Sub CloneSheet(SourceIndex As Int, NewName As String)
#If B4A Or B4J
	Try
		Dim workbook As JavaObject = managerRef.getNativeWorkbook
		Dim ClonedSheet As JavaObject = workbook.RunMethod("cloneSheet", Array(SourceIndex))
		Dim NewIndex As Int = workbook.RunMethod("getSheetIndex", Array(ClonedSheet))
		workbook.RunMethod("setSheetName", Array(NewIndex, NewName))
		Log("✅ Sheet cloned successfully.")
	Catch
		Log("❌ Error cloning sheet: " & LastException)
	End Try
#End If
End Sub

' Clones an existing sheet by name and names the clone sheet.
' <code>sheet.CloneSheetByName("Sales", "Sales_Copy")</code>
Public Sub CloneSheetByName(ExistingName As String, NewName As String)
#If B4A Or B4J
	Try
		Dim workbook As JavaObject = managerRef.getNativeWorkbook
		Dim SourceIndex As Int = workbook.RunMethod("getSheetIndex", Array(ExistingName))
        
		If SourceIndex = -1 Then
			Log("⚠️ The sheet '" & ExistingName & "' does not exist.")
			Return
		End If
        
		Dim ClonedSheet As JavaObject = workbook.RunMethod("cloneSheet", Array(SourceIndex))
		Dim NewIndex As Int = workbook.RunMethod("getSheetIndex", Array(ClonedSheet))
		workbook.RunMethod("setSheetName", Array(NewIndex, NewName))
        
		Log("✅ Sheet '" & ExistingName & "' cloned as '" & NewName & "'")
	Catch
		Log("❌ Error cloning sheet by name: " & LastException)
	End Try
#End If
End Sub

' Removes a sheet by name.
' <code>
'   sheet.RemoveSheetByName("Old_Data")
' </code>
Public Sub RemoveSheetByName(SheetName As String)
#If B4A Or B4J
	Try
		Dim workbook As JavaObject = managerRef.getNativeWorkbook
		Dim index As Int = workbook.RunMethod("getSheetIndex", Array(SheetName))
        
		If index <> -1 Then
			workbook.RunMethod("removeSheetAt", Array(index))
			Log("🗑️ Sheet '" & SheetName & "' removed.")
		Else
			Log("⚠️ Could not remove: The sheet '" & SheetName & "' does not exist.")
		End If
	Catch
		Log("❌ Error removing sheet: " & LastException)
	End Try
#End If
End Sub

' Copies a sheet structure and content directly into another workbook.
' <code>sheet.CopySheetToNewWorkbook(excelDest, "Exported_Sheet")</code>
Public Sub CopySheetToNewWorkbook(TargetManager As ExcelManager, NewSheetName As String)
#If B4A Or B4J
	Try
		Dim targetSheet As JavaObject = TargetManager.getNativeWorkbook.RunMethod("createSheet", Array(NewSheetName))
		Dim RowCount As Int = nativeSheet.RunMethod("getLastRowNum", Null)
        
		For i = 0 To RowCount
			Dim sourceRow As JavaObject = nativeSheet.RunMethod("getRow", Array(i))
			If sourceRow.IsInitialized Then
				Dim targetRow As JavaObject = targetSheet.RunMethod("createRow", Array(i))
				targetRow.RunMethod("setHeight", Array(sourceRow.RunMethod("getHeight", Null)))
                
				Dim colCount As Int = sourceRow.RunMethod("getLastCellNum", Null)
				For j = 0 To colCount - 1
					Dim sourceCell As JavaObject = sourceRow.RunMethod("getCell", Array(j))
					If sourceCell.IsInitialized Then
						Dim targetCell As JavaObject = targetRow.RunMethod("createCell", Array(j))
						CopyCellContent(sourceCell, targetCell)
					End If
				Next
			End If
		Next
		Log("✅ Sheet copied to another workbook successfully.")
	Catch
		Log("❌ Error copying between workbooks: " & LastException)
	End Try
#End If
End Sub

#If B4A Or B4J
' Helper to copy cell content by type.
Private Sub CopyCellContent(OldCell As JavaObject, NewCell As JavaObject)
	Dim cellType As Int = OldCell.RunMethod("getCellType", Null)
	Select Case cellType
		Case 0 ' NUMERIC
			NewCell.RunMethod("setCellValue", Array(OldCell.RunMethod("getNumericCellValue", Null)))
		Case 1 ' STRING
			NewCell.RunMethod("setCellValue", Array(OldCell.RunMethod("getStringCellValue", Null)))
		Case 4 ' BOOLEAN
			NewCell.RunMethod("setCellValue", Array(OldCell.RunMethod("getBooleanCellValue", Null)))
		Case 2 ' FORMULA
			NewCell.RunMethod("setCellFormula", Array(OldCell.RunMethod("getCellFormula", Null)))
	End Select
End Sub
#End If

' Inserts a workbook image spanning a specific rectangular cell range.
' <code>sheet.AddPictureRange(picIdx, 1, 1, 3, 5)</code>
Public Sub AddPictureRange(PictureIndex As Int, Col1 As Int, Row1 As Int, Col2 As Int, Row2 As Int)
#If B4A Or B4J
	Try
		Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
		Dim anchor As JavaObject = helper.RunMethod("createClientAnchor", Null)
        
		anchor.RunMethod("setCol1", Array(Col1))
		anchor.RunMethod("setRow1", Array(Row1))
		anchor.RunMethod("setCol2", Array(Col2))
		anchor.RunMethod("setRow2", Array(Row2))
        
		Dim anchorTypeEnum As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.ClientAnchor$AnchorType")
		anchor.RunMethod("setAnchorType", Array(anchorTypeEnum.GetField("MOVE_AND_RESIZE")))
        
		Dim drawing As JavaObject = SheetJO.RunMethod("createDrawingPatriarch", Null)
		drawing.RunMethod("createPicture", Array(anchor, PictureIndex))
	Catch
		Log("❌ Critical error in AddPictureRange: " & LastException)
	End Try
#End If
End Sub

' Sets the width of a specific column.
' <code>
'   sheet.SetColumnWidth(0, 4500)
' </code>
Public Sub SetColumnWidth(ColumnIndex As Int, Width As Int)
#If B4A Or B4J
	nativeSheet.RunMethod("setColumnWidth", Array(ColumnIndex, Width))
#End If
End Sub

' Sets visibility of gridlines in the worksheet.
' <code>
'   sheet.SetDisplayGridlines(True)
' </code>
Public Sub SetDisplayGridlines(Visible As Boolean)
#If B4A Or B4J
	SheetJO.RunMethod("setDisplayGridlines", Array(Visible))
#End If
End Sub

' Sets the height of a specific row in points.
' <code>
'   sheet.SetRowHeight(0, 25)
' </code>
Public Sub SetRowHeight(RowIndex As Int, Height As Float)
#If B4A Or B4J
	Dim r As ExcelRow = GetRow(RowIndex)
	r.HeightPoints = Height
#End If
End Sub

' Sets the height of a range of rows at once in points.
' <code>
'   sheet.SetRowsHeight(1, 10, 22.5)
' </code>
Public Sub SetRowsHeight(RowStart As Int, RowEnd As Int, Height As Float)
	For r = RowStart To RowEnd
		SetRowHeight(r, Height)
	Next
End Sub

' Enables or disables word wrapping in a cell range.
' <code>
'   sheet.SetRangeWrapText(1, 10, 0, 5, True)
' </code>
Public Sub SetRangeWrapText(RowStart As Int, RowEnd As Int, ColStart As Int, ColEnd As Int, Enabled As Boolean)
#If B4A Or B4J
	For r = RowStart To RowEnd
		Dim rowObj As ExcelRow = GetRow(r)
		For c = ColStart To ColEnd
			Dim cell As ExcelCell = rowObj.GetCell(c)
			Dim currentStyle As JavaObject = cell.Object.RunMethod("getCellStyle", Null)
			currentStyle.RunMethod("setWrapText", Array(Enabled))
			cell.Object.RunMethod("setCellStyle", Array(currentStyle))
		Next
	Next
#End If
End Sub

#If B4A Or B4J
Private Sub InitializeStaticSafe(ClassName As String) As JavaObject
	Dim jo As JavaObject
	Dim realClassName As String = ClassName
	#If B4A
	Try
		jo.InitializeStatic(ClassName)
	Catch
		realClassName = "poishadow." & ClassName
		jo.InitializeStatic(realClassName)
	End Try
	#Else
	jo.InitializeStatic(ClassName)
	#End If
	Return jo
End Sub

Private Sub InitializeNewInstanceSafe(ClassName As String, Args() As Object) As JavaObject
	Dim jo As JavaObject
	Dim realClassName As String = ClassName
	#If B4A
	Try
		jo.InitializeNewInstance(ClassName, Args)
	Catch
		realClassName = "poishadow." & ClassName
		jo.InitializeNewInstance(realClassName, Args)
	End Try
	#Else
	Return jo.InitializeNewInstance(realClassName, Args)
	#End If
	Return jo
End Sub

#End If

' Exports the active Excel sheet contents to an HTML table string.
' This HTML represents rows, cells, cell text values, alignments, and background colors.
' <code>Dim html As String = sheet.ExportToHTML</code>
Public Sub ExportToHTML As String
#If B4A Or B4J
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<!DOCTYPE html><html><head><meta charset='utf-8'><style>")
	sb.Append("body { font-family: sans-serif; margin: 20px; }")
	sb.Append("table { border-collapse: collapse; width: auto; }")
	sb.Append("td { border: 1px solid #ccc; padding: 6px; min-width: 60px; font-size: 10pt; }")
	sb.Append("</style></head><body><table>")
    
	Try
		Dim firstRow As Int = nativeSheet.RunMethod("getFirstRowNum", Null)
		Dim lastRow As Int = nativeSheet.RunMethod("getLastRowNum", Null)
        
		For r = firstRow To lastRow
			Dim rowJO As JavaObject = nativeSheet.RunMethod("getRow", Array(r))
			If rowJO.IsInitialized = False Then
				sb.Append("<tr></tr>")
				Continue
			End If
            
			sb.Append("<tr>")
			Dim lastCell As Int = rowJO.RunMethod("getLastCellNum", Null)
			For c = 0 To lastCell - 1
				Dim cellJO As JavaObject = rowJO.RunMethod("getCell", Array(c))
				If cellJO.IsInitialized = False Then
					sb.Append("<td></td>")
					Continue
				End If
                
				Dim cellValue As String = ""
				Try
					cellValue = cellJO.RunMethod("toString", Null)
				Catch
				End Try
                
				Dim styleStyle As String = ""
				Dim cellStyle As JavaObject = cellJO.RunMethod("getCellStyle", Null)
				If cellStyle.IsInitialized Then
					Dim fillCol As JavaObject = cellStyle.RunMethod("getFillForegroundColorColor", Null)
					If fillCol.IsInitialized Then
						Dim hex As String = ExtractColorHex(fillCol)
						If hex <> "" Then
							styleStyle = styleStyle & "background-color: #" & hex & ";"
						End If
					End If
                    
					Dim alignObj As JavaObject = cellStyle.RunMethod("getAlignment", Null)
					If alignObj.IsInitialized Then
						Dim alignStr As String = alignObj.RunMethod("name", Null).As(String).ToLowerCase
						styleStyle = styleStyle & "text-align: " & alignStr & ";"
					End If
				End If
                
				sb.Append("<td")
				If styleStyle <> "" Then sb.Append(" style='" & styleStyle & "'")
				sb.Append(">")
				sb.Append(cellValue.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;"))
				sb.Append("</td>")
			Next
			sb.Append("</tr>")
		Next
	Catch
		Log("❌ Error exporting Excel to HTML: " & LastException)
	End Try
    
	sb.Append("</table></body></html>")
	Return sb.ToString
#Else
	Return ""
#End If
End Sub

Private Sub ExtractColorHex(color As JavaObject) As String
	Try
		Dim hex As String = color.RunMethod("getARGBHex", Null)
		If hex <> "null" And hex <> Null And hex <> "" Then
			If hex.Length = 8 Then Return hex.SubString(2) ' Remove alpha
			Return hex
		End If
	Catch
	End Try
	Return ""
End Sub

' Returns the name of this worksheet.
' <code>
'   Dim name As String = sheet.SheetName
' </code>
Public Sub getSheetName As String
#If B4A Or B4J
	Return nativeSheet.RunMethod("getSheetName", Null)
#Else
	Return ""
#End If
End Sub

' Returns the 0-based index of this worksheet inside the workbook.
' <code>
'   Dim idx As Int = sheet.SheetIndex
' </code>
Public Sub getSheetIndex As Int
#If B4A Or B4J
	Return managerRef.getNativeWorkbook.RunMethod("getSheetIndex", Array(nativeSheet))
#Else
	Return -1
#End If
End Sub



#If Java
import java.lang.reflect.Method;

public void fixResizePicture(Object picture, double scaleX, double scaleY) {
    try {
        Method resizeMethod = picture.getClass().getMethod("resize", double.class, double.class);
        resizeMethod.invoke(picture, scaleX, scaleY);
    } catch (Exception e) {
        System.err.println("Error resizing picture: " + e.getMessage());
    }
}
#End If