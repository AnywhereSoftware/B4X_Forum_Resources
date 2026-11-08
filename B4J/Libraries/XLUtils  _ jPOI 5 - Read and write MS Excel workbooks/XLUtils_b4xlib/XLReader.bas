B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Private EmptyRow() As Object
	Public Password As String
	Private xl As XLUtils 'ignore
	Private MissingCellValue As Object = ""
	Public FetchFormulasInsteadOfCachedValues As Boolean
	Public FetchHyperlinks As Boolean
End Sub


Public Sub Initialize (vXL As XLUtils)
	xl = vXL
End Sub


'Reads all sheets from the workbook and returns a list with XLReaderResults.
Public Sub ReadAll (Dir As String, FileName As String) As List
	Return ReadWorkbook(OpenWorkbook(Dir, FileName))
End Sub

Private Sub OpenWorkbook (Dir As String, FileName As String) As PoiWorkbook
	If Dir = "" Then
		Dir = FileName
		FileName = ""
	End If
	Dim wb As PoiWorkbook
	wb.InitializeExisting(Dir, FileName, Password, True)
	CloseWBAfterSleep(wb)
	Return wb
End Sub

'make sure that the workbook is closed even if there are errors.
Private Sub CloseWBAfterSleep(wb As PoiWorkbook)
	Sleep(0)
	Try
		wb.Close
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub ReadWorkbook (wb As PoiWorkbook) As List
	Dim res As List
	res.Initialize
	For i = 0 To wb.NumberOfSheets - 1
		Dim sheet As PoiSheet = wb.GetSheet(i)
		res.add(SheetToResult(sheet))
	Next
	wb.Close
	Return res
End Sub

'Reads a single sheet from the workbook.
Public Sub ReadSheetByIndex (Dir As String, FileName As String, SheetIndex As Int) As XLReaderResult
	Dim wb As PoiWorkbook = OpenWorkbook(Dir, FileName)
	Dim res As XLReaderResult = SheetToResult(wb.GetSheet(SheetIndex))
	wb.Close
	Return res
End Sub

'Reads a single sheet from the workbook.
Public Sub ReadSheetByName (Dir As String, FileName As String, SheetName As String) As XLReaderResult
	Dim wb As PoiWorkbook = OpenWorkbook(Dir, FileName)
	Dim res As XLReaderResult = SheetToResult(wb.GetSheetByName(SheetName))
	wb.Close
	Return res
End Sub

'Reads a range from the workbook. The range can be a named range or a custom range: Sheet1!A1:F200.
Public Sub ReadRange (Dir As String, FileName As String, Range As String) As XLReaderResult
	Dim om As List = ReadRanges(Dir, FileName, Array(Range))
	Return om.Get(0)
End Sub

'Similar to ReadRange. Reads multiple ranges and returns them in a list. Each item is a XLReaderResult.
Public Sub ReadRanges(Dir As String, FileName As String, Ranges As List) As List
	Dim wb As PoiWorkbook = OpenWorkbook(Dir, FileName)
	Dim result As List
	result.Initialize
	For Each Range As String In Ranges
		result.Add(RangeToResult(xl.RangeStringOrNameToRange(wb, Range)))
	Next
	wb.Close
	Return result
End Sub

'Reads the data from the given range. Should be used when working with XLSheetWriter.
Public Sub RangeToResult (range As XLRange) As XLReaderResult
	Dim left = Min(range.FirstAddress.Col0Based, range.SecondAddress.Col0Based), right = Max(range.FirstAddress.Col0Based, range.SecondAddress.Col0Based), _
		top = Min(range.FirstAddress.Row0Based, range.SecondAddress.Row0Based), bottom = Max(range.FirstAddress.Row0Based, range.SecondAddress.Row0Based) As Int
	left = Max(0, left)
	bottom = Max(0, Min(range.sheet.LastRowNumber, bottom))
	right = Max(right, left)
	top = Max(0, Min(top, bottom))
	Dim rows As List
	rows.Initialize
	Dim res As XLReaderResult = CreateXLReaderResult(rows, xl.AddressZero(left, top), range.Name)
	For r = top To bottom
		Dim row(right - left + 1) As Object
		Dim prow As PoiRow = range.sheet.GetRow(r)
		If prow.IsInitialized = False Then
			For c = left To right
				row(c - left) = MissingCellValue
			Next
		Else
			For c = left To right
				Dim cell As PoiCell = prow.GetCell(c)
				row(c - left) = CellToObject(cell, res)
			Next
		End If
		rows.Add(row)
	Next
	Return RemoveEmptyRowsFromEndAndSetBottomRight(res)
