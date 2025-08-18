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
	Private ASCalendarAdvanced1 As ASCalendarAdvanced
	Private xclv_main As CustomListView
	Private xpnl_main As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	ASCalendarAdvanced1.CreateCalendar
	
	For i = 0 To 15 -1
		
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.SetLayoutAnimated(0,0,0,Root.Width,80dip)
		xpnl.Color = xui.Color_ARGB(255,Rnd(0,256),Rnd(0,256),Rnd(0,256))
		xclv_main.Add(xpnl,"")
		
	Next
	
End Sub

Private Sub ASCalendarAdvanced1_HeightChanged(Height As Float)
	xpnl_main.Top = Height
	xpnl_main.Height = Root.Height - Height
	
	If xclv_main.AsView <> Null And xclv_main.AsView.IsInitialized = True Then
		xclv_main.AsView.Height = xpnl_main.Height
		xclv_main.Base_Resize(Root.Width,xpnl_main.Height)
	End If
End Sub