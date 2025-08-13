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
	Private AS_Settings1 As AS_Settings
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS Settings ColorChooser Example")
	
	AS_Settings1.Theme = AS_Settings1.Theme_Light

	'************MainPage*****************
	AS_Settings1.MainPage.AddGroup("ColorChooser","Color Chooser")
	
	Dim lst_Colors As List
	lst_Colors.Initialize
	lst_Colors.Add(xui.Color_ARGB(255, 49, 208, 89))
	lst_Colors.Add(xui.Color_ARGB(255, 25, 29, 31))
	lst_Colors.Add(xui.Color_ARGB(255, 9, 131, 254))
	lst_Colors.Add(xui.Color_ARGB(255, 255, 159, 10))
	
	lst_Colors.Add(xui.Color_ARGB(255, 45, 136, 121))
	lst_Colors.Add(AS_Settings1.CreateColorItem(xui.Color_ARGB(255, 73, 98, 164),False)) 'This item is deactivated and cannot be selected
	lst_Colors.Add(AS_Settings1.CreateColorItem(xui.Color_ARGB(255, 221, 95, 96),False)) 'This item is deactivated and cannot be selected
	lst_Colors.Add(AS_Settings1.CreateColorItem(xui.Color_ARGB(255, 141, 68, 173),False))'This item is deactivated and cannot be selected
	lst_Colors.Add(xui.Color_Magenta)
	lst_Colors.Add(xui.Color_Cyan)

	'With Group
	AS_Settings1.MainPage.AddProperty_ColorChooser("ColorChooser","AppColor",lst_Colors,xui.Color_Magenta,50dip,Null)
	'With Icon
	AS_Settings1.MainPage.AddProperty_ColorChooser("ColorChooser","AppColor",lst_Colors,xui.Color_Magenta,50dip,AS_Settings1.FontToBitmap(Chr(0xE897),True,30,xui.Color_Gray))
	
	'Placeholder between
	AS_Settings1.MainPage.AddSpaceItem("","",50dip)
	
	'Without Group
	AS_Settings1.MainPage.AddProperty_ColorChooser("","AppColor2",lst_Colors,xui.Color_Magenta,50dip,Null)
	
	AS_Settings1.MainPage.Create
	
End Sub

Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)
	Select Property.PropertyName
		Case "AppColor","AppColor2"
			LogColor("ValueChanged AppColor",Value)
	End Select
End Sub

Private Sub AS_Settings1_DisabledItemClicked(Property As AS_Settings_Property, Value As Object)
	LogColor("DisabledItemClicked",Value)
End Sub
