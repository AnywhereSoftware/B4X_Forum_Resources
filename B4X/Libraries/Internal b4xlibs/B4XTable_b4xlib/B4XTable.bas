B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#DesignerProperty: Key: EvenRowColor, DisplayName: Even Row Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: OddRowColor, DisplayName: Odd Row Color, FieldType: Color, DefaultValue: #FFEAEAEA
#DesignerProperty: Key: HeaderColor, DisplayName: Header Color, FieldType: Color, DefaultValue: #FFECECEC
#DesignerProperty: Key: HeaderTextColor, DisplayName: Header Text Color, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: #FF313131
#DesignerProperty: Key: HighlightTextColor, DisplayName: Highlight Text Color, FieldType: Color, DefaultValue: 0xFFFF0000
#DesignerProperty: Key: GridColor, DisplayName: Grid Color, FieldType: Color, DefaultValue: 0xFFD7D7D7
#DesignerProperty: Key: SelectionColor, DisplayName: Selection Color, FieldType: Color, DefaultValue: 0xFF0094FF
#DesignerProperty: Key: SearchVisible, DisplayName: Search Visible, FieldType: Boolean, DefaultValue: True

#Event: CellClicked (ColumnId As String, RowId As Long)
#Event: CellLongClicked (ColumnId As String, RowId As Long)
#Event: DataUpdated
#Event: HeaderClicked (ColumnId As String)
#Event: HeaderLongClicked (ColumnId As String)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	Public sql1 As SQL
	Type B4XTableColumn (Title As String, Id As String, ColumnType As Int, Sortable As Boolean, Searchable As Boolean, _
		Formatter As B4XFormatter, SQLID As String, Width As Int, ComputedWidth As Int, CellsLayouts As List, _
		Panel As B4XView, LabelIndex As Int, DisableAutoResizeLayout As Boolean, InternalSortMode As String)
	Public COLUMN_TYPE_TEXT = 1, COLUMN_TYPE_NUMBERS = 2, COLUMN_TYPE_DATE = 3, COLUMN_TYPE_VOID = 4 As Int
	Public Columns As List
	Public VisibleColumns As List
	Private mFirstRowIndex, mLastRowIndex As Int
	Public DefaultFormatter, DefaultDataFormatter As B4XFormatter
	Public pnlHeader As B4XView
	Public pnlTitles As B4XView
	Public clvData As CustomListView
	Public RowHeight, HeadersHeight As Int
	Public AllowSmallRowHeightModifications As Boolean = True
	Private mRowsPerPage As Int = 0
	Private LayoutLoaded As Boolean
	Public MinimumWidth As Int
	Private SQLIndex As Int
	Public EvenRowColor, OddRowColor, HeaderTextColor, TextColor, HighlightTextColor, HeaderColor, GridColor As Int
	Public HighlightSearchResults As Boolean = True
	Public HeaderFont, LabelsFont As B4XFont
	Public lblFirst As B4XView
	Public lblBack As B4XView
	Public lblNumber As B4XView
	Public lblNext As B4XView
	Public lblLast As B4XView
	Public lblFromTo As B4XView
	Private CountAll As Int
	Private mCurrentPage As Int
	Public mCurrentCount As Int
	Public lblSort As B4XView
	Public SearchField As B4XFloatTextField
	Private FilterText As String
	Public SleepBeforeSearch As Int = 300
	Private SearchIndex As Int
	Public ArrowsEnabledColor, ArrowsDisabledColor As Int
	Public VisibleRowIds As List
	Public SelectionColor As Int
	Private SQLTableName As String = "data"
	Public StringMoreAvailable As String = "(more available)"
	Public StringNoMatches As String = "No matches"
	Public StringOutOf As String = "out of"
	Public StringTo As String = "to"
	Public MaximumRowsPerPage As Int
	Public PrefixSearch As Boolean
	#if B4J
	Private TextFlow As B4JTextFlow
	Private const TextPaneTag As String = "TextFlow"
	#End If
	Private LastBaseHeight As Int
	Public NumberOfFrozenColumns As Int
	Private LastCellClickEvent As Long
	#if B4i
	Private FeedbackGenerator As NativeObject
	#End If
	Public SearchVisible As Boolean
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Columns.Initialize
	DefaultFormatter.Initialize
	DefaultDataFormatter.Initialize
	VisibleColumns.Initialize
	HeaderFont = xui.CreateDefaultBoldFont(15)
	LabelsFont = xui.CreateDefaultFont(15)
	ArrowsDisabledColor = 0xFFBBBBBB
	ArrowsEnabledColor = xui.Color_Black
	VisibleRowIds.Initialize
	MinimumWidth = 140dip
	RowHeight = 40dip
	HeadersHeight = 40dip
	#if B4J
	TextFlow.Initialize
	#Else If B4i
	FeedbackGenerator = FeedbackGenerator.Initialize("UIImpactFeedbackGenerator").RunMethod("alloc", Null).RunMethod("initWithStyle:", Array(0)) 'light
	#End If
