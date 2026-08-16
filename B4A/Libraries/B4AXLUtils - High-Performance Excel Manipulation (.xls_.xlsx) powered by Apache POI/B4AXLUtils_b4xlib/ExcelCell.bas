B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' Class Module: ExcelCell
Sub Class_Globals
#If B4A Or B4J
	Private nativeCell As JavaObject
#End If
	Private managerRef As ExcelManager
End Sub

' Initializes the ExcelCell instance.
Public Sub Initialize (Manager As ExcelManager, Sheet As ExcelSheet, Cell As Object)
	managerRef = Manager
#If B4A Or B4J
	nativeCell = Cell
#End If
End Sub

' Unlocks a specific cell to make it editable after protecting the sheet.
' <code>cell.SetLocked(False)</code>
Public Sub SetLocked(Locked As Boolean)
#If B4A Or B4J
	Try
		Dim style As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
		style.RunMethod("setLocked", Array(Locked))
	Catch
		Log("❌ Error changing cell lock: " & LastException)
	End Try
#End If
End Sub

' Sets the cell value automatically handles Booleans, Longs, Doubles, and Strings.
' <code>cell.setValue("Hello World")</code>
Public Sub setValue(Val As Object)
#If B4A Or B4J
	If Val = Null Then
		nativeCell.RunMethod("setBlank", Null)
		Return
	End If

	' Boolean Handling
	If Val Is Boolean Then
		nativeCell.RunMethod("setCellValue", Array(Val))
		Return
	End If

	' Date Handling (represented as Long in B4X)
	If Val Is Long Then
		Dim joDate As JavaObject
		joDate.InitializeNewInstance("java.util.Date", Array(Val))
		nativeCell.RunMethod("setCellValue", Array(joDate))
		Return
	End If

	' Number Handling and precision validation
	If IsNumber(Val) Then
		Dim sVal As String = Val & ""
        
		' --- PRECISION ADJUSTMENT ---
		' If the number has more than 10 digits (like contract accounts),
		' we force it as STRING. This avoids E+11 notation and loss of precision
		' without needing visible single quotes.
		If sVal.Length > 10 Then
			Dim ctEnum As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.CellType")
			nativeCell.RunMethod("setCellType", Array(ctEnum.GetField("STRING")))
			nativeCell.RunMethod("setCellValue", Array(sVal))
		Else
			' It's a small/safe number (short ID, quantities, etc.)
			Dim d As Double = Val
			nativeCell.RunMethod("setCellValue", Array(d))
            
			' If it's near the limit of 10 digits, apply plain format
			If d > 999999999 Or d < -999999999 Then
				ApplyDataFormat("0")
			End If
		End If
		Return
	End If

	' String Handling (Default)
	nativeCell.RunMethod("setCellValue", Array(Val & ""))
#End If
End Sub

' Sets the cell formula expression (excluding the leading '=' sign).
' <code>cell.setFormula("SUM(A1:A10)")</code>
Public Sub setFormula(Formula As String)
#If B4A Or B4J
	nativeCell.RunMethod("setCellFormula", Array(Formula))
#End If
End Sub

' Reads the cell value, returning longs without decimals if they are whole numbers.
' <code>Dim value As Object = cell.getValue</code>
Public Sub getValue As Object
#If B4A Or B4J
	Try
		If nativeCell.IsInitialized = False Then Return ""
        
		Dim typeName As String = getCellTypeName
        
		Select Case typeName
			Case "NUMERIC"
				Dim dateUtil As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.DateUtil")
                
				If dateUtil.RunMethod("isCellDateFormatted", Array(nativeCell)) Then
					Return nativeCell.RunMethod("getDateCellValue", Null)
				Else
					Dim dblVal As Double = nativeCell.RunMethod("getNumericCellValue", Null)
					If dblVal = Floor(dblVal) Then
						Return dblVal.As(Long) ' Force Long if there are no decimals
					Else
						Return dblVal
					End If
				End If
                
			Case "STRING"
				Dim s As String = nativeCell.RunMethod("getStringCellValue", Null)
				Return IIf(s = Null, "", s)
                
			Case "FORMULA"
				Return getFormulaValue
                
			Case "BOOLEAN"
				Return nativeCell.RunMethod("getBooleanValue", Null)
                
			Case Else ' BLANK, ERROR, etc.
				Return ""
		End Select
	Catch
		Log("Error in getValue: " & LastException)
		Return ""
	End Try
