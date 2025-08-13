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
	Dim wifi As MLwifi
	Private Root As B4XView
	Private xui As XUI
	Public ActionBarHomeClicked As Boolean
	Public AStreams As AsyncStreams
	Dim Server As ServerSocket
	Dim Socket1 As Socket
	Public SMS As PhoneSms
	Public PE As PhoneEvents
	Public PhoneID As PhoneId
	Private rp As RuntimePermissions
	Public brktmr As Timer
	
	Private Label1 As Label
	Public EditText2 As EditText
	Private Button1 As Button
	Dim pws As PhoneWakeState
	Dim Connesso As Boolean
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
	Private SimpleProgressBar1 As SimpleProgressBar
	Private SimpleProgressBar2 As SimpleProgressBar
	Private SimpleProgressBar3 As SimpleProgressBar
	Dim Batteria As String
	Private PSL As PhoneStateListener
	Private CheckBox1 As CheckBox
End Sub

Public Sub Initialize
	PSL.Initialize("PSL",True)
	PSL.startListeningForEvent(PSL.LISTEN_SIGNAL_STRENGTHS)
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	
	Root.LoadLayout("MainPage")
'	txtLog.Color=Colors.DarkGray
	EditText2.Color=Colors.DarkGray
	Button1.Color = Colors.White
'	Button2.Color = Colors.Blue
	
	B4XPages.SetTitle(Me,"Non Connesso Smart Salon")
	Connesso=False
'	pws.ReleaseKeepAlive    ' display stays off
'	pws.KeepAlive(True)     ' display stays on
'	pws.KeepAlive(True)
	pws.PartialLock

	'initialize events for SMS statuses at needed Activity or Service
	PE.InitializeWithPhoneState("PE",PhoneID)

	pws.PartialLock
	If rp.Check(rp.PERMISSION_SEND_SMS)=False Then
		rp.CheckAndRequest(rp.PERMISSION_SEND_SMS)
	End If
		

		Server.Initialize(5500, "Server")
		Server.Listen
	
		Log("MyIp = " & Server.GetMyIP)
		Label1.Text = "IP App: " & Server.GetMyIP

'	serial1.Initialize("serial1")
	StartService(modSMS)
	B4XPages.SetTitle(Me,"Non Connesso Smart Salon")
	Connesso=False
		
	If Not(wifi.isWifiConnected) Then
		wifi.EnableWifi(True)
	End If
	
	brktmr.Initialize("brktmr", 2000)
	brktmr.Enabled = True
	
	
	'Dovrebbe consentire lo spegnimento del diplay ma non lo sleep della cpu. Altrimenti pws.KeepAlive(True)  che disabilita ogni funzione di risparmio energetico
'	
	'pws.PartialLock
	pws.KeepAlive(True)
	EditText2.Text = "Android " & GetSDKversion & " sdk" & GetSDK
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub brktmr_Tick
	
	If Main.vaixx = False Then 
		Return
	End If
	
'	Log("brk Ticked")
	brktmr.Enabled = False
	If CheckBox1.Checked Then
		brktmr.Interval=2000
	Else
		brktmr.Interval=4000
	End If
	
	If Connesso=False Then
		Server.Listen
		Log("MyIp = " & Server.GetMyIP)
		Label1.Text = "IP App: " & Server.GetMyIP
	End If
	
	Dim S As Int = Starter.getGsmSignalStrength
	If s > 100 Then s =100
	Label2.Text = Label2.Text & " " & S & "%"
	
	Dim RedDisponible As Phone
	Log("GetNetworkOperatorName: "&RedDisponible.GetNetworkOperatorName)
	Log("Gettipo =NetworkType: "&RedDisponible.GetNetworkType)
	Log("GetPhoneType: " & RedDisponible.GetPhoneType)

	If  RedDisponible.GetNetworkOperatorName <> "" And RedDisponible.GetNetworkType <> "UNKNOWN" Then
		Log("Red Disponible")
		Dim Tipo As String 
		If RedDisponible.GetNetworkType = "LTE" Then
			Tipo= " 4G"
		Else 
			Tipo= " 3G"							
		End If
		
		Label2.Text = RedDisponible.GetNetworkOperatorName & " - " & RedDisponible.GetNetworkType & Tipo  & " " & S & "%"
		
		If S > 50 Then
