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
	
	Private aspm_Main As ASPopupMenu
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
End Sub


#If B4J
Private Sub xlbl_open_MouseClicked (EventData As MouseEvent)
	ShowMenu
End Sub
#Else
Private Sub xlbl_open_Click
	ShowMenu
End Sub
#End If

Private Sub ShowMenu
	
	aspm_Main.Initialize(Root,Me,"aspm_Main")
 
	aspm_Main.MenuCornerRadius = 10dip
	aspm_Main.ItemLabelProperties.TextAlignment_Horizontal = aspm_Main.OrientationHorizontal_LEFT
	aspm_Main.ItemLabelProperties.LeftRightPadding = 10dip
 
	aspm_Main.IconProperties.HorizontalAlignment = aspm_Main.OrientationHorizontal_RIGHT
 
	aspm_Main.AddMenuItemWithIcon("Item #1",aspm_Main.FontToBitmap(Chr(0xE3C9),True,20,xui.Color_White),"Item1")
	aspm_Main.AddMenuItemWithIcon("Item #2",aspm_Main.FontToBitmap(Chr(0xE192),True,20,xui.Color_White),"Item2")
 
	aspm_Main.ItemLabelProperties.BackgroundColor = xui.Color_ARGB(200,0,0,0)'black
 
	aspm_Main.OpenMenuAdvanced(Root.Width/2 - 200dip/2,Root.Height/2 - aspm_Main.MenuHeight/2,200dip)

	Wait For aspm_Main_ItemClicked(Index As Int,Tag As Object)
	
	Select Tag.As(String)
		Case "Item1"
			
		Case "Item2"

	End Select
	
End Sub
