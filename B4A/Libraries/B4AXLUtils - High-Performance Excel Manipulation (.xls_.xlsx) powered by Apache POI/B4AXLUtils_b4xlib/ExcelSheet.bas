B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
'Class Module: ExcelSheet
Sub Class_Globals
	Private nativeSheet As JavaObject
	Private managerRef As ExcelManager
	Private StylesCache As Map
End Sub

Public Sub Initialize (Manager As ExcelManager, sJavaObj As JavaObject)
	managerRef = Manager
	nativeSheet = sJavaObj
	StylesCache.Initialize
End Sub

' Returns the row resource
Public Sub GetRow(RowIdx As Int) As ExcelRow
	Dim r As JavaObject = nativeSheet.RunMethod("getRow", Array(RowIdx))
	If r.IsInitialized = False Then r = nativeSheet.RunMethod("createRow", Array(RowIdx))
	Dim rowObj As ExcelRow
	rowObj.Initialize(managerRef, Me, r)
	Return rowObj
End Sub


Public Sub ProtectSheet(Password As String)
	nativeSheet.RunMethod("protectSheet", Array(Password))
End Sub

' === SAFE ADJUSTMENT ENGINEERING FOR ANDROID ===



' Finds the index of the last row with data
Public Sub LastRowWithData As Int
	Dim lastRow As Int = nativeSheet.RunMethod("getLastRowNum", Null)
	For i = lastRow To 0 Step -1
		Dim r As JavaObject = nativeSheet.RunMethod("getRow", Array(i))
		If r.IsInitialized Then
			' Pass the Java object directly
			If RowHasData(r) Then Return i
		End If
	Next
	Return -1
End Sub

Private Sub RowHasData(r As JavaObject) As Boolean
	Dim lastCell As Int = r.RunMethod("getLastCellNum", Null)
	For j = 0 To lastCell - 1
		Dim cell As JavaObject = r.RunMethod("getCell", Array(j))
		If cell.IsInitialized Then
			' 🔥 CORRECTION FOR POI 5: Get the enum type name as String
			Dim cellTypeEnum As JavaObject = cell.RunMethod("getCellType", Null)
			Dim typeName As String = cellTypeEnum.RunMethod("name", Null)
            
			' If it's not blank and not an error, there is data
			If typeName <> "BLANK" And typeName <> "ERROR" Then
				' Check that the content is not just whitespace
				If typeName = "STRING" Then
					If cell.RunMethod("getStringCellValue", Null).As(String).Trim <> "" Then Return True
				Else
					Return True ' It's numeric, boolean or formula
				End If
			End If
		End If
	Next
	Return False
End Sub


' <code>Dim uCol As Int = MySheet.LastColumnWithData</code>
Public Sub LastColumnWithData As Int
	Dim lastRowIdx As Int = nativeSheet.RunMethod("getLastRowNum", Null)
	Dim maxColFound As Int = -1
    
	For i = 0 To lastRowIdx
		Dim r As JavaObject = nativeSheet.RunMethod("getRow", Array(i))
		If r.IsInitialized Then
			' Find the ACTUAL last column with content in this section
			Dim lastCellInRow As Int = GetLastCellInRowWithData(r)
			If lastCellInRow > maxColFound Then maxColFound = lastCellInRow
		End If
	Next
    
	Return maxColFound
End Sub

' Helper to ignore cells with formatting but no value (Blank) adapted for POI 5
Private Sub GetLastCellInRowWithData(Row As JavaObject) As Int
	Dim lastCellNum As Int = Row.RunMethod("getLastCellNum", Null)
	If lastCellNum <= 0 Then Return -1
    
	' Search from right to left for the first cell that is not BLANK or ERROR
	For i = lastCellNum - 1 To 0 Step -1
		Dim cell As JavaObject = Row.RunMethod("getCell", Array(i))
		If cell.IsInitialized Then
			' 🔥 POI 5 CORRECTION: Compare the Enum name, not the integer
			Dim cellTypeEnum As JavaObject = cell.RunMethod("getCellType", Null)
			Dim typeName As String = cellTypeEnum.RunMethod("name", Null)
            
			If typeName <> "BLANK" And typeName <> "ERROR" Then
				' If it's text, check that it's not empty after Trim
				If typeName = "STRING" Then
					If cell.RunMethod("getStringCellValue", Null).As(String).Trim <> "" Then Return i
				Else
					Return i
				End If
			End If
		End If
	Next
	Return -1
