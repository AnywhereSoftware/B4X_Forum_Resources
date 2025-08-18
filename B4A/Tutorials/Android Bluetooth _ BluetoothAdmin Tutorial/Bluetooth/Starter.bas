B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public Manager As BluetoothManager
End Sub

Sub Service_Create
	Manager.Initialize
End Sub

Private Sub Service_Start (StartingIntent As Intent)
	
End Sub



'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
