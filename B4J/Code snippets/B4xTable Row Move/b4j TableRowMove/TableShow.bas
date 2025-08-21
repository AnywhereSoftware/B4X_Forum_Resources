B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'TableShow is generalised table for any sized database


Sub Process_Globals
	Private fx As JFX
	Dim Frm As Form
	
	'Table
	Public dbTable As B4XTable
	Public TableData As List
	Public RowIDList As List
	
	Private headers As List							' holds list of headers on csv file
	'Colours
	Private OldRow As Long
	Private SelectionColor As Int = 0xFF009DFF

	'Row Selection
	Private RowIDSelected As Long				'global long value for row selected
	
	Private dialog As B4XDialog	
	Private btnUp As Button
	Private btnDown As Button
End Sub


Public Sub Show
	If Frm.IsInitialized = False Then
		Frm.Initialize("frm", 1250, 800)
		Frm.RootPane.LoadLayout("DBPanel")
		dialog.Initialize(Frm.RootPane)
	End If
	headers.Initialize
	CreateDBTable
	LoadB4xTableData(Common.DBName,Common.TotColNumber) 'load table from db selected
	LoadData											' load B4xTable
	dbTable.Refresh
	Common.FullScreen(Frm)
	Frm.show
End Sub



'===========================================================================
' TABLE creation
'==============================================================================
' Creates the table
Sub CreateDBTable
'Log("CreateDBTable")
	dbTable.MaximumRowsPerPage=13	
	dbTable.NumberOfFrozenColumns=Common.FrozenCols
	dbTable.ArrowsEnabledColor=0xFFFFFFFF
	For i = 0 To Common.TotColNumber - 1
		dbTable.AddColumn(Common.ColNames(i), dbTable.COLUMN_TYPE_TEXT)
	Next
End Sub

'Load Tabledata list from SQL database
Public Sub LoadB4xTableData(DBname As Object,TotColNo As Int)
Log("Load B4x Table from  " & DBname)
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

' Loads dbTable from TableData list
Sub LoadData
'Log("Load DB Data")
	dbTable.SetData(TableData)
	dbTable.Refresh
End Sub

'Clears row colours on each page change
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

'Reads the Record IDs into RowIDList
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


'====================================================================================
'ROW SELECTION AND COLOUR CHANGE
'=====================================================================================
'Changes the colour of the row
Sub DBTable_CellClicked (ColumnId As String, RowId As Long)
'Log("Cell Clicked")
	StoreRecordIDs
	RowIDSelected= RowId											' Assigns to global constant
	RowChangeColourSelect
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

'=================================================================================
'DATA Modification
'===================================================================================

'Modifies the total record of a particular rowID
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


'============================================================================
' Move Buttons
'=============================================================================
' Returns the index of the RowID in the RowIDlist
Sub RowIDIndex(RowID As Long) As Long
   For i=0 To RowIDList.Size-1
   		If RowID = RowIDList.Get(i) Then
			Return i
		End If
	Next
	Return -1
End Sub

'finds the RowID of the rowIndex selected in RowIDList
Sub FindRowId(RowIndex As Long) As Long
	Return RowIDList.get (RowIndex)
End Sub


' Moves the selected row up, Converts Map to List for RowChange
Sub btnUp_Click
	If RowIDIndex(RowIDSelected)>0 Then
		' Select data and convert to list
		Dim SelectedData As Map= dbTable.GetRow(RowIDSelected)				' Selected row
		Dim SelectedList As List
		SelectedList.Initialize
		For Each Key As String In SelectedData.Keys
			SelectedList.Add(SelectedData.Get(Key))
		Next
		' Select data and convert to list
		Dim ToData As Map= dbTable.GetRow(FindRowId(RowIDIndex(RowIDSelected)-1))    ' Row above selected
		Dim ToList As List
		ToList.Initialize
		For Each Key As String In ToData.Keys
			ToList.Add(ToData.Get(Key))
		Next
		
		RecordChangeRowID(FindRowId(RowIDIndex(RowIDSelected)-1), SelectedList)
		RecordChangeRowID(RowIDSelected,ToList)
	
		RowIDSelected = FindRowId(RowIDIndex(RowIDSelected)-1)   'moves row up
		RowChangeColourSelect   ' change colour on new row
		dbTable.Refresh
	End If
End Sub


' Moves the row selected down.  Converts Map to List for RowChange
Sub btnDown_Click
	If RowIDIndex(RowIDSelected)<dbTable.mCurrentCount-1 Then
		Dim SelectedData As Map = dbTable.GetRow(RowIDSelected)								' Selected row
		Dim SelectedList As List
		SelectedList.Initialize
		For Each Key As String In SelectedData.Keys
			SelectedList.Add(SelectedData.Get(Key))
		Next
		
		Dim ToData As Map = dbTable.GetRow(FindRowId(RowIDIndex(RowIDSelected)+1))  'Row below selected
		Dim ToList As List
		ToList.Initialize
		For Each Key As String In ToData.Keys
			ToList.Add(ToData.Get(Key))
		Next
		
		RecordChangeRowID(FindRowId(RowIDIndex(RowIDSelected)+1), SelectedList)
		RecordChangeRowID(RowIDSelected,ToList)

		RowIDSelected = FindRowId(RowIDIndex(RowIDSelected)+1)     ' moves selected row down
		RowChangeColourSelect
		dbTable.Refresh
	End If
End Sub

