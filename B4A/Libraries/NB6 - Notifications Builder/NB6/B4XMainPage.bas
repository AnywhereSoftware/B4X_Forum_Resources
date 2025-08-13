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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=NB6.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private smiley As Bitmap
	Private OldIntent As Intent
	Private CLV As CustomListView
	Private Provider As FileProvider
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Provider.Initialize
	Root.LoadLayout("MainPage")
	smiley = LoadBitmapResize(File.DirAssets, "smiley.png", 24dip, 24dip, False)
	CLV.AddTextItem("Simple notification", "Simple_Notification")
	CLV.AddTextItem("Simple notification with CSBuilder and extra fields", "Simple_NotificationWithCSBuilderAndAFewExtraFields")
	CLV.AddTextItem("Big Picture Style notification", "BigPicture_Notification")
	CLV.AddTextItem("Big Text Style notification", "BigText_Notification")
	CLV.AddTextItem("Notification with progress", "Notification_WithProgress")
	CLV.AddTextItem("Notification with actions", "Notification_WithActions")
	CLV.AddTextItem("Count down notification", "CountDown_Notification")
	CLV.AddTextItem("Animated notification", "Animated_Notification")
	CLV.AddTextItem("Notification with custom sound", "Notification_WithCustomSound")
	CLV.AddTextItem("High priority notification", "HighPriority_Notification")
	CLV.AddTextItem("Low priority notification", "LowPriority_Notification")
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
	Return Result
End Sub


Private Sub B4XPage_Appear
	Dim in As Intent = B4XPages.GetNativeParent(Me).GetStartingIntent
	If in.IsInitialized And in <> OldIntent Then
		OldIntent = in
		If in.HasExtra("Notification_Tag") Then
			Log("Activity started from notification. Tag: " & in.GetExtra("Notification_Tag"))
		End If
	End If
End Sub

Private Sub CLV_ItemClick (Index As Int, Value As Object)
	Wait For (CheckAndRequestNotificationPermission) Complete (HasPermission As Boolean)
	If HasPermission Then
		CallSub(Me, Value)
	Else
		ToastMessageShow("No permission to show notification", True)
	End If
End Sub

Sub Simple_Notification
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "DEFAULT").AutoCancel(True).SmallIcon(smiley)
	n.Build("Title", "Content", "tag1", Main).Notify(4) 'It will be Main (or any other activity) instead of Me if called from a service.
End Sub

Sub Simple_NotificationWithCSBuilderAndAFewExtraFields
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "DEFAULT").AutoCancel(True).SmallIcon(smiley)
	Dim cs As CSBuilder
	n.SubText(cs.Initialize.BackgroundColor(Colors.Yellow).Append("Sub text").PopAll)
	Dim title As Object = cs.Initialize.Color(Colors.Green).Append("This is the title").PopAll
	Dim Content As Object = cs.Initialize.Underline.Bold.Append($"This is the content.
This is the second line"$ _
	).PopAll
	Dim largeIcon As Bitmap = LoadBitmapResize(File.DirAssets, "logo-02.png", 256dip, 256dip, True)
	n.LargeIcon(largeIcon)
	n.Color(Colors.Blue)
	n.BadgeIconType("SMALL").Number(1)
	n.ShowWhen(DateTime.Now)
	n.Build(title, Content, "tag2", Main).Notify(5)
End Sub

Sub BigPicture_Notification
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "DEFAULT").SmallIcon(smiley)
	Dim b As Bitmap = LoadBitmap(File.DirAssets, "logo-02.png")
	n.BigPictureStyle(b.Resize(256dip, 256dip, True), _
		b, "content title", "summary text")
	n.Color(0xFF00AEFF)
	n.Build("title", "collapsed content", "tag", Main).Notify(7)
End Sub

Sub BigText_Notification
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "DEFAULT").SmallIcon(smiley)
	Dim cs As CSBuilder
	n.BigTextStyle("content title", cs.Initialize.BackgroundColor(Colors.Red).Append("summary text").PopAll, _
	$"jfwelk fjwlek fjwelkf
wef jweklffwe jkfjwklegjlkw ejglkw ejglkw ejglkw egjw
eg wlkegj lkwe jglkw ejglkw ejglkwjeg lkweg
weg kwlegj lkwe gjlkwe gjlwke gjlkwe gjklwe gl
we gjklwe gjklw egjlwk egjklwe g
weg lkweg jlkwe g
weg
weg
we
g wejgkl wkelgj welkg jlwek glkwegj wlek gj lwk eg
we gklkwle gjlkwe jglkwej glkwejgklwegjw
eg weklgj welkgj wlekgj wlekgj lwkjegw eglk;we
g
weg
we gklw;e gk;lw ekg;lw egk;lw

 gw;lekg;wlegkl;weg
 111111111111111111111111
 22222222222222222222222
 33333333333333333333
 444444444444444444444444
 55555555555555"$ _
 	)
	n.Build("title", "collapsed content", "tag", Main).Notify(8)
