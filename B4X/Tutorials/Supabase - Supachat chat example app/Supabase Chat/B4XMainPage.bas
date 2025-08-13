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
	Private xclv_ChatRooms As CustomListView
	Private xlbl_AddRoom As B4XView
	Private Dialog As B4XDialog
	Public xSupabase As Supabase
	
	Private p_Chat As b4xp_Chat
	Private p_Login As b4xp_Login
End Sub

Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.AddPage("b4xp_Chat",p_Chat.Initialize)
	B4XPages.AddPage("b4xp_Login",p_Login.Initialize)
	
	B4XPages.SetTitle(Me,"Supachat")
	
	xSupabase.Initialize("https://xxx.supabase.co","xxx")
	xSupabase.InitializeEvents(Me,"Supabase")
	
	Dialog.Initialize(Root)
	
'	Wait For (xSupabase.Auth.Logout) Complete (Result As SupabaseError)
'	If Result.Success Then
'		Log("User successfully logged out")
'	Else
'		Log("Error: " & Result.ErrorMessage)
'	End If
'	
	Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)
	
	If isLoggedIn = False Then
	
		B4XPages.ShowPage("b4xp_Login")
	
	End If
	
	#If B4A or B4J
	B4XPage_Resize(Root.Width,Root.Height)
	#End If
	
End Sub

Private Sub B4XPage_Appear
	GetRooms
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
	xlbl_AddRoom.SetLayoutAnimated(0,Width/2 - xlbl_AddRoom.Width/2,Height - xlbl_AddRoom.Height - 10dip,xlbl_AddRoom.Width,xlbl_AddRoom.Height)
	#If B4I
	xlbl_AddRoom.Top = Height - xlbl_AddRoom.Height - 0dip - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom
	#End If
	
End Sub

Private Sub GetRooms
	
	Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)
	If isLoggedIn = False Then Return
	
	Dim Query As Supabase_DatabaseSelect = xSupabase.Database.SelectData
	Query.Columns("*").From("dt_Rooms")
	Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)
	'xSupabase.Database.PrintTable(DatabaseResult)
	
	xclv_ChatRooms.Clear
	
	For Each Row As Map In  DatabaseResult.Rows
		
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.SetLayoutAnimated(0,0,0,Root.Width,50dip)
		xpnl.LoadLayout("frm_RoomItem1")
		
		Dim xlbl_RoomName As B4XView = xpnl.GetView(0)
		xlbl_RoomName.Text = Row.Get("name")
		
		xclv_ChatRooms.Add(xpnl,CreateMap("RoomId":Row.Get("id"),"RoomName":Row.Get("name")))
		
	Next
	
End Sub

#If B4J
Private Sub xlbl_AddRoom_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_AddRoom_Click
#End If
	Dim input As B4XInputTemplate
	input.Initialize
	input.lblTitle.Text = "Chatroom Name"
	Dialog.PutAtTop = True
	Wait For (Dialog.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		'Log(input.Text)
		Dim Insert As Supabase_DatabaseInsert = xSupabase.Database.InsertData
		Insert.From("dt_Rooms")	
		Wait For (Insert.Insert(CreateMap("name":input.Text)).Upsert.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)
		
		If DatabaseResult.Error.Success Then
			GetRooms
			Else
				Log("Error")
		End If
		
	End If
End Sub

Private Sub xclv_ChatRooms_ItemClick (Index As Int, Value As Object)
	B4XPages.ShowPage("b4xp_Chat")
	Dim m_Values As Map = Value
	p_Chat.ShowDialog(m_Values.Get("RoomId"),m_Values.Get("RoomName"))
End Sub