End Sub

Public Sub getNativeSheet As JavaObject
	Return nativeSheet
End Sub




' === STYLE ENGINE WITH CACHE (THE HEART OF THE MODULE) ===

' === COMPREHENSIVE STYLE ENGINE (THE ONLY ERROR-FREE WAY) ===

' <code>sheet.SetRangeStyle(0, 10, 0, 5, True, True, True, excel.PASTEL_CORAL, False, False, excel.COLOR_RED, "@")</code>
Public Sub SetRangeStyle(F1 As Int, F2 As Int, C1 As Int, C2 As Int, _
                        Bold As Boolean, _
                        Center As Boolean, _
                        Border As Boolean, _
                        ColorBG As Short, _
                        Italic As Boolean, _
                        Underline As Boolean, _
                        TextColor As Short, _
                        TextSize As String)
    
	' Get the style from cache that already combines EVERYTHING
	Dim style As JavaObject = GetCachedStyle(Bold, Center, Border, ColorBG, Italic, Underline, TextColor, TextSize)
    
	For r = F1 To F2
		Dim rowObj As ExcelRow = GetRow(r)
		For c = C1 To C2
			' Apply the complete style object. No property overrides another.
			rowObj.GetCell(c).getObject.RunMethod("setCellStyle", Array(style))
		Next
	Next
End Sub

' Visual resources engine with Intelligent Cache
' Manages Borders, Alignment, Fonts, Colors and Sizes in an optimized way.
Private Sub GetCachedStyle(Bold As Boolean, Center As Boolean, Border As Boolean, ColorBG As Short, _
                          Italic As Boolean, Underline As Boolean, TextColor As Short, _
                          FontSize As Int) As JavaObject
    
	' 1. Generate the resource key.
	' The value -1 (COLOR_NONE) is part of the key to differentiate styles without color.
	Dim key As String = $"B${Bold}_C${Center}_Br${Border}_BG${ColorBG}_I${Italic}_U${Underline}_TC${TextColor}_S${FontSize}"$
    
	' 2. Check if the resource already exists in the cache map
	If StylesCache.ContainsKey(key) Then
		Return StylesCache.Get(key)
	End If
    
	' 3. If it doesn't exist, create a new style in the Workbook
	Dim st As JavaObject = managerRef.getNativeWorkbook.RunMethod("createCellStyle", Null)
    
	' --- PROPERTY: ALIGNMENT ---
	If Center Then
		Dim alignEnum As JavaObject : alignEnum.InitializeStatic("org.apache.poi.ss.usermodel.HorizontalAlignment")
		Dim vAlignEnum As JavaObject : vAlignEnum.InitializeStatic("org.apache.poi.ss.usermodel.VerticalAlignment")
		st.RunMethod("setAlignment", Array(alignEnum.GetField("CENTER")))
		st.RunMethod("setVerticalAlignment", Array(vAlignEnum.GetField("CENTER")))
	End If
	
	' --- PROPERTY: BORDERS ---
	If Border Then
		Dim bEnum As JavaObject : bEnum.InitializeStatic("org.apache.poi.ss.usermodel.BorderStyle")
		Dim thin As Object = bEnum.GetField("THIN")
		st.RunMethod("setBorderTop", Array(thin))
		st.RunMethod("setBorderBottom", Array(thin))
		st.RunMethod("setBorderLeft", Array(thin))
		st.RunMethod("setBorderRight", Array(thin))
	End If
	
	' --- PROPERTY: FONT (Bold, Italic, Size, Color) ---
	Dim font As JavaObject = managerRef.getNativeWorkbook.RunMethod("createFont", Null)
	font.RunMethod("setBold", Array(Bold))
	font.RunMethod("setItalic", Array(Italic))
    
	' Apply size if greater than 0
	If FontSize > 0 Then
		font.RunMethod("setFontHeightInPoints", Array(FontSize.As(Short)))
	End If
    
	' Underline (1 = Standard)
	If Underline Then font.RunMethod("setUnderline", Array(1))
    
	' COLOR_NONE LOGIC: Only applies text color if it's not -1
	If TextColor <> managerRef.COLOR_NONE Then
		font.RunMethod("setColor", Array(TextColor))
	End If
    
	st.RunMethod("setFont", Array(font))
    
	' --- PROPERTY: BACKGROUND ---
	Dim fillEnum As JavaObject : fillEnum.InitializeStatic("org.apache.poi.ss.usermodel.FillPatternType")
	
	' COLOR_NONE LOGIC: If it's -1 or White (9), leave the cell without fill
	If ColorBG <> managerRef.COLOR_NONE And ColorBG <> 9 Then
		st.RunMethod("setFillPattern", Array(fillEnum.GetField("SOLID_FOREGROUND")))
		st.RunMethod("setFillForegroundColor", Array(ColorBG))
	Else
		' Force NO_FILL to make it transparent or respect the sheet background
		st.RunMethod("setFillPattern", Array(fillEnum.GetField("NO_FILL")))
	End If
    
	' 4. Save the final product in the cache and return it
	StylesCache.Put(key, st)
    
	Return st
