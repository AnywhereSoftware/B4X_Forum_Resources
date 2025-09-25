B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#Macro: Title, Top, ide://goto?Module=B4XMainPage
#Macro: Title, ShowDialog, ide://goto?Module=B4XMainPage&Sub=ShowDialog
#Macro: Title, Export, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
#Macro: Title, Project, ide://run?file=%WINDIR%\SysWOW64\explorer.exe&Args=%PROJECT%\..\
'#Macro: Title, GitHub, ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=github&Args=..\..\
'#Macro: Title, JsonLayouts folder, ide://run?File=%WINDIR%\explorer.exe&Args=%PROJECT%\JsonLayouts
'#Macro: After Save, Sync Layouts, ide://run?File=%ADDITIONAL%\..\B4X\JsonLayouts.jar&Args=%PROJECT%&Args=%PROJECT_NAME%
'Sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

Sub Class_Globals
	Private DB As SQL
	Private xui As XUI
	Private Root As B4XView
	Private TxtDataId As B4XView
	Private B4XTable1 As B4XTable
	Private EditColumn As B4XTableColumn
	Private PriceColumn As B4XTableColumn
	Private PrefDialog As PreferencesDialog
	#If B4J
	Private DataDir As String = File.DirApp
	#Else
	Private DataDir As String = xui.DefaultFolder
	#End If
	Private DataFile As String = "Sample.db"
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Table")
	B4XPages.SetTitle(Me, "Android Devices")
	InitDatabase
	CreateDialog
	B4XTable1.RowHeight = 40dip
	BtnRefresh_Click
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
End Sub

Private Sub InitDatabase
	If File.Exists(DataDir, DataFile) = False Then
		#If B4J
		DB.InitializeSQLite(DataDir, DataFile, True)
		#Else
		DB.Initialize(DataDir, DataFile, True)
		#End If
		Dim Query As String = $"CREATE TABLE IF NOT EXISTS "Devices" (
		"id"		INTEGER PRIMARY KEY AUTOINCREMENT,
		"brand"		TEXT DEFAULT '',
		"name"		TEXT DEFAULT '',
		"device"	TEXT DEFAULT '',
		"model"		TEXT DEFAULT '',
		"price"		NUMERIC DEFAULT 0
		)"$
		DB.AddNonQueryToBatch(Query, Null)
		Dim sf As Object = DB.ExecNonQueryBatch("SQL")
		Wait For (sf) SQL_NonQueryComplete (Success As Boolean)
		Log("Database created: " & Success)
		If Success = False Then
			LogColor(LastException.Message, xui.Color_Red)
		End If
	Else
		#If B4J
		DB.InitializeSQLite(DataDir, DataFile, False)
		#Else
		DB.Initialize(DataDir, DataFile, False)
		#End If
	End If
End Sub

Private Sub CreateColumns
	EditColumn = B4XTable1.AddColumn("Edit", B4XTable1.COLUMN_TYPE_TEXT)
	EditColumn.Sortable = False
	EditColumn.Width = 127dip
	B4XTable1.NumberOfFrozenColumns = 1
	B4XTable1.AddColumn("Id", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Brand", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Name", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Device", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Model", B4XTable1.COLUMN_TYPE_TEXT)
	PriceColumn = B4XTable1.AddColumn("Price", B4XTable1.COLUMN_TYPE_NUMBERS)
	CreateCustomFormat(PriceColumn, B4XTable1)
End Sub

Private Sub AddControls
	B4XTable1.MaximumRowsPerPage = 20
	B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)
	For i = 1 To EditColumn.CellsLayouts.Size - 1
		Dim p As B4XView = EditColumn.CellsLayouts.Get(i)
		p.AddView(CreateButton("BtnEdit", Chr(0xF044)), 2dip, 2dip, 40dip, 36dip)
		p.AddView(CreateButton("BtnDelete", Chr(0xF00D)), 44dip, 2dip, 40dip, 36dip)
		p.AddView(CreateButton("BtnDuplicate",Chr(0xF0C5)), 85dip, 2dip, 40dip, 36dip)
	Next
End Sub

