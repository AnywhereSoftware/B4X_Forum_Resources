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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=CLVSwipeExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Swipe As CLVSwipe
	Private CustomListView1 As CustomListView
	Private ProgressBar1 As B4XView
	Private lblPullToRefresh As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	Swipe.Initialize(CustomListView1, Me, "Swipe")
	Swipe.ActionColors = CreateMap("Delete": xui.Color_Red, "Do Something Else": xui.Color_Green, _
		"Action 1": xui.Color_Red, "Action 2": xui.Color_Blue, "Action 3": xui.Color_Yellow)
	Dim PullToRefreshPanel As B4XView = xui.CreatePanel("")
	PullToRefreshPanel.SetLayoutAnimated(0, 0, 0, 100%x, 70dip)
	PullToRefreshPanel.LoadLayout("PullToRefresh")
	Swipe.PullToRefreshPanel = PullToRefreshPanel
	CustomListView1.DefaultTextColor = xui.Color_Black
	CustomListView1.DefaultTextBackgroundColor = xui.Color_White
	CreateItems
	#if B4A
	B4XPages.AddMenuItem(Me, "Toggle Scrolling")
	#end if
End Sub

Sub B4XPage_MenuClick (Tag As String)
	If Tag = "Toggle Scrolling" Then
		Swipe.ScrollingEnabled = Not(Swipe.ScrollingEnabled)
	End If
End Sub


Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Swipe.CloseLastSwiped
End Sub

Sub CustomListView1_ScrollChanged (Offset As Int)
	If xui.IsB4i Then
		Swipe.ScrollChanged(Offset)
	End If
	Swipe.CloseLastSwiped
End Sub

Sub Swipe_ActionClicked (Index As Int, ActionText As String)
	Log($"Action clicked: ${Index}, ${ActionText}"$)
	If ActionText = "Delete" Then
		CustomListView1.RemoveAt(Index)
	Else If ActionText = "Do Something Else" Then
		Dim p As B4XView = CustomListView1.GetPanel(Index)
		Dim lbl As B4XView = p.GetView(0)
		lbl.Text = "Done!!!"
	End If
End Sub

Sub Swipe_RefreshRequested
	lblPullToRefresh.Text = "Loading..."
	ProgressBar1.Visible = True
	'example!!!
	Sleep(3000)
	CustomListView1.Clear
	CreateItems
	
	Swipe.RefreshCompleted '<-- call to exit refresh mode
	lblPullToRefresh.Text = "Pull to refresh"
	ProgressBar1.Visible = False
End Sub

Sub CreateItems
	Dim cs As CSBuilder
	For i = 1 To 100
		cs.Initialize.Color(Rnd(0xff000000, -1))
		If i Mod 3 = 0 Then
			cs.Append($"Important item ${i} ..."$).PopAll
			CustomListView1.AddTextItem(cs, Swipe.CreateItemValue("", Array("Delete", "Do Something Else")))
		Else If i Mod 3 = 1 Then
			cs.Append($"Very important item ${i} ..."$).PopAll
			CustomListView1.AddTextItem(cs, Swipe.CreateItemValue("", Array("Action 1", "Action 2", "Action 3")))
		Else
			cs.Append($"Nothing to see here ${i}"$).PopAll
			CustomListView1.AddTextItem(cs, Null)
		End If
	Next
End Sub