#Else
	Return ""
#End If
End Sub

' Evaluates and retrieves the result value of a formula.
Private Sub getFormulaValue As Object
#If B4A Or B4J
	Try
		Dim wb As JavaObject = nativeCell.RunMethodjo("getSheet", Null).RunMethod("getWorkbook", Null)
		Dim evaluator As JavaObject = wb.RunMethodjo("getCreationHelper", Null).RunMethod("createFormulaEvaluator", Null)
        
		Dim cellValue As JavaObject = evaluator.RunMethod("evaluate", Array(nativeCell))
		Dim resultTypeEnum As JavaObject = cellValue.RunMethod("getCellType", Null)
		Dim resultTypeName As String = resultTypeEnum.RunMethod("name", Null)
        
		Select Case resultTypeName
			Case "NUMERIC"
				Return cellValue.RunMethod("getNumberValue", Null)
			Case "STRING"
				Return cellValue.RunMethod("getStringValue", Null)
			Case "BOOLEAN"
				Return cellValue.RunMethod("getBooleanValue", Null)
			Case Else
				Return ""
		End Select
	Catch
		Log("❌ Error evaluating formula: " & LastException.Message)
		Return ""
	End Try
#Else
	Return ""
#End If
End Sub

' === STYLE METHODS (CACHED & OPTIMIZED) ===

' Sets bold font styling.
' <code>cell.setBold(True)</code>
Public Sub setBold(Enabled As Boolean)
#If B4A Or B4J
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.GetModifiedStyle(oldStyle, "BOLD", Enabled)
	nativeCell.RunMethod("setCellStyle", Array(newStyle))
#End If
End Sub

' Applies a thin border on all sides of the cell.
' <code>cell.setBorders</code>
Public Sub setBorders
#If B4A Or B4J
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.GetModifiedStyle(oldStyle, "BORDER", True)
	nativeCell.RunMethod("setCellStyle", Array(newStyle))
#End If
End Sub

' Sets underline font styling.
' <code>cell.setUnderline(True)</code>
Public Sub setUnderline(Enabled As Boolean)
#If B4A Or B4J
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.GetModifiedStyle(oldStyle, "UNDERLINE", Enabled)
	nativeCell.RunMethod("setCellStyle", Array(newStyle))
#End If
End Sub

' Sets font text color using workbook color palette index.
' <code>cell.setTextColor(excel.COLOR_RED)</code>
Public Sub setTextColor(ColorIndex As Short)
#If B4A Or B4J
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.GetModifiedStyle(oldStyle, "TEXTCOLOR", ColorIndex)
	nativeCell.RunMethod("setCellStyle", Array(newStyle))
#End If
End Sub

' Aligns cell contents horizontally and vertically centered.
' <code>cell.setAlignmentCenter</code>
Public Sub setAlignmentCenter
#If B4A Or B4J
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.GetModifiedStyle(oldStyle, "CENTER", True)
	nativeCell.RunMethod("setCellStyle", Array(newStyle))
#End If
End Sub

' Sets the cell background color pattern.
' <code>cell.setBackgroundColor(excel.PASTEL_GREEN)</code>
Public Sub setBackgroundColor(ColorIndex As Short)
#If B4A Or B4J
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.GetModifiedStyle(oldStyle, "COLORBG", ColorIndex)
	nativeCell.RunMethod("setCellStyle", Array(newStyle))
#End If
End Sub

' Sets the font size in points.
' <code>cell.setTextSize(12)</code>
Public Sub setTextSize(Points As Short)
#If B4A Or B4J
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.GetModifiedStyle(oldStyle, "FONTSIZE", Points)
	nativeCell.RunMethod("setCellStyle", Array(newStyle))
#End If
End Sub

#If B4A Or B4J
' Returns the native POI Cell JavaObject.
Public Sub getObject As JavaObject
	Return nativeCell
End Sub
#End If

' Sets a numeric date value to the cell represented as a long.
' <code>
'   cell.setDate(DateTime.Now)
' </code>
Public Sub setDate(Value As Long)
#If B4A Or B4J
	nativeCell.RunMethod("setCellValue", Array(Value))
#End If
End Sub

