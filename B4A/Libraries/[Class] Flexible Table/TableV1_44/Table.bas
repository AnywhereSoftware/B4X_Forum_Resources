B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.01
@EndOfDesignText@
'Version 1.43
'The modifications in LoadSQLiteDB were not OK for all cases
'Reset LoadSQLiteDB like in version 1.40
'Added LoadSQLiteDB2 routine for real numbers with more than 6 digits
'This routine needs a string array with the data types

'Version 1.42
'Amended problem with big numbers in LoadSQLiteDB
'The code in version didn't work correctly
'Final solution suggested in the forum by cimperia

'Version 1.41
'Amended problem with big numbers in LoadSQLiteDB
'replaced GetString by GetDouble for REAL numbers
'replaced GetString by GetLong for INTEGER numbers

'Version 1.40
'Amended error cHeaderHeight
'Amended last row selection

'Version 1.39
'Added SetAutomaticWidths
'Changed AddRowAutomaticWidths

'Version 1.38
'Amended rows not visible problem

'Version 1.37
'Modified singleline as property
'Added AllowSelection property, True by default
'avoided unnecessary innerClearAll calls
'added HeaderAlignment

'Version 1.36
'Added UseColumnColors ColumnColors and HeaderColors properties.

'Version 1.35
'Added SortColumn property.

'Version 1.34
'Amended setRowColor1, setRowColor2 etc not working properly
'Added HeaderHeight property, allows to set it to 0 to hide the header, the default value is the row height.
'Some minor changes

'Version 1.33
'Added RowHeight as property

'Version 1.32
'Added sortTableNum to sort numbers instead of strings

'Version 1.31
'Amended error in line color when hiding a column

'Version 1.30
'Added Public Sub JumpToRowAndSelect(Row As Int, Col As Int) routine
'Added Left, Top, Widht, Height and Visible properties.
'Added HeaderNames List, you can get any header name with Table1.HeaderNames.Get(col)
'Amended line width problem for devices with 0.75 density

'Version 1.29
'Amended SetColumnWidths with 0 values

'Version 1.28
'Amended the click of the internalPanel

'Version 1.27
'Improved Header change with automatic widths

'Version 1.26
'Added GetColumnWidths method

'Version 1.25
'Added LoadTableFromCSV2(Dir As String, Filename As String, HeadersExist As Boolean, SeparatorChar As String, AutomaticWidths As Boolean)
'I kept LoadTableFromCSV for backward compatibility.
'The new routines alows to define the separator character and automatic column width calculation. 

'Version 1.24
'Added Gravity for each column

'Version 1.23
'Added the RemoveView method
'fixed StatusLine property setting

'Version 1.22
'Added code in setTextColor, setTableColor, setTextSize that changes the properties also after having filled the table

'Version 1.21
'method LoadSQLiteDB to fill a table from a SQLite database
'changed colors, alignment etc as properties (see the routines beginning with lowercase 'set' or 'get' 

'Version 1.20
' fix bug not calling updateIPLocation on clean table, which will cause panel to be of the wrong size if you create a table, fill it up than clear all and not add rows

'Version 1.19
' fix last column (if no empty space, its very hard to choose it)
' fix size of sorting icons on columns

' whats new 1.18
' bug fix, table can now start on left <> 0 without weird horizontal scroll issues  - thanks klaus
' add method addToView - which is the same as add2Activity - but a better naming - you can still use addToActivity - depricated like method.

' whats new 1.17
' bug fix, table that start not at top=0 will not fire events corretly internalPanel.top will start at top 0 and will consume events from tables rows

' whats new 1.16
' bug fix, table with no status line throw exception
' method to disable the status line auto fill with number of rows

' whats new 1.15
' Tables internal panel can now fire events - so when user click an empty space developer can trigger a UI component for example use this to trigger adding line to an empty table for example
' added statusline label, can be used to show messages (option to turn on/off in initialize sub) - default is to show number of rows
' will show (as default) the number of rows in the statusLine
' added size() sub to return the number of lines in the table
' added ability to sort by column - click on the column header (I had to remove the header click event) added small UI component to show sorting (will lose selection for now)
' need to copy png files sort_asc, sort_desc to the files folder of your project
' near future: need to add ability to keep selection

' Whats new 1.14
' alignement now is set in the Initialize sub
' added removeRow() sub to remove a specifc row from the table - this is EREL's removeRow adopted to 1.13 and to the rest of the changes in 1.14
' added getValues() sub to get the entire row in an array, thought this is usefull
' added updateRow() sub to set an entire row at once, Vs cell by cell, in tables many times, developer work by rows , update an entire row
' added ability to set (and get) the lables to be singleLine or multiLine lables (deafult is singleLine) this feature depend on reflection lib - setting this attribute will clear the table!!!
' added getHeaderPanel sub to return he header panel so developer can get access to the header components , for example to show tooltip, or quickAction on the header location
' added ability to turn on and off multi selection of rows, User can now select one row or any number of rows, developer can use that functunality to , for example change status of many rows at once, or remove many rows with one user action
' added getSelectedRows to return list of selected rows
' added ability to hide/unhide a specific column, so it will be part of the table but hidden from the user, this is usefull to if developer wants to maintain additional data in the table (this is not a complete data model / view model implementation)

' with ScrollView2 instead of ScrollView
' with highlighting of the selected cell

' example of how to use the table class.

Sub Class_Globals
	Private StringUtils1 As StringUtils
	Private SV As ScrollView2D
	Private pnlTable As Panel
	Private Header As Panel
	Private lblStatusLine As Label
	Private Callback As Object
	Private Event As String
	Public HeaderNames As List
	Public SelectedRows As List ' selected rows ' convert to map!!!
	Private SelectedCol As Int 
	Private Data As List
	Private LabelsCache As List
	Private minVisibleRow, maxVisibleRow As Int
	Private IsVisible As Boolean
	Public visibleRows As Map
	Private NumberOfColumns, ColumnWidths(), cColumnColors(), cTextColors(), cHeaderColors(), cHeaderTextColors(), DataWidths(), HeaderWidths() As Int
	Private cRowHeight, cHeaderColor, cTableColor, cTextColor, cHeaderHeight, cHeaderTextColor As Int
	Private cAutomaticWidths = False As Boolean
	Private cTextSize As Float
	Type RowCol (Row As Int, Col As Int)
	Private cAlignment As Int
	Private cAlignments() As Int
	Private cAlignments0() As Int
	Private MultiAlignments = False As Boolean
	Private cHeaderAlignment = Gravity.CENTER As Int
	Private cHeaderAlignments() As Int
	Private cHeaderAlignments0() As Int
	Private HeaderMultiAlignments = False As Boolean
	Private MultiTypeFace = False As Boolean
	Private cTypeFace = Typeface.DEFAULT As Typeface
	Private cTypeFaces() As Typeface
	Private cLineWidth = Max(1, 1dip) As Int
	Private ExtraWidth = 12dip + cLineWidth	As Int
	Private SelectedDrawable(), Drawable1(), Drawable2() As Object
	Private SelectedCellDrawable As Object
	Private cRowColor1, cRowColor2, cSelectedRowColor, cSelectedCellColor As Int
	Private cSortColumn = True As Boolean
	Private cUseColumnColors = False As Boolean
	
	Private bmp As Bitmap		' used for the canvas below
	Private cvs As Canvas		' used to measure string widths in the LoadSQLiteDB routine
	
	'Table settings
	cHeaderColor = Colors.Gray
	cTableColor = Colors.LightGray
	cTextColor = Colors.Black
	cHeaderTextColor = Colors.White
	cTextSize = 14
	cAlignment = Gravity.CENTER 'change to Gravity.LEFT or Gravity.RIGHT for other alignments.
	cRowColor1 = Colors.White
	cRowColor2 = 0xFF98F5FF
	cSelectedRowColor = 0xFF007FFF
	cSelectedCellColor = 0xFFFC8EAC
	cRowHeight = 40dip
	cHeaderHeight = cRowHeight
	
	Private cSingleLine = True As Boolean		' does a lable hold a single line text or multiline , need to be set rigth after call to initialize
	
	Private IsMultiSelect As Boolean = False
	Private cAllowSelection = True As Boolean
	Private SavedWidths() As Int' to keep the user set widths for columns
	Private showStatusLine As Boolean =True

	Private internalPanel As Panel

	Private sortingDir As Int = 0 ' -1,0,1 as acc, unsorted, dec
	Private sortedCol As Int = -1' hold the sorted column -1 for none
	Private sortingView As Panel

	Dim debug_counter As Long
	Private enableStatusLineAutoFill As Boolean = True
