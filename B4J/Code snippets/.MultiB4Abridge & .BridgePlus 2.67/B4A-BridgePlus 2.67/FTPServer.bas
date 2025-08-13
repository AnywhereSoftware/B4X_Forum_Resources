B4A=true
Group=FTP Server
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Version 1.00
#Event: StateChanged

Sub Class_Globals
	Type FTPUser (Name As String, Password As String)
	Private clients As List
	Public const EOL As String = Chr(13) & Chr(10)
	Public ssocket As ServerSocket
	Public port As Int
	Private dataPorts As Map
	Public Users As Map
	Public BaseDir As String
	Private mCallback As Object
	Private mEventName As String
	Private stopped As Boolean = True
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	clients.Initialize
	Users.Initialize
	mCallback = Callback
	mEventName = EventName
End Sub

'Sets the control part and the data ports range
Public Sub SetPorts(ControlPort As Int, DataPortBegin As Int, DataPortEnd As Int)
	dataPorts.Initialize
	For i = DataPortBegin To DataPortEnd
		dataPorts.Put(i, False)
	Next
	port = ControlPort
End Sub

Public Sub getRunning As Boolean
	Return stopped = False
End Sub

Public Sub Start
	ssocket.Initialize(port, "ssocket")
	ssocket.Listen
	stopped = False
End Sub

Public Sub AddUser (Name As String, Password As String)
	Dim u As FTPUser
	u.Initialize
	u.Name = Name
	u.Password = Password
	Users.Put(u.Name, u)
End Sub

Public Sub Stop
	If stopped Then Return
	stopped = True
	ssocket.Close
	For Each Client As FTPClient In clients
		Client.CloseConnection
	Next
End Sub

Public Sub ClientClosed (client As FTPClient)
	If stopped Then Return
	If client.mDataPort > 0 Then dataPorts.Put(client.mDataPort, False)
	Dim i As Int = clients.IndexOf(client)
	If i > -1 Then
		clients.RemoveAt(i)
		CallSub(mCallback, mEventName & "_StateChanged")
	End If
End Sub

Public Sub getNumberOfClients As Int
	Return clients.Size
End Sub

Private Sub ssocket_NewConnection (Successful As Boolean, NewSocket As Socket)
	If Successful Then
		Dim Client As FTPClient
		Dim dp As Int = GetDataPort
		Client.Initialize(Me, NewSocket, dp)
		clients.Add(Client)
		If dp > 0 Then dataPorts.Put(dp, True)
		CallSub(mCallback, mEventName & "_StateChanged")
	End If
	If stopped = False Then ssocket.Listen
End Sub

Private Sub GetDataPort As Int
	For Each i As Int In dataPorts.Keys
		If dataPorts.Get(i) = False Then
			Return i
		End If
	Next
	Return -1
End Sub
