B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Public Reader As XLReader
	Type XLAddress (Col0Based As Int, Row0Based As Int)
	Type XLRange (Sheet As PoiSheet, FirstAddress As XLAddress, SecondAddress As XLAddress, Name As String)
	Public CreateWriterPassword As String
	Public COLOR_BLACK = 8 As Short
	Public COLOR_WHITE = 9 As Short
	Public COLOR_RED = 10 As Short
	Public COLOR_BRIGHT_GREEN = 11 As Short
	Public COLOR_BLUE = 12 As Short
	Public COLOR_YELLOW = 13 As Short
	Public COLOR_PINK = 14 As Short
	Public COLOR_TURQUOISE = 15 As Short
	Public COLOR_DARK_RED = 16 As Short
	Public COLOR_GREEN = 17 As Short
	Public COLOR_DARK_BLUE = 18 As Short
	Public COLOR_DARK_YELLOW = 19 As Short
	Public COLOR_VIOLET = 20 As Short
	Public COLOR_TEAL = 21 As Short
	Public COLOR_GREY_25_PERCENT = 22 As Short
	Public COLOR_GREY_50_PERCENT = 23 As Short
	Public COLOR_CORNFLOWER_BLUE = 24 As Short
	Public COLOR_MAROON = 25 As Short
	Public COLOR_LEMON_CHIFFON = 26 As Short
	Public COLOR_LIGHT_TURQUOISE1 = 27 As Short
	Public COLOR_ORCHID = 28 As Short
	Public COLOR_CORAL = 29 As Short
	Public COLOR_ROYAL_BLUE = 30 As Short
	Public COLOR_LIGHT_CORNFLOWER_BLUE = 31 As Short
	Public COLOR_SKY_BLUE = 40 As Short
	Public COLOR_LIGHT_TURQUOISE = 41 As Short
	Public COLOR_LIGHT_GREEN = 42 As Short
	Public COLOR_LIGHT_YELLOW = 43 As Short
	Public COLOR_PALE_BLUE = 44 As Short
	Public COLOR_ROSE = 45 As Short
	Public COLOR_LAVENDER = 46 As Short
	Public COLOR_TAN = 47 As Short
	Public COLOR_LIGHT_BLUE = 48 As Short
	Public COLOR_AQUA = 49 As Short
	Public COLOR_LIME = 50 As Short
	Public COLOR_GOLD = 51 As Short
	Public COLOR_LIGHT_ORANGE = 52 As Short
	Public COLOR_ORANGE = 53 As Short
	Public COLOR_BLUE_GREY = 54 As Short
	Public COLOR_GREY_40_PERCENT = 55 As Short
	Public COLOR_DARK_TEAL = 56 As Short
	Public COLOR_SEA_GREEN = 57 As Short
	Public COLOR_DARK_GREEN = 58 As Short
	Public COLOR_OLIVE_GREEN = 59 As Short
	Public COLOR_BROWN = 60 As Short
	Public COLOR_PLUM = 61 As Short
	Public COLOR_INDIGO = 62 As Short
	Public COLOR_GREY_80_PERCENT = 63 As Short
	Public COLOR_AUTOMATIC = 64 As Short
	Public BlankWorkbookIs2007 As Boolean = True
End Sub

Public Sub Initialize
	Reader.Initialize (Me)
End Sub

'Creates a XLAddress from the column and row zero based indices.
'AddressZero(0, 0) = AddressName("A1") = AddressOne("A", 1)
'AddressZero(3, 4) = AddressName("D5") = AddressOne("D", 5)
Public Sub AddressZero (Col0Based As Int, Row0Based As Int) As XLAddress
	Dim xa As XLAddress
	xa.Initialize
	xa.Col0Based = Col0Based
	xa.Row0Based = Row0Based
	Return xa
End Sub

'Converts a zero based column and row indices to string (name). Useful in formulas.
Public Sub AddressZeroToString(Col0Based As Int, Row0Based As Int) As String
	Return AddressToString(AddressZero(Col0Based, Row0Based))
End Sub

'Creates a XLAddress from the cell address (ex: D17).
'AddressZero(0, 0) = AddressName("A1") = AddressOne("A", 1)
'AddressZero(3, 4) = AddressName("D5") = AddressOne("D", 5)
Public Sub AddressName (Address As String) As XLAddress
	Dim xa As XLAddress
	xa.Initialize
	Address = Address.ToUpperCase
	For i = 0 To Address.Length - 1
		Dim cp As Int = Asc(Address.CharAt(i))
		If cp >= 0x41 And cp <=	0x5A Then
			xa.Col0Based = xa.Col0Based * 26 + (cp - 0x40)
		Else If cp >= 0x30 And cp <= 0x39 Then
			xa.Row0Based = xa.Row0Based * 10 + cp - 0x30
		End If
	Next
	xa.Col0Based = xa.Col0Based - 1
	xa.Row0Based = xa.Row0Based - 1
	Return xa
End Sub

