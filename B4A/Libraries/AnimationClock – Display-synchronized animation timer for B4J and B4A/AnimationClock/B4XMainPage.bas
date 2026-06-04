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
	Private AC As AnimationClock
	Private firstTime As Boolean
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	AC.Initialize("AC", Me)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	If AC.Running Then
		AC.Stop
	Else
		firstTime = True
		AC.Start
	End If
End Sub

Sub AC_Tick(ElapsedTime As Long)
	' Runs every frame, synchronized with the display
	If firstTime Then
		firstTime = False
		#if b4j
		Dim jo As JavaObject
		jo.InitializeStatic("javafx.application.Platform")
		Log($"Is in UI thread: ${jo.RunMethod("isFxApplicationThread", Null)}"$)
		#else if b4a
		Dim jo As JavaObject
		jo.InitializeStatic("android.os.Looper")
		Dim mainLooper As JavaObject = jo.RunMethodJO("getMainLooper", Null)
		Dim myLooper As JavaObject = jo.RunMethodJO("myLooper", Null)
		Log($"On UI thread: ${mainLooper.RunMethod("equals", Array(myLooper))}"$)
		#end if	' update canvas etc.
	End If
	Log(ElapsedTime)
End Sub

