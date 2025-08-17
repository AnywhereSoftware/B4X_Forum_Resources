B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Type HighlightType (HLType As Int, Colour As String, StartVal As Object, EndVal As Object)

	
	Public mHighlightMap As Map
	Private mColumnWidthMap As Map
	
	Private mClass As String
	Private mID As String
	Private mClass As String
	Private mDivClass As String
	Private mTableRefClass As String
	Private TableData As List
	Private HeaderRow As Boolean
	Private mIndexNumbers As Boolean
	Private mIgnoreCSS As Boolean
	Private mFilterHits As Boolean
	Private mTitle As String
	Private mAsHex As Boolean
	Private mNumberColumns As Boolean
	Private mColumnNumStart As Int
	Private mSyncRequired As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Index As Int)
	mTableRefClass = "pagetable-" & Index
	mHighlightMap.Initialize
	mColumnWidthMap.Initialize
End Sub
Public Sub Highlight(Column As Int, HLType As Int, Colour As String, StartVal As Object, EndVal As Object) As HTMLPage_Table
	Dim HLT As HighlightType
	HLT.Initialize
	HLT.HLType = HLType
	HLT.colour = Colour
	HLT.StartVal = StartVal
	HLT.EndVal = EndVal
	mFilterHits = True
	mHighlightMap.put(Column,HLT)
	
	Return Me
End Sub

'Add a title to the table
Public Sub Title(tTitle As String) As HTMLPage_Table
	mTitle = tTitle
	Return Me
End Sub

Private Sub HasTitle As Boolean
	Return mTitle <> ""
End Sub

Private Sub GetFilterHits As Boolean
	Return mFilterHits
End Sub

'Add a CSS Selector Id to the table
Public Sub Id(tId As String) As HTMLPage_Table
	mID = tId
	Return Me
End Sub

'Add a CSS Selector class to the table
Public Sub Class(tClass As String) As HTMLPage_Table
	mClass = tClass
	Return Me
End Sub

Private Sub GetClass As String
	Return mClass
End Sub

'Add a CSS Selector class to the containing div
Public Sub DivClass(tClass As String) As HTMLPage_Table
	mDivClass = tClass
	Return Me
End Sub

'Specify that the data passed has a header row
Public Sub HasHeader As HTMLPage_Table
	HeaderRow = True
	Return Me
End Sub

'Display Column numbers
Public Sub ColumnNumbers(StartAt As Int) As HTMLPage_Table
	mNumberColumns = True
	mColumnNumStart = StartAt
	Return Me
End Sub

'Inserts a column at the left of the table. It's th and td children have a className of 'row-num'
Public Sub RowNumbers As HTMLPage_Table
	mIndexNumbers = True
	Return Me
End Sub

'Create the table from CSV data using the Delimiter
Public Sub FromCSV(Csv As String,Delimiter As String) As HTMLPage_Table
	Dim CSVP As CSVParser
	CSVP.Initialize
	TableData = CSVP.ParseIrregular(Csv,Delimiter)
	Return Me
End Sub

'Create the table from a list.
Public Sub FromList(L As List) As HTMLPage_Table
	If L.Get(0) Is List Or IsArray(L.Get(0)) Then
		TableData = ConvertArrays(L)
	Else
		TableData.Initialize
		TableData.Add(L)
	End If
	Return Me
End Sub

'Add a simgle dimensioned list inverted
Public Sub FromListInvert(L As List) As HTMLPage_Table
	Dim LL As List
	LL.Initialize
	For Each O As Object In L
		Dim LLL As List
		LLL.Initialize
		LLL.Add(O)
		LL.Add(LLL)
	Next
	TableData = LL
	Return Me
End Sub

'Displays values as Hex where possible, otherwise displays the original values.
Public Sub AsHex As HTMLPage_Table
	mAsHex = True
	Return Me
End Sub

'Create the table from a list of Types. Fieldnames will be used as a header row.
Public Sub FromTypeList(L As List) As HTMLPage_Table
	TableData.Initialize
	Dim O As Object = L.Get(0)
	TableData.Add(HTMLPage_Utils.GetTypeFieldNames(O))
	
	For Each O As Object In L
		TableData.Add(HTMLPage_Utils.GetTypeFieldValues(O))
	Next
	HeaderRow = True
	Return Me
End Sub

''Create the table from an Array, single or multi dimensional 
Public Sub FromArray(Arr As Object) As HTMLPage_Table
	Dim Arrays As JavaObject
	Arrays.InitializeStatic("java.util.Arrays")
	Dim L As List = Arrays.RunMethod("asList",Array(Array(Arr)))
	TableData = ConvertArrays(L)
	Return Me
