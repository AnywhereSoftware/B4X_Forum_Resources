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
	Private ASFlowTabMenu1 As ASFlowTabMenu
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	B4XPage_Resize(Width,Height)
	#End If
	
	ASFlowTabMenu1.AddTab(ASFlowTabMenu1.FontToBitmap(Chr(0xF015),False,20,xui.Color_White),"Home")
	ASFlowTabMenu1.AddTab(ASFlowTabMenu1.FontToBitmap(Chr(0xE7F4),True,20,xui.Color_White),"Notifications")
	ASFlowTabMenu1.AddTab(ASFlowTabMenu1.FontToBitmap(Chr(0xE8B8),True,20,xui.Color_White),"Settings")
	'ASFlowTabMenu1.AddTab(ASFlowTabMenu1.FontToBitmap(Chr(0xF015),False,20,xui.Color_White),"Test 4")

End Sub

#If B4I
Private Sub B4XPage_Resize (Width As Int, Height As Int)
	ASFlowTabMenu1.mBase.Top = Height - ASFlowTabMenu1.mBase.Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom
End Sub
#End If

Private Sub ASFlowTabMenu1_TabClick(index As Int)
	Log("TabClick: " & index)
End Sub