End Sub
' === ADDITIONAL UTILITIES ===

' Automatic column adjustment (Safe for Android)
Public Sub AutoSizeColumns(StartCol As Int, EndCol As Int)
	Try
		Dim lastRowNum As Int = nativeSheet.RunMethod("getLastRowNum", Null)
		' If the sheet is empty, there's nothing to adjust
		If lastRowNum < 0 Then Return
		
		' Use a Map instead of an Array to avoid size issues
		' and only process the columns we actually need.
		Dim maxLen As Map
		maxLen.Initialize
        
		' Initialize the map with a minimum width (e.g., 8 characters)
		For c = StartCol To EndCol
			maxLen.Put(c, 8)
		Next

		' 1. Scan the sheet to find maximum lengths
		For rowIndex = 0 To lastRowNum
			Dim row As JavaObject = nativeSheet.RunMethod("getRow", Array(rowIndex))
			If row.IsInitialized Then
				For col = StartCol To EndCol
					Dim cell As JavaObject = row.RunMethod("getCell", Array(col))
					If cell.IsInitialized Then
						' toString is safe to get a value representation
						Dim sValue As String = cell.RunMethod("toString", Null)
						Dim currentMax As Int = maxLen.Get(col)
                        
						If sValue.Length > currentMax Then
							maxLen.Put(col, sValue.Length)
						End If
					End If
				Next
			End If
		Next

		' 2. Apply the calculated widths
		For i = StartCol To EndCol
			Dim colWidth As Int = maxLen.Get(i)
            
			' (Characters + margin) * 256 POI units[cite: 1]
			' Use +3 as a balanced margin so it's not too tight
			Dim finalWidth As Int = (colWidth + 3) * 256
            
			' Limit the maximum width to avoid exaggerated columns (optional)
			If finalWidth > 255 * 256 Then finalWidth = 255 * 256
            
			nativeSheet.RunMethod("setColumnWidth", Array(i, finalWidth))
		Next
        
	Catch
		Log("❌ Error in AutoSizeColumns: " & LastException)
	End Try
End Sub


