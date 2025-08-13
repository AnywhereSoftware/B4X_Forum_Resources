B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?VMArgs=-DZeroSharedFiles%3DTrue&File=%B4X%\Zipper.jar&Args=B4XTableExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private B4XTable1 As B4XTable
	Private xui As XUI
	Private NumberColumn As B4XTableColumn
	#if B4A or B4i
	Private btnPrev As Button
	Private btnNext As Button
	#end if
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "B4XTable Example")
	'create the columns
	B4XTable1.AddColumn("US County", B4XTable1.COLUMN_TYPE_NUMBERS)
	B4XTable1.AddColumn("Name", B4XTable1.COLUMN_TYPE_TEXT)
	Dim StateColumn As B4XTableColumn = B4XTable1.AddColumn("State", B4XTable1.COLUMN_TYPE_TEXT)
	StateColumn.Width = 80dip
	NumberColumn = B4XTable1.AddColumn("Interesting Number", B4XTable1.COLUMN_TYPE_NUMBERS)
	CreateCustomFormat(NumberColumn)
	Dim parser As CSVParser
	parser.Initialize
	Dim data As List = parser.Parse(File.ReadString(File.DirAssets, "us_counties.csv"), ",", True)
	B4XTable1.SetData(data)
	
	'change the visible colums order
	'remove the number columns
	B4XTable1.VisibleColumns.RemoveAt(B4XTable1.VisibleColumns.IndexOf(NumberColumn))
	B4XTable1.VisibleColumns.InsertAt(1, NumberColumn)
	B4XTable1.Refresh
End Sub

Sub btnNext_Click
	B4XTable1.CurrentPage = B4XTable1.CurrentPage + 1
End Sub

Sub btnPrev_Click
	B4XTable1.CurrentPage = B4XTable1.CurrentPage - 1
End Sub

Sub B4XTable1_DataUpdated
	#if B4A or B4i
	btnNext.Visible = B4XTable1.lblNext.Tag
	btnPrev.Visible = B4XTable1.lblBack.Tag
	#end if
End Sub

Sub B4XSwitch1_ValueChanged (Value As Boolean)
	If Value Then
		'create custom filter
		B4XTable1.CreateDataView($"${NumberColumn.SQLID} > 10"$)
	Else
		B4XTable1.ClearDataView
	End If
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	Dim RowData As Map = B4XTable1.GetRow(RowId)
	Dim cell As String = RowData.Get(ColumnId)
	B4XPages.SetTitle(Me, cell)
End Sub

Private Sub CreateCustomFormat (c As B4XTableColumn)
	Dim formatter As B4XFormatter
	formatter.Initialize
	c.Formatter = formatter
	Dim Positive As B4XFormatData = c.Formatter.NewFormatData
	Positive.TextColor = B4XTable1.TextColor
	Positive.FormatFont = xui.CreateDefaultFont(16)
	c.Formatter.AddFormatData(Positive, 0, c.Formatter.MAX_VALUE, True) 'Inclusive (zero included)
	Dim Negative As B4XFormatData = c.Formatter.CopyFormatData(Positive)
	Negative.TextColor = xui.Color_Red
	Negative.FormatFont = xui.CreateDefaultBoldFont(16)
	Negative.Prefix = "("
	Negative.Postfix = ")"
	c.Formatter.AddFormatData(Negative,c.Formatter.MIN_VALUE, 0, False)
End Sub

#if B4i
Sub B4XPage_KeyboardStateChanged (Height As Float)
	If B4XTable1.IsInitialized Then
		Dim base As Panel = B4XTable1.mBase
		Dim TableViewMaxHeight As Int = base.CalcRelativeKeyboardHeight(Height)
		Dim TableViewMaxHeightWithNoKeyboard As Int = Root.Height - 2dip - B4XTable1.mBase.Top
		'If the keyboard is visible then the TableView ends at the keyboard's top line.
		'Otherwise the TableView will end a few pixels from the full page size.
		base.Height = Min(TableViewMaxHeight, TableViewMaxHeightWithNoKeyboard)
	End If
End Sub
#Else If B4A
Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	If B4XTable1.IsInitialized Then
		B4XTable1.mBase.Height = NewHeight - B4XTable1.mBase.Top
		B4XTable1.Refresh
	End If
End Sub
#end if
