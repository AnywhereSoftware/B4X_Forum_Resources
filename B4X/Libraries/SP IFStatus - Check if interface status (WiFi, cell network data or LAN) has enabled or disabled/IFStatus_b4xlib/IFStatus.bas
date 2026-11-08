Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
#Event: SocketStarted (Port As Int)
#Event: SocketClosed
#Event: ConnectionStatusChanged (IPStatus As tpeIPs)
#Event: Error (Msg As String)

Sub Class_Globals
	Private mCallBack As Object
	Private mEvent As String
	Private strPrevIP As String
	Private libNet As ServerSocket
	Type tpeIPs (IsIfConnected As Boolean, ConnType As String, IP As String)
	Public IPs As tpeIPs
	Public Tag As Object = Null
	Public blnIPv4IsValid As Boolean
	Public blnIPv6IsValid As Boolean
	Private xui As XUI
	Private Const IPv4Pattern As String = "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
	Private Const IPv6Pattern As String = "^([0-9a-fA-F]{1,4}:){7}([0-9a-fA-F]{1,4}|:)|(([0-9a-fA-F]{1,4}:){1,7}|:):(([0-9a-fA-F]{1,4}:){1,7}|:)|(([0-9a-fA-F]{1,4}:){1,6}|:):(([0-9a-fA-F]{1,4}:){1,6}|:)|(([0-9a-fA-F]{1,4}:){1,5}|:):(([0-9a-fA-F]{1,4}:){1,5}|:)|(([0-9a-fA-F]{1,4}:){1,4}|:):(([0-9a-fA-F]{1,4}:){1,4}|:)|(([0-9a-fA-F]{1,4}:){1,3}|:):(([0-9a-fA-F]{1,4}:){1,3}|:)|(([0-9a-fA-F]{1,4}:){1,2}|:):(([0-9a-fA-F]{1,4}:){1,2}|:)|(([0-9a-fA-F]{1,4}:)|:):(([0-9a-fA-F]{1,4}:)|:)|(([0-9a-fA-F]{1,4})|:):(([0-9a-fA-F]{1,4})|:)|(([0-9a-fA-F]{1,4})|:):(([0-9a-fA-F]{1,4})|:)|(([0-9a-fA-F]{1,4})|:):(([0-9a-fA-F]{1,4})|:)|(([0-9a-fA-F]{1,4})|:):(([0-9a-fA-F]{1,4})|:)|(([0-9a-fA-F]{1,4})|:):(([0-9a-fA-F]{1,4})|:)|(([0-9a-fA-F]{1,4})|:):(([0-9a-fA-F]{1,4})|:)|(([0-9a-fA-F]{1,4})|:):(([0-9a-fA-F]{1,4})|:)|(([0-9a-fA-F]{1,4})|:):(([0-9a-fA-F]{1,4})|:)|(([0-9a-fA-F]{1,4})|:)|::([0-9a-fA-F]{1,4}){0,6})$"
End Sub

#Region "Helper"
'Only required on B4I
Private Sub libNet_NewConnection (Successful As Boolean, NewSocket As Socket)

End Sub

Private Sub ResetValues()
	strPrevIP = ""
	IPs.IsIFConnected = False
	IPs.ConnType = "NONE"
	IPs.IP = "127.0.0.1"
End Sub

Private Sub RaiseStatusChanged()
	If xui.SubExists(mCallBack, mEvent & "_ConnectionStatusChanged", 1) Then
		CallSub2(mCallBack, mEvent & "_ConnectionStatusChanged", IPs)
	End If
End Sub

Private Sub RaiseError(strMsg As String)
	If xui.SubExists(mCallBack, mEvent & "_Error", 1) Then
		CallSub2(mCallBack, mEvent & "_Error", strMsg)
	End If
End Sub
#End Region

'Initialize class
Public Sub Initialize(CallBack As Object, EventName As String)
	'By default the variable IPs have these values
	ResetValues
	mCallBack = CallBack
	mEvent = EventName
End Sub

