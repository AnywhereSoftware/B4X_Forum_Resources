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
	Private MQTT As MqttClient
	Private MQTTUser As String = "teste"
	Private MQTTPassword As String = "Pp1c2s3m4"
	Private MQTTServerURI As String = "tcp://broker.hivemq.com:1883"'change for other broker
	Private BC As ByteConverter
	Private Conectar As Button
	Private Desconectar As Button
	
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
	Private Button8 As Button
	Private Button4 As Button
	Private Button5 As Button
	Private Button6 As Button
	Private Button7 As Button
	Private Button8 As Button
	
	
	Private IV1 As B4XView
	Private IV2 As B4XView
	Private IV3 As B4XView
	Private IV4 As B4XView
	Private IV5 As B4XView
	Private IV6 As B4XView
	Private IV7 As B4XView
	Private IV8 As B4XView
	
	Private Start1,Start2,Start3,Start4,Start5,Start6,Start7,Start8 As Boolean
	Private Rel1,Rel2,Rel3,Rel4,Rel5,Rel6,Rel7,Rel8 As String
	

	Private s_Menu() As String
	Private Panel2 As Panel
    Private Panel1 As B4XView
	Private EditText1 As EditText
	Private EditText2 As EditText
	Private Salvar As Button
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Panel2.Visible=True
	Panel1.Visible=False

'	If File.Exists(File.DirInternal,"Dados.txt")=False Then 'se o arquivo de texto "mac.txt" contendo o endereço MAC padrão do host não existir
'		File.WriteString(File.DirInternal,"Dados.txt","")	  'a criá-lo, com dados nulos
'	End If
	
	s_Menu = Array As String("Configura","Controle")
    #if B4A
	For Each sName As String In s_Menu
		B4XPages.AddMenuItem(Me, sName)
	Next
    #End If
    
	
	Dim cs As CSBuilder
	cs.Initialize.Size(28).BackgroundColor(xui.Color_Yellow).Color(xui.Color_Red).Append("Controle").Pop.Color(xui.Color_Blue) _
        .Append(" Rev.1").Pop.color(xui.Color_Black).Append(" By César").Popall
	B4XPages.SetTitle(Me,cs)
	
	'Dim cs As CSBuilder
	'B4XPages.SetTitle(Me,cs.Initialize.Color(xui.Color_Red).Append("      Casa Controle Ver.1.0").PopAll)
	'B4XPages.SetTitle(Me, "Casa Controle Ver.1.0")
	Button1.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button1.Gravity = Gravity.CENTER_HORIZONTAL
	Button2.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button2.Gravity = Gravity.CENTER_HORIZONTAL
	Button3.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button3.Gravity = Gravity.CENTER_HORIZONTAL
	Button4.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button4.Gravity = Gravity.CENTER_HORIZONTAL
	Button5.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button5.Gravity = Gravity.CENTER_HORIZONTAL
	Button6.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button6.Gravity = Gravity.CENTER_HORIZONTAL
	Button7.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button7.Gravity = Gravity.CENTER_HORIZONTAL
	Button8.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
	Button8.Gravity = Gravity.CENTER_HORIZONTAL
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
'Connect to CloudMQTT broker
Sub MQTT_Connect
	Dim ClientId As String = Rnd(0, 999999999) 'create a unique id
	MQTT.Initialize("MQTT", MQTTServerURI, ClientId)
	Dim ConnOpt As MqttConnectOptions
	'MQTTUser=Nome.Text
	'MQTTPassword=Senha.Text
	ConnOpt.Initialize(MQTTUser, MQTTPassword)
	MQTT.Connect2(ConnOpt)
End Sub

'MQTT CONNECT AND SUBSCRIBE TO TOPIC
Sub MQTT_Connected (Success As Boolean)
	If Success = False Then
		Log(LastException)
		xui.MsgboxAsync("Error de Conexão","")
	Else
		Conectar.Text = "Conectado"
		Conectar.TextColor = xui.Color_Red
        MQTT.Subscribe("ControlRelay4/#", 1)'change the name of the topic!
		MQTT.Subscribe("Relay_1",Chr(0)1)'change the name of the topic!
		MQTT.Subscribe("Relay_2",1)'change the name of the topic!
		MQTT.Subscribe("Relay_3",1)'change the name of the topic!
		MQTT.Subscribe("Relay_4",1)'change the name of the topic!
		MQTT.Subscribe("Relay_5",1)'change the name of the topic!
		MQTT.Subscribe("Relay_6",1)'change the name of the topic!
		MQTT.Subscribe("Relay_7",1)'change the name of the topic!
		MQTT.Subscribe("Relay_8",1)'change the name of the topic!
	End If
