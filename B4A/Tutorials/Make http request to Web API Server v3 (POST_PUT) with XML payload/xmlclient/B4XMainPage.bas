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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=XmlClient.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private URL As String = "http://192.168.50.42:8080/api/" ' Change to your Web API Server URL
	Private lblTitle As B4XView
	Private lblBack As B4XView
	Private clvRecord As CustomListView
	Private btnEdit As B4XView
	Private btnDelete As B4XView
	Private btnNew As B4XView
	Private lblName As B4XView
	Private lblStatus As B4XView
	Private indLoading As B4XLoadingIndicator
	Private PrefDialog1 As PreferencesDialog
	Private PrefDialog2 As PreferencesDialog
	Private PrefDialog3 As PreferencesDialog
	'Dim Viewing As String
	Private UserId As Int
	Private User() As User
	Type User (Id As Long, Name As String, Email As String, Password As String)
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Web API Client")
	CreateAddDialog
	CreateEditDialog
	CreateDeleteDialog
	#if B4J
	CallSubDelayed3(Me, "SetScrollPaneBackgroundColor", clvRecord, xui.Color_Transparent)
	#End If
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	If xui.IsB4A Then
		'back key in Android
		If PrefDialog1.BackKeyPressed Then Return False
		If PrefDialog2.BackKeyPressed Then Return False
		If PrefDialog3.BackKeyPressed Then Return False
	End If
	Return True
End Sub

'Don't miss the code in the Main module + manifest editor.
Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	PrefDialog1.KeyboardHeightChanged(NewHeight)
	PrefDialog2.KeyboardHeightChanged(NewHeight)
	PrefDialog3.KeyboardHeightChanged(NewHeight)
End Sub

#If B4J
Private Sub SetScrollPaneBackgroundColor(View As CustomListView, Color As Int)
	Dim SP As JavaObject = View.GetBase.GetView(0)
	Dim V As B4XView = SP
	V.Color = Color
	Dim V As B4XView = SP.RunMethod("lookup", Array(".viewport"))
	V.Color = Color
End Sub
#End If

Private Sub B4XPage_Appear
	GetUsers
End Sub

Private Sub B4XPage_Resize(Width As Int, Height As Int)
	If PrefDialog1.IsInitialized And PrefDialog1.Dialog.Visible Then PrefDialog1.Dialog.Resize(Width, Height)
	If PrefDialog2.IsInitialized And PrefDialog2.Dialog.Visible Then PrefDialog2.Dialog.Resize(Width, Height)
	If PrefDialog3.IsInitialized And PrefDialog3.Dialog.Visible Then PrefDialog3.Dialog.Resize(Width, Height)
End Sub

#If B4J
Private Sub lblBack_MouseClicked (EventData As MouseEvent)
	GetUsers
End Sub
#Else
Private Sub lblBack_Click
	GetUsers
End Sub
#End If

Private Sub GetUsers
	Try
		Dim i As Long
		Dim sd As Object = SendData("GET", "users", Null)
		Wait For (sd) Complete (Data As Map)
		If Data.Get("s") = "ok" Then
			Dim Items As List = Data.Get("r")
			Dim User(Items.Size) As User
			For Each Item As Map In Items
				User(i).Id = Item.Get("id")
				User(i).Name = Item.Get("user_name")
				i = i + 1
			Next
			clvRecord.Clear
			For i = 0 To User.Length - 1
				clvRecord.Add(CreateUserItems(User(i).Name, clvRecord.AsView.Width), User(i).Id)
			Next
			lblTitle.Text = "User"
			lblBack.Visible = False
			'CreateAddDialog
			'CreateEditDialog
			'CreateDeleteDialog
		Else
			xui.MsgboxAsync(Data.Get("e"), "Error")
		End If
	Catch
		'Log(LastException)
		xui.MsgboxAsync(LastException.Message, "Error")
	End Try
End Sub

Private Sub btnNew_Click
	If User.Length = 0 Then Return
	Dim UserMap As Map = CreateMap("Name": "", "Email": "", "Password": "", "id": 0)
	ShowAddDialog(UserMap)
End Sub

Private Sub CreateUserItems (Name As String, Width As Double) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Width, 90dip)
	p.LoadLayout("UserItem")
	lblName.Text = Name
	Return p
End Sub

Private Sub CreateAddDialog
	PrefDialog1.Initialize(Root, "User", 300dip, 250dip)
	PrefDialog1.Dialog.OverlayColor = xui.Color_ARGB(128, 0, 10, 40)
	PrefDialog1.Dialog.TitleBarHeight = 50dip
	PrefDialog1.LoadFromJson(File.ReadString(File.DirAssets, "template_user_add.json"))
End Sub

Private Sub CreateEditDialog
	PrefDialog2.Initialize(Root, "User", 300dip, 70dip)
	PrefDialog2.Dialog.OverlayColor = xui.Color_ARGB(128, 0, 10, 40)
	PrefDialog2.Dialog.TitleBarHeight = 50dip
	PrefDialog2.LoadFromJson(File.ReadString(File.DirAssets, "template_user_edit.json"))
