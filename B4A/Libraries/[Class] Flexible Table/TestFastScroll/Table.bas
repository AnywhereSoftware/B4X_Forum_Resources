B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Table CustomView
'Version 3.20
'Added FastScroll feature
'
'Version 3.19
'Improved automatic width calculation and hidden columns 
'
'Version 3.18
'Added a check in RemoveRowColorN to ensure that Row is not out of bounds
'Added ShowRow event
'Amended automatic width calculations
'Amended hidden column width problem
'
'Version 3.17
'Amended HeaderHeight problem with fixed columns
'
'Version 3.16
'Amended error with AddRowAutomaticWidth
'
'Version 3.15
'Amended error in InnerTotalWidth
'
'Version 3.14
'Added the methods below
'LoadSQLiteDB4(SQLite As SQL, Query As String, AutomaticWidths As Boolean)
'LoadSQLiteDB5(SQLite As SQL, Query As String, Values() As String, AutomaticWidths As Boolean)
'GetColumnDataTypes As String()
'GetColumnDataType(Column As Int) As String
'Added the InnerTotalWidth property, read only
'
'Version 3.13
'Added multiple first fiexed columns
'Added line colors
'
'Version 3.12
'This version was an intermediate version never published
'
'Version 3.11
'Amended Alignment and TypeFace problems
'
'Version 3.10
'Amended error with width setting, when first column fixed
'
'Version 3.09
'Amended error whith height setting, the first column wasn't updated. 
'
'Version 3.08
'Improved Hide / Unhide column handling
'Improved SetHeaderTypeFaces and added the HeaderTypeFace property.
'
'Version 3.07
'Added MultiSelect as a Designer property
'
'Version 3.06
'Amended some bugs
'
'Version 3.05
'Added the FirstColumnFixed property which allows to fix the first column
'
'Version 3.04
'Added SelectedRowTextColor and SlectedCellTextColor properties
'Added ZeroSelection property, True > when a selected row is pressed it will be unselected False > it remains selected.
'
'Version 3.03
'Changed JumpToRowAndSelect(Row As Int, Col As Int) to  JumpToRowAndSelect(Col As Int, Row As Int)
'Changed LoadSQLiteDB2 signature. Replaced the possible values from "T", "I", "R" to "TEXT", "NUMBER" for coherence with SetColumnDataTypes
'Added internal sorting bitmaps, avoids loading the image files into the Files folder
'Added two new properties: SortBitmapWidth and SortBitmapColor.
'Added SetCustomSortingBitmaps method, which allows to use custom bitmaps instead of the internal ones.
'
'Version 3.02
'Amended as error, cTypeFace
'
'Version 3.01
'Amended setSingleLine problem

'Version 3.00
'Amended SetColumnColors and SetTextColors
'Removed Reflection library dependency
'
'Version 2.29
'Added SaveTableToCSV2 with a user defined separator character
'
'Version 2.28
'Added SetHeaderTypeFaces
'Added SortRemoveAccents property
'
'Version 2.27
'set the two variables sortedCol and sortingDir to Public instaed of Private
'added RemoveAccent routine for sorting with accented characters
' 
'Version 2.26
'added the LoadSQLiteDB3 method using SQL.ExecQuery2 instead of SQL.ExecQuery

'Version 2.25
'added the UpdateCell method

'Version 2.24
'amended a minor error

'Version 2.22
'improved JumpToRowAndSelect scrolls horizontally to the selected column

'Version 2.21
'improved setHeaderHeight

'Version 2.20
'added padding for status bar Label

'Version 2.19
'replaced DoEvents by Sleep(0)
'
'Version 2.18
'amended error in setHeaderAlignment, missing Private cHeaderAlignments(mNumberOfColumns) As Int
'
'Version 2.17
'Amended an error
'
'Version 2.16
'Amended an error
'
'Version 2.15
'#Event: CellClick(row As Int, col As Int) to #Event: CellClick(col As Int, row As Int)
'#Event: CellLongClick(row As Int, col As Int) to #Event: CellLongClick(col As Int, row As Int)
'
'Version 2.14 Added NumberOfColumns and NumberOfRow as readable properties
'Amended Header_Click error

'Version 2.13
'Amended initialization problem 

'Version 2.12
'Added an array with column data types, this is useful for sorting columns with numbers.
'Added two methods: 
'SetColumnDataType(Col As Int, DataType As String)
'SetColumnDataTypes(DataType() As String)
'Changed Private Sub refreshTable to Public Sub RefreshTable

'Version 2.11
'Added a Scale routine allowing to scale the Table 
'Added Panel property
'Changed the Designer default values the same as the original default values
'TextAlignment and HeaderTextAlignment LEFT becomes CENTER
'TextSize  18 becomes 14
'LineWidth  2 becomes 1

'Version 2.10
'Amended problem with TextAlignmet and HeaderTextAlignment properties

'Version 2.00
'Added CustomView support

'Changes between the previous versions and version 2.00

'For a Table added in the Designer, this is new
'No need to initialize nor add it onto a parent view

'For a Table added in the code
'The Initialize routine has been splittend into two routines
'New:  
'	Initialize (CallBack As Object, EventName As String)
' InitializeTable (vNumberOfColumns As Int, cellAlignement As Int, showStatusL As Boolean)
'Example:
'	Table1.Initialize(Me, "Table1")
'	Table1.InitializeTable(5, Gravity.CENTER_HORIZONTAL, True)

'Old:
'Initialize(CallBack As Object, EventName As String, vNumberOfColumns As Int, cellAlignement As Int, showStatusL As Boolean)
'Example:
'	Table1.InitializeTable(Me, "Table1", 5, Gravity.CENTER_HORIZONTAL, True)

'Version history
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


' these Event lines are useful for a library compilation for the IDE autocompletion
#Event: CellClick(col As Int, row As Int)
#Event: CellLongClick(col As Int, row As Int)
#Event: HeaderClick(col As Int)
#Event: HeaderLongClick(col As Int)
#Event: ScrollChanged(PosX As Int, PosY As Int)
#Event: ShowRow(Row As Int, lbls() As Label)
' these RaisesSynchronousEvents lines are useful for a library compilation
#RaisesSynchronousEvents: CellClick
#RaisesSynchronousEvents: CellLongClick
#RaisesSynchronousEvents: HeaderClick
#RaisesSynchronousEvents: HeaderLongClick
#RaisesSynchronousEvents: ScrollChanged
#RaisesSynchronousEvents: ShowRow

'custom properties
#DesignerProperty: Key: NumberOfColumns, DisplayName: NumberOfColumns, FieldType: Int, DefaultValue: 3, Description: Number of columns.
#DesignerProperty: Key: NumberOfFixedColumns, DisplayName: NumberOfFixedColumns, FieldType: String, DefaultValue: 0, List: 0|1|2|3, Description: Sets the number of first fixed columns max value = 3.
#DesignerProperty: Key: FirstColumnFixed, DisplayName: FirstColumnFixed, FieldType: Boolean, DefaultValue: False, Description: Sets the first column fixed. This property is obsolete. It is replaced by NumberOfFixedColumns.
#DesignerProperty: Key: MultiSelect, DisplayName: MultiSelect, FieldType: Boolean, DefaultValue: False, Description: Allows more than one selected row.
#DesignerProperty: Key:	ZeroSelection, DisplayName: ZeroSelection, FieldType: Boolean, DefaultValue: False, Description: True > when a selected row is pressed it will be unselected False > it remains selected.
#DesignerProperty: Key: RowHeight, DisplayName: Row height, FieldType: Int, DefaultValue: 40, Description: Row height.
#DesignerProperty: Key: HeaderHeight, DisplayName: Header height, FieldType: Int, DefaultValue: 40, Description: Header height.
#DesignerProperty: Key: LineWidth, DisplayName: LineWidth, FieldType: Int, DefaultValue: 1, MinRange: 1, MaxRange: 10, Description: Line width in dips.
#DesignerProperty: Key: TextSize, DisplayName: Text size, FieldType: Int, DefaultValue: 14, Description: Text size.
#DesignerProperty: Key: TextAlignment, DisplayName: Text Alignment, FieldType: String, DefaultValue: CENTER, List: LEFT|CENTER|RIGHT, Description: Set the text alignment.
#DesignerProperty: Key: HeaderTextAlignment, DisplayName: Header text Alignment, FieldType: String, DefaultValue: CENTER, List: LEFT|CENTER|RIGHT, Description: Set the header text alignment.
#DesignerProperty: Key: HeaderColor, DisplayName: Header color, FieldType: Color, DefaultValue: 0xFF808080, Description: Header background color.
#DesignerProperty: Key: TableColor, DisplayName: Table color, FieldType: Color, DefaultValue: 0xFFD3D3D3, Description: Table background color.
#DesignerProperty: Key: HeaderTextColor, DisplayName: Header text color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Table background color.
#DesignerProperty: Key:	CellTextColor, DisplayName: Cell text color, FieldType: Color, DefaultValue: 0xFF000000, Description: Table background color.
#DesignerProperty: Key:	Row1Color, DisplayName: Row 1 color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Row1 background color.
#DesignerProperty: Key:	Row2Color, DisplayName: Row 2 color, FieldType: Color, DefaultValue: 0xFF98F5FF, Description: Row2 background color.
#DesignerProperty: Key:	SelectedRowColor, DisplayName: SelectedRowColor, FieldType: Color, DefaultValue: 0xFF007FFF, Description: Selected row background color.
#DesignerProperty: Key:	SelectedRowTextColor, DisplayName: SelectedRowTextColor, FieldType: Color, DefaultValue: 0xFF007FFF, Description: Selected row text color.
#DesignerProperty: Key:	SelectedCellColor, DisplayName: SelectedCellColor, FieldType: Color, DefaultValue: 0xFFFC8EAC, Description: Selected cett background color.
#DesignerProperty: Key:	SelectedCellTextColor, DisplayName: SelectedCellTextColor, FieldType: Color, DefaultValue: 0xFFFC8EAC, Description: Selected cell text color.
#DesignerProperty: Key:	ShowStatusLine, DisplayName: ShowStatusLine, FieldType: Boolean, DefaultValue: True, Description: Shows or hides the status line.
#DesignerProperty: Key:	SortColumn, DisplayName: SortColumn, FieldType: Boolean, DefaultValue: False, Description: True = Sorts columns, False = doesn't sort columns.
#DesignerProperty: Key:	SortRemoveAccents, DisplayName: SortRemoveAccents, FieldType: Boolean, DefaultValue: False, Description: Sorts without accented characters. Removes the accents for a correct sorting. This can slow down the sorting. Valid only with SortColumn = True.
#DesignerProperty: Key:	SortBitmapWidth, DisplayName: SortBitmapWidth, FieldType: Int, DefaultValue: 10, Description: Width of the sorting bitmap. Valid only with SortColumn = True.
#DesignerProperty: Key:	SortBitmapColor, DisplayName: SortBitmapColor, FieldType: Color, DefaultValue: 0xFFFFFF00, Description: Color of the sorting bitmap. Valid only with SortColumn = True.
#DesignerProperty: Key:	FastScroll, DisplayName: FastScroll, FieldType: Boolean, DefaultValue: False, Description: Allows the FastScroll feature.
#DesignerProperty: Key:	FastScrollMinItems, DisplayName: FastScrollMinItems, FieldType: Int, DefaultValue: 50, Description: Sets the number minumum of items before the fast scroll method is activated.
#DesignerProperty: Key:	FastScrollColumnIndex, DisplayName: FastScrollColumnIndex, FieldType: Int, DefaultValue: 0, Description: Sets the column idex for the display in the fast scroll label.
#DesignerProperty: Key:	FastScrollShowLabel, DisplayName: FastScrollShowLabel, FieldType: Boolean, DefaultValue: True, Description: Shows the FastScroll label.
#DesignerProperty: Key:	FastScrollFixedLabel, DisplayName: FastScrollFixedLabel, FieldType: Boolean, DefaultValue: False, Description: True = Shows the Label at the left in the middle. True = Shows the Label with the cursor.
#DesignerProperty: Key:	FastScrollLabelWidth, DisplayName: FastScrollLabelWidth, FieldType: Int, DefaultValue: 150, Description: Width of the fast scroll Label.