End Sub


Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	LastBaseHeight = mBase.Height
	Tag = mBase.Tag : mBase.Tag = Me
	LayoutLoaded = False
	EvenRowColor = xui.PaintOrColorToColor(Props.Get("EvenRowColor"))
	OddRowColor = xui.PaintOrColorToColor(Props.Get("OddRowColor"))
	HeaderTextColor = xui.PaintOrColorToColor(Props.Get("HeaderTextColor"))
	TextColor = xui.PaintOrColorToColor(Props.Get("TextColor"))
	HeaderColor = xui.PaintOrColorToColor(Props.Get("HeaderColor"))
	GridColor = xui.PaintOrColorToColor(Props.Get("GridColor"))
	SelectionColor = xui.PaintOrColorToColor(Props.Get("SelectionColor"))
	HighlightTextColor = xui.PaintOrColorToColor(Props.GetDefault("HighlightTextColor", 0xFFFF0000))
	SearchVisible = Props.GetDefault("SearchVisible", True)
	If Bit.And(SelectionColor, 0xff000000) = 0 Then SelectionColor = 0
	Sleep(0)
	mBase.LoadLayout("B4XTable")
	SearchField.mBase.Visible = False
	SearchField.LargeLabelTextSize = 14
	SearchField.SmallLabelTextSize = 8
	SearchField.Update
	#if B4A
	Dim jo As JavaObject = SearchField.TextField
	jo.RunMethod("setImeOptions", Array(Bit.Or(6, 0x10000000))) 'DONE + NO_EXTRACT_IO
	#else if B4i
	Dim sv As ScrollView = clvData.sv
	sv.Bounces = False
	#End If
	SetMouseTransparent(lblSort)
	clvData.AsView.SetColorAndBorder(0, 0, 0, 0)
	clvData.sv.SetColorAndBorder(0, 0, 0, 0)
	lblNumber.TextColor = ArrowsEnabledColor
	LayoutLoaded = True
	ClearNavigationState
	Refresh2 (True, False)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	Refresh2 (False, False)
End Sub

'Clears the columns and data.
Public Sub Clear
	SQLIndex = SQLIndex + 1
	Dim OldSQL As SQL = sql1
	Dim sql1 As SQL
	For Each c As B4XTableColumn In Columns
		If c.Panel.IsInitialized And c.Panel.Parent.IsInitialized Then
			c.Panel.RemoveViewFromParent
		End If
	Next
	VisibleColumns.Clear
	Columns.Clear
	SQLTableName = "data"
	If clvData.IsInitialized Then
		clvData.Clear
	End If
	mFirstRowIndex = 0
	ClearNavigationState
	If OldSQL.IsInitialized Then
		Sleep(1000)
		If OldSQL.IsInitialized Then
			OldSQL.Close
		End If
	End If
End Sub

Private Sub ClearNavigationState
	If lblNext.IsInitialized = False Then Return
	SetPageLabelState(lblNext, False)
	SetPageLabelState(lblLast, False)
	SetPageLabelState(lblBack, False)
	SetPageLabelState(lblFirst, False)
	lblFromTo.Text = ""
	lblNumber.Text = ""
End Sub

'Refreshes the table. 
Public Sub Refresh
	Refresh2(True, False)
End Sub

'Synchronously refreshes the table.
Public Sub RefreshNow
	Refresh2(True, True)
End Sub

