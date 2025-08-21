B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Dim Frm As Form
	Dim xui As XUI
	
	'Table
	Private dbTable As B4XTable
	Private TableData As List                      	'List to add in the dbTable information
	Private RowIDList As List						'Stores the RowList IDs
	Private headers As List							'holds list of headers
	
	Private OldRow As Long							'Used for colour changes
	Private SelectionColor As Int = 0xFF009DFF		'Row colour on select
	Private lblDBName As Label						'DB Name label
	Private RowIDSelected As Long					'global long value for row selected
	Private ColIDSelected As String					'global stringvalue for name of column selected
	
	'Modification buttons
	Private btnAddRow As Button
	Private btnDelete As Button
	Private btnDuplicate As Button
	Private btnEsc As Button
			
	'Add Record edit panel
	Private etTextBox As TextField					'Cell text box
	Private pnlNormal As Pane						'For Nomal buttoms
	Private dialog As B4XDialog
	Private MouseX As Int							'Mouse Click location
	Private MouseY As Int
	
	'EditPanel
	Private pnlEdit As Pane
	Private btnAccept As Button
	Private btnCancel As Button
	Private editLabel(60) As Label					' Sames number as common Headers list (could be a list)
	Private editBox(60) As TextField
	Private pnlbtnEdit As Pane
	Private AddList As List							'Used for the add row list

	'Move Row buttons
	Private btnUp As Button
	Private btnDown As Button
End Sub


Public Sub Show
	If Frm.IsInitialized = False Then
		Frm.Initialize("frm", 1250, 800)
		Frm.RootPane.LoadLayout("DBPanel")
		dialog.Initialize(Frm.RootPane)
	End If
	pnlNormal.Visible=True
	etTextBox.Visible=False
	pnlEdit.Visible=False
	pnlbtnEdit.Visible=False
	headers.Initialize
	CreateDBTable
	LoadB4xTableData(Common.DBName,Common.TotColNumber)     'loads TableData from dbTable
	LoadData												'loads into b4X table
	dbTable.Refresh
	Common.FullScreen(Frm)
	Frm.show
End Sub

'=======================================================================
' TABLE creation
'=======================================================================
' Creates the table Uses the information from table headers to develope b4xTable
Sub CreateDBTable
'Log("CreateDBTable")
	dbTable.MaximumRowsPerPage=13	
	dbTable.NumberOfFrozenColumns=Common.FrozenCols
	dbTable.ArrowsEnabledColor=0xFFFFFFFF
	For i = 0 To Common.TotColNumber - 1
		dbTable.AddColumn(Common.ColNames(i), dbTable.COLUMN_TYPE_TEXT)
	Next
End Sub

'Load Tabledata list from SQL database table
Public Sub LoadB4xTableData(DBname As Object,TotColNo As Int)
'Log("Load B4x Table from  " & DBname)
	TableData.Initialize
	Dim rs As ResultSet
	Dim Query As String = "SELECT * FROM " & DBname
	rs = Common.SQL.ExecQuery(Query)
	Do While rs.NextRow
		Dim row(TotColNo) As Object
		For i = 0 To TotColNo-1
			row(i) = rs.GetString(Common.ColNames(i))
		Next
		TableData.Add(row)
	Loop
	rs.Close
End Sub

'Loads b4XTable from TableData list
Sub LoadData
'Log("Load DB Data")
	lblDBName.Text=Common.DBName
	dbTable.SetData(TableData)
	dbTable.Refresh
End Sub

'=======================================================================
'Reads the Record IDs into RowIDList
'=======================================================================
Sub StoreRecordIDs
'Log("---Store Row IDs---")
	RowIDList.Initialize										'initialize the rowID list
	Private rs As ResultSet
	rs = dbTable.sql1.ExecQuery("SELECT RowID FROM data")
	Do While rs.NextRow
		RowIDList.Add(rs.GetString2(0))								'add the rowid's to the rowID list
	Loop
	rs.Close															'close the ResultSet, we don't need it anymore
End Sub

'=======================================================================
' b4xTable Recovery to SQL table
'=======================================================================
'Save the B4XTable database back to SQL dbTable file
Sub SaveB4XTableData(DBName As Object)
'Log("Save B4x Table Data")
	Dim ExistingData As List
	ExistingData.Initialize
	'clears old data
	SQLUtil.DeleteDataSQLTable(Common.SQL,DBName)     ' deletes the old dbtable
    
	'loads table data to rowlist
	Dim o() As Object = dbTable.BuildQuery(False)
	Dim rs As ResultSet = dbTable.sql1.ExecQuery2(o(0),o(1))
	Do While rs.NextRow
		Dim RowList As List
		RowList.Initialize
		For i = 1 To Common.TotColNumber           ' Column numbers a 1 to ............
			Dim Cell As String = rs.GetString2(i)    ' returns string of cells in columns
			RowList.Add(Cell)                       ' adds to the rowlist
		Next
		ExistingData.Add(RowList)					' adds on rows
	Loop
	'Saves each row to DB
	For RowNo = 0 To ExistingData.Size-1
		Dim RowList As List = ExistingData.Get(RowNo)                ' Gets total row information
		SQLUtil.AddRowValues (Common.SQL,DBName, Common.TotColNumber, RowList)
	Next
