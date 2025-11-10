B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private DB As MiniORM
	Private Conn As ORMConnector
	Private lblTitle As B4XView
	Private lblBack As B4XView
	Private clvRecord As CustomListView
	Private btnEdit As B4XView
	Private btnDelete As B4XView
	Private btnNew As B4XView
	Private lblName As B4XView
	Private lblStatus As B4XView
	Private PrefDialog1 As PreferencesDialog
	Private PrefDialog2 As PreferencesDialog
	Private PrefDialog3 As PreferencesDialog
	Private Const COLOR_RED As Int = -65536
	Private Const COLOR_BLUE As Int = -16776961
	Private Const COLOR_MAGENTA As Int = -65281
	Private Const COLOR_ADD As Int = -13447886
	Private Const COLOR_EDIT As Int = -12490271
	Private Const COLOR_DELETE As Int = -2354116
	Private Const COLOR_OVERLAY As Int = -2147481048
	Private Const COLOR_TRANSPARENT As Int = 0
	Type Cassa (IdCassa As String, Name As String)
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "MiniORM")
	CreateDialog1
	CreateDialog2
	CreateDialog3
	ConfigureDatabase
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	If xui.IsB4A Then
		'back key in Android
		If PrefDialog1.BackKeyPressed Then Return False
		If PrefDialog2.BackKeyPressed Then Return False
		If PrefDialog3.BackKeyPressed Then Return False
	End If
	DBClose
	Return True
End Sub

Private Sub B4XPage_Appear
	'GetCategories
End Sub

Private Sub B4XPage_Resize(Width As Int, Height As Int)
	If PrefDialog1.IsInitialized And PrefDialog1.Dialog.Visible Then PrefDialog1.Dialog.Resize(Width, Height)
	If PrefDialog2.IsInitialized And PrefDialog2.Dialog.Visible Then PrefDialog2.Dialog.Resize(Width, Height)
	If PrefDialog3.IsInitialized And PrefDialog3.Dialog.Visible Then PrefDialog3.Dialog.Resize(Width, Height)
End Sub

'Don't miss the code in the Main module + manifest editor.
Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	PrefDialog1.KeyboardHeightChanged(NewHeight)
	PrefDialog2.KeyboardHeightChanged(NewHeight)
	PrefDialog3.KeyboardHeightChanged(NewHeight)
End Sub

Private Sub clvRecord_ItemClick (Index As Int, Value As Object)
	' A demo to retrieve object
	Dim selectedCassa As Cassa = Value
	Log($"Casa Id: ${selectedCassa.IdCassa}${CRLF}Casa Name: ${selectedCassa.Name}"$)
End Sub

Private Sub btnNew_Click
	ShowDialog1
End Sub

Private Sub btnEdit_Click
	Dim Index As Int = clvRecord.GetItemFromView(Sender)
	Dim CassaEdit As Cassa = clvRecord.GetValue(Index)
	ShowDialog2(CassaEdit)
End Sub

Private Sub btnDelete_Click
	Dim Index As Int = clvRecord.GetItemFromView(Sender)
	Dim CassaDelete As Cassa = clvRecord.GetValue(Index)
	ShowDialog3(CassaDelete)
End Sub

Private Sub DBType As String
	Return Conn.DBType
End Sub

Private Sub DBOpen As SQL
	Return Conn.DBOpen
End Sub

Private Sub DBClose
	Conn.DBClose
End Sub

Public Sub ConfigureDatabase
	Dim con As ConnectionInfo
	con.Initialize
	con.DBType = "SQLite"
	con.DBFile = "Cassa.db"
	
	#If B4J
	con.DBDir = File.DirApp
	#Else
	con.DBDir = xui.DefaultFolder 
	#End If

	Try
		Conn.Initialize(con)
		Dim DBFound As Boolean = Conn.DBExist
		If DBFound Then
			LogColor($"${con.DBType} database found!"$, COLOR_BLUE)
			DB.Initialize(DBType, DBOpen)
			DB.ShowExtraLogs = True
			#If B4A or B4i
			'DB.ShowDBUtilsJson = True
			#End If
			LoadCassa
		Else
			LogColor($"${con.DBType} database not found!"$, COLOR_RED)
			CreateDatabase
		End If
	Catch
		Log(LastException.Message)
		LogColor("Error checking database!", COLOR_RED)
		Log("Application is terminated.")
		#If B4J
		ExitApplication
		#End If
	End Try
End Sub