'			Label2.Color = Colors.green
			Starter.Colore = "Green"
		else if S <= 50 And S > 10 Then
			Starter.Colore = "Yellow"
		Else
'			Label2.Color = 0xFFFF7700 'arancione
			Starter.Colore = "Red"
		End If

		SimpleProgressBar3.Invalidate
		SimpleProgressBar3.Value = S

	Else
		Log("Red no disponible")
		Label2.Text = RedDisponible.GetNetworkOperatorName
		Label2.Color = Colors.red
	End If

	Wait For (GetWifiInfo) Complete (WifiInfo As JavaObject)
	If WifiInfo.IsInitialized Then
		Log(WifiInfo.RunMethod("getSSID", Null))
		Log(wifi.WifiStrength)
		Label3.Text = "Wifi " & WifiInfo.RunMethod("getSSID", Null) & " " & wifi.WifiStrength & "%"
		If wifi.WifiStrength > 50 Then
'			Label3.Color = Colors.green
			Starter.Colore = "Green"
		else if wifi.WifiStrength <= 50 And wifi.WifiStrength > 10 Then
			Starter.Colore = "Yellow"
		Else
'			Label3.Color = Colors.red
			Starter.Colore = "Red"
		End If

		SimpleProgressBar2.Invalidate
		SimpleProgressBar2.Value = wifi.WifiStrength

	End If
	
	If Connesso=False Then
		Dim Ricevi As String = "|"
		AStreams.Write(Ricevi.GetBytes("UTF8"))
	Else
		Dim Ricevi As String = "Dati%," & S & "," & wifi.WifiStrength & "," & Batteria
		AStreams.Write(Ricevi.GetBytes("UTF8"))
	End If
'	If Clip.GetText.Length = 8 Then
'		Dim Ricevi As String = "Clip%," & Clip.GetText
'		AStreams.Write(Ricevi.GetBytes("UTF8"))
	''		Clip.clrText
'	End If

	Incolla
	
'	CancellaClip
	
	brktmr.Enabled = True
	
	

End Sub

Sub GetWifiInfo As ResumableSub
'	Dim p As Phone
	Dim WifiManager As JavaObject
	Dim WifiInfo As JavaObject
	WifiManager = WifiManager.InitializeContext.RunMethod("getSystemService", Array("wifi"))
'	If p.SdkVersion >= 27 Then
'		Dim rp As RuntimePermissions
'		rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
'		Wait For Activity_PermissionResult (Permission As String, Result As Boolean)
'		If Result = False Then Return WifiInfo
'	End If
	WifiInfo = WifiManager.RunMethod("getConnectionInfo", Null)
	Return WifiInfo
End Sub

Sub Server_NewConnection (Successful As Boolean, NewSocket As Socket)
	Label1.Text = "IP App: " & Server.GetMyIP
	If Successful Then
		ToastMessageShow("Connected", False)
		B4XPages.SetTitle(Me,"Connesso Smart Salon")
		Connesso=True
		Socket1 = NewSocket
		'Can only use prefix mode if both sides of the connection implement the prefix protocol!!!
		AStreams.Initialize(Socket1.InputStream, Socket1.OutputStream, "AStreams")
	Else
		ToastMessageShow(LastException.Message, True)
	End If
	Server.Listen
	brktmr.Enabled = True
End Sub

Sub AStreams_NewData (Buffer() As Byte)
	Dim s As String = BytesToString(Buffer, 0, Buffer.Length, "UTF8")
	
	LogMessage("Inviato > ", s.Replace("|",CRLF) & CRLF & CRLF)
	
	PE.InitializeWithPhoneState("PE", PhoneID)
'	Dim WantSentStatus As Boolean = True
'	Dim WantDeliveryNotification As Boolean = False
	Dim Messaggio() As String =Regex.Split("\|",s)
	Log(Messaggio(0))
	If Messaggio.Length>1 Then Log(Messaggio(1))
	Try
