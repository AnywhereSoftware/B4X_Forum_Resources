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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=PushClients.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private analytics As FirebaseAnalytics
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	analytics.Initialize
	Root = Root1
	Root.LoadLayout("MainPage")
	'request notification permission
	#if B4A
	Wait For (CheckAndRequestNotificationPermission) Complete (HasPermission As Boolean)
	If HasPermission = False Then
		Log("no permission")
		ToastMessageShow("no permission", True)
	End If
	APNPushTokenAvailable 'no need to wait in B4A.
	#Else If B4i
	Main.App.RegisterUserNotifications(True, True, True)
	Main.App.RegisterForRemoteNotifications
	#End If
End Sub

Public Sub APNPushTokenAvailable
	'you can add more topics here. Note that in B4i the topics will be prefixed with ios_.
	CallSubDelayed2(FirebaseMessaging, "SubscribeToTopics", Array("general"))
End Sub

#if B4A
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
#End If

