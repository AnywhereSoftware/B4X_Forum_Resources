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
	Private Label1 As Label
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	If Main.MyAppState.size = 0 Then			'The first orientation
		Main.MyAppState.Put("OrientationCount", 1)
	Else
		Main.MyAppState.Put("OrientationCount", 1 + Main.MyAppState.Get("OrientationCount"))
	End If
	Dim n As Int = Main.MyAppState.Get("OrientationCount")
	Dim message As String = "Now Portrait" & " Change # " & n
	If Root.Width>Root.Height Then message = "Now Landscape" & " Change # " & n
	Label1.Text = message
End Sub
