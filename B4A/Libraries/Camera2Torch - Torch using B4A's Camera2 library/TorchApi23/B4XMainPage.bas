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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=ProjectTorch.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private torch As Camera2Torch
	Private torchMode As Boolean
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Camera2 Torch v0.09")
	torch.Initialize
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	torchMode = Not(torchMode)
	Dim success As Boolean = torch.TorchMode(False, torchMode)
	If Not(success) Then
		xui.MsgboxAsync("Failed", "B4X")
		torchMode = Not(torchMode)
	End If
End Sub