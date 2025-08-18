B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
'v1.04
Sub Class_Globals
	Public MODE_SINGLE_CELL_TEMP = 1, MODE_SINGLE_CELL_PERMANENT = 2, MODE_SINGLE_LINE_PERMANENT = 3 As Int
	Public MODE_MULTIPLE_CELLS = 4, MODE_MULTIPLE_LINES = 5 As Int
	Private LineMode, SingleMode As Boolean
	Private mCurrentMode As Int
	Public SelectedLines As B4XOrderedMap
	Public SelectionColor As Int
	Private mTable As B4XTable
	Private xui As XUI
	Public AutoRemoveInvisibleSelections As Boolean
	Public SelectedTextColor As Int = xui.Color_White
End Sub

Public Sub Initialize (Table As B4XTable)
	mTable = Table
	SelectionColor = mTable.SelectionColor
	SelectedLines.Initialize
	mCurrentMode = MODE_SINGLE_CELL_TEMP
End Sub

Public Sub CellClicked (ColumnId As String, RowId As Long)
	If mCurrentMode = MODE_SINGLE_CELL_TEMP Then Return
	Dim RemovedSelection As Boolean
	If SelectedLines.ContainsKey(RowId) Then
		If LineMode Then
			RemovedSelection = True
			SelectedLines.Remove(RowId)
		Else
			Dim SelectedCells As List = SelectedLines.Get(RowId)
			Dim i As Int = SelectedCells.IndexOf(ColumnId)
			If i > -1 Then
				RemovedSelection = True
				SelectedCells.RemoveAt(i)
				If SelectedCells.Size = 0 Then
					SelectedLines.Remove(RowId)
				End If
			End If
		End If
	End If
	If RemovedSelection = False Then
		If SingleMode Then SelectedLines.Clear
		If LineMode Then
			SelectedLines.Put(RowId, "")
		Else
			Dim SelectedCells As List
			If SelectedLines.ContainsKey(RowId) Then
				SelectedCells = SelectedLines.Get(RowId)
			Else
				Dim SelectedCells As List
				SelectedCells.Initialize
				SelectedLines.Put(RowId, SelectedCells)
			End If
			SelectedCells.Add(ColumnId)
		End If
	End If
	Refresh
End Sub

Public Sub Refresh
	For i = 0 To mTable.VisibleRowIds.Size - 1
		Dim clr As Int
		If i Mod 2 = 0 Then clr = mTable.EvenRowColor Else clr = mTable.OddRowColor
		Dim RowId As Long = mTable.VisibleRowIds.Get(i)
		Dim RowSelected As Boolean = SelectedLines.ContainsKey(RowId)
		If RowSelected And LineMode = False Then
			Dim SelectedCells As List = SelectedLines.Get(RowId)
		End If
		For Each col As B4XTableColumn In mTable.VisibleColumns
			Dim p As B4XView = col.CellsLayouts.Get(i + 1)
			Dim lbl As B4XView = p.GetView(col.LabelIndex)
			If RowSelected And (LineMode Or SelectedCells.IndexOf(col.Id) > -1) Then
				p.Color = SelectionColor
				lbl.TextColor = SelectedTextColor
			Else
				p.Color = clr
				lbl.TextColor = mTable.TextColor
			End If
		Next
	Next
	If AutoRemoveInvisibleSelections Then
		Dim RowsToRemove As List
		RowsToRemove.Initialize
		For Each RowId As Long In SelectedLines.Keys
			If mTable.VisibleRowIds.IndexOf(RowId) = -1 Then
				RowsToRemove.Add(RowId)
			End If
		Next
		For Each RowId As Long In RowsToRemove
			SelectedLines.Remove(RowId)
		Next
	End If
End Sub

Public Sub getMode As Int
	Return mCurrentMode
End Sub

Public Sub setMode (m As Int)
	mCurrentMode = m
	SelectedLines.Clear
	If mCurrentMode = MODE_SINGLE_CELL_TEMP Then
		mTable.SelectionColor = SelectionColor
		mTable.HighlightSearchResults = True
	Else
		mTable.SelectionColor = xui.Color_Transparent
		mTable.HighlightSearchResults = False
	End If
	Select mCurrentMode
		Case MODE_SINGLE_CELL_PERMANENT
			SingleMode = True
			LineMode = False
		Case MODE_SINGLE_LINE_PERMANENT
			SingleMode = True
			LineMode = True
		Case MODE_MULTIPLE_CELLS
			SingleMode = False
			LineMode = False
		Case MODE_MULTIPLE_LINES
			SingleMode = False
			LineMode = True
	End Select
	Refresh
End Sub

Public Sub Clear
	SelectedLines.Clear
	Refresh
End Sub

'Returns true if it least one item is selected.
Public Sub getIsSelected As Boolean
	Return SelectedLines.Size > 0
End Sub

'Gets the first selected row id.
Public Sub FirstSelectedRowId As Long
	If SelectedLines.Size > 0 Then 
		Return SelectedLines.Keys.Get(0)
	Else
		Return 0
	End If
End Sub

'Gets the first selected column id. Only relevant in MODE_SINGLE_CELL_PERMANENT and MODE_MULTIPLE_CELLS modes.
Public Sub FirstSelectedColumnId As String
	If SelectedLines.Size > 0 Then
		Dim l As List = SelectedLines.Values.Get(0)
		Return l.Get(0)
	Else
		Return ""
	End If
End Sub