End Sub

' Initialize
' CallbackModule, the object that will listent to cell/ header click / long click events
' eventName the prefix of the events
' vNumberOfColumns = number of columns including hidden ones
'                    enter 1 if you use either LoadSQLiteDB, LoadTableFromCSV or LoadTableFromCSV2
' cellAlignment Gravity.* the cell alignments of all cells text
' showStatusL. if to show status line on the bottom of the table or not, to be able to show text to the user
Public Sub Initialize (CallbackModule As Object, EventName As String, vNumberOfColumns As Int, cellAlignement As Int, showStatusL As Boolean)
	SV.Initialize(0, 0, "SV")
	internalPanel.Initialize("IP")
	showStatusLine = showStatusL
	SelectedRows.Initialize
	cAlignment = cellAlignement
'	SV.Panel.Color = cTableColor
	Callback = CallbackModule
	Event = EventName
	
'	innerClearAll(vNumberOfColumns)

	NumberOfColumns = vNumberOfColumns
'	Dim Drawable1(NumberOfColumns) As Object
'	Dim Drawable2(NumberOfColumns) As Object
'	Dim SelectedDrawable(NumberOfColumns) As Object
'	Dim cAlignments(NumberOfColumns) As Int
	Data.Initialize

	sortingView.Initialize("")
	
	' used for string width measuements in the LoadSQLiteDB routine
	bmp.InitializeMutable(2dip, 2dip)	
	cvs.Initialize2(bmp)
End Sub

'Clears the table
Public Sub ClearAll
	innerClearAll(NumberOfColumns)
	updateIPLocation
End Sub

'Sets the columns widths.
'Example: <code>Table1.SetColumnsWidths(Array As Int(100dip, 30dip, 30dip, 100%x - 160dip))</code>
Public Sub SetColumnsWidths(Widths() As Int)
	' clone (keep) Widths
	Dim col, row As Int
	
	Dim SavedWidths(Widths.Length) As Int
	Dim ColumnWidths(Widths.Length) As Int
	Dim HeaderWidths(Widths.Length) As Int
	If cAutomaticWidths = False Then
		For col = 0 To Widths.Length - 1
			SavedWidths(col) = Widths(col)
			ColumnWidths(col) = Widths(col)
			HeaderWidths(col) = Widths(col)
			DataWidths(col) = Widths(col)
		Next
	Else
		For col = 0 To Widths.Length - 1
			SavedWidths(col) = Widths(col)
			ColumnWidths(col) = Widths(col)
		Next
	End If
	
	Dim v As View
	Dim w As Int
	For col = 0 To Widths.Length - 1
		v = Header.GetView(col)
		w = Max(2dip, Widths(col) - cLineWidth)
		v.Width = w
		If col > 0 Then
			v.Left = Header.GetView(col - 1).Left + Widths(col - 1)
		End If
	Next
	Header.Width = Header.GetView(Widths.Length - 1).Left + Widths(Widths.Length - 1)
	SV.Panel.Width = Header.Width
	Dim lbls() As Label
	For row = 0 To visibleRows.Size - 1
		lbls = visibleRows.GetValueAt(row)
		For col = 0 To lbls.Length - 1
			lbls(col).SetLayout(Header.GetView(col).Left, lbls(col).Top, _
				Header.GetView(col).Width, cRowHeight - cLineWidth)
		Next
	Next
	lblStatusLine.Width = Header.Width
	internalPanel.Width = Header.Width
End Sub

Public Sub GetColumnWidths As Int()
	Return SavedWidths
End Sub