Private Sub Refresh2 (RefreshData As Boolean, DontSleep As Boolean)
	If LayoutLoaded = False Or VisibleColumns.Size = 0 Then Return
	Dim PrevRowsPerPage As Int = mRowsPerPage
	If xui.IsB4A And LastBaseHeight <> mBase.Height Then
		clvData.AsView.Height = clvData.AsView.Height - (LastBaseHeight - mBase.Height)
		clvData.Base_Resize(clvData.AsView.Width, clvData.AsView.Height)
		LastBaseHeight = mBase.Height
	End If
	Dim TotalHeight As Int = clvData.AsView.Height - HeadersHeight
	If xui.IsB4J Then
		TotalHeight = TotalHeight - 20
	End If
	If AllowSmallRowHeightModifications Then
		mRowsPerPage = Max(0, Round(TotalHeight/ RowHeight))
	Else
		mRowsPerPage = Max(0, Floor(TotalHeight / RowHeight))
	End If
	If MaximumRowsPerPage > 0 Then
		mRowsPerPage = Min(MaximumRowsPerPage, mRowsPerPage)
		TotalHeight = Min(TotalHeight, MaximumRowsPerPage * RowHeight)
	End If
	If PrevRowsPerPage <> mRowsPerPage Then RefreshData = True
	CalculateWidths
	Dim ColumnIndex As Int
	
	For Each c As B4XTableColumn In VisibleColumns
		Dim IsFrozen As Boolean = ColumnIndex < NumberOfFrozenColumns
		If c.Panel.Parent.IsInitialized Then
			CheckAndRemoveColumnThatWasAddedToIncorrectParent(c, IsFrozen)
		End If
		If c.Panel.Parent.IsInitialized = False Then
			c.Panel.Width = c.ComputedWidth
			If IsFrozen Then
				mBase.AddView(c.Panel, 0, 0, 0, 0)
			Else
				AddColumnToCLV (c)
			End If
		End If
		
		CreateColumnLayouts(c, mRowsPerPage + 1)
		ResizeColumnImpl(c, TotalHeight)
		ColumnIndex = ColumnIndex + 1
	Next
	If RefreshData Then UpdateData (DontSleep)
	Dim FreezedWidth As Int
	For i = 0 To NumberOfFrozenColumns - 1
		Dim c As B4XTableColumn = VisibleColumns.Get(i)
		#if B4J
		Dim offset As Float = 1
		#else
		Dim offset As Float = 0
		#end if
		c.Panel.SetLayoutAnimated(0, offset + FreezedWidth, clvData.AsView.Top + offset, c.ComputedWidth, _
			clvData.AsView.Height)
		FreezedWidth = FreezedWidth + c.ComputedWidth
	Next
	clvData.AsView.Left = FreezedWidth
	If Round(clvData.AsView.Width) <> Round(mBase.Width - FreezedWidth) Then
		clvData.AsView.Width = mBase.Width - FreezedWidth
		If xui.IsB4A Then clvData.Base_Resize(clvData.AsView.Width, clvData.AsView.Height)
	End If
	ResizeAndReorderCLVItems
	UpdateSearchFieldVisibility
	UpdateSortIcon
End Sub

Private Sub ResizeAndReorderCLVItems
	Dim i As Int = NumberOfFrozenColumns
	Do While i < VisibleColumns.Size
		Dim c As B4XTableColumn = VisibleColumns.Get(i)
		Dim CLVIndex As Int = i - NumberOfFrozenColumns
		If c <> clvData.GetValue(CLVIndex) Then
			RemoveColumnFromCLV(c)
			clvData.InsertAt(CLVIndex, c.Panel, c)
		Else
			clvData.ResizeItem(CLVIndex, c.ComputedWidth)
		End If
		i = i + 1
	Loop
End Sub

Private Sub UpdateSearchFieldVisibility
#if B4J
	Sleep(100) 'workaround for a JavaFX drawing bug
#end if
	SearchField.mBase.Visible = SearchVisible And CountAll > 0
End Sub

Private Sub CheckAndRemoveColumnThatWasAddedToIncorrectParent(c As B4XTableColumn, IsFrozen As Boolean)
	If (c.Panel.Parent = mBase) <> IsFrozen Then
		If IsFrozen Then
			RemoveColumnFromCLV(c)
		Else
			c.Panel.RemoveViewFromParent
		End If
	End If
End Sub

Private Sub RemoveColumnFromCLV (c As B4XTableColumn)
	For i = 0 To clvData.Size - 1
		If clvData.GetValue(i) = c Then
			clvData.RemoveAt(i)
			Exit
		End If
	Next
	c.Panel.RemoveViewFromParent
End Sub

Private Sub ResizeColumnImpl (c As B4XTableColumn, TotalHeight As Int)
	c.Panel.Width = c.ComputedWidth
	
	Dim Height As Float = TotalHeight / mRowsPerPage
	If AllowSmallRowHeightModifications = False Then Height = RowHeight
	Dim TopInt, HeightInt As Int
	For i = 0 To c.CellsLayouts.Size - 1
		Dim p As B4XView = c.CellsLayouts.Get(i)
		If i < mRowsPerPage + 1 Then
			Dim HeightInt As Int = Round(Height * i + HeadersHeight - TopInt)
			If i = 0 Then HeightInt = HeadersHeight
			p.SetLayoutAnimated(0, 0, TopInt, c.ComputedWidth, HeightInt)
			p.Visible = True
			If c.DisableAutoResizeLayout = False Then
				Dim lbl As B4XView = p.GetView(0)
				lbl.SetLayoutAnimated(0, 0, 0, p.Width, p.Height)
				#if B4J
				If c.Searchable And p.NumberOfViews > 1 And p.GetView(1).Tag = TextPaneTag Then
					p.GetView(1).Width = p.Width
				End If
				#End If
			End If
			TopInt = TopInt + HeightInt
		Else
			p.Visible = False
		End If
	Next