Sub Class_Globals
	Private StringUtils1 As StringUtils
	Private SV2 As ScrollView2D
	Private SVF As ScrollView
	Private pnlTable As Panel
	Private Header As Panel
	Private HeaderFirst As Panel
	Private lblStatusLine As Label
	
	Private pnlFastScroll As Panel
	Private pnlFastScrollCursor As Panel
	Private FScCursorWidth = 25dip As Int
	Private FScCursorHeight = 60dip As Int
	Private FscLabelTopDelta As Int
	Private FScBackgroundColor = Colors.ARGB(48, 128, 128, 128) As Int
	Private FScCursorCol1 = Colors.Blue As Int
	Private FScCursorCol2 = Colors.Yellow As Int
	Private lblFastScroll As Label
	Private FSY0, FSdY, FastScrollHeight As Int
	Private FScScale As Double
	Private FScTimer As Timer
	Private mFastScroll = False As Boolean
	Private FastScrollActive As Boolean
	Private mFastScrollColumnIndex = 0 As Int
	Private mFastScrollMinItems = 50 As Int
	Private mFastScrollShowLabel = True As Boolean
	Private mFastScrollFixedLabel = False As Boolean
	Private mFastScrollLabelWidth = 150dip As Int
	Private mFastScrollLabelHeight = 30dip As Int
	
	Private cCallBack As Object
	Private cEventName As String
	Private cLeft, cTop , cWidth, cHeight As Int
	Public HeaderNames As List
	Public SelectedRows As List ' selected rows ' convert to map!!!
	Private SelectedCol As Int 
	Public Data As List
	Private LabelsCache As List
	Private minVisibleRow, maxVisibleRow As Int
	Private IsVisible As Boolean
	Public visibleRows As Map
	Private mNumberOfColumns, ColumnWidths(), cColumnColors(), cTextColors(), cHeaderColors(), cHeaderTextColors(), DataWidths(), HeaderWidths() As Int
	Private cColumnDataType() As String
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
	Private cTypeFaces0() As Typeface
	Private HeaderMultiTypeFace = False As Boolean
	Private cHeaderTypeFace = Typeface.DEFAULT As Typeface
	Private cHeaderTypeFaces() As Typeface
	Private cHeaderTypeFaces0() As Typeface
	Private cLineWidth = Max(1, 1dip) As Int
	Private ExtraWidth = 12dip + cLineWidth	As Int
	Private SelectedDrawable(), Drawable1(), Drawable2() As Object
	Private SelectedCellDrawable As Object
	Private cRowColor1, cRowColor2, cSelectedRowColor, cSelectedCellColor, cSelectedRowTextColor, cSelectedCellTextColor As Int
	Private cSortColumn = True As Boolean
	Private cUseColumnColors = False As Boolean
	Private cSortRemoveAccents = False As Boolean
	Private mFirstColumnsWidth = 0 As Int
	Private mFirstColumnFixed = False As Boolean
	Private mNumberOfFixedColumns As Int
	Private bmp As Bitmap		' used for the canvas below
	Private cvs As Canvas		' used to measure string widths in the LoadSQLiteDB routine
	Private lstRowColorIndexes As List
	Private lstRowColors As List
	Private lstRowDrawables As List
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
	cSelectedRowTextColor = Colors.Black
	cSelectedCellColor = 0xFFFC8EAC
	cSelectedCellTextColor = Colors.Black
	cRowHeight = 40dip
	cHeaderHeight = cRowHeight
	
	Private cSingleLine = True As Boolean		' does a lable hold a single line text or multiline , need to be set rigth after call to initialize
	
	Private mMultiSelect As Boolean = False
	Private cAllowSelection = True As Boolean
	Private SavedWidths() As Int' to keep the user set widths for columns
	Private cShowStatusLine As Boolean =True

	Private internalPanel As Panel

	Public sortingDir As Int = 0 ' -1,0,1 as acc, unsorted, dec
	Public sortedCol As Int = -1' hold the sorted column -1 for none
	Private pnlSortingView As Panel

	Private debug_counter As Long
	Private enableStatusLineAutoFill As Boolean = True
	
	Private pnlAsc As Panel										'added in version 3.03
	Private bmpAsc, bmpDes As Bitmap					'added in version 3.03
	Private cvsAsc, cvsDes As Canvas					'added in version 3.03
	Private cSortBitmapWidth As Int						'added in version 3.03
	Private cSortBitmapHeight As Int					'added in version 3.03
	Private cSortBitmapColor As Int						'added in version 3.03
	Private mCustomSortingBitmaps As Boolean	'added in version 3.03
	Private mZeroSelection = False As Boolean
	Private SV2Scrolls, SVFScrolls As Boolean
	Private SV2PosX As Int
	Public TableObject As Table
End Sub

Public Sub Initialize (CallBack As Object, EventName As String)
	cEventName = EventName
	cCallBack = CallBack
	
	cSortBitmapWidth = 10dip
	cSortBitmapColor = Colors.Yellow
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	pnlTable = Base
	cLeft = Base.Left
	cTop = Base.Top
	cWidth = Base.Width
	cHeight = Base.Height
	pnlTable.Color = Colors.Transparent
	
	'sets the text alignment property
	Select Props.Get("TextAlignment")
	Case "LEFT"
		cAlignment = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
	Case "CENTER"
		cAlignment = Gravity.CENTER
	Case "RIGHT"
		cAlignment = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.RIGHT)
	End Select

	'sets the header text alignment property	
	Select Props.Get("HeaderTextAlignment")
	Case "LEFT"
		cHeaderAlignment = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
	Case "CENTER"
		cHeaderAlignment = Gravity.CENTER
	Case "RIGHT"
		cHeaderAlignment = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.RIGHT)
	End Select
	
	cLineWidth = DipToCurrent(Props.Get("LineWidth"))
	
	mNumberOfColumns = Props.Get("NumberOfColumns")
	mNumberOfFixedColumns = Props.Get("NumberOfFixedColumns")
	mFirstColumnFixed = Props.Get("FirstColumnFixed")
	If mFirstColumnFixed = True And mNumberOfFixedColumns = 0 Then
		mNumberOfFixedColumns = 1
	End If
	mZeroSelection = Props.Get("ZeroSelection")
	cHeaderColor = Props.Get("HeaderColor")
	cTableColor = Props.Get("TableColor")
	cHeaderTextColor = Props.Get("HeaderTextColor")
	cTextColor = Props.Get("CellTextColor")
	cRowColor1 = Props.Get("Row1Color")
	cRowColor2 = Props.Get("Row2Color")
	cSelectedRowColor = Props.Get("SelectedRowColor")
	cSelectedCellColor = Props.Get("SelectedCellColor")
	
	cTextSize = Props.Get("TextSize")
	
	cRowHeight = DipToCurrent(Props.Get("RowHeight"))
	cHeaderHeight = DipToCurrent(Props.Get("HeaderHeight"))
	cShowStatusLine = Props.Get("ShowStatusLine")

	cSortColumn = Props.Get("SortColumn")
	cSortRemoveAccents = Props.Get("SortRemoveAccents")	
	cSortBitmapWidth = DipToCurrent(Props.Get("SortBitmapWidth"))
	cSortBitmapColor = Props.Get("SortBitmapColor")
	
	mFastScroll = Props.GetDefault("FastScroll", False)
	mFastScrollMinItems = Props.GetDefault("FastScrollMinItems", 50)
	mFastScrollColumnIndex = Props.GetDefault("FastScrollColumnIndex", 0)
	mFastScrollShowLabel = Props.GetDefault("FastScrollShowLabel", True)
	mFastScrollFixedLabel = Props.GetDefault("FastScrollFixedLabel", False)
	mFastScrollLabelWidth = Props.GetDefault("FastScrollLabelWidth", 150dip)
	
	InitTable
End Sub

' add the table to a view of your choice (panel, activity, etc)
' v as the view 
' Left, Top as the start point of the table in that view
' width and height as the width and height of the table in the view, note this include empty space in case not enough lines exists - 
' but the table will take the whole area.
Public Sub AddToView(v As View, Left As Int, Top As Int, Width As Int, Height As Int)
	AddToActivity(v,Left,Top,Width,Height)
End Sub

' add the table to an Activity
' Act is the Activity 
' Left, Top as the start point of the table in that view
' width and height as the width and height of the table in the view, note this include empty space in case not enough lines exists - 
' but the table will take the whole area.
Public Sub AddToActivity(Act As Activity, Left As Int, Top As Int, Width As Int, Height As Int)
	cLeft = Left
	cTop = Top
	cWidth = Width
	cHeight = Height
	
	pnlTable.Initialize("")
	pnlTable.Color = Colors.Transparent
	Act.AddView(pnlTable, cLeft, cTop , cWidth, cHeight)
	
	InitTable	
End Sub

