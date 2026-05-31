B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' Class Module: ExcelManager
Sub Class_Globals
	Private nativeWorkbook As JavaObject
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
	' In ExcelManager
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

	' Custom types (Internal logic of your class)
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
	
	Private styleCache As Map
	


End Sub

#Event: SaveCompleted(Success As Boolean)

Public Sub Initialize (CallBack As Object, EventName As String)
	mCallBack = CallBack
	mEventName = EventName
	styleCache.Initialize
	RegisterOOXML
End Sub

Public Sub CreateWorkbook
	nativeWorkbook.InitializeNewInstance("org.apache.poi.xssf.usermodel.XSSFWorkbook", Null)
End Sub

' Call this in the Initialize of your ExcelManager class
Private Sub RegisterOOXML
	Try
		Dim jo As JavaObject
		' Force loading the class that handles .xlsx
		jo.InitializeStatic("org.apache.poi.xssf.usermodel.XSSFWorkbookFactory")
		Log("✅ OOXML Provider registered manually")
	Catch
		Log("⚠️ Could not register XSSF manually: " & LastException.Message)
	End Try
End Sub

' Opens an existing Excel file (.xls or .xlsx)
' <code>Dim xl As ExcelManager = mExcel.LoadWorkbook(File.DirInternal, "data.xlsx")</code>
Public Sub ReadWorkbook(Directory As String, FileName As String) As ExcelManager
	Try
		Dim fis As JavaObject
		fis.InitializeNewInstance("java.io.FileInputStream", Array(File.Combine(Directory, FileName)))
        
		Dim extension As String = FileName.ToLowerCase
        
		If extension.EndsWith(".xls") Then
			' For the format from your example (.xls)
			nativeWorkbook.InitializeNewInstance("org.apache.poi.hssf.usermodel.HSSFWorkbook", Array(fis))
			Log("📂 Loaded as legacy format (.xls)")
            
		Else If extension.EndsWith(".xlsx") Then
			' For modern format (.xlsx)
			' This is where it used to fail; we force the XSSF class
			nativeWorkbook.InitializeNewInstance("org.apache.poi.xssf.usermodel.XSSFWorkbook", Array(fis))
			Log("📂 Loaded as modern format (.xlsx)")
		End If
        
		fis.RunMethod("close", Null)
	Catch
		Log("❌ Error: " & LastException.Message)
		' Initialize XSSF by default to avoid null pointers
		nativeWorkbook.InitializeNewInstance("org.apache.poi.xssf.usermodel.XSSFWorkbook", Null)
	End Try
	Return Me
End Sub

' Global Search and Replace for all sheets in the Excel file
' <code>xl.SearchAndReplace("{DATE}", "2026-04-30").Save</code>
' <code>xl.SearchAndReplace("{FECHA}", "01/05/2026").Save(File.DirDefaultExternal, "reporte.xlsx")</code>
Public Sub SearchAndReplace(SearchText As String, ReplaceText As String) As ExcelManager
	Try
		If nativeWorkbook.IsInitialized = False Then
			Log("❌ Resource not initialized")
			Return Me
		End If

		Dim numSheets As Int = nativeWorkbook.RunMethod("getNumberOfSheets", Null)
        
		For i = 0 To numSheets - 1
			' Access each section of the product
			Dim sheet As JavaObject = nativeWorkbook.RunMethod("getSheetAt", Array(i))
            
			Dim rowIter As JavaObject = sheet.RunMethod("rowIterator", Null)
			Do While rowIter.RunMethod("hasNext", Null)
				Dim row As JavaObject = rowIter.RunMethod("next", Null)
                
				Dim cellIter As JavaObject = row.RunMethod("cellIterator", Null)
				Do While cellIter.RunMethod("hasNext", Null)
					Dim cell As JavaObject = cellIter.RunMethod("next", Null)
                    
					' Get the cell type safely to avoid version errors
					Dim cellTypeEnum As JavaObject = cell.RunMethod("getCellType", Null)
					Dim typeName As String = cellTypeEnum.RunMethod("name", Null)
                    
					' Check if the cell contains text (STRING)
					If typeName = "STRING" Then
						Dim value As String = cell.RunMethod("getStringCellValue", Null)
						If value <> Null And value.Contains(SearchText) Then
							cell.RunMethod("setCellValue", Array(value.Replace(SearchText, ReplaceText)))
						End If
					End If
				Loop
			Loop
		Next
        
		Log("✅ Replacement in sections completed")
	Catch
		Log("❌ Error in SearchAndReplace: " & LastException)
	End Try
	Return Me