'		SMS.Send2(Messaggio(0),Messaggio(1),WantSentStatus,WantDeliveryNotification)
		If Messaggio.Length>2 Then
			SendLargeSms(Messaggio(0),Messaggio(1),Messaggio(2))
		End If
	Catch
		Log("Error when sending: " & LastException.Message)
	End Try


End Sub

Sub SendLargeSms(Destination As String, Message As String, Extra As String)
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim smsManager As JavaObject
	smsManager = smsManager.InitializeStatic("android.telephony.SmsManager").RunMethod("getDefault", Null)
	Dim parts As JavaObject = smsManager.RunMethod("divideMessage", Array As String (Message))
	Dim size As Int = parts.RunMethod("size", Null)
 
	Dim i As Intent
	i.Initialize("b4a.smssent", "")
	i.PutExtra("phone", Destination)
	i.PutExtra("message_sms", Message)
	i.PutExtra("message_id", Extra)
	Dim pi As JavaObject
	pi = pi.InitializeStatic("android.app.PendingIntent").RunMethod("getBroadcast", _
     Array(ctxt, 0, i, 134217728))
 
'	Dim i2 As Intent
'	i2.Initialize("b4a.smsdelivered", "")
'	i2.PutExtra("phone", Destination)
'	i2.PutExtra("message_id", Extra)
'	Dim pi2 As JavaObject
'	pi2 = pi2.InitializeStatic("android.app.PendingIntent").RunMethod("getBroadcast", _
	'     Array(ctxt, 0, i2, 134217728))
 
	Dim al, al2 As JavaObject
	al.InitializeNewInstance("java.util.ArrayList", Null)
	al2.InitializeNewInstance("java.util.ArrayList", Null)
	For ii = 0 To size - 2
		al.RunMethod("add", Array(Null))
		al2.RunMethod("add", Array(Null))
	Next
	al.RunMethod("add", Array(pi))
'	al2.RunMethod("add", Array(pi2))
'	smsManager.RunMethod("sendMultipartTextMessage", Array(Destination, Null, parts, al, al2))

	If Extra <>"No" Then
'		CheckBox1.Checked=True
		smsManager.RunMethod("sendMultipartTextMessage", Array(Destination, Null, parts, al, Null))
	Else
'		CheckBox1.Checked=False
		smsManager.RunMethod("sendMultipartTextMessage", Array(Destination, Null, parts, Null, Null))
	End If
	
End Sub

Sub LogMessage(From As String, Msg As String)
	EditText2.Text =  From & ": " & Msg & CRLF
'	txtLog.SelectionStart = txtLog.Text.Length
End Sub

Sub AStreams_Error
	B4XPages.SetTitle(Me,"Non Connesso Smart Salon")
	Connesso=False
	ToastMessageShow(LastException.Message, True)
	Log("AStreams_Error")
End Sub

Sub AStreams_Terminated
	B4XPages.SetTitle(Me,"Non Connesso Smart Salon")
	Connesso=False
	Log("AStreams_Terminated")
End Sub

'press on the Done button to send text
Sub EditText1_EnterPressed
	If AStreams.IsInitialized = False Then Return
	If EditText2.Text.Length > 0 Then
		Dim buffer() As Byte
		buffer = EditText2.Text.GetBytes("UTF8")
		AStreams.Write(buffer)
		EditText2.SelectAll
		Log("Sending: " & EditText2.Text)
	End If
End Sub

Sub Activity_Pause(UserClosed As Boolean)
	Log("closing")
	If UserClosed Then
		StopService(modSMS)
		StopService(Starter)
		Log("closing")
		AStreams.Close
		Socket1.Close
	End If
End Sub

Sub Button1_Click
	Log("Pressed Quit.")
	ExitApplication
End Sub