Private Sub InitTable
	Data.Initialize
	lstRowColors.Initialize				'list of the different row colors 
	lstRowColorIndexes.Initialize	'list of the color indexes for each row, always 0 for the the first two colors
	lstRowDrawables.Initialize		'list of the drawables for the different row colors
	
	visibleRows.Initialize
	
	pnlTable.Tag = "Table"
	TableObject = Me
	
	SV2.Initialize(0, 0, "SV2")
	SVF.Initialize2(0, "SVF")
	internalPanel.Initialize("IP")
	innerClearAll(mNumberOfColumns, True)

	SV2.Panel.Color = cTableColor
	SV2.FadingEdges(False)
	SVF.Panel.Color = cTableColor
	IsVisible = True
	HeaderFirst.Initialize("")
	HeaderFirst.Color = cTableColor
	Header.Initialize("")
	Header.Color = cTableColor
	
	If mNumberOfFixedColumns = 0 Then
		mFirstColumnsWidth = 0
	Else
		mFirstColumnsWidth = 100dip
	End If
	pnlTable.AddView(Header, mFirstColumnsWidth, 0 , cWidth - mFirstColumnsWidth, cHeaderHeight)
	pnlTable.AddView(HeaderFirst, 0, 0, mFirstColumnsWidth, cHeaderHeight)
	
	' add status line
	lblStatusLine.Initialize("")
	lblStatusLine.Color = Colors.Transparent ' is it really ?
	internalPanel.Color = Colors.Transparent 'TODO uncomment this
	If (cShowStatusLine = True) Then
		pnlTable.AddView(SVF, 0, Header.Height, cWidth, cHeight - Header.Height - cRowHeight)
		pnlTable.AddView(SV2, mFirstColumnsWidth, Header.Height, cWidth - mFirstColumnsWidth, cHeight - Header.Height - cRowHeight)
		pnlTable.AddView(lblStatusLine,0, SV2.Top + SV2.Height, cWidth, cRowHeight)
	Else
		pnlTable.AddView(SV2, mFirstColumnsWidth, Header.Height, cWidth - mFirstColumnsWidth, cHeight - Header.Height)
		pnlTable.AddView(SVF, 0, Header.Height, cWidth, cHeight - Header.Height)
		pnlTable.AddView(lblStatusLine,0, SV2.Top + SV2.Height, 0, 0)
	End If
	SetPadding(lblStatusLine, 4dip, 2dip, 4dip, 2dip)
	pnlTable.AddView(internalPanel, 0, 0, cWidth, 0)
	
	pnlFastScroll.Initialize("pnlFastScroll")
	pnlFastScroll.Color = FScBackgroundColor
	pnlFastScroll.Visible = False
	pnlTable.AddView(pnlFastScroll,  cWidth - FScCursorWidth, SV2.Top, FScCursorWidth, SV2.Height)
	pnlFastScrollCursor.Initialize("")
	pnlFastScrollCursor.Color = Colors.White
	pnlFastScroll.AddView(pnlFastScrollCursor,  0, 0, FScCursorWidth, FScCursorHeight)
	lblFastScroll.Initialize("")
	Private cdw As ColorDrawable
	cdw.Initialize2(Colors.White, 3dip, 1dip, Colors.Black)
	lblFastScroll.Background = cdw
	lblFastScroll.TextColor = Colors.Black
	lblFastScroll.Gravity = Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL)
	lblFastScroll.Padding = Array As Int(5dip, 0, 0, 0)
	lblFastScroll.Visible = False
	If mFastScrollFixedLabel = False Then
		pnlTable.AddView(lblFastScroll,  cWidth - mFastScrollLabelWidth - FScCursorWidth, FscLabelTopDelta, mFastScrollLabelWidth, 30dip)
	Else
		pnlTable.AddView(lblFastScroll,  0, (SV2.Height - mFastScrollLabelHeight) / 2, mFastScrollLabelWidth, mFastScrollLabelHeight)
	End If
	FScTimer.Initialize("FastScrollTimer", 1500)
	
	updateIPLocation

	InitFastScroll
	
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Dim SavedWidths(mNumberOfColumns) As Int
	Dim cColumnDataType(mNumberOfColumns) As String
	For i = 0 To mNumberOfColumns - 1
		ColumnWidths(i) = SV2.Width / mNumberOfColumns
		HeaderWidths(i) = ColumnWidths(i)
		DataWidths(i) = ColumnWidths(i)
		SavedWidths(i) = ColumnWidths(i)
		cColumnDataType(i) = "TEXT"
	Next
	SVF.Panel.Width = SVF.Width
	SVF_ScrollChanged(0)
	SV2.Panel.Width = SV2.Width
	SV2_ScrollChanged(0, 0)
	
	InitFastScroll
	
	If (lblStatusLine.IsInitialized And enableStatusLineAutoFill=True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?

	pnlSortingView.Initialize("")
	If mCustomSortingBitmaps = False Then
		InitializeSortingBitmaps
	End If

	' used for string width measuements in the LoadSQLiteDB routine
	bmp.InitializeMutable(2dip, 2dip)
	cvs.Initialize2(bmp)
	
	'adds the Touch event on top of the SV2 ScrollView
'	Private jo As JavaObject
'	jo = SV2
'	Private e As Object = jo.CreateEvent("android.view.View.OnTouchListener", "SV2_Touch", False)
'	jo.RunMethod("setOnTouchListener", Array As Object(e))

End Sub

' InitializeTable
' vNumberOfColumns = number of columns including hidden ones
'                    enter 1 if you use either LoadSQLiteDB, LoadTableFromCSV or LoadTableFromCSV2
' cellAlignment = Gravity of the cell alignments of all cells text
' showStatusLine = if to show status line on the bottom of the table or not, to be able to show text to the user
Public Sub InitializeTable (NumberOfColumns As Int, cellAlignement As Int, showStatusLine As Boolean)
'	cShowStatusLine = showStatusLine
	setShowStatusLine(showStatusLine)
	
	SelectedRows.Initialize
	cAlignment = cellAlignement

	mNumberOfColumns = NumberOfColumns
	Data.Initialize	'needed 
	
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Dim SavedWidths(mNumberOfColumns) As Int
	Dim cColumnDataType(mNumberOfColumns) As String
	For i = 0 To mNumberOfColumns - 1
		ColumnWidths(i) = cWidth / mNumberOfColumns
		HeaderWidths(i) = ColumnWidths(i)
		DataWidths(i) = ColumnWidths(i)
		SavedWidths(i) = ColumnWidths(i)
	Next
	
	innerClearAll(mNumberOfColumns, True)
End Sub

'initializes the sorting Bitmaps
Private Sub InitializeSortingBitmaps
	Private pthAsc, pthDes As Path
	
	cSortBitmapHeight = cSortBitmapWidth / 2
	
	pnlAsc.Initialize("")
	pnlTable.AddView(pnlAsc, 0, 0, cSortBitmapWidth, cSortBitmapHeight)
	cvsAsc.Initialize(pnlAsc)
	pthAsc.Initialize(0, 0)
	pthAsc.LineTo(cSortBitmapWidth, 0)
	pthAsc.LineTo(cSortBitmapHeight, cSortBitmapHeight)
	cvsAsc.DrawColor(Colors.Transparent)
	cvsAsc.DrawPath(pthAsc, cSortBitmapColor, True, 1dip)
	bmpAsc = cvsAsc.Bitmap

	cvsDes.Initialize(pnlAsc)
	pthDes.Initialize(0, cSortBitmapHeight)
	pthDes.LineTo(cSortBitmapHeight, 0)
	pthDes.LineTo(cSortBitmapWidth, cSortBitmapHeight)
	cvsDes.DrawColor(Colors.Transparent)
	cvsDes.DrawPath(pthDes, cSortBitmapColor, True, 1dip)
	bmpDes = cvsDes.Bitmap
	pnlAsc.RemoveView
End Sub

'initializes the fast scroll cursor
Private Sub InitializeFastScrollCursor
	Private pthArrow As Path
	Private cvsFSc As Canvas
	Private x1, x2, x3, y1, y2, dd, rr As Int
	Private rct As Rect
	
	rr = 7dip
	cvsFSc.Initialize(pnlFastScrollCursor)
	rct.Initialize(0, 0, FScCursorWidth, FScCursorHeight)
	cvsFSc.DrawRect(rct, Colors.Transparent, True, 1dip)
	
	cvsFSc.DrawCircle(rr, rr, rr, FScCursorCol1, True, 1dip)
	cvsFSc.DrawCircle(FScCursorWidth - rr, rr, rr, FScCursorCol1, True, 1dip)
	cvsFSc.DrawCircle(rr, FScCursorHeight - rr, rr, FScCursorCol1, True, 1dip)
	cvsFSc.DrawCircle(FScCursorWidth - rr, FScCursorHeight - rr, rr, FScCursorCol1, True, 1dip)

	rct.Initialize(rr, 0, FScCursorWidth - rr, rr)
	cvsFSc.DrawRect(rct, FScCursorCol1, True, 1dip)
	rct.Initialize(0, rr, FScCursorWidth, FScCursorHeight - rr)
	cvsFSc.DrawRect(rct, FScCursorCol1, True, 1dip)
	rct.Initialize(rr, FScCursorHeight - rr, FScCursorWidth, FScCursorHeight)
	cvsFSc.DrawRect(rct, FScCursorCol1, True, 1dip)

	cvsFSc.DrawLine(5dip, FScCursorHeight / 2 - 5dip, FScCursorWidth - 5dip, FScCursorHeight / 2 - 5dip, FScCursorCol2, 1dip)
	cvsFSc.DrawLine(5dip, FScCursorHeight / 2, FScCursorWidth - 5dip, FScCursorHeight / 2, FScCursorCol2, 1dip)
	cvsFSc.DrawLine(5dip, FScCursorHeight / 2 + 5dip, FScCursorWidth - 5dip, FScCursorHeight / 2 + 5dip, FScCursorCol2, 1dip)
	
	dd = 7dip
	x2 = FScCursorWidth / 2
	x1 = x2 - dd
	x3 = x2 + dd
	y2 = dd
	y1 = y2 + dd
	pthArrow.Initialize(x1, y1)
	pthArrow.LineTo(x3, y1)
	pthArrow.LineTo(x2, y2)
	cvsFSc.DrawPath(pthArrow, FScCursorCol2, True, 1dip)
	
	x2 = FScCursorWidth / 2
	x1 = x2 - dd
	x3 = x2 + dd
	y2 = FScCursorHeight - dd
	y1 = y2 - dd
	pthArrow.Initialize(x1, y1)
	pthArrow.LineTo(x3, y1)
	pthArrow.LineTo(x2, y2)
	cvsFSc.DrawPath(pthArrow, FScCursorCol2, True, 1dip)
	pnlFastScrollCursor.Invalidate
End Sub

'Clears the table
Public Sub ClearAll
	innerClearAll(mNumberOfColumns, True)
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
	
	Private v As View
	Private w As Int
	Private Left As Int
	Left = cLineWidth
	If mNumberOfFixedColumns = 0 Then
		For col = 0 To Widths.Length - 1
			v = Header.GetView(col)
			w = Max(2dip, Widths(col) - cLineWidth)
			v.Width = w
			v.Left = Left
			If w > 2dip Then
				Left = Left + w + cLineWidth
			End If
		Next
		mFirstColumnsWidth = 0
		HeaderFirst.Width = 0
		SVF.Width = 0
		Header.Width = Header.GetView(Widths.Length - 1).Left + Widths(Widths.Length - 1)
		SV2.Panel.Width = Header.Width
		SV2.Left = 0
		SV2.Width = Min(Header.Width, cWidth)
		Header.Left = 0
		SV2.HorizontalScrollPosition = 0
		Dim lbls() As Label
		For row = 0 To visibleRows.Size - 1
			lbls = visibleRows.GetValueAt(row)
			For col = 0 To lbls.Length - 1
				lbls(col).SetLayout(Header.GetView(col).Left, lbls(col).Top, Header.GetView(col).Width, cRowHeight - cLineWidth)
			Next
		Next
		pnlTable.Width = Min(Header.Width, cWidth)
		lblStatusLine.Width = Header.Width
		internalPanel.Width = Header.Width
	Else	'mNumberOfFixedColumns > 0 New
		Private v As View
		Private w, wt As Int
		Left = cLineWidth
		For col = 0 To mNumberOfFixedColumns - 1
			Private v As View
			v = HeaderFirst.GetView(col)
'			w = Max(2dip, Widths(col) - cLineWidth)
			w = Max(2dip, Widths(col) - cLineWidth)	'???
			v.Width = w
			wt = wt + w
			v.Left = Left
			If w > 2dip Then
				Left = Left + w + cLineWidth
			End If
		Next
		mFirstColumnsWidth = Left
		HeaderFirst.Width = Left
		SVF.Width = HeaderFirst.Width
		SV2.Left = HeaderFirst.Width
		Private Left, col_x As Int
		Left = 0
		For col = mNumberOfFixedColumns To Widths.Length - 1
			Private v As View
			col_x = col - mNumberOfFixedColumns
			v = Header.GetView(col_x)
			w = Max(2dip, Widths(col) - cLineWidth)
			v.Width = w
			v.Left = Left
			If w > 2dip Then
				Left = Left + w + cLineWidth
			End If
		Next
		Header.Width = Left
		Header.Left = -SV2.HorizontalScrollPosition + mFirstColumnsWidth
		SV2.Panel.Width = Header.Width
		Header.Left = mFirstColumnsWidth
		SV2.HorizontalScrollPosition = 0
		Dim lbls() As Label
		For row = 0 To visibleRows.Size - 1
			lbls = visibleRows.GetValueAt(row)
			Left = 0
			For col = 0 To mNumberOfFixedColumns - 1
				lbls(col).SetLayout(Left, lbls(col).Top, Widths(col), cRowHeight - cLineWidth)
				Left = HeaderFirst.GetView(col).Left + HeaderFirst.GetView(col).Width + cLineWidth
			Next
			Left = 0
			For col = mNumberOfFixedColumns To lbls.Length - 1
				col_x = col - mNumberOfFixedColumns
				lbls(col).SetLayout(Left, lbls(col).Top, Header.GetView(col_x).Width, cRowHeight - cLineWidth)
				Left = Left + Header.GetView(col_x).Width + cLineWidth
			Next
		Next
		SV2.Width = Min(Header.Width, cWidth - HeaderFirst.Width)
		pnlTable.Width = Min(HeaderFirst.Width + Header.Width, cWidth)
		lblStatusLine.Width = HeaderFirst.Width + Header.Width
		internalPanel.Width = HeaderFirst.Width + Header.Width
	End If
	pnlFastScroll.Left = pnlTable.Width - pnlFastScroll.Width
	If mFastScrollFixedLabel = True Then
		lblFastScroll.Top = (SV2.Height + lblFastScroll.Height) / 2
	End If

	RefreshTable
End Sub

Public Sub GetColumnWidths As Int()
	Return SavedWidths
End Sub

Private Sub innerClearAll(vNumberOfColumns As Int, ClearData As Boolean)
	SelectedRows.Initialize
	SV2.Panel.RemoveAllViews
	SVF.Panel.RemoveAllViews
	mNumberOfColumns = vNumberOfColumns
	Dim Drawable1(mNumberOfColumns) As Object
	Dim Drawable2(mNumberOfColumns) As Object
	Dim SelectedDrawable(mNumberOfColumns) As Object
	Dim cAlignments(mNumberOfColumns) As Int
	Dim cHeaderAlignments(mNumberOfColumns) As Int
	Dim cTypeFaces(mNumberOfColumns) As Typeface
	Dim cHeaderTypeFaces(mNumberOfColumns) As Typeface
	
	If cUseColumnColors = False Then
		If lstRowColors.Size > 0 Then
			For i = 0 To lstRowColors.Size - 1
				Private cds(mNumberOfColumns) As Object
				Private color = lstRowColors.Get(i) As Int
				For col = 0 To mNumberOfColumns - 1
					Private cdi As ColorDrawable
					cdi.Initialize(color, 0)
					cds(col) = cdi
				Next
				lstRowDrawables.Add(cds)
			Next			
		End If
		For i = 0 To mNumberOfColumns - 1
			Dim cd1, cd2, cd3 As ColorDrawable
			cd1.Initialize(cRowColor1, 0)
			cd2.Initialize(cRowColor2, 0)
			cd3.Initialize(cSelectedRowColor, 0)
			Drawable1(i) = cd1
			Drawable2(i) = cd2
			SelectedDrawable(i) = cd3
			If MultiAlignments = False Or cAlignments0.Length < mNumberOfColumns Then
				cAlignments(i) = cAlignment
			Else
				cAlignments(i) = cAlignments0(i)
			End If
			If MultiTypeFace = False  Or cTypeFaces0.Length < mNumberOfColumns Then
				cTypeFaces(i) = cTypeFace
			Else
				cTypeFaces(i) = cTypeFaces0(i)
			End If
			
			If HeaderMultiAlignments = False  Or cHeaderAlignments0.Length < mNumberOfColumns Then
				cHeaderAlignments(i) = cHeaderAlignment				
			Else
				cHeaderAlignments(i) = cHeaderAlignments0(i)
			End If
			If HeaderMultiTypeFace = False  Or cHeaderTypeFaces0.Length < mNumberOfColumns Then
				cHeaderTypeFaces(i) = cHeaderTypeFace				
			Else
				cHeaderTypeFaces(i) = cHeaderTypeFaces0(i)
			End If
		Next
	Else
		For i = 0 To mNumberOfColumns - 1
			Private cd1, cd2, cd3 As ColorDrawable
			cd1.Initialize(cColumnColors(i), 0)
			cd2.Initialize(cColumnColors(i), 0)
			cd3.Initialize(cSelectedRowColor, 0)
			Drawable1(i) = cd1
			Drawable2(i) = cd2
			SelectedDrawable(i) = cd3
			If MultiAlignments = False Or cAlignments0.Length < mNumberOfColumns Then
				cAlignments(i) = cAlignment
			Else
				cAlignments(i) = cAlignments0(i)
			End If
			If MultiTypeFace = False  Or cTypeFaces0.Length < mNumberOfColumns Then
				cTypeFaces(i) = cTypeFace
			Else
				cTypeFaces(i) = cTypeFaces0(i)
			End If
			
			If HeaderMultiAlignments = False  Or cHeaderAlignments0.Length < mNumberOfColumns Then
				cHeaderAlignments(i) = cHeaderAlignment
			Else
				cHeaderAlignments(i) = cHeaderAlignments0(i)
			End If
			If HeaderMultiTypeFace = False  Or cHeaderTypeFaces0.Length < mNumberOfColumns Then
				cHeaderTypeFaces(i) = cHeaderTypeFace
			Else
				cHeaderTypeFaces(i) = cHeaderTypeFaces0(i)
			End If		
		Next
	End If
	
	Dim cd4 As ColorDrawable
	cd4.Initialize(cSelectedCellColor, 0)
	SelectedCellDrawable = cd4

	SV2.Panel.Height = 0
	SVF.Panel.Height = 0

	'SelectedRow = -1
	SelectedCol = -1
	minVisibleRow = -1
	maxVisibleRow = 0
	If ClearData = True Then
		Data.Initialize
	End If
	LabelsCache.Initialize
	visibleRows.Initialize
	SV2.VerticalScrollPosition = 0
	SVF.ScrollPosition = 0
	For i = 1 To 80 'fill the cache to avoid delay on the first touch
		LabelsCache.Add(CreateNewLabels)
	Next
	If IsVisible Then
		SV2_ScrollChanged(0, 0)
		SVF_ScrollChanged(0)
	End If
	If (lblStatusLine.IsInitialized And enableStatusLineAutoFill = True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
	
End Sub

Private Sub SVF_ScrollChanged(Position As Int)
	SVFScrolls = True
	If SV2Scrolls = False Then
		Scroll(SV2PosX, Position)
		SV2.VerticalScrollPosition = Position
	End If
	SVFScrolls = False
End Sub

Private Sub SV2_ScrollChanged(PosX As Int, PosY As Int)
	SV2Scrolls = True
	If SVFScrolls = False Then
		Scroll(PosX, PosY)
		SV2PosX = PosX
		SVF.ScrollToNow(PosY)
	End If

	SV2Scrolls = False
	If mFastScroll = True And Data.Size >= mFastScrollMinItems And Data.Size * cRowHeight > SV2.Height Then
		FScScale = FastScrollHeight / (SV2.Panel.Height - SV2.Height)
		pnlFastScroll.Visible = True
		If mFastScrollShowLabel = True Then
			lblFastScroll.Visible = True
		End If
		CalcFastScroll(PosY)
		FScTimer.Enabled = True
	End If
End Sub

Private Sub Scroll(PosX As Int, PosY As Int)
	Dim currentMin, currentMax As Int
	currentMin = Max(0, PosY / cRowHeight - 30)
	currentMax = Min(Data.Size - 1, (PosY + SV2.Height) / cRowHeight + 30)
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
	Header.Left = -PosX + mFirstColumnsWidth
	lblStatusLine.Left = - PosX
End Sub

'Adds a row to the table
'Example:<code>Table1.AddRow(Array As String("aaa", "ccc", "ddd", "eee"))</code>
Public Sub AddRow(Values() As String)
	If Values.Length <> mNumberOfColumns Then
		Log("Wrong number of values =" & Values.Length & " col=" & mNumberOfColumns)
		Return
	End If
	Data.Add(Values)
	lstRowColorIndexes.Add(0)
	
	Dim lastRow As Int
	lastRow = Data.Size - 1
	If lastRow < (SV2.VerticalScrollPosition + SV2.Height) / cRowHeight + 1 Then
		ShowRow(lastRow)		
	End If
	SV2.Panel.Height = Data.Size * cRowHeight
	SVF.Panel.Height = SV2.Panel.Height
	FScScale = FastScrollHeight / Data.Size
	updateIPLocation
	If (lblStatusLine.IsInitialized And enableStatusLineAutoFill=True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
End Sub

'Adds a row to the table with automatic widths
'Example:<code>Table1.AddRow(Array As String("aaa", "ccc", "ddd", "eee"))</code>
Public Sub AddRowAutomaticWidth(Values() As String)
	Private i As Int
	
	If Values.Length <> mNumberOfColumns Then
		Log("Wrong number of values =" & Values.Length & " col=" & mNumberOfColumns)
		Return
	End If
	Data.Add(Values)
	lstRowColorIndexes.Add(0)

	Dim lastRow As Int
	lastRow = Data.Size - 1
	
	Dim changed = False As Boolean
	Dim width As Int
	If Data.Size = 1 Then
		For i = 0 To mNumberOfColumns - 1
			If HeaderMultiTypeFace = False Then
				width = cvs.MeasureStringWidth(HeaderNames.Get(i), cHeaderTypeFace, cTextSize) + ExtraWidth
			Else
				width = cvs.MeasureStringWidth(HeaderNames.Get(i), cHeaderTypeFaces(i), cTextSize) + ExtraWidth
			End If
			ColumnWidths(i) = width
			SavedWidths(i) = width
			HeaderWidths(i) = width
			DataWidths(i) = width		
		Next
	End If
	For i = 0 To mNumberOfColumns - 1
		If MultiTypeFace = False Then
			width = cvs.MeasureStringWidth(Values(i), cTypeFace, cTextSize) + ExtraWidth
		Else
			width = cvs.MeasureStringWidth(Values(i), cTypeFaces(i), cTextSize) + ExtraWidth
		End If
		If ColumnWidths(i) < width Then
			ColumnWidths(i) = width
			SavedWidths(i) = width
			HeaderWidths(i) = width
			DataWidths(i) = width
			changed = True
		End If
	Next

	If changed = True Then
		SetColumnsWidths(ColumnWidths)
	End If
	
	If lastRow < (SV2.VerticalScrollPosition + SV2.Height) / cRowHeight + 1 Then
		ShowRow(lastRow)
	End If
	SV2.Panel.Height = Data.Size * cRowHeight
	SVF.Panel.Height = SV2.Panel.Height
	updateIPLocation
	If (lblStatusLine.IsInitialized And enableStatusLineAutoFill=True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
End Sub

' draw a Row, now col is hidden (width <2)
Private Sub ShowRow(Row As Int)
	Private i As Int

	If visibleRows.ContainsKey(Row) Then Return
	
	
	'Log("ShowRow: " & row)
	Dim lbls() As Label
	Dim values() As String
	lbls = GetLabels(Row)
	values = Data.get(Row)
	visibleRows.Put(Row, lbls)
	Dim rowColor() As Object
	Private txtColor As Int
	If (SelectedRows.indexof(Row) <> -1 )Then
		rowColor = SelectedDrawable
		txtColor = cSelectedRowTextColor
	Else If lstRowColorIndexes.Get(Row) > 1 Then
		rowColor = lstRowDrawables.Get(lstRowColorIndexes.Get(Row) - 2)
'		txtColor = cTextColor
		txtColor = GetContrastColor(lstRowColors.Get(lstRowColorIndexes.Get(Row) - 2))
	Else
		If Row Mod 2 = 0 Then
			rowColor = Drawable1
			txtColor = cTextColor
		Else
			rowColor = Drawable2
			txtColor = cTextColor
		End If
	End If
	If mNumberOfFixedColumns = 0 Then
		For i = 0 To lbls.Length - 1
			If (Header.GetView(I).Width > 1 ) Then
				SV2.Panel.AddView(lbls(i), Header.GetView(I).Left, Row * cRowHeight, Header.GetView(I).Width, cRowHeight - cLineWidth)
				lbls(i).Text = values(i)
				lbls(i).TextColor = txtColor
				If i = SelectedCol And (SelectedRows.indexof(Row) <> -1) Then
					lbls(i).TextColor = cSelectedCellTextColor
					lbls(i).Background = SelectedCellDrawable
				Else
					lbls(i).TextColor = txtColor
					lbls(i).Background = rowColor(i)
				End If
				If MultiAlignments = False Then
					lbls(i).Gravity = cAlignment
				Else
					lbls(i).Gravity = cAlignments(i)
				End If
			End If
		Next
	Else 'mNumberOfFixedColumns > 0
		For i = 0 To lbls.Length - 1
			If i < mNumberOfFixedColumns Then
				SVF.Panel.AddView(lbls(i), HeaderFirst.GetView(i).Left, Row * cRowHeight, HeaderFirst.GetView(i).Width, cRowHeight - cLineWidth)
				lbls(i).Text = values(i)
				lbls(i).TextColor = txtColor
				If i = SelectedCol And (SelectedRows.indexof(Row) <> -1) Then
					lbls(i).TextColor = cSelectedCellTextColor
					lbls(i).Background = SelectedCellDrawable
				Else
					lbls(i).TextColor = txtColor
					lbls(i).Background = rowColor(i)
				End If
				If MultiAlignments = False Then
					lbls(i).Gravity = cAlignment
				Else
					lbls(i).Gravity = cAlignments(i)
				End If
			Else
				Private i_1 As Int
				i_1 = i - mNumberOfFixedColumns
				If (Header.GetView(i_1).Width > 1 ) Then
					SV2.Panel.AddView(lbls(i), Header.GetView(i_1).Left, Row * cRowHeight, Header.GetView(i_1).Width, cRowHeight - cLineWidth)
					lbls(i).Text = values(i)
					lbls(i).TextColor = txtColor
					If i = SelectedCol And (SelectedRows.indexof(Row) <> -1) Then
						lbls(i).TextColor = cSelectedCellTextColor
						lbls(i).Background = SelectedCellDrawable
					Else
						lbls(i).TextColor = txtColor
						lbls(i).Background = rowColor(i)
					End If
					If MultiAlignments = False Then
						lbls(i).Gravity = cAlignment
					Else
						lbls(i).Gravity = cAlignments(i)
					End If
				End If
			End If
		Next
	End If
	
	If SubExists(cCallBack, cEventName & "_ShowRow") Then
		Sleep(0)
		CallSub3(cCallBack, cEventName & "_ShowRow", Row, lbls)
	End If
End Sub

Private Sub IsRowVisible(Row As Int) As Boolean		'ignore
	Return Row < (SV2.VerticalScrollPosition + SV2.Height) / (cRowHeight + 1) And _
		Row > SV2.VerticalScrollPosition / cRowHeight
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
	Dim lbls(mNumberOfColumns) As Label
	For i = 0 To mNumberOfColumns - 1
		Dim rc As RowCol
		rc.Col = i
		Dim lbl As Label
		lbl.Initialize("Cell")
		
		lbl.TextSize = cTextSize
		
		If cUseColumnColors = False Then
			lbl.TextColor = cTextColor
		Else
			lbl.TextColor = cTextColors(i)
		End If
		
		If MultiTypeFace = False Then
			lbl.Typeface = cTypeFace
		Else
			lbl.Typeface = cTypeFaces(i)
		End If

		SetPadding(lbl, 4dip, 2dip, 4dip, 2dip)

		lbl.SingleLine = cSingleLine
		lbl.Tag = rc
		lbls(i) = lbl
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
	For col = 0 To mNumberOfColumns - 1
		Dim lbl As Label
		lbl.Initialize("header")
		If HeaderMultiAlignments = False Then
			lbl.Gravity = cHeaderAlignment
		Else
			lbl.Gravity = cHeaderAlignments(col)
		End If
		
		If HeaderMultiTypeFace = False Then
			lbl.Typeface = cHeaderTypeFace
		Else
			lbl.Typeface = cHeaderTypeFaces(col)
		End If
		
		lbl.TextSize = cTextSize
		SetPadding(lbl, 4dip, 2dip, 4dip, 2dip)

		If cUseColumnColors = False Or cHeaderTextColors.Length <> mNumberOfColumns Then
			lbl.Color = cHeaderColor
			lbl.TextColor = cHeaderTextColor
		Else
			lbl.Color = cHeaderColors(col)
			lbl.TextColor = cHeaderTextColors(col)
		End If
		
		lbl.Text = Values(col)
		lbl.Tag = col
'		w = Max(2dip, ColumnWidths(col) - cLineWidth)		' needed to make sure that the width has value >0
		w = Max(0, ColumnWidths(col) - cLineWidth)		' needed to make sure that the width has value >0

		If mNumberOfFixedColumns > 0 And col < mNumberOfFixedColumns Then
			HeaderFirst.AddView(lbl, Left, 0, w, cHeaderHeight)
		Else
			If col = mNumberOfFixedColumns Then
				Left = 0
			End If
			Header.AddView(lbl, Left, 0, w, cHeaderHeight)
		End If

		If cAutomaticWidths = True Then
			If Values(col).Contains(CRLF) Then
				Dim str() As String
				Dim j As Int
				str = Regex.Split(CRLF, Values(col))
				HeaderWidths(col) = cvs.MeasureStringWidth(str(0), lbl.Typeface, cTextSize) + ExtraWidth
				For j = 1 To str.Length - 1
					HeaderWidths(col) = Max(HeaderWidths(col),cvs.MeasureStringWidth(str(j), lbl.Typeface, cTextSize)  + ExtraWidth)
				Next
			Else
				HeaderWidths(col) = cvs.MeasureStringWidth(Values(col), lbl.Typeface, cTextSize)  + ExtraWidth
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
	Header.Left = - SV2.HorizontalScrollPosition + mFirstColumnsWidth
End Sub

Private Sub Cell_LongClick
	'Log("Cell: long click")
	Dim rc As RowCol
	Dim L As Label
	L = Sender
	rc = L.Tag
	'SelectRow(rc)
	If SubExists(cCallBack, cEventName & "_CellLongClick") Then
		CallSub3(cCallBack, cEventName & "_CellLongClick", rc.Col, rc.Row)
	End If
End Sub

Private Sub Header_LongClick
	'Log("Header: long click")
	Dim L As Label
	Dim col As Int
	L = Sender
	col = L.Tag
	If SubExists(cCallBack, cEventName & "_HeaderLongClick") Then
		CallSub2(cCallBack, cEventName & "_HeaderLongClick", col)
	End If	
End Sub

Private Sub Cell_Click
	Dim rc As RowCol
	Dim L As Label
	L = Sender
	rc = L.Tag

'	SelectRow(rc.Row)
	SelectRow(rc)
	If SubExists(cCallBack, cEventName & "_CellClick") Then
		CallSub3(cCallBack, cEventName & "_CellClick", rc.Col, rc.Row)
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
	If (prevIndex <> -1 And mMultiSelect = False) Then
		' if mMultiSelectt = True no column change, only if mMultiSelectt = False
		SelectedCol = rc.col
		If visibleRows.ContainsKey(rc.Row) Then
			HideRow(rc.Row)
			ShowRow(rc.Row)
		End If
		If mZeroSelection = False Then
			Return		
		End If
	End If
	
	If (prevIndex = -1) Then
		If (mMultiSelect) Then 
			SelectedRows.Add(rc.Row) 'Select the new row
			prev = -1
		Else ' set selected to the new one
			' hide / show all selected rows		
			'Log ("get at zero: " & SelectedRows)
			If (SelectedRows.Size <> 0) Then 
				prev = SelectedRows.get(0) ' there should be only one here ever!!!, keep the unselected row in prev
				SelectedRows.set(0, rc.Row) ' change it to the new one
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

'Unselects the row for the given index
Public Sub UnselectRow(Row As Int)
	If Not(cAllowSelection) Then Return
	
	Dim prevIndex As Int
	
	prevIndex = SelectedRows.indexof(Row)	 ' -1 if selecting not a selected row
	If prevIndex > -1 Then
		' if mMultiSelect = True no column change, only if mMultiSelect = False
		SelectedCol = -1
		SelectedRows.RemoveAt(prevIndex)
		If visibleRows.ContainsKey(Row) Then
			HideRow(Row)
			ShowRow(Row)
		End If
	End If
End Sub

'Makes the given row visible.
Public Sub JumpToRow(Row As Int)
	Sleep(0)
	SV2.VerticalScrollPosition = Row * cRowHeight
End Sub

'Makes the given row visible and set it's row and colum as selected.
Public Sub JumpToRowAndSelect(Col As Int, Row As Int)
	Log("You may get this warning:")
	Log("Unexpected event (missing RaiseSynchronousEvents): sv_scrollchanged")
	Log("Ignore it, it is NOT harmful !")
	Dim rc As RowCol
	
	rc.Row = Row
	rc.Col = Col
	SelectRow(rc)
	Sleep(0)

	SV2.VerticalScrollPosition = Row * cRowHeight
	Private i, Left As Int
	If Col > 0 Then
		For i = 0 To Col - 1
			Left = Left + ColumnWidths(i)			
		Next	
	End If
	SV2.HorizontalScrollPosition = Left
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
	innerClearAll(h.Length, True)
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Dim cColumnDataType(mNumberOfColumns) As String
	For i = 0 To mNumberOfColumns - 1
		cColumnDataType(i) = "TEXT"
		ColumnWidths(i) = SV2.Width / mNumberOfColumns
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
	innerClearAll(h.Length, True)
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Dim cColumnDataType(mNumberOfColumns) As String
	
	Dim col, Row As Int
	If AutomaticWidths = False Then
		For col = 0 To mNumberOfColumns - 1
			cColumnDataType(col) = "TEXT"
			ColumnWidths(col) = SV2.Width / mNumberOfColumns
			HeaderWidths(col) = ColumnWidths(col)
			DataWidths(col) = ColumnWidths(col)
		Next
	Else
		If HeadersExist Then
			Dim strRow(mNumberOfColumns) As String
			strRow = List1.get(col)
			If HeaderMultiTypeFace = False Then
				For col = 0 To mNumberOfColumns - 1
					HeaderWidths(col) = cvs.MeasureStringWidth(headers.get(col), cHeaderTypeFace, cTextSize)  + ExtraWidth
				Next
			Else
				For col = 0 To mNumberOfColumns - 1
					HeaderWidths(col) = cvs.MeasureStringWidth(headers.get(col), cHeaderTypeFaces(col), cTextSize)  + ExtraWidth
				Next
			End If
		End If
		For Row = 0 To List1.Size - 1
			Dim strRow(mNumberOfColumns) As String
			strRow = List1.get(Row)
			If MultiTypeFace = True Then
				For col = 0 To mNumberOfColumns - 1
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(strRow(col), cTypeFaces(col), cTextSize) + ExtraWidth)
				Next
			Else
				For col = 0 To mNumberOfColumns - 1
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(strRow(col), cTypeFace, cTextSize) + ExtraWidth)
				Next
			End If
		Next
		For col = 0 To mNumberOfColumns - 1
			cColumnDataType(col) = "TEXT"
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
	Dim headers(mNumberOfColumns) As String
	For i = 0 To headers.Length - 1
		Dim L As Label
		L = Header.GetView(i)
		headers(i) = L.Text
	Next
	StringUtils1.SaveCSV2(Dir, Filename, ",", Data, headers)
End Sub

'Saves the table to a CSV file with a given separator character.
Public Sub SaveTableToCSV2(Dir As String, Filename As String, SeparatorChar As String)
	Dim headers(mNumberOfColumns) As String
	For i = 0 To headers.Length - 1
		Dim L As Label
		L = Header.GetView(i)
		headers(i) = L.Text
	Next
	StringUtils1.SaveCSV2(Dir, Filename, SeparatorChar, Data, headers)
End Sub

' new functunality added by nir -->
' remove a row
'row is the row number
Public Sub RemoveRow(Row As Int)	
	If (Row <0 Or Row > Data.Size-1) Then Return ' cant remove row outside of the table scope
	
	SV2_ScrollChanged(SV2.HorizontalScrollPosition,SV2.VerticalScrollPosition) ' this strange call will set min/max visible area
	'Dim sr As Int ' to keep the previos selected row (in case mMultiSelect is off)
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
	lstRowColorIndexes.RemoveAt(Row)
	For i = minVisibleRow To maxVisibleRow ' hide all visible rows
		HideRow(i)
	Next

'	If mMultiSelect = False Then
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
		'If (mMultiSelect OR sr = i) Then HideRow(i) ' in multi select we made too much mess, we need to redraw the whole view (can be optimized if needed!)
			ShowRow(i)
		Next
	End If
	
	SV2.Panel.Height = Data.Size * cRowHeight
	SVF.Panel.Height = SV2.Panel.Height
	updateIPLocation
	
	SV2_ScrollChanged(SV2.HorizontalScrollPosition,Min(SV2.VerticalScrollPosition, SV2.Panel.Height))
	If (lblStatusLine.IsInitialized And enableStatusLineAutoFill=True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?	
End Sub

' return array of strings hold all the values for a row.
Public Sub GetValues(Row As Int ) As String()
	Dim rowData() As String  = Data.get(Row) ' will throw an excpetion if row is not correct
	Dim tmp(mNumberOfColumns) As String
	For i=0 To mNumberOfColumns-1 ' copy the array
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
    SV2_ScrollChanged(SV2.HorizontalScrollPosition,SV2.VerticalScrollPosition) ' this strange call will set min/max visible area

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
	
	SV2_ScrollChanged(SV2.HorizontalScrollPosition,SV2.VerticalScrollPosition) ' this strange call will set min/max visible area	

	For i = minVisibleRow To maxVisibleRow 
		ShowRow(i)
	Next
	
	SV2.Panel.Height = Data.Size * cRowHeight
	SVF.Panel.Height = SV2.Panel.Height
	updateIPLocation
	SV2_ScrollChanged(SV2.HorizontalScrollPosition,Min(SV2.VerticalScrollPosition, SV2.Panel.Height))	
	If (lblStatusLine.IsInitialized And enableStatusLineAutoFill = True) Then setStatusLine(Data.Size & " rows") ' should this be automatic ?
	Return False
End Sub

' update a row in the table
' row is the row number to update, Values is an array of string at the size of the number of columns
' return true if worked out, false if failed
Public Sub UpdateRow(Row As Int, Values () As String) As Boolean
	Dim i As Int
	If (Values.Length <> mNumberOfColumns Or Row <0 Or Row>Data.Size-1) Then
		Return False
	End If
	For i=0 To Values.Length-1
		SetValue(i,Row,Values(i))
	Next
	Return True
End Sub

' update a cell in the table
' col is the columne index and row is the row index of the cell to update, Value is the cell content string
' return true if worked out, false if failed
Public Sub UpdateCell(Col As Int, Row As Int, Value As String) As Boolean
	If (Col < 0 Or Col > mNumberOfColumns - 1 Or Row < 0 Or Row>Data.Size-1) Then
		Return False
	End If
	SetValue(Col, Row, Value)
	Return True
End Sub

Public Sub clearSelection
    'SV_ScrollChanged(SV2.HorizontalScrollPosition,SV2.VerticalScrollPosition) ' this strange call will set min/max visible area	
	SelectedRows.Clear
	RefreshTable
End Sub

' refresh / redraw the visible part of the table
Public Sub RefreshTable
	SV2_ScrollChanged(SV2.HorizontalScrollPosition,SV2.VerticalScrollPosition) ' this strange call will set min/max visible area	
	For i = minVisibleRow To maxVisibleRow ' hide all visible rows
		HideRow(i)
		ShowRow(i)
 	Next
End Sub

' refresh the Labels and redraw the visible part of the table
Private Sub RefreshLabels
	Private i, j As Int
		
	For i = minVisibleRow To maxVisibleRow ' hide all visible rows
		HideRow(i)
	Next
		
	For i = 0 To LabelsCache.Size - 1
		Private lbls() As Label
		lbls = LabelsCache.Get(i)
		For j = 0 To lbls.Length - 1
			If MultiTypeFace = True Then
				lbls(j).Typeface = cTypeFaces(j)
			Else
				lbls(j).Typeface = cTypeFace
			End If
		Next
	Next
		
	For i = minVisibleRow To maxVisibleRow ' show all visible rows again
		ShowRow(i)
	Next
End Sub

' return true if the table is set to multi select 
Public Sub getMultiSelect As Boolean 
	Return mMultiSelect
End Sub

'sets or gets the MultiSelect property
'when mMultiSelect is true, click on a not selected row will add that row to the selected list of rows, and click on an selected row will unselect it
'when mMultiSelect is false, click on a row will select it (or reselect it if it is alreday selected)
Public Sub setMultiSelect(MultiSelect As Boolean)
	clearSelection
	mMultiSelect = MultiSelect
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
	For i = 0 To SavedWidths.Length - 1
		tmpWidths(i) = SavedWidths(i) 
	Next
'	tmpWidths(col) = 1
	tmpWidths(col) = 0	'???
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
	If SubExists(cCallBack, cEventName & "_HeaderClick") Then
		CallSub2(cCallBack, cEventName & "_HeaderClick", -1)
	End If
End Sub

' update top/height for internalPanel
Private Sub updateIPLocation
	If (SV2.Height > Data.Size * cRowHeight) Then
'		Log("updateIPLocation") 
		internalPanel.Top = Data.Size * cRowHeight + cHeaderHeight
		internalPanel.Height = SV2.Height - (Data.Size * cRowHeight)
	Else
		internalPanel.Height = 0
	End If
End Sub

Public Sub getSize As Long
	Return Data.Size
End Sub

'Gets or sets the Table Left property
Public Sub setLeft(Left As Int)
	cLeft = Left
  pnlTable.Left = Left
End Sub

Public Sub getLeft As Int
   Return pnlTable.Left
End Sub

'Gets or sets the Table Left property
Public Sub setTop(Top As Int)
	cTop = Top
	pnlTable.Top = Top
End Sub

Public Sub getTop As Int
	Return pnlTable.Top
End Sub

'Gets or sets the Table Width property
Public Sub setWidth(Width As Int)
	cWidth = Width
	pnlTable.Width = Width
	If mNumberOfFixedColumns = 0 Then
		SV2.Width = Width
	Else
		SV2.Width = Width - SVF.Width
	End If
'	internalPanel.Width = Width
	updateIPLocation
End Sub

'Gets the total inner width, read only
Public Sub getInnerTotalWidth As Int
	If mNumberOfFixedColumns = 0 Then
		Return Header.Width
	Else
		Return HeaderFirst.Width + Header.Width
	End If
End Sub

Public Sub getWidth As Int
	Return pnlTable.Width
End Sub

'Gets or sets the Table Height property
Public Sub setHeight(Height As Int)
	cHeight = Height
	pnlTable.Height = Height
	If (cShowStatusLine = True) Then
		SVF.Height = Height - cRowHeight - cHeaderHeight
		SV2.Height = Height - cRowHeight - cHeaderHeight
	Else
		SVF.Height = Height - cHeaderHeight
		SV2.Height = Height - cHeaderHeight
	End If
	lblStatusLine.Top = SV2.Top + SV2.Height
	SVF_ScrollChanged(0)
	SV2_ScrollChanged(0, 0)
	InitFastScroll
	
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
	
	If cSortColumn = True Then
		Dim dir As Int = 0 ' unsorted
		If (sortedCol = col) Then ' we are sorting the same col, reverse dir
			Select sortingDir
				Case 0
					dir = -1 ' going up
				Case 1
					dir = -1
				Case -1
					dir = 1
			End Select
		Else
			dir = -1 ' start with going up
		End If
		sortedCol = col
		sortingDir = dir	
		If cColumnDataType(col) = "TEXT" Then
			sortTable(col,dir <=0)
		Else
			sortTableNum(col,dir <=0)
		End If
		showHeaderSorting(col, dir)	
	End If
	
	If SubExists(cCallBack, cEventName & "_HeaderClick") Then
		CallSub2(cCallBack, cEventName & "_HeaderClick", col)
	End If
End Sub

Public Sub showHeaderSorting(col As Int,dir As Int)
'	Dim ll As Int = 10dip
	Dim L As Int ' calculate left
	Dim t As Int ' calculate top
	Dim View As View
	Dim ParentView As Panel
	
	pnlSortingView.RemoveView
	
	If mNumberOfFixedColumns > 0 Then
		If col < mNumberOfFixedColumns Then
			View = HeaderFirst.GetView(0)
			ParentView = HeaderFirst
		Else
			View = Header.GetView(col - mNumberOfFixedColumns)
			ParentView = Header
		End If
	Else
		View = Header.GetView(col)
		ParentView = Header
	End If
	
	L = View.Left + View.Width - cSortBitmapWidth - 2dip
	
	If (dir = 0) Then Return ' remove the view only

	If (dir = -1) Then
'		pnlSortingView.SetBackgroundImage(LoadBitmapSample(File.DirAssets, "sort_asc.png", ll, ll))
		pnlSortingView.SetBackgroundImage(bmpDes)
		t = View.Top + View.Height - cSortBitmapHeight - 2dip
	Else
'		pnlSortingView.SetBackgroundImage(LoadBitmapSample(File.DirAssets, "sort_desc.png", ll, ll))
		pnlSortingView.SetBackgroundImage(bmpAsc)
		t = View.Top + View.Height - cSortBitmapHeight - 3dip
	End If

'	Dim View As View
'	View = Header.GetView(col)

	ParentView.AddView(pnlSortingView, L, t, cSortBitmapWidth, cSortBitmapHeight)

	
End Sub

' code for sorting
' http://www.basic4ppc.com/forum/basic4android-getting-started-tutorials/8548-sorting-algorithms-teaching-basic4android.html#post47730

' sort the table by column number and direction
' col is the column number starting with 0
' dir as direction true = asc, false = dec
Public Sub sortTable(col As Int, dir As Boolean)
'	Log ("sorting table for col:" & col)
	clearSelection
	debug_counter = 0
	'QuickSort(0,Data.Size-1, col, dir) ' TODO add dir
	SelectionSort(col, dir)
	RefreshTable
End Sub

Public Sub SelectionSort (col As Int, dir As Boolean) 
	Dim minIndex As Int
	If cSortRemoveAccents = False Then
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
	Else
		'removes the accents from accented characters for sorting
		For i = 0 To Data.Size- 1
			minIndex = i
			For j = i + 1 To Data.Size - 1
				Dim values1() As String = Data.get(j)
				Dim s1 As String = values1(col)
				Dim values2() As String = Data.get(minIndex)
				Dim s2 As String = values2(col)
				If (dir) Then
					If s1.CompareTo(RemoveAccents(s2)) < 0 Then minIndex = j
				Else
					If s1.CompareTo(RemoveAccents(s2)) > 0 Then minIndex = j
				End If
			Next
			SwapList(i, minIndex)
		Next
	End If

End Sub

' code for sorting
' http://www.basic4ppc.com/forum/basic4android-getting-started-tutorials/8548-sorting-algorithms-teaching-basic4android.html#post47730

' sort the table by column number and direction
' col is the column number starting with 0
' dir as direction true = asc, false = dec
Public Sub sortTableNum(col As Int, dir As Boolean)
'	Log ("sorting table for col:" & col)
	clearSelection
	debug_counter = 0
	'QuickSort(0,Data.Size-1, col, dir) ' TODO add dir
	SelectionSortNum(col, dir)
	RefreshTable
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
	If Alignments.Length <> mNumberOfColumns Then
		ToastMessageShow("The number of aligments is not equal to the number of columns.", False)
		Return
	End If
	
	cAlignments0 = Alignments
	cAlignments = cAlignments0

	MultiAlignments = True
	If Data.Size > 0 Then
		RefreshTable
	End If
End Sub

'sets the cell alignments for each column all columns with the same alignment
'Example:
'<code>Table1.CellAlignment = Bit.OR(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)</code>
Public Sub setCellAlignment(Alignment As Int)
	Dim i As Int
	
	cAlignment = Alignment
	Dim cAlignments(mNumberOfColumns) As Int
	For i = 0 To mNumberOfColumns - 1
		cAlignments(i) = cAlignment
	Next
	MultiAlignments = False
	If Data.Size > 0 Then
		RefreshTable
	End If
End Sub

'sets the header alignment for each column each column can have a diferent alignment
'Example:'<code>'Dim alignments() As Int
'alignments = Array As Int (Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL), Gravity.CENTER, Bit.Or(Gravity.RIGHT, Gravity.CENTER_VERTICAL), Gravity.CENTER)
'Table1.SetHeaderAlignments(Alignments)</code>
Public Sub SetHeaderAlignments(Alignments() As Int)
	Dim i As Int
	
	If Alignments.Length <> mNumberOfColumns Then
		ToastMessageShow("The number of aligments is not equal to the number of columns.", False)
		Return
	End If
	
	Dim i As Int
	Dim cHeaderAlignments0(mNumberOfColumns) As Int
	
	cHeaderAlignments0 = Alignments
	cHeaderAlignments = cHeaderAlignments0
	If Header.NumberOfViews > 0 Then
		If mNumberOfFixedColumns = 0 Then
			For i = 0 To mNumberOfColumns - 1
				Dim lbl As Label
				lbl = Header.GetView(i)
				lbl.Gravity = cHeaderAlignments(i)
			Next
		Else
			For i = 0 To mNumberOfFixedColumns - 1
				Dim lbl As Label
				lbl = HeaderFirst.GetView(i)
				lbl.Gravity = cHeaderAlignments(i)
			Next
			For i = 0 To mNumberOfColumns - mNumberOfFixedColumns - 1
				Dim lbl As Label
				lbl = Header.GetView(i)
				lbl.Gravity = cHeaderAlignments(i + mNumberOfFixedColumns)
			Next
		End If
	End If
	HeaderMultiAlignments = True
End Sub

Private Sub pnlFastScroll_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case 0	'DOWN
			If Y >= pnlFastScrollCursor.Top And Y <= pnlFastScrollCursor.Top + pnlFastScrollCursor.Height Then
				FSY0 = pnlFastScrollCursor.Top
				FSdY = Y - FSY0
				FastScrollActive = True
			End If
		Case 2	'MOVE
			If FastScrollActive = True Then
				Private Top, SV2Top As Int
				Top = Max(Y - FSdY, 0)
				Top = Min(Top, pnlFastScroll.Height - pnlFastScrollCursor.Height)
				pnlFastScrollCursor.Top = Top
				If mFastScrollFixedLabel = False Then
					lblFastScroll.Top = pnlFastScrollCursor.Top + FscLabelTopDelta					
				End If
				SV2Top = Top / FScScale
				SV2.VerticalScrollPosition = SV2Top
			End If
		Case 1	'UP
			FScTimer.Enabled = True
	End Select
End Sub

Private Sub InitFastScroll
	pnlFastScroll.Top = SV2.Top
	pnlFastScroll.Height = SV2.Height
	FastScrollHeight = pnlFastScroll.Height - pnlFastScrollCursor.Height
	pnlFastScrollCursor.Top = SV2.VerticalScrollPosition * FScScale
	FscLabelTopDelta = SV2.Top + (FScCursorHeight - mFastScrollLabelHeight) / 2
	If mFastScrollFixedLabel = False Then
		lblFastScroll.Top = pnlFastScrollCursor.Top + FscLabelTopDelta		
	End If
	InitializeFastScrollCursor
End Sub

Private Sub CalcFastScroll(Pos As Int)
	Private i, Top As Int
	Top = Pos * FScScale
	pnlFastScrollCursor.Top = Top
	If mFastScrollFixedLabel = False Then
		lblFastScroll.Top = Top + FscLabelTopDelta
	End If
	If Data.Size > 0 Then
		i = (Pos + SV2.Height / 2) / cRowHeight
		Private str() As String
		str = Data.Get(i)
'		lblFastScroll.Text = str(mFastScrollColumnIndex).SubString2(0, Min(str(mFastScrollColumnIndex).Length, 10))
		lblFastScroll.Text = str(mFastScrollColumnIndex)
	End If
End Sub

Private Sub FastScrollTimer_Tick
	FScTimer.Enabled = False
	lblFastScroll.Visible = False
	pnlFastScroll.Visible = False
End Sub

'sets the header alignments for each column, all columns with the same alignment
'Example:
'<code>Table1.HeaderAlignment = Bit.OR(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)</code>
Public Sub setHeaderAlignment(Alignment As Int)
	Dim i As Int
	
	cHeaderAlignment = Alignment

	If cHeaderAlignments.Length = 0 Then
		Private cHeaderAlignments(mNumberOfColumns) As Int
	End If
	
	For i = 0 To mNumberOfColumns - 1
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
		HeaderFirst.Height = cHeaderHeight
		If mNumberOfFixedColumns = 0 Then
		For i = 0 To mNumberOfColumns - 1
			Dim lbl As Label
			lbl = Header.GetView(i)
			lbl.Height = Height
			Next
		Else
			For i = 0 To mNumberOfFixedColumns - 1
				Dim lbl As Label
				lbl = HeaderFirst.GetView(i)
				lbl.Height = Height				
			Next
			For i = mNumberOfFixedColumns To mNumberOfColumns - 1
				Dim lbl As Label
				lbl = Header.GetView(i - mNumberOfFixedColumns)
				lbl.Height = Height
			Next
		End If
		SV2.Top = cHeaderHeight
		SVF.Top = cHeaderHeight
		If cShowStatusLine = True Then
			SV2.Height = pnlTable.Height - cHeaderHeight - cRowHeight
		Else
			SV2.Height = pnlTable.Height - cHeaderHeight
		End If
		SVF.Height = SV2.Height
		InitFastScroll
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
		innerClearAll(mNumberOfColumns, True)'?
	End If
End Sub

Public Sub getRowColor1 As Int
	Return cRowColor1
End Sub

'sets or gets the even rows color
Public Sub setRowColor2(Color As Int)
	cRowColor2 = Color
	If pnlTable.IsInitialized Then
		innerClearAll(mNumberOfColumns, True)'?
	End If
End Sub

Public Sub getRowColor2 As Int
	Return cRowColor2
End Sub

'sets a specific color to the given row
Public Sub SetRowColorN(Row As Int, Color As Int)
	Private col As Int
	Private New = False As Boolean
	If lstRowColors.IndexOf(Color) > 0 Then
		lstRowColorIndexes.Set(Row, lstRowColors.IndexOf(Color) + 2)
	Else
		lstRowColors.Add(Color)
		lstRowColorIndexes.Set(Row, lstRowColors.Size + 1)	'specific row color indexes begin with 2
		New = True
	End If
'	If pnlTable.IsInitialized Then
	If Data.Size > 0 Then
		Private cdi(mNumberOfColumns) As Object
		For col = 0 To mNumberOfColumns - 1
			Private cdw As ColorDrawable
			cdw.Initialize(Color, 0)
			cdi(col) = cdw
		Next
		If New = False Then
			lstRowDrawables.Set(lstRowColors.IndexOf(Color), cdi)
		Else
			lstRowDrawables.Add(cdi)
		End If

'		innerClearAll(mNumberOfColumns, True)'?
'		RefreshTable
		RefreshLabels
	End If
End Sub

'gets the specific color of the given row
Public Sub GetRowColorN(Row As Int) As Int
	Return lstRowColors.Get(lstRowColorIndexes.Get(Row) - 2)
End Sub

'removes the specific color of the given row
Public Sub RemoveRowColorN(Row As Int)
	If Row > -1 And Row <lstRowColorIndexes.Size Then
		lstRowColorIndexes.Set(Row, 0)
		If pnlTable.IsInitialized Then
			RefreshLabels
		End If
	End If
End Sub

'sets or gets the selected row color
Public Sub setSelectedRowColor(Color As Int)
	cSelectedRowColor = Color
	If pnlTable.IsInitialized Then
		innerClearAll(mNumberOfColumns, True)'?
	End If
End Sub

Public Sub getSelectedRowColor As Int
	Return cSelectedRowColor
End Sub

'sets or gets the selected row text color
Public Sub setSelectedRowTextColor(TextColor As Int)
	cSelectedRowTextColor = TextColor
	If pnlTable.IsInitialized Then
		innerClearAll(mNumberOfColumns, True)'?
	End If
End Sub

Public Sub getSelectedRowTextColor As Int
	Return cSelectedRowTextColor
End Sub

'sets or gets the selected cell color
Public Sub setSelectedCellColor(Color As Int)
	cSelectedCellColor = Color
	If pnlTable.IsInitialized Then
		innerClearAll(mNumberOfColumns, True)'?
	End If
End Sub

Public Sub getSelectedCellColor As Int
	Return cSelectedCellColor
End Sub

'sets or gets the selected cell text color
Public Sub setSelectedCellTextColor(TextColor As Int)
	cSelectedCellTextColor = TextColor
	If pnlTable.IsInitialized Then
		innerClearAll(mNumberOfColumns, True)'?
	End If
End Sub

Public Sub getSelectedCellTextColor As Int
	Return cSelectedCellTextColor
End Sub

'sets or gets the table color (color of lines between cells)
Public Sub setTableColor(Color As Int)
	cTableColor = Color
	If SV2.IsInitialized = True Then
		SV2.Panel.Color = cTableColor
		SVF.Panel.Color = cTableColor
		If Header.IsInitialized Then
			Header.Color = cTableColor
			HeaderFirst.Color = cTableColor
		End If
	End If
End Sub

Public Sub getTableColor As Int
	Return cTableColor
End Sub

'sets or gets the cell text color
Public Sub setTextColor(Color As Int)
	cTextColor = Color
	If SV2.IsInitialized = True Then
		Dim i As Int
		For i = 0 To SV2.Panel.NumberOfViews - 1
			Dim lbl As Label
			lbl = SV2.Panel.GetView(i)
			lbl.TextColor = cTextColor
		Next
	End If
End Sub

Public Sub getTextColor As Int
	Return cTextColor
End Sub

'sets or gets the cell text size
Public Sub setTextSize(Size As Float)
	cTextSize = Size
	
	Private i As Int
	
	If Header.IsInitialized Then
		For i = 0 To Header.NumberOfViews - 1
			Dim lbl As Label
			lbl = Header.GetView(i)
			lbl.TextSize = cTextSize
		Next
	End If

	If SV2.IsInitialized = True Then
		For i = 0 To SV2.Panel.NumberOfViews - 1
			Dim lbl As Label
			lbl = SV2.Panel.GetView(i)
			lbl.TextSize = cTextSize
		Next
	End If
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
	If TypeFaces.Length = 1 Then
		cTypeFace = TypeFaces(0)
		MultiTypeFace = False
	Else
		If TypeFaces.Length <> mNumberOfColumns Then
			ToastMessageShow("Invalid number of columns", False)
			Return
		End If
		
		cTypeFaces0 = TypeFaces
		cTypeFaces = cTypeFaces0
		MultiTypeFace = True
	End If
	
	If Data.Size > 0 Then
		RefreshLabels
	End If
End Sub

'load data from a SQLite database
'SQLite = SQL object
'Query = SQLite query
'AutomaticWidths  True > set the column widths automaticaly
'ATTENTION: if you expect REAL numbers with more than 7 digits you should use LoadSQLiteDB2
'SQLite limits REAL numbers converted to Strings like Floats (7 digits) not Doubles
'even 1000000.5 returns 1000000
Public Sub LoadSQLiteDB(SQLite As SQL, Query As String, AutomaticWidths As Boolean)
	Dim Curs As Cursor
	Curs = SQLite.ExecQuery(Query)
	
	cAutomaticWidths = AutomaticWidths
	mNumberOfColumns = Curs.ColumnCount
	innerClearAll(mNumberOfColumns, True)
	
	Dim Headers(mNumberOfColumns) As String
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Dim cColumnDataType(mNumberOfColumns) As String
	Dim col, row As Int
	Dim str As String
	For col = 0 To mNumberOfColumns - 1
		cColumnDataType(col) = "TEXT"
		Headers(col) = Curs.GetColumnName(col)
		If AutomaticWidths = False Then
			ColumnWidths(col) = 130dip
			HeaderWidths(col) = 130dip
			DataWidths(col) = 130dip
		Else
			If MultiTypeFace = True Then
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFaces(col), cTextSize) + ExtraWidth
			Else
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFace, cTextSize) + ExtraWidth
			End If
			DataWidths(col) = 0
			For row = 0 To Curs.RowCount - 1
				Curs.Position = row
				str = Curs.GetString2(col)
				If str <> Null Then
					If MultiTypeFace = True Then
						DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFaces(col).DEFAULT, cTextSize) + ExtraWidth)
					Else
						DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFace, cTextSize) + ExtraWidth)
					End If
				End If
			Next
			ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
		End If
	Next
	SetHeader(Headers)
	SetColumnsWidths(ColumnWidths)
	
	For row = 0 To Curs.RowCount - 1
		Dim R(mNumberOfColumns), str As String
		For col = 0 To mNumberOfColumns - 1
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
	