'Creates a XLAdress from the 1 based row number as appears in Excel and the column name.
'AddressZero(0, 0) = AddressName("A1") = AddressOne("A", 1)
'AddressZero(3, 4) = AddressName("D5") = AddressOne("D", 5)
Public Sub AddressOne(ColumnName As String, Row1Based As Int) As XLAddress
	Dim xa As XLAddress
	xa.Initialize
	Dim b() As Byte = ColumnName.GetBytes("ASCII")
	For i = 0 To b.Length - 1
		Dim cp As Int = b(i)
		xa.Col0Based = xa.Col0Based * 26 + (cp - 0x40)
	Next
	xa.Col0Based = xa.Col0Based - 1
	xa.Row0Based = Row1Based - 1
	Return xa
End Sub

'Converts column name and 1 based row to a string. Useful in formulas.
Public Sub AddressOneToString(ColumnName As String, Row1Based As Int) As String
	Return AddressToString(AddressOne(ColumnName, Row1Based))
End Sub

'Returns the string representation of the given address.
Public Sub AddressToString (Address As XLAddress) As String
	Return AddressToStringAbs(Address, False, False)
End Sub

'Returns the string representation of the given address, optionally adds the absolute modifier ($A$1).
Public Sub AddressToStringAbs(Address As XLAddress, AbsoluteColumn As Boolean, AbsoluteRow As Boolean) As String
	Dim c As Int = Address.Col0Based + 1
	If Address.Col0Based < 0 Or Address.Row0Based < 0 Then Return "N/A"
	Dim col As String
	Do While c > 0
		Dim cmod As Int = c Mod 26
		If cmod = 0 Then cmod = 26
		col = Chr(0x40 + cmod) & col
		c = Floor((c - 1) / 26)
	Loop
	If AbsoluteColumn Then col = "$" & col
	If AbsoluteRow Then col = col & "$"
	col = col & (Address.Row0Based + 1)
	Return col
End Sub

'Creates a writer, starting with an empty workbook.
Public Sub CreateWriterBlank As XLWorkbookWriter
	Dim wb As PoiWorkbook
	wb.InitializeNew(BlankWorkbookIs2007)
	Dim writer As XLWorkbookWriter
	writer.Initialize(Me, wb, False)
	Return writer
End Sub

'Creates a writer with the data from an existing workbook (xls or xlsx workbook).
Public Sub CreateWriterFromTemplate (Dir As String, FileName As String) As XLWorkbookWriter
	Dim wb As PoiWorkbook
	wb.InitializeExisting(Dir, FileName, CreateWriterPassword, False)
	Dim writer As XLWorkbookWriter
	writer.Initialize(Me, wb, True)
	Return writer
End Sub

'Returns a list of XLRanges with the workbook named ranges.
Public Sub GetWorkbookRangeNames (PoiWorkbook As PoiWorkbook) As List
	Dim res As List
	res.Initialize
	Dim jo As JavaObject = PoiWorkbook
	Dim names As List = jo.RunMethod("getAllNames", Null)
	For Each name As JavaObject In names
		Dim Formula As String = name.RunMethod("getRefersToFormula", Null)
		Dim NameName As String = name.RunMethod("getNameName", Null)
		Try
			res.Add(FormulaToRange(PoiWorkbook, Formula , NameName))
		Catch
			Log($"info: cannot get range of: ${NameName} - ${Formula} "$)
		End Try
	Next
	Return res
End Sub

Private Sub FormulaToRange (PoiWorkbook As PoiWorkbook, Formula As String, Name As String) As XLRange
	Dim jo As JavaObject = PoiWorkbook
	Dim AreaReference As JavaObject
	AreaReference.InitializeNewInstance("org.apache.poi.ss.util.AreaReference", Array(Formula, jo.RunMethod("getSpreadsheetVersion", Null)))
	Dim res As XLRange = AreaReferenceToXLRange(PoiWorkbook, AreaReference)
	res.Name = Name
	Return res
End Sub

Public Sub AreaReferenceToXLRange (PoiWorkbook As PoiWorkbook, AreaReference As JavaObject) As XLRange
	Dim res As XLRange
	res.Initialize
	Dim FirstCell = AreaReference.RunMethod("getFirstCell", Null), LastCell = AreaReference.RunMethod("getLastCell", Null) As JavaObject
	res.FirstAddress = AddressZero(FirstCell.RunMethod("getCol", Null), FirstCell.RunMethod("getRow", Null))
	res.SecondAddress = AddressZero(LastCell.RunMethod("getCol", Null), LastCell.RunMethod("getRow", Null))
	res.Sheet = PoiWorkbook.GetSheetByName(FirstCell.RunMethod("getSheetName", Null))
	Return res
End Sub

'Converts a range string (Sheet1!B3:D23) or a named range to a XLRange.
Public Sub RangeStringOrNameToRange (PoiWorkbook As PoiWorkbook, RangeOrName As String) As XLRange
	Dim RefersToFormula As String
	Dim jo As JavaObject = PoiWorkbook
	Dim name As JavaObject = jo.RunMethod("getName", Array(RangeOrName))
	If name.IsInitialized Then
		RefersToFormula  = name.RunMethod("getRefersToFormula", Null)
	Else
		RefersToFormula = RangeOrName
	End If
	Return FormulaToRange(PoiWorkbook, RefersToFormula, RangeOrName)