End Sub

Sub B4XPage_MenuClick (Tag As String)
	If Tag = "menu" Then 'für iOS Hauptmenü, quasi Sub pg_BarButtonClick (Tag As String)
        #if B4i
        Dim sheet As ActionSheet
        sheet.Initialize("sheet", "", "Cancel", "", s_Menu)
        sheet.Show(Root)
        Wait For sheet_Click (result As String)
        B4XPage_MenuClick(result)
        #End If
	Else
		Dim iIndex As Int = GetIndexInArray(s_Menu, Tag)
		Select iIndex
			Case 0 'Configurar
				Panel1.Visible=True
				Panel2.Visible=False
			Case 1 'Controle
				Panel2.Visible=True
				Panel1.Visible=False
		End Select
	End If
End Sub

Sub GetIndexInArray(arr() As String, txt As String) As Int
	Dim iIndex As Int = -1, iCount As Int = 0
	For Each sTxt As String In arr
		If sTxt = txt Then iIndex = iCount
		iCount = iCount + 1
	Next
	Return iIndex
End Sub

Private Sub Conectar_Click
	If Conectar.Text = "Conectado" Then
		xui.MsgboxAsync("Você está Conectado!","Casa Controle 1")
	Else
		MQTT_Connect
	End If
End Sub

Private Sub Desconectar_Click
	If MQTT.IsInitialized Then
		MQTT.Close
	End If
	ExitApplication
End Sub

Private Sub Button1_Click
	If Conectar.Text = "Conectado" Then
		If Rel1 = 0 Then
	        Rotate_IV1
			Button1.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
			Button1.Gravity = Gravity.CENTER_HORIZONTAL
			Start1 = True
			MQTT.Publish("Relay_1", BC.StringToBytes(Start1, "utf8"))
			Rel1 = 1
		Else
		    Rotate_IV1
			Button1.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
			Button1.Gravity = Gravity.CENTER_HORIZONTAL
			Start1 = False
			MQTT.Publish("Relay_1", BC.StringToBytes(Start1, "utf8"))
			Rel1 = 0
		    End If
	Else
		    xui.MsgboxAsync("Você Não Conectado!","Casa Controle 1")
	End If
	
End Sub

Private Sub Button2_Click
	If Conectar.Text = "Conectado" Then
		If Rel2 = 0 Then
			Rotate_IV2
			Button2.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
			Button2.Gravity = Gravity.CENTER_HORIZONTAL
			Start2 = True
			MQTT.Publish("Relay_2", BC.StringToBytes(Start2, "utf8"))
			Rel2 = 1
		Else
			Rotate_IV2
			Button2.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
			Button2.Gravity = Gravity.CENTER_HORIZONTAL
			Start2 = False
			MQTT.Publish("Relay_2", BC.StringToBytes(Start2, "utf8"))
			Rel2 = 0
		End If
	Else
		xui.MsgboxAsync("Você Não Conectado!","Casa Controle 1")
	End If
End Sub

Private Sub Button3_Click
	If Conectar.Text = "Conectado" Then
		If Rel3 = 0 Then
			Rotate_IV3
			Button3.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
			Button3.Gravity = Gravity.CENTER_HORIZONTAL
			Start3 = True
			MQTT.Publish("Relay_3", BC.StringToBytes(Start3, "utf8"))
			Rel3 = 1
		Else
			Rotate_IV3
			Button3.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
			Button3.Gravity = Gravity.CENTER_HORIZONTAL
			Start3 = False
			MQTT.Publish("Relay_3", BC.StringToBytes(Start3, "utf8"))
			Rel3 = 0
		End If
	Else
		xui.MsgboxAsync("Você Não Conectado!","Casa Controle 1")
	End If
End Sub

Private Sub Button4_Click
	If Conectar.Text = "Conectado" Then
		If Rel4 = 0 Then
			Rotate_IV4
			Button4.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
			Button4.Gravity = Gravity.CENTER_HORIZONTAL
			Start4 = True
			MQTT.Publish("Relay_4", BC.StringToBytes(Start4, "utf8"))
			Rel4 = 1
		Else
			Rotate_IV4
			Button4.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
			Button4.Gravity = Gravity.CENTER_HORIZONTAL
			Start4 = False
			MQTT.Publish("Relay_4", BC.StringToBytes(Start4, "utf8"))
			Rel4 = 0
		End If
	Else
		xui.MsgboxAsync("Você Não Conectado!","Casa Controle 1")
	End If
End Sub

