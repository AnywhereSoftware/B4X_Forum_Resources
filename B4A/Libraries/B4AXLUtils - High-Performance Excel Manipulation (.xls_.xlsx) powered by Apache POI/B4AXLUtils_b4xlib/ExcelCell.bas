B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' Class Module: ExcelCell
Sub Class_Globals
	Private nativeCell As JavaObject
	Private managerRef As ExcelManager
'	Private sheetRef As ExcelSheet

	
End Sub

Public Sub Initialize (Manager As ExcelManager, Sheet As ExcelSheet, Cell As JavaObject)
	managerRef = Manager
'	sheetRef = Sheet
	nativeCell = Cell
End Sub

' Unlocks a specific cell to make it editable after protecting the sheet
' Defines whether the cell is locked or not (Only works if the sheet is protected)
Public Sub SetLocked(Locked As Boolean)
	Try
		' Get the current style of the cell
		Dim style As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
        
		' Create a new style based on the previous one to not lose formatting (optional but recommended)
		' Or simply modify the current one if your library manages shared styles
		style.RunMethod("setLocked", Array(Locked))
	Catch
		Log("❌ Error changing cell lock: " & LastException)
	End Try
End Sub


' <code>Cell.setValue(76543210987654321098)</code>
' <code>Cell.setValue("Hello World")</code>
Public Sub setValue(Val As Object)
	If Val = Null Then
		nativeCell.RunMethod("setBlank", Null)
		Return
	End If

	' Boolean Handling
	If Val Is Boolean Then
		nativeCell.RunMethod("setCellValue", Array(Val))
		Return
	End If

	' Date Handling (Long in B4X)
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
		' we force it as STRING. This avoids E+11 and loss of precision
		' without needing visible single quotes.
		If sVal.Length > 10 Then
			Dim ctEnum As JavaObject
			ctEnum.InitializeStatic("org.apache.poi.ss.usermodel.CellType")
			nativeCell.RunMethod("setCellType", Array(ctEnum.GetField("STRING")))
			nativeCell.RunMethod("setCellValue", Array(sVal))
		Else
			' It's a small/safe number (short ID, quantities, etc.)
			Dim d As Double = Val
			nativeCell.RunMethod("setCellValue", Array(d))
            
			' If it's near the limit of 10, apply plain format
			If d > 999999999 Or d < -999999999 Then
				ApplyDataFormat("0")
			End If
		End If
		Return
	End If

	' String Handling (Default)
	nativeCell.RunMethod("setCellValue", Array(Val & ""))
End Sub


Public Sub setFormula(Formula As String)
	nativeCell.RunMethod("setCellFormula", Array(Formula))
End Sub


' <code>Dim value As Object = Cell.Value</code>
' Reads the cell value, returning integers without decimals if they don't have them.
' <code>Dim value As Object = Cell.Value</code>
Public Sub getValue As Object
	Try
		If nativeCell.IsInitialized = False Then Return ""
        
		' Use the type name for the Select Case
		Dim typeName As String = getCellTypeName
        
		Select Case typeName
			Case "NUMERIC"
				Dim dateUtil As JavaObject
				dateUtil.InitializeStatic("org.apache.poi.ss.usermodel.DateUtil")
                
				If dateUtil.RunMethod("isCellDateFormatted", Array(nativeCell)) Then
					Return nativeCell.RunMethod("getDateCellValue", Null)
				Else
					Dim dblVal As Double = nativeCell.RunMethod("getNumericCellValue", Null)
					If dblVal = Floor(dblVal) Then
						Return dblVal.As(Long) ' Force Long if no decimals
					Else
						Return dblVal
					End If
				End If
                
			Case "STRING"
				Dim s As String = nativeCell.RunMethod("getStringCellValue", Null)
				Return IIf(s = Null, "", s)
                
			Case "FORMULA"
				' Delegate to the formula sub
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
End Sub