End Sub

Public Sub CreateSheet(Name As String) As ExcelSheet
	Dim s As JavaObject = nativeWorkbook.RunMethod("createSheet", Array(Name))
    
	Dim sheetObj As ExcelSheet
	sheetObj.Initialize(Me, s)
    
	Return sheetObj
End Sub

Public Sub GetSheet(Name As String) As ExcelSheet
	Dim s As JavaObject = nativeWorkbook.RunMethod("getSheet", Array(Name))
	If s.IsInitialized = False Then s = nativeWorkbook.RunMethod("createSheet", Array(Name))
	Dim sheetObj As ExcelSheet
	sheetObj.Initialize(Me, s)
	Return sheetObj
End Sub

Public Sub Save(Directory As String, FileName As String)
	Try
		Dim out As OutputStream = File.OpenOutput(Directory, FileName, False)
		nativeWorkbook.RunMethod("write", Array(out))
		out.Close
		RaiseSaveEvent(True)
	Catch
		Log(LastException)
		RaiseSaveEvent(False)
	End Try
End Sub

Private Sub RaiseSaveEvent(Success As Boolean)
	If SubExists(mCallBack, mEventName & "_SaveCompleted") Then
		CallSub2(mCallBack, mEventName & "_SaveCompleted", Success)
	End If
End Sub

' Internal use for other classes
Public Sub getNativeWorkbook As JavaObject
	Return nativeWorkbook
End Sub

' <code>manager.TableToExcel(SQL1.ExecQuery("SELECT * FROM medidores"), "Reporte_SQL")</code>
Public Sub TableToExcel(Rs As ResultSet, SheetName As String)
	Try
		Dim sheet As ExcelSheet = GetSheet(SheetName)
		Dim colCount As Int = Rs.ColumnCount
		
		' 1. Create Headers (Row 0)
		Dim headerRow As ExcelRow = sheet.GetRow(0)
		For i = 0 To colCount - 1
			Dim cell As ExcelCell = headerRow.GetCell(i)
			cell.setValue(Rs.GetColumnName(i))
			cell.SetBold(True)
			cell.SetBorders
		Next
		
		' 2. Fill Data
		Dim rowIdx As Int = 1
		Do While Rs.NextRow
			Dim dataRow As ExcelRow = sheet.GetRow(rowIdx)
			For i = 0 To colCount - 1
				Dim dataCell As ExcelCell = dataRow.GetCell(i)
				
				' Try to get the value generically
				Dim val As Object = Rs.GetString2(i)
				If val = Null Then val = ""
				
				dataCell.setValue(val)
				dataCell.SetBorders
			Next
			rowIdx = rowIdx + 1
		Loop
		Rs.Close
		
		' 3. Safe column adjustment for Android (Manual Logic)
		sheet.AutoSizeColumns(0, colCount - 1)
		
		Log("SQL transformation completed: " & (rowIdx - 1) & " rows processed.")
		
	Catch
		Log("Error in TableToExcel: " & LastException.Message)
	End Try
End Sub


' Evolved version that allows adding an Item numbering column
Public Sub TableToExcelWithItem(Rs As ResultSet, SheetName As String)
	Try
		Dim sheet As ExcelSheet = GetSheet(SheetName)
		Dim colCount As Int = Rs.ColumnCount
		Dim offset As Int = 0
		offset = 1 ' Shift everything to the right if there is an Item
        
		Dim headerRow As ExcelRow = sheet.GetRow(0)
        
		' 1. Item Header (if applicable)
	
		Dim cellItem As ExcelCell = headerRow.GetCell(0)
		cellItem.setValue("ITEM")
		cellItem.SetBold(True)
		cellItem.SetBorders
	
        
		' 2. SQL Headers
		For i = 0 To colCount - 1
			Dim cell As ExcelCell = headerRow.GetCell(i + offset)
			cell.setValue(Rs.GetColumnName(i).ToUpperCase)
			cell.SetBold(True)
			cell.SetBorders
		Next
        
		' 3. Fill Data
		Dim rowIdx As Int = 1
		Do While Rs.NextRow
			Dim dataRow As ExcelRow = sheet.GetRow(rowIdx)
            
			' Write numbering
			
			Dim cItem As ExcelCell = dataRow.GetCell(0)
			cItem.setValue(rowIdx)
			cItem.SetBorders
			
            
			' Write SQL data
			For i = 0 To colCount - 1
				Dim dataCell As ExcelCell = dataRow.GetCell(i + offset)
				dataCell.setValue(Rs.GetString2(i))
				dataCell.SetBorders
			Next
			rowIdx = rowIdx + 1
		Loop
		Rs.Close
		sheet.AutoSizeColumns(0, colCount + offset - 1)
        
	Catch
		Log("Error: " & LastException.Message)
	End Try