End Sub

'Converts a XLRange to the native CellRangeAddress type.
Public Sub XLRangeToCellRangeAddress (Range As XLRange) As JavaObject
	Dim CellRange As JavaObject
	CellRange.InitializeNewInstance("org.apache.poi.ss.util.CellRangeAddress", Array(Range.FirstAddress.Row0Based, Range.SecondAddress.Row0Based, Range.FirstAddress.Col0Based, Range.SecondAddress.Col0Based))
	Return CellRange
End Sub

'Converts a XLRange to the native AreaReference type.
Public Sub XLRangeToAreaReference (Workbook As XLWorkbookWriter, Range As XLRange) As JavaObject
	Dim CellReference1 = XLAddressToCellReference(Range.Sheet.Name, Range.FirstAddress) As JavaObject
	Dim CellReference2 = XLAddressToCellReference(Range.Sheet.Name, Range.SecondAddress) As JavaObject
	Dim AreaReference As JavaObject
	AreaReference.InitializeNewInstance("org.apache.poi.ss.util.AreaReference", Array(CellReference1, CellReference2, Workbook.VersionName))
	Return AreaReference
End Sub

'Converts a XLAddress to the native CellReference type.
Public Sub XLAddressToCellReference (SheetName As String, Address As XLAddress) As JavaObject
	Dim CellReference1 As JavaObject
	CellReference1.InitializeNewInstance("org.apache.poi.ss.util.CellReference", Array(SheetName, Address.Row0Based, Address.Col0Based, True, True))
	Return CellReference1
End Sub



'Creates a XLRange object. The Sheet field will be uninitialized.
Public Sub CreateXLRange (FirstAddress As XLAddress, SecondAddress As XLAddress) As XLRange
	Dim t1 As XLRange
	t1.Initialize
	t1.FirstAddress = FirstAddress
	t1.SecondAddress = SecondAddress
	Return t1
End Sub

'Creates a XLRange object.
Public Sub CreateXLRangeWithSheet (FirstAddress As XLAddress, SecondAddress As XLAddress, PoiSheet As PoiSheet) As XLRange
	Dim t1 As XLRange
	t1.Initialize
	t1.FirstAddress = FirstAddress
	t1.SecondAddress = SecondAddress
	t1.Sheet = PoiSheet
	Return t1
End Sub

'Windows only!
'Opens MS Excel if it is installed.
'<code>Wait For (xl.OpenExcel(FilePath)) Complete (Success As Boolean)</code>
Public Sub OpenExcel (FilePath As String) As ResumableSub
	'example of showing the workbook. Will fail if Excel if not installed.
	Dim shl As Shell
	shl.InitializeDoNotHandleQuotes("shl", "cmd.exe", Array("/c", "start", $""""$, $""${FilePath}""$))
	shl.Run(-1)
	Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	If ExitCode <> 0 Then
		Log(StdOut)
		Log(StdErr)
		Return False
	End If
	Return True
End Sub

'Windows only and requires Excel to be installed!
'Uses PowerShell to convert the workbook to a pdf.
'SheetIndex - Sheet to convert. Pass -1 to convert the complete workbook. You can set the print area of each sheet.
Public Sub PowerShellConvertToPdf (InputFile As String, OutputFile As String, SheetIndex As Int, OpenPdf As Boolean) As ResumableSub
	File.Delete(OutputFile, "")
	If File.Exists(OutputFile, "") Then
		Log("Cannot delete output file")
		Return False
	End If
	Dim ObjectToConvert As String
	If SheetIndex < 0 Then
		ObjectToConvert = "$workbook"
	Else
		ObjectToConvert = $"$workbook.Sheets[${SheetIndex + 1}]"$
	End If
	Dim s As String = $"
	& {$objExcel = New-Object -ComObject excel.application
$workbook = $objExcel.workbooks.open('${InputFile}', 3)
${ObjectToConvert}.ExportAsFixedFormat($xlFixedFormat::xlTypePDF, '${OutputFile}')
$objExcel.Workbooks.close()
$objExcel.Quit()}"$
	Wait For (PowerShellScript(s)) Complete (Result As ShellSyncResult)
	If Result.ExitCode <> 0 Then Return False
	If OpenPdf Then
		Wait For (PowerShellScript($"& {Invoke-Item '${OutputFile}'}"$)) Complete (Result As ShellSyncResult)
		Return Result.ExitCode = 0
	End If
	Return True
End Sub

Public Sub PowerShellScript(s As String) As ResumableSub
	s = s.Replace(CRLF, ";").Replace("""", "'")
	Dim shl As Shell
	shl.InitializeDoNotHandleQuotes("shl", "powershell.exe", Array("-Command", s))
	shl.Run(-1)
	Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Dim res As ShellSyncResult
	res.ExitCode = ExitCode
	res.StdErr = StdErr
	res.StdOut = StdOut
	res.Success = Success
	If StdErr <> "" Then
		Log(StdErr)
		If ExitCode = 0 Then res.ExitCode = 1
	End If
	Return res
End Sub


