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
	Private xlbl_open As B4XView
	
	Private aspm_main As ASPopupMenu
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If

	aspm_main.Initialize(Root,Me,"aspm_main")
	aspm_main.ActivityHasActionBar = True
	
	aspm_main.OrientationVertical = aspm_main.OrientationVertical_BOTTOM
	
	aspm_main.ItemLabelProperties.BackgroundColor = xui.Color_ARGB(152,0,0,0)'black
	
	aspm_main.DividerEnabled = True
	aspm_main.DividerHeight = 2dip
	aspm_main.DividerColor = xui.Color_White
	
	aspm_main.TitleLabelProperties.BackgroundColor = xui.Color_White
	aspm_main.TitleLabelProperties.TextColor = xui.Color_Black
	aspm_main.AddTitle("Title",60dip)

	aspm_main.MenuCornerRadius = 10dip
	
	For i = 0 To 4 -1
		aspm_main.ItemLabelProperties.ItemBackgroundColor = xui.Color_ARGB(255,Rnd(1,256), Rnd(1,256), Rnd(1,256))
		aspm_main.AddMenuItem("Test_" & (i +1),"item_" & i)
	Next
	
End Sub

#If B4J
Sub xlbl_open_MouseClicked (EventData As MouseEvent)
	
	aspm_main.MenuViewGap = aspm_main.TriangleProperties.Height + 2dip
	aspm_main.ShowTriangle = True
	aspm_main.TriangleProperties.Left = 100dip/2 - aspm_main.TriangleProperties.Width/2
	
	aspm_main.OpenMenu(xlbl_open,100dip)
End Sub
#Else
Sub xlbl_open_Click

	aspm_main.MenuViewGap = aspm_main.TriangleProperties.Height + 2dip
	aspm_main.ShowTriangle = True
	aspm_main.TriangleProperties.Left = 100dip/2 - aspm_main.TriangleProperties.Width/2

	aspm_main.OpenMenu(xlbl_open,100dip)
End Sub
#End If

Private Sub aspm_main_ItemClicked(Index As Int,Tag As Object)
	Log(Index)
	Log(Tag)
End Sub

#If B4J
Sub xlbl_open_middle_MouseClicked (EventData As MouseEvent)
	aspm_main.OpenMenu2(Root,100dip)
	Sleep(0)
	aspm_main.MenuCornerRadius = 15dip
End Sub
#Else
Sub xlbl_open_middle_Click
	aspm_main.OpenMenu2(Root,100dip)
End Sub
#End If