' Applies a data format (currency, date, etc.) respecting the previous visual design
' <code>sheet.SetRangeDataFormat(startRow + 1, lastRow, startCol + i, startCol + i, "$#,##0.00")</code>
Public Sub SetRangeDataFormat(F1 As Int, F2 As Int, C1 As Int, C2 As Int, FormatStr As String)
	If FormatStr = "" Then Return
    
	Dim wb As JavaObject = managerRef.getNativeWorkbook
	Dim dataFormat As JavaObject = wb.RunMethod("createDataFormat", Null)
	Dim formatIdx As Object = dataFormat.RunMethod("getFormat", Array(FormatStr))
    
	For r = F1 To F2
		Dim rowObj As ExcelRow = GetRow(r)
		For c = C1 To C2
			Dim cellJO As JavaObject = rowObj.GetCell(c).getObject
            
			' 1. Retrieve the visual style that the cell already has (borders, colors, etc.)
			Dim currentStyle As JavaObject = cellJO.RunMethod("getCellStyle", Null)
            
			' 2. IMPORTANT: In POI we should not modify the shared style from cache.
			' Create a new style based on the previous one for this specific cell or column.
			' NOTE: If the report is massive, it is recommended to also cache these combinations.
			Dim newStyle As JavaObject = wb.RunMethod("createCellStyle", Null)
			newStyle.RunMethod("cloneStyleFrom", Array(currentStyle))
            
			' 3. Inject only the data format
			newStyle.RunMethod("setDataFormat", Array(formatIdx))
            
			' 4. Apply it back
			cellJO.RunMethod("setCellStyle", Array(newStyle))
		Next
	Next
End Sub



Public Sub AddHyperlink(Row As Int, Col As Int, Address As String, Text As String)
	Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
	Dim link As JavaObject = helper.RunMethod("createHyperlink", Array(1)) ' 1 = URL
    
	link.RunMethod("setAddress", Array(Address))
    
	Dim cell As ExcelCell = GetRow(Row).GetCell(Col)
	cell.setValue(Text)
    
	cell.Object.RunMethod("setHyperlink", Array(link))
End Sub


Public Sub MergeCells(FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int)
	Dim region As JavaObject
	region.InitializeNewInstance("org.apache.poi.ss.util.CellRangeAddress", _
        Array(FirstRow, LastRow, FirstCol, LastCol))
    
	nativeSheet.RunMethod("addMergedRegion", Array(region))
End Sub


Public Sub Freeze(ColSplit As Int, RowSplit As Int)
	nativeSheet.RunMethod("createFreezePane", Array(ColSplit, RowSplit))
End Sub

Public Sub SetAutoFilter(FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int)
	Dim region As JavaObject
	region.InitializeNewInstance("org.apache.poi.ss.util.CellRangeAddress", _
        Array(FirstRow, LastRow, FirstCol, LastCol))
    
	nativeSheet.RunMethod("setAutoFilter", Array(region))
End Sub


Public Sub SetAutoFilter2(Range As String)
	Try
		' 1. Use the CellRangeAddress class to convert the String
		' Use InitializeStatic to access the valueOf method
		Dim craStatic As JavaObject
		craStatic.InitializeStatic("org.apache.poi.ss.util.CellRangeAddress")
        
		' 2. Get the region object from the String (e.g. "A1:B10")
		Dim region As JavaObject = craStatic.RunMethod("valueOf", Array(Range))
        
		' 3. Apply the filter to the native sheet
		nativeSheet.RunMethod("setAutoFilter", Array(region))
	Catch
		Log("❌ Error in SetAutoFilter2 (Range): " & LastException)
		' Tip: Make sure the range is valid, for example "A1:D1"
	End Try
End Sub

Public Sub Protect(Password As String)
	nativeSheet.RunMethod("protectSheet", Array(Password))
End Sub

