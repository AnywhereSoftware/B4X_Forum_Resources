B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' Class Module: ExcelManager
Sub Class_Globals
#If B4A Or B4J
	Private nativeWorkbook As JavaObject
	Private styleCache As Map
#End If
	Private mEventName As String
	Private mCallBack As Object
	
	Public Const COLOR_WHITE As Short = 9
	Public Const COLOR_BLACK As Short = 8
	Public Const COLOR_RED As Short = 10
	Public Const COLOR_BLUE As Short = 12
	Public Const COLOR_YELLOW As Short = 13
	Public Const COLOR_GREEN As Short = 11
    
	' Grey Tones (Ideal for borders or subtle backgrounds)
	Public Const COLOR_GREY_25 As Short = 22
	Public Const COLOR_GREY_40 As Short = 52
	Public Const COLOR_GREY_50 As Short = 23
    
	' Pastel Tones (Recommended for table highlighting)
	Public Const PASTEL_AQUA As Short = 49      ' Soft Turquoise
	Public Const PASTEL_LAVENDER As Short = 46  ' Lavender / Soft Purple
	Public Const PASTEL_BLUE As Short = 44      ' Sky blue
	Public Const PASTEL_GREEN As Short = 42     ' Mint green
	Public Const PASTEL_YELLOW As Short = 43    ' Cream yellow
	Public Const PASTEL_ORANGE As Short = 51    ' Soft orange
	Public Const PASTEL_CORAL As Short = 53     ' Coral / Pink
    
	' Corporate Colors (Darker tones for text or strong headers)
	Public Const CORP_NAVY As Short = 18        ' Navy Blue
	Public Const CORP_TEAL As Short = 21        ' Teal
	Public Const CORP_OLIVE As Short = 19       ' Olive
	
	Public Const COLOR_NONE As Short = -1
	
	Public Const PICTURE_TYPE_PNG As Int = 6
	Public Const PICTURE_TYPE_JPEG As Int = 5
	
	' === CELL TYPES ===
	' These values correspond to the .ordinal of the Apache POI CellType Enum
	Public Const TYPE_NUMERIC As Int = 0
	Public Const TYPE_STRING As Int = 1
	Public Const TYPE_FORMULA As Int = 2
	Public Const TYPE_BLANK As Int = 3
	Public Const TYPE_BOOLEAN As Int = 4
	Public Const TYPE_ERROR As Int = 5

	' Custom types (Internal logic of this class)
	Public Const TYPE_CURRENCY As Int = 10
	Public Const TYPE_DATE As Int = 11
	Public Const TYPE_PERCENTAGE As Int = 12
	
	' === ISO CURRENCY CODES ===
	Public Const ISO_USD As String = "USD"
	Public Const ISO_EUR As String = "EUR"
	Public Const ISO_MXN As String = "MXN"
	Public Const ISO_PEN As String = "PEN"
	Public Const ISO_COP As String = "COP"
	Public Const ISO_ARS As String = "ARS"
	Public Const ISO_CLP As String = "CLP"
	Public Const ISO_GBP As String = "GBP"
	Public Const ISO_JPY As String = "JPY"
	Dim xui As XUI
End Sub

#Event: SaveCompleted(Success As Boolean)

' Initializes the manager instance.
' <code>excel.Initialize(Me, "excel")</code>
Public Sub Initialize (CallBack As Object, EventName As String)
	mCallBack = CallBack
	mEventName = EventName
#If B4A Or B4J
	styleCache.Initialize
	RegisterOOXML
#End If
End Sub

' Creates a new, blank workbook.
' <code>excel.CreateWorkbook</code>
Public Sub CreateWorkbook
#If B4A Or B4J
	nativeWorkbook = InitializeNewInstanceSafe("org.apache.poi.xssf.usermodel.XSSFWorkbook", Null)
#End If
End Sub

' Manually registers the OOXML provider to prevent loading failures with newer POI formats on Android.
Private Sub RegisterOOXML
#If B4A Or B4J
	Try
		Dim jo As JavaObject = InitializeStaticSafe("org.apache.poi.xssf.usermodel.XSSFWorkbookFactory")
		Log("✅ OOXML Provider registered manually")
	Catch
		Log("⚠️ Could not register XSSF manually: " & LastException.Message)
	End Try