End Sub

Private Sub SyncRequired
	mSyncRequired = True
End Sub

Private Sub ConvertArrays(L As List) As List
	For i = 0 To L.Size - 1
		If L.Get(i) Is List Then
			Continue
		End If
		If IsMultiArray(L.Get(i)) Then
			L = HTMLPage_Utils.ArrayToList(L.Get(i))
			Return L
		End If
		If IsArray(L.Get(i)) Then
			L.Set(i,HTMLPage_Utils.ArrayToList(L.Get(i)))
		End If
	Next
	Return L
End Sub

Private Sub getHTML As String
	
	Dim SB As StringBuilder
	SB.Initialize
	
	
	SB.Append(TAB)
	SB.Append($"<div"$)
	
	If mDivClass <> "" Then 
		SB.Append($" class="${mDivClass} tablediv""$)
	Else
		SB.Append($" class="tablediv""$)
	End If
	If mSyncRequired Then
		SB.Append($" onScroll="syncScroll(this)""$)
	End If
	
	SB.Append($">"$)
	
	Dim M As Map = CreateTable
	
	If mFilterHits Then
		SB.Append($"<div class="table-header"><span class="table-header-title" style="display:table;margin:auto;text-align:center">${mTitle}</span><button Type="button"
	onclick="filterHits('${mTableRefClass}')">Filter Hits (${M.Get("hitcount")})</button></div>
"$)
	Else
		SB.Append($"<div class="table-header"><span class="table-header-title" style="display:table;margin:auto;text-align:center">${mTitle}</span></div>
	"$)
	End If
	
	SB.Append("<table")
	If mID <> "" Then SB.Append($" id="${mID}""$)
	SB.Append($" class=""$)
	If mClass <> "" Then SB.Append($"${mClass} "$)
	SB.Append($"${mTableRefClass}"$)
	SB.Append($"""$)
	
	SB.Append($">
	<tbody>
"$)
	
	SB.Append(M.Get("html"))
	SB.Append(CRLF)
	SB.Append($"</tbody></table>
"$)
	SB.Append($"</div>
"$)
'	SB.Append(CRLF)
	Return SB.ToString
End Sub

Private Sub IgnoreCSS As Boolean
	Return mIgnoreCSS
End Sub

Public Sub IgnoreDefaultCSS As HTMLPage_Table
	mIgnoreCSS = True
	Return Me
End Sub

Private Sub IsArray(O As Object) As Boolean
	Return GetType(O).CharAt(0) = "[" And GetType(O).CharAt(1) <> "["
End Sub

Private Sub IsMultiArray(O As Object) As Boolean
	Return GetType(O).StartsWith("[[")
End Sub

Private Sub CreateTable As Map

	If TableData.Size = 0 Then Return CreateMap("html":"","hitcount":0)
	Dim HitCount As Int
	
	Dim HTML As StringBuilder
	HTML.Initialize
	
	
	For i = 0 To TableData.Size - 1
		Dim R As List = TableData.Get(i)
		HTML.Append(TAB)
		HTML.Append(TAB)
		
		If i = 0 And mNumberColumns Then
			HTML.Append($"<tr class="col-num-row">"$)
			If mIndexNumbers Then
				HTML.Append($"<th class="col-num col-num-1 row-1 col-1"></th>"$)
			End If
			For j = 0 To R.Size - 1
				HTML.Append($"<th class="col-num col-num${j} row${i-1} col${j}">${j + mColumnNumStart}</th>"$)
			Next
			HTML.Append($"</tr>
		"$)
		End If
		
		Dim SBRow As StringBuilder
		SBRow.Initialize
		If mFilterHits Then
			If HeaderRow And i = 0 Then
				SBRow.Append($"
		<tr class="header-row">"$)
			Else
				SBRow.Append($"<tr class="xnohit">"$)
			End If
		Else
			If i = 0 And HeaderRow Then
				SBRow.Append($"<tr class="header-row">"$)
			Else
				SBRow.Append($"<tr>"$)
			End If
		End If
		If mIndexNumbers Then
			If HeaderRow Then
				If i = 0 Then
					SBRow.Append($"<th class ="row-num col-1 row0">Index</th>"$)
				Else
					SBRow.Append($"<td class="row-num col-1 row${i}">${i-1}</td>"$)
				End If
			Else
				SBRow.Append($"<td class="row-num col-1 row${i}">${i}</td>"$)
			End If
		End If
		
		For j = 0 To R.Size - 1
			Dim CellVal As Object = R.Get(j)
			
			If i = 0 And HeaderRow Then
				SBRow.Append($"<th class="col-hdr row${i} col${j}">"$)
			Else
				If mHighlightMap.ContainsKey(j) And CheckHighlight(j,CellVal) Then
					HitCount = HitCount + 1
					Dim Row As String = SBRow.ToString
					If Row.Contains($"<tr class="xnohit">"$) Then
						Row = Row.Replace($"<tr class="xnohit">"$,"<tr>")
						SBRow.Remove(0,SBRow.Length)
						SBRow.Append(Row)
					End If
'					If i = 0 Then
'						SBRow.Append($"<td class="data-cell data-c${j} row${i} col${j}">"$)
'					Else
						SBRow.Append($"<td class="data-cell data-c${j} row${i} col${j}" style="background-color:${mHighlightMap.Get(j).As(HighlightType).colour};">"$)
'					End If
					
				Else
					If i = 0 Then
						SBRow.Append($"<td class="data-cell data-c${j} row${i} col${j}">"$)
					Else
						SBRow.Append($"<td class="data-cell data-c${j} row${i} col${j}">"$)
					End If
				End If
			End If
			
			If mAsHex Then
				SBRow.Append(ToHex(CellVal.As(String).trim))
			Else
				SBRow.Append(CellVal.As(String).trim)
			End If
			
			If i = 0 And HeaderRow Then
				SBRow.Append("</th>")
			Else
				SBRow.Append("</td>")
			End If
		Next
		SBRow.Append("</tr>")
		HTML.Append(SBRow)
		If i <> TableData.Size - 1 Then HTML.Append(CRLF)
	Next
	Return CreateMap("html":HTML.ToString,"hitcount":HitCount)
End Sub

Private Sub ToHex(Val As Object) As String
	If IsNumber(Val) = False Then Return Val
	Dim I As Long = Val
	Dim BC As ByteConverter
	
	If i < Power(2,8) Then
		Return BC.HexFromBytes(Array As Byte(I))
	Else If I < Power(2,16) Then
		Return BC.HexFromBytes(BC.ShortsToBytes(Array As Short(I)))
	Else
		If I < Power(2,32) Then
			Return BC.HexFromBytes(BC.IntsToBytes(Array As Int(I)))
		Else
			Return BC.HexFromBytes(BC.LongsToBytes(Array As Long(I)))
		End If
	End If
End Sub

Private Sub CheckHighlight(X As Int, Val As Object) As Boolean
	Dim HLT As HighlightType = mHighlightMap.Get(X)
	If IsNumber(Val) = False And GetType(Val) <> GetType(HLT.StartVal) Then Return False
	If HLT.StartVal Is Boolean And Not(Val Is Boolean) Then Return False
	If IsNumber(Val) And Not(IsNumber(HLT.StartVal)) Then Return False
	
	Select HLT.HLType
		Case HTMLPage_Static.HIGHLIGHT_LT
			If IsNumber(Val) Then
				Dim NVal As Double = Val
				Return NVal < HLT.StartVal
			End If
			Return Val < HLT.StartVal
			
		Case HTMLPage_Static.HIGHLIGHT_LTEQ
			If IsNumber(Val) Then
				Dim NVal As Double = Val
				Return NVal <= HLT.StartVal
			End If
			Return Val <= HLT.StartVal

		Case HTMLPage_Static.HIGHLIGHT_GT
			If IsNumber(Val) Then
				Dim NVal As Double = Val
				Return NVal > HLT.StartVal
			End If
			Return Val > HLT.StartVal

		Case HTMLPage_Static.HIGHLIGHT_GTEQ
			If IsNumber(Val) Then
				Dim NVal As Double = Val
				Return NVal >= HLT.StartVal
			End If
			Return Val >= HLT.StartVal

		Case HTMLPage_Static.HIGHLIGHT_EQ
			If IsNumber(Val) Then
				Dim NVal As Double = Val
				Return NVal = HLT.StartVal
			End If
			Return Val = HLT.StartVal

		Case HTMLPage_Static.HIGHLIGHT_BETWEEN
			If IsNumber(Val) Then
				Dim NVal As Double = Val
				Return NVal >= HLT.StartVal And NVal <= HLT.EndVal
			End If
			Return Val >= HLT.StartVal And Val <= HLT.EndVal

		Case Else
			Return False
	End Select
End Sub

Private Sub DefaultCSS As String
	Return HTMLPage_Static.TableDefaultCSS
End Sub