Public Sub AutoSizeColumnPOI(Column As Int)
	Try
		Dim MaxLength As Int = 5 ' Minimum initial width
        
		' Go through existing rows to find the longest text in that column
		Dim LastRow As Int = nativeSheet.RunMethod("getLastRowNum", Null)
        
		For i = 0 To LastRow
			Dim row As JavaObject = nativeSheet.RunMethod("getRow", Array(i))
			If row.IsInitialized Then
				Dim cell As JavaObject = row.RunMethod("getCell", Array(Column))
				If cell.IsInitialized Then
					' Get the value as String to count characters
					Dim cellValue As String = cell.RunMethod("toString", Null)
					MaxLength = Max(MaxLength, cellValue.Length)
				End If
			End If
		Next
        
		' Apply the width: (characters + margin) * 256 POI units
		' Use setColumnWidth which does NOT depend on AWT and doesn't fail on Android
		nativeSheet.RunMethod("setColumnWidth", Array(Column, (MaxLength + 2) * 256))
        
	Catch
		Log("❌ Error in AutoSizeColumnPOI: " & LastException)
		' If counting fails, set a standard width to not crash the app
		nativeSheet.RunMethod("setColumnWidth", Array(Column, 15 * 256))
	End Try
End Sub

Public Sub SheetJO As JavaObject
	Return nativeSheet
End Sub

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

Public Sub CreateTable(FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int)
    
	Dim startRef As String = ColumnToLetter(FirstCol) & (FirstRow + 1)
	Dim endRef As String = ColumnToLetter(LastCol) & (LastRow + 1)
    
	Dim fullRef As String = startRef & ":" & endRef
    
	Dim table As JavaObject = nativeSheet.RunMethod("createTable", Null)
    
	Dim version As JavaObject
	version.InitializeStatic("org.apache.poi.ss.SpreadsheetVersion")
    
	Dim area As JavaObject
	area.InitializeNewInstance("org.apache.poi.ss.util.AreaReference", _
        Array(fullRef, version.GetField("EXCEL2007")))
    
	table.RunMethod("setArea", Array(area))
End Sub


'<code>sheet.CreateTablePro(0, 20, 0, 4, "TableStyleMedium9")</code>
Public Sub CreateTable2(FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int, StyleName As String)
    
	' 1. Create dynamic A1:D10 style reference
	Dim startRef As String = ColumnToLetter(FirstCol) & (FirstRow + 1)
	Dim endRef As String = ColumnToLetter(LastCol) & (LastRow + 1)
	Dim fullRef As String = startRef & ":" & endRef

	' 2. Create table
	Dim table As JavaObject = nativeSheet.RunMethod("createTable", Null)
    
	' 3. AreaReference
	Dim version As JavaObject
	version.InitializeStatic("org.apache.poi.ss.SpreadsheetVersion")
    
	Dim area As JavaObject
	area.InitializeNewInstance("org.apache.poi.ss.util.AreaReference", _
        Array(fullRef, version.GetField("EXCEL2007")))
    
	table.RunMethod("setArea", Array(area))
    
	' 4. Enable headers
	table.RunMethod("setHeaderRowCount", Array(1))
    
	' 5. Apply style (TableStyle)
	Dim ctTable As JavaObject = table.RunMethod("getCTTable", Null)
	Dim style As JavaObject = ctTable.RunMethod("addNewTableStyleInfo", Null)
    
	style.RunMethod("setName", Array(StyleName)) ' e.g.: TableStyleMedium2
	style.RunMethod("setShowRowStripes", Array(True))
	style.RunMethod("setShowColumnStripes", Array(False))
    
	' 6. AutoFilter (this is KEY)
	nativeSheet.RunMethod("setAutoFilter", Array(area))
    
End Sub


Public Sub Unprotect
	nativeSheet.RunMethod("protectSheet", Array(Null))
End Sub


