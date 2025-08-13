B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.85
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals

End Sub

Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground
End Sub

Sub Service_TaskRemoved

End Sub

Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub