B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Sub Class_Globals
	Public BANano As BANano
	Public WorkBook As BANanoObject
	Private oxml As BANanoObject
	Private fName As String
	Type OXMLCell(typeOf As String, value As String, formula As String, style As Map)
	Type OXMLRow(rowIndex As Int, columnIndex As Int, values As List, style As Map)
	Type OXMLStyle(bold As Boolean, italic As Boolean, underline As Boolean, strike As Boolean, fontSize As String, _
	fontColor As String, fontName As String, fontFamily As String, scheme As String, numberFrmat As String, _
	borderColor As String, borderThickness As String, hAlignment As String, vAlignment As String, _
	FillPattern As String, FillForeColor As String, FillBackground As String)
	Public const BorderThick As String = "thick" 
	Public const BorderNone As String = "none"
	Public const BorderThin As String = "thin"
	Public const BorderMedium As String = "medium"
	Public const BorderDashed As String = "dashed"
	Public const BorderDotted As String = "dotted"
	Public const BorderDouble As String = "double"
	Public const BorderHair As String = "hair"
	Public const BorderMediumDashed As String = "mediumDashed"
	Public const BorderDashDot As String = "dashDot"
	Public const BorderMediumDashDot As String = "mediumDashDot"
	Public const BorderDashDotDot As String = "dashDotDot"
	Public const BorderMediumDashDotDot As String = "mediumDashDotDot"
	Public const BorderSlantDashDot As String = "slantDashDot"
	Public const colors_red As String = "F44336"
	Public const colors_pink As String = "E91E63"
	Public const colors_purple As String = "9C27B0"
	Public const colors_deepPurple As String = "673AB7"
	Public const colors_indigo As String = "3F51B5"
	Public const colors_blue As String = "2196F3"
	Public const colors_lightBlue As String = "03A9F4"
	Public const colors_cyan As String = "00BCD4"
	Public const colors_teal As String = "009688"
	Public const colors_green As String = "4CAF50"
	Public const colors_lightGreen As String = "8BC34A"
	Public const colors_lime As String = "CDDC39"
	Public const colors_yellow As String = "ffe821"
	Public const colors_amber As String = "FFC107"
	Public const colors_orange As String = "FF9800"
	Public const colors_deepOrange As String = "FF5722"
	Public const colors_brown As String = "795548"
	Public const colors_grey As String = "9E9E9E"
	Public const colors_blueGrey As String = "607D8B"
	Public const colors_black As String = "000000"
	Public const colors_white As String = "ffffff"
	Public const colors_transparent As String = "transparent"
	'
	Public const Pattern_darkDown As String = "darkDown"
	Public const Pattern_darkGray As String = "darkGray"
	Public const Pattern_darkGrid As String = "darkGrid"
	Public const Pattern_darkHorizontal As String = "darkHorizontal"
	Public const Pattern_darkTrellis As String = "darkTrellis"
	Public const Pattern_darkUp As String = "darkUp"
	Public const Pattern_darkVertical As String = "darkVertical"
	Public const Pattern_gray0625 As String = "gray0625"
	Public const Pattern_gray125 As String = "gray125"
	Public const Pattern_lightDown As String = "lightDown"
	Public const Pattern_lightGray As String = "lightGray"
	Public const Pattern_lightGrid As String = "lightGrid"
	Public const Pattern_lightHorizontal As String = "lightHorizontal"
	Public const Pattern_lightTrellis As String = "lightTrellis"
	Public const Pattern_lightUp As String = "lightUp"
	Public const Pattern_lightVertical As String  = "lightVertical"
	Public const Pattern_mediumGray As String = "mediumGray"
	Public const Pattern_none As String = "none"
	Public const Pattern_solid As String = "solid"
End Sub

'initialize with filename
Public Sub Excel(fileName As String)
	oxml.Initialize("oxml")
	WorkBook = oxml.RunMethod("xlsx", Null) 
	fName = fileName
End Sub

'create a style
Sub CreateStyle As OXMLStyle
	Dim s As OXMLStyle
	s.Initialize
	s.bold = False
	s.italic = False
	s.underline = False
	s.strike = False
	s.fontSize = False
	s.fontColor = ""
	s.fontName= ""
	s.fontFamily = ""
	s.scheme = ""
	s.numberFrmat = ""
	s.bordercolor = ""
	s.hAlignment = ""
	s.vAlignment = ""
	s.FillPattern =""
	s.FillForeColor = ""
	s.FillBackground = ""
	Return s
End Sub

'set style
Sub SetStyle(rc As BANanoObject, Style As OXMLStyle)
	Dim obj As Map = CreateMap()
	If Style.bold Then obj.Put("bold", Style.bold)
	If Style.italic Then obj.Put("italic", Style.italic)
	If Style.underline Then obj.Put("underline", Style.underline)
	If Style.strike Then obj.Put("strike", Style.strike)
	If Style.fontSize Then obj.Put("fontSize", Style.fontSize)
	If Style.fontColor <> "" Then obj.Put("fontColor", Style.fontColor)
	If Style.fontName <> "" Then obj.Put("fontName", Style.fontName)
	If Style.fontFamily <> "" Then obj.Put("fontFamily", Style.fontFamily)
	If Style.scheme <> "" Then obj.Put("scheme", Style.scheme)
	If Style.numberFrmat <> "" Then obj.Put("numberFormat", Style.numberFrmat)
	If Style.vAlignment <> "" Then obj.Put("vAlignment", Style.vAlignment)
	If Style.hAlignment <> "" Then obj.Put("hAlignment", Style.hAlignment)
	If Style.borderColor <> "" Or Style.borderThickness <> "" Then
		Dim border As Map = CreateMap()
		border.Put("color", Style.bordercolor)
		border.Put("style", Style.borderthickness)
		obj.Put("border", border)
	End If
	
	If Style.FillPattern <> "" And Style.FillForeColor <> "" And Style.FillBackground <> "" Then
		Dim fill As Map = CreateMap()
		fill.Put("pattern", Style.FillPattern)
		fill.Put("foreColor", Style.FillForeColor)
		fill.Put("backColor", Style.FillBackground)
		obj.Put("fill", fill)
	End If
	rc.RunMethod("style", Array(obj))
End Sub

'merge a collection of cells
Sub Merge(sheet As BANanoObject, range As String) As BANanoOXML
	sheet.RunMethod("merge", Array(range))
	Return Me
End Sub

'get an existing row, should be already defined
Sub GetRow(sheet As BANanoObject, rowPos As Int, colPos As Int) As BANanoObject
	Dim row As BANanoObject = sheet.RunMethod("row", Array(rowPos, colPos))
	Return row
End Sub

'get an existing column, should be already defined
Sub GetColumn(sheet As BANanoObject, rowPos As Int, colPos As Int) As BANanoObject
	Dim colx As BANanoObject = sheet.RunMethod("column", Array(rowPos, colPos))
	Return colx
End Sub

'get an existing cell, should be already defined
Sub GetCell(sheet As BANanoObject, rowPos As Int, colPos As Int) As BANanoObject
	Dim colx As BANanoObject = sheet.RunMethod("cell", Array(rowPos, colPos))
	Return colx
End Sub

'create a row to add rows
Sub CreateRow(rowPos As Int, colPos As Int) As OXMLRow
	Dim row As OXMLRow
	row.Initialize 
	row.columnIndex = colPos
	row.rowIndex = rowPos
	row.values.Initialize 
	row.style = CreateMap()
	Return row
End Sub

'create a formula cell
private Sub CreateFormula(formula As String) As OXMLCell
	Dim cell As OXMLCell
	cell.Initialize 
	cell.typeOf = "formula"
	cell.formula = formula
	cell.style = CreateMap()
	Return cell
End Sub

'create a string cell
private Sub CreateText(value As String) As OXMLCell
	Dim cell As OXMLCell
	cell.Initialize 
	cell.typeOf = "string"
	cell.value = value
	cell.style = CreateMap()
	Return cell
End Sub

'create a number cell
private Sub CreateNumber(value As String) As OXMLCell
	Dim cell As OXMLCell
	cell.Initialize 
	cell.typeOf = "numeric"
	cell.value = value
	cell.style = CreateMap()
	Return cell
End Sub

'create a sharedText cell
private Sub CreateSharedText(value As String) As OXMLCell
	Dim cell As OXMLCell
	cell.Initialize 
	cell.typeOf = "sharedString"
	cell.value = value
	cell.style = CreateMap()
	Return cell
End Sub

'convert an OXML to an object
private Sub Cell2Map(cell As OXMLCell) As Map
	Dim m As Map = CreateMap()
	m.Put("type", cell.typeOf)
	m.Put("value", cell.value)
	If cell.formula <> "" Then
		m.Put("formula", cell.formula)
	End If
	Return m
End Sub

'add a new workbook
Sub WorkSheet(sheetName As String) As BANanoObject
	Dim wkSheet As BANanoObject
	wkSheet = WorkBook.RunMethod("sheet", Array(sheetName))
	Return wkSheet	
End Sub	

'set row values at a row starting at column
Sub SetRow(sheet As BANanoObject, rowPos As Int, colPos As Int, values As List)
	sheet.RunMethod("row", Array(rowPos, colPos, values))
End Sub

'set column values at a row starting at column
Sub SetColumn(sheet As BANanoObject, rowPos As Int, colPos As Int, values As List)
	sheet.RunMethod("column", Array(rowPos, colPos, values))
End Sub

'set row values based on row banano object
Sub SetRowBO(row As BANanoObject, values As List)
	row.RunMethod("set", values)
End Sub

'set col values based on col banano object
Sub SetColBO(col As BANanoObject, values As List)
	col.RunMethod("set", values)
End Sub

'set row using OXML
Sub SetRow1(sheet As BANanoObject, row As OXMLRow)
	Dim rowPos As Int = row.rowIndex
	Dim colPos As Int = row.columnIndex
	Dim values As List = row.values
	SetRow(sheet, rowPos, colPos, values)  
End Sub

'download the file
Sub Download(module As Object, methodName As String)
	methodName = methodName.tolowercase
	Dim cb As BANanoObject = BANano.CallBack(module, methodName, Null)
	Dim prom As BANanoObject = WorkBook.RunMethod("download", Array(fName))
	prom.RunMethod("then", Array(cb))
End Sub

'set row text
Sub AddRowText(row As OXMLRow, value As String) As BANanoOXML
	Dim cell As Map = Cell2Map(CreateText(value))
	row.values.Add(cell)
	Return Me
End Sub

'set row number
Sub AddRowNumber(row As OXMLRow, value As String) As BANanoOXML
	Dim cell As Map = Cell2Map(CreateNumber(value))
	row.values.Add(cell)
	Return Me
End Sub

'set row shared text
Sub AddRowSharedText(row As OXMLRow, value As String) As BANanoOXML
	Dim cell As Map = Cell2Map(CreateSharedText(value))
	row.values.Add(cell)
	Return Me
End Sub

'set row formula
Sub AddRowFormula(row As OXMLRow, formula As String) As BANanoOXML
	Dim cell As Map = Cell2Map(CreateFormula(formula))
	row.values.Add(cell)
	Return Me
End Sub

'set row formula with value
Sub AddRowFormula1(row As OXMLRow, formula As String, value As String) As BANanoOXML
	Dim cell As OXMLCell = CreateFormula(formula)
	cell.value = value
	Dim cellV As Map = Cell2Map(cell)
	row.values.Add(cellV)
	Return Me
End Sub

'set a string
Sub SetText(sheet As BANanoObject, rowPos As Int, colPos As Int, value As String)
	Dim cell As Map = Cell2Map(CreateText(value))
	sheet.RunMethod("cell", Array(rowPos, colPos)).RunMethod("set", Array(cell))
End Sub

'set a string to existing cell
Sub SetCellText(cellBO As BANanoObject,  value As String)
	Dim cell As Map = Cell2Map(CreateText(value))
	cellBO.RunMethod("set", Array(cell))
End Sub

'set a numeric value
Sub SetCellNumber(cellBO As BANanoObject, value As String)
	Dim cell As Map = Cell2Map(CreateNumber(value))
	cellBO.RunMethod("set", Array(cell))
End Sub

'set a numeric value
Sub SetNumber(sheet As BANanoObject, rowPos As Int, colPos As Int, value As String)
	Dim cell As Map = Cell2Map(CreateNumber(value))
	sheet.RunMethod("cell", Array(rowPos, colPos)).RunMethod("set", Array(cell))
End Sub

'set a shared string
Sub SetCellSharedText(cellBO As BANanoObject, value As String)
	Dim cell As Map = Cell2Map(CreateSharedText(value))
	cellBO.RunMethod("set", Array(cell))
End Sub

'set a shared string
Sub SetSharedText(sheet As BANanoObject, rowPos As Int, colPos As Int, value As String)
	Dim cell As Map = Cell2Map(CreateSharedText(value))
	sheet.RunMethod("cell", Array(rowPos, colPos)).RunMethod("set", Array(cell))
End Sub

'set a formula
Sub SetCellFormula(cellBO As BANanoObject, formula As String)
	Dim cell As Map = Cell2Map(CreateFormula(formula))
	cellBO.RunMethod("set", Array(cell))
End Sub


'set a formula
Sub SetFormula(sheet As BANanoObject, rowPos As Int, colPos As Int, formula As String)
	Dim cell As Map = Cell2Map(CreateFormula(formula))
	sheet.RunMethod("cell", Array(rowPos, colPos)).RunMethod("set", Array(cell))
End Sub

'set a formular with cached result value
Sub SetCellFormula1(cellBO As BANanoObject, formula As String, value As String)
	Dim cell As OXMLCell = CreateFormula(formula)
	cell.value = value
	Dim cellV As Map = Cell2Map(cell)
	cellBO.RunMethod("set", Array(cellV))
End Sub

'set a formular with cached result value
Sub SetFormula1(sheet As BANanoObject, rowPos As Int, colPos As Int, formula As String, value As String)
	Dim cell As OXMLCell = CreateFormula(formula)
	cell.value = value
	Dim cellV As Map = Cell2Map(cell)
	sheet.RunMethod("cell", Array(rowPos, colPos)).RunMethod("set", Array(cellV))
End Sub