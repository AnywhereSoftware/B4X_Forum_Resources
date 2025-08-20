B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Public PoiWorkbook As PoiWorkbook
	Public xl As XLUtils
	Private FromTemplate As Boolean 'ignore
	Public jWorkbook As JavaObject
	Public MaxRows, MaxColumns As Int
	Private mVersionName As String
	Public IsXLSX As Boolean
	Public DefaultFontName As String
	Public DefaultFontSize As Short
	Public DefaultExtension As String
	Public InternalStylesCache As Map
	Public InternalStyleShorts As List = Array("setBottomBorderColor", "setLeftBorderColor", "setRightBorderColor", "setTopBorderColor", "setFillForegroundColor", "setFillBackgroundColor", "setIndention", "setDataFormat", "setRotation")
	Public InternalStyleBooleans As List = Array("setLocked", "setHidden", "setWrapText")
	Public InternalStyleInts As List = Array("setFont")
	Public InternalStyleStrings As List = Array("setBorderBottom", "setBorderLeft", "setBorderRight", "setBorderTop", "setAlignment", "setVerticalAlignment", "setFillPattern")
	Public InternalAllSimpleMethods As List = Array(InternalStyleShorts, InternalStyleBooleans)
	Public InternalNameRegex As String = "[_A-Za-z][_\.A-Za-z0-9]+"
End Sub

'<b>Use XL.CreateWriter instead.</b>
Public Sub Initialize (vXL As XLUtils, vWorkbook As PoiWorkbook, vFromTemplate As Boolean)
	xl = vXL
	PoiWorkbook = vWorkbook
	FromTemplate = vFromTemplate
	jWorkbook = PoiWorkbook
	mVersionName = jWorkbook.RunMethodJO("getSpreadsheetVersion", Null).RunMethod("toString", Null)
	IsXLSX = mVersionName = "EXCEL2007"
	If IsXLSX Then
		MaxRows = 0x100000
		MaxColumns = 0x4000
		DefaultFontName = "Calibri"
		DefaultFontSize = 11
		DefaultExtension = ".xlsx"
	Else
		MaxRows = 0x10000
		MaxColumns = 0x0100
		DefaultFontName = "Arial"
		DefaultFontSize = 10
		DefaultExtension = ".xls"
	End If
	InternalStylesCache.Initialize
End Sub

'Returns EXCEL97 or EXCEL2007
Public Sub getVersionName As String
	Return mVersionName
End Sub

'Saves a copy of the workbook. Returns the saved file name.
'RenameIfNeeded - If true the file will automatically be renamed if saving fails. Saving will fail if the workbook is open in Excel.
Public Sub SaveAs (Dir As String, FileName As String, RenameIfNeeded As Boolean) As String
	If RenameIfNeeded Then
		Dim orig As String = File.Combine(Dir, FileName)
		Dim extension As String
		Dim i As Int = orig.LastIndexOf(".")
		If i >-1 Then
			extension = orig.SubString(i)
			orig = orig.SubString2(0, i)
		End If
		For i = 0 To 10
			Dim f As String
			Try
				If i = 0 Then f = orig & extension Else f = orig & " (" & i & ")" & extension
				PoiWorkbook.Save(f, "")
				Return f
			Catch
				Log("Failed: " & f)
			End Try
		Next
	End If
	PoiWorkbook.Save(Dir, FileName)
	Return File.Combine(Dir, FileName)
End Sub

'Creates a XLSheetWriter for the given sheet. A new sheet will be created if it doesn't exist.
Public Sub CreateSheetWriterByName (SheetName As String) As XLSheetWriter
	Dim sheet As PoiSheet = PoiWorkbook.GetSheetByName(SheetName)
	If sheet.IsInitialized = False Then
		sheet = PoiWorkbook.AddSheet(SheetName, PoiWorkbook.NumberOfSheets)
	End If
	Dim writer As XLSheetWriter
	writer.Initialize(xl, Me, sheet)
	Return writer
End Sub

'Creates a XLSheetWriter for the given sheet.
Public Sub CreateSheetWriterByIndex (SheetIndex As Int) As XLSheetWriter
	Dim Sheet As PoiSheet = PoiWorkbook.GetSheet(SheetIndex)
	Dim writer As XLSheetWriter
	writer.Initialize(xl, Me, Sheet)
	Return writer
End Sub

'Clones a sheet. Note that complex objects such as charts are not supported and will lead to a corrupt workbook.
Public Sub CloneSheet (Sheet As XLSheetWriter, NewSheetName As String) As XLSheetWriter
	Dim NewPoiSheet As PoiSheet = jWorkbook.RunMethod("cloneSheet", Array(Sheet.PoiSheet.Index))
	NewPoiSheet.Name = NewSheetName
	Dim writer As XLSheetWriter
	writer.Initialize(xl, Me, NewPoiSheet)
	Return writer