End Sub

Private Sub UpdateData (DontSleep As Boolean)
	If sql1.IsInitialized = False Then Return
	Dim o() As Object = BuildQuery(True)
'	Log(sb.ToString)
	ImplUpdateDataFromQuery (o(0), o(1), o(2), DontSleep)
End Sub

'Builds the SQL query based on the current table state. You can use it to export the table filtered and sorted table data.
'Returns an array of objects. The first item is the query and the second item is the arguments. 
Public Sub BuildQuery (WithPageLimit As Boolean) As Object()
	Dim SortColumn As String
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("SELECT rowid")
	For Each c As B4XTableColumn In VisibleColumns
		If c.ColumnType = COLUMN_TYPE_VOID Then Continue
		sb.Append(",").Append(c.SQLID)
		If c.InternalSortMode <> "" Then
			SortColumn = " ORDER BY " & c.SQLID & " " & c.InternalSortMode
		End If
	Next
	sb.Append(" FROM ").Append(SQLTableName).Append(" ")
	Dim args As List
	args.Initialize
	Dim TotalCount As Int
	If FilterText = "" Then
		TotalCount = CountAll
	Else
		For Each c As B4XTableColumn In VisibleColumns
			If c.Searchable Then
				If args.Size = 0 Then
					sb.Append(" WHERE ")
				Else
					sb.Append(" OR ")
				End If
				sb.Append(c.SQLID).Append(" LIKE ? ")
				If PrefixSearch Then
					args.Add(FilterText & "%")
				Else
					args.Add("%" & FilterText & "%")
				End If
			End If
		Next
		TotalCount = -1
	End If
	If SortColumn <> "" Then sb.Append(SortColumn)
	If WithPageLimit Then
		Dim limit As Int = mRowsPerPage
		If TotalCount < 0 Then limit = limit + 1
		sb.Append($" LIMIT ${mFirstRowIndex}, ${limit}"$)
	End If
	#if B4A
	Dim aargs(args.Size) As String
	For i = 0 To args.Size - 1
		aargs(i) = args.Get(i)
	Next
	#else
	Dim aargs As List = args
	#End If
	Return Array(sb.ToString, aargs, TotalCount)
End Sub

'Filters the data. Call ClearDataView to remove the filter.
Public Sub CreateDataView (WhereClause As String)
	sql1.ExecNonQuery("DROP VIEW IF EXISTS TempView")
	sql1.ExecNonQuery("CREATE VIEW TempView AS SELECT *, rowid FROM data WHERE " & WhereClause)
	CountAll = sql1.ExecQuerySingleResult("SELECT count(*) FROM TempView")
	mFirstRowIndex = 0
	SQLTableName = "TempView"
	UpdateData (False)
End Sub

Public Sub ClearDataView
	SQLTableName = "data"
	mFirstRowIndex = 0
	CountAll = sql1.ExecQuerySingleResult("SELECT count(*) FROM data")
	UpdateData (True)
End Sub

'Update the table counters. Should be called after adding or removing items from the table.
Public Sub UpdateTableCounters
	CountAll = sql1.ExecQuerySingleResult("SELECT count(*) FROM data")
	UpdateData (True)
End Sub

Private Sub ImplUpdateDataFromQuery (Query As String, Args As Object, TotalCount As Int, DontSleep As Boolean)
	SQLIndex = SQLIndex + 1
	If mRowsPerPage = 0 Then Return
	
	Dim MyIndex As Int = SQLIndex
	If DontSleep = False Then
		Sleep(40)
	End If
	If MyIndex <> SQLIndex Then
		Return
	End If
	VisibleRowIds.Clear

	Dim rs As ResultSet = sql1.ExecQuery2(Query, Args)
	Dim success As Boolean = True
