B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=13.4
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Private xui As XUI
End Sub

Sub Globals
	Private bar As StdActionBar
	Private lblCount As Label
	Private clvUsers As CustomListView
	Private lblName As Label
	Private lblEmail As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	bar.Initialize("")
	bar.NavigationMode = bar.NAVIGATION_MODE_STANDARD
	bar.ShowUpIndicator = True
	
	Activity.AddMenuItem3("Add","Add",Utils.FontToBitmap(Chr(0xE145),28,0xFFD5E9FF),True)
	Activity.AddMenuItem3("Refresh","Refresh",Utils.FontToBitmap(Chr(0xE5D5),28,0xFFD5E9FF),True)
	Activity.LoadLayout("User_List")
	Activity.Title = "User List"
End Sub

Sub Activity_Resume
	LoadUsers
	lblCount.Text = clvUsers.Size & " records"
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub Activity_ActionBarHomeClick
	Activity.Finish
End Sub


Sub LoadUsers
	clvUsers.Clear
	Dim users As List = DBCalls.GetAllUsers
	For Each user As Map In users
		Dim id As Int = user.Get("id")
		clvUsers.Add(CreateUserRow(user),id)
	Next
	clvUsers.JumpToItem(0)
End Sub

Sub CreateUserRow(user As Map) As B4XView
	Dim pTemp As B4XView = xui.CreatePanel("")
	pTemp.SetLayoutAnimated(0,20dip,0dip,100%x - 20dip,100%y)
	pTemp.LoadLayout("User_Detail")
	
	Dim p2 As Panel = pTemp.GetView(0)
	Dim pHeight As Int = p2.Height
	pTemp.RemoveAllViews
	
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0,20dip,0dip,100%x - 30dip,pHeight)
	p.LoadLayout("User_Detail")
	
	Dim uname As String = user.Get("username")
	Dim email As String = user.Get("email")
	Dim isAdmin As Boolean = user.Get("is_admin")
	
	lblName.Text = uname & IIf(isAdmin," (Admin)","")
	lblEmail.Text = email
	
	Return p
End Sub

Sub Add_Click
	Starter.SelectedUserId = -1
	StartActivity(UserEdit)
End Sub

Sub Refresh_Click
	LoadUsers
End Sub


Private Sub clvUsers_ItemClick (Index As Int,Value As Object)
	Dim id As Int = Value
	Starter.SelectedUserId = id
	StartActivity(UserEdit)
End Sub


