B4A=true
Group=Bridge
ModulesStructureVersion=1
Type=Service
Version=7.3
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public folder As String
	Public rp As RuntimePermissions
	Private AutoDiscoverUdpSocket As UDPSocket
	Private Phone As Phone
	Private lastPing As Long
	Private MulticastLock As JavaObject
End Sub

Sub Service_Create
	folder = rp.GetSafeDirDefaultExternal("")
	If folder = File.DirInternal Then
		ToastMessageShow("Secondary storage is not available. You will need to switch to USB debug mode.", True)
	End If
	Try
		AutoDiscoverUdpSocket.Initialize("AutoDiscoverUdpSocket", 58912, 8192)
	Catch
		Log("Error opening auto discover port")
		Log(LastException)
	End Try
	AcquireMulticastLock
End Sub

Sub AcquireMulticastLock
	Try
		Dim ctxt As JavaObject
		ctxt.InitializeContext
		Dim WifiManager As JavaObject = ctxt.RunMethod("getSystemService", Array("wifi"))
		MulticastLock = WifiManager.RunMethodJO("createMulticastLock", Array("b4a-udp"))
		MulticastLock.RunMethod("acquire", Null)
	Catch
		Log(LastException)
	End Try
End Sub

Sub AutoDiscoverUdpSocket_PacketArrived (Packet As UDPPacket)
	Dim p As UDPPacket
	Dim name As String = Phone.Manufacturer & " " & Phone.Model
	If IsPaused(Service1) Then name = name & " (not started)"
	Dim b() As Byte = name.GetBytes("UTF8")
	p.Initialize(Utils.AddCommandToBytes(2, b, b.Length), Packet.HostAddress, Packet.Port)
	AutoDiscoverUdpSocket.Send(p)
	If DateTime.Now < lastPing + 3000 Then Return
	lastPing = DateTime.Now
	If IsPaused(Main) = False Then CallSubDelayed(Main, "UdpPing")
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