' Extracts the actual result of a formula by evaluating the product
Private Sub getFormulaValue As Object
	Try
		Dim wb As JavaObject = nativeCell.RunMethodjo("getSheet", Null).RunMethod("getWorkbook", Null)
		Dim evaluator As JavaObject = wb.RunMethodjo("getCreationHelper", Null).RunMethod("createFormulaEvaluator", Null)
        
		Dim cellValue As JavaObject = evaluator.RunMethod("evaluate", Array(nativeCell))
		' Get the type of the FORMULA RESULT
		Dim resultTypeEnum As JavaObject = cellValue.RunMethod("getCellType", Null)
		Dim resultTypeName As String = resultTypeEnum.RunMethod("name", Null)
        
		Select Case resultTypeName
			Case "NUMERIC"
				' <code>Result = cellValue.getNumberValue</code>
				Return cellValue.RunMethod("getNumberValue", Null)
			Case "STRING"
				' <code>Result = cellValue.getStringValue</code>
				Return cellValue.RunMethod("getStringValue", Null)
			Case "BOOLEAN"
				' <code>Result = cellValue.getBooleanValue</code>
				Return cellValue.RunMethod("getBooleanValue", Null)
			Case Else
				Return ""
		End Select
	Catch
		Log("❌ Error evaluating formula: " & LastException.Message)
		Return ""
	End Try
End Sub
' === REPAIRED STYLE METHODS ===

Public Sub setBold(Enabled As Boolean)
	Dim style As JavaObject = GetOrCloneStyle
	Dim font As JavaObject = managerRef.getNativeWorkbook.RunMethod("createFont", Null)
	font.RunMethod("setBold", Array(Enabled))
	style.RunMethod("setFont", Array(font))
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub

Public Sub setBorders
	Dim style As JavaObject = GetOrCloneStyle
	Dim bEnum As JavaObject
	bEnum.InitializeStatic("org.apache.poi.ss.usermodel.BorderStyle")
	Dim thin As Object = bEnum.GetField("THIN")
	
	style.RunMethod("setBorderTop", Array(thin))
	style.RunMethod("setBorderBottom", Array(thin))
	style.RunMethod("setBorderLeft", Array(thin))
	style.RunMethod("setBorderRight", Array(thin))
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub

Public Sub GetOrCloneStyle As JavaObject
	Dim oldStyle As JavaObject = nativeCell.RunMethod("getCellStyle", Null)
	Dim newStyle As JavaObject = managerRef.getNativeWorkbook.RunMethod("createCellStyle", Null)
	If oldStyle.IsInitialized Then newStyle.RunMethod("cloneStyleFrom", Array(oldStyle))
	Return newStyle
End Sub


' <code>cell.SetUnderline(True)</code>
Public Sub setUnderline(Enabled As Boolean)
	Dim style As JavaObject = GetOrCloneStyle
	Dim font As JavaObject = managerRef.getNativeWorkbook.RunMethod("createFont", Null)
    
	If Enabled Then
		Dim uEnum As JavaObject
		uEnum.InitializeStatic("org.apache.poi.ss.usermodel.Font")
		font.RunMethod("setUnderline", Array(uEnum.GetField("U_SINGLE")))
	Else
		font.RunMethod("setUnderline", Array(0))
	End If
    
	style.RunMethod("setFont", Array(font))
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub

' <code>cell.SetTextColor(10) ' 10 is RED in HSSFColor</code>
Public Sub setTextColor(ColorIndex As Short)
	Dim style As JavaObject = GetOrCloneStyle
	Dim font As JavaObject = managerRef.getNativeWorkbook.RunMethod("createFont", Null)
    
	Dim joShort As JavaObject
	font.RunMethod("setColor", Array(joShort.InitializeStatic("java.lang.Short").RunMethod("valueOf", Array(ColorIndex))))
    
	style.RunMethod("setFont", Array(font))
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub


' Aligns the product content to center (Horizontal and Vertical)
' <code>cell.SetAlignmentCenter</code>
Public Sub setAlignmentCenter
	Dim style As JavaObject = GetOrCloneStyle
	
	' Load POI alignment classes
	Dim alignEnum As JavaObject
	Dim vAlignEnum As JavaObject
	
	alignEnum.InitializeStatic("org.apache.poi.ss.usermodel.HorizontalAlignment")
	vAlignEnum.InitializeStatic("org.apache.poi.ss.usermodel.VerticalAlignment")
	
	' Apply horizontal center and vertical center
	style.RunMethod("setAlignment", Array(alignEnum.GetField("CENTER")))
	style.RunMethod("setVerticalAlignment", Array(vAlignEnum.GetField("CENTER")))
	
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub

' <code>cell.SetBackgroundColor(cell.PASTEL_GOLD)</code>
Public Sub setBackgroundColor(ColorIndex As Short)
	Dim style As JavaObject = GetOrCloneStyle
	
	Dim fillEnum As JavaObject
	fillEnum.InitializeStatic("org.apache.poi.ss.usermodel.FillPatternType")
	
	' It is mandatory to define the SOLID_FOREGROUND pattern for the color to be visible
	style.RunMethod("setFillPattern", Array(fillEnum.GetField("SOLID_FOREGROUND")))
	
	Dim joShort As JavaObject
	style.RunMethod("setFillForegroundColor", Array(joShort.InitializeStatic("java.lang.Short").RunMethod("valueOf", Array(ColorIndex))))
	
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub

' Sets the font size in points
' <code>cell.setTextSize(14)</code>
Public Sub setTextSize(Points As Short)
	Dim style As JavaObject = GetOrCloneStyle
	Dim font As JavaObject = managerRef.getNativeWorkbook.RunMethod("createFont", Null)
    
	' If a font already existed, try to copy its attributes to not lose Bold/Color
	Dim oldFont As JavaObject = GetFontFromStyle(style)
	If oldFont.IsInitialized Then
		' Copy basic attributes (optional, but recommended)
		font.RunMethod("setBold", Array(oldFont.RunMethod("getBold", Null)))
		font.RunMethod("setColor", Array(oldFont.RunMethod("getColor", Null)))
	End If
    
	' Apply the new size
	Dim joShort As JavaObject
	font.RunMethod("setFontHeightInPoints", Array(joShort.InitializeStatic("java.lang.Short").RunMethod("valueOf", Array(Points))))
    
	style.RunMethod("setFont", Array(font))
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub

' Helper to extract the current font from a style
Private Sub GetFontFromStyle(style As JavaObject) As JavaObject
	Try
		Dim fontIdx As Int = style.RunMethod("getFontIndex", Null)
		Return managerRef.getNativeWorkbook.RunMethod("getFontAt", Array(fontIdx))
	Catch
		Return Null
	End Try
End Sub

Public Sub getObject As JavaObject
	Return  nativeCell
End Sub

Public Sub setDate(Value As Long)
	nativeCell.RunMethod("setCellValue", Array(Value))
End Sub

Public Sub getDate As Long
	Return nativeCell.RunMethod("getDateCellValue", Null)
End Sub

Public Sub setHyperlink(Address As String)
	Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
	Dim link As JavaObject = helper.RunMethod("createHyperlink", Array(1)) ' URL
    
	link.RunMethod("setAddress", Array(Address))
	nativeCell.RunMethod("setHyperlink", Array(link))
End Sub

Public Sub removeHyperlink
	nativeCell.RunMethod("removeHyperlink", Null)
End Sub

Public Sub setComment(Text As String)
	Dim sheet As JavaObject = nativeCell.RunMethod("getSheet", Null)
	Dim drawing As JavaObject = sheet.RunMethod("createDrawingPatriarch", Null)
    
	Dim helper As JavaObject = managerRef.getNativeWorkbook.RunMethod("getCreationHelper", Null)
	Dim anchor As JavaObject = helper.RunMethod("createClientAnchor", Null)
    
	Dim comment As JavaObject = drawing.RunMethod("createCellComment", Array(anchor))
    
	Dim richText As JavaObject = helper.RunMethod("createRichTextString", Array(Text))
	comment.RunMethod("setString", Array(richText))
    
	nativeCell.RunMethod("setCellComment", Array(comment))
End Sub

Public Sub removeComment
	nativeCell.RunMethod("removeCellComment", Null)
End Sub


Public Sub getReference As String
	Return nativeCell.RunMethod("getReference", Null)
End Sub

' Returns the integer ID of the cell type (0=NUMERIC, 1=STRING, etc.)
Public Sub getCellType As Int
	Try
		Dim cellTypeEnum As JavaObject = nativeCell.RunMethod("getCellType", Null)
		Return cellTypeEnum.RunMethod("ordinal", Null)
	Catch
		Log("Error in getCellType: " & LastException)
		Return -1
	End Try
End Sub

