B4A=true
Group=Bridge
ModulesStructureVersion=1
Type=Service
Version=7.3
@EndOfDesignText@
#Region Module Attributes
	#StartAtBoot: False
#End Region

'Service module
Sub Process_Globals
	Private WifiServer As ServerSocket
	Private Client As Socket
	Private Streams As AsyncStreams
	Private Notification1 As Notification
	Private PE As PhoneEvents
	Private Phone As Phone
	Private LogCat As LogCat
	Public ConnectedStatus As Boolean
	Private Out As OutputStream
	Private LastToastMessageShown As Long 'ignore
	Private Const PING = 1, APK_COPY_START = 2, APK_PACKET = 3 _
		,APK_COPY_CLOSE = 4, SEND_DEVICE_NAME = 5, START_LOGCAT = 6 _
		,STOP_LOGCAT = 7, LOGCAT_DATA = 8, LAUNCH_PROGRAM = 9, KILL_PROGRAM = 10 _
		,ASK_FOR_DESIGNER = 11, BRIDGE_LOG_PORT = 12, SEND_FTP_ENABLED = 13, APK_SIZE = 14, VERSIONS = 15 As Byte
	Private DisconnectTimer As Timer
	Private DisconnectTicks As Int
	Private apkName As Int = 1
	Private noDesignerInstalled As Boolean
	Private lastCheckForDesigner As Long
	Private UdpServer As UDPSocket
	Public FTP As FTPServer
	Public const FTP_PORT = 6781 As Int
	Public currentAPKTotal As Int
	Public currentAPKWritten As Int
	Private Phone As Phone
End Sub

Sub Service_Create
	Try
		If WifiServer.IsInitialized = False Then
			WifiServer.Initialize(6789, "Server")
		End If
	Catch
		Log(LastException.Message)
		'switch to alternate port
		WifiServer.Initialize(6789 + 117, "Server")
	End Try
	If Phone.SdkVersion >= 16 And UdpServer.IsInitialized = False Then
		UdpServer.Initialize("Udp", 0, 8192)
	End If
	DisconnectTimer.Initialize("DisconnectTimer", 1000)
	
	PE.Initialize("PE")
	UpdateNotification
	Service.StartForeground(1, Notification1)
	Try
		SetFTPServerState
	Catch
		Log(LastException)
	End Try
End Sub

Public Sub SetFTPServerState
	If Main.FTPServerEnabled Then
		If FTP.IsInitialized And FTP.Running Then Return
		FTP.Initialize(Main, "ftp")
		FTP.AddUser("anonymous", "")
		FTP.BaseDir = File.DirRootExternal
		FTP.SetPorts(FTP_PORT, 6782, 6788)
		FTP.Start
	Else
		If FTP.IsInitialized And FTP.Running Then
			FTP.Stop
		End If
	End If
End Sub

Sub UpdateNotification
	Dim icon As String
	Dim content As String
	If ConnectedStatus Then
		icon = "ic_connected"
		content = "Connected"
		If IsPaused(Main) = False Then CallSubDelayed2(Main, "IsConnectedUpdateColors",1)
	Else
		icon = "ic_disconnected"
		content = "Disconnected"
		If IsPaused(Main) = False Then CallSubDelayed2(Main, "IsConnectedUpdateColors",0)
	End If
	Notification1.Initialize2(Notification1.IMPORTANCE_LOW)
	Notification1.Sound = False
	Notification1.Vibrate = False
	Notification1.Icon = icon
	Notification1.SetInfo("B4A-Bridge", content, Main)
	Notification1.Notify(1)
End Sub

Sub Service_Start (StartingIntent As Intent)
	Try
		UpdateStatus (ConnectedStatus, True)
	Catch
		Log("Error starting service: " & LastException.Message)
	End Try
End Sub

Sub UpdateStatus (Connected As Boolean, AllowFurtherConnections As Boolean)
	ConnectedStatus = Connected
	If Connected Then
		DisconnectTimer.Enabled = True
		DisconnectTicks = 0
		CheckIfDesignerIsInstalled
	Else
		If Streams.IsInitialized Then Streams.Close
		DisconnectTimer.Enabled = False
	End If
	If AllowFurtherConnections Then
		UpdateNotification
		WifiServer.Listen
	End If
	If IsPaused(Main) = False Then CallSubDelayed(Main, "UpdateStatus")
End Sub

Sub DisconnectTimer_Tick
	DisconnectTicks = DisconnectTicks + 1
	If DisconnectTicks = 10 Then
		UpdateStatus(False, True)
	End If
End Sub

Sub Service_Destroy
	Service.StopForeground(1)
	UpdateStatus (False, False)
	LogCat.LogCatStop
	If FTP.IsInitialized Then FTP.Stop
End Sub

Sub Server_NewConnection (Successful As Boolean, NewSocket As Socket)
	If Streams.IsInitialized Then Streams.Close
	Dim Streams As AsyncStreams 'create a new streams object.
	If Successful Then
		Log("Connected to B4A-Bridge (Wifi)")
		Client = NewSocket
		Streams.InitializePrefix(Client.InputStream, False, Client.OutputStream, "Streams")
		AfterConnect
	Else
		Log(LastException.Message)
		UpdateStatus(False, True)
	End If
End Sub

Sub AfterConnect
	Dim pingB(1) As Byte
	pingB(0) = PING
	Streams.Write(pingB)
	Dim name As String = Phone.Manufacturer & " " & Phone.Model
	Dim b() As Byte = name.GetBytes("UTF8")
	Streams.Write(Utils.AddCommandToBytes(SEND_DEVICE_NAME, b, b.Length))
	If Main.FTPServerEnabled Then
		Streams.Write(Utils.AddCommandToBytes(SEND_FTP_ENABLED, Array As Byte(1), 1))
	End If
	SendVersions
	UpdateStatus(True, True)
End Sub

Sub SendVersions
	Dim b(9) As Byte
	Dim raf As RandomAccessFile = CreateRAF(b)
	raf.WriteByte(VERSIONS, raf.CurrentPosition)
	raf.WriteInt(Application.VersionCode, raf.CurrentPosition)
	Dim p As Phone
	raf.WriteInt(p.SdkVersion, raf.CurrentPosition)
	Streams.Write(b)
End Sub

Sub Streams_Error
	If Sender <> Streams Then Return
	Log(LastException.Message)
	UpdateStatus(False, True)
End Sub

Sub Streams_Terminated
	If Sender <> Streams Then Return
	UpdateStatus(False, True)
	Log("Streams_terminated")
End Sub

Sub Streams_NewData (Buffer() As Byte)
	If Streams.IsInitialized = False Then Return
	DisconnectTicks = 0 'reset the disconnect timer
	Dim command As Byte
	command = Buffer(0)
	Select command
		Case PING
			Streams.Write(Array As Byte(PING))
			If noDesignerInstalled And DateTime.Now > lastCheckForDesigner + 20 * DateTime.TicksPerSecond Then CheckIfDesignerIsInstalled
		Case APK_COPY_START
			HandleFileStart
		Case APK_PACKET
			Streams.Write(Array As Byte(PING))
			HandleFilePacket(Buffer)
		Case APK_COPY_CLOSE
			HandleFileClose
		Case START_LOGCAT
			StartLogcat(Buffer)
		Case STOP_LOGCAT
			StopLogcat
		Case LAUNCH_PROGRAM
			LaunchProgram(Buffer)
		Case KILL_PROGRAM
			KillProgram(Buffer)
		Case APK_SIZE
			Dim raf As RandomAccessFile = CreateRAF(Buffer)
			currentAPKTotal = raf.ReadInt(1)
			currentAPKWritten = 0
		Case VERSIONS
			Dim raf As RandomAccessFile = CreateRAF(Buffer)
			Dim ideVersion As Int = raf.ReadInt(1) 'ignore
	End Select
End Sub

Sub CreateRAF(buffer() As Byte) As RandomAccessFile
	Dim raf As RandomAccessFile
	raf.Initialize3(buffer, True)
	Return raf
End Sub

Sub CheckIfDesignerIsInstalled
	Dim pm As PackageManager
	Dim packages As List
	packages = pm.GetInstalledPackages
	Dim buffer() As Byte
	If packages.IndexOf("anywheresoftware.b4a.designer") = -1 Then
		buffer = "0".GetBytes("UTF8")
		noDesignerInstalled = True
		lastCheckForDesigner = DateTime.Now
	Else
		noDesignerInstalled = False
		Dim s As String
		s = pm.GetVersionCode("anywheresoftware.b4a.designer")
		buffer = s.GetBytes("UTF8")
	End If
	
	'we are sending the installed designer version so the IDE will decide if a new version should be installed.
	Streams.Write(Utils.AddCommandToBytes(ASK_FOR_DESIGNER, buffer, buffer.Length))
End Sub

Sub LaunchProgram (Buffer() As Byte)
	Dim s As String = BytesToString(Buffer, 1, Buffer.Length - 1, "UTF8")
	Dim args() As String
	args = Regex.Split(",", s)
	Dim In1 As Intent
	For i = 1 To args.Length - 1 Step 2
		Select args(i)
			Case "-a"
				In1.Initialize(args(i + 1), "")
			Case "-n"
				In1.SetComponent(args(i + 1))
			Case "-f"
				In1.Flags = Bit.ParseInt(args(i + 1).SubString(2), 16)
			Case "-c"
				In1.SetComponent(args(i + 1))
			Case "-e"
				In1.PutExtra(args(i + 1), args(i + 2))
				Exit
		End Select
	Next
	Try
		StartActivity(In1)
	Catch
		Log("Error starting intent: " & In1) 'ignore
	End Try