'	Log(Data.Size)
End Sub

'load data from a SQLite database
'SQLite = SQL object
'Query = SQLite query
'AutomaticWidths  True > set the column widths automaticaly
'ColumDataTypes Array od strings with the data types
'		"TEXT
'		"NUMBER"
'Example:
'<code>Table1.LoadSQLiteDB2(SQL1, "SELECT * FROM Test", True, Array As String("NUMBER", "TEXT", "NUMBER", "NUMBER"))</code>
Public Sub LoadSQLiteDB2(SQLite As SQL, Query As String, AutomaticWidths As Boolean, ColumnDataTypes() As String)
	Dim Curs As Cursor
	Curs = SQLite.ExecQuery(Query)
	
	cAutomaticWidths = AutomaticWidths
	mNumberOfColumns = Curs.ColumnCount
	innerClearAll(mNumberOfColumns, True)
	
	Dim Headers(mNumberOfColumns) As String
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Dim cColumnDataType(mNumberOfColumns) As String
	Dim col, row As Int
	Dim ii As Long
	Dim dd As Double
	Dim str As String
	For col = 0 To mNumberOfColumns - 1
'		If ColumnDataTypes(col) = "T" Then 'changed in version 3.01
		If ColumnDataTypes(col).CharAt(0) = "T" Then
			cColumnDataType(col) = "TEXT"
		Else
			cColumnDataType(col) = "NUMBER"
		End If
		Headers(col) = Curs.GetColumnName(col)
		If AutomaticWidths = False Then
			ColumnWidths(col) = 130dip
			HeaderWidths(col) = 130dip
			DataWidths(col) = 130dip
		Else
			If HeaderMultiTypeFace = True Then
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFaces(col), cTextSize) + ExtraWidth
			Else
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFace, cTextSize) + ExtraWidth
			End If
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
				If MultiTypeFace = True Then
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFaces(col), cTextSize) + ExtraWidth)
				Else
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFace, cTextSize) + ExtraWidth)
				End If
			Next
			ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
		End If
	Next
	SetHeader(Headers)
	SetColumnsWidths(ColumnWidths)

	For row = 0 To Curs.RowCount - 1
		Curs.Position = row
		Dim R(mNumberOfColumns), str As String
		For col = 0 To mNumberOfColumns - 1
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

