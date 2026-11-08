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
	Private Drawer As B4XDrawerAdvanced
	Private xclv_Left As CustomListView
	Private xclv_Right As CustomListView
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	Drawer.Initialize(Me, "Drawer", Root, 300dip)
	Drawer.CenterPanel.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"B4XDrawerAdvanced")
	
	Drawer.LeftPanel.LoadLayout("frm_Left")
	Drawer.RightPanel.LoadLayout("frm_Right")
	Drawer.RightPanelEnabled = True
	
	For i = 0 To 20 -1
		xclv_Left.AddTextItem("Test " & i,"")
		xclv_Right.AddTextItem("Test " & i,"")
	Next
	
End Sub

