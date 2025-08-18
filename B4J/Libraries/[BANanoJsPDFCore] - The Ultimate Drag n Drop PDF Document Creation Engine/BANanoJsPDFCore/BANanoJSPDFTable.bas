B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public rows As List
	Public columns As List
	Public head As List
	Private ocolumns As Map
	Private StylesM As Map
	Private ColumnStylesM As Map
	Private MarginM As Map
	Public Theme As String
	Private HeaderStylesM As Map
	Private BodyStylesM As Map
	Private alternateRowStylesM As Map
	Public StartY As Object
	Public PageBreak As String
	Public TableWidth As String
	Private mCallBack As Object
	Public options As Map
	Public CONST THEME_STRIPED As String = "striped"
	Public CONST THEME_GRID As String = "grid"
	Public CONST THEME_PLAIN As String = "plain"
	Public CONST THEME_CSS As String = "css"
	Public CONST PAGE_BREAK_AUTO As String = "auto"
	Public CONST PAGE_BREAK_AVOID As String = "avoid"
	Public CONST PAGE_BREAK_ALWAYS As String = "always"
	Private mtableLineColor As List
	Private mtableLineWidth As Double
	Private BANano As BANano 'ignore
	Type styleDef (font As String, lineWidth As Double, lineColor As List, fillColor As List, fontSize As Int, _
	cellPadding As Int, fontStyle As String,overflow As String, textColor As List, halign As String, valign As String, _
	fillStyle As String, rowHeight As Int, minCellWidth As Int, minCellHeight As Int, cellWidth As String)
	Public styles As styleDef
	Public headerStyles As styleDef
	Public alternateRowStyles As styleDef
	Public bodyStyles As styleDef
	Type MarginObj(top As Int, bottom As Int, left As Int, right As Int, width As Int)
	Public Margin As MarginObj
	Type CellDef(content As String, rowSpan As Int, colSpan As Int, styles As styleDef)
	Private headRows As Map
	Private footRows As Map
	Private FooterStyleM As Map
	Public footerStyles As styleDef
	Private ColumnAlign As Map
End Sub

'initialize the autoTable
Public Sub Initialize(eventHandler As Object)
	mCallBack = eventHandler
	options.Initialize 
	StylesM.Initialize 
	ColumnStylesM.Initialize 
	Margin.Initialize
	Margin.top = 0
	Margin.left = 0
	Margin.width = 0
	Margin.bottom = 0
	Margin.right = 0 
	Theme = ""
	HeaderStylesM.Initialize 
	BodyStylesM.Initialize 
	StartY = False
	PageBreak = "auto"
	TableWidth = "auto"
	mtableLineColor.Initialize
	alternateRowStylesM.Initialize 
	
	styles = NewStyleDef
	headerStyles = NewStyleDef
	alternateRowStyles = NewStyleDef
	bodyStyles = NewStyleDef
	footerStyles = NewStyleDef
	headRows.Initialize 
	footRows.Initialize 
	head.Initialize 
	FooterStyleM.Initialize 
	ColumnAlign.Initialize
	rows.Initialize 
	columns.Initialize
	Dim table As Object
	didParseCell(Me, "didParseCellInternal", table) 
End Sub

'initialize the style
Sub NewStyleDef As styleDef
	Dim stylesx As styleDef
	stylesx.Initialize 
	stylesx.font = "helvetica"
	stylesx.linewidth = 0
	stylesx.lineColor.Initialize 
	stylesx.fillColor.Initialize 
	stylesx.fontSize = 10
	stylesx.cellPadding = 10
	stylesx.fontStyle = "normal"
	stylesx.overflow = "normal"
	stylesx.textColor.Initialize 
	stylesx.halign = "left"
	stylesx.valign = "top"
	stylesx.fillStyle = ""
	stylesx.rowHeight = 0
	stylesx.minCellWidth = 10
	stylesx.minCellHeight = 0
	stylesx.cellWidth = ""
	Return stylesx
End Sub

'will right align columns
private Sub didParseCellInternal(table As Map)
	AlignHeaders(table)
End Sub

'add a column style
Sub addColumnStyle(colName As String, style As styleDef)
	Dim cm As Map = CreateMap()
	CopyStyles(style, cm)
	ColumnStylesM.Put(colName, cm) 
	'get the column title that should be right aligned
	If headRows.ContainsKey(colName) Then
		Dim tit As String = headRows.Get(colName)
		ColumnAlign.Put(tit, style)
	End If
End Sub

