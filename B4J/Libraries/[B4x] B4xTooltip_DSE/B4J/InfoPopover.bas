B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
' Class Module: GlobalInfoPopover
Sub Class_Globals
	Private xui As XUI
	Private OverlayPanel As B4XView
	Private ContentCard As B4XView
	Private TextLabel As B4XView
	Private AutoDismissTimer As Timer
	Private IsShowing As Boolean = False
End Sub

' Initialize ONCE against the root activity/view container
Public Sub Initialize(RootContainer As B4XView)
	OverlayPanel = xui.CreatePanel("OverlayPanel")
	OverlayPanel.Color = xui.Color_ARGB(60, 0, 0, 0)
	
	ContentCard = xui.CreatePanel("ContentCard")
	ContentCard.SetColorAndBorder(xui.Color_RGB(50, 50, 50), 1dip, xui.Color_White, 8dip)
	
	Dim lbl As Label
	lbl.Initialize("")
	TextLabel = lbl
	TextLabel.TextColor = xui.Color_White
	TextLabel.TextSize = 14
	TextLabel.SetTextAlignment("CENTER", "CENTER")
	
	ContentCard.AddView(TextLabel, 10dip, 10dip, 180dip, 60dip)
	OverlayPanel.AddView(ContentCard, 0, 0, 200dip, 80dip)
	
	AutoDismissTimer.Initialize("AutoDismissTimer", 4000)
	
	RootContainer.AddView(OverlayPanel, 0, 0, RootContainer.Width, RootContainer.Height)
	OverlayPanel.Visible = False
End Sub

Public Sub Show(TargetView As B4XView, Message As String)
	If IsShowing Then Dismiss
	TextLabel.Text = Message
	
	' Get absolute screen coordinates of the target view via JavaObject
	Dim ScreenLoc(2) As Int
	Dim jo As JavaObject = TargetView
	#If B4a
	jo.RunMethod("getLocationOnScreen", Array(ScreenLoc))
	#End If
	#If B4J
	Dim Bounds As JavaObject = jo.RunMethod("localToScene",Array(jo.RunMethod("getBoundsInLocal")))
	ScreenLoc(0) = Bounds.RunMethod("getMinX")
	ScreenLoc(1) = Bounds.RunMethod("getMinY")
	#End If
	
	' Also get root container location to handle relative offsets if needed
	Dim RootLoc(2) As Int
	Dim rootJo As JavaObject = OverlayPanel
	#if B4a
	rootJo.RunMethod("getLocationOnScreen", Array(RootLoc))
	#End If
	#If B4J
	Dim Bounds As JavaObject = rootJo.RunMethod("localToScene",Array(jo.RunMethod("getBoundsInLocal")))
	RootLoc(0) = Bounds.RunMethod("getMinX")
	RootLoc(1) = Bounds.RunMethod("getMinY")
	#End If
	' Calculate absolute position relative to the root overlay container
	Dim ViewAbsX As Int = ScreenLoc(0) - RootLoc(0)
	Dim ViewAbsY As Int = ScreenLoc(1) - RootLoc(1)
	
	' Position card centered below the target view
	Dim LeftPos As Int = ViewAbsX + (TargetView.Width / 2) - (ContentCard.Width / 2)
	Dim TopPos As Int = ViewAbsY + TargetView.Height + 6dip
	
	' Keep within screen bounds
	LeftPos = Max(10dip, Min(LeftPos, OverlayPanel.Width - ContentCard.Width - 10dip))
	If TopPos + ContentCard.Height > OverlayPanel.Height - 10dip Then
		TopPos = ViewAbsY - ContentCard.Height - 6dip
	End If
	
	ContentCard.Left = LeftPos
	ContentCard.Top = TopPos
	
	OverlayPanel.Visible = True
	IsShowing = True
	AutoDismissTimer.Enabled = True
End Sub

Public Sub Dismiss
	If Not(IsShowing) Then Return
	AutoDismissTimer.Enabled = False
	OverlayPanel.Visible = False
	IsShowing = False
End Sub

#If B4a
Private Sub OverlayPanel_Click
#else #if B4J
Private Sub OverlayPanel_MouseClicked (EventData As MouseEvent)
#End If
	Dismiss
End Sub

Private Sub AutoDismissTimer_Tick
	Dismiss
End Sub