Public Sub AddPictureToCell(PictureIndex As Int, Col As Int, Row As Int)
	Try
		Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
		Dim anchor As JavaObject = helper.RunMethod("createClientAnchor", Null)
        
		' Define the exact cell area
		anchor.RunMethod("setCol1", Array(Col))
		anchor.RunMethod("setRow1", Array(Row))
		anchor.RunMethod("setCol2", Array(Col + 1)) ' Ends in the next column
		anchor.RunMethod("setRow2", Array(Row + 1)) ' Ends in the next row
        
		' Anchor type so it stretches with the cell
		Dim anchorTypeEnum As JavaObject
		anchorTypeEnum.InitializeStatic("org.apache.poi.ss.usermodel.ClientAnchor$AnchorType")
		anchor.RunMethod("setAnchorType", Array(anchorTypeEnum.GetField("MOVE_AND_RESIZE")))
        
		Dim drawing As JavaObject = nativeSheet.RunMethod("createDrawingPatriarch", Null)
		drawing.RunMethod("createPicture", Array(anchor, PictureIndex))
        
		' NOTE: Don't use pict.resize() here, as the anchor defines the size.
	Catch
		Log("❌ Error in AddPictureToCell: " & LastException)
	End Try
End Sub


Public Sub AddComboBox(Options() As String, FirstRow As Int, LastRow As Int, FirstCol As Int, LastCol As Int)
	Try
		Dim helper As JavaObject = nativeSheet.RunMethod("getDataValidationHelper", Null)
        
		' Create the constraint with the list of options
		Dim constraint As JavaObject = helper.RunMethod("createExplicitListConstraint", Array(Options))
        
		' Define the cell range (CellRangeAddressList)
		Dim addressList As JavaObject
		addressList.InitializeNewInstance("org.apache.poi.ss.util.CellRangeAddressList", Array(FirstRow, LastRow, FirstCol, LastCol))
        
		' Create the validation
		Dim validation As JavaObject = helper.RunMethod("createValidation", Array(constraint, addressList))
        
		' Additional settings
		validation.RunMethod("setShowErrorBox", Array(True))
		validation.RunMethod("setEmptyCellAllowed", Array(True))
        
		' Apply to the sheet[cite: 2]
		nativeSheet.RunMethod("addValidationData", Array(validation))
        
	Catch
		Log("❌ Error in Validation: " & LastException)
	End Try
End Sub


Public Sub SetActiveSheetByName(Name As String)
	nativeSheet = managerRef.getNativeWorkbook.RunMethod("getSheet", Array(Name))
End Sub


Public Sub SetActiveSheetByIndex(Index As Int)
	nativeSheet = managerRef.getNativeWorkbook.RunMethod("getSheetAt", Array(Index))
End Sub

' Clones an existing sheet by its index and gives it a new name
Public Sub CloneSheet(SourceIndex As Int, NewName As String)
	Try
		Dim workbook As JavaObject = managerRef.getNativeWorkbook
		Dim ClonedSheet As JavaObject = workbook.RunMethod("cloneSheet", Array(SourceIndex))
		Dim NewIndex As Int = workbook.RunMethod("getSheetIndex", Array(ClonedSheet))
		workbook.RunMethod("setSheetName", Array(NewIndex, NewName))
		Log("✅ Sheet cloned successfully.")
	Catch
		Log("❌ Error cloning sheet: " & LastException)
	End Try
End Sub


Public Sub CloneSheetByName(ExistingName As String, NewName As String)
	Try
		Dim workbook As JavaObject = managerRef.getNativeWorkbook
        
		' Find the index of the original sheet by its name
		Dim SourceIndex As Int = workbook.RunMethod("getSheetIndex", Array(ExistingName))
        
		If SourceIndex = -1 Then
			Log("⚠️ The sheet '" & ExistingName & "' does not exist.")
			Return
		End If
        
		' Use the native method to clone
		Dim ClonedSheet As JavaObject = workbook.RunMethod("cloneSheet", Array(SourceIndex))
        
		' Get the index of the new cloned sheet to rename it
		Dim NewIndex As Int = workbook.RunMethod("getSheetIndex", Array(ClonedSheet))
		workbook.RunMethod("setSheetName", Array(NewIndex, NewName))
        
		Log("✅ Sheet '" & ExistingName & "' cloned as '" & NewName & "'")
	Catch
		Log("❌ Error cloning sheet by name: " & LastException)
	End Try
End Sub

Public Sub RemoveSheetByName(SheetName As String)
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
End Sub