' Recommended alternative: Get the name directly
Public Sub getCellTypeName As String
	Try
		Dim cellTypeEnum As JavaObject = nativeCell.RunMethod("getCellType", Null)
		Return cellTypeEnum.RunMethod("name", Null)
	Catch
		Return "ERROR"
	End Try
End Sub


' Replace your current setCellType sub with this one:
Public Sub setCellType(TypeCode As Int)
	Try
		Dim ctEnum As JavaObject
		ctEnum.InitializeStatic("org.apache.poi.ss.usermodel.CellType")
        
		' Map your Int constant to the corresponding Enum object
		Dim typeName As String
		Select Case TypeCode
			Case managerRef.TYPE_NUMERIC: typeName = "NUMERIC"
			Case managerRef.TYPE_STRING:  typeName = "STRING"
			Case managerRef.TYPE_FORMULA: typeName = "FORMULA"
			Case managerRef.TYPE_BLANK:   typeName = "BLANK"
			Case managerRef.TYPE_BOOLEAN: typeName = "BOOLEAN"
			Case managerRef.TYPE_ERROR:   typeName = "ERROR"
			Case Else:         typeName = "STRING" ' Default
		End Select
		
		nativeCell.RunMethod("setCellType", Array(ctEnum.GetField(typeName)))
	Catch
		Log("Error setting cell type: " & LastException)
	End Try
End Sub

Public Sub setCurrency(Value As Double, Symbol As String)
	nativeCell.RunMethod("setCellValue", Array(Value))
    
	Dim format As String = Symbol & "#,##0.00"
	ApplyDataFormat(format)
End Sub

Public Sub clear
	nativeCell.RunMethod("setBlank", Null)
End Sub

Public Sub setAsActiveCell
	nativeCell.RunMethod("setAsActiveCell", Null)
End Sub

Public Sub toString As String
	Return nativeCell.RunMethod("toString", Null)
End Sub

Public Sub isArrayFormula As Boolean
	Return nativeCell.RunMethod("isPartOfArrayFormulaGroup", Null)
End Sub

Private Sub ApplyDataFormat(FormatStr As String)
	Dim dataFormat As JavaObject = managerRef.getNativeWorkbook.RunMethod("createDataFormat", Null)
	Dim formatIdx As Object = dataFormat.RunMethod("getFormat", Array(FormatStr))
    
	Dim style As JavaObject = GetOrCloneStyle
	style.RunMethod("setDataFormat", Array(formatIdx))
    
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub

Public Sub setPercentage(Value As Double)
	nativeCell.RunMethod("setCellValue", Array(Value))
    
	ApplyDataFormat("0.00%")
End Sub

Public Sub setDateFormatted(Value As Long, FormatStr As String)
	nativeCell.RunMethod("setCellValue", Array(Value))
	ApplyDataFormat(FormatStr)
End Sub

' Inside ExcelCell (based on POI 5.x)
Public Sub setDateFormat(format As String)
	Dim workbook As JavaObject = managerRef.getNativeWorkbook ' Need reference to the workbook
	Dim helper As JavaObject = workbook.RunMethod("getCreationHelper", Null)
	Dim dataFormat As JavaObject = helper.RunMethod("createDataFormat", Null)
    
	Dim style As JavaObject = workbook.RunMethod("createCellStyle", Null)
	style.RunMethod("setDataFormat", Array(dataFormat.RunMethod("getFormat", Array(format))))
    
	nativeCell.RunMethod("setCellStyle", Array(style))
End Sub

Public Sub setSmartValue(Value As Object)
    
	If Value Is Boolean Then
		nativeCell.RunMethod("setCellValue", Array(Value))
		Return
	End If
    
	If IsNumber(Value) Then
		Dim d As Double = Value
		nativeCell.RunMethod("setCellValue", Array(d))
		' Force full numeric format if it's a large number
		If d > 999999999 Or d < -999999999 Then
			ApplyDataFormat("0")
		End If
		Return
	End If
    
	' Detect date (Long DateTime type)
	If Value Is Long Then
		nativeCell.RunMethod("setCellValue", Array(Value))
		ApplyDataFormat("dd/MM/yyyy")
		Return
	End If
    
	' Default: text
	nativeCell.RunMethod("setCellValue", Array(Value & ""))
    
End Sub


Public Sub setCurrencyISO(Value As Double, ISO As String)
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
End Sub