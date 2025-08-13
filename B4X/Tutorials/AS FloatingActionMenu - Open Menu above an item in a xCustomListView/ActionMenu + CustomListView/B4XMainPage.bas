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
	Private CustomListView1 As CustomListView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"ActionMenu + CustomListView Example")
	
	For i = 0 To 50 -1
		
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.SetLayoutAnimated(0,0,0,Root.Width,50dip)
		xpnl.LoadLayout("frm_Item")
		xpnl.GetView(0).Text = "Item #" & (i+1)
		CustomListView1.Add(xpnl,"")
		
	Next
	
End Sub

#If B4J
Private Sub xlbl_Options_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Options_Click
#End If
	OpenDarkMenu(Sender)
End Sub

Private Sub OpenDarkMenu(TargetView As B4XView)
	FloatingActionMenu.Initialize(Me,"FloatingActionMenu",Root)
	FloatingActionMenu.OpenOrientation = FloatingActionMenu.OpenOrientation_RightBottom
	FloatingActionMenu.Color = xui.Color_ARGB(255,32, 33, 37)
	FloatingActionMenu.TextColor = xui.Color_White
	FloatingActionMenu.ItemProperties.SeperatorVisible = True
   
	FloatingActionMenu.AddItem("Item #1",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),0)
	FloatingActionMenu.AddItem("Item #2",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),1)
	FloatingActionMenu.AddItem("Item #3",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),2)
   
	Dim Height As Float = FloatingActionMenu.ItemProperties.Height*FloatingActionMenu.Size 'Action Menu Height
	Dim Width As Float = 250dip 'Action Menu Width
	Dim Left As Float = TargetView.Left + TargetView.Width/2 - Width 'To the left of the target item
	
	Dim RawListItem As CLVItem = CustomListView1.GetRawListItem(CustomListView1.GetItemFromView(TargetView)) 'Gets the raw list item
	Dim Top As Float = CustomListView1.AsView.Top + (RawListItem.Offset - CustomListView1.sv.ScrollViewOffsetY) + RawListItem.Panel.Height 'Calculates the right height
	If Top + Height > Root.Height Then 'If the menu no longer fits on the screen, display the menu above the list item
		Top = Top - Height - 80dip + 20dip
	End If
   
	FloatingActionMenu.ShowPicker(Left,Top,Width,Height)
   
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