#End If
End Sub

' Opens an existing Excel workbook (.xls or .xlsx formats).
' <code>Dim xl As ExcelManager = excel.ReadWorkbook(File.DirInternal, "data.xlsx")</code>
Public Sub ReadWorkbook(Directory As String, FileName As String) As ExcelManager
#If B4A Or B4J
	Try
		Dim fis As JavaObject
		fis.InitializeNewInstance("java.io.FileInputStream", Array(File.Combine(Directory, FileName)))
        
		Dim extension As String = FileName.ToLowerCase
        
		If extension.EndsWith(".xls") Then
			' HSSF Workbook format (.xls)
			nativeWorkbook = InitializeNewInstanceSafe("org.apache.poi.hssf.usermodel.HSSFWorkbook", Array(fis))
			Log("📂 Loaded as legacy format (.xls)")
		Else If extension.EndsWith(".xlsx") Then
			' XSSF Workbook format (.xlsx)
			nativeWorkbook = InitializeNewInstanceSafe("org.apache.poi.xssf.usermodel.XSSFWorkbook", Array(fis))
			Log("📂 Loaded as modern format (.xlsx)")
		End If
        
		fis.RunMethod("close", Null)
	Catch
		Log("❌ Error reading workbook: " & LastException.Message)
		' Fallback initialization to avoid null pointers
		nativeWorkbook = InitializeNewInstanceSafe("org.apache.poi.xssf.usermodel.XSSFWorkbook", Null)
	End Try
#End If
	Return Me
End Sub

' Performs a workbook-wide find and replace operation on all text cells.
' <code>excel.SearchAndReplace("{DATE}", "2026-07-16").Save(File.DirInternal, "updated.xlsx")</code>
Public Sub SearchAndReplace(SearchText As String, ReplaceText As String) As ExcelManager
#If B4A Or B4J
	Try
		If nativeWorkbook.IsInitialized = False Then
			Log("❌ Resource not initialized")
			Return Me
		End If

		Dim numSheets As Int = nativeWorkbook.RunMethod("getNumberOfSheets", Null)
        
		For i = 0 To numSheets - 1
			' Access each sheet of the workbook
			Dim sheet As JavaObject = nativeWorkbook.RunMethod("getSheetAt", Array(i))
            
			Dim rowIter As JavaObject = sheet.RunMethod("rowIterator", Null)
			Do While rowIter.RunMethod("hasNext", Null)
				Dim row As JavaObject = rowIter.RunMethod("next", Null)
                
				Dim cellIter As JavaObject = row.RunMethod("cellIterator", Null)
				Do While cellIter.RunMethod("hasNext", Null)
					Dim cell As JavaObject = cellIter.RunMethod("next", Null)
                    
					' Get the cell type safely as String
					Dim cellTypeEnum As JavaObject = cell.RunMethod("getCellType", Null)
					Dim typeName As String = cellTypeEnum.RunMethod("name", Null)
                    
					' Only check text cells
					If typeName = "STRING" Then
						Dim value As String = cell.RunMethod("getStringCellValue", Null)
						If value <> Null And value.Contains(SearchText) Then
							cell.RunMethod("setCellValue", Array(value.Replace(SearchText, ReplaceText)))
						End If
					End If
				Loop
			Loop
		Next
        
		Log("✅ Replacement in sheets completed")
	Catch
		Log("❌ Error in SearchAndReplace: " & LastException)
	End Try
#End If
	Return Me
End Sub

' Creates a new sheet in the workbook.
' <code>Dim sheet As ExcelSheet = excel.CreateSheet("Sales")</code>
Public Sub CreateSheet(Name As String) As ExcelSheet
	Dim sheetObj As ExcelSheet
#If B4A Or B4J
	Dim s As JavaObject = nativeWorkbook.RunMethod("createSheet", Array(Name))
	sheetObj.Initialize(Me, s)
#End If
	Return sheetObj
End Sub

