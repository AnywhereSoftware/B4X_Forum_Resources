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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip


Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Dim ph As Phone
	Dim rp As RuntimePermissions
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	
'	If it crashes, AndroidX Is Not included.
'	If it doesn't crash, you can now use the Builder
	Dim test As JavaObject
	test.InitializeStatic("androidx.core.app.NotificationCompat")
	Log("AndroidX OK")

	'Works for testing:
'	TestBroadcast
End Sub

Private Sub B4XPage_Appear
	RequestNotificationPermission
End Sub


'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub RemoveNotification
	Dim ctxt As JavaObject
	ctxt.InitializeContext

	Dim manager As JavaObject
	manager = ctxt.RunMethod("getSystemService", Array("notification"))

	manager.RunMethod("cancel", Array(MyService.notificationId))
End Sub

' Works for testing:
'Sub TestBroadcast
'	Dim ctxt As JavaObject
'	ctxt.InitializeContext
'
'	Dim i As Intent
'	i.Initialize("ACTION_1", "")
'	i.SetComponent(Application.PackageName & "/.myreceiver")
'
'	ctxt.RunMethod("sendBroadcast", Array(i))
'End Sub



'Permisos
Public Sub RequestNotificationPermission As ResumableSub
	If ph.SdkVersion < 33 Then Return True

	Private Permission As String = rp.PERMISSION_POST_NOTIFICATIONS
	
	rp.CheckAndRequest(Permission)
	
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)

'	Log("Result = " & Result)

	' The permit was denied. We are now checking if it was permanently denied:
	If Result = False Then CheckIfPermanentDenial(Permission)

	Return Result
End Sub

Sub CheckIfPermanentDenial(Permission As String)
	Dim jo As JavaObject
	jo.InitializeContext

	'We check if we should show an explanation
	Dim shouldShowRationale As Boolean = jo.RunMethod("shouldShowRequestPermissionRationale", Array(Permission))
    
	If shouldShowRationale = False Then
		'The user selected "Don't ask again" or permanently denied it in settings
		Log("Permission permanently blocked.")
		
		Private simplePermission As String
		
		If Permission = rp.PERMISSION_POST_NOTIFICATIONS Then simplePermission = "Notification"
		
		Dim sf As Object = xui.Msgbox2Async(("You have permanently disabled " _
		& simplePermission & " permission. You must manually enable it in Settings to continue. And return to this app using the back button"), _
		"Permission required", "Go to Settings", "Cancel", "", Null)
		
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			OpenAppDetails
		End If

		Log("The user denied it, but we can still ask again.")
	End If
End Sub

Public Sub OpenAppDetails	'As a last resort to enable notifications, or to disable the manufacturer's automatic power management...
	Dim i As Intent
	i.Initialize("android.settings.APPLICATION_DETAILS_SETTINGS", "package:" & Application.PackageName)
	StartActivity(i)
End Sub


'Función auxiliar:
Private Sub btnLaunchNotification_Click
	StartService(MyService)
End Sub

Private Sub btnRemoveNotification_Click
	RemoveNotification
	StopService(MyService)
End Sub