Private Sub CreateDatabase
	LogColor("Creating database...", COLOR_MAGENTA)
	#If B4A or B4i
	Dim Success As Boolean = Conn.DBCreate
	#Else
	Wait For (Conn.DBCreate) Complete (Success As Boolean)
	#End If
	If Not(Success) Then
		Log("Database creation failed!")
		Return
	End If
	
	DB.Initialize(DBType, DBOpen)
	DB.UseTimestamps = True
	DB.QueryAddToBatch = True
	DB.AutoIncrement = False
	
	DB.Table = "tCassa"
	DB.Columns.Add(DB.CreateColumn2(CreateMap("Name": "idCassa")))
	DB.Columns.Add(DB.CreateColumn2(CreateMap("Name": "Name")))
	DB.Primary(Array As String("idCassa"))
	DB.Create
	
	DB.Columns = Array("idCassa", "Name")
	DB.Insert2(Array As String("1", "Hardwares"))
	DB.Insert2(Array As String("2", "Toys"))
	
	Wait For (DB.ExecuteBatch) Complete (Success As Boolean)
	If Success Then
		LogColor("Database is created successfully!", COLOR_BLUE)
	Else
		LogColor("Database creation failed!", COLOR_RED)
		Log(LastException)
	End If
	DB.Close
	DB.Initialize(DBType, DBOpen)
	LoadCassa
End Sub

Private Sub LoadCassa
	Try
		DB.Table = "tCassa"
		DB.Query
		Dim Items As List = DB.Results
		clvRecord.Clear
		For Each Item As Map In Items
			Dim Cassa As Cassa = CreateCassa(Item.Get("idCassa"), Item.Get("Name"))
			clvRecord.Add(CreateCassaItems(Cassa.Name, clvRecord.AsView.Width), Cassa)
		Next
		lblTitle.Text = "Cassa"
		lblBack.Visible = False
	Catch
		xui.MsgboxAsync(LastException.Message, "Error")
	End Try
End Sub

Private Sub CreateCassaItems (Name As String, Width As Double) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Width, 90dip)
	p.LoadLayout("CassaItem")
	lblName.Text = Name
	Return p
End Sub

Private Sub CreateDialog1
	PrefDialog1.Initialize(Root, "Add Cassa", 300dip, 150dip)
	PrefDialog1.Dialog.TitleBarHeight = 50dip
	PrefDialog1.Dialog.TitleBarColor = COLOR_ADD
	PrefDialog1.Dialog.OverlayColor = COLOR_OVERLAY
	PrefDialog1.LoadFromJson(File.ReadString(File.DirAssets, "template_cassa.json"))
	PrefDialog1.SetEventsListener(Me, "PrefDialog1") '<-- must add to handle events
End Sub

Private Sub CreateDialog2
	PrefDialog2.Initialize(Root, "Edit Cassa", 300dip, 150dip)
	PrefDialog2.Dialog.TitleBarHeight = 50dip
	PrefDialog2.Dialog.TitleBarColor = COLOR_EDIT
	PrefDialog2.Dialog.OverlayColor = COLOR_OVERLAY
	PrefDialog2.LoadFromJson(File.ReadString(File.DirAssets, "template_cassa.json"))
	PrefDialog2.SetEventsListener(Me, "PrefDialog2") '<-- must add to handle events
End Sub

Private Sub CreateDialog3
	PrefDialog3.Initialize(Root, "Delete Cassa", 300dip, 70dip)
	PrefDialog3.Dialog.TitleBarHeight = 50dip
	PrefDialog3.Dialog.TitleBarColor = COLOR_DELETE
	PrefDialog3.Dialog.OverlayColor = COLOR_OVERLAY
	PrefDialog3.Theme = PrefDialog3.THEME_LIGHT
	PrefDialog3.AddSeparator("default")
	PrefDialog3.SetEventsListener(Me, "PrefDialog3") '<-- must add to handle events
End Sub

Private Sub PrefDialog1_BeforeDialogDisplayed (Template As Object)
	AdjustDialogText(PrefDialog1)
End Sub

Private Sub PrefDialog2_BeforeDialogDisplayed (Template As Object)
	AdjustDialogText(PrefDialog2)
End Sub

Private Sub PrefDialog3_BeforeDialogDisplayed (Template As Object)
	AdjustDialogText(PrefDialog3)
End Sub

