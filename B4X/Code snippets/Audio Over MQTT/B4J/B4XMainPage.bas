B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Public mqtt As MqttClient
	Public audio As AudioRecord
	Public PDA As PlayDataAudio
	Public mqttstatus As Boolean
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Dim ClientId As String = Rnd(0, 999999999) 'create a unique id
	If mqtt.IsInitialized=False Then
		mqtt.Initialize("mqtt","tcp://broker.hivemq.com:1883",ClientId)
	End If
	mqtt.Connect
	
	audio.Initialize(22050, 16,audio.CH_CONF_STEREO)
	PDA.Initialize
	
	
End Sub


Sub mqtt_Connected (Success As Boolean)
	Log(Success)
	mqttstatus=Success
	If Success Then
		mqtt.Subscribe("b4xexamplevoiceovermqtt\stream",0)  'only change this on both sides B4A-B4J
	End If
End Sub
	
Sub mqtt_Disconnected
	Log("disconnected")
	mqttstatus=False
	audio.Stop
	PDA.StopAudioPlayer
End Sub


Sub mqtt_MessageArrived (Topic As String, Payload() As Byte)
	audio.Start
	PDA.StartAudioPlayer
	PDA.SendDataPlayer(Payload)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
