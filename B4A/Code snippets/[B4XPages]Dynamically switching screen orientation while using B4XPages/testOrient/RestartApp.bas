B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=11
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
	StartActivity(B4XPages.GetNativeParent(Me))
End Sub

Sub Service_Destroy

End Sub
