B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	' external libraries
	Private rp As RuntimePermissions
	Private AStream As AsyncStreams
	Private serial As Serial
	Private admin As BluetoothAdmin
	Private AnotherProgressBar1 As AnotherProgressBar
	Private CLV As CustomListView
	
	' Socket for texting
	'Private theName As String = "Socket CHS [62A9E6]" ' Socket
	'Private theMAC As String = "00:06:66:62:A9:E6" ' Socket
	' Scan Avenger for testing
	'Private theName As String = "Scan Avenger"
	'Private theMAC As String = "AA:A8:AC:35:A3:41" ' Scan Avenger
	' Unassigned - set after search or Statemanager
	Private theMAC As String = ""
	Private theName As String  = ""
	
	Private btnSearchForDevices As B4XView
	Private btnAllowConnection As B4XView
	Private btnMenu As Button
	Private btnConnect As Button
	Private ourMenu As frmMenu	
	Private ourTimer As Timer
	
	Private serialConnectCount As Int
	Private scannerOnceConnected As Boolean
	Private isDebug As Boolean
	
	Private callersCurrentPage As Object = Null
	Private callersRoutine As String
	Private callersSymbologies As List
	
	Private socketSymbologies As Map
	Private scanAvengerSymbologies As Map
	Private MACs As Map
	
	Public BluetoothState, ConnectionState As Boolean
	Public LastSymbology As String
	Public SP As SoundPool
	Dim DitDit, PlayId, WBC, good, bad, online  As Int
	
	Public IsLoggedIn As Boolean
	Private txtScan As EditText
End Sub

'You can add more parameters here.
Public Sub Initialize
    #if debug
		isDebug = True
    #end If
	socketSymbologies.Initialize
	' Socket Mobile values
	socketSymbologies.Put(1, "Code 39")
	socketSymbologies.Put(3, "Code 128")
	socketSymbologies.Put(8, "UPC_A")
	socketSymbologies.Put(9, "UPC_E")
	socketSymbologies.Put(11, "EAN_13")
	socketSymbologies.Put(10, "EAN_8")
	socketSymbologies.Put(15, "GS1-128")

	' Scan Avenger values
	scanAvengerSymbologies.Initialize
	scanAvengerSymbologies.Put(109, "Code 39")
	scanAvengerSymbologies.Put(128, "Code 128")
	scanAvengerSymbologies.Put(101, "UPC_A")
	scanAvengerSymbologies.Put(102, "UPC_E")
	scanAvengerSymbologies.Put(100, "EAN_13")
	scanAvengerSymbologies.Put(99, "EAN_8")
	
	' will be empty the first time before assigning a scanner
	theMAC = StateManager.GetSetting2("theMac", "")
	theName = StateManager.GetSetting2("theName", "")
	
	SP.Initialize(4)
	DitDit = SP.Load(File.DirAssets, "ditDit.wav")
	WBC = SP.Load(File.DirAssets, "wrong_bar_code.wav")
	good = SP.Load(File.DirAssets, "good.wav")
	bad = SP.Load(File.DirAssets, "bad.wav")
	' foundit, unableToFind cause file not found exception!
	online = SP.Load(File.DirAssets, "online.wav")

	admin.Initialize("admin")
	serial.Initialize("serial")
	ourTimer.Initialize("Timer", 2000) ' 2 seconds
	
	If admin.IsEnabled = False Then
		If admin.Enable = False Then
			LogToastMsg("Error enabling Bluetooth adapter.")
		Else
			LogToastMsg("Enabling Bluetooth adapter...")
		End If
	Else
		LogToastMsg("Bluetooth Enabled")
		BluetoothState = True
	End If
	' must do before B4XPage_Created
	ourMenu.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	AnotherProgressBar1.Tag = 1
	B4XPages.AddPageAndCreate("Our Menu", ourMenu)
End Sub