'load data from a SQLite database
'uses SQL.ExecQuery2, the query can include question marks which will be replaced with the values in the array.
'SQLite = SQL object
'Query = SQLite query
'Values = Array of Strings with the values
'AutomaticWidths  True > set the column widths automaticaly
'ATTENTION: if you expect REAL numbers with more than 7 digits you should use LoadSQLiteDB5
'SQLite limits REAL numbers converted to Strings like Floats (7 digits) not Doubles
'even 1000000.5 returns 1000000
Public Sub LoadSQLiteDB3(SQLite As SQL, Query As String, Values() As String, AutomaticWidths As Boolean)
	Dim Curs As Cursor
	Curs = SQLite.ExecQuery2(Query, Values)
	
	cAutomaticWidths = AutomaticWidths
	mNumberOfColumns = Curs.ColumnCount
	innerClearAll(mNumberOfColumns, True)
	
	Dim Headers(mNumberOfColumns) As String
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Dim cColumnDataType(mNumberOfColumns) As String
	Dim col, row As Int
	Dim str As String
	For col = 0 To mNumberOfColumns - 1
		cColumnDataType(col) = "TEXT"
		Headers(col) = Curs.GetColumnName(col)
		If AutomaticWidths = False Then
			ColumnWidths(col) = 130dip
			HeaderWidths(col) = 130dip
			DataWidths(col) = 130dip
		Else
			If HeaderMultiTypeFace = True Then
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFaces(col), cTextSize) + ExtraWidth
			Else
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFace, cTextSize) + ExtraWidth
			End If
			DataWidths(col) = 0
			For row = 0 To Curs.RowCount - 1
				Curs.Position = row
				str = Curs.GetString2(col)
				If str <> Null Then
					If MultiTypeFace = True Then
						DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFaces(col), cTextSize) + ExtraWidth)
					Else
						DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFace, cTextSize) + ExtraWidth)
					End If
				End If
			Next
			ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
		End If
	Next
	SetHeader(Headers)
	SetColumnsWidths(ColumnWidths)
	
	For row = 0 To Curs.RowCount - 1
		Dim R(mNumberOfColumns), str As String
		For col = 0 To mNumberOfColumns - 1
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

