B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=7.3
@EndOfDesignText@
#Region Module Attributes
	#StartAtBoot: False
#End Region

'Service module
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub
Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	If StartingIntent.HasExtra("admin") Then
		Select StartingIntent.GetExtra("admin")
			Case "Enabled"
				Log("admin enabled")
				AdminEnabled
			Case "Disabled"
				Log("admin disabled")
			Case "PasswordChanged"
				Log("Password changed")
		End Select
	End If
End Sub
Sub AdminEnabled
	Main.manager.SetPasswordQuality(Main.manager.PASSWORD_QUALITY_NUMERIC, 4)
	If Main.manager.PasswordSufficient = False Then
		Main.manager.RequestNewPassword
	End If
End Sub
Sub Service_Destroy

End Sub
