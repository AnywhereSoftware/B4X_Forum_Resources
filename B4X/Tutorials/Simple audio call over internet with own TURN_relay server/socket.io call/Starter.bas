B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.801
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public socket As SocketIOClient
	Public rp As RuntimePermissions
	Public busy As Boolean = False
	Public connectedUsers As List
	Public myID As String
	Public status As String
End Sub

Sub Service_Create
	myID = Rnd(10000,99999)&"_"&Rnd(10000,99999)
	socket.initialize("socket")
'	socket.connect("http://192.168.0.111:5555/","",False)
	socket.connect("http://35.154.181.92:5555/","",False)
	connectedUsers.Initialize
	
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	socket.disconnect
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	socket.disconnect
	Return True
End Sub

Sub Service_Destroy
	socket.disconnect
End Sub

Sub socket_OnDisconnect (reason As String)
	CallSub2(Main,"update_status","Disconnected - "&reason)
End Sub

Sub socket_OnConnecting
	CallSub2(Main,"update_status","Connecting to server...")
End Sub

Sub socket_OnReconnecting (attemptNumber As Object)
	CallSub2(Main,"update_status","Trying to reconnect...")
End Sub

Sub socket_OnError (error As Object)
	CallSub2(Main,"update_status","Error")
End Sub

Sub socket_OnConnect
	socket.addEvent("user_update","user_update")
	socket.addEvent("is_connected","registered")
	socket.addEvent("audio_broadcast","audiorecived")
	socket.emit("reg_user",myID)
	CallSub2(Main,"update_status","Registering Device...")
End Sub

Sub socket_registered(data As Object)
	If data = "0" Then
		myID = Rnd(10000,99999)&"_"&Rnd(10000,99999)
		socket.emit("reg_user",myID)
		Return
	End If
	CallSub2(Main,"update_status","Connected. My ID: "&myID)
	Dim j As JSONParser
	j.Initialize(data)
	connectedUsers = j.NextArray
	CallSubDelayed(Main,"update_user_list")
	
	socket.addEvent("call_in","call_in")
	socket.addEvent("call_status","call_status")
End Sub

Sub socket_audiorecived(data As Object)
	If busy Then
		Dim b As B4XSerializator
		CallSub2(CallActivity,"audiorecived",b.ConvertBytesToObject(data))
	End If
End Sub

Sub socket_call_status(data As Object)
	CallSubDelayed2(CallActivity,"call_status",data)
End Sub

Sub socket_user_update(data As Object)
	Dim j As JSONParser
	j.Initialize(data)
	connectedUsers = j.NextArray
	If Not(IsPaused(Main)) Then CallSubDelayed(Main,"update_user_list")
End Sub

Sub socket_call_in(data As Object, ack As Object)
	If Not(IsPaused(CallActivity)) Then
		socket.sendAck(ack,Array(0))
		Return
	End If
	socket.sendAck(ack,Array(1))
	Dim j As JSONParser
	j.Initialize(data)
	CallActivity.callType = "in"
	CallActivity.peerId = j.NextObject.Get("from")
	
	If IsPaused(Main) Then
		Dim n As Notification
		n.Initialize2(n.IMPORTANCE_HIGH)
		n.AutoCancel = True
		n.Icon = "icon"
		n.Insistent=True
		n.Light=True
		n.OnGoingEvent = True
		n.Vibrate=True
		n.Sound=True
		n.SetInfo("Incoming Call...",CallActivity.peerId&" is calling you...",CallActivity)
		n.Notify(1)
	Else
		StartActivity(CallActivity)
	End If
End Sub