Private Sub B4XPage_Appear
	CLV.Clear
	ScanSet(Me, "NewMessage", Array As String ("*"))
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	' handle the Back request
	Dim sf As Object = xui.Msgbox2Async("Exit?", "", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		' Cleanup regardless of being connected as we may be in a timer loop trying to connect
		Disconnect
		Return True
	Else
		Return False
	End If
End Sub

Sub btnExit_Click
	Disconnect
	B4XPages.ClosePage(Me) ' Doesn't trigger B4XPage_CloseRequest
End Sub

public Sub ScanSet(paActivity As Object, paRoutine As String, paSymbology As List)
	callersCurrentPage = paActivity
	callersRoutine = paRoutine
	callersSymbologies = paSymbology
	If paActivity <> Null And ConnectionState = False Then ' ScanON and not connectoed
		attemptConnect
	End If
End Sub

public Sub PlaySound(paWhichSound As String)
	Select paWhichSound.ToLowerCase
		Case "wbc"
			PlayId = SP.Play(WBC, 1, 1, 1, 0, 1)
		Case "good"
			PlayId = SP.Play(good, 1, 1, 1, 0, 1)
		Case "bad"
			PlayId = SP.Play(bad, 1, 1, 1, 0, 1)
		Case "ditdit"
			PlayId = SP.Play(DitDit, 1, 1, 1, 0, 1)
		Case "online"
			PlayId = SP.Play(online, 1, 1, 1, 0, 1)
	End Select
End Sub

Sub attemptConnect
	If theMAC = "" Then
		LogToastMsg("No scanner assigned! Search for Device.")
	Else
		LogToastMsg("attemptConnect " & theMAC & " Connect Attempt")
		serial.Connect(theMAC)
	End If
End Sub

public Sub SetLogin(theState As Boolean)
	IsLoggedIn = theState
End Sub

Sub Timer_Tick
	ourTimer.Enabled = False
	If serialConnectCount > 4 Then ' 4 * 2 = 8 seconds
		LogToastMsg ("Failed to connect to " & theMAC & ". Search for scanner again.")
		CallSubDelayed2(callersCurrentPage, "ScanError", "Disconnected")
	Else
		' attempt to connect again
		serial.Connect(theMAC)
		LogToastMsg ("ReTrying to connect to " & theMAC)
	End If
End Sub

Sub btnConnect_Click
	If btnConnect.Text = "Connect" Then
		If theMAC = "" Then
			LogToastMsg("No scanner assigned! Search for Device.")
		Else
			attemptConnect
			btnConnect.Text = "Disconnect"
		End If
	Else
		Disconnect
		btnConnect.Text = "Connect"
	End If
End Sub

Sub btnMenu_Click
	If ConnectionState = False Then
		If theMAC = "" Then
			LogToastMsg("No scanner assigned! Search for Device.")
		Else
			' start connect attempt and show the Menu
			attemptConnect
			ourMenu.Setup
			btnConnect.Text = "Disconnect"
			B4XPages.ShowPage("Our Menu")
		End If
	Else
		B4XPages.MainPage.Scanset(Null, "", Array As String (""))' Scanner OFF
		ourMenu.Setup
		B4XPages.ShowPage("Our Menu")
	End If
End Sub

Sub btnSearchForDevices_Click
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_COARSE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False Then
		ToastMessageShow("No permission...", False)
	Else
		MACs.Initialize
		Dim success As Boolean = admin.StartDiscovery
		If success = False Then
			ToastMessageShow("Error starting discovery process.", True)
		Else
			CLV.Clear
			Dim Index As Int = ShowProgress
			Wait For Admin_DiscoveryFinished
			HideProgress(Index)
			If CLV.Size = 0 Then
				ToastMessageShow("No device found.", True)
			Else
				If ConnectionState Then
					LogToastMsg("Scanner " & theMAC & " Connected")
				Else
					LogToastMsg("Search for " & theMAC & " Failed")
				End If
			End If
		End If
	End If
End Sub

Sub btnAllowConnection_Click
	'this intent makes the device discoverable for 300 seconds.
	Dim i As Intent
	i.Initialize("android.bluetooth.adapter.action.REQUEST_DISCOVERABLE", "")
	i.PutExtra("android.bluetooth.adapter.extra.DISCOVERABLE_DURATION", 300)
	StartActivity(i)
	serial.Listen
	AfterSuccessfulConnection
End Sub

' Serial events
Sub Serial_Connected (Success As Boolean)
	LogOnly("Serial_Connected = " & Success)
	If Success Then
		LogOnly("Scanner is now connected. Waiting for data...")
		ourTimer.Enabled = False
		AfterSuccessfulConnection
		StateChanged
		CLV.Clear
		CLV.AddTextItem("Connected to " & theMAC, theMAC)
	Else
		If scannerOnceConnected = False Then
			LogToastMsg("Please switch on the scanner...")
			If callersCurrentPage <> Null Then
				CallSubDelayed2(callersCurrentPage, "ScanError", "Scanner offline")
			End If
		Else
			LogToastMsg("Still waiting for the scanner to reconnect: " & theName)
			If callersCurrentPage <> Null Then
				CallSubDelayed2(callersCurrentPage, "ScanError", "Waiting to Connect")
			End If
		End If
		serialConnectCount = serialConnectCount + 1
		ourTimer.Enabled = True
	End If
End Sub

' AStream Bluetooth events
Private Sub AStream_NewData (Buffer() As Byte)
	Dim barcode As String = ""
	If callersCurrentPage <> Null Then
		Select theName.SubString2(0, 3)
			Case "Soc"
				barcode = decodeSocket(Buffer)
			Case "Sca"
				barcode = decodeScanAvenger(Buffer)
			Case Else
				' assumes a suffix. if not then change Buffer.Length - 1 to Buffer.Length
				' also doesn't look for symbology ID
				LastSymbology = "UNK" ' unknown because scanner doesn't provided symbology
				barcode = BytesToString(Buffer, 0, Buffer.Length - 1, "UTF8")
		End Select
		If barcode <> "" Then
			If callersCurrentPage <> Null Then
				' let client play sound
				CallSubDelayed2(callersCurrentPage, callersRoutine, barcode)
			Else
				LogToastMsg("Scanner Off")
			End If
		End If
	Else
		LogToastMsg("Scanner Off")
	End If
End Sub

'  Called by B4XMainPage
Public Sub NewMessage (msg As String)
	txtScan.Text = msg & ":" & LastSymbology
	CLV.AddTextItem("Scan: " & msg, msg & ":" & LastSymbology)
End Sub

Sub decodeScanAvenger(Buffer() As Byte) As String
	Dim symbologyID As Int = Buffer(0)
	Dim barcode As String  = ""
	
	Dim foundSym As Int
	Dim wildcard As String
	Dim symGet As Object

	If symbologyID > 96 And symbologyID < 119 Then ' a to v = CODE ID
		' 1 char prefix is symbology and 1 char suffix (Enter)
		symGet = scanAvengerSymbologies.Get(symbologyID) ' so we can test for Null
		LastSymbology = scanAvengerSymbologies.Get(symbologyID)
		wildcard = callersSymbologies.Get(0)
		If wildcard = "*" And symGet = Null Then ' wildcard and symbology not found
			foundSym = 0 ' don't care
			LastSymbology = BytesToString(Buffer, 0, 1, "UTF8")
		Else
			foundSym = callersSymbologies.IndexOf(LastSymbology)
		End If
		If foundSym <> -1 Or wildcard = "*" Then
			barcode = BytesToString(Buffer, 1, Buffer.Length - 2, "UTF8") ' skip leading sym, trailing Enter
			LogOnly("Scanned " & barcode)
		Else
			' Don't bother caller
			LogToastMsg("Wrong Symbology")
			PlaySound("wbc")
		End If
	Else
		' Scan Avenger not providing CODE ID
		barcode = BytesToString(Buffer, 0, Buffer.Length - 1, "UTF8")
	End If
	Return barcode
End Sub

Sub decodeSocket(Buffer() As Byte) As String
	' 5 char prefix and 2 char suffix, symbology in byte 5
	Dim symbologyID As Int = Buffer(4)
	Dim barcode As String = ""
	
	Dim foundSym As Int
	Dim wildcard As String
	Dim symGet As Object
	
	symGet = socketSymbologies.Get(symbologyID) ' so we can test for Null
	LastSymbology = socketSymbologies.Get(symbologyID)
	wildcard = callersSymbologies.Get(0)
	If wildcard = "*" And symGet = Null Then ' wildcard and symbology not found
		foundSym = 0 ' don't care
		LastSymbology = BytesToString(Buffer, 4, 1, "UTF8")
	Else
		foundSym = callersSymbologies.IndexOf(LastSymbology)
	End If
	If foundSym <> -1 Or wildcard = "*" Then
		barcode = BytesToString(Buffer, 5, Buffer.Length - 7, "UTF8") ' skip 5 char prefix and 2 char suffix
		LogOnly("Scanned " & barcode)
	Else
		' Don't bother caller
		' testing barcode = BytesToString(Buffer, 5, Buffer.Length - 7, "UTF8") ' skip 5 char prefix and 2 char suffix
		LogToastMsg("Wrong Symbology")
		PlaySound("wbc")
	End If
	Return barcode
End Sub

Private Sub AStream_Error
	LogToastMsg("Connection error.")
	ConnectionState = False
	BluetoothState = False ' 8/26/20
	StateChanged
	ourTimer.Enabled = False
	AStream.Close
	serial.Disconnect
	LogToastMsg("Disconnected")
	serialConnectCount = 0
	ourTimer.Enabled = True ' try to reconnect
	If callersCurrentPage <> Null Then
		CallSubDelayed2(callersCurrentPage, "ScanError", "Disconnected") ' advise client
	End If
End Sub

Private Sub AStream_Terminated
	LogOnly("AStream_Terminated")
	AStream_Error
End Sub

' Called by other Pages
Public Sub SendMessage (msg As String)
	AStream.Write(msg.GetBytes("utf8"))
End Sub

' Called by other Pages
Public Sub Disconnect
	ourTimer.Enabled = False
	If AStream.IsInitialized Then AStream.Close
	serial.Disconnect
End Sub

public Sub Connect
	attemptConnect
End Sub

' Admin routines related to device discovery
Private Sub Admin_DeviceFound (Name As String, MacAddress As String)
	LogOnly(Name & ":" & MacAddress)
	' assign theName and theMAC when connection complete
	Dim thisMac As Object = MACs.Get(MacAddress)
	If thisMac = Null Then ' this event triggers many times for the same MAC, so only show once
		' mac = 17 characters
		MACs.Put(MacAddress, Name)
		CLV.AddTextItem($"${Name}: ${MacAddress}"$, MacAddress & Name) ' 17 char MAC, rest is Name
		LogOnly("Admin_DeviceFound " & MacAddress)
	End If
	'End If
End Sub

Private Sub Admin_StateChanged (NewState As Int, OldState As Int)
	LogOnly("State Change New " & NewState & " Old " & OldState)
	BluetoothState = NewState = admin.STATE_ON
	StateChanged
End Sub

' Misc support routines
private Sub StateChanged
	LogOnly("StateChanged to " & BluetoothState)
	'btnSearchForDevices.Enabled = BluetoothState
	'btnAllowConnection.Enabled = BluetoothState
	'ChatPage1.btnSend.Enabled = ConnectionState
End Sub

Sub CLV_ItemClick (Index As Int, Value As Object)
	LogToastMsg($"Clicked to connect to: ${Value}"$)
	Dim macString As String = Value
	theMAC = macString.SubString2(0 ,17)
	theName = macString.SubString(17)
	serial.Connect(theMAC)
	Dim Index As Int = ShowProgress
	Wait For Serial_Connected (Success As Boolean)
	HideProgress(Index)
	If Success = False Then
		LogOnly(LastException.Message)
		LogToastMsg("Error connecting: " & LastException.Message)
	Else
		AfterSuccessfulConnection
	End If
	StateChanged
End Sub

Sub AfterSuccessfulConnection
	If AStream.IsInitialized Then AStream.Close
	ourTimer.Enabled = False
	setAsDefaultScanner
	If callersCurrentPage <> Null Then
		CallSubDelayed2(callersCurrentPage, "ScanError", "Connected")
	End If
	LogToastMsg("Scanner Connected")
	'prefix mode! Change to non-prefix mode if communicating with non-B4X device.
	'Prefix doesn't work with scanner AStream.InitializePrefix(serial.InputStream, False, serial.OutputStream, "astream")
	AStream.Initialize(serial.InputStream, serial.OutputStream, "astream")
	btnConnect.Text = "Disconnect"
	ConnectionState = True
	scannerOnceConnected = True
End Sub

Sub setAsDefaultScanner
	StateManager.SetSetting("theMac", theMAC)
	StateManager.SetSetting("theName", theName)
	StateManager.SaveSettings
End Sub

Sub ShowProgress As Int
	AnotherProgressBar1.Tag = AnotherProgressBar1.Tag + 1
	AnotherProgressBar1.Visible = True
	Return AnotherProgressBar1.Tag
End Sub

Sub HideProgress (Index As Int)
	If Index = AnotherProgressBar1.Tag Then
		AnotherProgressBar1.Visible = False
	End If
End Sub

public Sub LogToastMsg(theMessage As String)
	LogOnly(theMessage)
	ToastMessageShow(theMessage, False)
End Sub

public Sub LogOnly(theMessage As String)
	If isDebug Then
		Log(theMessage)
	End If
End Sub

Sub txtScan_TextChanged (Old As String, New As String)
	Dim theText As String = New
	Log(theText)
End Sub

Sub txtScan_EnterPressed
	Log("Enter Pressed")
End Sub