End Sub

Private Sub CreateDeleteDialog
	PrefDialog3.Initialize(Root, "Delete", 300dip, 70dip)
	PrefDialog3.Theme = PrefDialog3.THEME_LIGHT
	PrefDialog3.Dialog.OverlayColor = xui.Color_ARGB(128, 0, 10, 40)
	PrefDialog3.Dialog.TitleBarHeight = 50dip
	PrefDialog3.Dialog.TitleBarColor = xui.Color_RGB(220, 20, 60)
	PrefDialog3.AddSeparator("default")
End Sub

Private Sub ShowAddDialog (Item As Map)
	PrefDialog1.Dialog.TitleBarColor = xui.Color_RGB(50, 205, 50)
	PrefDialog1.Title = "Add User"
	Dim sf As Object = PrefDialog1.ShowDialog(Item, "OK", "CANCEL")
	#if B4A or B4i
	PrefDialog1.Dialog.Base.Top = 100dip ' Make it lower
	#Else
	'Dim sp As ScrollPane = PrefDialog1.CustomListView1.sv
	'sp.SetVScrollVisibility("NEVER")
	Sleep(0)
	PrefDialog1.CustomListView1.sv.Height = PrefDialog1.CustomListView1.sv.ScrollViewInnerPanel.Height + 10dip
	#End If
	' Fix Linux UI (Long Text Button)
	Dim btnCancel As B4XView = PrefDialog1.Dialog.GetButton(xui.DialogResponse_Cancel)
	btnCancel.Width = btnCancel.Width + 20dip
	btnCancel.Left = btnCancel.Left - 20dip
	btnCancel.TextColor = xui.Color_Red
	Dim btnOk As B4XView = PrefDialog1.Dialog.GetButton(xui.DialogResponse_Positive)
	btnOk.Left = btnOk.Left - 20dip
	Wait For (sf) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim UserMap As Map = CreateMap("name": Item.Get("Name"), "email": Item.Get("Email"), "password": Item.Get("Password"))
		UserMap = CreateMap("user": UserMap)
		Dim xm As Map2Xml
		xm.Initialize
		Dim sd As Object = SendData("POST", "users", xm.MapToXml(UserMap))
		Wait For (sd) Complete (Data As Map)
		If Data.Get("s") = "ok" Then
			'Log(Data.Get("a")) ' 201 Created
			Dim l As List = Data.Get("r")
			Dim m As Map = l.Get(0)
			xui.MsgboxAsync("New user created!", $"ID: ${m.Get("id")}"$)
		Else
			xui.MsgboxAsync(Data.Get("e"), "Error")
			Return
		End If
		GetUsers
	Else
		Return
	End If
End Sub

Private Sub ShowEditDialog (Item As Map)
	PrefDialog2.Dialog.TitleBarColor = xui.Color_RGB(65, 105, 225)
	PrefDialog2.Title = "Edit User"
	Dim sf As Object = PrefDialog2.ShowDialog(Item, "OK", "CANCEL")
	#if B4A or B4i
	PrefDialog2.Dialog.Base.Top = 100dip ' Make it lower
	#Else
	'Dim sp As ScrollPane = PrefDialog2.CustomListView1.sv
	'sp.SetVScrollVisibility("NEVER")
	Sleep(0)
	PrefDialog2.CustomListView1.sv.Height = PrefDialog2.CustomListView1.sv.ScrollViewInnerPanel.Height + 10dip
	#End If
	' Fix Linux UI (Long Text Button)
	Dim btnCancel As B4XView = PrefDialog2.Dialog.GetButton(xui.DialogResponse_Cancel)
	btnCancel.Width = btnCancel.Width + 20dip
	btnCancel.Left = btnCancel.Left - 20dip
	btnCancel.TextColor = xui.Color_Red
	Dim btnOk As B4XView = PrefDialog2.Dialog.GetButton(xui.DialogResponse_Positive)
	btnOk.Left = btnOk.Left - 20dip
	Wait For (sf) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim UserMap As Map = CreateMap("name": Item.Get("Name"))
		UserMap = CreateMap("user": UserMap)
		Dim xm As Map2Xml
		xm.Initialize
		Dim sd As Object = SendData("PUT", $"users/${Item.Get("id")}"$, xm.MapToXml(UserMap))
		Wait For (sd) Complete (Data As Map)
		If Data.Get("s") = "ok" Then
			xui.MsgboxAsync("User name updated!", "Edit")
		Else
			xui.MsgboxAsync(Data.Get("e"), "Error")
		End If
		GetUsers
	Else
		Return
	End If
End Sub

