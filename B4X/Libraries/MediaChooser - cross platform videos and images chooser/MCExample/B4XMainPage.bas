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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=MCExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private chooser As MediaChooser
	Private smm As SimpleMediaManager
	Private Panel1 As B4XView
	Private AnotherProgressBar1 As AnotherProgressBar
	Private pnlTop As B4XView
	Private btnChooseImage As B4XView
	Private btnChooseVideo As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	xui.SetDataFolder("mediachooser-example")
	chooser.Initialize(Me, "chooser")
	smm.Initialize
	'smm.MaxImageFileSize = 20 * 1024 * 1024 'uncomment if using latest version of SMM that supports this property.
End Sub

Private Sub Chooser_Error (Key As String, Message As String)
	Log("error: " & Message)
End Sub

Private Sub btnCaptureImage_Click
	Wait For (chooser.CaptureImage) Complete (Result As MediaChooserResult)
	ShowMedia(Result)
End Sub


Private Sub btnCaptureVideo_Click
	Wait For (chooser.CaptureVideo) Complete (Result As MediaChooserResult)
	ShowMedia(Result)
End Sub

Private Sub btnChooseImage_Click
	Wait For (chooser.ChooseImage(btnChooseVideo)) Complete (Result As MediaChooserResult)
	ShowMedia(Result)
End Sub

Private Sub btnChooseVideo_Click
	Wait For (chooser.ChooseVideo(btnChooseVideo)) Complete (Result As MediaChooserResult)
	ShowMedia(Result)
End Sub

Private Sub ShowMedia (Result As MediaChooserResult)
	If Result.Success Then
		smm.SetMediaFromFile(Panel1, Result.MediaDir, Result.MediaFile, Result.Mime, Null)
	Else
		Panel1.RemoveAllViews
	End If
End Sub

Private Sub Chooser_Progress (Value As Int)
	Select Value
		Case chooser.PROGRESS_HIDE
			AnotherProgressBar1.Visible = False
		Case chooser.PROGRESS_SHOW
			AnotherProgressBar1.Visible = True
		Case chooser.PROGRESS_INDETERMINATE
			AnotherProgressBar1.Value = 100
		Case Else
			AnotherProgressBar1.Value = Value
	End Select
	If Value = chooser.PROGRESS_HIDE Or Value = chooser.PROGRESS_SHOW Then
		For Each btn As B4XView In pnlTop.GetAllViewsRecursive
			btn.Enabled = Value = chooser.PROGRESS_HIDE
		Next
	End If
End Sub