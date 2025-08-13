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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XPages_LoadingIndicators.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub B4XPage_Appear
	#IF B4A
	For Each v As b4xView In Root.GetAllViewsRecursive
		If v.Tag Is SD_LoadingIndicator And v.Visible = True Then
			Dim x As SD_LoadingIndicator = v.Tag
			x.Show
		End If
	Next
	#END IF
End Sub

Sub B4XPage_Disappear
	
End Sub

Sub B4XPage_Foreground
	
End Sub

Sub B4XPage_Background
	
End Sub