' Retrieves the date value of the cell as a Long.
' <code>
'   Dim dt As Long = cell.getDate
' </code>
Public Sub getDate As Long
#If B4A Or B4J
	Return nativeCell.RunMethod("getDateCellValue", Null)
#Else
	Return 0
#End If
End Sub

' Sets a hyperlink address to the cell.
' <code>cell.setHyperlink("https://www.google.com")</code>
Public Sub setHyperlink(Address As String)
#If B4A Or B4J
	Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
	Dim link As JavaObject = helper.RunMethod("createHyperlink", Array(1)) ' URL Type = 1
    
	link.RunMethod("setAddress", Array(Address))
	nativeCell.RunMethod("setHyperlink", Array(link))
#End If
End Sub

' Removes hyperlinks from the cell.
' <code>cell.removeHyperlink</code>
Public Sub removeHyperlink
#If B4A Or B4J
	nativeCell.RunMethod("removeHyperlink", Null)
#End If
End Sub

' Sets a popup comment to the cell.
' <code>cell.setComment("Review required.")</code>
Public Sub setComment(Text As String)
#If B4A Or B4J
	Dim sheet As JavaObject = nativeCell.RunMethod("getSheet", Null)
	Dim drawing As JavaObject = sheet.RunMethod("createDrawingPatriarch", Null)
    
	Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
	Dim anchor As JavaObject = helper.RunMethod("createClientAnchor", Null)
    
	Dim comment As JavaObject = drawing.RunMethod("createCellComment", Array(anchor))
    
	Dim richText As JavaObject = helper.RunMethod("createRichTextString", Array(Text))
	comment.RunMethod("setString", Array(richText))
    
	nativeCell.RunMethod("setCellComment", Array(comment))
#End If
End Sub

' Removes any comments from the cell.
' <code>cell.removeComment</code>
Public Sub removeComment
#If B4A Or B4J
	nativeCell.RunMethod("removeCellComment", Null)
#End If
End Sub

' Returns the cell address reference string (e.g. "A1").
' <code>Dim ref As String = cell.getReference</code>
Public Sub getReference As String
#If B4A Or B4J
	Return nativeCell.RunMethod("getReference", Null)
#Else
	Return ""
#End If
End Sub

' Returns the integer ID representing cell type (0=NUMERIC, 1=STRING, etc.)
' <code>Dim t As Int = cell.getCellType</code>
Public Sub getCellType As Int
#If B4A Or B4J
	Try
		Dim cellTypeEnum As JavaObject = nativeCell.RunMethod("getCellType", Null)
		Return cellTypeEnum.RunMethod("ordinal", Null)
	Catch
		Log("Error in getCellType: " & LastException)
		Return -1
	End Try
#Else
	Return -1
#End If
End Sub

' Returns the name representing the cell type (e.g. "STRING", "NUMERIC").
' <code>Dim tName As String = cell.getCellTypeName</code>
Public Sub getCellTypeName As String
#If B4A Or B4J
	Try
		Dim cellTypeEnum As JavaObject = nativeCell.RunMethod("getCellType", Null)
		Return cellTypeEnum.RunMethod("name", Null)
	Catch
		Return "ERROR"
	End Try
#Else
	Return "ERROR"
#End If
End Sub

' Sets the structural type of the cell (0=NUMERIC, 1=STRING, etc.).
' <code>
'   cell.setCellType(excel.TYPE_STRING)
' </code>
Public Sub setCellType(TypeCode As Int)
#If B4A Or B4J
	Try
		Dim ctEnum As JavaObject = InitializeStaticSafe("org.apache.poi.ss.usermodel.CellType")
        
		Dim typeName As String
		Select Case TypeCode
			Case managerRef.TYPE_NUMERIC: typeName = "NUMERIC"
			Case managerRef.TYPE_STRING:  typeName = "STRING"
			Case managerRef.TYPE_FORMULA: typeName = "FORMULA"
			Case managerRef.TYPE_BLANK:   typeName = "BLANK"
			Case managerRef.TYPE_BOOLEAN: typeName = "BOOLEAN"
			Case managerRef.TYPE_ERROR:   typeName = "ERROR"
			Case Else:         typeName = "STRING"
		End Select
		
		nativeCell.RunMethod("setCellType", Array(ctEnum.GetField(typeName)))
	Catch
		Log("Error setting cell type: " & LastException)
	End Try
	#End If
