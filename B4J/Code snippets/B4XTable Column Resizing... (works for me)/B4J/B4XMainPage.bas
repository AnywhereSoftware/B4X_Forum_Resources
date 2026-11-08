B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

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
	'added by MAGMA:
	Dim hheaderpanel As B4XView
	Dim ViewsThatShouldBeRemoved As List
	Dim headerpressing As Boolean=False
	Dim B4XTableTimer As Timer
	Dim lastcolwidth() As Int
	'---------------
	
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
	

	B4XTable1.VisibleColumns.RemoveAt(B4XTable1.VisibleColumns.IndexOf(NumberColumn))  
	B4XTable1.VisibleColumns.InsertAt(1, NumberColumn)
	B4XTable1.Refresh

	'added by Magma...
	Sleep(0)
	
	Dim lastcolwidth(B4XTable1.Columns.Size) As Int
	
	ViewsThatShouldBeRemoved.Initialize
	For k=0 To B4XTable1.visibleColumns.Size-1
		Dim kko As B4XTableColumn = B4XTable1.visibleColumns.Get(k)
		kko.DisableAutoResizeLayout=True
		kko.Width=150dip  'important to set width
		lastcolwidth(k)=kko.width
	Next
	
	

	B4XTableTimer.Initialize("B4XTableTimers",1000)
	B4XTableTimer.Enabled=True
	
End Sub

Sub B4XTableTimers_Tick
	B4XTableTimer.Enabled=False
	enableresize
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


' MAGMA (Georgios Kantzas) addition... to this example - For Resizing...
' ofcourse you can donate my with paypal at cyberd@mmpc.gr  /// don't forget donating B4X too!!!!
' Credits go to:
' Thanks Erel... for RemoviewfromParent and List Idea !!!
' Thanks LucaMs clv.sv.ScrollViewOffsetX !!!! :-)

Sub enableresize
	
	'lets see - first we must remove the guidelines if already add them - because sometimes, resizing the table... change form size... blah blah...
	' headerpanel are the guidelines ...sorry for my bad names for the objects !!! i was testing...

	If headerpressing=False Then
	B4XTableTimer.Enabled=False
	headerpressing=True
'	Log("count them again")
		For Each v As B4XView In ViewsThatShouldBeRemoved
			v.RemoveViewFromParent
		Next
	Sleep(0)
	
	Dim clv As CustomListView = B4XTable1.clvData
	Dim scrollx As Int=clv.sv.ScrollViewOffsetX
	
	Dim leftest As Int=B4XTable1.mBase.left-scrollx
	
'	Log(leftest)

	ViewsThatShouldBeRemoved.Clear
	
	For k=0 To B4XTable1.visibleColumns.Size-1
		hheaderpanel.As(B4XView)=xui.CreatePanel("hhheaderpanel")
			
		ViewsThatShouldBeRemoved.Add(hheaderpanel)
		hheaderpanel.Tag= k

		hheaderpanel.SetColorAndBorder(xui.Color_Transparent,2,0,0)
	
		Dim cc As B4XTableColumn=B4XTable1.visibleColumns.Get(k)
		
		leftest=leftest+cc.Width
		
		Root.AddView(hheaderpanel,leftest,B4XTable1.mBase.Top+41,2,B4XTable1.mBase.Height-60) '+41 for label,search, -60 scrollbar height - can we get those somehow... ?

	Next
	Sleep(0)
	headerpressing=False
	B4XTableTimer.Enabled=True
	End If
	
End Sub


Private Sub hhheaderpanel_MouseEntered (EventData As MouseEvent)
	If EventData.PrimaryButtondown Then Return
	Dim pane1 As B4XView=Sender
	pane1.SetColorAndBorder(xui.Color_Green,2,0,0)
End Sub

Private Sub hhheaderpanel_MouseExited (EventData As MouseEvent)
	If EventData.PrimaryButtondown Then Return
	Dim pane1 As B4XView=Sender
	pane1.SetColorAndBorder(xui.Color_Transparent,2,0,0)
End Sub

Private Sub hhheaderpanel_MouseDragged (EventData As MouseEvent)
	If EventData.PrimaryButtondown Then
		B4XTableTimer.Enabled=False
		Dim pane1 As B4XView=Sender
		headerpressing=True
			
		If pane1.Left+EventData.X<B4XTable1.mbase.left+B4XTable1.mBase.Width And pane1.left+EventData.X>B4XTable1.mbase.left Then
			pane1.Left=pane1.Left+EventData.X
		End If

	End If
End Sub

Private Sub hhheaderpanel_MouseReleased (EventData As MouseEvent)
	If headerpressing=True Then
		headerpressing=False
'		Log("size it")
		Dim pane1 As B4XView=Sender
		Dim cc1 As B4XTableColumn=B4XTable1.visibleColumns.Get(pane1.tag)
		'lets count some things
		Dim beforesize As Int=cc1.Width
		Dim fromleftsize As Int
		Dim newsize As Int
		For k=0 To pane1.tag-1
			Dim cc As B4XTableColumn=B4XTable1.visibleColumns.Get(k)
			fromleftsize=fromleftsize+cc.Width
		Next
		newsize=cc1.Width
		If pane1.Left>beforesize Then
			newsize=(pane1.left-B4XTable1.mBase.Left)-fromleftsize
		Else
			If pane1.Left>B4XTable1.mBase.Left+fromleftsize Then
				newsize=(pane1.left-B4XTable1.mBase.Left)-fromleftsize
			Else
				pane1.Left=fromleftsize+cc1.Width
			End If
		End If
		cc1.Width=newsize
		B4XTable1.Refresh
		Sleep(0)
		enableresize
		B4XTableTimer.Enabled=True
		
	End If
End Sub

Private Sub hhheaderpanel_MouseClicked (EventData As MouseEvent)
	If EventData.ClickCount=2 Then
		B4XTableTimer.Enabled=False
		headerpressing=False
		Dim pane1 As B4XView=Sender
		Dim cc1 As B4XTableColumn=B4XTable1.visibleColumns.Get(pane1.tag)
		Dim fromleftsize As Int
		For k=0 To pane1.tag-1
			Dim cc As B4XTableColumn=B4XTable1.visibleColumns.Get(k)
			fromleftsize=fromleftsize+cc.Width
		Next
		If cc1.Width>1 Then
			lastcolwidth(pane1.tag)=cc1.Width
			cc1.Width=1
		Else
			cc1.Width=lastcolwidth(pane1.tag)
		End If
		pane1.Left=fromleftsize+cc1.Width
		Sleep(0)
		B4XTable1.Refresh
		Sleep(0)
		enableresize
		B4XTableTimer.Enabled=True
	End If
End Sub

private Sub B4XPage_Resize(Width As Double, Height As Double)
	If hheaderpanel.IsInitialized Then
		enableresize
	End If
End Sub

