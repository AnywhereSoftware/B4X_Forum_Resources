B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=2.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	'Private Phone As Phone
	'Private Provider As FileProvider
	Private LblMessage As B4XView
	Private LblVersion As B4XView
	'Private FileToInstall As String = "1.apk"
	Private latestVersion As Int = 2
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("2")
	B4XPages.SetTitle(Me, "APP")
	LblVersion.Text = $"Version ${Application.VersionName}"$
	If Application.VersionCode = latestVersion Then
		LblMessage.Visible = False
	End If
	'Provider.Initialize
	'If File.Exists(File.DirInternal, FileToInstall) = False Then
	'	File.Copy(File.DirAssets, FileToInstall, File.DirInternal, FileToInstall)
	'End If
End Sub

Private Sub BtnUpdate_Click
	If Application.VersionCode = latestVersion Then
		xui.MsgboxAsync("You already have the latest version", "")
		Return
	End If
	'SendInstallIntent
End Sub

'Private Sub SendInstallIntent
'	Dim i As Intent
'	If Phone.SdkVersion >= 24 Then
'		File.Copy(File.DirInternal, FileToInstall, Provider.SharedFolder, FileToInstall)
'		i.Initialize("android.intent.action.INSTALL_PACKAGE", Provider.GetFileUri(FileToInstall))
'		i.Flags = Bit.Or(i.Flags, 1) 'FLAG_GRANT_READ_URI_PERMISSION
'	Else
'		i.Initialize(i.ACTION_VIEW, "file://" & File.Combine(File.DirInternal, FileToInstall))
'		i.SetType("application/vnd.android.package-archive")
'	End If
'	StartActivity(i)
'End Sub