End Sub

' Sets a currency double value with a prepended symbol formatting.
' <code>cell.setCurrency(1500.50, "$")</code>
Public Sub setCurrency(Value As Double, Symbol As String)
#If B4A Or B4J
	nativeCell.RunMethod("setCellValue", Array(Value))
	Dim format As String = Symbol & "#,##0.00"
	ApplyDataFormat(format)
#End If
End Sub

' Clears the cell contents (sets it to blank).
' <code>cell.clear</code>
Public Sub clear
#If B4A Or B4J
	nativeCell.RunMethod("setBlank", Null)
#End If
End Sub

' Sets the active cell in the workbook.
' <code>cell.setAsActiveCell</code>
Public Sub setAsActiveCell
#If B4A Or B4J
	nativeCell.RunMethod("setAsActiveCell", Null)
#End If
End Sub

Public Sub toString As String
#If B4A Or B4J
	Return nativeCell.RunMethod("toString", Null)
#Else
	Return ""
#End If
End Sub

' Returns True if the cell is part of an array formula.
Public Sub isArrayFormula As Boolean
#If B4A Or B4J
	Return nativeCell.RunMethod("isPartOfArrayFormulaGroup", Null)
#Else
	Return False
#End If
End Sub

' Applies a custom POI data format mask to the cell.
Private Sub ApplyDataFormat(FormatStr As String)
#If B4A Or B4J
	Dim dataFormat As JavaObject = managerRef.getNativeWorkbook.RunMethod("createDataFormat", Null)
	Dim formatIdx As Object = dataFormat.RunMethod("getFormat", Array(FormatStr))
    
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.GetModifiedStyle(oldStyle, "DATAFORMAT", formatIdx)
    
	nativeCell.RunMethod("setCellStyle", Array(newStyle))
#End If
End Sub

' Sets a value formatted as percentage.
' <code>cell.setPercentage(0.155)</code>
Public Sub setPercentage(Value As Double)
#If B4A Or B4J
	nativeCell.RunMethod("setCellValue", Array(Value))
	ApplyDataFormat("0.00%")
#End If
End Sub

' Sets a date value formatted by a custom formatting string.
' <code>cell.setDateFormatted(DateTime.Now, "yyyy-MM-dd")</code>
Public Sub setDateFormatted(Value As Long, FormatStr As String)
#If B4A Or B4J
	nativeCell.RunMethod("setCellValue", Array(Value))
	ApplyDataFormat(FormatStr)
#End If
End Sub

' Sets the date formatting mask.
' <code>
'   cell.setDateFormat("yyyy-MM-dd HH:mm:ss")
' </code>
Public Sub setDateFormat(format As String)
#If B4A Or B4J
	ApplyDataFormat(format)
#End If
End Sub

' Smart inserts a value, automatically detecting dates, numbers, booleans, and formats.
' <code>
'   cell.setSmartValue("Text or number or boolean or long-date")
' </code>
Public Sub setSmartValue(Value As Object)
#If B4A Or B4J
	If Value Is Boolean Then
		nativeCell.RunMethod("setCellValue", Array(Value))
		Return
	End If
    
	If IsNumber(Value) Then
		Dim d As Double = Value
		nativeCell.RunMethod("setCellValue", Array(d))
		If d > 999999999 Or d < -999999999 Then
			ApplyDataFormat("0")
		End If
		Return
	End If
    
	If Value Is Long Then
		nativeCell.RunMethod("setCellValue", Array(Value))
		ApplyDataFormat("dd/MM/yyyy")
		Return
	End If
    
	nativeCell.RunMethod("setCellValue", Array(Value & ""))
#End If
End Sub

' Sets a currency double value formatted according to standard ISO currency codes.
' <code>cell.setCurrencyISO(450.75, excel.ISO_USD)</code>
Public Sub setCurrencyISO(Value As Double, ISO As String)
#If B4A Or B4J
	nativeCell.RunMethod("setCellValue", Array(Value))
    
	Dim format As String
	Select ISO
		Case "USD"
			format = "$#,##0.00"
		Case "EUR"
			format = "€#,##0.00"
		Case "MXN"
			format = "$#,##0.00"
		Case "PEN"
			format = "S/ #,##0.00"
		Case Else
			format = "#,##0.00"
	End Select
    
	ApplyDataFormat(format)
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
#End If