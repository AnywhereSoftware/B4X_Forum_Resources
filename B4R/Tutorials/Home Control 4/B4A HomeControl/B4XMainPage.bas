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
	Private MQTT As MqttClient
	Private MQTTUser As String = ""
	Private MQTTPassword As String = ""
	Private MQTTServerURI As String = "tcp://test.mosquitto.org:1883"'change for other broker
	Private State1 As Boolean
	Private State2 As Boolean
	Private State3 As Boolean
	Private State4 As Boolean		
	Private BTConnect As Button
	Private BTDisconnect As Button
	Private BC As ByteConverter
	Private Panel1 As Panel
	Private Panel2 As Panel
	Private Panel3 As Panel
	Private Panel4 As Panel	
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
	Private IV1 As B4XView
	Private IV2 As B4XView
	Private IV3 As B4XView
	Private IV4 As B4XView
	Private LbBt1 As Label
	Private LbBt2 As Label
	Private LbBt3 As Label
	Private LbBt4 As Label
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("designer_button.bal")
	B4XPages.SetTitle(Me, "Home Control 4 Ver.1.0")
	Button1.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button1.Gravity = Gravity.CENTER_HORIZONTAL
	Button2.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button2.Gravity = Gravity.CENTER_HORIZONTAL
	Button3.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button3.Gravity = Gravity.CENTER_HORIZONTAL
	Button4.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button4.Gravity = Gravity.CENTER_HORIZONTAL

End Sub

'Connect to CloudMQTT broker
Sub MQTT_Connect
	Dim ClientId As String = Rnd(0, 999999999) 'create a unique id
	MQTT.Initialize("MQTT", MQTTServerURI, ClientId)
	Dim ConnOpt As MqttConnectOptions
	ConnOpt.Initialize(MQTTUser, MQTTPassword)
	MQTT.Connect2(ConnOpt)
End Sub

'MQTT CONNECT AND SUBSCRIBE TO TOPIC
Sub MQTT_Connected (Success As Boolean)
	If Success = False Then
		Log(LastException)
		xui.MsgboxAsync("Error connecting","")
	Else
		BTConnect.Text = "Connected"
		BTConnect.TextColor = xui.Color_Red

		MQTT.Subscribe("ControlRelay4/#", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_1", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_2", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_3", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_4", 1)'change the name of the topic!
	End If
End Sub

'STATUS ON DISCONNECT
Private Sub MQTT_Disconnected
	Log("Disconnected")
End Sub

'IT IS NOT USED AT THE MOMENT
Private Sub MQTT_MessageArrived (Topic As String, Payload() As Byte)
	'...IN THE FUTURE WITH VERSION 2 YES...STAY TUNED!!	:D
End Sub


'BUTTON CONNECT
Private Sub BTConnect_Click
	If BTConnect.Text = "Connected" Then
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


Private Sub Button1_Click
	If BTConnect.Text = "Connected" Then
		
		Select Case LbBt1.text
						
			Case "OFF"
				Rotate_IV1
				Button1.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
				Button1.Gravity = Gravity.CENTER_HORIZONTAL
				LbBt1.Text = "ON"
				State1 = True
				MQTT.Publish("Relay_1", BC.StringToBytes(State1, "utf8"))
				
			Case "ON"
				Rotate_IV1
				Button1.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
				Button1.Gravity = Gravity.CENTER_HORIZONTAL
				LbBt1.Text = "OFF"
				State1 = False
				MQTT.Publish("Relay_1", BC.StringToBytes(State1, "utf8"))
				
		End Select	
	Else
		xui.MsgboxAsync("You are not connected!","Home Control 4")
	End If
	
End Sub

Private Sub Button2_Click
	If BTConnect.Text = "Connected" Then
		
		Select Case LbBt2.text
						
			Case "OFF"
				Rotate_IV2
				Button2.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
				Button2.Gravity = Gravity.CENTER_HORIZONTAL
				LbBt2.Text = "ON"
				State2 = True
				MQTT.Publish("Relay_2", BC.StringToBytes(State2, "utf8"))
				
			Case "ON"
				Rotate_IV2
				Button2.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
				Button2.Gravity = Gravity.CENTER_HORIZONTAL
				LbBt2.Text = "OFF"
				State2 = False
				MQTT.Publish("Relay_2", BC.StringToBytes(State2, "utf8"))
				
		End Select		
	Else
		xui.MsgboxAsync("You are not connected!","Home Control 4")
	End If
End Sub

Private Sub Button3_Click
	If BTConnect.Text = "Connected" Then
		
		Select Case LbBt3.text
						
			Case "OFF"
				Rotate_IV3
				Button3.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
				Button3.Gravity = Gravity.CENTER_HORIZONTAL
				LbBt3.Text = "ON"
				State3 = True
				MQTT.Publish("Relay_3", BC.StringToBytes(State3, "utf8"))
				
			Case "ON"
				Rotate_IV3
				Button3.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
				Button3.Gravity = Gravity.CENTER_HORIZONTAL
				LbBt3.Text = "OFF"
				State3 = False
				MQTT.Publish("Relay_3", BC.StringToBytes(State3, "utf8"))
				
		End Select
	Else
		xui.MsgboxAsync("You are not connected!","Home Control 4")
	End If
End Sub

'Motor Garage ON/OFF impulse (HERE NEED IMPULSE)
Private Sub Button4_Click
	If BTConnect.Text = "Connected" Then
		
		Select Case LbBt4.text
						
			Case "OFF"
				Rotate_IV4
				Button4.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
				Button4.Gravity = Gravity.CENTER_HORIZONTAL
				LbBt4.Text = "ON"
				State4 = True
				MQTT.Publish("Relay_4", BC.StringToBytes(State4, "utf8"))				

				Sleep(1000)
				
				Rotate_IV4
				Button4.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
				Button4.Gravity = Gravity.CENTER_HORIZONTAL
				LbBt4.Text = "OFF"
				
		End Select
	Else
		xui.MsgboxAsync("You are not connected!","Home Control 4")
	End If
End Sub

'Rotate IV1
Private Sub Rotate_IV1
	IV1.Visible = True
	For i = 1 To 180 Step 5
		IV1.Rotation = (i)
		Sleep(0)
	Next
	IV1.Visible = False
End Sub

'Rotate IV2
Private Sub Rotate_IV2
	IV2.Visible = True
	For i = 1 To 180 Step 5
		IV2.Rotation = (i)
		Sleep(0)
	Next
	IV2.Visible = False
End Sub

'Rotate IV3
Private Sub Rotate_IV3
	IV3.Visible = True
	For i = 1 To 180 Step 5
		IV3.Rotation = (i)
		Sleep(0)
	Next
	IV3.Visible = False
End Sub

'Rotate IV4
Private Sub Rotate_IV4
	IV4.Visible = True
	For i = 1 To 180 Step 5
		IV4.Rotation = (i)
		Sleep(0)
	Next
	IV4.Visible = False
End Sub