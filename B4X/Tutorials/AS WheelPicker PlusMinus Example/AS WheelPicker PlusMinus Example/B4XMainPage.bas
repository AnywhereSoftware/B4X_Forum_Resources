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
	Private ASWheelPicker1 As ASWheelPicker
	
	Private xlbl_up_1 As B4XView
	Private xlbl_up_2 As B4XView
	Private xlbl_down_1 As B4XView
	Private xlbl_down_2 As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS WheelPicker PlusMinus Example")
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
    #End If
	
	'ASWheelPicker1.CornerRadius = 20dip'can be set in the designer
	
	'*****Arrows
	xlbl_up_1.Left = ASWheelPicker1.Base.Left + (ASWheelPicker1.Base.Width/2 - 15dip/2)/2 - xlbl_up_1.Width/2
	xlbl_down_1.Left = ASWheelPicker1.Base.Left + (ASWheelPicker1.Base.Width/2 - 15dip/2)/2 - xlbl_up_1.Width/2
	
	xlbl_up_2.Left = ASWheelPicker1.Base.Left + ASWheelPicker1.Base.Width - (ASWheelPicker1.Base.Width/2 - 15dip/2)/2 - xlbl_up_1.Width/2
	xlbl_down_2.Left = ASWheelPicker1.Base.Left + ASWheelPicker1.Base.Width - (ASWheelPicker1.Base.Width/2 - 15dip/2)/2 - xlbl_up_1.Width/2
	'*****Arrows
	
	
	ASWheelPicker1.RowHeightSelected = 70dip
	ASWheelPicker1.RowHeightUnSelected = 60dip
	
	Dim ItemTextProperties As ASWheelPicker_ItemTextProperties = ASWheelPicker1.ItemTextProperties
	ItemTextProperties.TextFont = xui.CreateDefaultBoldFont(50) 'makes the items bold
	ASWheelPicker1.ItemTextProperties = ItemTextProperties
	
	ASWheelPicker1.SeperatorProperties.TextFont = xui.CreateDefaultBoldFont(50) 'makes the seperator text bold
	
	ASWheelPicker1.FadeColor = xui.Color_Transparent 'no fade color effect
	'set the same color as the view so that the upper and lower numbers are not visible and there is a slide in effect
	ASWheelPicker1.TopFadePanel.Color = xui.Color_ARGB(255,60, 64, 67)
	ASWheelPicker1.BottomFadePanel.Color = xui.Color_ARGB(255,60, 64, 67)
	
	'Add the numbers to wheel 1
	Dim tmp_lst As List : tmp_lst.Initialize
	For i = 0 To 24 -1
		tmp_lst.Add(i)
	Next
	ASWheelPicker1.AddItems(tmp_lst)
	'Add the numbers to wheel 2
	Dim tmp_lst As List : tmp_lst.Initialize
	For i = 0 To 60 -1
		tmp_lst.Add(i)
	Next
	ASWheelPicker1.AddItems(tmp_lst)
	
	ASWheelPicker1.SeperatorProperties.BackgroundColor = xui.Color_ARGB(255,60, 64, 67)'sets the seperator backgroundcolor matched to the view background color
	ASWheelPicker1.SetSeperator(0,15dip,":")'adds the seperator
	
	ASWheelPicker1.Refresh
	
End Sub
#If B4J
Private Sub xlbl_up_1_MouseClicked (EventData As MouseEvent)
	ASWheelPicker1.NextItem(0,True)
End Sub

Private Sub xlbl_up_2_MouseClicked (EventData As MouseEvent)
	ASWheelPicker1.NextItem(1,True)
End Sub

Private Sub xlbl_down_1_MouseClicked (EventData As MouseEvent)
	ASWheelPicker1.PreviousItem(0,True)
End Sub

Private Sub xlbl_down_2_MouseClicked (EventData As MouseEvent)
	ASWheelPicker1.PreviousItem(1,True)
End Sub
#Else
Private Sub xlbl_up_1_Click
	ASWheelPicker1.NextItem(0,True)
End Sub

Private Sub xlbl_up_2_Click
	ASWheelPicker1.NextItem(1,True)
End Sub

Private Sub xlbl_down_1_Click
	ASWheelPicker1.PreviousItem(0,True)
End Sub

Private Sub xlbl_down_2_Click
	ASWheelPicker1.PreviousItem(1,True)
End Sub
#End If

Private Sub B4XSwitch1_ValueChanged (Value As Boolean)
	If Value Then
		ASWheelPicker1.SelectionBarColor = xui.Color_Transparent
		Else
		ASWheelPicker1.SelectionBarColor = xui.Color_White
	End If
End Sub

Private Sub ASWheelPicker1_ItemSnapped(wheel_index As Int,list_index As Int)
	Log("Index: " & list_index)
End Sub