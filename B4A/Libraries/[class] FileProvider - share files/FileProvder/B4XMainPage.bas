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
	Public Provider As FileProvider
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Provider.Initialize
End Sub

Private Sub btnShareFile_Click
	Dim FileToSend As String = "Message.txt"
	File.WriteString(Provider.SharedFolder, FileToSend, "jaklsdjalksdjalskdjasld")
	Dim in As Intent
	in.Initialize(in.ACTION_SEND, "")
	in.SetType("text/plain")
	in.PutExtra("android.intent.extra.STREAM", Provider.GetFileUri(FileToSend))
	in.Flags = 1 'FLAG_GRANT_READ_URI_PERMISSION
	StartActivity(in)
End Sub

Private Sub btnViewImage_Click
	Dim FileName As String = "b4a.png"
	File.Copy(File.DirAssets, FileName, Provider.SharedFolder, FileName)
	Dim in As Intent
	in.Initialize(in.ACTION_VIEW, "")
	Provider.SetFileUriAsIntentData(in, FileName)
	'Type must be set after calling SetFileUriAsIntentData
	in.SetType("image/*")
	StartActivity(in)
End Sub

Private Sub btnSendEmail_Click
	Dim FileName As String = "b4a.png"
	'copy the shared file to the shared folder
	File.Copy(File.DirAssets, FileName, Provider.SharedFolder, FileName)
	Dim email As Email
	email.To.Add("aaa@bbb.com")
	email.Subject = "subject"
	email.Attachments.Add(Provider.GetFileUri(FileName))
	email.Attachments.Add(Provider.GetFileUri(FileName)) 'second attachment
	Dim in As Intent = email.GetIntent
	in.Flags = 1 'FLAG_GRANT_READ_URI_PERMISSION
	StartActivity(in)
End Sub