'right align the table columns
Sub AlignHeaders(table As Map)
	'get the section
	Dim ssection As String = table.Get("section")
	If ssection <> "head" Then Return
	'we want to align the column header
	Dim cellM As Map = table.Get("cell")
	Dim raw As String = cellM.Get("raw")
	Dim mstyles As Map = cellM.Get("styles")
	If ColumnAlign.ContainsKey(raw) Then
		Dim hstyle As styleDef = ColumnAlign.Get(raw)
		mstyles.Put("halign", hstyle.halign)
		mstyles.Put("valign", hstyle.valign)	
	End If
End Sub

'set the text color
Sub setTextColor(s As styleDef, r As Int, g As Int, b As Int)
	s.textColor.Add(r)
	s.textColor.Add(g)
	s.textColor.Add(b)
End Sub

'set the style line color
Sub setLineColor(s As styleDef, r As Int, g As Int, b As Int)
	s.lineColor.Add(r)
	s.lineColor.Add(g)
	s.lineColor.Add(b)
End Sub

'set style fill color
Sub setFillColor(s As styleDef, r As Int, g As Int, b As Int)
	s.fillColor.Add(r)
	s.fillColor.Add(g)
	S.fillColor.Add(b)
End Sub

'set table line width
Sub setTableLineWidth(t As Double)
	mtableLineWidth = t
	options.Put("tableLineWidth", mtableLineWidth)
End Sub

'set table line color
Sub TableLineColor(r As Int, g As Int, b As Int)
	mtableLineColor.AddAll(Array As Int(r, g, b))
	options.Put("tableLineColor", mtableLineColor)
End Sub

'set rows from a data-table
Sub SetRows(xrows As List)
	rows = xrows
End Sub

'set rows from data-table
Sub SetRowsFromDataTable(xRows As List)
	rows = xRows
End Sub

'set columns
Sub SetColumns(xcolumns As List)
	columns = xcolumns
End Sub

'add a column
Sub addColumn(fld As String, title As String)
	Dim nc As Map = CreateMap()
	nc.Put("header", title)
	nc.Put("dataKey", fld)
	columns.Add(nc)
	headRows.Put(fld, title)
End Sub

'add a row
Sub addRow(row As Map)
	rows.Add(row)
End Sub

'event on didDrawPage
Sub didDrawPage(Module As Object, methodName As String, data As Object)
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(data))
	options.Put("didDrawPage", cb)
End Sub
'
'event on didParseCell 
Sub didParseCell(Module As Object, methodName As String, table As Object)
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(table))
	options.Put("didParseCell", cb)
End Sub
'	
'event on willDrawCell	
Sub willDrawCell(Module As Object, methodName As String, cell As Object, data As Object)
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(cell, data))
	options.Put("willDrawCell", cb)
End Sub	
'
'event on didDrawCell
Sub didDrawCell(Module As Object, methodName As String, row As Object, data As Object)
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(row, data))
	options.Put("didDrawCell", cb)
End Sub	

'event on beforePageContent
Sub beforePageContent(Module As Object, methodName As String, data As Object)
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(data))
	options.Put("beforePageContent", cb)
End Sub	

'event on afterPageContent
Sub afterPageContent(Module As Object, methodName As String, data As Object)
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(data))
	options.Put("afterPageContent", cb)
End Sub	

private Sub CopyStyles(source As styleDef, target As Map)
	If source.font <> "" Then 
		target.Put("font", source.font)
	End If
	If source.linewidth <> 0 Then 
		target.Put("lineWidth", source.lineWidth)
	End If
	If source.lineColor.Size > 0 Then 
		target.Put("lineColor", source.lineColor)
	End If
	If source.fontSize <> 0 Then
		target.Put("fontSize", source.fontSize)
	End If
	If source.fillColor.Size > 0 Then
		target.Put("fillColor", source.fillColor)
	End If
	If source.cellPadding <> 0 Then
		target.Put("cellPadding", source.cellPadding)
	End If
	If source.cellWidth <> "" Then
		target.Put("cellWidth", source.cellWidth)
	End If
	If source.rowHeight <> 0 Then
		target.Put("rowHeight", source.rowHeight)
	End If
	If source.fontStyle <> "" Then 
		target.Put("fontStyle", source.fontStyle)
	End If
	If source.overflow <> "" Then 
		target.Put("overflow", source.overflow)
	End If
	If source.halign <> "" Then 
		target.Put("halign", source.halign)
	End If
	If source.valign <> "" Then 
		target.Put("valign", source.valign)
	End If
	If source.fillStyle <> "" Then 
		target.Put("fillStyle", source.fillStyle)
	End If
	If source.textColor.Size > 0 Then
		target.Put("textColor", source.textColor)
	End If
	target.Put("minCellWidth", source.minCellWidth)
	target.Put("minCellHeight", source.minCellHeight)
