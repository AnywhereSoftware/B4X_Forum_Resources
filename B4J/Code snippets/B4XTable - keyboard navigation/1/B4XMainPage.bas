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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private B4XTable1 As B4XTable
	Private XSelections As B4XTableSelections
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XTable1.AddColumn("Col 1", B4XTable1.COLUMN_TYPE_NUMBERS)
	B4XTable1.AddColumn("Col 2", B4XTable1.COLUMN_TYPE_NUMBERS)
	B4XTable1.AddColumn("Col 3", B4XTable1.COLUMN_TYPE_NUMBERS)
	B4XTable1.AddColumn("Col 4", B4XTable1.COLUMN_TYPE_NUMBERS)
	Dim data As List
	data.Initialize
	For i = 1 To 1000
		data.Add(Array(i, i + 1, i + 2, i + 3))
	Next
	B4XTable1.SetData(data)
	XSelections.Initialize(B4XTable1)
	XSelections.Mode = XSelections.MODE_SINGLE_CELL_PERMANENT
	AddKeyPressedListener
End Sub

Sub AddKeyPressedListener
	Dim r As Reflector
	r.Target = Root
	r.AddEventFilter("keypressed", "javafx.scene.input.KeyEvent.ANY")
End Sub

Sub KeyPressed_Filter (e As Event)
	Dim table As B4XTable = B4XTable1
	If IsTableFocused(table) And XSelections.FirstSelectedColumnId <> "" And XSelections.FirstSelectedRowId > 0 Then
		Dim jo As JavaObject = e
		Dim EventType As String = jo.RunMethodJO("getEventType", Null).RunMethod("getName", Null)
		If EventType = "KEY_PRESSED" Then
			Dim keycode As String = jo.RunMethod("getCode", Null)
			Dim col As String = XSelections.FirstSelectedColumnId
			Dim row As Long = XSelections.FirstSelectedRowId
			
			Dim ColSize As Int = table.VisibleColumns.Size
			Dim RowSize As Int = table.VisibleRowIds.Size
			Select keycode
				Case "RIGHT"
					col = table.VisibleColumns.Get((table.VisibleColumns.IndexOf(table.GetColumn(col)) + 1) Mod ColSize).As(B4XTableColumn).Id
				Case "LEFT"
					col = table.VisibleColumns.Get((table.VisibleColumns.IndexOf(table.GetColumn(col)) - 1 + ColSize) Mod ColSize).As(B4XTableColumn).Id
				Case "UP"
					row = table.VisibleRowIds.Get((table.VisibleRowIds.IndexOf(row) - 1 + RowSize) Mod RowSize)
					If row = 0 Then
						For i = table.VisibleRowIds.Size - 1 To 0 Step -1
							row = table.VisibleRowIds.Get(i)
							If row <> 0 Then Exit
						Next
					End If
				Case "DOWN"
					row = table.VisibleRowIds.Get((table.VisibleRowIds.IndexOf(row) + 1 + RowSize) Mod RowSize)
					If row = 0 Then row = table.VisibleRowIds.Get(0)
				Case "ENTER"
					EnterPressed(col, row)
					Return				
				Case Else
					Return
			End Select
			XSelections.CellClicked(col, row)
		End If
	End If
End Sub

Private Sub EnterPressed (ColumnId As String, RowId As Long)
	Log("EnterPressed: " & B4XTable1.GetRow(RowId).Get(ColumnId))
End Sub

Private Sub IsTableFocused (Table As B4XTable) As Boolean
	Dim scene As JavaObject = B4XPages.GetNativeParent(Me).As(JavaObject).GetField("scene")
	Dim FocusedNode As B4XView = scene.RunMethodJO("focusOwnerProperty", Null).RunMethod("get", Null)
	Do While FocusedNode.IsInitialized
		If FocusedNode = Table.clvData.AsView Then Return True
		FocusedNode = FocusedNode.Parent
	Loop
	Return False
End Sub


Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	XSelections.CellClicked(ColumnId, RowId)
End Sub

Sub B4XTable1_DataUpdated
	XSelections.Refresh
End Sub