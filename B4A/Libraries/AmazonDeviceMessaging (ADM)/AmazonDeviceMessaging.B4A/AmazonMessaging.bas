B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private am As AmazonMessaging
	Private adm As ADM

End Sub
Sub Service_Create
	am.Initialize("am")
	adm.Initialize("ADM")
End Sub
Sub AM_MessageArrived(MessageJSON As String)
	Log($"AM_MessageArrived(${MessageJSON})"$)
End Sub

Public Sub Register
	If adm.IS_ADM_AVAILABLE Then
		If adm.IS_ADM_V2 Then
			Log("ADM V2 supported on this Device!")
		Else
			Log("ADM supported on this Device!")
		End If
		
		Log("Check Manifest")
		adm.checkManifestAuthoredProperly
		
		'Log("Calling startRegister")
		StartRegister
	Else
		Log("ADM not supported on this Device!")
	End If
End Sub
Public Sub GetToken() As String
	If adm.Supported Then
		If adm.RegistrationId = Null Then
			adm.startRegister
		Else
			Return adm.RegistrationId
		End If
	End If
	Return ""
End Sub

public Sub StartRegister()
	Log("StartRegister()")
	If adm.Supported Then
		'Log("ADM 2nd check: ADM supported on this Device!")
		Log($"RegistrationId = ${adm.RegistrationId}"$)
		If adm.RegistrationId = Null Then
			adm.startRegister 
		Else
			Log($"RegistrationId = ${adm.RegistrationId}"$)
			Log($"Send the RegistrationId to your Server to track the users RegistrationId (this apps instance). This is the id your server sender app need to send messages to."$)
		End If
		
	End If
End Sub
Sub Service_Start (StartingIntent As Intent)
	If StartingIntent <> Null Then
		Log("AmazonMessaging Service_Start")
	  Log(StartingIntent)
		Log(StartingIntent.Action)
		Log(StartingIntent.ExtrasToString)
	End If
	am.HandleIntent(StartingIntent)
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy

End Sub