Private Sub AdjustDialogText (Pref As PreferencesDialog)
	Try
		Dim btnCancel As B4XView = Pref.Dialog.GetButton(xui.DialogResponse_Cancel)
		btnCancel.Width = btnCancel.Width + 20dip
		btnCancel.Left = btnCancel.Left - 20dip
		btnCancel.TextColor = COLOR_RED
		Dim btnOk As B4XView = Pref.Dialog.GetButton(xui.DialogResponse_Positive)
		If btnOk.IsInitialized Then
			btnOk.Width = btnOk.Width + 20dip
			btnOk.Left = btnCancel.Left - btnOk.Width
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub ShowDialog1
	Dim Item As Map = CreateMap("idCassa": "", "Cassa Name": "")
	Dim sf As Object = PrefDialog1.ShowDialog(Item, "OK", "CANCEL")
	#If B4A or B4i
	PrefDialog1.Dialog.Base.Top = 100dip ' Make it lower
	#Else
	Sleep(0)
	PrefDialog1.CustomListView1.sv.Height = PrefDialog1.CustomListView1.sv.ScrollViewInnerPanel.Height + 10dip
	#End If
	Wait For (sf) Complete (Result As Int)
	If Result <> xui.DialogResponse_Positive Then Return
	' Check idCassa already exist
	DB.Table = "tCassa"
	DB.WhereParam("idCassa = ?", Item.Get("idCassa"))
	DB.Query
	If DB.Found Then
		xui.MsgboxAsync("Id Cassa already exists!", "Edit")
		Return
	Else
		DB.AutoIncrement = False
		DB.Table = "tCassa"
		DB.Columns = Array("idCassa", "Name")
		DB.Parameters = Array(Item.Get("idCassa"), Item.Get("Cassa Name"))
		DB.Save
		xui.MsgboxAsync("New Cassa created!", "Add")
		LoadCassa
	End If
End Sub

Private Sub ShowDialog2 (Cassa As Cassa)
	Dim Item As Map = CreateMap("idCassa": Cassa.IdCassa, "Cassa Name": Cassa.Name)
	Dim sf As Object = PrefDialog2.ShowDialog(Item, "OK", "CANCEL")
	#If B4A or B4i
	PrefDialog2.Dialog.Base.Top = 100dip ' Make it lower
	#Else
	Sleep(0)
	PrefDialog2.CustomListView1.sv.Height = PrefDialog2.CustomListView1.sv.ScrollViewInnerPanel.Height + 10dip
	#End If
	Wait For (sf) Complete (Result As Int)
	If Result <> xui.DialogResponse_Positive Then Return
	' Check idCassa already exist
	DB.Table = "tCassa"
	DB.WhereParam("idCassa = ?", Cassa.IdCassa)
	DB.Query
	If DB.Found = False Then
		xui.MsgboxAsync("Id Cassa not found!", "Edit")
		Return
	End If
	If Cassa.IdCassa <> Item.Get("idCassa") Then
		xui.MsgboxAsync("Cannot update to another Id!", "Edit")
		Return
	End If
	DB.Table = "tCassa"
	DB.Columns = Array("IdCassa", "Name")
	DB.Parameters = Array As String(Item.Get("idCassa"), Item.Get("Cassa Name"))
	DB.WhereParams(Array("IdCassa = ?"), Array(Cassa.IdCassa))
	DB.Save
	LoadCassa
	xui.MsgboxAsync("Cassa updated!", "Edit")
End Sub

Private Sub ShowDialog3 (Cassa As Cassa)
	Dim sf As Object = PrefDialog3.ShowDialog(CreateMap("Cassa Name": Cassa.Name), "OK", "CANCEL")
	#If B4A or B4i
	PrefDialog3.Dialog.Base.Top = 100dip ' Make it lower
	#Else
	Sleep(0)
	PrefDialog3.CustomListView1.sv.Height = PrefDialog3.CustomListView1.sv.ScrollViewInnerPanel.Height + 10dip
	#End If
	PrefDialog3.CustomListView1.GetPanel(0).GetView(0).Text = Cassa.Name
	#If B4i
	PrefDialog3.CustomListView1.GetPanel(0).GetView(0).TextSize = 16 ' Text too small in ios
	#Else
	PrefDialog3.CustomListView1.GetPanel(0).GetView(0).TextSize = 15 ' 14
	#End If
	PrefDialog3.CustomListView1.GetPanel(0).GetView(0).Color = COLOR_TRANSPARENT
	PrefDialog3.CustomListView1.sv.ScrollViewInnerPanel.Color = COLOR_TRANSPARENT
	Wait For (sf) Complete (Result As Int)
	If Result <> xui.DialogResponse_Positive Then Return
	DB.Table = "tCassa"
	DB.WhereParam("IdCassa = ?", Cassa.IdCassa)
	DB.Query
	If DB.Found = False Then
		xui.MsgboxAsync("Cassa not found", "Error")
		Return
	End If
	DB.Reset
	DB.WhereParam("IdCassa = ?", Cassa.IdCassa)
	DB.Delete
	LoadCassa
	xui.MsgboxAsync("Cassa deleted successfully", "Delete")
End Sub

Public Sub CreateCassa (IdCassa As String, Name As String) As Cassa
	Dim t1 As Cassa
	t1.Initialize
	t1.IdCassa = IdCassa
	t1.Name = Name
	Return t1
End Sub