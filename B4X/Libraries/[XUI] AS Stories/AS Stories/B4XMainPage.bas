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
	Private AS_Stories1 As AS_Stories
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	For i = 0 To 11 -1
	
		Dim xpnl_Item As B4XView = xui.CreatePanel("")
		xpnl_Item.Color = xui.Color_ARGB(255,Rnd(0,256),Rnd(0,256),Rnd(0,256))
		AS_Stories1.AddPage(xpnl_Item,i)
	
	Next
	
	B4XPages.SetTitle(Me,$"AS Stories Example Story ${AS_Stories1.Index+1}/${AS_Stories1.Size}"$)
	
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
	AS_Stories1.Base_Resize(Width,Height)

End Sub

Private Sub AS_Stories1_PageChanged(Index As Int)
	Log("PageChanged: " & Index)
	B4XPages.SetTitle(Me,$"AS Stories Example Story ${Index+1}/${AS_Stories1.Size}"$)
End Sub

Private Sub AS_Stories1_LazyLoadingAddContent(Parent As B4XView, Value As Object)
	Dim xpnl_tmp As B4XView = xui.CreatePanel("")
	xpnl_tmp.Color = xui.Color_Red
	
	Parent.AddView(xpnl_tmp,0,0,50dip,50dip)
End Sub

Private Sub AS_Stories1_AutoPlayPause
	AS_Stories1.HeaderPanel.SetVisibleAnimated(250,False)
End Sub

Private Sub AS_Stories1_AutoPlayContinue
	AS_Stories1.HeaderPanel.SetVisibleAnimated(250,True)
End Sub