'	Dim SenderFilter As Object = sql1.ExecQueryAsync("SQL1", Query, Args)
'	Wait For (SenderFilter) SQL1_QueryComplete (success As Boolean, rs As ResultSet)
'	If MyIndex <> SQLIndex Then Return
	If success Then
		Dim RowNumber As Int = 1
		Do While RowNumber <= mRowsPerPage And rs.NextRow
			VisibleRowIds.Add(rs.GetLong("rowid"))
			For Each c As B4XTableColumn In VisibleColumns
				Dim lbl As B4XView = GetLabelFromColumn(c, RowNumber)
				Select c.ColumnType
					Case COLUMN_TYPE_TEXT
						SetTextToCell(rs.GetString(c.SQLID), lbl, c.Searchable)
					Case COLUMN_TYPE_NUMBERS
						c.Formatter.FormatLabel(rs.GetDouble(c.SQLID), lbl)
					Case COLUMN_TYPE_DATE
						lbl.Text = DateTime.Date(rs.GetLong(c.SQLID))
				End Select
			Next
			RowNumber = RowNumber + 1
		Loop
		Dim AreThereMoreResults As Boolean = RowNumber = mRowsPerPage + 1 And rs.NextRow
		rs.Close
		For i = RowNumber To mRowsPerPage
			For Each c As B4XTableColumn In VisibleColumns
				#if B4J
				SetTextToCell("", GetLabelFromColumn(c, i), c.Searchable)
				#else
				GetLabelFromColumn(c, i).Text = ""
				#End If
			Next
			VisibleRowIds.Add(0)
		Next
		mLastRowIndex = mFirstRowIndex - 2 + RowNumber
		SetPageLabelState(lblLast, TotalCount >= 0)
		If TotalCount >= 0 Then
			If TotalCount = 0 Then
				lblFromTo.Text = ""
			Else
				lblFromTo.Text = $"${DefaultFormatter.Format(mFirstRowIndex + 1)} ${StringTo} ${DefaultFormatter.Format(mLastRowIndex + 1)} ${StringOutOf} ${DefaultFormatter.Format(TotalCount)}"$
			End If
			SetPageLabelState(lblNext, mLastRowIndex < TotalCount - 1)
			SetPageLabelState(lblLast, lblNext.Tag)
		Else
			If mLastRowIndex = -1 Then
				lblFromTo.Text = StringNoMatches
			Else
				lblFromTo.Text = $"${DefaultFormatter.Format(mFirstRowIndex + 1)} ${StringTo} ${DefaultFormatter.Format(mLastRowIndex + 1)}"$
				If AreThereMoreResults Then lblFromTo.Text = lblFromTo.Text & " " & StringMoreAvailable
			End If
			SetPageLabelState(lblNext, AreThereMoreResults)
			SetPageLabelState(lblLast, False)
		End If
		SetPageLabelState(lblBack, mFirstRowIndex > 0)
		SetPageLabelState(lblFirst, lblBack.Tag)
		mCurrentPage = Ceil(mFirstRowIndex / mRowsPerPage) + 1
		lblNumber.Text = NumberFormat(mCurrentPage, 0, 0)
		rs.Close
		mCurrentCount = TotalCount
	Else
		Log(LastException)
	End If
	If xui.SubExists(mCallBack, mEventName & "_DataUpdated", 0) Then
		CallSub(mCallBack, mEventName & "_DataUpdated")
	End If
End Sub

Private Sub SetTextToCell (Text As String, lbl As B4XView, Searchable As Boolean)
	If Searchable = False Or HighlightSearchResults = False Then
		lbl.Text = Text
	Else
	#if B4J
		Dim parent As B4XView = lbl.Parent
		If parent.GetView(parent.NumberOfViews - 1).Tag = TextPaneTag Then
			parent.GetView(parent.NumberOfViews - 1).RemoveViewFromParent	
		End If
	#End If
		If FilterText = "" Then
			lbl.Text = Text
		Else
			Dim x As Int = Text.ToLowerCase.IndexOf(FilterText)
			If x = -1 Or (PrefixSearch And x > 0) Then
				lbl.Text = Text
				Return
			End If
		
		#if B4A or B4i
			Dim cs As CSBuilder
			cs.Initialize.Append(Text.SubString2(0, x)).Color(HighlightTextColor).Append(Text.SubString2(x, x + FilterText.Length)).Pop
			cs.Append(Text.SubString(x + FilterText.Length))
			#if B4A
			lbl.Text = cs
			#else if B4i
			Dim l As Label = lbl
			l.AttributedText = cs
			#End If
		End If
		#Else
			TextFlow.Reset
			If x > 0 Then
				TextFlow.Append(Text.SubString2(0, x)).SetColor(TextColor).SetFont(LabelsFont)
			End If
			TextFlow.Append(Text.SubString2(x, x + FilterText.Length)).SetColor(HighlightTextColor).SetFont(LabelsFont)
			If x + FilterText.Length < Text.Length Then
				TextFlow.Append(Text.SubString(x + FilterText.Length)).SetColor(TextColor).SetFont(LabelsFont)
			End If
			Dim TextPane As B4XView = TextFlow.CreateTextFlow
			TextPane.Tag = TextPaneTag
			lbl.Text = ""
			parent.AddView(TextPane, 0, parent.Height / 2 - 12, parent.Width, parent.Height / 2)
		End If
		#end if
	End If
End Sub

'Gets the column with the given id. By default the id is the same as the title.
Public Sub GetColumn (ColumnId As String) As B4XTableColumn
	For Each c As B4XTableColumn In Columns
		If c.Id = ColumnId Then Return c
	Next
	Return c
End Sub

