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
	Private ASSwipeCard1 As ASSwipeCard
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	ASSwipeCard1.IniParent(Root)
	
	For i = 0 To 10 -1
	
		Dim xpnl_cardbase As B4XView = CreateLabel("")'xui.CreatePanel("")
		xpnl_cardbase.SetLayoutAnimated(0,0,0,ASSwipeCard1.Base.Width,ASSwipeCard1.Base.Height)
		xpnl_cardbase.SetColorAndBorder(xui.Color_ARGB(255,Rnd(1,254), Rnd(1,254), Rnd(1,254)),0,0,10dip)'xui.Color_ARGB(255,43, 134, 117)
		xpnl_cardbase.Text = "Item #" & i
		xpnl_cardbase.SetTextAlignment("CENTER","CENTER")
		xpnl_cardbase.TextColor = xui.Color_White
		xpnl_cardbase.Font = xui.CreateDefaultBoldFont(20)
		ASSwipeCard1.AddCard(xpnl_cardbase,"")
	Next
	
	'Sleep(2000)
	'ASSwipeCard1.CurrentIndex = ASSwipeCard1.Size -1
	
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	ASSwipeCard1.Base_Resize(Width,Height)
End Sub

Sub ASSwipeCard1_SwipeStateChanged(state As Int)
	If state = ASSwipeCard1.SwipeState_NEUTRAL Then
		Log("SwipeStateChanged: Neutral")
	else If state = ASSwipeCard1.SwipeState_TOP Then
		Log("SwipeStateChanged: Top")
	else If state = ASSwipeCard1.SwipeState_BOTTOM Then
		Log("SwipeStateChanged: Bottom")
	else If state = ASSwipeCard1.SwipeState_LEFT Then
		Log("SwipeStateChanged: Left")
	else If state = ASSwipeCard1.SwipeState_RIGHT Then
		Log("SwipeStateChanged: Right")
	End If
End Sub

Private Sub ASSwipeCard1_SwipeStateChange(state As Int)
	If state = ASSwipeCard1.SwipeState_NEUTRAL Then
		Log("SwipeStateChange: Neutral")
	else If state = ASSwipeCard1.SwipeState_TOP Then
		Log("SwipeStateChange: Top")
	else If state = ASSwipeCard1.SwipeState_BOTTOM Then
		Log("SwipeStateChange: Bottom")
	else If state = ASSwipeCard1.SwipeState_LEFT Then
		Log("SwipeStateChange: Left")
	else If state = ASSwipeCard1.SwipeState_RIGHT Then
		Log("SwipeStateChange: Right")
	End If
End Sub

Sub ASSwipeCard1_IndexChanged(index As Int)
	Log("Index: " & index)
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim xlbl As Label
	xlbl.Initialize(EventName)
	Return xlbl
End Sub

#IF B4J
Private Sub xlbl_prev_MouseClicked (EventData As MouseEvent)
	ASSwipeCard1.PreviousCard(ASSwipeCard1.SwipeStateRandom)
End Sub

Private Sub xlbl_next_MouseClicked (EventData As MouseEvent)
	ASSwipeCard1.NextCard(ASSwipeCard1.SwipeStateRandom)
End Sub

Private Sub xlbl_firstcard_MouseClicked (EventData As MouseEvent)
	ASSwipeCard1.CurrentIndex = 0
End Sub
#Else
Sub xlbl_next_Click
	ASSwipeCard1.NextCard(ASSwipeCard1.SwipeStateRandom)
End Sub

Sub xlbl_prev_Click
	ASSwipeCard1.PreviousCard(ASSwipeCard1.SwipeStateRandom)
End Sub

Sub xlbl_firstcard_Click
	ASSwipeCard1.CurrentIndex = 0
End Sub
#End If
