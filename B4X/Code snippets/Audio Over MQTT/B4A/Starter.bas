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
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public rp As RuntimePermissions
	Public mqtt As MqttClient
	Public audio As AudioStreamer
	Public mqttstatus As Boolean
	
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	
	Dim ClientId As String = Rnd(0, 999999999) 'create a unique id
	If mqtt.IsInitialized=False Then		
		mqtt.Initialize("mqtt","tcp://broker.hivemq.com:1883",ClientId)
	End If
	mqtt.Connect
	
	audio.Initialize("audio", 22050, True, 16, audio.VOLUME_SYSTEM)
	
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

Sub mqtt_Connected (Success As Boolean)
	Log(Success)
	mqttstatus=Success
	If Success Then
		audio.StartRecording
	End If
End Sub
	
Sub mqtt_Disconnected
	Log("disconnected")	
	mqttstatus=False
	audio.StopRecording	
End Sub

Sub audio_RecordBuffer (Data() As Byte)
	If mqttstatus Then
		mqtt.Publish("b4xexamplevoiceovermqtt\stream",Data) 	'only change this on both sides B4A-B4J
	End If
End Sub