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
	
	'Dim rp As RuntimePermissions
	
	Private ListView1 As ListView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	
	ListView1.SingleLineLayout.Label.TextColor = Colors.Black
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub btnRuntime_Click	
	
'	If rp.Check(rp.PERMISSION_WRITE_EXTERNAL_STORAGE) = False Then	'
'		rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)
'		
''		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
'		Log(Result)
'		
'		If Result = False Then
'			ToastMessageShow("Permission denied.", True)
'			Return
'		End If
'	Else
'		LogColor("Write permission allowed",xui.Color_Green)
'		
'	End If
End Sub

Private Sub btnScope_Click
	
	Dim phone As Phone
		If phone.SdkVersion >= 30 Then		
		Dim i As Intent
		i.Initialize("android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION", "package:" & Application.PackageName)
		StartActivity(i)
	End If
End Sub


'End Sub

Private Sub btnFolder_Click'
	
	'Create Folder on Root
	File.MakeDir(File.DirRootExternal, "PermissionManager")

	
	'Check if folder is created then write a file inside
	If File.Exists(File.DirRootExternal, "PermissionManager")  Then
	
		LogColor("Folder created successfully or exist", xui.Color_Green)		
		
		Sleep(1000)
		
		'Create a text file in the folder
		File.WriteString(File.DirRootExternal &"/PermissionManager","text.txt","Hello world")
		
		Sleep(100)
		
		'Read the Text file
		LogColor(File.ReadString(File.DirRootExternal &"/PermissionManager","text.txt"),xui.Color_Blue)
	Else
		LogColor("No folder created.", xui.Color_Red)
	End If
	
	
	'List all folders in Dir Root	
	Wait For (File.ListFilesAsync(File.DirRootExternal)) Complete (Success As Boolean, Files As List)
	Log("Total Files and folders: " & Files.Size)
	
	If Files.Size > 0 Then
		For Each myFile In Files
			'Log(myFile)
			ListView1.AddSingleLine(myFile)
		Next
	End If

	
End Sub