' Retrieves an existing sheet by name, or creates a new one if it does not exist.
' <code>Dim sheet As ExcelSheet = excel.GetSheet("Data")</code>
Public Sub GetSheet(Name As String) As ExcelSheet
	Dim sheetObj As ExcelSheet
#If B4A Or B4J
	Dim s As JavaObject = nativeWorkbook.RunMethod("getSheet", Array(Name))
	If s.IsInitialized = False Then s = nativeWorkbook.RunMethod("createSheet", Array(Name))
	sheetObj.Initialize(Me, s)
#End If
	Return sheetObj
End Sub

' Saves the workbook to the specified location.
' <code>excel.Save(File.DirInternal, "report.xlsx")</code>
Public Sub Save(Directory As String, FileName As String)
#If B4A Or B4J
	Try
		Dim out As OutputStream = File.OpenOutput(Directory, FileName, False)
		nativeWorkbook.RunMethod("write", Array(out))
		out.Close
		RaiseSaveEvent(True)
	Catch
		Log("❌ Error saving workbook: " & LastException)
		RaiseSaveEvent(False)
	End Try
#End If
End Sub

Private Sub RaiseSaveEvent(Success As Boolean)
	If xui.SubExists(mCallBack, mEventName & "_SaveCompleted",1) Then
		CallSubDelayed2(mCallBack, mEventName & "_SaveCompleted", Success)
	End If
End Sub

#If B4A Or B4J
' Returns the native workbook JavaObject instance.
Public Sub getNativeWorkbook As JavaObject
	Return nativeWorkbook
End Sub
#End If

' Exports an SQL ResultSet directly to a sheet.
' <code>excel.TableToExcel(SQL1.ExecQuery("SELECT * FROM users"), "Users_Report")</code>
Public Sub TableToExcel(SQLResultSet As Object, SheetName As String)
#If B4A Or B4J
	Try
		Dim joRs As JavaObject = SQLResultSet
		Dim sheet As ExcelSheet = GetSheet(SheetName)
		Dim colCount As Int = joRs.RunMethod("getColumnCount", Null)
		
		' 1. Create Headers (Row 0)
		Dim headerRow As ExcelRow = sheet.GetRow(0)
		For i = 0 To colCount - 1
			Dim cell As ExcelCell = headerRow.GetCell(i)
			Dim colName As String = joRs.RunMethod("getColumnName", Array(i))
			cell.setValue(colName)
			cell.SetBold(True)
			cell.SetBorders
		Next
		
		' 2. Fill Data Rows
		Dim rowIdx As Int = 1
		Do While joRs.RunMethod("NextRow", Null)
			Dim dataRow As ExcelRow = sheet.GetRow(rowIdx)
			For i = 0 To colCount - 1
				Dim dataCell As ExcelCell = dataRow.GetCell(i)
				Dim val As Object = joRs.RunMethod("GetString2", Array(i))
				If val = Null Then val = ""
				dataCell.setValue(val)
				dataCell.SetBorders
			Next
			rowIdx = rowIdx + 1
		Loop
		joRs.RunMethod("Close", Null)
		
		' 3. Adjust columns sizes to content
		sheet.AutoSizeColumns(0, colCount - 1)
		Log("SQL transformation completed: " & (rowIdx - 1) & " rows processed.")
	Catch
		Log("Error in TableToExcel: " & LastException.Message)
	End Try
#End If
End Sub

