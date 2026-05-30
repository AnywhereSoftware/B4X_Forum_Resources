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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private UpdateManager As mcInAppUpdateManager
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	UpdateManager.Initialize(Me, "InAppUpdate")
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub B4XPage_Appear
	UpdateManager.CheckForUpdate
End Sub


Public Sub InAppUpdate_onUserAcceptUpdate(accepted As Boolean)
	Log($"User accepted flexible update: ${accepted}"$)
End Sub


Sub InAppUpdate_OnCheckCompleted(Result As Map)

	Log(Result)

	If Result.Get("success") = False Then Return

	Dim available As Boolean = Result.Get("available")

	If available Then

		Dim info As JavaObject = Result.Get("info")

		UpdateManager.StartUpdateFlow(info, UpdateManager.FLEXIBLE)

	Else

		Log("No update available")

	End If

End Sub


Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub
