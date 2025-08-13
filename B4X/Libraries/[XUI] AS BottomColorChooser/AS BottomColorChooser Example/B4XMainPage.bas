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
	
	Private BottomColorChooser As AS_BottomColorChooser
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomColorChooser Example")
	
End Sub

Private Sub OpenSheet(DarkMode As Boolean)
	
	BottomColorChooser.Initialize(Me,"BottomColorChooser",Root)
	
	Dim lst_Colors As List
	lst_Colors.Initialize
	lst_Colors.Add(xui.Color_ARGB(255, 49, 208, 89))
	lst_Colors.Add(xui.Color_ARGB(255, 25, 29, 31))
	lst_Colors.Add(xui.Color_ARGB(255, 9, 131, 254))
	lst_Colors.Add(xui.Color_ARGB(255, 255, 159, 10))
	
	lst_Colors.Add(xui.Color_ARGB(255, 45, 136, 121))
	lst_Colors.Add(BottomColorChooser.CreateColorItem(xui.Color_ARGB(255, 73, 98, 164),False))
	lst_Colors.Add(BottomColorChooser.CreateColorItem(xui.Color_ARGB(255, 221, 95, 96),False))
	lst_Colors.Add(BottomColorChooser.CreateColorItem(xui.Color_ARGB(255, 141, 68, 173),False))
	lst_Colors.Add(xui.Color_Magenta)
	lst_Colors.Add(xui.Color_Cyan)
	
	BottomColorChooser.SelectedColor = xui.Color_ARGB(255, 9, 131, 254)
	
	BottomColorChooser.Theme = IIf(DarkMode,BottomColorChooser.Theme_Dark,BottomColorChooser.Theme_Light)
	BottomColorChooser.ActionButtonVisible = True
	BottomColorChooser.SetItems(lst_Colors)
'	BottomColorChooser.WidthHeight = 100dip
'	BottomColorChooser.CornerRadius = BottomColorChooser.WidthHeight/2 'For a circle
	BottomColorChooser.ShowPicker
	
	BottomColorChooser.ActionButton.Text = "Confirm"
	
End Sub

Private Sub OpenDark
	OpenSheet(True)
End Sub

Private Sub OpenLight
	OpenSheet(False)
End Sub

#Region Bottom Events

Private Sub BottomColorChooser_ItemClicked(Item As AS_BottomColorChooser_Item)
	LogColor("ItemClicked",Item.Color)
End Sub

Private Sub BottomColorChooser_DisabledItemClicked(Item As AS_BottomColorChooser_Item)
	LogColor("DisabledItemClicked",Item.Color)
End Sub

Private Sub BottomColorChooser_ActionButtonClicked
	LogColor("ActionButtonClicked with color",BottomColorChooser.SelectedColor)
	BottomColorChooser.HidePicker
End Sub

#End Region


#Region ButtonEvents

#If B4J
Private Sub xlbl_OpenDark_MouseClicked (EventData As MouseEvent)
	OpenDark
End Sub
#Else
Private Sub xlbl_OpenDark_Click
	OpenDark
End Sub
#End If

#If B4J
Private Sub xlbl_OpenLight_MouseClicked (EventData As MouseEvent)
	OpenLight
End Sub
#Else
Private Sub xlbl_OpenLight_Click
	OpenLight
End Sub
#End If

#End Region