Private Sub CreateCustomFormat (c As B4XTableColumn, v As B4XTable)
	Dim formatter As B4XFormatter
	formatter.Initialize
	c.Formatter = formatter
	Dim Positive As B4XFormatData = c.Formatter.NewFormatData
	Positive.MinimumFractions = 2
	Positive.MaximumFractions = 2
	Positive.TextColor = v.TextColor
	Positive.FormatFont = xui.CreateDefaultFont(16)
	c.Formatter.AddFormatData(Positive, 0, c.Formatter.MAX_VALUE, True) 'Inclusive (zero included)
	Dim Negative As B4XFormatData = c.Formatter.CopyFormatData(Positive)
	Negative.TextColor = xui.Color_Red
	Negative.FormatFont = xui.CreateDefaultBoldFont(16)
	Negative.Prefix = "("
	Negative.Postfix = ")"
	c.Formatter.AddFormatData(Negative, c.Formatter.MIN_VALUE, 0, False)
End Sub

Sub CreateButton (EventName As String, Text As String) As B4XView
	Dim Btn As Button
	Dim FontSize As Int = 12
	#If B4i
	'Btn.Initialize(EventName,Btn.STYLE_SYSTEM)
	Btn.InitializeCustom(EventName, xui.Color_Black, xui.Color_White)
	#Else
	Btn.Initialize(EventName)
	#End If
	Dim x As B4XView = Btn
	x.Font = xui.CreateFontAwesome(FontSize)
	x.Visible = False
	x.Text = Text
	Return x
End Sub

Private Sub CreateDialog
	PrefDialog.Initialize(Root, "Add/Edit Device", 600dip, 330dip)
	PrefDialog.Theme = PrefDialog.THEME_LIGHT
	PrefDialog.LoadFromJson(File.ReadString(File.DirAssets, "template.json"))
End Sub

Private Sub ShowDialog (Item As Map, RowId As Long)
	Dim sf As Object = PrefDialog.ShowDialog(Item, "OK", "CANCEL")
	PrefDialog.Dialog.Base.Top = 50dip ' Make it lower
	Wait For (sf) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		' Convert item map to list of params for SQL query
		Dim params As List
		params.Initialize
		params.AddAll(Array(Item.Get("Id"), Item.Get("Brand"), Item.Get("Name"), Item.Get("Device"), Item.Get("Model"), Item.Get("Price"))) 'keys based on the template json file
		If RowId = 0 Then 'new row
			' Check duplicate Device and Model in sqlite db
			Dim Query As String = $"SELECT "id" FROM "Devices" WHERE "device" = ? AND "model" = ?"$
			Dim RS As ResultSet = DB.ExecQuery2(Query, Array As String(Item.Get("Device"), Item.Get("Model"))) ' use values from item map
			'Dim RS As ResultSet = DB.ExecQuery2(Query, Array As String(params.Get(3), params.Get(4)))			' or use values from params list (index can be confusing)
			If RS.NextRow Then
				xui.MsgboxAsync("Device already exist!", "E R R O R")
				Return
			End If
			' Insert new Device in sqlite db
			Dim Query As String = $"INSERT INTO "Devices" ("brand", "name", "device", "model", "price") VALUES (?, ?, ?, ?, ?)"$
			DB.ExecNonQuery2(Query, Array As String(Item.Get("Brand"), Item.Get("Name"), Item.Get("Device"), Item.Get("Model"), Item.Get("Price")))
			'DB.ExecNonQuery2(Query, Array As String(params.Get(1), params.Get(2), params.Get(3), params.Get(4), params.Get(5)))
			
			' Get freshly inserted id from sqlite db
			Dim newID As Int
			Dim RS As ResultSet = DB.ExecQuery("SELECT LAST_INSERT_ROWID()")
			Do While RS.NextRow
				newID = RS.GetInt2(0)
			Loop
			RS.Close
			
			params.Set(0, newID) ' Replace the id as params.Get(0)
			B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data (c0, c1, c2, c3, c4, c5, c6) VALUES ("", ?, ?, ?, ?, ?, ?)"$, params)
			'B4XTable1.ClearDataView
			' Let's show last page
			'GotoLastPage
			' Stay at current page but update paging and labels
			B4XTable1.UpdateTableCounters
		Else
			params.Add(RowId) ' Add the selected rowid as params.Get(6)
			
			' Check duplicate Device and Model in sqlite db
			Dim Found As Boolean
			Dim Query As String = $"SELECT "id" FROM "Devices" WHERE "device" = ? AND "model" = ? AND "id" <> ?"$
			Dim RS As ResultSet = DB.ExecQuery2(Query, Array As String(Item.Get("Device"), Item.Get("Model"), Item.Get("Id")))
			'Dim RS As ResultSet = DB.ExecQuery2(Query, Array As String(params.Get(3), params.Get(4), params.Get(0)))
			If RS.NextRow Then
				Found = True
			End If
			RS.Close
			If Found Then
				xui.MsgboxAsync("Device with another id already exist!", "E R R O R")
				Return
			End If

			' Update data in sqlite db
			Dim Query As String = $"UPDATE "Devices" SET "brand" = ?, "name" = ?, "device" = ?, "model" = ?, "price" = ? WHERE "id" = ?"$
			DB.ExecNonQuery2(Query, Array As String(Item.Get("Brand"), Item.Get("Name"), Item.Get("Device"), Item.Get("Model"), Item.Get("Price"), Item.Get("Id")))
			'DB.ExecNonQuery2(Query, Array As String(params.Get(1), params.Get(2), params.Get(3), params.Get(4), params.Get(5), params.Get(0)))
			' Update in-memory db
			' First column is c0. We skip it as this is the "edit" column
			Dim Query As String = $"UPDATE data SET c1 = ?, c2 = ?, c3 = ?, c4 = ?, c5 = ?, c6 = ? WHERE rowid = ?"$
			B4XTable1.sql1.ExecNonQuery2(Query, params)
			B4XTable1.Refresh
		End If
	End If
