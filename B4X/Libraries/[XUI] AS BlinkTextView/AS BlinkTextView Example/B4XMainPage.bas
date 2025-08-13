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
	Private AS_BlinkTextView1 As AS_BlinkTextView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	
	'Creates as view per code
	Dim Blink As AS_BlinkTextView
	Blink.Initialize(Me,"Blink")
	Blink.AddToParent(Root,0,0,50dip,50dip)
	Blink.Text = "Test"
	Blink.Font = xui.CreateDefaultBoldFont(20)
	Blink.TextColor = xui.Color_White
	Blink.AnimationDuration = 250
	Blink.StartBlink
	
End Sub

