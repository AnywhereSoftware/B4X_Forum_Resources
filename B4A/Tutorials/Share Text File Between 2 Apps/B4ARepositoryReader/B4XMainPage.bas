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
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4ARepositoryReader.zip

Sub Class_Globals
	Private Root As B4XView
	Private device As Phone
	Private MES As ManageExternalStorage
	Private Button1 As Button
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
	MES.Initialize(Me, "MES")
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, Application.LabelName)
	
	' Get the device SDK version
	Dim SdkVersion As Int = device.SdkVersion
	Log("SDK = " & SdkVersion)

	' Choose which permission to request in order to access external storgage
	If SdkVersion < 30 Then
		Log("Requesting WRITE_EXTERNAL_STORAGE permission")
		Dim rp As RuntimePermissions
		rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE) ' Implicit read capability if granted
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		Log($"${Permission} = ${Result}"$)
	Else
		Log("Requesting WRITE_EXTERNAL_STORAGE permission")
		Log("WRITE_EXTERNAL_STORAGE = " & MES.HasPermission)
		If Not(MES.HasPermission) Then
			MsgboxAsync("This app requires access to all files, please enable the option", "Manage All Files")
			Wait For Msgbox_Result (Res As Int)
			Log("Getting permission")
			MES.GetPermission
			Wait For MES_StorageAvailable
		End If
		If MES.HasPermission Then
			Button1.Enabled = True
		Else
			Button1.Enabled = False
		End If
	End If
End Sub

Private Sub Button1_Click
	Try
		Dim Directory As String = "B4A/Repository"
		'Log(File.Exists(File.DirRootExternal, Directory))
		Dim B4XRepository As String = File.Combine(File.DirRootExternal, Directory)
		'Log(B4XRepository)
		If File.Exists(B4XRepository, "Test.txt") Then
			Log(File.ReadString(B4XRepository, "Test.txt"))
		Else
			Log("File not found")
		End If
	Catch
		Log(LastException)
	End Try
End Sub