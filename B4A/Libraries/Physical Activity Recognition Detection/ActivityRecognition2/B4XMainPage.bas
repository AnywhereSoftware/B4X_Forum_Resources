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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=ActivityRecognition.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private rp As RuntimePermissions
	Public client As RecognitionClient
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	client.Initialize(True)
	Dim p As Phone
	If p.SdkVersion >= 29 Then
		rp.CheckAndRequest("android.permission.ACTIVITY_RECOGNITION")
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then
			ToastMessageShow("No permission", True)
			Return
		End If
	End If
	Dim activities As List = Array("IN_VEHICLE", "ON_BICYCLE", "ON_FOOT", "STILL", "WALKING", "RUNNING")
	Wait For (client.RequestTransitionUpdates(activities)) Complete (Success As Boolean)
	Log(Success)
End Sub
