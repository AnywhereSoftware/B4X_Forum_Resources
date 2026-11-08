B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.8
@EndOfDesignText@
'Code module

Sub Process_Globals
	Private Page1 As Page
	Private xui As XUI
	Public statusLbl As Label
	Private connectedList As TableView
End Sub

Public Sub ShowPage
	Page1.Initialize("Page1")
	Page1.RootPanel.LoadLayout("Home")
	Main.NavControl.ShowPage(Page1)
	update_user_list
	'Main.socket.DebugLog(True)
	Main.socket.connect("http://35.154.181.92:5555/",Null,False)
	'Main.socket.connect("http://192.168.0.111:5555/",null,False)
End Sub

Sub update_status(status As String)
	statusLbl.text = "Status: "&status
End Sub

Sub update_user_list
	connectedList.Clear
	For Each uid As String In Main.connectedUsers
		If uid <> Main.myID Then connectedList.AddTwoLines(uid,"Click to call")
	Next
	connectedList.ReloadAll
End Sub

Sub connectedList_SelectedChanged (SectionIndex As Int, Cell As TableCell)
	connectedList.SetSelection(0,-1)
	CallPage.callType = "out"
	CallPage.peerId = Cell.Text.ToString
	CallPage.ShowPage
End Sub