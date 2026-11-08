B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private vh As VisualHelp_JE
	Private Label1 As Label
	Private EditText1 As EditText
	Private Panel1 As Panel
	Private Panel2 As B4XView
	Private B4XComboBox1 As B4XComboBox
	Private B4XFloatTextField1 As B4XFloatTextField
	Private Button1 As Button
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
		
	vh.Initialize(Root, 0)
'	vh.SetIconDimensions(100dip, 100dip)
'	vh.SetFrame(xui.Color_Magenta, 2dip)
	
	vh.AddInfo("This is a info label with default colors showed on 25%y", 25%y)
	
	Private cd As ColorDrawable
	cd.Initialize2(xui.Color_Blue, 10dip, 2dip, xui.Color_LightGray)
	vh.HelpColor = cd
	vh.AddInfo("This is a info label with changed colors showed on 50%y", 50%y)
	vh.AddHelp(Label1, "Help for Label 1", vh.GIF_SWIPE_LEFT)
	vh.AddHelp(EditText1, "Help for Label 2", vh.GIF_SWIPE_RIGHT)
	vh.AddHelp(Panel1, "Help for Panel 1 Help for Panel 1 Help for Panel 1", vh.GIF_SCROLL_HORIZONTAL)

	Private cd2 As ColorDrawable
	cd2.Initialize2(0xFF00FF00, 10dip, 2dip, xui.Color_Yellow)
	vh.HelpColor = cd2
	vh.TextSize = 25
	vh.TextColor = xui.Color_DarkGray

	vh.AddHelp(Panel2, "Help for Panel 2 Help for Panel 2 Help for Panel 2", vh.GIF_SCROLL_VERTICAL)
	vh.AddHelp(B4XComboBox1.mBase, "Help for Panel 3 Help for Panel 3 Help for Panel 3", vh.GIF_SWIPE_UP)
	vh.AddHelp(B4XFloatTextField1.mBase, "Help for Panel 3 Help for Panel 3 Help for Panel 3 PART2", vh.ICON_ARROW_UP)
	vh.AddHelp(Button1, "Help for Button1", vh.GIF_SWIPE_UP)
	
	Wait For (vh.ShowHelp) Complete (result As Boolean)

End Sub

Private Sub Button1_Click
	ExitApplication
End Sub