Private Sub SetPageLabelState (lbl As B4XView, enabled As Boolean)
	If lbl.Tag = enabled Then Return
	lbl.Tag = enabled
	If enabled Then
		lbl.TextColor = ArrowsEnabledColor
	Else
		lbl.TextColor = ArrowsDisabledColor
	End If
End Sub

Private Sub GetLabelFromColumn (c As B4XTableColumn, Index As Int) As B4XView
	Dim p As B4XView = c.CellsLayouts.Get(Index)
	Return p.GetView(c.LabelIndex)
End Sub

Private Sub CalculateWidths
	Dim wildcardcount As Int
	Dim TotalExplicitWidth As Int
	For Each c As B4XTableColumn In VisibleColumns
		If c.Width = 0 Then wildcardcount = wildcardcount + 1 Else c.ComputedWidth = c.Width
		TotalExplicitWidth = TotalExplicitWidth + c.Width
	Next
	If wildcardcount = 0 Then Return
	Dim WildcardWidth As Int = Max(wildcardcount * MinimumWidth, mBase.Width - 2dip - TotalExplicitWidth)
	Dim Width As Int = WildcardWidth / wildcardcount
	Dim Remainder As Int = WildcardWidth Mod wildcardcount
	For Each c As B4XTableColumn In VisibleColumns
		If c.Width = 0 Then
			c.ComputedWidth = Width
			If Remainder > 0 Then
				Remainder = Remainder - 1
				c.ComputedWidth = c.ComputedWidth + 1
			End If
		End If
	Next
End Sub

Private Sub AddColumnToCLV (c As B4XTableColumn)
	clvData.Add(c.Panel, c)
End Sub

'Adds a column.
'Title - Column title.
'ColumnType - One of the COLUMN_TYPE constants.

Public Sub AddColumn (Title As String, ColumnType As Int) As B4XTableColumn
	Dim c As B4XTableColumn
	c.Initialize
	c.Title = Title
	c.ColumnType = ColumnType
	c.Sortable = ColumnType <> COLUMN_TYPE_VOID
	c.Searchable = ColumnType = COLUMN_TYPE_TEXT
	c.CellsLayouts.Initialize
	c.Formatter = DefaultDataFormatter
	c.Panel = xui.CreatePanel("ColumnPanel")
	c.Panel.Tag = c
	c.Id = Title
	Columns.Add(c)
	VisibleColumns.Add(c)
	CreateColumnLayouts(c, mRowsPerPage + 1)
	Dim header As B4XView = GetLabelFromColumn(c, 0)
	SetTextOrCSBuilderToLabel (header, Title)
	If LayoutLoaded Then
		AddColumnToCLV(c)
	End If
	Return c
End Sub

'Builds a cache of cell layouts. This is useful if you want to modify the default layout.
Public Sub BuildLayoutsCache (Size As Int)
	For Each c As B4XTableColumn In Columns
		CreateColumnLayouts(c, Size + 1)
	Next
End Sub

Private Sub CreateColumnLayouts (c As B4XTableColumn, Size As Int)
	For i = c.CellsLayouts.Size To Size - 1
		Dim p As B4XView = CreateCellViews
		Dim lbl As B4XView = p.GetView(c.LabelIndex)
		c.CellsLayouts.Add(p)
		Dim clr, tclr As Int
		Dim fnt As B4XFont
		If i = 0 Then
			clr = HeaderColor
			tclr = HeaderTextColor
			fnt = HeaderFont
		Else
			fnt = LabelsFont
			tclr = TextColor
			If i Mod 2 = 1 Then
				clr = EvenRowColor
			Else
				clr = OddRowColor
			End If
		End If
		lbl.Font = fnt
		p.SetColorAndBorder(clr, 1dip, GridColor, 0)
		lbl.TextColor = tclr
		lbl.SetTextAlignment("CENTER", "CENTER")
		p.Tag = i
		c.Panel.AddView(p, 0, 0, 0, 0)
	Next
End Sub

'Sets the table data.
'Returns a ResumableSub object. You can call this method with Wait For to continue after it completes.
'Example: <code>Wait For (Table.SetData(Data)) Complete (Unused As Boolean)</code>
Public Sub SetData (Data As List) As ResumableSub
	If sql1.IsInitialized Then sql1.Close
	#if B4J
	sql1.InitializeSQLite("", ":memory:", True)
	#Else If B4A OR B4I
	sql1.Initialize("", ":memory:", True)
	#End If
	CreateTable
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("INSERT INTO data VALUES (")
	For Each Column As B4XTableColumn In Columns
		If Column.ColumnType = COLUMN_TYPE_VOID Then Continue
		sb.Append("?,")
	Next
	sb.Remove(sb.Length - 1, sb.Length)
	sb.Append(")")
	If Data.Size > 0 Then
		If Data.Get(0) Is List Then
			For Each lrow As Object In Data
				sql1.AddNonQueryToBatch(sb.ToString, lrow)
			Next
		Else
			For Each row() As Object In Data
				sql1.AddNonQueryToBatch(sb.ToString, row)
			Next
		End If
		
	End If
	Dim SenderFilter As Object = sql1.ExecNonQueryBatch("SQL1")
