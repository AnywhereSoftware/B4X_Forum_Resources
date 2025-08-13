B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=10
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private transmits As UDPSocket
	Private audioStream As AudioStreamer
	Public AudioSender As Boolean = False
	Public AudioRicever As Boolean = False
	
	Dim address As String
	Private Port As String = "51051"
	Private BufferSize As Int = 8192
End Sub

Sub Service_Create
	transmits.Initialize("transmits",Port,BufferSize)
	audioStream.Initialize("audioStream", 22050, True, 16, audioStream.VOLUME_SYSTEM)
	
	address = GetBroadcastAddress
	Sleep(500)
	OpenTrasmits
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy

End Sub

Public Sub OpenTrasmits
	audioStream.StartRecording
	audioStream.StartPlaying
End Sub

Public Sub CloseTrasmits
	audioStream.StopRecording
	audioStream.StopPlaying
End Sub

Public Sub Close
	transmits.Close
End Sub

Private Sub transmits_PacketArrived (Packet As UDPPacket)
	If AudioRicever Then
		Starter.myLog($"Riceve(${Packet.HostAddress}): ${Packet.Length}"$)
		Try
			Dim bc As ByteConverter
			Dim data(Packet.Length) As Byte
			bc.ArrayCopy(Packet.Data, Packet.Offset, data, 0, Packet.Length)
			audioStream.Write(data)
		Catch
			Starter.myLog(LastException)
		End Try
	End If
End Sub

Private Sub audioStream_RecordBuffer (Data() As Byte)
	If address <> "" And AudioSender Then
		Starter.myLog($"Send(${address}): ${Data.Length}"$)
		Dim up As UDPPacket
		up.Initialize(Data , address, Port)
		transmits.Send(up)
	End If
End Sub

private Sub GetBroadcastAddress As String
	Dim niIterator As JavaObject
	niIterator = niIterator.InitializeStatic("java.net.NetworkInterface").RunMethod("getNetworkInterfaces", Null)
	Do While niIterator.RunMethod("hasMoreElements", Null)
		Dim ni As JavaObject = niIterator.RunMethod("nextElement", Null)
		If ni.RunMethod("isLoopback", Null) = False Then
			Dim addresses As List = ni.RunMethod("getInterfaceAddresses", Null)
			For Each ia As JavaObject In addresses
				Dim broadcast As Object = ia.RunMethod("getBroadcast", Null)
				If broadcast <> Null Then
					Dim b As String = broadcast
					Return b.SubString(1)
				End If
			Next
		End If
	Loop
	Return ""
End Sub