End Sub

Sub Notification_WithProgress
	Dim notif As Notification
	For i = 1 To 10
		Dim n As NB6
		n.Initialize("default", Application.LabelName, "DEFAULT").SmallIcon(smiley)
		n.Progress(i, 10, False)
		n.OnlyAlertOnce(True)
		notif = n.Build("Title", "Content", "tag", Main)
		notif.Notify(6)
		Sleep(500)
	Next
	notif.Cancel(6)
End Sub

Sub Notification_WithActions
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "DEFAULT").SmallIcon(smiley)
	n.AddButtonAction(smiley, "Action 1", MyReceiver, "action 1")
	Dim cs As CSBuilder
	n.AddButtonAction(Null, cs.Initialize.Color(Colors.Red).Bold.Append("Action 2").PopAll, MyReceiver, "action 2")
	n.DeleteAction(MyReceiver, "delete action")
	n.Build("Actions", "Actions", "tag", Main).Notify(1)
	
End Sub

Sub CountDown_Notification
	Dim p As Panel = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 24dip, 24dip)
	Dim cvs As B4XCanvas
	cvs.Initialize(p)
	For i = 10 To 1 Step -1
		Dim n As NB6
		n.Initialize("default", Application.LabelName, "DEFAULT")
		n.OnlyAlertOnce(True)
		cvs.ClearRect(cvs.TargetRect)
		cvs.DrawText(i, cvs.TargetRect.Width / 2, cvs.TargetRect.Height - 5dip, xui.CreateDefaultBoldFont(20), xui.Color_White, _
			 "CENTER")
		cvs.Invalidate
		n.SmallIcon(cvs.CreateBitmap)
		Dim Notification As Notification = n.Build("CountDownNotification", "...", "", Main)
		Notification.Notify(2)
		Sleep(600)
	Next
	cvs.Release
	Notification.Cancel(2)
End Sub

Sub Animated_Notification
	Dim p As Panel = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 24dip, 24dip)
	Dim cvs As B4XCanvas
	cvs.Initialize(p)
	Dim smly As B4XBitmap = smiley.Resize(24dip, 24dip, True)
	For i = 0 To 9
		Dim n As NB6
		n.Initialize("default", Application.LabelName, "DEFAULT")
		n.OnlyAlertOnce(True)
		cvs.ClearRect(cvs.TargetRect)
		cvs.DrawBitmapRotated(smly, cvs.TargetRect, i * 40)
		cvs.Invalidate
		n.SmallIcon(cvs.CreateBitmap)
		Dim Notification As Notification = n.Build("Animated notification", "...", "", Main)
		Notification.Notify(11)
		Sleep(200) 'It cannot be too fast as Android will not let it update.
	Next
	cvs.Release
End Sub

'See the manifest editor for a snippet that needs to be added.
Sub Notification_WithCustomSound
	Dim FileName As String = "shotgun.mp3"
	File.Copy(File.DirAssets, FileName, Provider.SharedFolder, FileName)
	Dim in As Intent
	in.Initialize(in.ACTION_VIEW, "")
	Provider.SetFileUriAsIntentData(in, FileName)
	Dim n As NB6
	n.Initialize("custom sound", Application.LabelName, "DEFAULT")
	n.SmallIcon(LoadBitmapResize(File.DirAssets, "smiley.png", 32dip, 32dip, True))
	'disable the default sound
	n.SetDefaults(False, True, True)
	'set custom sound
	n.CustomSound(Provider.GetFileUri(FileName))
	Dim Notification As Notification = n.Build("Notification with custom sound", "...", "", Main)
	Notification.Notify(3)
End Sub

Sub HighPriority_Notification
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "HIGH").SmallIcon(smiley)
	n.Build("Important!!!", "Content", "tag", Main).Notify(9)
End Sub

Sub LowPriority_Notification
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "LOW").SmallIcon(smiley)
	n.SetDefaults(False, False, False)
	n.Build("Not important...", "Content", "tag", Main).Notify(10)
End Sub