'	Dim n As Long = DateTime.Now
	Wait For (SenderFilter) SQL1_NonQueryComplete (Success As Boolean)
'	Log($"Set data time: ${DateTime.Now - n}ms"$)
	CountAll = Data.Size
	RefreshNow
	Return True
End Sub

Private Sub CreateTable
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("CREATE TABLE data (")
	Dim i As Int
	For Each Column As B4XTableColumn In Columns
		If Column.ColumnType = COLUMN_TYPE_VOID Then Continue
		Column.SQLID = "c" & i
		sb.Append(Column.SQLID & " " & ColumnToSQLType(Column) & ",")
		i = i + 1
	Next
	sb.Remove(sb.Length - 1, sb.Length)
	sb.Append(")")
	sql1.ExecNonQuery(sb.ToString)
End Sub

Private Sub ColumnToSQLType (c As B4XTableColumn) As String
	If c.ColumnType = COLUMN_TYPE_TEXT Then Return "TEXT" Else Return "INTEGER"
End Sub


Private Sub CreateCellViews As B4XView
	Dim p As B4XView = xui.CreatePanel("cell")
	Dim lbl As Label
	lbl.Initialize("lbl")
	SetMouseTransparent(lbl)
	Dim xlbl As B4XView = lbl
	xlbl.SetTextAlignment("CENTER", "CENTER")
	p.AddView(xlbl, 0, 0, 0, 0)
	Return p
End Sub

#if B4A or B4i
Private Sub lbl_Click
	Dim lbl As B4XView = Sender
	CellClicked(lbl.Parent, False)
End Sub

Private Sub lbl_LongClick
	Dim lbl As B4XView = Sender
	CellClicked(lbl.Parent, True)
End Sub

Private Sub Cell_Click
	CellClicked(Sender, False)
End Sub

Private Sub Cell_LongClick
	CellClicked(Sender, True)
End Sub

#else
Private Sub Cell_MouseClicked (EventData As MouseEvent)
	EventData.Consume
	CellClicked(Sender, EventData.SecondaryButtonPressed)
End Sub
#end if

Private Sub SetMouseTransparent (lbl As B4XView) 'ignore
	#if B4J
	Dim jo = lbl As JavaObject
	jo.RunMethod("setMouseTransparent", Array(True))
	#End If
End Sub

Private Sub SetTextOrCSBuilderToLabel(xlbl As B4XView, Text As Object)
	#if B4A or B4J
	xlbl.Text = Text
	#else if B4i
	If Text Is CSBuilder And xlbl Is Label Then
		Dim lbl As Label = xlbl
		lbl.AttributedText = Text
	Else 
		If GetType(Text) = "__NSCFNumber" Then Text = "" & Chr(Text)
		xlbl.Text = Text
	End If
	#end if
End Sub



Private Sub CellClicked (pnl As B4XView, LongClicked As Boolean)
	If DateTime.Now < LastCellClickEvent + 20 Then Return
	LastCellClickEvent = DateTime.Now
	Dim column As B4XTableColumn = pnl.Parent.Tag
	Dim Row As Int = pnl.Tag - 1
	Dim e As String
	If Row = -1 Then
		If LongClicked Then
			e = "_headerlongclicked"
		Else
			e = "_headerclicked"
			HeaderClicked(column)
		End If
		If xui.SubExists(mCallBack, mEventName & e, 1) Then
			#if B4i
			If LongClicked Then FeedbackGenerator.RunMethod("impactOccurred", Null)
			#End If
			CallSub2(mCallBack, mEventName & e, column.Id)
		End If
	Else If VisibleRowIds.Size > 0 Then
		Dim RowId As Long = VisibleRowIds.Get(Row)
		If RowId > 0 Then
			Dim clr As Int
			If Row Mod 2 = 0 Then clr = EvenRowColor Else clr = OddRowColor
			
			If LongClicked Then
				e = "_CellLongClicked"
			Else
				e = "_cellclicked"
				If SelectionColor <> 0 Then pnl.SetColorAnimated(50, clr, SelectionColor)
			End If
			
			If xui.SubExists(mCallBack, mEventName & e, 2) Then
			#if B4i
				If LongClicked Then FeedbackGenerator.RunMethod("impactOccurred", Null)
			#End If
				CallSub3(mCallBack, mEventName & e, column.Id, VisibleRowIds.Get(Row))
			End If
			If LongClicked = False Then
				Sleep(200)
				If pnl.IsInitialized Then
					If SelectionColor <> 0 Then pnl.SetColorAnimated(200, SelectionColor, clr)
				End If
			End If
		End If
	End If
