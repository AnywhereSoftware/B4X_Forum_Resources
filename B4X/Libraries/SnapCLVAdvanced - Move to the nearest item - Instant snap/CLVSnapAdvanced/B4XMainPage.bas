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
	Private CustomListView1 As CustomListView
	Private AdvancedSnap As CLVSnapAdvanced
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"CLVSnapAdvanced Example")
	
	
	For i = 0 To 50 -1
		
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.Color = Rnd(0xff000000, 0xffffffff)
		xpnl.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, Rnd(200dip, 300dip))
		CustomListView1.Add(xpnl, "")
		
	Next
	
	AdvancedSnap.Initialize(CustomListView1)
	AdvancedSnap.InstantSnap = True
	
End Sub

Sub CustomListView1_ScrollChanged (Offset As Int)
	AdvancedSnap.ScrollChanged(Offset)
End Sub
