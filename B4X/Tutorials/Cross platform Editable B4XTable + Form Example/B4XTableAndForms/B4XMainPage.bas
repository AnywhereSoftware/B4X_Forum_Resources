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
	Public PrefDialog As PreferencesDialog
	Private xui As XUI
	Private editCol As B4XTableColumn
	Private const CSVFile As String = "table.csv"
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	xui.SetDataFolder("TableAndForms")
	editCol = B4XTable1.AddColumn("Edit", B4XTable1.COLUMN_TYPE_TEXT)
	editCol.Sortable = False
	editCol.Width = 127dip
	B4XTable1.RowHeight = 50dip
	B4XTable1.NumberOfFrozenColumns = 1
	B4XTable1.AddColumn("Type", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Name", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Birth Date", B4XTable1.COLUMN_TYPE_DATE)
	B4XTable1.AddColumn("Sex", B4XTable1.COLUMN_TYPE_TEXT)
	LoadData
	PrefDialog.Initialize(Root, "Editable Table", 300dip, 300dip)
	PrefDialog.LoadFromJson(File.ReadString(File.DirAssets, "template.json"))
	PrefDialog.SetOptions("Type", File.ReadList(File.DirAssets, "animals.txt"))
	PrefDialog.SearchTemplate.MaxNumberOfItemsToShow = 300
	B4XTable1.MaximumRowsPerPage = 20
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	For i = 1 To editCol.CellsLayouts.Size - 1
		Dim p As B4XView = editCol.CellsLayouts.Get(i)
		p.AddView(CreateButton("btnEdit", Chr(0xF044)), 2dip, 5dip, 40dip, 40dip)
		p.AddView(CreateButton("btnDelete", Chr(0xF00D)), 44dip, 5dip, 40dip, 40dip)
		p.AddView(CreateButton("btnDuplicate",Chr(0xF0C5)), 85dip, 5dip, 40dip, 40dip)
	Next
End Sub

Private Sub B4XPage_Background
	ExportTableToCSV
End Sub

Sub LoadData
	Dim data As List
	If File.Exists(xui.DefaultFolder, CSVFile) Then
		Dim su As StringUtils
		data = su.LoadCSV(xui.DefaultFolder, CSVFile, ",")
	Else
		data.Initialize
	End If
	B4XTable1.SetData(data)
End Sub

Sub btnDelete_Click
	Dim RowId As Long = GetRowId(Sender)
	Dim Item As Map = B4XTable1.GetRow(RowId)
	Dim sf As Object = xui.Msgbox2Async($"Delete item: ${Item.Get("Name")}?"$, "", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		B4XTable1.sql1.ExecNonQuery2("DELETE FROM data WHERE rowid = ?", Array(RowId))
		B4XTable1.UpdateTableCounters
	End If
End Sub

Sub btnEdit_Click
	Dim RowId As Long = GetRowId(Sender)
	Dim Item As Map = B4XTable1.GetRow(RowId)
	ShowDialog(Item, RowId)
End Sub

Sub btnDuplicate_Click
	Dim RowId As Long = GetRowId(Sender)
	Dim Item As Map = B4XTable1.GetRow(RowId)
	ShowDialog(Item, 0) 'RowId = 0 means that a new item will be created
End Sub

Sub GetRowId (View As B4XView) As Long
	Dim RowIndex As Int = editCol.CellsLayouts.IndexOf(View.Parent)
	Dim RowId As Long = B4XTable1.VisibleRowIds.Get(RowIndex - 1) '-1 because of the header
	Return RowId
End Sub

Sub CreateButton (EventName As String, Text As String) As B4XView
	Dim Btn As Button
	Dim FontSize As Int = 14
	#if B4i
	Btn.InitializeCustom(EventName, xui.Color_Black, xui.Color_White)
	FontSize = 16
	#else
	Btn.Initialize(EventName)
	#End If
	Dim x As B4XView = Btn
	
	x.Font =  xui.CreateFontAwesome(FontSize)
	x.Visible = False
	x.Text = Text
	Return x
End Sub

Private Sub B4XTable1_DataUpdated
	For i = 0 To B4XTable1.VisibleRowIds.Size - 1
		Dim p As B4XView = editCol.CellsLayouts.Get(i + 1)
		p.GetView(1).Visible = B4XTable1.VisibleRowIds.Get(i) > 0
		p.GetView(2).Visible = p.GetView(1).Visible
		p.GetView(3).Visible = p.GetView(1).Visible
	Next
End Sub

Private Sub ShowDialog(Item As Map, RowId As Long)
	Wait For (PrefDialog.ShowDialog(Item, "OK", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim params As List
		params.Initialize
		params.AddAll(Array(Item.Get("Type"), Item.Get("Name"), Item.Get("Birth Date"), Item.Get("Sex"))) 'keys based on the template json file
		If RowId = 0 Then 'new row
			B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES("", ?, ?, ?, ?)"$, params)
			B4XTable1.ClearDataView
		Else
			params.Add(RowId)
			'first column is c0. We skip it as this is the "edit" column
			B4XTable1.sql1.ExecNonQuery2("UPDATE data SET c1 = ?, c2 = ?, c3 = ?, c4 = ? WHERE rowid = ?", params)
			B4XTable1.Refresh
		End If
	End If
End Sub

Sub btnAdd_Click
	ShowDialog(CreateMap(), 0)
End Sub

Public Sub ExportTableToCSV
	Dim data As List
	data.Initialize
	Dim rs As ResultSet = B4XTable1.sql1.ExecQuery("SELECT * FROM data")
	Do While rs.NextRow
		Dim row(B4XTable1.Columns.Size) As String
		For i = 0 To B4XTable1.Columns.Size - 1
			Dim c As B4XTableColumn = B4XTable1.Columns.Get(i)
			row(i) = rs.GetString(c.SQLID)
		Next
		data.Add(row)
	Loop
	rs.Close
	Dim su As StringUtils
	su.SaveCSV(xui.DefaultFolder, CSVFile, ",", data)
End Sub