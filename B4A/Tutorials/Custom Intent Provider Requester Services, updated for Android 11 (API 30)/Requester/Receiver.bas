B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=11.2
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
	LogColor("R.R.SS " & StartingIntent,Colors.Cyan)
	If StartingIntent <> Null Then
		Log("R.R.SS extras " & StartingIntent.ExtrasToString)
		If StartingIntent.Action.Contains("b4a.Requester.CALLBACK") And _
			StartingIntent.HasExtra("Successful") And _
			StartingIntent.GetExtra("Successful")="True" And _
			StartingIntent.HasExtra("Result") Then
			LogColor("R.R.SS Result = "&StartingIntent.GetExtra("Result"),Colors.Green)
		End If
	End If
	
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy

End Sub

