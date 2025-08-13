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
	
	Public tDLocalizeSQL As SQL
End Sub

Sub Service_Create
	' initialize database chanel
	If tDLocalizeSQL.IsInitialized = False Then
		If File.exists(File.dirinternal,"TDLocalize.db") = False Then
			File.Copy(File.DirAssets,"TDLocalize.db",File.DirInternal,"TDLocalize.db")
		End If
		tDLocalizeSQL.Initialize(File.DirInternal,"TDLocalize.db",False)
	End If

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

End Sub