End Sub

'=======================================================================
'ROW SELECTION AND COLOUR CHANGE
'=======================================================================
'Responds to any touch on screen
'Action= 0 = pressed  X and Y are locations
Sub frm_Touched (Action As Int, X As Float, Y As Float)
'	If Action = 0 Then
		MouseX=X
		If MouseX>Frm.Width-200dip Then
			MouseX=Frm.Width-220dip          ' Allows editbox to remain on screen
		End If
		MouseY=Y
'	End If
	Log(MouseX & "   "& MouseY) 
End Sub

'Changes the colour of the row selected
Sub DBTable_CellClicked (ColumnId As String, RowId As Long)
'Log("Cell Clicked")
	StoreRecordIDs
	RowIDSelected= RowId											' Assigns to global constant
	ColIDSelected= ColumnId
	RowChangeColourSelect
	etTextBox.Visible=True
	etTextBox.RequestFocus
	etTextBox.Left=MouseX
	etTextBox.Top=MouseY
	etTextBox.Text = GetCellData(RowIDSelected,ColIDSelected)
End Sub

'Decides colour change of the row, and deletes colour on previous selected row
Sub RowChangeColourSelect
	Dim Index As Int
	Index=dbTable.VisibleRowIds.IndexOf(RowIDSelected)
	Select True
		Case RowIDSelected = OldRow                                 'Same so remove
			SetRowColor(Index, False)
		Case RowIDSelected<>OldRow
			SetRowColor(Index, True)								'change colour
			Index=dbTable.VisibleRowIds.IndexOf(OldRow)             'remove the old colour
			SetRowColor(Index, False)
			OldRow=RowIDSelected
	End Select
End Sub

 'Sets the color of the row
Sub SetRowColor(RowIndex As Int, Selected As Boolean)
'Log("Set Row Colour")
	Dim clr As Int
	If Selected Then
		clr = SelectionColor
	Else If RowIndex Mod 2 = 0 Then
		clr = dbTable.EvenRowColor
	Else
		clr = dbTable.OddRowColor
	End If
	If RowIndex>-1 Then
		For Each c As B4XTableColumn In dbTable.VisibleColumns
			Dim pnl As B4XView = c.CellsLayouts.Get(RowIndex + 1) '+1 because of the header
			pnl.Color = clr
		Next
	End If
End Sub

'Clears row highlight colour on each page change
'Index =-1 on page change
Sub DBTable_DataUpdated
	Dim clr As Int
	Dim Index As Int
	Index=dbTable.VisibleRowIds.IndexOf(RowIDSelected)
	If Index =-1 Then
		For i = 0 To dbTable.VisibleRowIds.Size-1
			If i Mod 2 = 0 Then
				clr = dbTable.EvenRowColor
			Else
				clr = dbTable.OddRowColor
			End If
			For Each c As B4XTableColumn In dbTable.VisibleColumns
				Dim pnl As B4XView = c.CellsLayouts.Get(i + 1) '+1 because of the header
				pnl.Color = clr
			Next
		Next
		OldRow=1
	End If
End Sub

'=======================================================================
'DATA Modification
'=======================================================================
'Modifies the total record of a particular rowID for the row move
'NewList must have the same number of items as TotColNumber
Sub RecordChangeRowID(RowID As Long, NewList As List)
'Log("Change record at  " & RowID)	
	Dim Query As String = "UPDATE data SET "
	Dim column As B4XTableColumn
	For i = 0 To Common.TotColNumber-2
		column = dbTable.GetColumn(Common.ColNames(i))
		Query = Query & column.SQLID & " = ?, "
	Next
	column  = dbTable.GetColumn(Common.ColNames(Common.TotColNumber-1))
	Query = Query & column.SQLID & $" = ? WHERE ROWID = ${RowID}"$
	dbTable.sql1.ExecNonQuery2(Query,NewList)
	dbTable.refresh
	StoreRecordIDs
End Sub

