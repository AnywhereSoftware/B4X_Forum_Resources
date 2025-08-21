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
	Private transmits As Socket
	Private astream As AsyncStreams
	Private audioStream As AudioStreamer
	Public AudioSender As Boolean = False
	Public AudioRicever As Boolean = False
	
	Public address As String ="192.168.0.147"
	Private Port As String = "51051"
End Sub

Sub Service_Create
	transmits.Initialize("transmits")
	transmits.Connect(address,Port,DateTime.TicksPerSecond*10)
	audioStream.Initialize("audioStream", 22050, True, 16, audioStream.VOLUME_SYSTEM)
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Public Sub OpenTrasmits
	audioStream.StartRecording
	audioStream.StartPlaying
End Sub

Public Sub CloseTrasmits
	audioStream.StopRecording
	audioStream.StopPlaying
End Sub

Public Sub CloseTrasmit
	If astream.IsInitialized Then astream.Close
	If transmits.IsInitialized Then transmits.Close
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
		Starter.myLog($"Riceve: ${Buffer.Length}"$)
		Try
			audioStream.Write(Buffer)
		Catch
			Starter.myLog(LastException)
		End Try
	End If
End Sub

Private Sub audioStream_RecordBuffer (Data() As Byte)
	If AudioSender Then
		Starter.myLog($"Send: ${Data.Length}"$)
		astream.Write(Data)
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