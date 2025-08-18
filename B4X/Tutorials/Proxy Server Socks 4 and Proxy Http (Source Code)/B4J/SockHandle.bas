B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Private client As Socket
	Private toServer As Socket
	Private inStream As AsyncStreams
	Private outStream As AsyncStreams
	Private deal As Boolean = False
	Private Vers As Int
	Private Cd As Int
	Private Host As String = ""
	Private Port As Int = 0
	Private ResponseData(8) As Byte
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Sck As Socket)
	client = Sck
	inStream.Initialize(client.InputStream,client.OutputStream,"inStream")
End Sub

private Sub inStream_NewData (Buffer() As Byte)
	If Not(deal) Then
'		+----+----+----+----+----+----+----+----+----+----+....+----+
'		| VN | CD | DSTPORT |      DSTIP        | USERID       |NULL|
'		+----+----+----+----+----+----+----+----+----+----+....+----+
'		   1    1      2              4           variable       1
		If Buffer.Length>=9 Then
			Vers = Buffer(0)
			Cd = Buffer(1)
			Port=Bit.ShiftLeft(Bit.And(Buffer(2),0xff),8) + Bit.And(Buffer(3),0xff)
			Host=$"${Bit.And(Buffer(4),0xff)}.${Bit.And(Buffer(5),0xff)}.${Bit.And(Buffer(6),0xff)}.${Bit.And(Buffer(7),0xff)}"$
			Log($"Socks: ${Host}:${Port}"$)
			If Vers=4 Then
				If Cd=1 Then ' connect
					toServer.Initialize("toServer")
					
					If Host="192.168.1.100" Then 
						' redirect IP
						Host="192.168.1.200" 		
					End If
					toServer.Connect(Host,Port,4000)
					Wait For toServer_Connected (Successful As Boolean)
					
'					+----+----+----+----+----+----+----+----+
'					| VN | Cd | DSTPORT |      DSTIP        |
'					+----+----+----+----+----+----+----+----+
'					    1    1      2              4
					ResponseData(0)=0 ' version 0
					Bit.ArrayCopy(Buffer,2,ResponseData,2,6)
					
					If Successful Then 
						deal=True
						ResponseData(1)=90 ' accept
						inStream.Write(ResponseData)
						outStream.Initialize(toServer.InputStream,toServer.OutputStream,"outStream")
					Else
						ResponseData(1)=91 ' don't accept
						inStream.Write(ResponseData)
						Sleep(500)
						client.Close
					End If
				Else if Cd=2 Then ' BIND
					
				End If
			Else ' wrong version
				Log("Wrong version")
				client.Close
			End If
		Else
			Log("Wrong protocol")
			client.Close
		End If
		
	Else
		' Connect
		' here can sniffer a traffic
		'Log("From client: " & Buffer.Length)
		outStream.Write(Buffer)
	End If
	
End Sub

Private Sub inStream_Terminated
	
End Sub

Private Sub inStream_Error
	
End Sub

private Sub outStream_NewData (Buffer() As Byte)
	' here can sniffer a traffic
	'Log("From server: " & Buffer.Length)
	inStream.Write(Buffer)
End Sub

Private Sub outStream_Terminated
	
End Sub

Private Sub outStream_Error
	
End Sub
