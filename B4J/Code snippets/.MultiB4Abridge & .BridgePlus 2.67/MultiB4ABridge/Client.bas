B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.7
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private astream As AsyncStreams
	Private socket As Socket
	Private const port As Int = 6789
	Private attemptCounter As Int
	Private mIP As String
	Private Const PING = 1, APK_COPY_START = 2, APK_PACKET = 3 _
		,APK_COPY_CLOSE = 4, SEND_DEVICE_NAME = 5,  APK_SIZE = 14 As Byte
	Private SendTimer As Timer
	Private FileBuffer(81920) As Byte
	Private FileIn As InputStream
	Private allSent As Boolean
End Sub

Public Sub Initialize (Ip As String)
	mIP = Ip
	socket.Initialize("socket")
	socket.Connect(mIP, port, 5000)
	SendTimer.Initialize("SendTimer", 30)
End Sub

Public Sub Close
	socket.Close
	astream.Close
End Sub

Private Sub socket_Connected (Successful As Boolean)
	If Successful = False Then
		attemptCounter = attemptCounter  + 1
		If attemptCounter = 1 Then
			socket.Initialize("socket")
			socket.Connect(mIP, port + 117, 5000)
		Else
'			Log("Error connecting")
			ExitApplication2(1)
		End If
	Else
		astream.InitializePrefix(socket.InputStream, False, socket.OutputStream, "astream")
		
	End If
End Sub

Private Sub SendTimer_Tick
	Try
		If allSent Then
			If astream.OutputQueueSize = 0 Then
				SendTimer.Enabled = False
				Main.csu.CallSubPlus(Me, "SendCompleted", 500)
			End If
			Return
		End If
		If astream.OutputQueueSize > 50 Then Return
		Dim c As Int = FileIn.ReadBytes(FileBuffer, 1, FileBuffer.Length - 1)
		If c <= 0 Then
			astream.Write(Array As Byte(APK_COPY_CLOSE))
			allSent = True
		Else
			FileBuffer(0) = APK_PACKET
			astream.Write2(FileBuffer, 0, c + 1)
		End If
	Catch
		Close
	End Try
End Sub

Private Sub SendCompleted
'	Log("Completed successfully")
	Close
	Main.SendCompleted(Me)
End Sub

Public Sub SendFile (f As String)
	Dim size(5) As Byte
	Dim raf As RandomAccessFile
	raf.Initialize3(size, True)
	raf.WriteByte(APK_SIZE, raf.CurrentPosition)
	raf.WriteInt(File.Size(f, ""), raf.CurrentPosition)
	astream.Write(size)
	astream.Write(Array As Byte(APK_COPY_START))
	FileIn = File.OpenInput(f, "")
	SendTimer.Enabled = True
End Sub

Private Sub AStream_NewData (Buffer() As Byte)
	Dim raf As RandomAccessFile
	raf.Initialize3(Buffer, True)
	Select Buffer(0)
		Case PING
			'nop
		Case SEND_DEVICE_NAME
'			Log("Connected to: " & BytesToString(Buffer, 1, Buffer.Length - 1, "utf8"))			
			Main.Client_Connected(Me)
	End Select
End Sub

Private Sub AStream_Error
'	Log("Error: " & LastException)
End Sub

Private Sub AStream_Terminated
	If allSent = False Then
'		Log("Error sending file")
	End If
End Sub