' Exports an SQL ResultSet to a sheet, adding an auto-incremented Item number column.
' <code>excel.TableToExcelWithItem(SQL1.ExecQuery("SELECT * FROM tasks"), "Tasks_Report")</code>
Public Sub TableToExcelWithItem(SQLResultSet As Object, SheetName As String)
#If B4A Or B4J
	Try
		Dim joRs As JavaObject = SQLResultSet
		Dim sheet As ExcelSheet = GetSheet(SheetName)
		Dim colCount As Int = joRs.RunMethod("getColumnCount", Null)
		Dim offset As Int = 1 ' Offset columns to make room for the ITEM column
        
		Dim headerRow As ExcelRow = sheet.GetRow(0)
        
		' 1. Write the auto-increment header
		Dim cellItem As ExcelCell = headerRow.GetCell(0)
		cellItem.setValue("ITEM")
		cellItem.SetBold(True)
		cellItem.SetBorders
        
		' 2. Write the SQL column headers
		For i = 0 To colCount - 1
			Dim cell As ExcelCell = headerRow.GetCell(i + offset)
			Dim colName As String = joRs.RunMethod("getColumnName", Array(i))
			cell.setValue(colName.ToUpperCase)
			cell.SetBold(True)
			cell.SetBorders
		Next
        
		' 3. Fill data and numbering rows
		Dim rowIdx As Int = 1
		Do While joRs.RunMethod("NextRow", Null)
			Dim dataRow As ExcelRow = sheet.GetRow(rowIdx)
            
			' Item number cell
			Dim cItem As ExcelCell = dataRow.GetCell(0)
			cItem.setValue(rowIdx)
			cItem.SetBorders
			
			' Data cells
			For i = 0 To colCount - 1
				Dim dataCell As ExcelCell = dataRow.GetCell(i + offset)
				dataCell.setValue(joRs.RunMethod("GetString2", Array(i)))
				dataCell.SetBorders
			Next
			rowIdx = rowIdx + 1
		Loop
		joRs.RunMethod("Close", Null)
		sheet.AutoSizeColumns(0, colCount + offset - 1)
	Catch
		Log("Error: " & LastException.Message)
	End Try
#End If
End Sub


' Forces re-evaluation of all formulas in the workbook.
' <code>excel.EvaluateAllFormulas</code>
Public Sub EvaluateAllFormulas
#If B4A Or B4J
	Dim evaluator As JavaObject = nativeWorkbook.RunMethodjo("getCreationHelper", Null).RunMethod("createFormulaEvaluator", Null)
	evaluator.RunMethod("evaluateAll", Null)
#End If
End Sub

' Retrieves an existing sheet by index.
' <code>Dim sheet As ExcelSheet = excel.GetSheetAt(0)</code>
Public Sub GetSheetAt(Index As Int) As ExcelSheet
	Dim sheetObj As ExcelSheet
#If B4A Or B4J
	Dim s As JavaObject = nativeWorkbook.RunMethod("getSheetAt", Array(Index))
	sheetObj.Initialize(Me, s)
#End If
	Return sheetObj
End Sub

' Returns the number of sheets in the workbook.
' <code>Dim count As Int = excel.GetSheetCount</code>
Public Sub GetSheetCount As Int
#If B4A Or B4J
	Return nativeWorkbook.RunMethod("getNumberOfSheets", Null)
#Else
	Return 0
#End If
End Sub

' Removes a sheet by index.
' <code>excel.RemoveSheet(0)</code>
Public Sub RemoveSheet(Index As Int)
#If B4A Or B4J
	nativeWorkbook.RunMethod("removeSheetAt", Array(Index))
#End If
End Sub

' Renames a sheet by index.
' <code>excel.RenameSheet(0, "Q1_Report")</code>
Public Sub RenameSheet(Index As Int, NewName As String)
#If B4A Or B4J
	nativeWorkbook.RunMethod("setSheetName", Array(Index, NewName))
#End If
End Sub

' Sets the active sheet index.
' <code>excel.SetActiveSheet(0)</code>
Public Sub SetActiveSheet(Index As Int)
#If B4A Or B4J
	nativeWorkbook.SetField("ActiveSheet", Index)
#End If
End Sub

' Enables or disables formula auto-recalculation when opening the workbook.
' <code>excel.ForceRecalculation(True)</code>
Public Sub ForceRecalculation(Enabled As Boolean)
#If B4A Or B4J
	nativeWorkbook.SetField("ForceFormulaRecalculation", Enabled)
#End If
End Sub

' Adds a picture to the workbook's internal image store and returns its picture index.
' <code>Dim picIdx As Int = excel.AddPicture(File.DirAssets, "logo.png", excel.PICTURE_TYPE_PNG)</code>
Public Sub AddPicture(FileDir As String, FileName As String, Format As Int) As Int
#If B4A Or B4J
	Dim bytes() As Byte = File.ReadBytes(FileDir, FileName)
	Return nativeWorkbook.RunMethod("addPicture", Array(bytes, Format))
