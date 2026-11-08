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

	Private ASSegmentedTab3 As ASSegmentedTab
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"AS SegmentedTab Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	ASSegmentedTab3.mBase.Color = xui.Color_ARGB(255,42, 156, 255)
	ASSegmentedTab3.SelectionPanel.Color = xui.Color_White
	ASSegmentedTab3.ItemTextProperties.TextColor = xui.Color_Black
	ASSegmentedTab3.ItemTextProperties.SelectedTextColor = xui.Color_Black
	ASSegmentedTab3.CornerRadiusBackground = 8dip
	ASSegmentedTab3.CornerRadiusSelectionPanel = 8dip
	ASSegmentedTab3.PaddingSelectionPanel = 4dip
	
	Dim Tab1 As ASSegmentedTab_Tab
	Tab1.Initialize
	Tab1.Icon = ASSegmentedTab3.FontToBitmap(Chr(0xE068),True,15,xui.Color_White)
	Tab1.Width = 40dip
	ASSegmentedTab3.AddTabAdvanced(Tab1)

	ASSegmentedTab3.AddTab("Inizio",Null)
	ASSegmentedTab3.AddTab("Fine Prova",Null)

End Sub
