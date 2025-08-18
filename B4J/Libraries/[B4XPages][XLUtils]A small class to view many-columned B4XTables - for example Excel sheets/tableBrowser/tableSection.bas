B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.87
@EndOfDesignText@
'This class is optimized for B4J - the row and column selections as well as the Toolkit will only work in B4J
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private MP As B4XMainPage
	Private B4XTable1 As B4XTable
	Private sectionNumber As Int
	Private dataRows(2) As Int
	Private addresses() As String
	Private columnNames() As String
	Private buildingTable As Boolean
	Private Label1, Label2 As Label
	
	Private sorted As Boolean = False
	Private TableData As List
	Private ControlKey As Boolean	
	Private AltKey As Boolean	
	Private Tools As Label
	Private ToolList As ListView
	Private txtEng As BCTextEngine
	Public reportPanel As BBCodeView
	Public exitBtn As Button
End Sub

Public Sub Initialize(sectionNumber1 As Int, dataRows1() As Int, addresses1() As String, columnNames1() As String) As Object
	MP = B4XPages.MainPage
	sectionNumber = sectionNumber1
	addresses = addresses1
	dataRows = dataRows1
	columnNames = columnNames1
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("genericTable")
	txtEng.Initialize(Root)
	reportPanel.TextEngine = txtEng

	Dim r As Reflector
	r.Target = B4XPages.GetNativeParent(Me).rootPane
	r.AddEventHandler("keypressed", "javafx.scene.input.KeyEvent.KEY_PRESSED")
	r.AddEventHandler("keyreleased", "javafx.scene.input.KeyEvent.KEY_RELEASED")

	B4XPages.SetTitle(Me, MP.tableName)
	Dim leftSet As B4XSet
	leftSet.Initialize
	For j = 0 To addresses.Length - 1
		Dim colName As String = columnNames(j)
		If addresses(j).endsWith("*") Then 
			B4XTable1.AddColumn(colName, B4XTable1.COLUMN_TYPE_TEXT)
			addresses(j) = addresses(j).SubString2(0, addresses(j).Length - 1)
			leftSet.Add(j)
		Else
			B4XTable1.AddColumn(colName, B4XTable1.COLUMN_TYPE_NUMBERS)
		End If
	Next
	buildingTable = True
	TableData.Initialize
	For i = dataRows(0) To dataRows(1)
		Dim data(addresses.length) As Object
		For j = 0 To addresses.Length - 1
			data(j) = MP.getItem(i, addresses(j))
		Next
		TableData.Add(data)
	Next
	Wait For (B4XTable1.SetData(TableData)) Complete
	For k = 0 To B4XTable1.Columns.Size - 1
		Dim aCol As B4XTableColumn = B4XTable1.Columns.Get(k)
		Dim alignment As String = "RIGHT"
		If leftSet.Contains(k) Then alignment = "LEFT"
		For i = 1 To aCol.CellsLayouts.Size - 1
			Dim pnl As B4XView = aCol.CellsLayouts.Get(i)
			pnl.GetView(0).Tag = alignment
		Next
	Next
	buildingTable = False
End Sub

Private Sub B4XPage_Appear
	B4XTable1.CurrentPage = MP.currentTablePage
End Sub

Private Sub B4XTable1_DataUpdated
	If buildingTable Then Return
	For i = 0 To B4XTable1.VisibleRowIds.Size - 1
		Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)
		For j = 0 To B4XTable1.Columns.size - 1
			Dim row As String = (RowId + dataRows(0) - 1)
			Dim address As String = addresses(j) & "," & row
			Dim c As B4XTableColumn = B4XTable1.Columns.Get(j)
			Dim pnl As B4XView = c.CellsLayouts.Get(i + 1)
			If RowId > 0 Then
				Dim lbl As Label = pnl.GetView(0)
				Dim lt As String = lbl.Tag
				Dim xlbl As B4XView = lbl
				If lt.StartsWith("LEFT") Then
					xlbl.SetTextAlignment("CENTER", "LEFT")
					xlbl.Left = 20
				Else If lt.StartsWith("RIGHT") Then
					xlbl.SetTextAlignment("CENTER", "RIGHT")
					xlbl.Left = -20
				End If
				If MP.selection.Contains(address) Or MP.selection.Contains(addresses(j) & ",*") Or MP.selection.Contains("*," & row) Then 
					xlbl.Font = xui.CreateDefaultBoldFont(15)
					xlbl.TextColor = xui.Color_Blue
				Else
					xlbl.Font = xui.CreateDefaultFont(15)
					xlbl.TextColor = xui.Color_Black
				End If
			End If
		Next
	Next
End Sub

Private Sub undoSorts
	For Each aCol As B4XTableColumn In B4XTable1.Columns
		aCol.InternalSortMode = ""			
	Next
	buildingTable = True
	Wait For (B4XTable1.SetData(TableData)) Complete
	buildingTable = False
	B4XTable1.RefreshNow
	sorted = False
End Sub

Private Sub Label2_MouseClicked (EventData As MouseEvent)		'to next section
	If sorted Then undoSorts
	B4XTable1.SearchField.Text = ""
	Dim nextSection As Int = sectionNumber + 1
	If nextSection > MP.numSections - 1 Then nextSection = 0
	MP.currentTablePage = B4XTable1.CurrentPage
	B4XPages.ShowPage("section" & nextSection)
