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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=NotifListenerExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
End Sub

Private Sub CheckAndRequestNotificationPermission As ResumableSub
	Dim p As Phone
	If p.SdkVersion < 33 Then Return True
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim targetSdkVersion As Int = ctxt.RunMethodJO("getApplicationInfo", Null).GetField("targetSdkVersion")
	If targetSdkVersion < 33 Then Return True
	Dim NotificationsManager As JavaObject = ctxt.RunMethod("getSystemService", Array("notification"))
	Dim NotificationsEnabled As Boolean = NotificationsManager.RunMethod("areNotificationsEnabled", Null)
	If NotificationsEnabled Then Return True
	Dim rp As RuntimePermissions
	rp.CheckAndRequest(rp.PERMISSION_POST_NOTIFICATIONS)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean) 'change to Activity_PermissionResult if non-B4XPages.
	Log(Permission & ": " & Result)
	Return Result
End Sub

Sub btnEnableNotifications_Click
	Dim In As Intent
	In.Initialize("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS", "")
	StartActivity(In)
End Sub

Sub btnCreateNotifications_Click
	Wait For (CheckAndRequestNotificationPermission) Complete (HasPermission As Boolean)
	If HasPermission Then
		For i = 1 To 5
			Dim n As Notification
			n.Initialize
			n.Icon = "icon"
			n.SetInfo("Notification " & i, "abcde", Main)
			n.Notify(i)
		Next
	End If
End Sub

Sub btnClearAll_Click
	CallSubDelayed(NotificationService, "ClearAll")
End Sub
Sub btnGetActive_Click
	CallSubDelayed(NotificationService, "GetActive")
End Sub