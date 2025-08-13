Type=StaticCode
Version=2.2
B4J=true
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Private VERSION As Double = 1.0
	Private wsh As WebSocketHandler
	Private id As String
	Public kvs As KeyValueStore
	Private pingTimer As Timer
	Private lastServerPong As Long
	Type Message (id As String, Text As String)
	Private ReconnectTimer As Timer
End Sub

Public Sub Create
	If File.Exists(File.DirApp, "id.txt") = False Then
		File.WriteString(File.DirApp, "id.txt", Rnd(0, 2147483647))
	End If
	id = File.ReadString(File.DirApp, "id.txt")
	kvs.Initialize(File.DirApp, "msg.db")
	If kvs.ContainsKey("messages") = False Then
		Dim messages As List
		messages.Initialize
		kvs.PutObject("messages", messages)
	End If
	pingTimer.Initialize("pingTimer", 10000)
	ReconnectTimer.Initialize("ReconnectTimer", 5000)
	Connect
	Main.UpdateId(id)
	Main.UpdateStatus(wsh.ws.Connected)
	'Show stored messages
	Dim messages As List = kvs.GetObject("messages")
	If messages.Size > 0 Then
		Main.NewMessage(messages)
		messages.Clear
		kvs.PutObject("messages", messages)
	End If
End Sub


Private Sub Connect
	Dim wsh As WebSocketHandler
	wsh.Initialize(Me, "wsh")
	wsh.Connect(Main.serverLink)
End Sub

Sub wsh_ServerReady(Params As List)
	Dim m As Map
	m.Initialize
	m.Put("id", id)
	m.Put("version", VERSION)
	wsh.SendEventToServer("Device_id", m)
End Sub

Sub wsh_NewMessage(Params As List)
	Dim messages As List
	messages.Initialize
	Dim ids As List
	ids.Initialize
	For i = 0 To Params.Size - 1 Step 2
		Dim m As Message
		m.Initialize
		m.id = Params.Get(i)
		m.Text = Params.Get(i + 1)
		messages.Add(m)
		ids.Add(m.id)
	Next
	Main.NewMessage(messages)
	Dim mm As Map
	mm.Initialize
	mm.Put("ids", ids)
	wsh.SendEventToServer("Device_MessageDelivered", mm)
End Sub

Sub wsh_Connected
	Log("WebSocket Connected")
	Main.UpdateStatus(wsh.ws.Connected)
	pingTimer.Enabled = True
	lastServerPong = DateTime.Now
End Sub

Sub wsh_Closed (Reason As String)
	Log("WebSocket Closed: " & Reason)
	CallSub2(Main, "UpdateStatus", wsh.ws.Connected)
	pingTimer.Enabled = False
	ReconnectTimer.Enabled = True
End Sub

Sub ReconnectTimer_Tick
	If wsh.ws.Connected = False Then
		Connect
	End If
	ReconnectTimer.Enabled = False
End Sub

Sub PingTimer_Tick
	'Log("PingTimer_Tick: " & wsh.ws.Connected & ", " & lastServerPong & ", "  & (lastServerPong + 30 * DateTime.TicksPerSecond < DateTime.Now))
	If wsh.ws.Connected = False Then Return
	
	If lastServerPong + 30 * DateTime.TicksPerSecond < DateTime.Now Then
		'Log("Closing connection after 30 seconds of no response")
		wsh.Close
	Else
		Dim m As Map
		m.Initialize
		wsh.SendEventToServer("Device_Ping", m)
	End If
End Sub

Sub wsh_Pong(Params As List)
	lastServerPong = DateTime.Now
End Sub

Public Sub Close
	If wsh.ws.Connected Then
		wsh.Close
	End If
End Sub

Public Sub SendMessageToCloud(Msg As String)
	wsh.SendEventToServer("Device_MessageFrom", CreateMap("text": Msg))
End Sub