End Sub

Private Sub GetRowId (View As B4XView) As Long
	Dim RowIndex As Int = EditColumn.CellsLayouts.IndexOf(View.Parent)
	Dim RowId As Long = B4XTable1.VisibleRowIds.Get(RowIndex - 1) '-1 because of the header
	Return RowId
End Sub

' Code adapted from B4XTable's lblLast_Click
Private Sub GotoLastPage 'ignore
	Dim CurrentCount As Int = B4XTable1.mCurrentCount
	Dim RowsPerPage As Int = B4XTable1.RowsPerPage
	Dim NumberOfPages As Int = Ceil(CurrentCount / RowsPerPage)
	B4XTable1.FirstRowIndex = (NumberOfPages - 1) * RowsPerPage
End Sub

Private Sub B4XTable1_DataUpdated
	For i = 0 To B4XTable1.VisibleRowIds.Size - 1
		Dim p As B4XView = EditColumn.CellsLayouts.Get(i + 1)
		p.GetView(1).Visible = B4XTable1.VisibleRowIds.Get(i) > 0
		p.GetView(2).Visible = p.GetView(1).Visible
		p.GetView(3).Visible = p.GetView(1).Visible
	Next
	' Adjust labels width
	#If B4J
	B4XTable1.lblFromTo.Width = 260dip
	B4XTable1.lblNumber.Parent.Width = 260dip
	B4XTable1.lblNumber.Width = B4XTable1.lblNumber.Parent.Width - 146dip
	B4XTable1.lblNumber.Parent.Left = B4XTable1.SearchField.mBase.Left - B4XTable1.lblNumber.Parent.Width - 5dip
	B4XTable1.lblLast.Left = B4XTable1.lblLast.Parent.Width - B4XTable1.lblLast.Width
	B4XTable1.lblNext.Left = B4XTable1.lblLast.Left - B4XTable1.lblNext.Width
	#Else If B4A
	B4XTable1.lblNumber.Parent.Width = 380dip
	B4XTable1.lblNumber.Width = B4XTable1.lblNumber.Parent.Width - 146dip
	B4XTable1.SearchField.mBase.Left = B4XTable1.lblNumber.Parent.Width + 20dip
	B4XTable1.lblLast.Left = B4XTable1.lblLast.Parent.Width - B4XTable1.lblLast.Width
	B4XTable1.lblNext.Left = B4XTable1.lblLast.Left - B4XTable1.lblNext.Width
	#End If
End Sub

Private Sub BtnAdd_Click
	Dim Item As Map = CreateMap("Id": 0, "Brand": "", "Name": "", "Device": "", "Model": "", "Price": 0)
	ShowDialog(Item, 0)
End Sub

Private Sub BtnEdit_Click
	Dim RowId As Long = GetRowId(Sender)
	Dim Item As Map = B4XTable1.GetRow(RowId)
	'Log(Item)
	ShowDialog(Item, RowId)
End Sub