'Check if the connectivity status has changed
'ForceRaiseStatus - (Boolean) Force raise ConnectionStatusChanged event to run. If false, the event is only fired if the IP has changed.
Public Sub GetIfChanged(ForceRaiseStatus As Boolean)
	If Not (libNet.IsInitialized) Then
		ResetValues
		RaiseError("Socket not initialized.")
		RaiseStatusChanged
	Else
		Try
			Dim strLocalIP As String
			Dim strWiFiIP As String
			Dim blnLocalIP As Boolean
			Dim blnWiFiIP As Boolean
			'GetMyWiFiIP is not valid in B4J
			#If B4J
	    strWiFiIP = "127.0.0.1"
			blnWiFiIP = False
			#Else
			strWiFiIP = libNet.GetMyWiFiIP
			blnWiFiIP = IsValidIP(strWiFiIP)
			#End If
			strLocalIP = libNet.GetMyIP
			blnLocalIP = IsValidIP(strLocalIP)
		  If blnLocalIP Or blnWiFiIP Then
				If strLocalIP <> "127.0.0.1" Or strWiFiIP <> "127.0.0.1" Then
					IPs.IsIfConnected = True
					If strWiFiIP = "127.0.0.1" And strLocalIP <> "127.0.0.1" Then
						#If B4J
						IPs.ConnType = "LAN"
						#Else
						IPs.ConnType = "CELL"
						#End If
						IPs.IP = strLocalIP
					Else If strWiFiIP <> "127.0.0.1" And strLocalIP <> "127.0.0.1" Then
						IPs.ConnType = "WIFI"
						IPs.IP = strWiFiIP
					End If
				Else If strWiFiIP = "127.0.0.1" And strLocalIP = "127.0.0.1" Then
					ResetValues
				End If
				If strPrevIP <> IPs.IP Or ForceRaiseStatus Then
					RaiseStatusChanged
				End If
			Else
				ResetValues
				RaiseError("The IP format is not valid.")
				RaiseStatusChanged
			End If
		Catch
			ResetValues
			RaiseError("Can't initialize socket.")
			RaiseStatusChanged
		End Try
		strPrevIP = IPs.IP
	End If
End Sub

'Initialize the socket
'Port - (Int) The number can be 0 or one greater than or equal to 1025 up to 65535
'           Search on this <a href="https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers">list of ports</a> for one that is available and does not conflict with another service
Public Sub Start(Port As Int)
	ResetValues
	If Not (libNet.IsInitialized) Then
		libNet.Initialize(Port, "libNet")
		If libNet.IsInitialized Then
			If xui.SubExists(mCallBack, mEvent & "_SocketStarted", 1) Then
				CallSub2(mCallBack, mEvent & "_SocketStarted", Port)
			End If
			'Run to get initial values
			GetIfChanged(False)
		Else
			RaiseError("Can't initialize socket on port " & Port & ".")
		End If
	Else
		RaiseError("Socket is already initialized on port " & Port & ".")
	End If
End Sub

'Close the socket if it is already open.
Public Sub Close
	If libNet.IsInitialized Then
		libNet.Close
		ResetValues
		If xui.SubExists(mCallBack, mEvent & "_SocketClosed", 0) Then
			CallSub(mCallBack, mEvent & "_SocketClosed")
		End If
		RaiseStatusChanged
	Else
		RaiseError("Socket not initialized.")
	End If
End Sub

'Check if the value is valid IPv4 or IPv6 and return True or False
'IP - (String) IP value to verify
'       Valid range for IPv4 0.0.0.0 to 255.255.255.255
'       Valid range for IPv6 0000:0000:0000:0000:0000:0000:0000:0000 to ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
Public Sub IsValidIP(IP As String) As Boolean
	Dim matcherIPv4 As Matcher
	Dim matcherIPv6 As Matcher
	Try
		matcherIPv4 = Regex.Matcher(IPv4Pattern, IP)
		blnIPv4IsValid = True
	Catch
		blnIPv4IsValid = False
	End Try
	Try
		matcherIPv6 = Regex.Matcher(IPv6Pattern, IP)
		blnIPv6IsValid = True
	Catch
		blnIPv6IsValid = False
	End Try
	Return matcherIPv4.Find Or matcherIPv6.Find
End Sub

'Checks if the value is a valid URI and return True or False
Public Sub IsValidURL(Url As String) As Boolean
	Return Regex.IsMatch("(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})$", Url)
End Sub