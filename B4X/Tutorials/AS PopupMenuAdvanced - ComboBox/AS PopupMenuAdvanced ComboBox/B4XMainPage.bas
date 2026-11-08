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
	
	Private aspma_Main As ASPopupMenuAdvanced

	Private xpnlComboBox As B4XView
	Private xlblText As B4XView
	Private xlblIcon As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	xpnlComboBox.Left = Width/2 - xpnlComboBox.Width/2 'Center the view
	#Else
	xpnlComboBox.Left = Root.Width/2 - xpnlComboBox.Width/2 'Center the view
	#End If


	aspma_Main.Initialize(Root,Me,"aspma_Main")
	aspma_Main.CornerRadius = 10dip
	aspma_Main.MenuViewGap = 5dip
	
End Sub

#If B4J
Private Sub xpnlComboBox_MouseClicked (EventData As MouseEvent)
	OpenMenuOnView
End Sub
#Else
Private Sub xpnlComboBox_Click
	OpenMenuOnView
End Sub
#End If


Private Sub OpenMenuOnView
	aspma_Main.ActivityHasActionBar = True	
	aspma_Main.OrientationVertical = aspma_Main.OrientationVertical_BOTTOM
	
	aspma_Main.SeparatorProperties.BackgroundColor = xui.Color_ARGB(255,255,255,255)'white
	aspma_Main.SeparatorProperties.Height = 1dip
	
	aspma_Main.Clear
	
	For i = 0 To 20 -1
		
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.SetLayoutAnimated(0,0,0,150dip,40dip)
		xpnl.LoadLayout("frm_Item1")
		
		xpnl.GetView(0).Text = "Option " & (i +1)
		
		aspma_Main.AddItem(xpnl,"")
		If i <> 19 Then aspma_Main.AddSeparator
	Next
	
	xlblIcon.SetRotationAnimated(500,180)
	aspma_Main.OpenMenuOnView(xpnlComboBox,xpnlComboBox.Width,200dip)
End Sub

Private Sub aspma_Main_ItemClick(Index As Int,Tag As Object)
	aspma_Main.CloseMenu
	xlblText.Text = aspma_Main.CustomListView.GetPanel(Index).GetView(0).Text
End Sub

Private Sub aspma_Main_MenuClosed
	xlblIcon.SetRotationAnimated(500,1)
	Sleep(500)
	xlblIcon.Rotation = 0
End Sub