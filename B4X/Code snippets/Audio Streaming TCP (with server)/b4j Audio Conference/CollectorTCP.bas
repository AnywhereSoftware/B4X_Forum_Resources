B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	
	Private transmits As Socket
	Private astream As AsyncStreams
	
	Private audioStream As AudioRecord
	Public AudioSender As Boolean = False
	Public AudioRicever As Boolean = False
	Private ActiveListen As Boolean = True
		
	Public address As String = "192.168.0.147"
	Private PDA As PlayDataAudio
	Private Port As String = "51051"
	Private BufferSize As Int = 8192
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	transmits.Initialize("transmits")
	transmits.Connect(address,Port,DateTime.TicksPerSecond*10)
	audioStream.Initialize(22050, 16,audioStream.CH_CONF_MONO)

	PDA.Initialize
	PDA.StartAudioPlayer
End Sub


Sub transmits_Connected (Successful As Boolean)
	Log($"Connect: ${Successful}"$)
	If Successful Then
		'astream.InitializePrefix(transmits.InputStream, False, transmits.OutputStream, "astream")
		astream.Initialize(transmits.InputStream, transmits.OutputStream, "astream")
		OpenTrasmits
	Else
		Log("Failed to connect: " & LastException)
	End If
End Sub

Sub AStream_Error

End Sub

Sub AStream_Terminated

End Sub

Sub AStream_NewData (Buffer() As Byte)
	If AudioRicever Then
		Log($"Riceve: ${Buffer.Length}"$)
		Try
			PDA.SendDataPlayer(Buffer)
		Catch
			Log(LastException)
		End Try
	End If
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
'			Dim bc As ByteConverter
'			Dim data(BytesRead) As Byte
'			bc.ArrayCopy(RecData, 0, data, 0, BytesRead)
			astream.Write(RecData)
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
