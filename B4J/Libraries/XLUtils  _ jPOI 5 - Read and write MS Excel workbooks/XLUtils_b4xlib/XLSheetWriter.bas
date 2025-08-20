B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Public PoiSheet As PoiSheet
	Public xl As XLUtils
	
	Public LastAccessed As XLAddress
	Private jsheet As JavaObject
	Public Workbook As XLWorkbookWriter
End Sub

'<b>Don't call. Use Writer.CreateSheetWriter instead.</b>
Public Sub Initialize (vxl As XLUtils, vWorkbookWriter As XLWorkbookWriter, vSheet As PoiSheet)
	PoiSheet = vSheet
	xl = vxl
	Workbook = vWorkbookWriter
	jsheet = PoiSheet
End Sub

'Puts a number in the given cell address.
Public Sub PutNumber (Address As XLAddress, Value As Double) As XLSheetWriter
	GetCell(Address).ValueNumeric = Value
	Return Me
End Sub
'Puts a string in the given cell address.
Public Sub PutString (Address As XLAddress, Value As String) As XLSheetWriter
	GetCell(Address).ValueString = Value
	Return Me
End Sub
'Puts a date (ticks) in the given cell address.
Public Sub PutDate (Address As XLAddress, Value As Long) As XLSheetWriter
	GetCell(Address).ValueDate = Value
	Return Me
End Sub
'Puts a formula in the given cell address.
Public Sub PutFormula (Address As XLAddress, Value As String) As XLSheetWriter
	If Value.StartsWith("=") Then Value = Value.SubString(1)
	GetCell(Address).ValueFormula = Value
	Return Me
End Sub

'Sets the cell style. Existing style properties will be replaced.
Public Sub SetStyle (Address As XLAddress, Style As XLStyle) As XLSheetWriter
	Dim cell As PoiCell = GetCell(Address)
	ApplyStyle(cell, False, Style.StyleMap)
	Return Me
End Sub

'Keeps the existing cell style and adds the given style properties.
Public Sub AddStyle (Address As XLAddress, Style As XLStyle) As XLSheetWriter
	Dim cell As PoiCell = GetCell(Address)
	ApplyStyle(cell, True, Style.StyleMap)
	Return Me
End Sub

'Sets multiple styles.
Public Sub SetStyles (Address As XLAddress, Styles As List) As XLSheetWriter
	Dim cell As PoiCell = GetCell(Address)
	ApplyStyle(cell, False, MergeStyles(Styles))
	Return Me
End Sub

'Adds multiple styles.
Public Sub AddStyles (Address As XLAddress, Styles As List) As XLSheetWriter
	Dim cell As PoiCell = GetCell(Address)
	ApplyStyle(cell, True, MergeStyles(Styles))
	Return Me
End Sub

Private Sub MergeStyles (Styles As List) As Map
	Dim NewProps As Map
	NewProps.Initialize
	For Each style As XLStyle In Styles
		For Each key As String In style.StyleMap.Keys
			NewProps.Put(key, style.StyleMap.Get(key))
		Next
	Next
	Return NewProps
End Sub

'Sets multiple styles to cells in the range.
Public Sub SetStylesToRange (Range As XLRange, Styles As List) As XLSheetWriter
	Return InternalSetStylesToRange(Range, Styles, False)
End Sub

'Adds multiple styles to cells in the range.
Public Sub AddStylesToRange (Range As XLRange, Styles As List) As XLSheetWriter
	Return InternalSetStylesToRange(Range, Styles, True)
End Sub

Private Sub InternalSetStylesToRange (Range As XLRange, Styles As List, Add As Boolean) As XLSheetWriter
	Dim props As Map = MergeStyles(Styles)
	For col = Range.FirstAddress.Col0Based To Range.SecondAddress.Col0Based
		For row = Range.FirstAddress.Row0Based To Range.SecondAddress.Row0Based
			Dim cell As PoiCell = GetCell(xl.AddressZero(col, row))
			ApplyStyle(cell, Add, props)
		Next
	Next
	Return Me
End Sub

'Adds a merged region.
Public Sub AddMergedRegion (Range As XLRange) As XLSheetWriter
	Dim jo As JavaObject = PoiSheet
	jo.RunMethod("addMergedRegion", Array(xl.XLRangeToCellRangeAddress(Range)))
	Return Me
End Sub


