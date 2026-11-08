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
	Private xui As XUI
	Private Root As B4XView
	Private TxtCode As B4XView
	Private B4XTable1 As B4XTable
	Private EditColumn As B4XTableColumn
	Private EmailColumn As B4XTableColumn
	Private PrefDialog As PreferencesDialog
	Private KVS As KeyValueStore
	Private CustomersList As MinimaList
	Private FavouritedCustomerCode As String
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Table")
	B4XPages.SetTitle(Me, "Customers")
	InitMinimaList
	CreateDialog
	B4XTable1.RowHeight = 40dip
	BtnRefresh_Click
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
End Sub

Private Sub InitMinimaList
	#If B4J
	KVS.Initialize(File.DirApp, "kvs.dat")
	#Else
	KVS.Initialize(xui.DefaultFolder, "kvs.dat")
	#End If
	CustomersList.Initialize
	CustomersList.List = KVS.GetDefault("CustomersList", CustomersList.List)
	If CustomersList.List.Size = 0 Then
		Dim M1 As Map = CreateMap("code": "D001", "first name": "John", "last name": "Doe", "email": "john.doe@acme.com", "location": "CN", "sales": 10, "created_date": CurrentDateTime)
		Dim M2 As Map = CreateMap("code": "D002", "first name": "Jane", "last name": "Doe", "email": "jane.doe@yahoo.com", "location": "UK", "sales": 50, "created_date": CurrentDateTime)
		Dim M3 As Map = CreateMap("code": "S001", "first name": "Alice", "last name": "Smith", "email": "alice.smith@google.com", "location": "EU", "sales": 250.75, "created_date": CurrentDateTime)
		Dim M4 As Map = CreateMap("code": "R001", "first name": "Bob", "last name": "Ross", "email": "bob.ross@acme.com", "location": "IT", "sales": 320, "created_date": CurrentDateTime)
		Dim M5 As Map = CreateMap("code": "J001", "first name": "Michael", "last name": "Jordan", "email": "mike.jordan@gmail.com", "location": "US", "sales": 360, "created_date": CurrentDateTime)
		Dim M6 As Map = CreateMap("code": "D003", "first name": "Donald", "last name": "Duck", "email": "donald.duck@disney.com", "location": "US", "sales": 500, "created_date": CurrentDateTime)
		CustomersList.Add(M1)
		CustomersList.Add(M2)
		CustomersList.Add(M3)
		CustomersList.Add(M4)
		CustomersList.Add(M5)
		CustomersList.Add(M6)		
		WriteKVS("CustomersList", CustomersList)
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
		p.AddView(CreateButton("BtnDuplicate", Chr(0xF0C5)), 85dip, 2dip, 40dip, 36dip)
	Next
End Sub

Sub CreateButton (EventName As String, Text As String) As B4XView
	Dim Btn As Button
	Dim FontSize As Int = 12
	#If B4i
	Btn.Initialize(EventName, Btn.STYLE_SYSTEM)
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
		' Convert item map to list of params
		Dim params As List
		params.Initialize
		params.AddAll(Array(Item.Get("Code"), Item.Get("First Name"), Item.Get("Last Name"), Item.Get("Email"), Item.Get("Location"), Item.Get("Sales"))) 'keys based on the template json file
		If RowId = 0 Then 'new row
			' Check existing code in MinimaList
			Dim M1 As Map = CustomersList.FindFirst(Array("code"), Array(Item.Get("Code")))
			If M1.Size > 0 Then
				xui.MsgboxAsync("Customer code already exist!", "E R R O R")
				Return
			End If
			
			' Check duplicate First and Last Name in MinimaList
			Dim M1 As Map = CustomersList.FindFirst(Array("first name", "last name"), Array(Item.Get("First Name"), Item.Get("Last Name")))
			If M1.Size > 0 Then
				xui.MsgboxAsync("Customer with same name already exist!", "E R R O R")
				Return
			End If

			' Insert new Customer in MinimaList
			Dim M2 As Map
			M2.Initialize
			M2.Put("code", Item.Get("Code"))
			M2.Put("first name", Item.Get("First Name"))
			M2.Put("last name", Item.Get("Last Name"))
			M2.Put("email", Item.Get("Email"))
			M2.Put("location", Item.Get("Location"))
			M2.Put("sales", Item.Get("Sales"))
			'M2.Put("created_date", CurrentDateTime)
			CustomersList.Add(M2)
			WriteKVS("CustomersList", CustomersList)

			B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data (c0, c1, c2, c3, c4, c5, c6) VALUES ("", ?, ?, ?, ?, ?, ?)"$, params)
			' Stay at current page but update paging and labels
			B4XTable1.UpdateTableCounters
		Else
			params.Add(RowId) ' Add the selected rowid as params.Get(6)

			' Check duplicate First and Last Name in MinimaList
			Dim TempList As MinimaList = CustomersList.Clone
			TempList.List = TempList.FindAll(Array("first name", "last name"), Array(Item.Get("First Name"), Item.Get("Last Name")))
			TempList.List = TempList.ExcludeAll(Array("code"), Array(Item.Get("Code")))
			If TempList.List.Size > 0 Then
				xui.MsgboxAsync("Customer with same name already exist!", "E R R O R")
				Return
			End If

			' Update data in MinimaList
			Dim M2 As Map = CustomersList.FindFirst(Array("code"), Array(Item.Get("Code")))
			M2.Put("code", Item.Get("Code"))
			M2.Put("first name", Item.Get("First Name"))
			M2.Put("last name", Item.Get("Last Name"))
			M2.Put("email", Item.Get("Email"))
			M2.Put("location", Item.Get("Location"))
			M2.Put("sales", Item.Get("Sales"))
			'M2.Put("modified_date", CurrentDateTime)
			WriteKVS("CustomersList", CustomersList)

			' Update B4XTable in-memory db
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
		' Check existing code in MinimaList	
		Dim M1 As Map = CustomersList.FindFirst(Array("code"), Array(Item.Get("Code")))
		If M1.Size = 0 Then
			xui.MsgboxAsync("Customer code not found!", "E R R O R")
			Return
		End If

		' Remove row from MinimaList
		CustomersList.Remove2(M1)

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

Private Sub LoadData
	Dim Data As List
	Data.Initialize
	CustomersList.List = KVS.GetDefault("CustomersList", CustomersList.List)
	For Each M1 As Map In CustomersList.List
		Data.Add(Array("", M1.Get("code"), M1.Get("first name"), M1.Get("last name"), M1.Get("email"), M1.Get("location"), M1.Get("sales")))
	Next	
	Wait For (B4XTable1.SetData(Data)) Complete (Unused As Boolean)
End Sub

Private Sub CurrentDateTime As String
	Dim CurrentDateFormat As String = DateTime.DateFormat
	DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
	DateTime.SetTimeZone(0)
	Dim Current As String = DateTime.Date(DateTime.Now)
	DateTime.DateFormat = CurrentDateFormat
	Return Current
End Sub

Private Sub WriteKVS (List As String, M As MinimaList)
	KVS.Put(List, M.List)
End Sub

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