End Sub

'Gets or creates a PoiFont. Can be used with XLStyle.
Public Sub GetFont (Size As Short, Bold As Boolean, Name As String, Italic As Boolean, Underline As Boolean, IndexedColor As Int) As PoiFont
	For Each f As PoiFont In PoiWorkbook.Fonts
		If f.Size = Size And f.Bold = Bold And f.Name = Name And f.Italic = Italic And f.Underline = Underline And f.IndexedColor = IndexedColor Then
			Return f
		End If
	Next
	Dim f As PoiFont
	f.Initialize(PoiWorkbook)
	f.Size = Size
	f.Bold = Bold
	f.Name = Name
	f.Italic = Italic
	f.Underline = Underline
	f.IndexedColor = IndexedColor
	Return f
End Sub

'Creates a new empty XLStyle.
Public Sub CreateStyle As XLStyle
	Dim style As XLStyle
	style.Initialize (Me)
	Return style
End Sub

'Evaluates all formulas in the workbook and store the result in the cells cache.
Public Sub EvaluateFormulas
	jWorkbook.RunMethodJO("getCreationHelper", Null).RunMethodJO("createFormulaEvaluator", Null).RunMethod("evaluateAll", Null)
End Sub

'Gets or sets the active sheet - the sheet that will be active when the workbook is opened.
Public Sub getActiveSheetIndex As Int
	Return jWorkbook.RunMethod("getActiveSheetIndex", Null)
End Sub

Public Sub setActiveSheetIndex (i As Int)
	For ii = 0 To PoiWorkbook.NumberOfSheets - 1
		Dim jo As JavaObject = PoiWorkbook.GetSheet(ii)
		jo.RunMethod("setSelected", Array(False))
	Next
	jWorkbook.RunMethod("setActiveSheet", Array(i))
End Sub

'Adds a global named range. Range.Sheet must hold a valid sheet.
'This call will first remove existing ranges with the same name.
Public Sub AddNamedRange (Name As String, Range As XLRange) As JavaObject
	RemoveNamedRange(Name)
	If Range.Sheet.IsInitialized = False Then
		LogError("Range.Sheet must me set. Use xl.CreateXLRangeWithSheet!")
	End If
	Dim CellRangeAddress As JavaObject = xl.XLRangeToCellRangeAddress(Range)
	Dim jname As JavaObject = CreateName(Name, CellRangeAddress.RunMethod("formatAsString", Array(Range.Sheet.Name, True)))
	Return jname
End Sub

Private Sub CreateName (Name As String, Formula As String) As JavaObject
	Dim jname As JavaObject = jWorkbook.RunMethod("createName", Null)
	jname.RunMethod("setNameName", Array(Name))
	jname.RunMethod("setRefersToFormula", Array(Formula))
	Return jname
End Sub

'Adds a sheet scoped named range. Range.Sheet must hold a valid sheet.
Public Sub AddNamedRangeScoped (Name As String, Range As XLRange)
	Dim jName As JavaObject = AddNamedRange(Name, Range)
	jName.RunMethod("setSheetIndex", Array(Range.Sheet.Index))
End Sub

'Adds a global dynamic named range. It can be used to create templates.
Public Sub AddNamedRangeOffset (Name As String, Range As XLRange)
	RemoveNamedRange(Name)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("OFFSET(").Append(xl.XLAddressToCellReference(Range.Sheet.Name, Range.FirstAddress).RunMethod("formatAsString", Null))
	sb.Append(", 0, 0, ").Append(Range.SecondAddress.Row0Based - Range.FirstAddress.Row0Based + 1).Append(", ")
	sb.Append(Range.SecondAddress.Col0Based - Range.FirstAddress.Col0Based + 1).Append(")")
	CreateName(Name, sb.ToString)
End Sub

'Removes all named ranges with the matching name.
Public Sub RemoveNamedRange (Name As String)
	Dim Names As List = jWorkbook.RunMethod("getNames", Array(Name))
	Dim DontModifyListWhileRemoving As List
	DontModifyListWhileRemoving.Initialize
	DontModifyListWhileRemoving.AddAll(Names)
	For Each n As Object In DontModifyListWhileRemoving
		jWorkbook.RunMethod("removeName", Array(n))
	Next
End Sub
'Removes the sheet at the given 0 based index.
Public Sub RemoveSheetAt (Index As Int)
	jWorkbook.RunMethod("removeSheetAt", Array(Index))
End Sub

'Gets or sets whether Excel will recalculate all formulas when the workbook is opened.
Public Sub getForceFormulaRecalculation As Boolean
	Return jWorkbook.RunMethod("getForceFormulaRecalculation", Null)
End Sub

Public Sub setForceFormulaRecalculation (b As Boolean)
	jWorkbook.RunMethod("setForceFormulaRecalculation", Array(b))
End Sub






