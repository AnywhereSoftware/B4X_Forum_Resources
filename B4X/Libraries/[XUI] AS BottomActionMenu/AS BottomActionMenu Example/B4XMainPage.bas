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
	
	Private BottomActionMenu As AS_BottomActionMenu
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomActionMenu Example")
	
End Sub

Private Sub OpenDark
	
	BottomActionMenu.Initialize(Me,"BottomActionMenu",Root)
	
	BottomActionMenu.Color = xui.Color_ARGB(255,32, 33, 37)
	BottomActionMenu.DragIndicatorColor = xui.Color_White
	BottomActionMenu.ItemProperties.TextColor = xui.Color_White
	
	BottomActionMenu.AddItem("WhatsApp",BottomActionMenu.FontToBitmap(Chr(0xF232),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("Twitter",BottomActionMenu.FontToBitmap(Chr(0xF099),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("Instagram",BottomActionMenu.FontToBitmap(Chr(0xF16D),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("Snapchat",BottomActionMenu.FontToBitmap(Chr(0xF2AC),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("YouTube",BottomActionMenu.FontToBitmap(Chr(0xF16A),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("Stackoverflow",BottomActionMenu.FontToBitmap(Chr(0xF16C),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	
	BottomActionMenu.ShowPicker
	
End Sub

Private Sub OpenLight
	
	BottomActionMenu.Initialize(Me,"BottomActionMenu",Root)
	
	BottomActionMenu.Color = xui.Color_White
	BottomActionMenu.DragIndicatorColor = xui.Color_Black
	BottomActionMenu.ItemProperties.TextColor = xui.Color_Black
	
	BottomActionMenu.AddItem("WhatsApp",BottomActionMenu.FontToBitmap(Chr(0xF232),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("Twitter",BottomActionMenu.FontToBitmap(Chr(0xF099),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("Instagram",BottomActionMenu.FontToBitmap(Chr(0xF16D),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("Snapchat",BottomActionMenu.FontToBitmap(Chr(0xF2AC),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("YouTube",BottomActionMenu.FontToBitmap(Chr(0xF16A),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	BottomActionMenu.AddItem("Stackoverflow",BottomActionMenu.FontToBitmap(Chr(0xF16C),False,30,BottomActionMenu.ItemProperties.TextColor),"")
	
	BottomActionMenu.ShowPicker
	
	
End Sub

Private Sub BottomActionMenu_ItemClick (Index As Int, Value As Object)
	Log("Item Clicked: " & Index)
End Sub

#If B4J
Private Sub xlbl_OpenDark_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenDark_Click
#End If
	OpenDark
End Sub

#If B4J
Private Sub xlbl_OpenLight_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenLight_Click
#End If
	OpenLight
End Sub


Private Sub B4XPage_CloseRequest As ResumableSub

	If BottomActionMenu.isOpen Then
		BottomActionMenu.HidePicker
		Return False
	End If
Return True
End Sub