B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' Class Module: ExcelRow
Sub Class_Globals
#If B4A Or B4J
	Private nativeRow As JavaObject
#End If
	Private managerRef As ExcelManager
	Private sheetRef As ExcelSheet
End Sub

' Initializes the ExcelRow instance.
Public Sub Initialize (Manager As ExcelManager, Sheet As ExcelSheet, Row As Object)
	managerRef = Manager
	sheetRef = Sheet
#If B4A Or B4J
	nativeRow = Row
#End If
End Sub

' Retrieves the ExcelCell instance at the specified column index, creating it if it doesn't exist.
' <code>Dim cell As ExcelCell = row.GetCell(0)</code>
Public Sub GetCell(Index As Int) As ExcelCell
	Dim c As ExcelCell
#If B4A Or B4J
	Dim joCell As JavaObject = nativeRow.RunMethod("getCell", Array(Index))
	If joCell.IsInitialized = False Then
		joCell = nativeRow.RunMethod("createCell", Array(Index))
	End If
	c.Initialize(managerRef, sheetRef, joCell)
#End If
	Return c
End Sub

' Applies background color to only existing data cells in the row.
' <code>row.PaintOnlyDataCells(excel.PASTEL_BLUE)</code>
Public Sub PaintOnlyDataCells(ColorIndex As Short)
#If B4A Or B4J
	Dim lastCell As Int = nativeRow.RunMethod("getLastCellNum", Null)
	If lastCell <= 0 Then Return
	
	For i = 0 To lastCell - 1
		Dim cellObj As ExcelCell = GetCell(i)
		cellObj.SetBackgroundColor(ColorIndex)
	Next
#End If
End Sub

' Sets the row height in points.
' <code>row.setHeightPoints(25)</code>
Public Sub setHeightPoints(Points As Float)
#If B4A Or B4J
	nativeRow.RunMethod("setHeightInPoints", Array(Points))
#End If
End Sub

' Retrieves the row height in points.
' <code>Dim h As Float = row.getHeightPoints</code>
Public Sub getHeightPoints As Float
#If B4A Or B4J
	Return nativeRow.RunMethod("getHeightInPoints", Null)
#Else
	Return 0.0
#End If
End Sub

' Returns the number of physical cells defined in this row.
' <code>Dim count As Int = row.getCellCount</code>
Public Sub getCellCount As Int
#If B4A Or B4J
	Return nativeRow.RunMethod("getPhysicalNumberOfCells", Null)
#Else
	Return 0
#End If
End Sub

' Returns the 0-based row index.
' <code>Dim index As Int = row.getRowIndex</code>
Public Sub getRowIndex As Int
#If B4A Or B4J
	Return nativeRow.RunMethod("getRowNum", Null)
#Else
	Return -1
#End If
End Sub

' Removes all cells from the row.
' <code>row.clear</code>
Public Sub clear
#If B4A Or B4J
	Dim lastCell As Int = nativeRow.RunMethod("getLastCellNum", Null)
	If lastCell <= 0 Then Return
    
	For i = 0 To lastCell - 1
		Dim cell As JavaObject = nativeRow.RunMethod("getCell", Array(i))
		If cell.IsInitialized Then
			nativeRow.RunMethod("removeCell", Array(cell))
		End If
	Next
#End If
End Sub

' Creates a cell with a specific structural type (0=NUMERIC, 1=STRING, etc.).
' <code>
'   Dim cell As ExcelCell = row.CreateCellTyped(0, excel.TYPE_NUMERIC)
' </code>
Public Sub CreateCellTyped(ColIdx As Int, CellType As Int) As ExcelCell
	Dim cellObj As ExcelCell
#If B4A Or B4J
	Dim c As JavaObject = nativeRow.RunMethod("createCell", Array(ColIdx, CellType))
	cellObj.Initialize(managerRef, sheetRef, c)
#End If
	Return cellObj
End Sub

' Removes a cell at the specified column index.
' <code>row.RemoveCellAt(0)</code>
Public Sub RemoveCellAt(ColIdx As Int)
#If B4A Or B4J
	Dim cell As JavaObject = nativeRow.RunMethod("getCell", Array(ColIdx))
	If cell.IsInitialized Then
		nativeRow.RunMethod("removeCell", Array(cell))
	End If
#End If
End Sub

' Returns True if the row has custom formatting styles.
Public Sub isFormatted As Boolean
#If B4A Or B4J
	Return nativeRow.RunMethod("isFormatted", Null)
#Else
	Return False
#End If
End Sub

Public Sub toString As String
#If B4A Or B4J
	Return nativeRow.RunMethod("toString", Null)
#Else
	Return ""
#End If
End Sub

' Sets multiple cell values in this row sequentially.
' <code>row.SetValues(Array("John Doe", 34, 45000))</code>
Public Sub SetValues(Values() As Object)
	For i = 0 To Values.Length - 1
		Try
			Dim cell As ExcelCell = GetCell(i)
			cell.setValue(Values(i))
		Catch
			Log("❌ Error writing row value at index: " & i)
			Log("Value: " & Values(i))
			Log("Type: " & GetType(Values(i)))
			Log(LastException)
		End Try
	Next
End Sub

' Sets bold formatting for all cells in the row.
' <code>row.SetBoldRow(True)</code>
Public Sub SetBoldRow(Enabled As Boolean)
#If B4A Or B4J
	Dim lastCell As Int = nativeRow.RunMethod("getLastCellNum", Null)
	If lastCell <= 0 Then Return
    
	For i = 0 To lastCell - 1
		GetCell(i).setBold(Enabled)
	Next
#End If
End Sub