#Else
	Return -1
#End If
End Sub

' Creates a named formula range.
' <code>excel.CreateNamedRange("TaxRate", "Sheet1!$H$1")</code>
Public Sub CreateNamedRange(Name As String, Ref As String)
#If B4A Or B4J
	Dim nm As JavaObject = nativeWorkbook.RunMethod("createName", Null)
	nm.RunMethod("setNameName", Array(Name))
	nm.RunMethod("setRefersToFormula", Array(Ref))
#End If
End Sub

' Sets the printable print area for a sheet.
' <code>excel.SetPrintArea(0, 0, 5, 0, 20)</code>
Public Sub SetPrintArea(SheetIndex As Int, StartCol As Int, EndCol As Int, StartRow As Int, EndRow As Int)
#If B4A Or B4J
	nativeWorkbook.RunMethod("setPrintArea", Array(SheetIndex, StartCol, EndCol, StartRow, EndRow))
#End If
End Sub

' Sets repeating rows at top of the printed sheets.
' <code>excel.SetRepeatingRows(0, 0, 2)</code>
Public Sub SetRepeatingRows(SheetIndex As Int, StartRow As Int, EndRow As Int)
#If B4A Or B4J
	nativeWorkbook.RunMethod("setRepeatingRowsAndColumns", _
        Array(SheetIndex, -1, -1, StartRow, EndRow))
#End If
End Sub

' Locks the workbook structure to prevent worksheets from being moved or deleted.
' <code>excel.LockStructure</code>
Public Sub LockStructure
#If B4A Or B4J
	nativeWorkbook.RunMethod("lockStructure", Null)
#End If
End Sub

' Unlocks the workbook structure.
' <code>excel.UnlockStructure</code>
Public Sub UnlockStructure
#If B4A Or B4J
	nativeWorkbook.RunMethod("unLockStructure", Null)
#End If
End Sub

' Returns the name of a sheet by index.
' <code>Dim name As String = excel.GetSheetName(0)</code>
Public Sub GetSheetName(Index As Int) As String
#If B4A Or B4J
	Return nativeWorkbook.RunMethod("getSheetName", Array(Index))
#Else
	Return ""
#End If
End Sub

' Closes the workbook and frees native resources.
' <code>excel.Close</code>
Public Sub Close
#If B4A Or B4J
	nativeWorkbook.RunMethod("close", Null)
#End If
End Sub

#If B4A Or B4J
' Returns the native workbook Object.
Public Sub getObject As JavaObject
	Return nativeWorkbook
End Sub
#End If

' Locks the workbook structure to prevent worksheets from being moved or deleted.
' <code>
'   excel.LockWorkbookStructure
' </code>
Public Sub LockWorkbookStructure
#If B4A Or B4J
	nativeWorkbook.RunMethod("lockStructure", Null)
#End If
End Sub

' Unlocks the workbook structure.
' <code>
'   excel.UnlockWorkbookStructure
' </code>
Public Sub UnlockWorkbookStructure
#If B4A Or B4J
	nativeWorkbook.RunMethod("unLockStructure", Null)
#End If
End Sub

#If B4A Or B4J
' Retrieves an existing CellStyle from cache, or creates one if it doesn't exist.
Public Sub GetStyle(Key As String) As JavaObject
	If styleCache.ContainsKey(Key) Then
		Return styleCache.Get(Key)
	End If
    
	Dim style As JavaObject = nativeWorkbook.RunMethod("createCellStyle", Null)
	styleCache.Put(Key, style)
    
	Return style
End Sub

' Clones a base CellStyle and caches the result with a specific key.
' Useful for building compound styles: "BORDER_BG_CORAL"
Public Sub GetCombinedStyle(BaseStyle As JavaObject, PropertyKey As String) As JavaObject
	Dim finalKey As String = PropertyKey
    
	If styleCache.ContainsKey(finalKey) Then
		Return styleCache.Get(finalKey)
	End If
    
	Dim newStyle As JavaObject = nativeWorkbook.RunMethod("createCellStyle", Null)
	newStyle.RunMethod("cloneStyleFrom", Array(BaseStyle))
    
	styleCache.Put(finalKey, newStyle)
	Return newStyle