Public Sub CopySheetToNewWorkbook(TargetManager As ExcelManager, NewSheetName As String)
	Try
		' 1. Create the new sheet in the destination workbook
		Dim targetSheet As JavaObject = TargetManager.getNativeWorkbook.RunMethod("createSheet", Array(NewSheetName))
        
		Dim RowCount As Int = nativeSheet.RunMethod("getLastRowNum", Null)
        
		For i = 0 To RowCount
			Dim sourceRow As JavaObject = nativeSheet.RunMethod("getRow", Array(i))
			If sourceRow.IsInitialized Then
				Dim targetRow As JavaObject = targetSheet.RunMethod("createRow", Array(i))
                
				' Copy row height
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
End Sub

' Helper to copy content (you can expand to copy styles)
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

Public Sub AddPictureRange(PictureIndex As Int, Col1 As Int, Row1 As Int, Col2 As Int, Row2 As Int)
	Try
		Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
		Dim anchor As JavaObject = helper.RunMethod("createClientAnchor", Null)
        
		' Assign coordinates
		anchor.RunMethod("setCol1", Array(Col1))
		anchor.RunMethod("setRow1", Array(Row1))
		anchor.RunMethod("setCol2", Array(Col2))
		anchor.RunMethod("setRow2", Array(Row2))
        
		' --- CORRECTION FOR POI 5.x ---
		' Instead of passing a 0, pass the MOVE_AND_RESIZE Enum object
		Dim anchorTypeEnum As JavaObject
		anchorTypeEnum.InitializeStatic("org.apache.poi.ss.usermodel.ClientAnchor$AnchorType")
        
		' Use MOVE_AND_RESIZE (which is equivalent to the old 0)
		anchor.RunMethod("setAnchorType", Array(anchorTypeEnum.GetField("MOVE_AND_RESIZE")))
        
		' Create the drawing resource and the image
		Dim drawing As JavaObject = SheetJO.RunMethod("createDrawingPatriarch", Null)
		drawing.RunMethod("createPicture", Array(anchor, PictureIndex))
        
	Catch
		Log("❌ Critical error in AddPictureRange: " & LastException)
	End Try
End Sub
' <code>sheet.SetColumnWidth(3, 5000)</code>
Public Sub SetColumnWidth(ColumnIndex As Int, Width As Int)
	nativeSheet.RunMethod("setColumnWidth", Array(ColumnIndex, Width))
End Sub

' Shows or hides the gridlines
Public Sub SetDisplayGridlines(Visible As Boolean)
	SheetJO.RunMethod("setDisplayGridlines", Array(Visible))
End Sub

' Changes the height of a specific row (e.g., so the title has breathing room)
' <code>sheet.SetRowHeight(0, 50)</code>
Public Sub SetRowHeight(RowIndex As Int, Height As Float)
	Dim r As ExcelRow = GetRow(RowIndex)
	' POI uses units of 1/20 point, B4A uses points. Multiply by 20.
	r.HeightPoints = Height
End Sub

' Changes the height of a range of rows at once
Public Sub SetRowsHeight(RowStart As Int, RowEnd As Int, Height As Float)
	For r = RowStart To RowEnd
		SetRowHeight(r, Height)
	Next
End Sub

' Activates text wrapping in a range. 
' Crucial so long texts don't get cut off in Android.
Public Sub SetRangeWrapText(RowStart As Int, RowEnd As Int, ColStart As Int, ColEnd As Int, Enabled As Boolean)
	For r = RowStart To RowEnd
		Dim rowObj As ExcelRow = GetRow(r)
		For c = ColStart To ColEnd
			Dim cell As ExcelCell = rowObj.GetCell(c)
			Dim currentStyle As JavaObject = cell.Object.RunMethod("getCellStyle", Null)
			
			' Clone or modify the style to enable wrapping
			currentStyle.RunMethod("setWrapText", Array(Enabled))
			cell.Object.RunMethod("setCellStyle", Array(currentStyle))
		Next
	Next
End Sub