Public Sub GetCell (Address As XLAddress) As PoiCell
	Dim row As PoiRow = GetRow(Address)
	Dim Cell As PoiCell = row.GetCell(Address.Col0Based)
	If Cell.IsInitialized = False Then
		Cell = row.CreateCellBlank(Address.Col0Based)
	End If
	LastAccessed = Address
	Return Cell
End Sub

Public Sub GetRow (Address As XLAddress) As PoiRow
	Dim row As PoiRow = PoiSheet.GetRow(Address.Row0Based)
	If row.IsInitialized = False Then
		row = PoiSheet.CreateRow(Address.Row0Based)
	End If
	Return row
End Sub

'Shifts the rows. ShiftAmount can be negative to shift upwards.
Public Sub ShiftRows (StartRow0Based As Int, EndRow0Based As Int, ShiftAmount As Int) As XLSheetWriter
	jsheet.RunMethod("shiftRows", Array(StartRow0Based, EndRow0Based, ShiftAmount))
	Return Me
End Sub

'Shifts the columns. ShiftAmount can be negative to shift left.
Public Sub ShiftColumns (StartColumn0Based As Int, EndColumn0Based As Int, ShiftAmount As Int) As XLSheetWriter
	jsheet.RunMethod("shiftColumns", Array(StartColumn0Based, EndColumn0Based, ShiftAmount))
	Return Me
End Sub

'Auto sizes the column based on the content. Uses the cached values for formula cells.
'You can call WorkbookWriter.EvaluateFormulas to make sure that the cached values are available.
Public Sub AutoSizeColumn (Column0Based As Int) As XLSheetWriter
	jsheet.RunMethod("autoSizeColumn", Array(Column0Based))
	Return Me
End Sub

'Creates a freeze pane with.
'Pass (0, 0) to remove the freeze pane.
Public Sub CreateFreezePane (NumberOfColumns As Int, NumberOfRows As Int) As XLSheetWriter
	jsheet.RunMethod("createFreezePane", Array(NumberOfColumns, NumberOfRows))
	Return Me
End Sub

'Gets or sets the active cell. Returns an uninitialized address if there is no active cell.
Public Sub getActiveCell As XLAddress
	Dim res As XLAddress
	Dim celladdress As JavaObject = jsheet.RunMethod("getActiveCell", Null)
	If celladdress.IsInitialized = False Then Return res
	Return xl.AddressZero(celladdress.RunMethod("getColumn", Null), celladdress.RunMethod("getRow", Null))
End Sub

Public Sub setActiveCell (Address As XLAddress)
	Dim celladdress As JavaObject
	celladdress.InitializeNewInstance("org.apache.poi.ss.util.CellAddress", Array(Address.Row0Based, Address.Col0Based))
	jsheet.RunMethod("setActiveCell", Array(celladdress))
End Sub

'Adds automatic filters.
Public Sub SetAutoFilter (Range As XLRange) As XLSheetWriter
	Dim c As Object = xl.XLRangeToCellRangeAddress(Range)
	jsheet.RunMethod("setAutoFilter", Array(c))
	Return Me
End Sub

'Adds a hyperlink to the cell.
'HyperlinkType - URL, DOCUMENT - place in this document, EMAIL or FILE.
'URL - should be URL encoded if contains spaces and other characters that need to be escaped.
Public Sub CreateHyperlink (Address As XLAddress, HyperlinkType As String, URL As String) As XLSheetWriter
	Dim link As JavaObject = Workbook.jWorkbook.RunMethodJO("getCreationHelper", Null).RunMethod("createHyperlink", Array(HyperlinkType))
	link.RunMethod("setAddress", Array(URL))
	Dim jcell As JavaObject = GetCell(Address)
	jcell.RunMethod("setHyperlink", Array(link))
	Return Me
End Sub

'Creates an outline for the provided columns range.
Public Sub GroupColumns (FromColumn0 As Int, ToColumn0 As Int, Collapse As Boolean) As XLSheetWriter
	jsheet.RunMethod("groupColumn", Array (FromColumn0, ToColumn0))
	If Collapse Then jsheet.RunMethod("setColumnGroupCollapsed", Array(FromColumn0, Collapse))
	Return Me
End Sub
'Creates an outline for the provided rows range.
Public Sub GroupRows (FromRow0 As Int, ToRow0 As Int, Collapse As Boolean) As XLSheetWriter
	jsheet.RunMethod("groupRow", Array(FromRow0, ToRow0))
	If Collapse Then jsheet.RunMethod("setRowGroupCollapsed", Array(FromRow0, Collapse))
	Return Me
	