End Sub

' --- UNIFIED CACHE ENGINE ---

' Extracts style and font properties from an existing CellStyle, overrides a single property, and returns a unified cached CellStyle.
Public Sub GetModifiedStyle(CurrentStyle As JavaObject, PropertyName As String, Value As Object) As JavaObject
	Dim Bold As Boolean = False
	Dim Italic As Boolean = False
	Dim Underline As Boolean = False
	Dim FontSize As Int = 0
	Dim TextColor As Short = COLOR_NONE
	Dim Border As Boolean = False
	Dim Center As Boolean = False
	Dim ColorBG As Short = COLOR_NONE
	Dim DataFormat As Short = 0
	
	If CurrentStyle.IsInitialized And CurrentStyle <> Null Then
		' Extract alignment properties
		Try
			Dim alignJO As JavaObject = CurrentStyle.RunMethod("getAlignment", Null)
			If alignJO.IsInitialized And alignJO <> Null Then
				Dim align As String = alignJO.RunMethod("name", Null)
				If align = "CENTER" Then Center = True
			End If
		Catch
			' Handled silently - defaults to False/General alignment
		End Try
		
		' Extract border properties
		Try
			Dim borderTopJO As JavaObject = CurrentStyle.RunMethod("getBorderTop", Null)
			If borderTopJO.IsInitialized And borderTopJO <> Null Then
				Dim borderTop As String = borderTopJO.RunMethod("name", Null)
				If borderTop <> "NONE" Then Border = True
			End If
		Catch
			' Handled silently - defaults to False/No border
		End Try
		
		' Extract background fill properties
		Try
			Dim fillPatternJO As JavaObject = CurrentStyle.RunMethod("getFillPattern", Null)
			If fillPatternJO.IsInitialized And fillPatternJO <> Null Then
				Dim fillPattern As String = fillPatternJO.RunMethod("name", Null)
				If fillPattern <> "NO_FILL" Then
					ColorBG = CurrentStyle.RunMethod("getFillForegroundColor", Null)
				End If
			End If
		Catch
			' Handled silently - defaults to COLOR_NONE
		End Try
		
		' Extract data format index
		Try
			DataFormat = CurrentStyle.RunMethod("getDataFormat", Null)
		Catch
			' Handled silently - defaults to 0
		End Try
		
		' Extract font properties
		Try
			Dim fontIdx As Int = CurrentStyle.RunMethod("getFontIndex", Null)
			Dim font As JavaObject = nativeWorkbook.RunMethod("getFontAt", Array(fontIdx))
			If font.IsInitialized And font <> Null Then
				Bold = font.RunMethod("getBold", Null)
				Italic = font.RunMethod("getItalic", Null)
				FontSize = font.RunMethod("getFontHeightInPoints", Null)
				Dim uline As Int = font.RunMethod("getUnderline", Null)
				If uline > 0 Then Underline = True
				TextColor = font.RunMethod("getColor", Null)
			End If
		Catch
			' Handled silently - defaults to default font properties
		End Try
	End If
	
	' Apply the override to the corresponding property
	Select PropertyName.ToUpperCase
		Case "BOLD"
			Bold = Value
		Case "ITALIC"
			Italic = Value
		Case "UNDERLINE"
			Underline = Value
		Case "FONTSIZE"
			FontSize = Value
		Case "TEXTCOLOR"
			TextColor = Value
		Case "BORDER"
			Border = Value
		Case "CENTER"
			Center = Value
		Case "COLORBG"
			ColorBG = Value
		Case "DATAFORMAT"
			DataFormat = Value
	End Select
	
	Return GetCachedStyleInternal(Bold, Center, Border, ColorBG, Italic, Underline, TextColor, FontSize, DataFormat)
End Sub