Private Sub innerClearAll(vNumberOfColumns As Int)
	SelectedRows.Initialize
	SV.Panel.RemoveAllViews
	NumberOfColumns = vNumberOfColumns
	Dim Drawable1(NumberOfColumns) As Object
	Dim Drawable2(NumberOfColumns) As Object
	Dim SelectedDrawable(NumberOfColumns) As Object
	Dim cAlignments(NumberOfColumns) As Int
	If cUseColumnColors = False Then
		For i = 0 To NumberOfColumns - 1
			Dim cd1, cd2, cd3 As ColorDrawable
			cd1.Initialize(cRowColor1, 0)
			cd2.Initialize(cRowColor2, 0)
			cd3.Initialize(cSelectedRowColor, 0)
			Drawable1(i) = cd1
			Drawable2(i) = cd2
			SelectedDrawable(i) = cd3
			If MultiAlignments = False Then
				cAlignments(i) = cAlignment
			Else
				cAlignments(i) = cAlignments0(i)
			End If
		Next
	Else
		For i = 0 To NumberOfColumns - 1
			Dim cd1, cd2, cd3 As ColorDrawable
			cd1.Initialize(cColumnColors(i), 0)
			cd2.Initialize(cColumnColors(i), 0)
			cd3.Initialize(cSelectedRowColor, 0)
			Drawable1(i) = cd1
			Drawable2(i) = cd2
			SelectedDrawable(i) = cd3
			If MultiAlignments = False Then
				cAlignments(i) = cAlignment
			Else
				cAlignments(i) = cAlignments0(i)
			End If
		Next
	End If
	
	Dim cd4 As ColorDrawable
	cd4.Initialize(cSelectedCellColor, 0)
	SelectedCellDrawable = cd4

	SV.Panel.Height = 0

	'SelectedRow = -1
	SelectedCol = -1
	minVisibleRow = -1
	maxVisibleRow = 0
	Data.Initialize
	LabelsCache.Initialize
	visibleRows.Initialize
	SV.VerticalScrollPosition = 0
	DoEvents
	SV.VerticalScrollPosition = 0
	For i = 1 To 80 'fill the cache to avoid delay on the first touch
		LabelsCache.Add(CreateNewLabels)
	Next
	If IsVisible Then
		SV_ScrollChanged(0, 0)		
	End If
	If (lblStatusLine.IsInitialized AND enableStatusLineAutoFill = True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
	
End Sub

Private Sub SV_ScrollChanged(PosX As Int, PosY As Int)
	Dim currentMin, currentMax As Int
	currentMin = Max(0, PosY / cRowHeight - 30)
	currentMax = Min(Data.Size - 1, (PosY + SV.Height) / cRowHeight + 30)
	If minVisibleRow > -1 Then
		If minVisibleRow < currentMin Then
			'need to hide the upper rows
			For I = minVisibleRow To Min(currentMin - 1, maxVisibleRow)
				HideRow(I)
			Next
		Else If minVisibleRow > currentMin Then
			'need to show the upper rows
			For I = currentMin To Min(minVisibleRow - 1, currentMax)
				ShowRow(I)
			Next
		End If
		If maxVisibleRow > currentMax Then
			'need to hide the lower rows
			For I = maxVisibleRow To Max(currentMax + 1, minVisibleRow) Step -1
				HideRow(I)
			Next
		Else If maxVisibleRow < currentMax Then
			'need to show the lower rows
			For I = currentMax To Max(maxVisibleRow + 1, currentMin) Step -1
				ShowRow(I)
			Next
		End If
	End If
	minVisibleRow = currentMin
	maxVisibleRow = currentMax
	Header.Left = -PosX
	lblStatusLine.Left = - PosX
End Sub

' add the table to a view of your choice (panel, activity, etc)
' v as the view 
' Left, Top as the start point of the table in that view
' width and height as the width and height of the table in the view, note this include empty space in case not enough lines exists - 
' but the table will take the whole area.
Public Sub AddToView(v As View, Left As Int, Top As Int, Width As Int, Height As Int)
	AddToActivity(v,Left,Top,Width,Height)
End Sub

Public Sub AddToActivity(Act As Activity, Left As Int, Top As Int, Width As Int, Height As Int)
	innerClearAll(NumberOfColumns)

	SV.Panel.Color = cTableColor
	IsVisible = True
	Header.Initialize("")
	pnlTable.Initialize("")
	Header.Color = cTableColor	
	Act.AddView(pnlTable, Left, Top , Width, Height)
	pnlTable.AddView(Header, 0, 0 , Width, cHeaderHeight)
	
	' add status line
	lblStatusLine.Initialize("")
	lblStatusLine.Color = Colors.Transparent ' is it really ?	
	internalPanel.Color = Colors.Transparent 'TODO uncomment this	
	If (showStatusLine = True) Then
		pnlTable.AddView(SV, 0, Header.Height, Width, Height - Header.Height - cRowHeight)
		pnlTable.AddView(lblStatusLine,0, SV.Top + SV.Height, Width, cRowHeight)		
	Else
		pnlTable.AddView(SV, 0, Header.Height, Width, Height - Header.Height)
		pnlTable.AddView(lblStatusLine,0, SV.Top + SV.Height, 0, 0)		
	End If
	pnlTable.AddView(internalPanel,0,0,Width,0)
	updateIPLocation
	
	Dim ColumnWidths(NumberOfColumns) As Int
	Dim HeaderWidths(NumberOfColumns) As Int
	Dim DataWidths(NumberOfColumns) As Int
	Dim SavedWidths(NumberOfColumns) As Int
	For i = 0 To NumberOfColumns - 1
		ColumnWidths(i) = SV.Width / NumberOfColumns
		HeaderWidths(i) = ColumnWidths(i)
		DataWidths(i) = ColumnWidths(i)
		SavedWidths(i) = ColumnWidths(i)
	Next 
	SV.Panel.Width = SV.Width
	SV_ScrollChanged(0, 0)
	If (lblStatusLine.IsInitialized AND enableStatusLineAutoFill=True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
End Sub

'Adds a row to the table
'Example:<code>Table1.AddRow(Array As String("aaa", "ccc", "ddd", "eee"))</code>
Public Sub AddRow(Values() As String)
	If Values.Length <> NumberOfColumns Then
		Log("Wrong number of values =" & Values.Length & " col=" & NumberOfColumns)
		Return
	End If
	Data.Add(Values)
	Dim lastRow As Int
	lastRow = Data.Size - 1
	If lastRow < (SV.VerticalScrollPosition + SV.Height) / cRowHeight + 1 Then
		ShowRow(lastRow)		
	End If
	SV.Panel.Height = Data.Size * cRowHeight
	updateIPLocation
	If (lblStatusLine.IsInitialized AND enableStatusLineAutoFill=True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
End Sub

'Adds a row to the table
'Example:<code>Table1.AddRow(Array As String("aaa", "ccc", "ddd", "eee"))</code>
Public Sub AddRowAutomaticWidth(Values() As String)
	If Values.Length <> NumberOfColumns Then
		Log("Wrong number of values =" & Values.Length & " col=" & NumberOfColumns)
		Return
	End If
	Data.Add(Values)
	Dim lastRow As Int
	lastRow = Data.Size - 1
	
	Dim changed = False As Boolean
	Dim width As Int
	For I = 0 To NumberOfColumns - 1
		If MultiTypeFace = False Then
'			width = cvs.MeasureStringWidth(Values(I), cTypeFaces(0), cTextSize) + ExtraWidth
			width = cvs.MeasureStringWidth(Values(I), cTypeFace, cTextSize) + ExtraWidth
		Else
			width = cvs.MeasureStringWidth(Values(I), cTypeFaces(I), cTextSize) + ExtraWidth
		End If
		If ColumnWidths(I) < width Then
			ColumnWidths(I) = width
			SavedWidths(I) = width
			HeaderWidths(I) = width
			DataWidths(I) = width
			changed = True
		End If
	Next

	If changed = True Then
		SetColumnsWidths(ColumnWidths)
	End If
	
	If lastRow < (SV.VerticalScrollPosition + SV.Height) / cRowHeight + 1 Then
		ShowRow(lastRow)		
	End If
	SV.Panel.Height = Data.Size * cRowHeight
	updateIPLocation
	If (lblStatusLine.IsInitialized AND enableStatusLineAutoFill=True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
End Sub

' draw a Row, now col is hidden (width <2)
Private Sub ShowRow(Row As Int)
	If visibleRows.ContainsKey(Row) Then Return
	'Log("ShowRow: " & row)
	Dim lbls() As Label
	Dim values() As String
	lbls = GetLabels(Row)
	values = Data.get(Row)
	visibleRows.Put(Row, lbls)
	Dim rowColor() As Object
	If (SelectedRows.indexof(Row) <> -1 )Then
		rowColor = SelectedDrawable
	Else If Row Mod 2 = 0 Then
		rowColor = Drawable1
	Else
		rowColor = Drawable2
	End If
	For I = 0 To lbls.Length - 1
		If (Header.GetView(I).Width > 1 ) Then 
			SV.Panel.AddView(lbls(I), Header.GetView(I).Left, Row * cRowHeight, Header.GetView(I).Width, cRowHeight - cLineWidth)
			lbls(I).Text = values(I)
			If I = SelectedCol AND (SelectedRows.indexof(Row) <> -1) Then
				lbls(I).Background = SelectedCellDrawable
			Else
				lbls(I).Background = rowColor(I)
			End If
			If MultiAlignments = False Then
				lbls(I).Gravity = cAlignment
			Else
				lbls(I).Gravity = cAlignments(I)
			End If
		End If
	Next
End Sub

Private Sub IsRowVisible(Row As Int) As Boolean
	Return Row < (SV.VerticalScrollPosition + SV.Height) / (cRowHeight + 1) AND _
		Row > SV.VerticalScrollPosition / cRowHeight
End Sub

Private Sub HideRow (Row As Int)
	'Log("HideRow: " & Row)
	Dim lbls() As Label
	lbls = visibleRows.get(Row)
	If lbls = Null Then 
'		Log("HideRow: (null) " & Row)
		Return
	End If
	For I = 0 To lbls.Length - 1	
		lbls(I).RemoveView
	Next
	visibleRows.Remove(Row)
	LabelsCache.Add(lbls)
End Sub

Private Sub GetLabels(Row As Int) As Label()
	Dim lbls() As Label
	If LabelsCache.Size > 0 Then
		'Log("from cache")
		lbls = LabelsCache.get(LabelsCache.Size - 1)
		LabelsCache.RemoveAt(LabelsCache.Size - 1)
	Else
		lbls = CreateNewLabels		
	End If
	For I = 0 To lbls.Length - 1
		Dim rc As RowCol
		rc = lbls(I).Tag
		rc.Row = Row
	Next
	Return lbls
End Sub

Private Sub CreateNewLabels As Label()
	Dim lbls(NumberOfColumns) As Label
	For i = 0 To NumberOfColumns - 1
		Dim rc As RowCol
		rc.Col = i
		Dim L As Label
		L.Initialize("Cell")
		
		L.TextSize = cTextSize
		
		If cUseColumnColors = False Then
			L.TextColor = cTextColor
		Else
			L.TextColor = cTextColors(i)
		End If
		
		If MultiTypeFace = False Then
			L.Typeface = cTypeFace
		Else
			L.Typeface = cTypeFaces(i)
		End If

		SetPadding(L, 4dip, 2dip, 4dip, 2dip)

		' added by nir, make each label single line
		If cSingleLine Then 
			Dim ref As Reflector
			ref.Target = L
			ref.RunMethod2("setSingleLine", True, "java.lang.boolean")
		End If
		L.Tag = rc
		lbls(i) = L
	Next
	Return lbls
End Sub

'Set the headers values
'Example:<code>Table1.SetHeader(Array As String("Col1", "Col2", "Col3"))</code>
Public Sub SetHeader(Values() As String)
	Dim col As Int

	Header.RemoveAllViews
	HeaderNames.Initialize2(Values)

	Dim Left = 0 As Int
'	Dim Left = cLineWidth As Int
	Dim Change = 0 As Int
	Dim w As Int
	For col = 0 To NumberOfColumns - 1
		Dim L As Label
		L.Initialize("header")
		If HeaderMultiAlignments = False Then
			L.Gravity = cHeaderAlignment
		Else
			L.Gravity = cHeaderAlignments(col)
		End If
		L.TextSize = cTextSize
		SetPadding(L, 4dip, 2dip, 4dip, 2dip)
		If cUseColumnColors = False Then
			L.Color = cHeaderColor
			L.TextColor = cHeaderTextColor
		Else
			L.Color = cHeaderColors(col)
			L.TextColor = cHeaderTextColors(col)
		End If
		
		L.Text = Values(col)
		L.Tag = col
		w = Max(2dip, ColumnWidths(col) - cLineWidth)		' needed to make sure that the width has value >0
		Header.AddView(L, Left, 0, w, cHeaderHeight)
		If cAutomaticWidths = True Then
			If Values(col).Contains(CRLF) Then
				Dim str() As String
				Dim j As Int
				str = Regex.Split(CRLF, Values(col))
				HeaderWidths(col) = cvs.MeasureStringWidth(str(0), L.Typeface, cTextSize) + ExtraWidth
				For j = 1 To str.Length - 1
					HeaderWidths(col) = Max(HeaderWidths(col),cvs.MeasureStringWidth(str(j), L.Typeface, cTextSize)  + ExtraWidth)
				Next
			Else
				HeaderWidths(col) = cvs.MeasureStringWidth(Values(col), L.Typeface, cTextSize)  + ExtraWidth
			End If
			If HeaderWidths(col) > ColumnWidths(col) Then 
				Change = 1
				ColumnWidths(col) = Max(HeaderWidths(col), ColumnWidths(col))
			Else If ColumnWidths(col) > HeaderWidths(col) And ColumnWidths(col) > DataWidths(col) Then
				Change = 1
				ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
			End If
		End If
		Left = Left + ColumnWidths(col)
	Next
	
	If Change = 1 Then
		SetColumnsWidths(ColumnWidths)
	End If
	Header.Left = - SV.HorizontalScrollPosition
End Sub

Private Sub Cell_LongClick
	'Log("Cell: long click")
	Dim rc As RowCol
	Dim L As Label
	L = Sender
	rc = L.Tag
	'SelectRow(rc)
	If SubExists(Callback, Event & "_CellLongClick") Then
		CallSub3(Callback, Event & "_CellLongClick", rc.Col, rc.Row)
	End If
End Sub

Private Sub Header_LongClick
	'Log("Header: long click")
	Dim L As Label
	Dim col As Int
	L = Sender
	col = L.Tag
	If SubExists(Callback, Event & "_HeaderLongClick") Then
		CallSub2(Callback, Event & "_HeaderLongClick", col)
	End If	
End Sub

Private Sub Cell_Click
	Dim rc As RowCol
	Dim L As Label
	L = Sender
	rc = L.Tag
'	SelectRow(rc.Row)
	SelectRow(rc)
	If SubExists(Callback, Event & "_CellClick") Then
		CallSub3(Callback, Event & "_CellClick", rc.Col, rc.Row)
	End If
End Sub

'Gets the value of the given cell.
Public Sub GetValue(Col As Int, Row As Int) As String
	Dim values() As String
	values = Data.get(Row)
	Return values(Col)
End Sub

'Sets the value of the given cell.
Public Sub SetValue(Col As Int, Row As Int, Value As String)
	Dim values() As String
	values = Data.get(Row)
	values(Col) = Value
	If visibleRows.ContainsKey(Row) Then
		Dim lbls() As Label
		lbls = visibleRows.get(Row)
		lbls(Col).Text = Value
	End If
End Sub

Public Sub SelectRow(rc As RowCol)
	If Not(cAllowSelection) Then Return
	
	Dim prevIndex As Int
	Dim prev As Int ' if we select an alreday selected row, prev will be rc.row, else will be -1
	
	prevIndex = SelectedRows.indexof(rc.Row)	 ' -1 if selecting not a selected row	
	If (prevIndex <> -1 And IsMultiSelect = False) Then
		' if IsMultiSelect = True no column change, only if IsMultiSelect = False
		SelectedCol = rc.col
		If visibleRows.ContainsKey(rc.Row) Then
			HideRow(rc.Row)
			ShowRow(rc.Row)
		End If
		Return	' comment this line if you want to unselect a line
	End If
	
	If (prevIndex = -1) Then
		If (IsMultiSelect) Then 
			SelectedRows.add(rc.Row) 'Select the new row
			prev = -1
		Else ' set selected to the new one
			' hide / show all selected rows		
			'Log ("get at zero: " & SelectedRows)
			If (SelectedRows.Size <> 0) Then 
				prev = SelectedRows.get(0) ' there should be only one here ever!!!, keep the unselected row in prev
				SelectedRows.set(0,rc.Row) ' change it to the new one
			Else 
				prev = -1
				SelectedRows.Add(rc.Row)
			End If
		End If
	Else ' multi select and found a row (unselect it)
		'Log ("multi select and found row")
		prev = SelectedRows.get(prevIndex) ' should be RC.row
		SelectedRows.RemoveAt(prevIndex) ' deselect the old selected row		
	End If
	'remove the color of previously selected row
	If prev > -1 Then
		If visibleRows.ContainsKey(rc.Row) Then
			HideRow(prev)
			ShowRow(prev)
		End If
	End If
	
	SelectedCol = rc.col
	If visibleRows.ContainsKey(rc.Row) Then
		HideRow(rc.Row)
		ShowRow(rc.Row)
	End If
End Sub

'Makes the given row visible.
Public Sub JumpToRow(Row As Int)
	Sleep(0)
	SV.VerticalScrollPosition = Row * cRowHeight
End Sub

'Makes the given row visible and det it's row and colum as selected.
Public Sub JumpToRowAndSelect(Row As Int, Col As Int)
	Dim rc As RowCol
	
	rc.Row = Row
	rc.Col = Col
	SelectRow(rc)
	
	Sleep(0)
	SV.VerticalScrollPosition = Row * cRowHeight
End Sub

'Clears the previous table and loads the CSV file to the table.
'You should first add the Table to the activity before calling this method.
Public Sub LoadTableFromCSV(Dir As String, Filename As String, HeadersExist As Boolean)
	
	Dim List1 As List
	Dim h() As String
	
	cAutomaticWidths = False
	
	If HeadersExist Then
		Dim headers As List
		List1 = StringUtils1.LoadCSV2(Dir, Filename, ",", headers)
		Dim h(headers.Size) As String
		For i = 0 To headers.Size - 1
			h(i) = headers.get(i)
		Next
	Else
		List1 = StringUtils1.LoadCSV(Dir, Filename, ",")
		Dim firstRow() As String
		firstRow = List1.get(0)
		Dim h(firstRow.Length) As String
		For i = 0 To firstRow.Length - 1
			h(i) = "Col" & (i + 1)
		Next
	End If
	innerClearAll(h.Length)
	Dim ColumnWidths(NumberOfColumns) As Int
	Dim HeaderWidths(NumberOfColumns) As Int
	Dim DataWidths(NumberOfColumns) As Int
	For i = 0 To NumberOfColumns - 1
		ColumnWidths(i) = SV.Width / NumberOfColumns
		HeaderWidths(i) = ColumnWidths(i)	
		DataWidths(i) = ColumnWidths(i)
	Next
	SetHeader(h)
	SetColumnsWidths(ColumnWidths)

	For i = 0 To List1.Size - 1
		Dim Row() As String
		Row = List1.get(i)
		AddRow(Row)
	Next
End Sub

'Clears the previous table and loads the CSV file to the table.
'You should first add the Table to the activity before calling this method.
'This method allows to set the separator character and automatic widht calculation.
'Example:
'<code>Table1.LoadTableFromCSV2(File.DirAssets, "citylist.csv", True, ";", True)</code>
Public Sub LoadTableFromCSV2(Dir As String, Filename As String, HeadersExist As Boolean, SeparatorChar As String, AutomaticWidths As Boolean)
	
	Dim List1 As List
	Dim h() As String
	
	cAutomaticWidths = AutomaticWidths
	
	If HeadersExist Then
		Dim headers As List
		List1 = StringUtils1.LoadCSV2(Dir, Filename, SeparatorChar, headers)
		Dim h(headers.Size) As String
		For i = 0 To headers.Size - 1
			h(i) = headers.get(i)
		Next
	Else
		List1 = StringUtils1.LoadCSV(Dir, Filename, SeparatorChar)
		Dim firstRow() As String
		firstRow = List1.get(0)
		Dim h(firstRow.Length) As String
		For i = 0 To firstRow.Length - 1
			h(i) = "Col" & (i + 1)
		Next
	End If
	innerClearAll(h.Length)
	Dim ColumnWidths(NumberOfColumns) As Int
	Dim HeaderWidths(NumberOfColumns) As Int
	Dim DataWidths(NumberOfColumns) As Int
	
	Dim col, Row As Int
	If AutomaticWidths = False Then
		For col = 0 To NumberOfColumns - 1
			ColumnWidths(col) = SV.Width / NumberOfColumns
			HeaderWidths(col) = ColumnWidths(col)
			DataWidths(col) = ColumnWidths(col)
		Next
	Else
		If HeadersExist Then
			Dim strRow(NumberOfColumns) As String
			strRow = List1.get(col)
			For col = 0 To NumberOfColumns - 1
				HeaderWidths(col) = cvs.MeasureStringWidth(headers.get(col), Typeface.DEFAULT, cTextSize)  + ExtraWidth
			Next
		End If
		For Row = 0 To List1.Size - 1
			Dim strRow(NumberOfColumns) As String
			strRow = List1.get(Row)
			For col = 0 To NumberOfColumns - 1
				DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(strRow(col), Typeface.DEFAULT, cTextSize) + ExtraWidth)
			Next
		Next
		For col = 0 To NumberOfColumns - 1
			ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
		Next
	End If
	SetHeader(h)
	
	SetColumnsWidths(ColumnWidths)

	For i = 0 To List1.Size - 1
		Dim strRow() As String
		strRow = List1.get(i)
		AddRow(strRow)
	Next
End Sub

'Saves the table to a CSV file.
Public Sub SaveTableToCSV(Dir As String, Filename As String)
	Dim headers(NumberOfColumns) As String
	For i = 0 To headers.Length - 1
		Dim L As Label
		L = Header.GetView(i)
		headers(i) = L.Text
	Next
	StringUtils1.SaveCSV2(Dir, Filename, ",", Data, headers)
End Sub

' new functunality added by nir -->
' remove a row
'row is the row number
Public Sub RemoveRow(Row As Int)	
	If (Row <0 OR Row > Data.Size-1) Then Return ' cant remove row outside of the table scope
	
	SV_ScrollChanged(SV.HorizontalScrollPosition,SV.VerticalScrollPosition) ' this strange call will set min/max visible area
	'Dim sr As Int ' to keep the previos selected row (in case IsMultiSelect is off)
	'sr = -1 ' not the selected row
	
	Dim prevIndex As Int 
	prevIndex = SelectedRows.IndexOf(Row) ' if the rmeoved one was selected or not/
	
	For i=0 To SelectedRows.Size -1 ' updated selection
		Dim keepSel As Int
		keepSel = SelectedRows.get(i)
		If (keepSel > Row) Then 			
			SelectedRows.set(i,keepSel-1) ' dec row number in all rows appear after the soon tobe removed removed row
			' future optimization: hide and show all rows touched and that within visible range, for now we hide/show all rows in visible scope
		End If
	Next 
	
	If (prevIndex <> -1) Then 
		'sr = Row ' in case the row was selected keep it in sr
		SelectedRows.RemoveAt(prevIndex) ' removed the current row from the selected list
	End If
	
	Data.RemoveAt(Row)
	For i = minVisibleRow To maxVisibleRow ' hide all visible rows
		HideRow(i)
	Next

'	If IsMultiSelect = False Then
'		If sr = Row Then ' current selected row was deleted
'			sr = -1
'		Else If sr > Row Then
'			sr = sr - 1
'		End If
'	End If

	If Data.Size > 0 Then
		maxVisibleRow = Min(maxVisibleRow, Data.Size - 1) ' adjust visible rows
		minVisibleRow = Min(minVisibleRow, Data.Size - 1)
		For i = minVisibleRow To maxVisibleRow ' show all visible rows (should select the ones needed to be selected as well)
		'If (IsMultiSelect OR sr = i) Then HideRow(i) ' in multi select we made too much mess, we need to redraw the whole view (can be optimized if needed!)
			ShowRow(i)
		Next
	End If
	
	SV.Panel.Height = Data.Size * cRowHeight
	updateIPLocation	
	
	SV_ScrollChanged(SV.HorizontalScrollPosition,Min(SV.VerticalScrollPosition, SV.Panel.Height))
	If (lblStatusLine.IsInitialized AND enableStatusLineAutoFill=True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?	
End Sub

' return array of strings hold all the values for a row.
Public Sub GetValues(Row As Int ) As String()
	Dim rowData() As String  = Data.get(Row) ' will throw an excpetion if row is not correct
	Dim tmp(NumberOfColumns) As String
	For i=0 To NumberOfColumns-1 ' copy the array
		tmp(i) =  rowData(i)
	Next
	Return tmp
End Sub

' insert a new row at a specific index
Public Sub insertRowAt (Row As Int, Values() As String) As Boolean
	If (Row < 0) Then Row = 0
	If (Row > Data.Size) Then 
		AddRow(Values)
		Return True		
	End If
    SV_ScrollChanged(SV.HorizontalScrollPosition,SV.VerticalScrollPosition) ' this strange call will set min/max visible area

	Dim L As List
	L.Initialize
	L.Add(Values)
	' fix selection
	For i=0 To SelectedRows.Size -1 ' updated selection
		Dim keepSel As Int
		keepSel = SelectedRows.get(i)
		If (keepSel >= Row) Then 			
			SelectedRows.set(i,keepSel+1) ' dec row number in all rows appear after the soon tobe removed removed row
			' future optimization: hide and show all rows touched and that within visible range, for now we hide/show all rows in visible scope
		End If
	Next 
	For i = minVisibleRow To maxVisibleRow 
		HideRow(i)
	Next
	Data.AddAllAt(Row,L) ' now I can add the row
	
	SV_ScrollChanged(SV.HorizontalScrollPosition,SV.VerticalScrollPosition) ' this strange call will set min/max visible area	

	For i = minVisibleRow To maxVisibleRow 
		ShowRow(i)
	Next
	
	SV.Panel.Height = Data.Size * cRowHeight
	updateIPLocation	
	SV_ScrollChanged(SV.HorizontalScrollPosition,Min(SV.VerticalScrollPosition, SV.Panel.Height))	
	If (lblStatusLine.IsInitialized AND enableStatusLineAutoFill = True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
	Return False
End Sub

' update a row in the table
' row is the row number to update, Values is an array of string at the size of the number of columns
' return true is worked out, false if failed
Public Sub UpdateRow(Row As Int, Values () As String) As Boolean
	Dim i As Int
	If (Values.Length <> NumberOfColumns OR Row <0 OR Row>Data.Size-1) Then
		Return False
	End If
	For i=0 To Values.Length-1
		SetValue(i,Row,Values(i))
	Next
	Return True
End Sub

Public Sub clearSelection
    'SV_ScrollChanged(SV.HorizontalScrollPosition,SV.VerticalScrollPosition) ' this strange call will set min/max visible area	
	SelectedRows.Clear
	refreshTable
End Sub

' refresh / redraw the visible part of the table
Private Sub refreshTable
	SV_ScrollChanged(SV.HorizontalScrollPosition,SV.VerticalScrollPosition) ' this strange call will set min/max visible area	
	For i = minVisibleRow To maxVisibleRow ' hide all visible rows
		HideRow(i)
		ShowRow(i)
 	Next
End Sub

' return true if the table is set to multi select 
Public Sub getMultiSelect As Boolean 
	Return IsMultiSelect
End Sub

' set multi select flag, and clear the selected list (just in case)
' when IsMultiSelect is true, click on a not selected row will add that row to the selected list of rows, and click on an selected row will unselect it
' when IsMultiSelect is false, click on a row will select it (or reselect it if alreday selected)
Public Sub setMultiSelect(ms As Boolean)
	clearSelection
	IsMultiSelect = ms
End Sub

Public Sub getAllowSelection As Boolean 
	Return cAllowSelection
End Sub

' set allow selection flag, and clear the selected list (just in case)
' AllowSelection = True by default
Public Sub setAllowSelection(AllowSelection As Boolean)
	cAllowSelection = AllowSelection
	If pnlTable.IsInitialized Then
		clearSelection
	End If
End Sub

' return the header panel
Public Sub getHeaderPanel As Panel
	Return Header
End Sub

' return the selected row numbers as a list of int.
Public Sub getSelectedRows As List
	Dim sr As List
	sr.Initialize
	sr.AddAll(SelectedRows)
	Return sr
End Sub

' set column col to length '1' which means it will be hidden
Public Sub hideCol(col As Int) 
	Dim tmpWidths(SavedWidths.Length) As Int
	For i = 0 To SavedWidths.Length-1
		tmpWidths(i) = SavedWidths(i) 
	Next
	tmpWidths(col) = 1
	SetColumnsWidths(tmpWidths)	
End Sub

' unhide column col, and give it a new size ???
Public Sub unHideCol(col As Int, newSize As Int) 
	Dim tmpWidths(SavedWidths.Length) As Int
	For i=0 To SavedWidths.Length-1
		tmpWidths(i) = SavedWidths(i) 
	Next
	tmpWidths(col) = newSize
	SetColumnsWidths(tmpWidths)
End Sub

Public Sub setStatusLine(s As String)
	If (lblStatusLine.IsInitialized) Then lblStatusLine.Text = s
End Sub

Private Sub IP_Click
'	Log ("panel clicked!")
	If SubExists(Callback, Event & "_HeaderClick") Then
		CallSub2(Callback, Event & "_HeaderClick", -1)
	End If
End Sub

' update top/height for internalPanel
Private Sub updateIPLocation
	If (SV.Height > Data.Size * cRowHeight) Then
'		Log("updateIPLocation") 
		internalPanel.Top = Data.Size * cRowHeight + cHeaderHeight
		internalPanel.Height = SV.Height - (Data.Size * cRowHeight)
	Else
		internalPanel.Height = 0
	End If
End Sub

Public Sub getSize As Long
	Return Data.Size
End Sub

'Gets or sets the Table Left property
Public Sub setLeft(Left As Int)
   pnlTable.Left = Left
End Sub

Public Sub getLeft As Int
   Return pnlTable.Left
End Sub

'Gets or sets the Table Left property
Public Sub setTop(Top As Int)
   pnlTable.Top = Top
End Sub

Public Sub getTop As Int
   Return pnlTable.Top
End Sub

'Gets or sets the Table Width property
Public Sub setWidth(Width As Int)
   pnlTable.Width = Width
   SV.Width = Width
   internalPanel.Width = Width
   updateIPLocation
End Sub   

Public Sub getWidth As Int
   Return pnlTable.Width
End Sub

'Gets or sets the Table Height property
Public Sub setHeight(Height As Int)
   pnlTable.Height = Height
   If (showStatusLine = True) Then
     SV.Height = Height - cRowHeight - cHeaderHeight
   Else
     SV.Height = Height - cHeaderHeight 
   End If
   lblStatusLine.Top = SV.Top + SV.Height
   updateIPLocation
End Sub

Public Sub getHeight As Int
	Return pnlTable.Height
End Sub

'Gets or sets the Table Visible property
Public Sub setVisible(Visible As Boolean)
   pnlTable.Visible = Visible
End Sub

Public Sub getVisible As Boolean
	Return pnlTable.Visible
End Sub

'Gets or sets the grid line wisth
Public Sub setLineWidth(LineWidth As Int)
   cLineWidth = LineWidth
End Sub

Public Sub getLineWidth As Int
   Return cLineWidth
End Sub

Private Sub Header_Click
	Dim L As Label
	Dim col As Int
	L = Sender
	col = L.Tag
	'If SubExists(Callback, Event & "_HeaderClick") Then
	'	CallSub2(Callback, Event & "_HeaderClick", col)
	'End If
	
	If cSortColumn = True Then
		Dim dir As Int = 0 ' unsorted
		If (sortedCol = col) Then ' we are sorting the same col, reverse dir
			Select sortingDir
				Case 0: dir = -1 ' going up
				Case 1: dir = -1
				Case -1: dir = 1
			End Select
		Else
			dir = -1 ' start with going up
		End If
		sortedCol = col
		sortingDir = dir	
		sortTable(col,dir <=0)
		showHeaderSorting(col, dir)	
	End If
	
	If SubExists(Callback, Event & "_HeaderClick") Then
		CallSub2(Callback, Event & "_HeaderClick", col)
	End If
End Sub

Public Sub showHeaderSorting(col As Int,dir As Int)
	'For i = 0 To NumberOfColumns-1
	'	Dim v As View 
	'	v = Header.GetView(i)
	'	
	'Next
	
	Dim ll As Int = 40
	sortingView.RemoveView
	If (dir = 0) Then Return ' remove the view only

	If (dir = -1) Then 
		sortingView.SetBackgroundImage(LoadBitmapSample(File.DirAssets, "sort_asc.png", ll, ll))
	Else 
		sortingView.SetBackgroundImage(LoadBitmapSample(File.DirAssets, "sort_desc.png", ll, ll))
	End If

	Dim v As View 
	v = Header.GetView(col)
	Dim L As Int ' calculate left
	Dim t As Int ' calculate top
	L = v.Left + v.Width - ll + 6
	t = v.Top + v.Height - ll + 6
	Header.AddView(sortingView, L, t, ll, ll)	
End Sub

' code for sorting
' http://www.basic4ppc.com/forum/basic4android-getting-started-tutorials/8548-sorting-algorithms-teaching-basic4android.html#post47730

' sort the table by column number and direction
' col is the column number starting with 0
' dir as direction true = acc, false = dec
Public Sub sortTable(col As Int, dir As Boolean)
'	Log ("sorting table for col:" & col)
	clearSelection
	debug_counter = 0
	'QuickSort(0,Data.Size-1, col, dir) ' TODO add dir
	SelectionSort(col, dir)
	refreshTable
End Sub

Public Sub SelectionSort (col As Int, dir As Boolean) 
	Dim minIndex As Int
	For i = 0 To Data.Size- 1
		minIndex = i
		For j = i + 1 To Data.Size - 1
			Dim values1() As String = Data.get(j)
			Dim s1 As String = values1(col)
			Dim values2() As String = Data.get(minIndex)
			Dim s2 As String = values2(col)
			If (dir) Then
				If s1.CompareTo(s2) < 0 Then minIndex = j
			Else 
				If s1.CompareTo(s2) > 0 Then minIndex = j
			End If
		Next
		SwapList(i, minIndex)
	Next
End Sub

' code for sorting
' http://www.basic4ppc.com/forum/basic4android-getting-started-tutorials/8548-sorting-algorithms-teaching-basic4android.html#post47730

' sort the table by column number and direction
' col is the column number starting with 0
' dir as direction true = acc, false = dec
Public Sub sortTableNum(col As Int, dir As Boolean)
'	Log ("sorting table for col:" & col)
	clearSelection
	debug_counter = 0
	'QuickSort(0,Data.Size-1, col, dir) ' TODO add dir
	SelectionSortNum(col, dir)
	refreshTable
End Sub

Public Sub SelectionSortNum (col As Int,dir As Boolean) 
	Dim minIndex As Int
	For i = 0 To Data.Size- 1
		minIndex = i
		For j = i + 1 To Data.Size - 1
			Dim values1() As String = Data.get(j)
			Dim s1 As Double = values1(col)
			Dim values2() As String = Data.get(minIndex)
			Dim s2 As Double = values2(col)
			If (dir) Then
				If s1 < s2 Then minIndex = j
			Else 
				If s1 > s2 Then minIndex = j
			End If
		Next
		SwapList(i, minIndex)
	Next
End Sub

Public Sub SwapList(index1 As Int, index2 As Int)
	Dim temp As Object
	temp = Data.get(index1)
	Data.set(index1,Data.get(index2))
	Data.set(index2,temp)
'	Dim addindex1 As Boolean = False  ' add after transfer selction to map
'	Dim addindex2 As Boolean = False
'	If (SelectedRows.containKey(index1)) Then addindex2 = True
'	If (SelectedRows.containKey(index2)) Then addindex1 = True
'	If (addindex1 <> addindex2 AND addindex1 = True) Then 
'		SelectedRows.Remove(addindex2)
'		SelectedRows.put(addindex1,addindex1)
'	Else If (addindex1 <> addindex2 AND addindex2 = True) Then 
'		SelectedRows.Remove(addindex1)
'		SelectedRows.put(addindex2,addindex2)	
'	End If 
End Sub

' True to automatically show number of rows in status line, false to turn it off
Public Sub setStatusLineAutoFill(status As Boolean) 
	enableStatusLineAutoFill = status
End Sub

' ------------------------------------ not in use for now ---------------------------------
' not in use, fail in big numbers where the value is the same
Public Sub QuickSort (left As Int, right As Int, col As Int, dir As Boolean)
	debug_counter = debug_counter +1
'	Log ("counter=" & debug_counter)
	If right > left Then
		Dim pivotIndex, pivotNewIndex As Int
		pivotIndex = Rnd(left, right + 1) 'max value is exclusive
		pivotNewIndex = Partition(left, right, pivotIndex, col,dir)
		QuickSort(left, pivotNewIndex - 1, col, dir)
		QuickSort(pivotNewIndex + 1, right, col, dir)
	End If
End Sub

Public Sub Partition (left As Int, right As Int, pivotIndex As Int, col As Int, dir As Boolean) As Int
	Dim storeIndex As Int
	Dim pivotValues() As String
	Dim pivotValue As String
	pivotValues = Data.get(pivotIndex)
	pivotValue = pivotValues(col)
	SwapList(pivotIndex, right)
	storeIndex = left
	For i = left To right - 1
		Dim values() As String = Data.get(i)
		Dim s As String = values(col)
		If (dir) Then 
			If s.CompareTo(pivotValue) < 0 Then ' dir is < acc, > dec
				SwapList(i, storeIndex)
				storeIndex = storeIndex + 1
			End If
		Else 
			If s.CompareTo(pivotValue) > 0 Then ' dir is < acc, > dec
				SwapList(i, storeIndex)
				storeIndex = storeIndex + 1
			End If
		End If 
	Next
	SwapList(storeIndex, right)
	Return storeIndex
End Sub

'sets the cell alignment for each column each column can have a diferent alignment
'Example:'<code>'Dim alignments() As Int
'alignments = Array As Int (Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL), Gravity.CENTER, Bit.Or(Gravity.RIGHT, Gravity.CENTER_VERTICAL), Gravity.CENTER)
'Table1.SetCellAlignments(alignments)</code>
Public Sub SetCellAlignments(Alignments() As Int)
	Dim i As Int
	
	If Alignments.Length <> NumberOfColumns Then
		ToastMessageShow("The number of aligments is not equal to the number of columns.", False)
		Return
	End If
	
	Dim i As Int
	Dim cAlignments0(NumberOfColumns) As Int
	
	For i = 0 To NumberOfColumns - 1
		cAlignments0 = Alignments
		cAlignments = cAlignments0
	Next
	MultiAlignments = True
	If Data.Size > 0 Then
		refreshTable
	End If
End Sub

'sets the cell alignments for each column all columns with the same alignment
'Example:
'<code>Table1.CellAlignment = Bit.OR(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)</code>
Public Sub setCellAlignment(Alignment As Int)
	Dim i As Int
	
	cAlignment = Alignment
	Dim cAlignments(NumberOfColumns) As Int
	For i = 0 To NumberOfColumns - 1
		cAlignments(i) = cAlignment
	Next
	MultiAlignments = False
	If Data.Size > 0 Then
		refreshTable
	End If
End Sub

'sets the header alignment for each column each column can have a diferent alignment
'Example:'<code>'Dim alignments() As Int
'alignments = Array As Int (Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL), Gravity.CENTER, Bit.Or(Gravity.RIGHT, Gravity.CENTER_VERTICAL), Gravity.CENTER)
'Table1.SetHeaderAlignments(Alignments)</code>
Public Sub SetHeaderAlignments(Alignments() As Int)
	Dim i As Int
	
	If Alignments.Length <> NumberOfColumns Then
		ToastMessageShow("The number of aligments is not equal to the number of columns.", False)
		Return
	End If
	
	Dim i As Int
	Dim cHeaderAlignments0(NumberOfColumns) As Int
	
	For i = 0 To NumberOfColumns - 1
		cHeaderAlignments0 = Alignments
		cHeaderAlignments = cHeaderAlignments0
		Dim lbl As Label
		lbl = Header.GetView(i)
		lbl.Gravity = cHeaderAlignments(i)
	Next
	HeaderMultiAlignments = True
End Sub

'sets the header alignments for each column, all columns with the same alignment
'Example:
'<code>Table1.HeaderAlignment = Bit.OR(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)</code>
Public Sub setHeaderAlignment(Alignment As Int)
	Dim i As Int
	
	cHeaderAlignment = Alignment
	For i = 0 To NumberOfColumns - 1
		cHeaderAlignments(i) = cHeaderAlignment
		Dim lbl As Label
		lbl = Header.GetView(i)
		lbl.Gravity = cHeaderAlignments(i)
	Next
	HeaderMultiAlignments = False
End Sub

Public Sub getCellAlignment As Int
	Return cAlignment
End Sub

'sets or gets the header height
Public Sub setHeaderHeight(Height As Int)
	cHeaderHeight = Height
		If Header.IsInitialized Then
		Header.Height = cHeaderHeight
		SV.Top = cHeaderHeight
		If showStatusLine = True Then
			SV.Height = pnlTable.Height - cHeaderHeight - cRowHeight
		Else
			SV.Height = pnlTable.Height - cHeaderHeight
		End If
	End If
End Sub

Public Sub getHeaderHeight As Int
	Return cHeaderHeight
End Sub

'sets or gets the header color
Public Sub setHeaderColor(Color As Int)
	cHeaderColor = Color
End Sub

Public Sub getHeaderColor As Int
	Return cHeaderColor
End Sub

'sets or gets the header text color
Public Sub setHeaderTextColor(Color As Int)
	cHeaderTextColor = Color
End Sub

Public Sub getHeaderTextColor As Int
	Return cHeaderTextColor
End Sub

'sets or gets the odd rows color
Public Sub setRowColor1(Color As Int)
	cRowColor1 = Color
	If pnlTable.IsInitialized Then
		innerClearAll(NumberOfColumns)
	End If
End Sub

Public Sub getRowColor1 As Int
	Return cRowColor1
End Sub

'sets or gets the even rows color
Public Sub setRowColor2(Color As Int)
	cRowColor2 = Color
	If pnlTable.IsInitialized Then
		innerClearAll(NumberOfColumns)
	End If
End Sub

Public Sub getRowColor2 As Int
	Return cRowColor2
End Sub

'sets or gets the selected row color
Public Sub setSelectedRowColor(Color As Int)
	cSelectedRowColor = Color
	If pnlTable.IsInitialized Then
		innerClearAll(NumberOfColumns)
	End If
End Sub

Public Sub getSelectedRowColor As Int
	Return cSelectedRowColor
End Sub

'sets or gets the selected cell color
Public Sub setSelectedCellColor(Color As Int)
	cSelectedCellColor = Color
	If pnlTable.IsInitialized Then
		innerClearAll(NumberOfColumns)
	End If
End Sub

Public Sub getSelectedCellColor As Int
	Return cSelectedCellColor
End Sub

'sets or gets the table color (color of lines between cells)
Public Sub setTableColor(Color As Int)
	cTableColor = Color
	SV.Panel.Color = cTableColor
	If Header.IsInitialized Then
		Header.Color = cTableColor
	End If
End Sub

Public Sub getTableColor As Int
	Return cTableColor
End Sub

'sets or gets the cell text color
Public Sub setTextColor(Color As Int)
	cTextColor = Color
	Dim i As Int
	For i = 0 To SV.Panel.NumberOfViews - 1
		Dim lbl As Label
		lbl = SV.Panel.GetView(i)
		lbl.TextColor = cTextColor
	Next
End Sub

Public Sub getTextColor As Int
	Return cTextColor
End Sub

'sets or gets the cell text size
Public Sub setTextSize(Size As Float)
	cTextSize = Size
	Dim i As Int
	
	For i = 0 To Header.NumberOfViews - 1
		Dim lbl As Label
		lbl = Header.GetView(i)
		lbl.TextSize = cTextSize
	Next

	For i = 0 To SV.Panel.NumberOfViews - 1
		Dim lbl As Label
		lbl = SV.Panel.GetView(i)
		lbl.TextSize = cTextSize
	Next
End Sub

Public Sub getTextSize As Float
	Return cTextSize
End Sub

'sets or gets the row height
Public Sub setRowHeight(RowHeight As Int)
	If cRowHeight = cHeaderHeight Then
		setHeaderHeight(RowHeight)
	End If
	cRowHeight = RowHeight
End Sub

Public Sub getRowHeight As Int
	Return cRowHeight
End Sub

'Sets different typefaces for columns
'If TypeFaces() is an array with only one TypeFace this one is applied to all columns.
'This method must be called before filling the table
'Example code:
'<code>Dim tf() As TypeFace
'tf = Array As Typeface(Typeface.DEFAULT, Typeface.DEFAULT_BOLD, , Typeface.DEFAULT, Typeface.DEFAULT_BOLD)
'Table1.SetTypeFaces(tf)</code>
Public Sub SetTypeFaces(TypeFaces() As Typeface)
	If TypeFaces.Length <> NumberOfColumns Then
		ToastMessageShow("Invalid number of columns", False)
		Return
	End If
	
	If TypeFaces.Length = 1 Then
		cTypeFace = TypeFaces(0)
		MultiTypeFace = False
	Else	
		cTypeFaces = TypeFaces
		MultiTypeFace = True
	End If
	
	If Data.Size > 0 Then
		refreshTable
	End If
End Sub

'load data from a SQLite database
'SQLite = SQL object
'Query = SQLite query
'AutomaticWidths  True > set the column widths automaticaly
'ATTENTION: if you expect REAL numbers with more than 7 digits you should use LoadSQLiteDB2
'SQLite limits REAL numbers converted to Strings like Floats (7 digits) not Doubles
Public Sub LoadSQLiteDB(SQLite As SQL, Query As String, AutomaticWidths As Boolean)
	Dim Curs As Cursor
	Curs = SQLite.ExecQuery(Query)
	
	cAutomaticWidths = AutomaticWidths
	NumberOfColumns = Curs.ColumnCount
	innerClearAll(NumberOfColumns)
	
	Dim Headers(NumberOfColumns) As String
	Dim ColumnWidths(NumberOfColumns) As Int
	Dim HeaderWidths(NumberOfColumns) As Int
	Dim DataWidths(NumberOfColumns) As Int
	Dim col, row As Int
	Dim str As String
	For col = 0 To NumberOfColumns - 1
		Headers(col) = Curs.GetColumnName(col)
		If AutomaticWidths = False Then
			ColumnWidths(col) = 130dip
			HeaderWidths(col) = 130dip
			DataWidths(col) = 130dip
		Else
			HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), Typeface.DEFAULT, cTextSize) + ExtraWidth
			DataWidths(col) = 0
			For row = 0 To Curs.RowCount - 1
				Curs.Position = row
				str = Curs.GetString2(col)
				If str <> Null Then
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, Typeface.DEFAULT, cTextSize) + ExtraWidth)
				End If
			Next
			ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
		End If
	Next
	SetHeader(Headers)
	SetColumnsWidths(ColumnWidths)
	
	For row = 0 To Curs.RowCount - 1
		Dim R(NumberOfColumns), str As String
		For col = 0 To NumberOfColumns - 1
			Curs.Position = row
			str = Curs.GetString2(col)
			If str <> Null Then
				R(col) = str
			Else
				R(col) = ""
			End If
		Next
		AddRow(R) 
	Next
	
	Curs.Close
End Sub

'load data from a SQLite database
'SQLite = SQL object
'Query = SQLite query
'AutomaticWidths  True > set the column widths automaticaly
'ColumDataTypes Array od strings with the data types
'		"I" = INTEGER
'		"R" = REAL
'		"T" = TEXT
'Example:
'<Table1.LoadSQLiteDB2(SQL1, "SELECT * FROM Test", True, Array As String("I", "T", "R", "I"))\>
Public Sub LoadSQLiteDB2(SQLite As SQL, Query As String, AutomaticWidths As Boolean, ColumnDataTypes() As String)
	Dim Curs As Cursor
	Curs = SQLite.ExecQuery(Query)
	
	cAutomaticWidths = AutomaticWidths
	NumberOfColumns = Curs.ColumnCount
	innerClearAll(NumberOfColumns)
	
	Dim Headers(NumberOfColumns) As String
	Dim ColumnWidths(NumberOfColumns) As Int
	Dim HeaderWidths(NumberOfColumns) As Int
	Dim DataWidths(NumberOfColumns) As Int
	Dim col, row As Int
	Dim ii As Long
	Dim dd As Double
	Dim str As String
	For col = 0 To NumberOfColumns - 1
		Headers(col) = Curs.GetColumnName(col)
		If AutomaticWidths = False Then
			ColumnWidths(col) = 130dip
			HeaderWidths(col) = 130dip
			DataWidths(col) = 130dip
		Else
			HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), Typeface.DEFAULT, cTextSize) + ExtraWidth
			DataWidths(col) = 0
			For row = 0 To Curs.RowCount - 1
				Curs.Position = row
				str = Curs.GetString2(col)
				If str <> Null Then
					Select ColumnDataTypes(col)
					Case "I"
						ii = Curs.GetInt2(col)
						str = ii
					Case "R"
						dd = Curs.GetDouble2(col)
						str = dd
					End Select
				Else
					str = ""
				End If
				DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, Typeface.DEFAULT, cTextSize) + ExtraWidth)
			Next
			ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
		End If
	Next
	SetHeader(Headers)
	SetColumnsWidths(ColumnWidths)

	For row = 0 To Curs.RowCount - 1
		Curs.Position = row
		Dim R(NumberOfColumns), str As String
		For col = 0 To NumberOfColumns - 1
			str = Curs.GetString2(col)
			If str = Null Then
				R(col) = ""
			Else
				Select ColumnDataTypes(col)
				Case "I"
					ii = Curs.GetLong2(col)
					R(col) = ii
				Case "R"
					dd = Curs.GetDouble2(col)
					R(col) = dd
				Case "T"
					R(col) = Curs.GetString2(col)
				Case Else '"BLOB"
					R(col) = ""
				End Select
			End If
		Next
		AddRow(R) 
	Next
	
	Curs.Close