End Sub

' Forces re-evaluation of all formulas in the workbook
Public Sub EvaluateAllFormulas
	Dim evaluator As JavaObject = nativeWorkbook.RunMethodjo("getCreationHelper", Null).RunMethod("createFormulaEvaluator", Null)
	evaluator.RunMethod("evaluateAll", Null)
End Sub


Public Sub GetSheetAt(Index As Int) As ExcelSheet
	Dim s As JavaObject = nativeWorkbook.RunMethod("getSheetAt", Array(Index))
    
	Dim sheetObj As ExcelSheet
	sheetObj.Initialize(Me, s)
    
	Return sheetObj
End Sub

Public Sub GetSheetCount As Int
	Return nativeWorkbook.RunMethod("getNumberOfSheets", Null)
End Sub

Public Sub RemoveSheet(Index As Int)
	nativeWorkbook.RunMethod("removeSheetAt", Array(Index))
End Sub

Public Sub RenameSheet(Index As Int, NewName As String)
	nativeWorkbook.RunMethod("setSheetName", Array(Index, NewName))
End Sub

Public Sub SetActiveSheet(Index As Int)
	nativeWorkbook.SetField("ActiveSheet", Index)
End Sub

Public Sub ForceRecalculation(Enabled As Boolean)
	nativeWorkbook.SetField("ForceFormulaRecalculation", Enabled)
End Sub


Public Sub AddPicture(FileDir As String, FileName As String, Format As Int) As Int
	Dim bytes() As Byte = File.ReadBytes(FileDir, FileName)
	Return nativeWorkbook.RunMethod("addPicture", Array(bytes, Format))
End Sub


Public Sub CreateNamedRange(Name As String, Ref As String)
	Dim nm As JavaObject = nativeWorkbook.RunMethod("createName", Null)
    
	nm.RunMethod("setNameName", Array(Name))
	nm.RunMethod("setRefersToFormula", Array(Ref))
End Sub


Public Sub SetPrintArea(SheetIndex As Int, StartCol As Int, EndCol As Int, StartRow As Int, EndRow As Int)
	nativeWorkbook.RunMethod("setPrintArea", Array(SheetIndex, StartCol, EndCol, StartRow, EndRow))
End Sub

Public Sub SetRepeatingRows(SheetIndex As Int, StartRow As Int, EndRow As Int)
	nativeWorkbook.RunMethod("setRepeatingRowsAndColumns", _
        Array(SheetIndex, -1, -1, StartRow, EndRow))
End Sub


Public Sub LockStructure
	nativeWorkbook.RunMethod("lockStructure", Null)
End Sub

Public Sub UnlockStructure
	nativeWorkbook.RunMethod("unLockStructure", Null)
End Sub

Public Sub GetSheetName(Index As Int) As String
	Return nativeWorkbook.RunMethod("getSheetName", Array(Index))
End Sub

Public Sub Close
	nativeWorkbook.RunMethod("close", Null)
End Sub

Public Sub getObject As JavaObject
	Return  nativeWorkbook
End Sub

Public Sub LockWorkbookStructure
	nativeWorkbook.RunMethod("lockStructure", Null)
End Sub

Public Sub UnlockWorkbookStructure
	nativeWorkbook.RunMethod("unLockStructure", Null)
End Sub

Public Sub GetStyle(Key As String) As JavaObject
	If styleCache.ContainsKey(Key) Then
		Return styleCache.Get(Key)
	End If
    
	Dim style As JavaObject = nativeWorkbook.RunMethod("createCellStyle", Null)
	styleCache.Put(Key, style)
    
	Return style
End Sub



Public Sub GetCombinedStyle(BaseStyle As JavaObject, PropertyKey As String) As JavaObject
	Dim finalKey As String = PropertyKey ' Here you can concatenate properties: "BORDER_BG_CORAL"
    
	If styleCache.ContainsKey(finalKey) Then
		Return styleCache.Get(finalKey)
	End If
    
	' If it doesn't exist, clone the base style and save it
	Dim newStyle As JavaObject = nativeWorkbook.RunMethod("createCellStyle", Null)
	newStyle.RunMethod("cloneStyleFrom", Array(BaseStyle))
    
	styleCache.Put(finalKey, newStyle)
	Return newStyle
End Sub