Private Sub Button5_Click
	If Conectar.Text = "Conectado" Then
		If Rel5 = 0 Then
			Rotate_IV5
			Button5.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
			Button5.Gravity = Gravity.CENTER_HORIZONTAL
			Start5 = True
			MQTT.Publish("Relay_5", BC.StringToBytes(Start5, "utf8"))
			Rel5 = 1
		Else
			Rotate_IV5
			Button5.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
			Button5.Gravity = Gravity.CENTER_HORIZONTAL
			Start5 = False
			MQTT.Publish("Relay_5", BC.StringToBytes(Start5, "utf8"))
			Rel5 = 0
		End If
	Else
		xui.MsgboxAsync("Você Não Conectado!","Casa Controle 1")
	End If
End Sub

Private Sub Button6_Click
	If Conectar.Text = "Conectado" Then
		If Rel6 = 0 Then
			Rotate_IV6
			Button6.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
			Button6.Gravity = Gravity.CENTER_HORIZONTAL
			Start6 = True
			MQTT.Publish("Relay_6", BC.StringToBytes(Start6, "utf8"))
			Rel6 = 1
		Else
			Rotate_IV6
			Button6.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
			Button6.Gravity = Gravity.CENTER_HORIZONTAL
			Start6 = False
			MQTT.Publish("Relay_6", BC.StringToBytes(Start6, "utf8"))
			Rel6 = 0
		End If
	Else
		xui.MsgboxAsync("Você Não Conectado!","Casa Controle 1")
	End If
End Sub

Private Sub Button7_Click
	If Conectar.Text = "Conectado" Then
		If Rel7 = 0 Then
			Rotate_IV7
			Button7.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
			Button7.Gravity = Gravity.CENTER_HORIZONTAL
			Start7 = True
			MQTT.Publish("Relay_7", BC.StringToBytes(Start7, "utf8"))
			Rel7 = 1
		Else
			Rotate_IV7
			Button7.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
			Button7.Gravity = Gravity.CENTER_HORIZONTAL
			Start7 = False
			MQTT.Publish("Relay_7", BC.StringToBytes(Start7, "utf8"))
			Rel7 = 0
		End If
	Else
		xui.MsgboxAsync("Você Não Conectado!","Casa Controle 1")
	End If
End Sub

Private Sub Button8_Click
	If Conectar.Text = "Conectado" Then
		If Rel8 = 0 Then
			Rotate_IV8
			Button8.SetBackgroundImage(LoadBitmap(File.DirAssets, "btoff.png"))
			Button8.Gravity = Gravity.CENTER_HORIZONTAL
			Start8 = True
			MQTT.Publish("Relay_8", BC.StringToBytes(Start8, "utf8"))
			Rel8 = 1
		Else
			Rotate_IV8
			Button8.SetBackgroundImage(LoadBitmap(File.DirAssets, "bton.png"))
			Button8.Gravity = Gravity.CENTER_HORIZONTAL
			Start8 = False
			MQTT.Publish("Relay_8", BC.StringToBytes(Start8, "utf8"))
			Rel8 = 0
		End If
	Else
		xui.MsgboxAsync("Você Não Conectado!","Casa Controle 1")
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

Private Sub Rotate_IV2
	IV2.Visible = True
	For i = 1 To 180 Step 5
		IV2.Rotation = (i)
		Sleep(0)
	Next
	IV2.Visible = False
End Sub

Private Sub Rotate_IV3
	IV3.Visible = True
	For i = 1 To 180 Step 5
		IV3.Rotation = (i)
		Sleep(0)
	Next
	IV3.Visible = False
End Sub


Private Sub Rotate_IV4
	IV4.Visible = True
	For i = 1 To 180 Step 5
		IV4.Rotation = (i)
		Sleep(0)
	Next
	IV4.Visible = False
End Sub

Private Sub Rotate_IV5
	IV5.Visible = True
	For i = 1 To 180 Step 5
		IV5.Rotation = (i)
		Sleep(0)
	Next
	IV5.Visible = False
End Sub

Private Sub Rotate_IV6
	IV6.Visible = True
	For i = 1 To 180 Step 5
		IV6.Rotation = (i)
		Sleep(0)
	Next
	IV6.Visible = False
End Sub

Private Sub Rotate_IV7
	IV7.Visible = True
	For i = 1 To 180 Step 5
		IV7.Rotation = (i)
		Sleep(0)
	Next
	IV7.Visible = False
End Sub

Private Sub Rotate_IV8
	IV8.Visible = True
	For i = 1 To 180 Step 5
		IV8.Rotation = (i)
		Sleep(0)
	Next
	IV8.Visible = False
End Sub


Private Sub Salvar_Click
	
End Sub