Sub pe_BatteryChanged (Level As Int, Scale As Int, Plugged As Boolean, Intent As Intent)
	Log("BatteryChanged: Level = " & Level & ", Scale = " & Scale & ", Plugged = " & Plugged)
	If Level >50 Then
		Starter.Colore = "Green"
	else if Level <= 50 And Level > 10 Then
		Starter.Colore = "Yellow"
	Else
		Starter.Colore = "Red"
	End If
	SimpleProgressBar1.Invalidate
	SimpleProgressBar1.Value = Level
	
	Dim Collegato As String
	If Plugged Then
		Collegato="In Carica"
	Else
		Collegato="Non sotto Carica"
	End If
	Label4.Text = "Batteria " & Level & "%  " & Collegato
	Batteria = Level & "," & Collegato
End Sub

Sub PE_SmsDelivered (PhoneNumber As String, Intent As Intent)
	'Have never got a receipt from SMS using this!
	Dim Result As String
	Result="Conferma SMS Ricevuto da : " & PhoneNumber
	Log(Result)
	EditText2.Text=EditText2.Text & Result & CRLF
End Sub

Sub PE_SmsSentStatus(Success As Boolean, ErrorMessage As String, PhoneNumber As String, Intent As Intent)
	Dim Result As String
	Result="SMS Inviato : " & Success & " : " & ErrorMessage & " " & PhoneNumber
	Log(Result)
	EditText2.Text=EditText2.Text & Result & CRLF
	Dim Ricevi As String = PhoneNumber & "|" & Success & "|" & Intent.GetExtra("message_id")
	AStreams.Write(Ricevi.GetBytes("UTF8"))

End Sub

Sub PE_PhoneStateChanged (State As String, IncomingNumber As String, Intent As Intent)

	Try
		If State = "RINGING" Then
			Log( State & ", Chiamata da " & IncomingNumber)
			Dim Ricevi As String = IncomingNumber & "|Chiamata"
			AStreams.Write(Ricevi.GetBytes("UTF8"))
			Log(State & ", Chiamata da " & IncomingNumber)
		End If
	Catch
		Log(LastException)
	End Try

End Sub

Sub PE_ConnectivityChanged (NetworkType As String, State As String, Intent As Intent)
	Log("ConnectivityChanged: " & NetworkType & ", state = " & State)
	Log(Intent.ExtrasToString)
End Sub

