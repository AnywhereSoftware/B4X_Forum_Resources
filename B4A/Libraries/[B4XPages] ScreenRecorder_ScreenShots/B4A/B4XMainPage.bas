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
	Public Recording As Boolean
	Private btnStartRec As B4XView
	Private btnStopRec As B4XView
	Private btnShowVideo As B4XView
	Public PageShow As Show
End Sub

Public Sub Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("lay1")
	PageShow.Initialize
	B4XPages.AddPage("PageShow",PageShow)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.



Private Sub btnStartRec_Click
	If Recording = False Then
		StartService(Screen)
	End If
	'Android imposes that user needs to grant permission before when we can record the screen.
	Starter.rec.GetPermission
End Sub

Private Sub btnStopRec_Click
	StopService(Screen)
	ToastMessageShow("Screenrecording was stopped....", False)
End Sub

Private Sub btnShowVideo_Click
	B4XPages.ShowPage("PageShow")
	PageShow.GenerateVideoVievAndPlay
	
End Sub

Sub rec_Result(Grant As Boolean)
	'here we check if user granted permission to record the screen
	If Grant Then
		'in this sample-app, I am using the same file-name for all recordings and therefore
		'I delete the previous video-file. Here you will need to implement your own solution
		'in order to make sure the video file-name does not already exist....
		If File.Exists(Starter.rp.GetSafeDirDefaultExternal(""),"mytest1.mp4") Then
			File.Delete(Starter.rp.GetSafeDirDefaultExternal(""),"mytest1.mp4")
		End If
		If Recording = False Then
			Starter.rec.StartRecording(GetDeviceLayoutValues.Width,GetDeviceLayoutValues.Height,Starter.rp.GetSafeDirDefaultExternal(""),"mytest1")
			Recording = True
			ToastMessageShow("Screenrecording is running....", False)
		End If
	Else
		ToastMessageShow("User did not grant permission to record.", True)
	End If
End Sub