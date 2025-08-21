B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
'Version 1.00
#Event: GetUpdatedValue (FC As FocusedCell) As Object
#Event: EnterEditMode (FC As FocusedCell) 
Sub Class_Globals
	Type FocusedCell (ColumnId As String, RowId As Long, View As B4XView, VisibleIndex As Int, PrevValue As Object, Tag As Object)
	Public CurrentlyFocusedCell As FocusedCell
	Private mTable As B4XTable
	Private mCallback As Object
	Private mEventName As String
End Sub

Public Sub Initialize (Table As B4XTable, Callback As Object, EventName As String)
	mTable = Table
	mCallback = Callback
	mEventName = EventName
End Sub

'Returns true if the table is in editing state.
Public Sub getIsInEditingState As Boolean
	Return CurrentlyFocusedCell.RowId > 0
End Sub

Private Sub IsEditingViewInCorrectPosition As Boolean
	Return CurrentlyFocusedCell.VisibleIndex = mTable.VisibleRowIds.IndexOf(CurrentlyFocusedCell.RowId)
End Sub

'Should be called from DataUpdated event.
Public Sub DataUpdated
	If getIsInEditingState And IsEditingViewInCorrectPosition = False Then
		ExitEditMode
	End If
End Sub

'Should be called when the table is resized.
Public Sub TableResized
	If getIsInEditingState Then SetEditableControlLayout(CurrentlyFocusedCell)
End Sub

'Should be called when an editable cell is clicked.
Public Sub CellClicked (ColumnId As String, RowId As Long)
	MakeCellEditable(ColumnId, RowId)
End Sub

Private Sub MakeCellEditable (ColumnId As String, RowId As Long)
	If getIsInEditingState And CurrentlyFocusedCell.ColumnId = ColumnId And CurrentlyFocusedCell.RowId = RowId Then Return
	If getIsInEditingState Then
		ExitEditMode
	End If
	CurrentlyFocusedCell = CreateFocusedCell(ColumnId, RowId, Null)
	CurrentlyFocusedCell.PrevValue = mTable.GetRow(RowId).Get(ColumnId)
	CallSub2(mCallback, mEventName & "_EnterEditMode", CurrentlyFocusedCell)
	SetEditableControlLayout(CurrentlyFocusedCell)
End Sub

Private Sub SetEditableControlLayout (SelectedControl As FocusedCell)
	Dim c As B4XTableColumn = mTable.GetColumn(SelectedControl.ColumnId)
	CurrentlyFocusedCell.VisibleIndex = mTable.VisibleRowIds.IndexOf(SelectedControl.RowId)
	Dim p As B4XView = c.CellsLayouts.Get(CurrentlyFocusedCell.VisibleIndex + 1) '+1 because of the header
	If SelectedControl.View.Parent <> p Then
		If p.GetView(p.NumberOfViews - 1).Tag = "TextFlow" Then
			p.GetView(p.NumberOfViews - 1).RemoveViewFromParent 'remove the special TextFlow control that is added to highlight search result
		End If
		p.AddView(SelectedControl.View, 0, 0, p.Width, p.Height)
		p.GetView(c.LabelIndex).Visible = False
		SelectedControl.View.BringToFront
		CurrentlyFocusedCell.View.RequestFocus
	Else
		SelectedControl.View.SetLayoutAnimated(0, 0, 0, p.Width, p.Height)
	End If
End Sub

'Exits edit mode
Public Sub ExitEditMode
	If getIsInEditingState = False Then Return
	Dim c As B4XTableColumn = mTable.GetColumn(CurrentlyFocusedCell.ColumnId)
	Dim Value As Object = CallSub2(mCallback, mEventName & "_GetUpdatedValue", CurrentlyFocusedCell)
	Dim parent As B4XView = CurrentlyFocusedCell.View.Parent
	mTable.sql1.ExecNonQuery2($"UPDATE data SET ${c.SQLID} = ? WHERE rowid = ?"$, Array(Value, CurrentlyFocusedCell.RowId))
	CurrentlyFocusedCell.RowId = 0
	mTable.RefreshNow
	parent.GetView(c.LabelIndex).Visible = True
	CurrentlyFocusedCell.View.RemoveViewFromParent
End Sub

Private Sub CreateFocusedCell (ColumnId As String, RowId As Long, View As B4XView) As FocusedCell
	Dim t1 As FocusedCell
	t1.Initialize
	t1.ColumnId = ColumnId
	t1.RowId = RowId
	t1.View = View
	Return t1
End Sub
