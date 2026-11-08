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
	
	Private mc As MediaChooser
	Private ImageView1 As ImageView 
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	mc.Initialize(Me, "mc")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Wait For (mc.CaptureImage) Complete (Result As MediaChooserResult)
	ShowMedia(Result)
End Sub

Private Sub mc_Error (Key As String, Message As String)
	Log("error: " & Message)
End Sub

Private Sub ShowMedia (Result As MediaChooserResult)
	If Result.Success Then
		ImageView1.Bitmap = xui.LoadBitmap(Result.MediaDir, Result.MediaFile)
	End If
End Sub