End Sub

Sub KillProgram (Buffer() As Byte)
	Dim package As String
	package = BytesToString(Buffer, 1, Buffer.Length - 1, "UTF8")
	Dim sb As StringBuilder
	sb.Initialize
	Phone.Shell("ps", Null, sb, Null)
	Dim m As Matcher
	m = Regex.Matcher2("^[^ ]*\s+(\d+) .*" & package, Regex.MULTILINE, sb.ToString)
	If m.Find Then
		Log("Package found: " & package)
		Phone.Shell("kill", Array As String(m.Group(1)), Null, Null)
	End If
End Sub

Sub StartLogcat (Buffer() As Byte)
	Dim args As String
	args = BytesToString(Buffer, 1, Buffer.Length - 1, "UTF8")
	LogCat.LogCatStart(Regex.Split(",", args), "LogCat")
End Sub

Sub LogCat_LogCatData (Buffer() As Byte, Length As Int)
	If ConnectedStatus = True Then
		Streams.Write(Utils.AddCommandToBytes(LOGCAT_DATA, Buffer, Length))
	End If
End Sub

Sub StopLogcat
	LogCat.LogCatStop
End Sub

Sub HandleFileStart
	Log("Installing file.")
	If Phone.SdkVersion >= 26 Then
		If IsPaused(Main) Then
			StartActivity(Main)
		End If
	End If
	Try
		If Out.IsInitialized Then Out.Close
	Catch
		Log(LastException)
	End Try
	Dim retries As Int = 5
	Do While retries > 0
		Try
			Out = File.OpenOutput(Starter.folder, "temp" & apkName & ".apk", False)
			Exit
		Catch
			Log(LastException.Message) 'this can happen if the file is locked.
			apkName = apkName + 1
			retries = retries - 1
		End Try
	Loop
	If retries = 0 Then
		ToastMessageShow("Error writing file.", True)
	End If
End Sub

Sub HandleFilePacket(Buffer() As Byte)
	Try
		Out.WriteBytes(Buffer, 1, Buffer.Length - 1)
	Catch
		Log(LastException)
	End Try
	currentAPKWritten = currentAPKWritten + Buffer.Length
	UpdateFileProgress
End Sub

Private Sub UpdateFileProgress
	If IsPaused(Main) = False Then
		CallSub(Main, "UpdateFileProgress")
	End If
End Sub

Sub HandleFileClose
	Try
		Out.Close
	Catch
		Log(LastException)
		ToastMessageShow("Error saving APK.", True)
		Return
	End Try
	currentAPKTotal = 0
	UpdateFileProgress
	'ask the system to install the apk
	SendInstallIntent
	If UdpServer.IsInitialized Then
		Dim port As String
		port = UdpServer.port
		Dim b() As Byte = port.GetBytes("UTF8")
		Streams.Write(Utils.AddCommandToBytes(BRIDGE_LOG_PORT, b, b.Length))
	End If
	Sleep(1000)
	If IsPaused(Main) = False Then
		Log("sending another install intent")
		SendInstallIntent
	End If
End Sub

Private Sub SendInstallIntent
	Dim i As Intent
	If Phone.SdkVersion >= 24 Then
		i.Initialize("android.intent.action.INSTALL_PACKAGE", CreateFileProviderUri(Starter.folder, "temp" & apkName & ".apk"))
		i.Flags = Bit.Or(i.Flags, 1) 'FLAG_GRANT_READ_URI_PERMISSION
	Else
		i.Initialize(i.ACTION_VIEW, "file://" & File.Combine(Starter.folder, "temp" & apkName & ".apk"))
		i.SetType("application/vnd.android.package-archive")
	End If
	StartActivity(i)
End Sub

Sub PE_PackageAdded (Package As String, Intent As Intent)
	Log("PackageAdded: " & Package)
End Sub
Sub PE_ConnectivityChanged (NetworkType As String, State As String, Intent As Intent)
	If NetworkType = "WIFI" Then CallSub(Main, "UpdateIp")
End Sub

Sub UDP_PacketArrived (Packet As UDPPacket)
	Log(BytesToString(Packet.Data, Packet.Offset, Packet.Length, "UTF8"))
End Sub

Sub CreateFileProviderUri (Dir As String, FileName As String) As Object
	Dim FileProvider As JavaObject
	Dim context As JavaObject
	context.InitializeContext
	FileProvider.InitializeStatic("android.support.v4.content.FileProvider")
	Dim f As JavaObject
	f.InitializeNewInstance("java.io.File", Array(Dir, FileName))
	Return FileProvider.RunMethod("getUriForFile", Array(context, Application.PackageName & ".provider", f))
End Sub
