B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.9
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public rp As RuntimePermissions
	Dim af As aftpclient
	Public Root_FTPfolder As String = "/"
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy
If af.IsInitialized Then
	af.Close_FTP
	af = Null
End If
End Sub

Sub StartFTP
	af.Initialize(Me, Main.folder, "ftp.host", "userlogin", "password", 21, 10)	'edit according to your FTP-account
	af.Connect(Root_FTPfolder)
End Sub

'callback event from FTP work: log and files info - edit this sub as your algorithm needs to process files
Sub aftp_event(details As Map)
	If details.IsInitialized = False Then Return
	
	
	'now it's just FTP exchange logging
	#if debug 
		Dim a As StringBuilder:	a.Initialize
		a.Append(details.Get("eventkind"))
		a.Append(": ").Append(details.Get("message"))
		Dim fileinfo As FTPEntry2 = details.Get("file")
		If fileinfo <> Null Then
			If fileinfo.IsInitialized Then
				a.Append("; file = " & fileinfo.Name & ", size = " & fileinfo.Size & ", date = " & DateTime.Date(fileinfo.Timestamp) & " " & DateTime.Time(fileinfo.Timestamp))
			End If
		End If
		Log("aftp_event = " & a.ToString)
	#end if
End Sub

