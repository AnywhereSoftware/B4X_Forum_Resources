B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' Class Module: ExcelRow
Sub Class_Globals
	Private nativeRow As JavaObject
	Private managerRef As ExcelManager
	Private sheetRef As ExcelSheet

End Sub

Public Sub Initialize (Manager As ExcelManager, Sheet As ExcelSheet, Row As JavaObject)
	managerRef = Manager
	sheetRef = Sheet
	nativeRow = Row
End Sub



' In your ExcelRow class, make sure to handle non-existent cells
Public Sub GetCell(Index As Int) As ExcelCell
	Dim joCell As JavaObject = nativeRow.RunMethod("getCell", Array(Index))
	Dim c As ExcelCell
    
	If joCell.IsInitialized = False Then
		' If the cell doesn't exist physically, we create it or return an empty one
		joCell = nativeRow.RunMethod("createCell", Array(Index))
	End If
    
	c.Initialize(managerRef, Null, joCell)
	Return c
End Sub


' <code>row.PaintOnlyDataCells(cell.PASTEL_SKY_BLUE)</code>
Public Sub PaintOnlyDataCells(ColorIndex As Short)
	' getLastCellNum returns the number of cells created in the row
	Dim lastCell As Int = nativeRow.RunMethod("getLastCellNum", Null)
	If lastCell <= 0 Then Return
	
	' Loop only up to the last written cell
	For i = 0 To lastCell - 1
		Dim cellObj As ExcelCell = GetCell(i) ' Use the row's own GetCell method
		cellObj.SetBackgroundColor(ColorIndex)
	Next
End Sub


Public Sub setHeightPoints(Points As Float)
	nativeRow.RunMethod("setHeightInPoints", Array(Points))
End Sub

Public Sub getHeightPoints As Float
	Return nativeRow.RunMethod("getHeightInPoints", Null)
End Sub

Public Sub getCellCount As Int
	Return nativeRow.RunMethod("getPhysicalNumberOfCells", Null)
End Sub


Public Sub getRowIndex As Int
	Return nativeRow.RunMethod("getRowNum", Null)
End Sub

Public Sub clear
	Dim lastCell As Int = nativeRow.RunMethod("getLastCellNum", Null)
	If lastCell <= 0 Then Return
    
	For i = 0 To lastCell - 1
		Dim cell As JavaObject = nativeRow.RunMethod("getCell", Array(i))
		If cell.IsInitialized Then
			nativeRow.RunMethod("removeCell", Array(cell))
		End If
	Next
End Sub

Public Sub CreateCellTyped(ColIdx As Int, CellType As Int) As ExcelCell
	Dim c As JavaObject = nativeRow.RunMethod("createCell", Array(ColIdx, CellType))
    
	Dim cellObj As ExcelCell
	cellObj.Initialize(managerRef, sheetRef, c)
    
	Return cellObj
End Sub

Public Sub RemoveCellAt(ColIdx As Int)
	Dim cell As JavaObject = nativeRow.RunMethod("getCell", Array(ColIdx))
	If cell.IsInitialized Then
		nativeRow.RunMethod("removeCell", Array(cell))
	End If
End Sub

Public Sub isFormatted As Boolean
	Return nativeRow.RunMethod("isFormatted", Null)
End Sub

Public Sub toString As String
	Return nativeRow.RunMethod("toString", Null)
End Sub

'<code>row.SetValues(Array("John", 25, 1500))</code>
Public Sub SetValues(Values() As Object)
	For i = 0 To Values.Length - 1
		Try
			Dim cell As ExcelCell = GetCell(i)
			cell.setValue(Values(i))
		Catch
			Log("❌ Error in column: " & i)
			Log("Value: " & Values(i))
			Log("Type: " & GetType(Values(i)))
			Log(LastException)
		End Try
	Next
End Sub

Public Sub SetBoldRow(Enabled As Boolean)
	Dim lastCell As Int = nativeRow.RunMethod("getLastCellNum", Null)
	If lastCell <= 0 Then Return
    
	For i = 0 To lastCell - 1
		GetCell(i).setBold(Enabled)
	Next
End Sub