'load data from a SQLite database with data type checking
'similar to LoadSQLiteDB2 without the need to provide the data types Array.
'if all values in a column are numbers, the data type is set to NUMBER otherwise it's TEXT
'SQLite = SQL object
'Query = SQLite query
'AutomaticWidths  True > set the column widths automaticaly
Public Sub LoadSQLiteDB4(SQLite As SQL, Query As String, AutomaticWidths As Boolean)
	Private Curs As Cursor
	
	Curs = SQLite.ExecQuery(Query)
	
	cAutomaticWidths = AutomaticWidths
	mNumberOfColumns = Curs.ColumnCount
	innerClearAll(mNumberOfColumns, True)
	
	Dim Headers(mNumberOfColumns) As String
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Private col, row As Int
	Private str As String
	Private dVal As Double

	cColumnDataType = CheckColumnDataTypes(Curs)
	
	For col = 0 To mNumberOfColumns - 1
		Headers(col) = Curs.GetColumnName(col)
		If AutomaticWidths = False Then
			ColumnWidths(col) = 130dip
			HeaderWidths(col) = 130dip
			DataWidths(col) = 130dip
		Else
			If HeaderMultiTypeFace = True Then
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFaces(col), cTextSize) + ExtraWidth
			Else
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFace, cTextSize) + ExtraWidth
			End If
			DataWidths(col) = 0
			For row = 0 To Curs.RowCount - 1
				Curs.Position = row
				str = Curs.GetString2(col)
				If str = Null Then
					str = ""
				Else If IsNumber(str) Then
					dVal = Curs.GetDouble2(col)
					str = dVal
				End If
				If MultiTypeFace = True Then
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFaces(col), cTextSize) + ExtraWidth)
				Else
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFace, cTextSize) + ExtraWidth)
				End If
			Next
			ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
		End If
	Next
	SetHeader(Headers)
	SetColumnsWidths(ColumnWidths)
	
	For row = 0 To Curs.RowCount - 1
		Dim R(mNumberOfColumns), str As String
		For col = 0 To mNumberOfColumns - 1
			Curs.Position = row
			str = Curs.GetString2(col)
			If str = Null Then
				str = ""
			Else If IsNumber(str) Then
				dVal = Curs.GetDouble2(col)
				str = dVal
			End If
			R(col) = str
		Next
		AddRow(R)
	Next
	
	Curs.Close
End Sub

'load data from a SQLite database with data type checking
'uses SQL.ExecQuery2, the query can include question marks which will be replaced with the values in the array.
'SQLite = SQL object
'Query = SQLite query
'Values = Array of Strings with the values
'AutomaticWidths  True > set the column widths automaticaly
Public Sub LoadSQLiteDB5(SQLite As SQL, Query As String, Values() As String, AutomaticWidths As Boolean)
	Private Curs As Cursor
	
	Curs = SQLite.ExecQuery2(Query, Values)
	
	cAutomaticWidths = AutomaticWidths
	mNumberOfColumns = Curs.ColumnCount
	innerClearAll(mNumberOfColumns, True)
	
	Dim Headers(mNumberOfColumns) As String
	Dim ColumnWidths(mNumberOfColumns) As Int
	Dim HeaderWidths(mNumberOfColumns) As Int
	Dim DataWidths(mNumberOfColumns) As Int
	Private col, row As Int
	Private str As String
	Private dVal As Double

	cColumnDataType = CheckColumnDataTypes(Curs)
	
	For col = 0 To mNumberOfColumns - 1
		Headers(col) = Curs.GetColumnName(col)
		If AutomaticWidths = False Then
			ColumnWidths(col) = 130dip
			HeaderWidths(col) = 130dip
			DataWidths(col) = 130dip
		Else
			If HeaderMultiTypeFace = True Then
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFaces(col), cTextSize) + ExtraWidth
			Else
				HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), cHeaderTypeFace, cTextSize) + ExtraWidth
			End If
			DataWidths(col) = 0
			For row = 0 To Curs.RowCount - 1
				Curs.Position = row
				str = Curs.GetString2(col)
				If str = Null Then
					str = ""
				Else If IsNumber(str) Then
					dVal = Curs.GetDouble2(col)
					str = dVal
				End If
				If MultiTypeFace = True Then
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFaces(col), cTextSize) + ExtraWidth)
				Else
					DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, cTypeFace, cTextSize) + ExtraWidth)
				End If
			Next
			ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))
		End If
	Next
	SetHeader(Headers)
	SetColumnsWidths(ColumnWidths)
	
	For row = 0 To Curs.RowCount - 1
		Dim R(mNumberOfColumns), str As String
		For col = 0 To mNumberOfColumns - 1
			Curs.Position = row
			str = Curs.GetString2(col)
			If str = Null Then
				str = ""
			Else If IsNumber(str) Then
				dVal = Curs.GetDouble2(col)
				str = dVal
			End If
			R(col) = str
		Next
		AddRow(R)
	Next
	
	Curs.Close
End Sub

'Returns an Array with the column data types.
'TEXT or NUMBER
Private Sub CheckColumnDataTypes(MyCurs As Cursor) As String()
	Private NbCols, NbRows As Int
	NbCols = MyCurs.ColumnCount
	NbRows = MyCurs.RowCount
	
	Private ColumnTypes(NbCols), str As String
	Private col, row As Int
	
	For col = 0 To NbCols - 1
		ColumnTypes(col) = "TEXT"
		For row = 0 To NbRows - 1
			MyCurs.Position = row
			str = MyCurs.GetString2(col)
			If str = Null Then
				str = ""
			End If
			If IsNumber(str) Then
				ColumnTypes(col) = "NUMBER"
			Else
				ColumnTypes(col) = "TEXT"
				Exit
			End If
		Next
	Next

	Return ColumnTypes
End Sub

Public Sub RemoveView
	pnlTable.RemoveView
End Sub

Private Sub SetPadding(v As View, Left As Int, Top As Int, Right As Int, Bottom As Int)
	v.Padding = Array As Int (Left, Top, Right, Bottom)
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
		Dim cColumnColors(mNumberOfColumns) As Int
		Dim cTextColors(mNumberOfColumns) As Int
		For i = 0 To mNumberOfColumns - 1
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
		Dim cHeaderColors(mNumberOfColumns) As Int
		Dim cHeaderTextColors(mNumberOfColumns) As Int
		For i = 0 To mNumberOfColumns - 1
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

Public Sub getHeaderTypeFace As Typeface
	Return cHeaderTypeFace
End Sub

'Sets or gets the same TypeFace for all Header texts
Public Sub setHeaderTypeFace(HeaderTypeFace As Typeface)
	cHeaderTypeFace = HeaderTypeFace
	HeaderMultiTypeFace = False
	If Header.NumberOfViews > 0 Then
		For col = 0 To mNumberOfColumns - 1
			Private lbl As Label
			lbl = Header.GetView(col)
			lbl.Typeface = cHeaderTypeFace
		Next
	End If
End Sub

'Sets the TypeFace for each Header text
Public Sub SetHeaderTypeFaces(HeaderTypeFaces() As Typeface)
	Private col As Int
	
	If HeaderTypeFaces.Length = 1 Then
		cHeaderTypeFace = HeaderTypeFaces(0)
		HeaderMultiTypeFace = False
		If Header.NumberOfViews > 0 Then
			If mNumberOfFixedColumns = 0 Then
				For col = 0 To mNumberOfColumns - 1
					Private lbl As Label
					lbl = Header.GetView(col)
					lbl.Typeface = cHeaderTypeFace
				Next
			Else
				Private lbl As Label
				lbl = HeaderFirst.GetView(0)
				lbl.Typeface = cHeaderTypeFaces(0)
				For col = 0 To mNumberOfColumns - 2
					Private lbl As Label
					lbl = Header.GetView(col)
					lbl.Typeface = cHeaderTypeFace
				Next
			End If
		End If
	Else
		If HeaderTypeFaces.Length <> mNumberOfColumns Then
			ToastMessageShow("Invalid number of columns", False)
			Log("SetHeaderTypeFaces: Invalid number of columns")
			Return
		Else
			cHeaderTypeFaces0 = HeaderTypeFaces
			cHeaderTypeFaces = cHeaderTypeFaces0
			HeaderMultiTypeFace = True
			If Header.NumberOfViews > 0 Then
				If mNumberOfFixedColumns = 0 Then
					For col = 0 To mNumberOfColumns - 1
						Private lbl As Label
						lbl = Header.GetView(col)
						lbl.Typeface = cHeaderTypeFaces(col)
					Next
				Else
					For i = 0 To mNumberOfFixedColumns - 1
						Private lbl As Label
						lbl = HeaderFirst.GetView(i)
						lbl.Typeface = cHeaderTypeFaces(i)
					Next
					For col = 0 To mNumberOfColumns - mNumberOfFixedColumns - 1
						Private lbl As Label
						lbl = Header.GetView(col)
						lbl.Typeface = cHeaderTypeFaces(col + mNumberOfFixedColumns - 1)
					Next
				End If
			End If
		End If
	End If
End Sub

Public Sub GetHeaderTextColors As Int()
	Return cHeaderTextColors
End Sub

