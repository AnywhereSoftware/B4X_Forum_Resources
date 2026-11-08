B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.7
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private const port As Int = 58912
	Private udpsocket As UDPSocket
	Private FoundDevices As Map
	Private Timer1 As Timer
	Private mHost As String
End Sub

Public Sub Initialize(Host As String)
	mHost = Host
	udpsocket.Initialize("udpsocket", 0, 8192)
	FoundDevices.Initialize
	Timer1.Initialize("Timer1", 1000)
End Sub

Private Sub Timer1_Tick
	Dim p As UDPPacket
	p.Initialize(Array As Byte(0), mHost, port)
	udpsocket.Send(p)
End Sub

Public Sub Start
	FoundDevices.Clear
	Timer1.Enabled = True
End Sub

Public Sub Stop
	udpsocket.Close
	Timer1.Enabled = False
End Sub

Private Sub UdpSocket_PacketArrived (Packet As UDPPacket)
	Dim name As String = BytesToString(Packet.Data, 1, Packet.Length - 1, "utf8")
	If FoundDevices.GetDefault(Packet.HostAddress, "") <> name Then
		FoundDevices.Put(Packet.HostAddress, name)
		Main.AutoDiscover_Found(name, Packet.HostAddress)
	End If
End Sub