End Sub

Private Sub HeaderClicked (col As B4XTableColumn)
	If col.Sortable Then
		For Each c As B4XTableColumn In Columns
			If c = col Then
				If c.InternalSortMode = "ASC" Then c.InternalSortMode = "DESC" Else c.InternalSortMode = "ASC"
			Else
				c.InternalSortMode = ""
			End If
		Next
		mFirstRowIndex = 0
		UpdateSortIcon
		UpdateData (False)
	End If
End Sub

Private Sub UpdateSortIcon
	For Each col As B4XTableColumn In Columns
		If col.InternalSortMode <> "" Then
			If lblSort.Parent <> col.Panel Then
				lblSort.RemoveViewFromParent
				col.Panel.AddView(lblSort, 0, 0, lblSort.Width, 0)
			End If
			lblSort.Top = 0
			lblSort.Height = HeadersHeight
			lblSort.Left = col.Panel.Width - lblSort.Width
			lblSort.Visible = True
			If col.InternalSortMode = "ASC" Then lblSort.Text = Chr(0xF0DE) Else lblSort.Text = Chr(0xF0DD)
			Return
		End If
	Next
	lblSort.Visible = False
End Sub

'Gets the data of the row with the given row id. The data is returned as a map with the columns ids as the keys.
Public Sub GetRow(RowId As Long) As Map
	Dim m As Map
	m.Initialize
	Dim rs As ResultSet = sql1.ExecQuery2("SELECT * FROM data WHERE rowid = ?", Array As String(RowId))
	If rs.NextRow Then
		For Each c As B4XTableColumn In Columns
			Select c.ColumnType
				Case COLUMN_TYPE_TEXT
					m.Put(c.Id, rs.GetString(c.SQLID))
				Case COLUMN_TYPE_NUMBERS
					m.Put(c.Id, rs.GetDouble(c.SQLID))
				Case COLUMN_TYPE_DATE
					m.Put(c.Id, rs.GetLong(c.SQLID))
			End Select
		Next
	End If
	rs.Close
	Return m
End Sub

'Gets or sets the index of the first visible row.
Public Sub setFirstRowIndex (row As Int)
	row = Max(0, Min(CountAll - 1, row))
	mFirstRowIndex = row
	UpdateData (False)
End Sub

Public Sub getFirstRowIndex As Int
	Return mFirstRowIndex
End Sub

'Gets the current number of rows per page.
Public Sub getRowsPerPage As Int
	Return mRowsPerPage
End Sub

'Gets or sets the current page.
Public Sub getCurrentPage As Int
	Return mCurrentPage
End Sub

Public Sub setCurrentPage(p As Int)
	setFirstRowIndex((p - 1) * mRowsPerPage)
End Sub

Private Sub lblFirst_Click
	If lblFirst.Tag = False Then Return
	setFirstRowIndex (0)
End Sub

Private Sub lblBack_Click
	If lblBack.Tag = False Then Return
	setFirstRowIndex (mFirstRowIndex - mRowsPerPage)
End Sub

Private Sub lblLast_Click
	If lblLast.Tag = False Then Return
	Dim NumberOfPages As Int = Ceil(mCurrentCount / mRowsPerPage)
	setFirstRowIndex ((NumberOfPages - 1) * mRowsPerPage)
End Sub

Private Sub lblNext_Click
	If lblNext.Tag = False Then Return
	setFirstRowIndex (mFirstRowIndex + mRowsPerPage)
End Sub

#if B4J
Private Sub lblFirst_MouseClicked (EventData As MouseEvent)
	lblFirst_Click
End Sub

Private Sub lblBack_MouseClicked (EventData As MouseEvent)
	lblBack_Click
End Sub


Private Sub lblNext_MouseClicked (EventData As MouseEvent)
	lblNext_Click
End Sub

Private Sub lblLast_MouseClicked (EventData As MouseEvent)
	lblLast_Click
End Sub
#end if

Private Sub SearchField_TextChanged (Old As String, New As String)
	SearchIndex = SearchIndex + 1
	Dim MyIndex As Int = SearchIndex
	Sleep(SleepBeforeSearch)
	If MyIndex <> SearchIndex Then
		Return
	End If
	Dim term As String = New.ToLowerCase
	If term = FilterText Then Return
	FilterText = term
	mFirstRowIndex = 0
	UpdateData (False)
End Sub

'Returns the number of items in the table, or the filtered table if CreateDataView was called.
Public Sub getSize As Int
	Return CountAll
End Sub