End Sub

Public Sub RemoveView
	pnlTable.RemoveView
End Sub

Private Sub SetPadding(v As View, Left As Int, Top As Int, Right As Int, Bottom As Int)
	Dim r As Reflector
	r.Target = v
	r.RunMethod4("setPadding", Array As Object(Left, Top, Right, Bottom), Array As String("java.lang.int", "java.lang.int", "java.lang.int", "java.lang.int"))
End Sub

'A Header click sorts the selected column If SortColum = True 
Public Sub setSortColumn(SortColumn As Boolean)
	cSortColumn = SortColumn
End Sub

Public Sub getSortColumn As Boolean
	Return cSortColumn
End Sub

'Uses different column colors insted of different row colors if UseColumnColors = True
Public Sub setUseColumnColors(UseColumnColors As Boolean)
	cUseColumnColors = UseColumnColors
	If cColumnColors.Length = 0 Then
		Dim i As Int
		Dim cColumnColors(NumberOfColumns) As Int
		Dim cTextColors(NumberOfColumns) As Int
		For i = 0 To NumberOfColumns - 1
			If i Mod 2 = 0 Then
				cColumnColors(i) = cRowColor1
			Else
				cColumnColors(i) = cRowColor2
			End If
			cTextColors(i) = cTextColor
		Next
	End If
	
		If cHeaderColors.Length = 0 Then
		Dim i As Int
		Dim cHeaderColors(NumberOfColumns) As Int
		Dim cHeaderTextColors(NumberOfColumns) As Int
		For i = 0 To NumberOfColumns - 1
			cHeaderColors(i) = cHeaderColor
			cHeaderTextColors(i) = cHeaderTextColor
		Next
	End If