Private Sub BtnDelete_Click
	Dim RowId As Long = GetRowId(Sender)
	Dim Item As Map = B4XTable1.GetRow(RowId)
	Dim sf As Object = xui.Msgbox2Async($"Device: ${Item.Get("Device")}"$, "Delete Device?", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		' Check existing id in sqlite
		Dim Query As String = $"SELECT "id" FROM "Devices" WHERE "id" = ?"$
		Dim RS As ResultSet =  DB.ExecQuery2(Query, Array As String(Item.Get("Id")))
		If Not(RS.NextRow) Then
			xui.MsgboxAsync("Device not found!", "E R R O R")
			Return
		End If
		' Remove from sqlite db
		Dim Query As String = $"DELETE FROM "Devices" WHERE "id" = ?"$
		DB.ExecNonQuery2(Query, Array As Object(Item.Get("Id")))
		' Remove from in-memory db
		Dim Query As String = "DELETE FROM data WHERE rowid = ?"
		B4XTable1.sql1.ExecNonQuery2(Query, Array(RowId))
		'B4XTable1.ClearDataView 'update the table
		'B4XTable1.Refresh
		' Stay at current page but update paging and labels
		B4XTable1.UpdateTableCounters
	End If
End Sub

Private Sub BtnDuplicate_Click
	Dim RowId As Long = GetRowId(Sender)
	Dim Item As Map = B4XTable1.GetRow(RowId)
	ShowDialog(Item, 0) 'RowId = 0 means that a new item will be created
End Sub

' List of Android Devices
' Source: https://github.com/pbakondy/android-device-list/
Private Sub BtnDownload_Click
	Dim Rows As Int
	Dim Query As String = $"SELECT COUNT("id") FROM "Devices""$
	Dim RS As ResultSet = DB.ExecQuery(Query)
	Do While RS.NextRow
		Rows = RS.GetInt2(0)
	Loop
	RS.Close
	If Rows > 0 Then
		xui.MsgboxAsync("Database not empty!", "Data existed")
		Return
	End If
	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download("https://raw.githubusercontent.com/pbakondy/android-device-list/refs/heads/master/devices.json")
	Wait For (job) JobDone (job As HttpJob)
	If job.Success Then
		Dim response As List = job.GetString.As(JSON).ToList
		If response.Size = 0 Then Return
		Dim Query As String = $"INSERT INTO "Devices" ("brand", "name", "device", "model", "price") VALUES (?, ?, ?, ?, ?)"$
		For Each item As Map In response
			DB.AddNonQueryToBatch(Query, Array(item.Get("brand"), item.Get("name"), item.Get("device"), item.Get("model"), 0))
		Next
		Dim sf As Object = DB.ExecNonQueryBatch("SQL")
		Wait For (sf) SQL_NonQueryComplete (Success As Boolean)
		Log("Insert: " & Success)
		If Success = False Then
			LogColor(LastException.Message, xui.Color_Red)
		End If
	Else
		Log(job.ErrorMessage)
	End If
	job.Release
	' Show the data
	BtnRefresh_Click
End Sub

Private Sub LoadData
	Dim Data As List
	Data.Initialize
	Dim Query As String = $"SELECT "id", "brand", "name", "device", "model", "price" FROM "Devices""$
	Dim RS1 As ResultSet = DB.ExecQuery(Query)
	Do While RS1.NextRow
		Data.Add(Array("", RS1.GetInt("id"), RS1.GetString("brand"), RS1.GetString("name"), RS1.GetString("device"), RS1.GetString("model"), RS1.GetDouble("price")))
	Loop
	RS1.Close
	Wait For (B4XTable1.SetData(Data)) Complete (Unused As Boolean)
	' Check first row of in-memory db
	'Dim Query As String = "SELECT * FROM data LIMIT 1"
	'Dim RS2 As ResultSet = B4XTable1.sql1.ExecQuery(Query)
	'Do While RS2.NextRow
	'	Log($"${RS2.GetString2(0)}|${RS2.GetString2(1)}|${RS2.GetString2(2)}|${RS2.GetString2(3)}|${RS2.GetString2(4)}|${RS2.GetString2(5)}|${RS2.GetDouble2(6)}"$)
	'Loop
	'RS2.Close
	Log("Loaded")
End Sub

Private Sub BtnJump_Click
	If TxtDataId.Text.Length = 0 Then Return
	B4XTable1.CreateDataView("c1 >= " & TxtDataId.Text)
End Sub

Private Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	Dim item As Map = B4XTable1.GetRow(RowId)
	TxtDataId.Text = item.Get("Id")
End Sub

Private Sub BtnRefresh_Click
	B4XTable1.Clear
	CreateColumns
	LoadData
	AddControls
End Sub