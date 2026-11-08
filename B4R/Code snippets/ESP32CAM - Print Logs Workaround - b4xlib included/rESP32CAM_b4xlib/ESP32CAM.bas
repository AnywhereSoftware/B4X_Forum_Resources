B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.9
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Dim mqco As MqttConnectOptions
	Dim mq As MqttClient
	
End Sub

Sub Initialize(wificlient As WiFiSocket, IP() As Byte, Port As UInt, mqttusername As String, mqttpassword As String)
	Log("Got in initialize")
	mqco.Initialize(mqttusername, mqttpassword)
	ConnectMQTT(0, wificlient, IP, Port, mqttusername, mqttpassword)
End Sub


Sub ConnectMQTT(iCount As Byte, wificlient As WiFiSocket, IP() As Byte, Port As UInt, mqttusername As String, mqttpassword As String)
	Log("Got in ConnectMQTT")
	
	mq.Initialize(wificlient.Stream, IP, Port, "esp32webcam", "mq_MessageArrived", "mq_Disconnected")
	If mq.Connect2(mqco) = True Then
		Log("connected to MQTT Broker")
		mq.Publish("/esp32webcam/logs", "I am online".GetBytes)
		
	Else
		Delay(100)
		Log("Got in no connectMQTT")
		If iCount + 1 < 3 Then
			Delay(2000)
			ConnectMQTT(iCount + 1, wificlient, IP, Port, mqttusername, mqttpassword)
		End If
		
	End If
End Sub


Sub Log2(Message As String)
	mq.Publish("/esp32webcam/logs", Message.GetBytes)
End Sub

Sub mq_MessageArrived (Topic As String, Payload() As Byte)
	
End Sub

Sub mq_Disconnected
	
End Sub


