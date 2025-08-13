B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
Sub Class_Globals
	Private transmits As UDPSocket
	Private audioStream As AudioRecord
	Public AudioSender As Boolean = False
	Public AudioRicever As Boolean = False
	Private ActiveListen As Boolean = True
	
	Private Port As String = "51051"
	Private BufferSize As Int = 8192
	Private address As String
	Private PDA As PlayDataAudio
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	transmits.Initialize("transmits",Port,BufferSize)
	audioStream.Initialize(22050, 16,audioStream.CH_CONF_MONO)
	
	address = GetBroadcastAddress
	
	PDA.Initialize
	PDA.StartAudioPlayer
	OpenTrasmits
End Sub

Public Sub OpenTrasmits
	Dim BytesRead As Int = 0
	Dim RecDataSize As Int = BufferSize
	
	audioStream.Start
	ActiveListen=True
	Do While ActiveListen
		' read audio from card
		Dim RecData(RecDataSize) As Byte
		BytesRead = audioStream.Read(RecData,0,RecData.Length)
		If AudioSender	Then
			Log($"Send(${address}): ${BytesRead}"$)
			Dim bc As ByteConverter
			Dim data(BytesRead) As Byte
			bc.ArrayCopy(RecData, 0, data, 0, BytesRead)
			SendAudio(data)
		End If
		Sleep(0)
	Loop
End Sub

Public Sub CloseTrasmits
	audioStream.Stop
	ActiveListen=False
End Sub

Public Sub Close
	transmits.Close
	PDA.StopAudioPlayer
End Sub

Private Sub transmits_PacketArrived (Packet As UDPPacket)
	If AudioRicever Then
		Log($"Riceved(${Packet.HostAddress}): ${Packet.Length}"$)
		Try
			Dim bc As ByteConverter
			Dim data(Packet.Length) As Byte
			bc.ArrayCopy(Packet.Data, Packet.Offset, data, 0, Packet.Length)
			PDA.SendDataPlayer(data)
		Catch
			Log(LastException)
		End Try
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

Private Sub SendAudio(Data() As Byte)
	Log($"Send(${address}): ${Data.Length}"$)
	If address <> "" And AudioSender Then
		Dim up As UDPPacket
		up.Initialize(Data , address, Port)
		transmits.Send(up)
	End If
End Sub