Private Sub ShowDeleteDialog (Item As Map, Id As Int)
	PrefDialog3.Title = "Delete User"
	Dim sf As Object = PrefDialog3.ShowDialog(Item, "OK", "CANCEL")
	#if B4A or B4i
	PrefDialog3.Dialog.Base.Top = 100dip ' Make it lower
	#Else
	' Fix Linux UI (Long Text Button)
	'Dim sp As ScrollPane = PrefDialog3.CustomListView1.sv
	'sp.SetVScrollVisibility("NEVER")
	Sleep(0)
	PrefDialog3.CustomListView1.sv.Height = PrefDialog3.CustomListView1.sv.ScrollViewInnerPanel.Height + 10dip
	#End If
	Dim btnCancel As B4XView = PrefDialog3.Dialog.GetButton(xui.DialogResponse_Cancel)
	btnCancel.Width = btnCancel.Width + 20dip
	btnCancel.Left = btnCancel.Left - 20dip
	btnCancel.TextColor = xui.Color_Red
	Dim btnOk As B4XView = PrefDialog3.Dialog.GetButton(xui.DialogResponse_Positive)
	btnOk.Left = btnOk.Left - 20dip
	PrefDialog3.CustomListView1.GetPanel(0).GetView(0).Text = Item.Get("Item")
	#If B4i
	PrefDialog3.CustomListView1.GetPanel(0).GetView(0).TextSize = 16 ' Text too small in ios
	#Else
	PrefDialog3.CustomListView1.GetPanel(0).GetView(0).TextSize = 15 ' 14
	#End If
	PrefDialog3.CustomListView1.GetPanel(0).GetView(0).Color = xui.Color_Transparent
	PrefDialog3.CustomListView1.sv.ScrollViewInnerPanel.Color = xui.Color_Transparent
	Wait For (sf) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim sd As Object = SendData("DELETE", $"users/${Id}"$, Null)
		Wait For (sd) Complete (Data As Map)
		If Data.Get("s") = "ok" Then
			xui.MsgboxAsync("User deleted!", "Delete")
		Else
			xui.MsgboxAsync(Data.Get("e"), "Error")
		End If
	Else
		Return
	End If
	GetUsers
End Sub

Private Sub btnEdit_Click
	Dim Index As Int = clvRecord.GetItemFromView(Sender)
	Dim lst As B4XView = clvRecord.GetPanel(Index)
	UserId = clvRecord.GetValue(Index)
	Dim pnl As B4XView = lst.GetView(0)
	Dim v1 As B4XView = pnl.GetView(0)
	Dim UserMap As Map = CreateMap("Name": v1.Text, "id": UserId)
	ShowEditDialog(UserMap)
End Sub

Private Sub btnDelete_Click
	Dim Index As Int = clvRecord.GetItemFromView(Sender)
	Dim Id As Int = clvRecord.GetValue(Index)
	Dim lst As B4XView = clvRecord.GetPanel(Index)
	Dim pnl As B4XView = lst.GetView(0)
	UserId = clvRecord.GetValue(Index)
	Dim v1 As B4XView = pnl.GetView(0)
	Dim M1 As Map
	M1.Initialize
	M1.Put("Item", v1.Text)
	ShowDeleteDialog(M1, Id)
End Sub

Sub SendData (Method As String, EndPoint As String, Payload As String) As ResumableSub
	Dim j As HttpJob
	Dim Data As Map
	Try
		Dim Link As String = $"${URL}${EndPoint}"$
		'Log("Link:" & Link)
		indLoading.Show
		j.Initialize("", Me)
		Select Method.ToUpperCase
			Case "POST"
				j.PostString(Link, Payload)
			Case "PUT"
				j.PutString(Link, Payload)
			Case "DELETE"
				j.Delete(Link)
			Case Else ' GET
				j.Download(Link)
		End Select
		Wait For (j) JobDone(j As HttpJob)
		If j.Success Then
			Log(j.GetString)
			Data = j.GetString.As(JSON).ToMap 'ignore
			Data.Put("a", j.Response.StatusCode)
			#if B4J
			lblStatus.Text = "Connected to " & URL
			#Else
			lblStatus.Text = "Connected to " & CRLF & URL
			#End If
			lblStatus.TextColor = xui.Color_White
		Else
			If j.ErrorMessage.Contains($""s": "error""$) Then
				Data = j.ErrorMessage.As(JSON).ToMap 'ignore
				Data.Put("a", j.Response.StatusCode)
			Else
				Data = CreateMap("s": "error", "e": j.ErrorMessage, "m": "")
				Data.Put("a", j.Response.StatusCode)
				#if B4J
				lblStatus.Text = "Connection to " & URL & " failed"
				#Else
				lblStatus.Text = "Connection failed:" & CRLF & URL
				#End If
				lblStatus.TextColor = xui.Color_Red
			End If
		End If
	Catch
		Log(LastException.Message)
		Data = CreateMap("s": "error", "e": LastException.Message, "m": "")
		Data.Put("a", 0)
		lblStatus.Text = "Error: " & LastException.Message
		lblStatus.TextColor = xui.Color_Red
	End Try
	j.Release
	indLoading.Hide
	Return Data
End Sub