End Sub
'Ungroups a range of columns.
Public Sub UngroupColumns (FromColumn0 As Int, ToColumn0 As Int) As XLSheetWriter
	jsheet.RunMethod("ungroupColumn", Array (FromColumn0, ToColumn0))
	Return Me
End Sub
'Ungroups a range of rows.
Public Sub UngroupRows (FromRow0 As Int, ToRow0 As Int) As XLSheetWriter
	jsheet.RunMethod("ungroupRow", Array(FromRow0, ToRow0))
	Return Me
End Sub

'Creates a conditional formatting rule. You should set its style modifiers and call XLSheetWriter.AddConditionalFormatting.
'Formula - A boolean formula that will be evaluated against each cell in the set range.
Public Sub CreateConditionalFormattingRule(Formula As String) As XLConditionalFormattingRule
	Dim x As XLConditionalFormattingRule
	Dim m As JavaObject = Me
	x.Initialize(m.RunMethod("createConditionalFormattingRule", Array(GetSheetConditionalFormatting, Formula)))
	Return x
End Sub

#if Java
import org.apache.poi.ss.usermodel.*;
public Object createConditionalFormattingRule (SheetConditionalFormatting s, String formula) {
	return s.createConditionalFormattingRule(formula);
}
#End If


Private Sub GetSheetConditionalFormatting As JavaObject
	Return jsheet.RunMethod("getSheetConditionalFormatting", Null)
End Sub

'Adds one or more conditional formatting rules to the specified range.
Public Sub AddConditionalFormatting (Range As XLRange, Rules As List) As XLSheetWriter
	Dim jrules(Rules.Size) As Object
	For i = 0 To Rules.Size - 1
		Dim r As XLConditionalFormattingRule = Rules.Get(i)
		jrules(i) = r.jRule
	Next
	Dim cfrules As JavaObject
	cfrules.InitializeArray("org.apache.poi.ss.usermodel.ConditionalFormattingRule", jrules)
	Dim Regions As JavaObject
	Regions.InitializeArray("org.apache.poi.ss.util.CellRangeAddress", Array(xl.XLRangeToCellRangeAddress(Range)))
	GetSheetConditionalFormatting.RunMethod("addConditionalFormatting", Array(Regions, cfrules))
	Return Me
End Sub

'Creates a new table. Only XLSX workbooks support this feature.
'Range - table range, including headers and total rows.
'TableName - table name. Must be a unique and valid name.
'StyleName - One of the following case sensitive values: TableStyleDark1 - 11, TableStyleLight1 - 21, TableStyleMedium1 - 28
Public Sub CreateTable (Range As XLRange, TableName As String, StyleName As String) As XLTable
	If Workbook.IsXLSX = False Then
		Log("Tables are supported in XLSX only.")
		Return Null
	End If
	If ValidateTableName(TableName) = False Then Return Null
	Range.Sheet = PoiSheet
	Dim AreaReference As JavaObject = xl.XLRangeToAreaReference(Workbook, Range)
	Dim Table As JavaObject = jsheet.RunMethod("createTable", Array(AreaReference))
	Table.RunMethod("setName", Array(TableName))
	Table.RunMethod("setStyleName", Array(StyleName))
	Dim t As XLTable
	t.Initialize(Table, Me)
	Return t
End Sub

'(XLSX only) Returns all tables in the sheet.
Public Sub GetTables As List
	Dim t As List = jsheet.RunMethod("getTables", Null)
	Dim res As List
	res.Initialize
	For Each j As Object In t
		Dim table As XLTable
		table.Initialize(j, Me)
		res.Add(table)
	Next
	Return res
End Sub

'Removes a table.
Public Sub RemoveTable (Table As XLTable)
	jsheet.RunMethod("removeTable", Array(Table))
End Sub

Public Sub ValidateTableName (Name As String) As Boolean
	If Regex.IsMatch(Workbook.InternalNameRegex, Name) = False Then
		LogError("Invalid name: " & Name)
		Return False
	End If
	Return True
End Sub

Private Sub ApplyStyle (Cell As PoiCell, Add As Boolean, StyleMap As Map)
	Dim props As Map
	If Add = False Then
		props = StyleMap
	Else
		props.Initialize
		FillStyleFromCell(props, Cell.CellStyle)
		For Each key As String In StyleMap.Keys
			props.Put(key, StyleMap.Get(key))
		Next
	End If
	Cell.CellStyle = CreateStyle(props)
