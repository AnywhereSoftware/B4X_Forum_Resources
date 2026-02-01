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
	Private voip As modVoice
	Public rp As RuntimePermissions
	Private lock As PhoneWakeState
'	Type RadioValues(bandwidth As Int, transmitFreq As Double, receiveFreq As Double, txCTCSS As Double, squelch As Int, rxCTCSS As Double)
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	lock.PartialLock
	If rp.Check("android.permission.RECORD_AUDIO")=True Then
		voip.Initialize(Me, "vx") ' initialize the library
		voip.vSetlistenport(0) ' can be any 0 for a random port or a non-reserved port that is not the same as the server's port
		voip.vSetVOXTrigger(0) 'turn off vox, a value of 3000 can be used to turn on vox with a sensitivity of 3000
		voip.vSetkey("JZ624RAS127878AF901C423910763350") ' must be set to exactly 32 bytes long and match the server key identically
		voip.vStartListening() ' listen for any received audio and messages
	Else
		ToastMessageShow("Be sure to enable Microphone Permission before running app.", True)
		ExitApplication
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
	lock.ReleasePartialLock
End Sub
Sub CreateNotification (Body As String) As Notification
	Dim notification As Notification
	notification.Initialize2(notification.IMPORTANCE_LOW)
	notification.Icon = "Icon"
	notification.SetInfo("Audio", Body, Main)
	Return notification
End Sub

Sub setHostPort(hst As String, port As String)
	voip.vSetHost(hst) 'ip or hostname where B9X Server is running
	voip.vSetPort(port) ' default port of B9X Server
End Sub
Sub vx_messageReceived(msg As String)
	CallSubDelayed2(Main, "voipMessage",msg) ' status and broadcast messages received
End Sub
Sub startSending
	voip.vStartSending ' send audio to all who are connected to the server
End Sub
Sub stopSending
	voip.vStopSending ' stop sending audio
End Sub
Sub connect
	Service.StartForeground(1, CreateNotification("Background Audio"))
	voip.vConnect("adminPassword") ' default admin password of server
End Sub
Sub close
	voip.vClose("adminPassword")' default admin password of server
End Sub
	
Sub broadCast(msg As String)
	voip.vBroadcast(msg) ' broadcast text message to all who are connected to server - broadcasting can also be used to send control or info messages
End Sub
Sub voxOn
	voip.vSetVOXTrigger(500) ' turn vox on with sensitivity of 3000 - lower values mean greater sensitivity
End Sub
Sub voxOff
	voip.vSetVOXTrigger(0) ' turn vox off
End Sub