' Directly resolves/creates CellStyles and Fonts inside styleCache.
Public Sub GetCachedStyleInternal(Bold1 As Boolean, Center1 As Boolean, Border1 As Boolean, ColorBG1 As Short, _
                           Italic1 As Boolean, Underline1 As Boolean, TextColor1 As Short, _
                           FontSize1 As Int, DataFormat1 As Short) As JavaObject
    
	Dim key As String = $"B${Bold1}_C${Center1}_Br${Border1}_BG${ColorBG1}_I${Italic1}_U${Underline1}_TC${TextColor1}_S${FontSize1}_DF${DataFormat1}"$
    
	If styleCache.ContainsKey(key) Then
		Return styleCache.Get(key)
	End If
    
	Dim st As JavaObject = nativeWorkbook.RunMethod("createCellStyle", Null)
    
	' --- PROPERTY: ALIGNMENT ---
	If Center1 Then
		Dim alignEnum As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.HorizontalAlignment")
		Dim vAlignEnum As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.VerticalAlignment")
		st.RunMethod("setAlignment", Array(alignEnum.GetField("CENTER")))
		st.RunMethod("setVerticalAlignment", Array(vAlignEnum.GetField("CENTER")))
	End If
	
	' --- PROPERTY: BORDERS ---
	If Border1 Then
		Dim bEnum As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.BorderStyle")
		Dim thin As Object = bEnum.GetField("THIN")
		st.RunMethod("setBorderTop", Array(thin))
		st.RunMethod("setBorderBottom", Array(thin))
		st.RunMethod("setBorderLeft", Array(thin))
		st.RunMethod("setBorderRight", Array(thin))
	End If
	
	' --- PROPERTY: FONT (Bold, Italic, Size, Color) ---
	Dim fontKey As String = $"F_${Bold1}_${Italic1}_${Underline1}_${TextColor1}_${FontSize1}"$
	Dim font As JavaObject
	If styleCache.ContainsKey(fontKey) Then
		font = styleCache.Get(fontKey)
	Else
		font = nativeWorkbook.RunMethod("createFont", Null)
		font.RunMethod("setBold", Array(Bold1))
		font.RunMethod("setItalic", Array(Italic1))
		If FontSize1 > 0 Then
			font.RunMethod("setFontHeightInPoints", Array(FontSize1.As(Short)))
		End If
		If Underline1 Then font.RunMethod("setUnderline", Array(1))
		If TextColor1 <> COLOR_NONE Then
			font.RunMethod("setColor", Array(TextColor1))
		End If
		styleCache.Put(fontKey, font)
	End If
    
	st.RunMethod("setFont", Array(font))
    
	' --- PROPERTY: BACKGROUND ---
	Dim fillEnum As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.FillPatternType")
	
	If ColorBG1 <> COLOR_NONE And ColorBG1 <> 9 Then
		st.RunMethod("setFillPattern", Array(fillEnum.GetField("SOLID_FOREGROUND")))
		st.RunMethod("setFillForegroundColor", Array(ColorBG1))
	Else
		st.RunMethod("setFillPattern", Array(fillEnum.GetField("NO_FILL")))
	End If
    
	' --- PROPERTY: DATAFORMAT ---
	If DataFormat1 > 0 Then
		st.RunMethod("setDataFormat", Array(DataFormat1))
	End If
	
	styleCache.Put(key, st)
	Return st
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
	jo.InitializeNewInstance(ClassName, Args)
	#End If
	Return jo
End Sub

' Returns the index of the currently active worksheet.
' <code>
'   Dim activeIdx As Int = excel.GetActiveSheetIndex
' </code>
Public Sub GetActiveSheetIndex As Int
#If B4A Or B4J
	Return nativeWorkbook.RunMethod("getActiveSheetIndex", Null)
#Else
	Return -1
#End If
End Sub

' Returns the name of the currently active worksheet.
' <code>
'   Dim activeName As String = excel.GetActiveSheetName
' </code>
Public Sub GetActiveSheetName As String
#If B4A Or B4J
	Dim idx As Int = GetActiveSheetIndex
	If idx >= 0 And idx < GetSheetCount Then
		Return GetSheetName(idx)
	End If
#End If
	Return ""
End Sub
#End If
#End If