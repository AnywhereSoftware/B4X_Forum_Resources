B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Public txtUser As B4XFloatTextField
	Private btnLogin As B4XView
	Public Page2 As B4XPage2
	Public Page3 As B4XPage3
	
	Dim Drawer As B4XDrawer
	Private btnDrawer As Button
	Private lviewDrawer As ListView
	Private pnlDrawer As Panel
	
	Private pmgr As B4XPagesManager 'ignore
End Sub

'You can add more parameters here.
Public Sub Initialize
	pmgr  =  B4XPages.GetManager	
	B4XPages.GetManager.TransitionAnimationDuration = 0
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	'Root.LoadLayout("Login")
	
	Drawer.Initialize(Me, "Drawer", Root, 200dip)
	Drawer.CenterPanel.LoadLayout("Login")
	Drawer.LeftPanel.LoadLayout("left")
	For i = 1 To 10
		lviewDrawer.AddSingleLine("Main " & i)
	Next
	
	Page2.Initialize
	B4XPages.AddPage("Page 2", Page2)
	Page3.Initialize
	B4XPages.AddPage("Page 3", Page3)			
	
	Dim Screen As LayoutValues = GetDeviceLayoutValues
	Dim Width As Int = Screen.Width
	Dim Height As Int = Screen.Height
	Log("LayoutValues Width x Height = " & Width & " x " & Height)
	Log("LayoutValues.Scale = " & Screen.Scale)
	Log("LayoutValues.ApproximateScreenSize = " & Screen.ApproximateScreenSize)
	Log("100%x = " & 100%x)	

	Dim rp As RuntimePermissions
	rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	Log(Permission & " : " & Result)
	Log(File.DirRootExternal) ' needed for permission

End Sub

Sub btnLogin_Click
	B4XPages.ShowPage("Page 2")
End Sub

Sub txtUser_TextChanged (Old As String, New As String)
	btnLogin.Enabled = New.Length > 0
End Sub

Sub txtUser_EnterPressed
	If btnLogin.Enabled Then btnLogin_Click
End Sub


' Events

Sub btnSet_Click
	B4XPages.ClosePage(Me)
End Sub

Sub btnDrawer_Click
	Log("Button")
	Drawer.LeftOpen = False
End Sub

Sub lviewDrawer_ItemClick (Position As Int, Value As Object)
	Log("Listview " & Position & " " & Value)
	Drawer.LeftOpen = False	
End Sub


'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub B4XPage_Appear
	Log("MainPage Appeared")
End Sub

Sub B4XPage_Disappear
	Log("MainPage Disappeared")	
End Sub

Sub B4XPage_Foreground
	Log("MainPage Foreground")	
End Sub

Sub B4XPage_Background
	Log("MainPage Background")	
End Sub


'Return True to close, False to cancel
Private Sub B4XPage_CloseRequest As ResumableSub
	Log("MainPage CloseRequest")
	If Drawer.LeftOpen Then
		Drawer.LeftOpen = False		
		Return False
	End If
	Dim sf As Object = xui.Msgbox2Async("Close?", "Title", "Yes", "Cancel", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	Log(Result)
	If Result = xui.DialogResponse_Positive Then
		Return True
	End If
	Return False
End Sub

