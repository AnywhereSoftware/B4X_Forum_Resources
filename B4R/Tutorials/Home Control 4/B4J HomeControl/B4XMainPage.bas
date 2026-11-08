B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private fx As JFX
	Private MQTT As MqttClient
	Private MQTT_User As String = ""
	Private MQTT_Pass As String = ""
	Private MQTT_Broker As String = "tcp://test.mosquitto.org:1883"'change for other broker
	Private lblStatus As Label	
	Private ToggleButton1 As ToggleButton
	Private ToggleButton2 As ToggleButton
	Private ToggleButton3 As ToggleButton
	Private ToggleButton4 As ToggleButton			
	Private BTConnect As Button
	Private BTDisconnect As Button	
	Private BC As ByteConverter
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.GetNativeParent(Me).Resizable = False
	B4XPages.SetTitle(Me, "Home Control 4")
End Sub

'Connect to CloudMQTT broker
Sub MQTT_Connect
	Dim ClientId As String = Rnd(0, 999999999) 'create a unique id
	MQTT.Initialize("MQTT", MQTT_Broker, ClientId)
	Dim ConnOpt As MqttConnectOptions
	ConnOpt.Initialize(MQTT_User, MQTT_Pass)
	MQTT.Connect2(ConnOpt)
End Sub

'MQTT CONNECT AND SUBSCRIBE TO TOPIC
Sub MQTT_Connected (Success As Boolean)
	If Success = False Then
		Log(LastException)
		lblStatus.Text = "Error connecting"
	Else
		lblStatus.Text = "Connected"
		lblStatus.TextColor = fx.Colors.Red
		MQTT.Subscribe("ControlRelay4/#", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_1", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_2", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_3", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_4", 1)'change the name of the topic!
	End If
End Sub

'LABEL STATUS ON DISCONNECT
Private Sub MQTT_Disconnected
	lblStatus.Text = "Disconnected"
	lblStatus.TextColor = fx.Colors.Black
End Sub

'IT IS NOT USED AT THE MOMENT
Private Sub MQTT_MessageArrived (Topic As String, Payload() As Byte)
'...IN THE FUTURE WITH VERSION 2 YES...STAY TUNED!! :D
End Sub

'SEND TO ESP ON/OFF house alarm
Private Sub ToggleButton1_SelectedChange(Selected As Boolean)
	If lblStatus.Text = "Connected" Then		
		MQTT.Publish("Relay_1", BC.StringToBytes(Selected, "utf8"))		
		If Selected = True Then
			ToggleButton1.Text = "ON"
			ToggleButton1.TextColor = fx.Colors.Red
		Else
			ToggleButton1.Text = "OFF"
			ToggleButton1.TextColor = fx.Colors.Black
		End If
	Else
		xui.MsgboxAsync("You are not connected!","Home Control 4")
	End If		
End Sub

'SEND TO ESP ON/OFF garden light
Private Sub ToggleButton2_SelectedChange(Selected As Boolean)
	If lblStatus.Text = "Connected" Then
		MQTT.Publish("Relay_2", BC.StringToBytes(Selected, "utf8"))
		If Selected = True Then
			ToggleButton2.Text = "ON"
			ToggleButton2.TextColor = fx.Colors.Red
		Else
			ToggleButton2.Text = "OFF"
			ToggleButton2.TextColor = fx.Colors.Black
		End If
	Else
		xui.MsgboxAsync("You are not connected!","Home Control 4")
	End If	
End Sub

'SEND TO ESP ON/OFF garage light 
Private Sub ToggleButton3_SelectedChange(Selected As Boolean)
	If lblStatus.Text = "Connected" Then
		MQTT.Publish("Relay_3", BC.StringToBytes(Selected, "utf8"))
		If Selected = True Then
			ToggleButton3.Text = "ON"
			ToggleButton3.TextColor = fx.Colors.Red
		Else
			ToggleButton3.Text = "OFF"
			ToggleButton3.TextColor = fx.Colors.Black
		End If
	Else
		xui.MsgboxAsync("You are not connected!","Home Control 4")
	End If	
End Sub

'SEND TO ESP ON/OFF Motor Garage (HERE NEED IMPULSE)
Private Sub ToggleButton4_SelectedChange(Selected As Boolean)
	If lblStatus.Text = "Connected" Then
		MQTT.Publish("Relay_4", BC.StringToBytes(Selected, "utf8"))
		If Selected = True Then
			ToggleButton4.Text = "ON"
			ToggleButton4.TextColor = fx.Colors.Red

			Sleep(1000)
			
			ToggleButton4.Selected = False
			ToggleButton4.Text = "OFF"
			ToggleButton4.TextColor = fx.Colors.Black
		End If
	Else
		xui.MsgboxAsync("You are not connected!","Home Control 4")
	End If	
End Sub


'BUTTON CONNECT
Private Sub BTConnect_Click
	If lblStatus.Text = "Connected" Then
		xui.MsgboxAsync("You are Connected!","Home Control 4")
	Else
		MQTT_Connect
	End If
	
End Sub

'BUTTON DISCONNECT
Private Sub BTDisconnect_Click
	If MQTT.IsInitialized Then
		MQTT.Close
	End If	
	ExitApplication
End Sub
