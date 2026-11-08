B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=14
@EndOfDesignText@
Sub Process_Globals
	
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
    Log("StepReceiver triggered: " & StartingIntent.Action)
    
    ' Check permission before launching foreground service
    Dim rp As RuntimePermissions
    If rp.Check("android.permission.ACTIVITY_RECOGNITION") Then
        ' Start Foreground Service safely
        StartService(StepService)
    End If
End Sub