'True sets the cells to single line
Public Sub setSingleLine(SingleLine As Boolean)
	Private row, col As Int
	cSingleLine = SingleLine
	
	If LabelsCache.Size > 0 Then
		For row = 0 To LabelsCache.Size - 1
			Private lbls(mNumberOfColumns) As Label
			lbls = LabelsCache.Get(row)
			For col = 0 To mNumberOfColumns - 1
				Private jo As JavaObject
				jo = lbls(col)
				jo.RunMethod("setSingleLine", Array(cSingleLine))
			Next
		Next
	End If
End Sub

Public Sub getSingleLine As Boolean
	Return cSingleLine
End Sub

'Calculates the column widths according to the longest text in each column
'hidden columns will be undidden
Public Sub SetAutomaticWidths
	Dim row, col As Int
	Dim Vals(mNumberOfColumns) As String
	Dim Width, Widths(mNumberOfColumns) As Int
	
	cAutomaticWidths = True
	
	For col = 0 To mNumberOfColumns - 1
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

'True shows the status line at the bottom
Public Sub setShowStatusLine(ShowStatusLine As Boolean)
	cShowStatusLine = ShowStatusLine
	If cShowStatusLine = True Then
		SV2.Height = cHeight - Header.Height - cRowHeight
		lblStatusLine.Visible = True
	Else
		SV2.Height = cHeight - Header.Height
		lblStatusLine.Visible = False
	End If
	SVF.Height = SV2.Height
	InitFastScroll
	
End Sub

Public Sub getShowStatusLine As Boolean
	Return cShowStatusLine
End Sub

'Gets the base Panel of the Table
Public Sub getPanel As Panel
	Return pnlTable
End Sub

'Scales the Table with the two scale factors.
'This routine is useful with Scale Module.
' It must be called before filling the Table.
'ScaleX = horizontal sclae factor
'ScaleY = Vertical sclae factor
'ScaleAllDone = True if ScaleAll of the Scale Module was already used
'ScaleAllDone = False if ScaleAll of the Scale Module was not used
Public Sub ScaleTable(ScaleX As Double, ScaleY As Double, ScaleAllDone As Boolean)
	If Data.Size > 0 Then
		ToastMessageShow("Table.ScaleTable must be called before filling the Table", False) 
		Log("Table.ScaleTable must be called before filling the Table")
		Return
	End If

	cTextSize = cTextSize * Min(ScaleX, ScaleY)
	cLineWidth = cLineWidth * ScaleX
	ExtraWidth = ExtraWidth * ScaleX
	cRowHeight  = cRowHeight * ScaleY
	cHeaderHeight = cHeaderHeight * ScaleY
	For i = 0 To mNumberOfColumns - 1
		ColumnWidths(i) = ColumnWidths(i) * ScaleX
		DataWidths(i) = DataWidths(i) * ScaleX
		HeaderWidths(i) = HeaderWidths(i)	* ScaleX
		SavedWidths(i) = SavedWidths(i)	* ScaleX
	Next
		
	If ScaleAllDone = False Then
		cLeft = cLeft * ScaleX
		cTop = cTop * ScaleY
		cWidth = cWidth * ScaleX
		cHeight = cHeight * ScaleY
		
		pnlTable.Left = cLeft
		pnlTable.Top = cTop
		pnlTable.Width = cWidth
		pnlTable.Height = cHeight
		Header.Height = cHeaderHeight
		SV2.Width = cWidth
		SV2.Top = cHeaderHeight
		If (cShowStatusLine = True) Then
			SV2.Height = cHeight - cRowHeight - cHeaderHeight
		Else
			SV2.Height = cHeight - cHeaderHeight 
		End If
		InitFastScroll
		lblStatusLine.TextSize = cTextSize
		lblStatusLine.Height = cRowHeight
		lblStatusLine.Top = SV2.Top + SV2.Height
	End If
	CreateNewLabels
End Sub

'Gets or sets the Table Tag
Public Sub setTag(Tag As Object)
	pnlTable.Tag = Tag
End Sub

Public Sub getTag As Object
	Return pnlTable.Tag
End Sub

'sets the data type of a column
'Col = index of the column
'DataType can be either "TEXT" or "NUMBER"
Public Sub SetColumnDataType(Column As Int, DataType As String)
	If Column < 0 Or Column > mNumberOfColumns - 1 Then
		ToastMessageShow("Wrong column index", False)
		Return
	End If

	If DataType <> "TEXT" And DataType <> "NUMBER" Then
		ToastMessageShow("Wrong data type only TEXT abd NUMBER are allowed", False)
		Return		
	End If

	cColumnDataType(Column) = DataType
End Sub

'gets the data type of the given column 
'returns a Strings, the value is either TEXT or NUMBER
Public Sub GetColumnDataType(Column As Int) As String
	If Column < 0 Or Column > mNumberOfColumns - 1 Then
		ToastMessageShow("Wrong column index", False)
		Return ""
	End If
	
	Return cColumnDataType(Column)
End Sub

'sets the data type of all columns
'Col = index of the column
'DataType() array, can be either "TEXT" or "NUMBER"
'Example:
'<code>SetColumnDataTypes(Array As String("NUMBER", "TEXT", "TEXT", "TEXT", "NUMBER")</code>
Public Sub SetColumnDataTypes(DataType() As String)
	If DataType.Length <> mNumberOfColumns Then
		ToastMessageShow("Wrong number of columns", False)
		Return
	End If
	
	For Col = 0 To mNumberOfColumns - 1
		If DataType(Col) <> "TEXT" And DataType(Col) <> "NUMBER" Then
			ToastMessageShow("Wrong data type only TEXT abd NUMBER are allowed", False)
			Return		
		End If	
	Next
	
	cColumnDataType = DataType
End Sub

'gets the data types of all current 
'returns an Array of Strings, the values are either TEXT or NUMBER
Public Sub GetColumnDataTypes As String()
	Return cColumnDataType
End Sub

'gets the number of columns, read only
Public Sub getNumberOfColumns As Int
	Return mNumberOfColumns
End Sub

'gets the number of rowsolumns, read only
Public Sub getNumberOfRows As Int
	Return Data.Size
End Sub

'gets or sets the SortRemoveAccents property
'Sorts without accented characters. 
'Removes the accents for a correct sorting. 
'This can slow down the sorting.
Public Sub getSortRemoveAccents As Boolean
	Return cSortRemoveAccents
End Sub

Public Sub setSortRemoveAccents(SortRemoveAccents As Boolean)
	cSortRemoveAccents = SortRemoveAccents
End Sub

'returns a new string without accented characters
Private Sub RemoveAccents(s As String) As String
	Dim normalizer As JavaObject
	normalizer.InitializeStatic("java.text.Normalizer")
	Dim n As String = normalizer.RunMethod("normalize", Array As Object(s, "NFD"))
	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To n.Length - 1
		If Regex.IsMatch("\p{InCombiningDiacriticalMarks}", n.CharAt(i)) = False  Then
			sb.Append(n.CharAt(i))
		End If
	Next
	Return sb.ToString
End Sub

'sets or gets the color of the sort width
'should be an even value in dips 
Public Sub setSortBitmapWidth(Width As Int)
	cSortBitmapWidth = Width
	InitializeSortingBitmaps
End Sub

Public Sub getSortBitmapWidth As Int
	Return cSortBitmapWidth
End Sub

'sets or gets the color of the sort bitmaps
Public Sub setSortBitmapColor(Color As Int)
	cSortBitmapColor = Color
	InitializeSortingBitmaps
End Sub

Public Sub getSortBitmapColor As Int
	Return cSortBitmapColor
End Sub

'sets the two custom sorting Bitmaps.
'the files must be in the Files folder
'the default width of the parent view is 10dip
'this value is the SortBitmapWidth property.  
'the height of the parent view is half the width, set internally.
'the SortBitmapColor property has no effect with custom bitmaps.
Public Sub SetSortingBitmaps(BitmapAscFilename As String, BitmapDesFilename As String)
	bmpAsc.Initialize(File.DirAssets, BitmapAscFilename)
	bmpDes.Initialize(File.DirAssets, BitmapDesFilename)
	mCustomSortingBitmaps = True
End Sub

'sets or gets the ZeroSelection property
'With ZeroSelection = True, when press on a selectd row this one will be unselected.
'Default value = False, a selected row remains selected when you press on it.
Public Sub setZeroSelection(ZeroSelection As Boolean)
	mZeroSelection = ZeroSelection
End Sub

'gets or sets the NumberFixedColumns property
'When > 0 then, the specified number of first columns remains at their place they will not scroll horizontally
'Default value = 0
'Max value = 3 
Public Sub setNumberOfFixedColumns(NumberOfFixedColumns As Int)
	NumberOfFixedColumns = Max(0, Min(3, NumberOfFixedColumns)) 'set the value in the limits 0 - 3
	If mNumberOfFixedColumns = NumberOfFixedColumns Then
		Return 
	End If
	
	If Header.NumberOfViews = 0 Then
		mNumberOfFixedColumns = NumberOfFixedColumns	'New
	Else
		Private col As Int
		
		Private Headers(mNumberOfColumns) As String
		If HeaderFirst.NumberOfViews = 0 Then
			For col = 0 To mNumberOfColumns - 1
				Private lbl As Label
				lbl = Header.GetView(col)
				Headers(col) = lbl.Text
			Next		
		Else
			For col = 0 To mNumberOfFixedColumns - 1
				Private lbl As Label
				lbl = HeaderFirst.GetView(col)
				Headers(col) = lbl.Text
			Next
			For col = mNumberOfFixedColumns To mNumberOfColumns - 1
				Private lbl As Label
				lbl = Header.GetView(col - mNumberOfFixedColumns)
				Headers(col) = lbl.Text
			Next
		End If
	
		HeaderFirst.RemoveAllViews
		Header.RemoveAllViews

		mNumberOfFixedColumns = NumberOfFixedColumns
	
		innerClearAll(mNumberOfColumns, False)
		SetHeader(Headers)
		SetColumnsWidths(ColumnWidths)
		SV2.Panel.Height = Data.Size * cRowHeight
		SVF.Panel.Height = SV2.Panel.Height
	
'	Update the table
		Private currentMax As Int
		currentMax = Min(Data.Size - 1, SV2.Height / cRowHeight + 30)
	
		For row = 0 To currentMax
			ShowRow(row)
		Next
	End If

End Sub

Public Sub getNumberOfFixedColumns As Int
	Return mNumberOfFixedColumns
End Sub


'gets or sets the FirstColumnFixed property
'When True, the first column remains at its place it will not scroll horizontally
'Default value = True 
'This property is obsolete you should set NumberFixedColumns
'If you set it to True and NumberFixedColumns = 0, NumberFixedColumns will be set to 1
'If you set it to Galse and NumberFixedColumns = 1, NumberFixedColumns will be set to 0
Public Sub setFirstColumnFixed(FirstColumnFixed As Boolean)
	If FirstColumnFixed = True Then
		If mNumberOfFixedColumns = 0 Then
			setNumberOfFixedColumns(1)
		End If
	Else
		If mNumberOfFixedColumns = 1 Then
			setNumberOfFixedColumns(0)
		End If
	End If
End Sub

Public Sub getFirstColumnFixed As Boolean
	Return mFirstColumnFixed
End Sub

'returns white for a dark color or returns black for a light color for a good contrast between bachground and text colors
Private Sub GetContrastColor(Color As Int) As Int
	Private a, r, g, b, yiq As Int	'ignore
	
	a = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	b = Bit.And(Color, 0xff)
	
	yiq = r * 0.299 + g * 0.587 + b * 0.114
	
	If yiq > 128 Then
		Return Colors.Black
	Else
		Return Colors.White
	End If
End Sub

'gets or sets the FastScroll property
'Allows a fast scroll method
'Default value False
Public Sub getFastScroll As Boolean
	Return mFastScroll
End Sub

Public Sub setFastScroll (FastScroll As Boolean)
	mFastScroll = FastScroll
	pnlFastScroll.Visible = False
	lblFastScroll.Visible = False
End Sub

'gets or sets the FastScrollMinItems property
'Sets the number minumum of items before the fast scroll method is activated.
'Default value 50
Public Sub getFastScrollMinItems As Int
	Return mFastScrollMinItems
End Sub

Public Sub setFastScrollMinItems (FastScrollMinItems As Int)
	mFastScrollMinItems = FastScrollMinItems
End Sub

'gets or sets the FastScrollColumnIndex property
'Sets the column idex for the display in the fast scroll label.
'Default value 0
Public Sub getFastScrollColumnIndex As Int
	Return mFastScrollColumnIndex
End Sub

Public Sub setFastScrollColumnIndex (FastScrollColumnIndex As Int)
	mFastScrollColumnIndex = Max(0, FastScrollColumnIndex)
	mFastScrollColumnIndex = Min(mFastScrollColumnIndex, mNumberOfColumns - 1)
End Sub

'gets or sets the FastScrollShowLabel property
'Displays the fast scroll label showing the text in the column set in the  property.
'Default value True
Public Sub getFastScrollShowLabel As Boolean
	Return mFastScrollShowLabel
End Sub

Public Sub setFastScrollShowLabel (FastScrollShowLabel As Boolean)
	mFastScrollShowLabel = FastScrollShowLabel
	lblFastScroll.Visible = False
End Sub

'gets or sets the FastScrollFixedLabel property
'Displays the fast scroll label showing the text in the column set in the  property.
'Default value True
Public Sub getFastScrollFixedLabel As Boolean
	Return mFastScrollFixedLabel
End Sub

Public Sub setFastScrollFixedLabel (FastScrollFixedLabel As Boolean)
	mFastScrollFixedLabel = FastScrollFixedLabel
	If mFastScrollFixedLabel = False Then
		lblFastScroll.Left = cWidth - mFastScrollLabelWidth - mFastScrollLabelWidth
		lblFastScroll.Top = pnlFastScrollCursor.Top + FscLabelTopDelta
	Else
		lblFastScroll.Left = 0
		lblFastScroll.Top = (SV2.Height + lblFastScroll.Height) / 2
	End If
	lblFastScroll.Visible = False
End Sub

