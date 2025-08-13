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
	
	Private FloatingActionMenu As AS_FloatingActionMenu
	
	Private xlbl_OpenMenuDark As B4XView
	Private xlbl_OpenMenuLight As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
End Sub

Private Sub OpenDarkMenu
	
	FloatingActionMenu.Initialize(Me,"FloatingActionMenu",Root)
	
	FloatingActionMenu.Color = xui.Color_ARGB(255,32, 33, 37)
	FloatingActionMenu.TextColor = xui.Color_White
	FloatingActionMenu.ItemProperties.SeperatorVisible = True

'	FloatingActionMenu.AddItem("Item #1",Null,0)
'	FloatingActionMenu.AddItem("Item #2",Null,1)
'	FloatingActionMenu.AddItem("Item #3",Null,2)
	
	FloatingActionMenu.AddItem("Item #1",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),0)
	FloatingActionMenu.AddItem("Item #2",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),1)
	FloatingActionMenu.AddItem("Item #3",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),2)
	
	Dim Height As Float = FloatingActionMenu.ItemProperties.Height*FloatingActionMenu.Size
	Dim Left As Float = xlbl_OpenMenuDark.Left + xlbl_OpenMenuDark.Width + 10dip
	Dim Top As Float = xlbl_OpenMenuDark.Top + xlbl_OpenMenuDark.Height/2 - Height/2
	
	FloatingActionMenu.ShowPicker(Left,Top,200dip,Height)
	
	Wait For FloatingActionMenu_ItemClicked(Item As AS_FloatingActionMenu_Item)
	
	Select Item.Value
		Case 0
			Log(Item.Text & " clicked")
		Case 1
			Log(Item.Text & " clicked")
		Case 2
			Log(Item.Text & " clicked")
	End Select
	
End Sub

Private Sub OpenLightMenu
	
	FloatingActionMenu.Initialize(Me,"FloatingActionMenu",Root)
	
	FloatingActionMenu.Color = xui.Color_White
	FloatingActionMenu.TextColor = xui.Color_Black
	FloatingActionMenu.ItemProperties.SeperatorVisible = True

'	FloatingActionMenu.AddItem("Item #1",Null,0)
'	FloatingActionMenu.AddItem("Item #2",Null,1)
'	FloatingActionMenu.AddItem("Item #3",Null,2)
	
	FloatingActionMenu.AddItem("Item #1",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),0)
	FloatingActionMenu.AddItem("Item #2",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),1)
	FloatingActionMenu.AddItem("Item #3",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),2)
	
	Dim Height As Float = FloatingActionMenu.ItemProperties.Height*FloatingActionMenu.Size
	Dim Left As Float = xlbl_OpenMenuLight.Left + xlbl_OpenMenuLight.Width + 10dip
	Dim Top As Float = xlbl_OpenMenuLight.Top + xlbl_OpenMenuLight.Height/2 - Height/2
	
	FloatingActionMenu.ShowPicker(Left,Top,200dip,Height)
	
	Wait For FloatingActionMenu_ItemClicked(Item As AS_FloatingActionMenu_Item)
	
	Select Item.Value
		Case 0
			Log(Item.Text & " clicked")
		Case 1
			Log(Item.Text & " clicked")
		Case 2
			Log(Item.Text & " clicked")
	End Select
	
End Sub

Private Sub FloatingActionMenu_MenuClosed
	Log("Menu closed")
End Sub

#IF B4J
Private Sub xlbl_OpenMenuDark_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenMenuDark_Click
#End If
	
	OpenDarkMenu
End Sub

#IF B4J
Private Sub xlbl_OpenMenuLight_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenMenuLight_Click
#End If
	
	OpenLightMenu
End Sub