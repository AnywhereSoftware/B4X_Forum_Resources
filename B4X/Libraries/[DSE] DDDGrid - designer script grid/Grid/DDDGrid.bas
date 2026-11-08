B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private GridsData As Map
End Sub

Public Sub Initialize
	GridsData.Initialize
End Sub

'Parameters: Panel, #Columns, #Rows, Padding
Private Sub CreateGrid (DesignerArgs As DesignerArgs)
	Dim parent As B4XView = DesignerArgs.GetViewFromArgs(0)
	Dim NumberOfColumns As Int = DesignerArgs.Arguments.Get(1)
	Dim NumberOfRows As Int = DesignerArgs.Arguments.Get(2)
	Dim Padding As Int = DesignerArgs.Arguments.Get(3)
	Dim CellWidth As Int = (parent.Width - Padding * NumberOfColumns) / NumberOfColumns
	Dim CellHeight As Int = (parent.Height - Padding * NumberOfRows) / NumberOfRows
	If DesignerArgs.FirstRun Then
		GridsData.Put(parent, Array(NumberOfRows, NumberOfColumns))
		For y = 0 To NumberOfRows - 1
			For x = 0 To NumberOfColumns - 1
				Dim pnl As B4XView = xui.CreatePanel("")
				parent.AddView(pnl, 0.5 * Padding + (CellWidth + Padding) * x, 0.5 * Padding + (CellHeight + Padding) * y, CellWidth, CellHeight)
			Next
		Next
	Else
		For y = 0 To NumberOfRows - 1
			For x = 0 To NumberOfColumns - 1
				Dim pnl As B4XView = GetCell(parent, x, y)
				pnl.SetLayoutAnimated(0, 0.5 * Padding + (CellWidth + Padding) * x, 0.5 * Padding + (CellHeight + Padding) * y, CellWidth, CellHeight)
			Next
		Next
	End If
End Sub

Public Sub GetCell(Parent As B4XView, Column As Int, Row As Int) As B4XView
	Dim RowsColumns() As Object = GridsData.Get(Parent)
	Return Parent.GetView(Row * RowsColumns(1) + Column)
End Sub