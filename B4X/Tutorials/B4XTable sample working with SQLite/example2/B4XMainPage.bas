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
	Private TxtCode As B4XView
	Private B4XTable1 As B4XTable
	Private EditColumn As B4XTableColumn
	Private EmailColumn As B4XTableColumn
	Private PrefDialog As PreferencesDialog
	#If B4J
	Private DataDir As String = File.DirApp
	#Else
	Private DataDir As String = xui.DefaultFolder
	#End If
	Private DataFile As String = "Customers.db"
	'Private LastRowNum As Int
	Private FavouritedCustomerCode As String
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Table")
	B4XPages.SetTitle(Me, "Customers")
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
		Dim Query As String = $"CREATE TABLE IF NOT EXISTS "Customers" (
		"code"			TEXT PRIMARY KEY UNIQUE,
		"first name"	TEXT DEFAULT '',
		"last name"		TEXT DEFAULT '',
		"email"			TEXT DEFAULT '',
		"location"		TEXT DEFAULT '',
		"sales"			NUMERIC DEFAULT 0
		)"$
		DB.AddNonQueryToBatch(Query, Null)
		Dim Query As String = $"INSERT INTO "Customers" ("code", "first name", "last name", "email", "location", "sales") VALUES (?, ?, ?, ?, ?, ?)"$
		DB.AddNonQueryToBatch(Query, Array("D001", "John", "Doe", "john.doe@acme.com", "CN", 10))
		DB.AddNonQueryToBatch(Query, Array("D002", "Jane", "Doe", "jane.doe@yahoo.com", "UK", 50))
		DB.AddNonQueryToBatch(Query, Array("S001", "Alice", "Smith", "alice.smith@google.com", "EU", 250))
		DB.AddNonQueryToBatch(Query, Array("R001", "Bob", "Ross", "bob.ross@acme.com", "IT", 320))
		DB.AddNonQueryToBatch(Query, Array("J001", "Michael", "Jordan", "mike.jordan@gmail.com", "US", 360))
		DB.AddNonQueryToBatch(Query, Array("D003", "Donald", "Duck", "donald.duck@disney.com", "US", 500))
		
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
	B4XTable1.AddColumn("Code", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("First Name", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Last Name", B4XTable1.COLUMN_TYPE_TEXT)
	EmailColumn = B4XTable1.AddColumn("Email", B4XTable1.COLUMN_TYPE_TEXT)
	EmailColumn.Width = 200dip
	B4XTable1.AddColumn("Location", B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn("Sales", B4XTable1.COLUMN_TYPE_NUMBERS)
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

Sub CreateButton (EventName As String, Text As String) As B4XView
	Dim Btn As Button
	Dim FontSize As Int = 12
	#If B4i
	Btn.Initialize(EventName,Btn.STYLE_SYSTEM)
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
	PrefDialog.Initialize(Root, "Add/Edit Customer", 600dip, 330dip)
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
		params.AddAll(Array(Item.Get("Code"), Item.Get("First Name"), Item.Get("Last Name"), Item.Get("Email"), Item.Get("Location"), Item.Get("Sales"))) 'keys based on the template json file
		If RowId = 0 Then 'new row
			' Check duplicate Device and Model in sqlite db
			Dim Query As String = $"SELECT "code" FROM "Customers" WHERE "first name" = ? AND "last name" = ?"$
			Dim RS As ResultSet =  DB.ExecQuery2(Query, Array As String(Item.Get("First Name"), Item.Get("Last Name"))) ' use values from item map
			If RS.NextRow Then
				xui.MsgboxAsync("Customer already exist!", "E R R O R")
				Return
			End If
			' Insert new Device in sqlite db
			Dim Query As String = $"INSERT INTO "Customers" ("code", "first name", "last name", "email", "location", "sales") VALUES (?, ?, ?, ?, ?, ?)"$
			DB.ExecNonQuery2(Query, Array As String(Item.Get("Code"), Item.Get("First Name"), Item.Get("Last Name"), Item.Get("Email"), Item.Get("Location"), Item.Get("Sales")))
			
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
			
			' Check duplicate First and Last Name in sqlite db
			Dim Found As Boolean
			Dim Query As String = $"SELECT "code" FROM "Customers" WHERE "first name" = ? AND "last name" = ? AND "code" <> ?"$
			Dim RS As ResultSet =  DB.ExecQuery2(Query, Array As String(Item.Get("First Name"), Item.Get("Last name"), Item.Get("Code")))
			If RS.NextRow Then
				Found = True
			End If
			RS.Close
			If Found Then
				xui.MsgboxAsync("Customer with same code already exist!", "E R R O R")
				Return
			End If

			' Update data in sqlite db
			Dim Query As String = $"UPDATE "Customers" SET "code" = ?, "first name" = ?, "last name" = ?, "email" = ?, "location" = ?, "sales" = ? WHERE "code" = ?"$
			DB.ExecNonQuery2(Query, Array As String(Item.Get("Code"), Item.Get("First Name"), Item.Get("Last Name"), Item.Get("Email"), Item.Get("Location"), Item.Get("Sales"), Item.Get("Code")))
						
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
	Dim Item As Map = CreateMap("Code": "", "First Name": "", "Last Name": "", "Email": "", "Location": "", "Sales": 0)
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
	Dim sf As Object = xui.Msgbox2Async($"Code: ${Item.Get("Code")}${CRLF}Name: ${Item.Get("First Name")} ${Item.Get("Last Name")}"$, "Delete Customer?", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		' Check existing id in sqlite
		Dim Query As String = $"SELECT "code" FROM "Customers" WHERE "code" = ?"$
		Dim RS As ResultSet =  DB.ExecQuery2(Query, Array As String(Item.Get("Code")))
		If Not(RS.NextRow) Then
			xui.MsgboxAsync("Customer not found!", "E R R O R")
			Return
		End If
		' Remove from sqlite db
		Dim Query As String = $"DELETE FROM "Customers" WHERE "code" = ?"$
		DB.ExecNonQuery2(Query, Array As Object(Item.Get("Code")))
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

'Private Sub BtnDownload_Click
'	Dim Rows As Int
'	Dim Query As String = $"SELECT COUNT("code") FROM "Customers""$
'	Dim RS As ResultSet = DB.ExecQuery(Query)
'	Do While RS.NextRow
'		Rows = RS.GetInt2(0)
'	Loop
'	RS.Close
'	If Rows > 0 Then
'		xui.MsgboxAsync("Database not empty!", "Data existed")
'		Return
'	End If
'	Dim job As HttpJob
'	job.Initialize("", Me)
'	job.Download("https://raw.githubusercontent.com/pbakondy/android-device-list/refs/heads/master/Customers.json")
'	Wait For (job) JobDone (job As HttpJob)
'	If job.Success Then
'		Dim response As List = job.GetString.As(JSON).ToList
'		If response.Size = 0 Then Return
'		Dim Query As String = $"INSERT INTO "Customers" ("brand", "name", "device", "model", "price") VALUES (?, ?, ?, ?, ?)"$
'		For Each item As Map In response
'			DB.AddNonQueryToBatch(Query, Array(item.Get("brand"), item.Get("name"), item.Get("device"), item.Get("model"), 0))
'		Next
'		Dim sf As Object = DB.ExecNonQueryBatch("SQL")
'		Wait For (sf) SQL_NonQueryComplete (Success As Boolean)
'		Log("Insert: " & Success)
'		If Success = False Then
'			LogColor(LastException.Message, xui.Color_Red)
'		End If
'	Else
'		Log(job.ErrorMessage)
'	End If
'	job.Release
'	' Show the data
'	BtnRefresh_Click
'End Sub

Private Sub LoadData
	Dim Data As List
	Data.Initialize
	Dim Query As String = $"SELECT "code", "first name", "last name", "email", "location", "sales" FROM "Customers""$
	Dim RS1 As ResultSet = DB.ExecQuery(Query)
	Do While RS1.NextRow
		Data.Add(Array("", RS1.GetString("code"), RS1.GetString("first name"), RS1.GetString("last name"), RS1.GetString("email"), RS1.GetString("location"), RS1.GetDouble("sales")))
	Loop
	RS1.Close
	Wait For (B4XTable1.SetData(Data)) Complete (Unused As Boolean)
	' Check last 5 rows of in-memory db
	'Dim Query As String = "SELECT * FROM data ORDER BY rowid DESC LIMIT 5"
	'Dim RS2 As ResultSet = B4XTable1.sql1.ExecQuery(Query)
	'Do While RS2.NextRow
	'	Log($"${RS2.GetString2(0)}|${RS2.GetString2(1)}|${RS2.GetString2(2)}|${RS2.GetString2(3)}|${RS2.GetString2(4)}|${RS2.GetString2(5)}|${RS2.GetDouble2(6)}"$)
	'Loop
	'RS2.Close
	Log("Loaded")
End Sub

'Private Sub BtnJump_Click
'	If TxtRowNum.Text.Length = 0 Then Return
'	LastRowNum = TxtRowNum.Text
'	B4XTable1.FirstRowIndex = LastRowNum - 1
'End Sub
'
'Private Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
'	LastRowNum = RowId
'	TxtRowNum.Text = LastRowNum
'End Sub

Private Sub BtnRead_Click
	B4XTable1.CreateDataView($"c1 = '${FavouritedCustomerCode}'"$)
End Sub

Private Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
    Dim item As Map = B4XTable1.GetRow(RowId)
    FavouritedCustomerCode = item.Get("Code")
    TxtCode.Text = FavouritedCustomerCode
End Sub

Private Sub BtnRefresh_Click
	B4XTable1.Clear
	CreateColumns
	LoadData
	AddControls
End Sub