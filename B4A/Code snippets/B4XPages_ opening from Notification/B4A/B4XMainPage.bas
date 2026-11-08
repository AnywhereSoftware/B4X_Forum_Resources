B4A=true
Group=Pages
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Page2 As NewPage
	Private OldIntent As Intent
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Main Title")
	
	B4XPages.AddPage("NewPage", Page2.Initialize)
	
	Wait For (CheckAndRequestNotificationPermission) Complete (HasPermission As Boolean)
	If HasPermission = False Then
		Dim nopermissionnotif As String = "No notification permission !"
		Log(nopermissionnotif)
		ToastMessageShow(nopermissionnotif, True)
		Sleep(3000)
	End If
	
	If IsPaused(serv) Then
		StartService(serv)
		Sleep(10)
	End If	
End Sub

Private Sub BtnNewPage_Click
	B4XPages.ShowPage("NewPage")
End Sub

Sub B4XPage_Appear	
	If B4XPages.GetNativeParent(Me).GetStartingIntent.HasExtra("Notification_Tag") Then
		Dim intent1 As Intent = B4XPages.GetNativeParent(Me).GetStartingIntent
		If IsRelevantIntent(intent1) Then
			Dim page_ID As String = intent1.GetExtra("Notification_Tag")
			others.OpenPage(page_ID)
		End If
	End If
	others.NotifB4XPages("Tap for second page", False, False, "NewPage")
End Sub

'Make sure that targetSdkVersion >= 33
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
	Main.rp.CheckAndRequest(Main.rp.PERMISSION_POST_NOTIFICATIONS)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean) 'change to Activity_PermissionResult if non-B4XPages.
'	Log(Permission & ": " & Result)
	If Result = False Then
		'ToastMessageShow("Notification permission is the must for work", True)
		Sleep(3000)
	End If
	Return Result
End Sub

Private Sub IsRelevantIntent(in As Intent) As Boolean
	If in.IsInitialized And in <> OldIntent Then
		OldIntent = in
		Return True
	End If
	Return False
End Sub