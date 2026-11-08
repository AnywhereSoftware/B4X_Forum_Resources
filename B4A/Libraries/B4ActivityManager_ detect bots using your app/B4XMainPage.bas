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
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Dim objB4ActivityManager As B4ActivityManager
	objB4ActivityManager.Initialize
	Log($"Runing isRunningInUserTestHarness: ${objB4ActivityManager.isRunningInUserTestHarness}"$)
	Log($"Runing getLockTaskModeState: ${objB4ActivityManager.getLockTaskModeState}"$)
	Log($"Runing isInLockTaskMode: ${objB4ActivityManager.isInLockTaskMode}"$)
	Log($"Runing isBackgroundRestricted: ${objB4ActivityManager.isBackgroundRestricted}"$)
	Log($"Runing isLowMemoryKillReportSupported: ${objB4ActivityManager.isLowMemoryKillReportSupported}"$)
	Log($"Runing isLowRamDevice: ${objB4ActivityManager.isLowRamDevice}"$)
	Log($"Runing isUserAMonkey: ${objB4ActivityManager.isUserAMonkey}"$)
	Log($"Runing getLargeMemoryClass: ${objB4ActivityManager.getLargeMemoryClass}"$)
	Log($"Runing getLauncherLargeIconDensity: ${objB4ActivityManager.getLauncherLargeIconDensity}"$)
	Log($"Runing getLauncherLargeIconSize: ${objB4ActivityManager.getLauncherLargeIconSize}"$)
	Log($"Runing getMemoryClass: ${objB4ActivityManager.getMemoryClass}"$)
End Sub

Private Sub Button2_Click
	Dim objB4ActivityManager As B4ActivityManager
	objB4ActivityManager.Initialize
	If objB4ActivityManager.isUserAMonkey = True Or objB4ActivityManager.isRunningInUserTestHarness = True Then
		xui.MsgboxAsync("A bot is running the app.","Alert!")
	Else
		xui.MsgboxAsync("You may be a human.","Alert!")
	End If
End Sub