'ADDS a record to the bottom of the dbTable
'Used for AddRow, moves the display to the last page
Sub AddRecord(NewList As List)
'Log("Add Record Data from Add Panel")
	Dim Query As String = "INSERT INTO data VALUES ("
	For i = 1 To Common.TotColNumber-1
		Query = Query & "?,"
	Next
	Query = Query & "?)"
	dbTable.sql1.ExecNonQuery2(Query ,NewList)
	dbTable.refresh
	dbTable.ClearDataView
	dbTable.CurrentPage = Ceil(dbTable.mCurrentCount / dbTable.VisibleRowIds.Size)   ' Goes to last page
	StoreRecordIDs
End Sub

'DELETE the selected Record
Public Sub DeleteRecord(RowIdNo As Int)
'Log("Delete Selected Row")
	Private Question As String = "Do you really want to delete? "
	Dim sf As Object = xui.Msgbox2Async(Question, "Delete Row", "Yes", "", "No",Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_POSITIVE Then
		RowChangeColourSelect
		Dim x As Int = dbTable.CurrentPage
		dbTable.sql1.ExecNonQuery2("DELETE FROM data WHERE rowid = ?", Array As String(RowIdNo))
		dbTable.ClearDataView
		dbTable.CurrentPage=x
	End If
	dbTable.Refresh
	StoreRecordIDs
End Sub

'DUPLICATE the selected record. moves display to the last page
Sub DuplicateRecord
'Log("Duplicate Selected")
	Private Question As String
	Question = "Do you really want to duplicate this selection? "
	Dim sf As Object = xui.Msgbox2Async(Question, "Duplicate Row", "Yes", "", "No",Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_POSITIVE Then
		RowChangeColourSelect
		Dim RowData As Map = dbTable.GetRow(RowIDSelected)		' Gets the Row
		AddList.Initialize
		For i = 0 To Common.TotColNumber-1
			AddList.add(RowData.GetValueAt(i))
		Next
		AddRecord(AddList)
		dbTable.CurrentPage = Ceil(dbTable.mCurrentCount / dbTable.VisibleRowIds.Size)   ' Goes to last page
	End If
	StoreRecordIDs
End Sub

'ADD a value to a cell at the record and column selected
Sub AddCellData (Value As String, RowNo As Int, ColName As String)
'Log("Add Cell Data")
	Dim column As B4XTableColumn = dbTable.GetColumn(ColName)
	dbTable.sql1.ExecNonQuery2($"UPDATE data SET ${column.SQLID} = ? WHERE rowid = ?"$, Array As String(Value, RowNo))
	Dim x As Int = dbTable.CurrentPage
	dbTable.ClearDataView								 'Updates the rows count.
	dbTable.CurrentPage=x								 'Stays at same page
End Sub


'Gets CELL data for display on the edit text box
Sub GetCellData(RowNo As Int, ColString As String) As String
'Log("Get Cell Value")
	Dim RowData As Map = dbTable.GetRow(RowNo)
	Dim Cell As String = RowData.Get(ColString)
	Return Cell
End Sub

'=======================================================================
'BUTTONS - Modification
'=======================================================================
'Brings on the edit panel
Sub btnAddRow_Click
	pnlEdit.Visible=True
	pnlNormal.Visible=False
	pnlbtnEdit.Visible=True
	etTextBox.Visible=False
	EditPanelInit
End Sub

'Deletes a selected Row
Sub btnDelete_Click
	etTextBox.Visible=False
	DeleteRecord(RowIDSelected)
End Sub

'Dublicates a selected Row
Sub btnDuplicate_Click
	etTextBox.Visible=False
	DuplicateRecord
End Sub

'=======================================================================
' Escape/Save button
'=======================================================================
' Updates the records of the dbTable selected from the DBTable info
' Closes the activity so a return creates a clean DB table
Sub btnEsc_Click
	SaveB4XTableData(Common.DBName)  ' Saves b4xTable back to the DB
	dbTable.Clear
	Frm.close
	Selection.show
End Sub


'=======================================================================
'Cell Edit Text Box
'=======================================================================
'Operates whenever a cell is clicked
Sub etTextBox_Action
	'Log("EditBox Enter Pressed")
	AddCellData(etTextBox.Text,RowIDSelected,ColIDSelected)
	etTextBox.Text = ""
	Sleep(200)
	etTextBox.Visible=False
End Sub


'=======================================================================
' EDIT PANEL
'=======================================================================
'Adjusts the row and columns of the edit labels and the edit box on the EditPanel 
'depending on the total number of columns in the dbTable
Sub EditPanelInit
	'Log("InitEditPanel")
	Private EditHeight = 30dip As Int
	Private EditWidth = 110dip As Int
	Private EditTop As Int
	Private EditLeft As Int
	pnlEdit.RemoveAllNodes

	For Col = 0 To Common.TotColNumber - 1
		' set up the column labels
		editLabel(Col).Initialize("")
		editLabel(Col).TextSize = 15
		editLabel(Col).Text = Common.ColNames(Col)
		
		'Set up the edittext boxes
		editBox(Col).Initialize("edtEdit")
		editBox(Col).Tag = Col														' Stores the item number
		editBox(Col).Text=""
	
		Select True
			Case Col<=9
				EditLeft=(Col+1)*(EditWidth + 5dip)
				EditTop = 20dip
			Case Col>9 And Col<=19
				EditLeft=(Col-9)*(EditWidth + 5dip)
				EditTop = 2*EditHeight+20dip
			Case Col>19 And Col<=29
				EditLeft=(Col-19)*(EditWidth + 5dip)
				EditTop = 4*EditHeight+20dip
			Case Col>29 And Col<=39
				EditLeft=(Col-29)*(EditWidth + 5dip)
				EditTop = 6*EditHeight+20dip			
			Case Col>39 And Col<=49
				EditLeft=(Col-39)*(EditWidth + 5dip)
				EditTop = 8*EditHeight+20dip
			Case Col>49 And Col<=59
				EditLeft=(Col-49)*(EditWidth + 5dip)
				EditTop = 10*EditHeight+20dip				
		End Select
		pnlEdit.Addnode(editLabel(Col), EditLeft, EditTop, EditWidth, EditHeight)
		pnlEdit.Addnode(editBox(Col), EditLeft, EditTop+EditHeight+5dip, EditWidth, EditHeight)	
	Next
End Sub

' Accepts the add row values and adds to the table
Sub btnAccept_Click	
		AddList.Initialize
		For i = 0 To Common.TotColNumber-1              'Optains
			AddList.Add(editBox(i).text)
		Next
		AddRecord(AddList)
		pnlEdit.Visible=False
		pnlbtnEdit.Visible=False
		pnlNormal.Visible=True
		etTextBox.Visible=False	
		RowChangeColourSelect
End Sub

'Cancels the add row values
Sub btnCancel_Click
	pnlEdit.Visible=False
	pnlbtnEdit.Visible=False
	pnlNormal.Visible=True
	etTextBox.Visible=False
	RowChangeColourSelect
End Sub

'=======================================================================
' Move Buttons
'=======================================================================
' Returns the index of the RowID in the RowIDlist
Sub RowIDIndex(RowID As Long) As Long
   For i=0 To RowIDList.Size-1
   		If RowID = RowIDList.Get(i) Then
			Return i
		End If
	Next
	Return -1
End Sub

' Moves the selected row up, Converts Map to List for RowChange
Sub btnUp_Click
	etTextBox.Visible=False
	If RowIDIndex(RowIDSelected)>0 Then
		' Select data and convert to list
		Dim SelectedData As Map = dbTable.GetRow(RowIDSelected)								' Selected row
		Dim SelectedList As List
		SelectedList.Initialize
		For Each Key As String In SelectedData.Keys
			SelectedList.Add(SelectedData.Get(Key))
		Next
		' Select data and convert to list
		Dim ToData As Map = dbTable.GetRow(RowIDList.get(RowIDIndex(RowIDSelected)-1))    ' Row above selected
		Dim ToList As List
		ToList.Initialize
		For Each Key As String In ToData.Keys
			ToList.Add(ToData.Get(Key))
		Next
		
		RecordChangeRowID(RowIDList.get(RowIDIndex(RowIDSelected)-1), SelectedList)
		RecordChangeRowID(RowIDSelected,ToList)
	
		RowIDSelected = RowIDList.get(RowIDIndex(RowIDSelected)-1)   'moves row up
		RowChangeColourSelect   ' change colour on new row
		dbTable.Refresh
	End If
End Sub

' Moves the row selected down.  Converts Map to List for RowChange
Sub btnDown_Click
	etTextBox.Visible=False
	If RowIDIndex(RowIDSelected)<dbTable.mCurrentCount-1 Then
		Dim SelectedData As Map = dbTable.GetRow(RowIDSelected)								' Selected row
		Dim SelectedList As List
		SelectedList.Initialize
		For Each Key As String In SelectedData.Keys
			SelectedList.Add(SelectedData.Get(Key))
		Next
		
		Dim ToData As Map = dbTable.GetRow(RowIDList.get(RowIDIndex(RowIDSelected)+1))  'Row below selected
		Dim ToList As List
		ToList.Initialize
		For Each Key As String In ToData.Keys
			ToList.Add(ToData.Get(Key))
		Next
		
		RecordChangeRowID(RowIDList.get(RowIDIndex(RowIDSelected)+1), SelectedList)
		RecordChangeRowID(RowIDSelected,ToList)

		RowIDSelected = RowIDList.get(RowIDIndex(RowIDSelected)+1)     ' moves selected row down
		RowChangeColourSelect
		dbTable.Refresh
	End If
End Sub