End Sub

Private Sub FillStyleFromCell (props As Map, CellStyle As PoiCellStyle)
	Dim jStyle As JavaObject = CellStyle
	For Each methods As List In Workbook.InternalAllSimpleMethods
		For Each method As String In methods
			props.Put(method, jStyle.RunMethod("g" & method.SubString(1), Null))
		Next
	Next
	props.Put("setFont", jStyle.RunMethod("getFontIndex", Null))
	For Each method As String In Workbook.InternalStyleStrings
		props.Put(method, jStyle.RunMethodJO("g" & method.SubString(1), Null).RunMethod("toString", Null))
	Next
End Sub

Private Sub CreateStyle (props As Map) As PoiCellStyle
	Dim style As PoiCellStyle = CheckIfStyleExists (props)
	If style.IsInitialized = False Then
		style.Initialize(Workbook.PoiWorkbook)
		Workbook.InternalStylesCache.Put(props, style)
		Dim jstyle As JavaObject = style
		For Each key As String In props.Keys
			If key = "setFont" Then
				jstyle.RunMethod(key, Array(Workbook.jWorkbook.RunMethod("getFontAt", Array(props.Get(key)))))
			Else
				jstyle.RunMethod(key, Array(props.Get(key)))
			End If
		Next
	End If
	Return style
End Sub

Private Sub CheckIfStyleExists (props As Map) As PoiCellStyle
	Dim empty As PoiCellStyle
	For Each m As Map In Workbook.InternalStylesCache.Keys
		If IsMapTheSameAsProps(m, props) Then
			Return Workbook.InternalStylesCache.Get(m)
		End If
	Next
	Return empty
End Sub

Private Sub IsMapTheSameAsProps (m As Map, Props As Map) As Boolean
	If m.Size = Props.Size Then
		For Each key As String In Props.Keys
			If m.ContainsKey(key) = False Then Return False
		Next
		For Each key As String In Workbook.InternalStyleInts
			If Props.ContainsKey(key) Then
				Dim i As Int = Props.Get(key)
				If i <> m.Get(key) Then
					Return False
				End If
			End If
		Next
		For Each key As String In Workbook.InternalStyleBooleans
			If Props.ContainsKey(key) Then
				Dim b As Boolean = Props.Get(key)
				If b <> m.Get(key) Then
					Return False
				End If
			End If
		Next
		For Each key As String In Workbook.InternalStyleShorts
			If Props.ContainsKey(key) Then
				Dim s As Short = Props.Get(key)
				If s <> m.Get(key) Then
					Return False
				End If
			End If
		Next
		For Each key As String In Workbook.InternalStyleStrings
			If Props.ContainsKey(key) Then
				Dim t As String = Props.Get(key)
				If t <> m.Get(key) Then
					Return False
				End If
			End If
		Next
		Return True
	End If
	Return False
End Sub

'Gets or sets the sheet's print area. Returns an uninitialized XLRange if a print area wasn't set.
Public Sub setPrintArea(Range As XLRange)
	Workbook.jWorkbook.RunMethod("setPrintArea", Array(PoiSheet.Index, Range.FirstAddress.Col0Based, Range.SecondAddress.Col0Based, _
		Range.FirstAddress.Row0Based, Range.SecondAddress.Row0Based))
End Sub

Public Sub getPrintArea As XLRange
	Dim ref As Object = Workbook.jWorkbook.RunMethod("getPrintArea", Array(PoiSheet.Index))
	If ref = Null Then
		Dim res As XLRange
		 Return res
	End If
	Return xl.RangeStringOrNameToRange(Workbook.PoiWorkbook, ref)
End Sub

'Sets the page printing scale.
'PagesWide - Set the scale to fit this number of pages wide, or 0 for no scaling.
'PagesTall - Set the scale to fit this number of pages tall, or 0 for no scaling.
Public Sub SetFitToPage (PagesWide As Short, PagesTall As Short) As XLSheetWriter
	jsheet.RunMethod("setFitToPage", Array(True))
	Dim ps As JavaObject = getPrintSetup
	ps.RunMethod("setFitWidth", Array(PagesWide))
	ps.RunMethod("setFitHeight", Array(PagesTall))
	Return Me
End Sub

'Returns the native PrintSetup object.
Public Sub getPrintSetup As JavaObject
	Return jsheet.RunMethod("getPrintSetup", Null)
End Sub