End Sub

'Reads the data from the given sheet. Should be used when working with XLSheetWriter.
Public Sub SheetToResult (sheet As PoiSheet) As XLReaderResult
	Dim rows As List
	rows.Initialize
	Dim res As XLReaderResult = CreateXLReaderResult(rows, xl.AddressZero(0, 0), sheet.Name)
	Dim LastRowIndex As Int = sheet.LastRowNumber
	For r = 0 To LastRowIndex
		Dim prow As PoiRow = sheet.GetRow(r)
		If prow.IsInitialized = False Then
			rows.Add(EmptyRow)
			Continue
		End If
		Dim cells As List = prow.Cells
		If cells.Size = 0 Then
			rows.Add(EmptyRow)
			Continue
		End If
		Dim LastCell As PoiCell = cells.Get(cells.Size - 1)
		Dim row(LastCell.ColumnIndex + 1) As Object
		Dim CurrentCellIndex As Int = 0
		Dim CurrentCell As PoiCell = cells.Get(CurrentCellIndex)
		For c = 0 To row.Length - 1
			If c = CurrentCell.ColumnIndex Then
				row(c) = CellToObject(CurrentCell, res)
				CurrentCellIndex = CurrentCellIndex + 1
				If CurrentCellIndex = cells.Size Then Exit
				CurrentCell = cells.Get(CurrentCellIndex)
			Else
				row(c) = MissingCellValue
			End If
		Next
		rows.Add(row)
	Next
	Return RemoveEmptyRowsFromEndAndSetBottomRight(res)
End Sub

Private Sub RemoveEmptyRowsFromEndAndSetBottomRight(res As XLReaderResult) As XLReaderResult
	Do While res.Data.Size > 0
		Dim lastrow() As Object = res.Data.Get(res.Data.Size - 1)
		If lastrow.Length = 0 Then
			res.Data.RemoveAt(res.Data.Size - 1)
		Else
			Exit
		End If
	Loop
	If res.Data.Size > 0 Then
		Dim lastrow() As Object = res.Data.Get(res.Data.Size - 1)
		res.BottomRight = xl.AddressZero(res.TopLeft.Col0Based + lastrow.Length - 1, res.TopLeft.Row0Based + res.Data.Size - 1)
	End If
	Return res
End Sub

Private Sub CellToObject (cell As PoiCell, Result As XLReaderResult) As Object
	If cell.IsInitialized = False Then Return MissingCellValue
	If FetchHyperlinks Then
		Dim jcell As JavaObject = cell
		Dim hyperlink As JavaObject = jcell.RunMethod("getHyperlink", Null)
		If hyperlink.IsInitialized Then
			Dim h As XLHyperlink
			h.Initialize
			h.Address = ObjectToString(hyperlink.RunMethod("getAddress", Null))
			h.Label = ObjectToString(hyperlink.RunMethod("getLabel", Null))
			h.LinkType = hyperlink.RunMethod("getType", Null)
			Dim CellAddress As JavaObject = jcell.RunMethod("getAddress", Null)
			Result.Hyperlinks.Put(CellAddress.RunMethod("formatAsString", Null), h)
		End If
	End If
	If FetchFormulasInsteadOfCachedValues Then Return cell.Value Else Return cell.ValueCached
End Sub

Private Sub ObjectToString(o As Object) As String
	If o = Null Then Return ""
	Return o
End Sub

Private Sub CreateXLReaderResult (Data As List, TopLeft As XLAddress, Name As String) As XLReaderResult
	Dim t1 As XLReaderResult
	t1.Initialize(xl)
	t1.Data = Data
	t1.TopLeft = TopLeft
	t1.Name = Name
	Return t1
End Sub