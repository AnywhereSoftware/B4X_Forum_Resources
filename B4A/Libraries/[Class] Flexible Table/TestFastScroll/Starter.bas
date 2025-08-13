B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public SQL1 As SQL
	
	Public DBPath = File.DirInternal As String
	Public DBFileName = "citylist.db" As String
	Public DBTableName = "citylist" As String
End Sub

Sub Service_Create
	If File.Exists(DBPath, DBFileName) = False Then
		File.Copy(File.DirAssets, DBFileName, DBPath, DBFileName)
	End If
	SQL1.Initialize(File.DirInternal, DBFileName, False)
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved

End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