End Sub

Private Sub Label1_MouseClicked (EventData As MouseEvent)		'to previous section
	If sorted Then undoSorts
	B4XTable1.SearchField.Text = ""
	Dim nextSection As Int = sectionNumber - 1
	If nextSection < 0 Then nextSection = MP.numSections - 1
	MP.currentTablePage = B4XTable1.CurrentPage
	B4XPages.ShowPage("section" & nextSection)
End Sub

Private Sub B4XTable1_HeaderClicked (ColumnId As String)
	sorted = True
End Sub

Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	If ColumnId = "" Then Return
	For i = 0 To columnNames.Length - 1
		If columnNames(i) = ColumnId Then Exit
	Next
	Dim address As String = addresses(i)
	Dim row As Long = RowId + dataRows(0) - 1
	Dim refaddress As String = addresses(0)
	Dim value As Object = MP.getItem(row, address)
	Dim valueString As String = value
	If GetType(value).Contains("Double") Then valueString = NumberFormat(value, 1, 2)
	Dim fullAddress As String = address & "," & row
	Dim columnSpec As String = address & ",*"
	Dim rowSpec As String = "*," & row
	If ControlKey Then						'Column Selection by using "Ctrl" key
		If MP.selection.contains(columnSpec) Then
			MP.selection.Remove(columnSpec)
			B4XPages.SetTitle(Me, MP.tableName)
		Else 
			MP.selection.Add(columnSpec)
			B4XPages.SetTitle(Me, MP.tableName & ": " & ColumnId)
		End If
	Else If AltKey Then						'Row Selection by using "Alt" key
		If MP.selection.contains(rowSpec) Then
			MP.selection.Remove(rowSpec)
			B4XPages.SetTitle(Me, MP.tableName)
		Else 
			MP.selection.Add(rowSpec)
			B4XPages.SetTitle(Me, MP.tableName & ": Row " & RowId)
		End If
	Else
		If MP.selection.contains(fullAddress) Then
			MP.selection.Remove(fullAddress)
			B4XPages.SetTitle(Me, MP.tableName)
		Else 
			MP.selection.Add(fullAddress)
			B4XPages.SetTitle(Me, MP.tableName & ": " & ColumnId & " - " & MP.getItem(row, refaddress) & " [" & fullAddress & "] = " & valueString)
		End If
	End If
	MP.currentTablePage = B4XTable1.CurrentPage
	B4XPage_Appear
End Sub

Private Sub KeyPressed_Event (e As Event)
	Dim jo As JavaObject = e
	Dim keycode As String = jo.RunMethod("getCode", Null)
	If keycode = "CONTROL" Then 
		ControlKey = True
		AltKey = False				'having both Ctrl and Alt key active is not intuitive and not functional in this context
	Else If keycode = "ALT" Then 
		AltKey = True
		ControlKey = False
	End If							'other keypresses are handled by the Searchfield
End Sub

Private Sub KeyReleased_Event (e As Event)
	Dim jo As JavaObject = e
	Dim keycode As String = jo.RunMethod("getCode", Null)
	If keycode = "CONTROL" Then  
		ControlKey = False
	Else If keycode = "ALT" Then 
		AltKey = False
	End If
End Sub

Private Sub Tools_MouseClicked (EventData As MouseEvent)
	ToolList.Items.clear
	If MP.selection.Size > 0 Then 
		ToolList.Items.Add("Save Selected Items")
		ToolList.Items.Add("Unselect All Items")
	End If
	If MP.savedSelection.Size > 0 Then
		ToolList.Items.Add("Reselect Saved Items")
	End If
	ToolList.Items.AddAll(MP.toolKit)
	ToolList.Items.Add("_Cancel Tool Kit_")
	ToolList.Visible = True
End Sub

Private Sub ToolList_SelectedIndexChanged(Index As Int)
	If Index = -1 Then Return
	ToolList.Visible = False
	Select ToolList.Items.get(Index)
		Case "Unselect All Items"
			MP.selection.clear
			MP.currentTablePage = B4XTable1.CurrentPage
			B4XPage_Appear
		Case "Save Selected Items"
			MP.savedSelection.Clear
			For Each s As String In MP.selection.AsList
				MP.savedSelection.Add(s)
			Next
		Case "Reselect Saved Items"
			For Each s As String In MP.savedSelection
				If MP.selection.Contains(s) = False Then MP.selection.Add(s)
			Next
			MP.savedSelection.clear
			MP.currentTablePage = B4XTable1.CurrentPage
			B4XPage_Appear
		Case "_Cancel Tool Kit_"
		Case Else
			MP.handle_toolKit(Me, ToolList.Items.get(Index))
	End Select
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	B4XPages.ShowPageAndRemovePreviousPages("MainPage")
	Return False
End Sub

Private Sub exitBtn_MouseClicked(ev As MouseEvent)
	exitBtn.visible = False
	reportPanel.mBase.Visible = False
End Sub

Public Sub hideScroll
	Dim sp As ScrollPane = reportPanel.sv
	sp.SetVScrollVisibility("NEVER")
End Sub

Public Sub showScroll
	Dim sp As ScrollPane = reportPanel.sv
	sp.SetVScrollVisibility("ALWAYS")
End Sub