End Sub

'set head
Sub setHead(heads As List)
	options.Put("head", heads)
End Sub

'set foot
Sub setFoot(foots As List)
	options.Put("foot", foots)
End Sub

'set body
Sub setBody(body As List)
	options.Put("body", body)
End Sub

'use CSS
Sub useCss(b As Boolean)
	options.Put("useCss", b)
End Sub

'set padding
Sub setPadding(p As Object)
	options.Put("padding", p)
End Sub

'set font size
Sub setFontSize(fs As Object)
	options.Put("fontSize", fs)
End Sub

'set line height
Sub setlineHeight(lh As Object)
	options.Put("lineHeight", lh)
End Sub

'set row page break
Sub setrowPageBreak(rpb As String)
	options.Put("rowPageBreak", rpb)
End Sub

'set show head
Sub setshowHead(sh As String)
	options.Put("showHead", sh)
End Sub

'set horizontalPageBreakRepeat
Sub sethorizontalPageBreakRepeat(v As Object)
	options.Put("horizontalPageBreakRepeat", v)
End Sub

'set horizontalPageBreak
Sub sethorizontalPageBreak(v As Boolean)
	options.Put("horizontalPageBreak", v)
End Sub

'set show foot
Sub setshowFoot(sf As String)
	options.Put("showFoot", sf)
End Sub

'do not all this directly
Sub BuildOptions
	If columns.Size = 0 Or rows.Size = 0 Then Return
	'
	head.Add(headRows)
	'
	options.Put("head", head)
	options.Put("columns", columns)
	options.Put("body", rows)
	If Theme <> "" Then 
		options.Put("theme", Theme)
	End If
	'*** STYLES
	CopyStyles(styles, StylesM)
	If StylesM.Size > 0 Then 
		options.Put("styles", StylesM)
	End If
	'
	'*** HEADER STYLES
	CopyStyles(headerStyles, HeaderStylesM)
	If HeaderStylesM.Size > 0 Then
		options.put("headStyles", HeaderStylesM)
	End If
	'
	'** ALTERNATE STYLES
	CopyStyles(alternateRowStyles, alternateRowStylesM)
	If alternateRowStylesM.Size > 0 Then
		options.Put("alternateRowStyles", alternateRowStylesM)
	End If
	'
	'*** BODY STYLES
	CopyStyles(bodyStyles, BodyStylesM)
	If BodyStylesM.Size > 0 Then
		options.Put("bodyStyles", BodyStylesM)
	End If
	'
	'COLUMN STYLES
	If ColumnStylesM.Size > 0 Then
		options.Put("columnStyles", ColumnStylesM)
	End If
	
	'footer styles
	CopyStyles(footerStyles, FooterStyleM)
	If FooterStyleM.Size > 0 Then
		options.Put("footStyles", FooterStyleM)
	End If
	'
	CopyMargin(Margin, MarginM)
	If MarginM.Size > 0 Then
		options.put("margin", MarginM)
	End If
	'
	options.Put("startY", StartY)
	options.Put("pageBreak", PageBreak)
	options.Put("tableWidth", TableWidth)
End Sub

'copy margins
private Sub CopyMargin(source As MarginObj, target As Map)
	If source.top <> 0 Then 
		target.Put("top", source.top)
	End If
	If source.left <> 0 Then 
		target.Put("left", source.left)
	End If
	If source.right <> 0 Then 
		target.Put("right", source.right)
	End If
	If source.bottom <> 0 Then 
		target.Put("bottom", source.bottom)
	End If
	If source.width <> 0 Then 
		target.Put("width", source.width)
	End If
End Sub

Sub SetBorders(width As Int, r As Int, g As Int, b As Int)
	setTableLineWidth(width)
	TableLineColor(r, g, b)
	styles.lineColor.Add(r)
	styles.lineColor.Add(g)
	styles.lineColor.Add(b)
	styles.lineWidth = width
	bodyStyles.lineColor.Add(r)
	bodyStyles.lineColor.Add(g)
	bodyStyles.lineColor.Add(b)
	bodyStyles.lineWidth = width
End Sub