Sub GotMessage(From As String,MsgText As String)
	'See Service Module modSMS
	EditText2.Text=EditText2.Text & $"
	Ricevuto SMS da ${From}
	${MsgText}
	"$
	Log($"
	Ricevuto SMS da ${From}
	${MsgText}
	"$)
End Sub

Sub Button2_Click
'	Dim myIntent As Intent
'	myIntent.Initialize(myIntent.ACTION_MAIN,"")
	''	myIntent.SetComponent("com.qrcodescannerfree.barcodereaderappfree/.SplashActivity")
'	myIntent.SetComponent("com.opensignalNotificationOpenedAcivityHMS")
'	StartActivity(myIntent)

	Try
		Dim Intent1 As Intent
		Dim pm As PackageManager
'		Intent1 = pm.GetApplicationIntent ("com.qrcodescannerfree.barcodereaderappfree")
		Intent1 = pm.GetApplicationIntent ("app.qrcode")
		StartActivity (Intent1)
	Catch
		ToastMessageShow ("App 'Lettore codici QR' non disponibile!  Installare 'Lettore codici QR' da Play Store ", True)
	End Try
End Sub

Sub CancellaClip
	Dim r As Reflector
	r.Target = r.GetContext
	Log(r.Target)
	r.Target = r.RunMethod2("getSystemService", "clipboard", "java.lang.String")    'CipboardManager
	Log(r.Target)
	Log(r.RunMethod2("setText","","java.lang.CharSequence"))
End Sub

Sub Incolla
	Dim r As Reflector
	r.Target = r.GetContext
	Log(r.Target)
	r.Target = r.RunMethod2("getSystemService", "clipboard", "java.lang.String")    'CipboardManager
	Log(r.Target)
	If r.RunMethod("hasText") Then
		Dim Codice As String = r.RunMethod("getText")
		If Codice.Length = 8 Then
			EditText2.Text=Codice
			Log(r.RunMethod("getText"))
			Dim Ricevi As String = "Clip%," & Codice
			AStreams.Write(Ricevi.GetBytes("UTF8"))
			CancellaClip
		End If

	Else
		Log("Error : No texto")
	End If
End Sub

Sub PSL_onSignalStrengthsChanged (signalStrength As String)
	Log(signalStrength)
	Dim S() As String
	S=Regex.split(" ", signalStrength)
	Log ("Android " & GetSDKversion)
	Log (GetSDK)
	If S.Length > 22 And S(22).IndexOf("rsrq")>=0 Then
		Dim SS As Int = RSSPPerc(S(21).Replace("rsrp=",""))
		Log("signalStrength=" & SS)
		Starter.getGsmSignalStrength=SS
	Else If GetSDK = 24 Or GetSDK = 25 Then
		Starter.getGsmSignalStrength=RSSPPerc(S(9))
	Else If GetSDK = 26 Or GetSDK = 27 Or GetSDK = 28 Then
		Starter.getGsmSignalStrength=RSSPPerc(S(9))
	Else If GetSDK <= 28 Then
		Dim X As Int =S(1)
		Starter.getGsmSignalStrength=x*100/31
	Else
		Starter.getGsmSignalStrength=0
	End If
	
	Dim dbm As Int = 0
	If GetSDK < 26 Then
		dbm = S(1)*100/31
		Starter.getGsmSignalStrength=dbm
	Else if GetSDK > 28 Then
		Dim xi As Int
		For i =0 To S.Length-1
			If Left(S(i),4)="rsrp" Then
				xi=i
			End If
		Next
		dbm = RSSPPerc(S(xi).Replace("rsrp=",""))
		Starter.getGsmSignalStrength=dbm
	End If
	
End Sub

'Sub	RSSQPerc(RSRQ As Int) As Int
'	RSRQ=-(RSRQ+10)
'	Return 100-(RSRQ*100/10)
'End Sub
'
'Sub GSMPerc(GSM As Int) As Int
'	GSM=-(GSM+55)
'	Return 100-(GSM*100/55)
'End Sub
	
Sub RSSPPerc(RSRP As Int) As Int
	RSRP=-(RSRP+90)
	Return 100-(RSRP*100/30)
End Sub

Sub GetSDK() As Int
	Dim p As Phone
	Return p.SdkVersion
End Sub
Sub GetSDKversion() As String
	Dim versions As Map
	versions.Initialize
	versions.Put(3,"1.5")
	versions.Put(4,"1.6")
	versions.Put(7,"2.1")
	versions.Put(8,"2.2")
	versions.Put(10,"2.3.3")
	versions.Put(11,"3.0")
	versions.Put(12,"3.1")
	versions.Put(13,"3.2")
	versions.Put(14,"4.0")
	versions.Put(15,"4.0.3")
	versions.Put(16,"4.1.2")
	versions.Put(17,"4.2.2")
	versions.Put(18,"4.3")
	versions.Put(19,"4.4.2")
	versions.Put(20,"5.0p")
	versions.Put(21,"5.0")
	versions.Put(22,"5.1")
	versions.Put(23,"6.0")
	versions.Put(24,"7.0")
	versions.Put(25,"7.1")
	versions.Put(26,"8.0")
	versions.Put(27,"8.1")
	versions.Put(28,"9.0")
	versions.Put(29,"10.0")	
	versions.Put(30,"11.0")
	Dim V As Int
	Dim p As Phone
	If p.SdkVersion > 30 Then
		V = 30
	Else
		V = p.SdkVersion
	End If
	Return versions.Get(V)
End Sub

Sub Left(Text As String, Length As Int)As String
	If Length>Text.Length Then Length=Text.Length
	Return Text.SubString2(0, Length)
End Sub

'Sub Right(Text As String, Length As Int) As String
'	If Length>Text.Length Then Length=Text.Length
'	Return Text.SubString(Text.Length-Length)
'End Sub
'
'Sub Mid(Text As String, Start As Int, Length As Int) As String
'	Return Text.SubString2(Start-1,Start+Length-1)
'End Sub
'
'Sub Split(Text As String, Delimiter As String) As String()
'	Return Regex.Split(delimter,Text)
'End Sub