End Sub

Public Sub getUseColumnColors As Boolean
	Return cUseColumnColors
End Sub

'Sets the colors for each column
Public Sub SetColumnColors(ColumnColors() As Int)
	cColumnColors = ColumnColors
End Sub

Public Sub GetColumnColors As Int()
	Return cColumnColors
End Sub

'Sets the colors for the text in each column
Public Sub SetTextColors(TextColors() As Int)
	cTextColors = TextColors
End Sub

Public Sub GetTextColors As Int()
	Return cTextColors
End Sub

'Sets the colors for each Header
Public Sub SetHeaderColors(HeaderColors() As Int)
	cHeaderColors = HeaderColors
End Sub

Public Sub GetHeaderColors As Int()
	Return cHeaderColors
End Sub

'Sets the colors for each Header text
Public Sub SetHeaderTextColors(HeaderTextColors() As Int)
	cHeaderTextColors = HeaderTextColors
End Sub

Public Sub GetHeaderTextColors As Int()
	Return cHeaderTextColors
End Sub

'True sets the cells to single line
Public Sub setSingleLine(SingleLine As Boolean)
	cSingleLine = SingleLine
End Sub

Public Sub getSingleLine As Boolean
	Return cSingleLine
End Sub

Public Sub SetAutomaticWidths
	Dim row, col As Int
	Dim Vals(NumberOfColumns) As String
	Dim Width, Widths(NumberOfColumns) As Int
	
	cAutomaticWidths = True
	
	For col = 0 To NumberOfColumns - 1
		If MultiTypeFace = False Then
			Widths(col) = cvs.MeasureStringWidth(HeaderNames.Get(col), cTypeFace, cTextSize) + ExtraWidth
		Else
			Widths(col) = cvs.MeasureStringWidth(HeaderNames.Get(col), cTypeFaces(col), cTextSize) + ExtraWidth
		End If

		For row = 0 To Data.Size - 1
			Vals = Data.Get(row)
			If MultiTypeFace = False Then
				Width = cvs.MeasureStringWidth(Vals(col), cTypeFace, cTextSize) + ExtraWidth
			Else
				Width = cvs.MeasureStringWidth(Vals(col), cTypeFaces(col), cTextSize) + ExtraWidth
			End If
			If Widths(col) < Width Then
				Widths(col) = Width
			End If
		Next
	Next
	SetColumnsWidths(Widths)
End Sub