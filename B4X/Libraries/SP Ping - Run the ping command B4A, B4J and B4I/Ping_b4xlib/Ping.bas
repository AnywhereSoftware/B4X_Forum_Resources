B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
#Event: PingStarted
#Event: PingFinished
#Event: PingError(Msg As String)
Sub Class_Globals
	Private mCallback As Object
	Private mEventName As String
	Private xui As XUI
	Type tpePing (Success As Boolean, toHost As String, toIP As String, fromDest As String, mapResponse As Map, mapStatistics As Map)
	Public pingResult As tpePing
  #If B4J
	Private mapRegEx As Map
	Private mapLang As String
	Private Pinger As B4JPing
	#Else If B4I
	'Ext Library: https://www.b4x.com/android/forum/threads/iping-send-and-receive-ping-icmp-packets.132440/#content
	Private Pinger As SimplePing
	Private lngTStart As Long = 0
	#End If
	Private mapSeq As Map
	Private icmp_seq As Map
	Public Destination As String
	Public Attempts As Byte
	Public Timeout As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallBack As Object, EventName As String)
	pingResult.Initialize
	mCallback = CallBack
	mEventName = EventName
	Destination = "google.com"
	Attempts = 1
	Timeout = 200
	pingResult.mapResponse.Initialize
	pingResult.mapStatistics.Initialize
	icmp_seq.Initialize
	mapSeq.Initialize
	#if B4J
	Pinger.Initialize(Me, "B4JPinger")
	#End If
End Sub

'B4A Piing Version
#If B4A
Public Sub Start()
	mapSeq.Clear
	icmp_seq.Clear
	If Attempts = 0 Then
		If xui.SubExists(mCallback, mEventName & "_PingError", 1) Then
			CallSub2(mCallback, mEventName & "_PingError", "Attempts must be greater than or equal to 1")
		End If
	Else
		If xui.SubExists(mCallback, mEventName & "_PingStarted", 0) Then
			CallSub(mCallback, mEventName & "_PingStarted")
		End If
		Dim sb As StringBuilder
		sb.Initialize
		Dim p As Phone
		p.Shell("ping " & IIf(Attempts > 0, "-c" & Attempts, "") & " -W" & Timeout & " -v " & Destination, Null, sb, Null)
		If sb.Length = 0 Then
			If xui.SubExists(mCallback, mEventName & "_PingError", 1) Then
				CallSub2(mCallback, mEventName & "_PingError", "Host unreachable")
			End If
		Else
			pingResult.Success = True
			Dim aryResult() As String = Regex.Split(CRLF, sb.ToString)
			Dim blnIsFirstLine As Boolean = False
			Dim blnStats As Boolean = False
			Dim bteLine As Byte = 0
			Dim matchStats As Matcher
			For Each lneResult As String In aryResult
				If Not (blnIsFirstLine) Then
					Dim regexHostInfo As String = "PING ([^ ]+) \(([^)]+)\) "
					blnIsFirstLine = True
					' Match host info
					Dim matchHost As Matcher = Regex.Matcher(regexHostInfo, lneResult)
					If matchHost.Find Then
						pingResult.toHost = matchHost.Group(1)
						pingResult.toIP = matchHost.Group(2)
					End If
				Else If Not (blnStats)  Then
					If lneResult <> "" And lneResult.IndexOf("ping statistics") = -1 Then
						Dim regexICMPSeq As String = ".* from ([^ ]+) \(([^)]+)\): icmp_seq=([0-9]+) ttl=([0-9]+) time=([0-9.]+) ms"
						Dim matchICMPSeq As Matcher = Regex.Matcher(regexICMPSeq, lneResult)
						If matchICMPSeq.Find Then
							mapSeq.Put("ttl", matchICMPSeq.Group(4))
							mapSeq.Put("time", matchICMPSeq.Group(5))
							icmp_seq.Put(matchICMPSeq.Group(3).As (Byte), mapSeq)
							If icmp_seq.Size = 1 Then
								pingResult.fromDest = matchICMPSeq.Group(1)
							End If
						End If
					End If
				Else If blnStats Then
					If bteLine = 0 Then
						Dim regexStatsLine1 As String = "([0-9]+) packets transmitted, ([0-9]+) received, ([0-9]+)% packet loss, time ([0-9]+)ms"
						matchStats = Regex.Matcher(regexStatsLine1, lneResult)
						If matchStats.Find Then
							pingResult.mapStatistics.Put("packets transmitted", matchStats.Group(1))
							pingResult.mapStatistics.Put("received", matchStats.Group(2))
							pingResult.mapStatistics.Put("packet loss",matchStats.Group(3))
							pingResult.mapStatistics.Put("time", matchStats.Group(4))
						End If
					Else If bteLine = 1 Then
						Dim regexStatsLine2 As String = "rtt min/avg/max/mdev = ([\d\.]+)/([\d\.]+)/([\d\.]+)/([\d\.]+) ms"
						Dim matchStats As Matcher = Regex.Matcher(regexStatsLine2, lneResult)
						If matchStats.Find Then
							pingResult.mapStatistics.Put("rtt min", matchStats.Group(1))
							pingResult.mapStatistics.Put("rtt agv", matchStats.Group(2))
							pingResult.mapStatistics.Put("rtt max", matchStats.Group(3))
							pingResult.mapStatistics.Put("rtt mdev", matchStats.Group(4))
						End If
					End If
					bteLine = bteLine + 1
				End If
				If Not (blnStats) Then
					'Skip --- DEST_HOST ping statistics --- string and add map with all ping's result to pingResult
					If lneResult.IndexOf("ping statistics") > 0 Then
						pingResult.mapResponse = icmp_seq
						blnStats = True
					End If
				End If
			Next
		End If
	End If
	If xui.SubExists(mCallback, mEventName & "_PingFinished", 0) Then
		CallSub(mCallback, mEventName & "_PingFinished")
	End If
End Sub
#End IF

'B4J Piing Version
#If B4J
Public Sub Start()
	mapSeq.Clear
	icmp_seq.Clear
	Dim parser As JSONParser
	parser.Initialize(File.ReadString(File.DirAssets, "os.lang.ping.json"))
	Dim jRoot As Map = parser.NextObject
	Dim SystemLanguaje As String = getSystemLanguage
	mapLang = jRoot.Get(SystemLanguaje)
	If mapLang = Null Then
		Log("ERROR: LANGUAGE NOT FOUND " & mapLang)
		If xui.SubExists(mCallback, mEventName & "_PingError", 1) Then
			CallSub2(mCallback, mEventName & "_PingError", "ERROR: LANGUAGE NOT FOUND " & SystemLanguaje)
		End If
	Else
		mapRegEx = jRoot.Get(SystemLanguaje).As (Map)
		Pinger.Host = Destination
		Pinger.Attempt = Attempts
		Pinger.Timeout = Timeout
		Pinger.Encoding = "850"
		Pinger.Start()
	End If
End Sub

Private Sub B4JPinger_ResponseSuccessFul (values As List)
	If values = Null Then
		If xui.SubExists(mCallback, mEventName & "_PingError", 1) Then
			CallSub2(mCallback, mEventName & "_PingError", "Can't run ping command on your system")
		End If
	Else
		Dim blnIsFirstLine As Boolean = False
		Dim blnStats As Boolean = False
		Dim bteLine As Byte = 0
		Dim matchStats As Matcher
		pingResult.Success = True
		For Each lneResult As String In values
			If lneResult.Trim <> "" Then
				If Not (blnIsFirstLine) Then
					Dim regexHostInfo As String = mapRegEx.Get("Pinging_regex")
					blnIsFirstLine = True
					' Match host info
					Dim matchHost As Matcher = Regex.Matcher(regexHostInfo, lneResult)
					If matchHost.Find Then
						pingResult.toHost = matchHost.Group(1)
						pingResult.toIP = matchHost.Group(2)
					End If
				Else If Not (blnStats)  Then
					If lneResult <> "" And Not (Regex.Matcher(mapRegEx.Get("Statistics_regex"), lneResult).Find) Then
						Dim regexICMPSeq As String = mapRegEx.Get("Reply_regex")
						Dim matchICMPSeq As Matcher = Regex.Matcher(regexICMPSeq, lneResult)
						bteLine = bteLine + 1
						If matchICMPSeq.Find Then
							mapSeq.Put("time", matchICMPSeq.Group(3))
							mapSeq.Put("ttl", matchICMPSeq.Group(4))
							If icmp_seq.Size = 0 Then
								pingResult.fromDest = matchICMPSeq.Group(1)
							End If
						End If
						icmp_seq.Put(bteLine, mapSeq)
					End If
				Else If blnStats Then
					If bteLine = 0 Then
						Dim regexStatsLine1 As String = mapRegEx.Get("StatsLine1_regex")
						matchStats = Regex.Matcher(regexStatsLine1, lneResult)
						If matchStats.Find Then
							pingResult.mapStatistics.Put("packets transmitted", matchStats.Group(1))
							pingResult.mapStatistics.Put("received", matchStats.Group(2))
							pingResult.mapStatistics.Put("packet loss",matchStats.Group(3))
							pingResult.mapStatistics.Put("time", 0)
						End If
						bteLine = bteLine + 1
					Else If bteLine = 1 Then
						Dim regexStatsLine2 As String = mapRegEx.Get("StatsLine2_regex")
						Dim matchStats As Matcher = Regex.Matcher(regexStatsLine2, lneResult)
						If matchStats.Find Then
							pingResult.mapStatistics.Put("rtt min", matchStats.Group(1))
							pingResult.mapStatistics.Put("rtt agv", matchStats.Group(2))
							pingResult.mapStatistics.Put("rtt max", matchStats.Group(3))
						End If
					End If
				End If
				If Not (blnStats) Then
					'Skip --- DEST_HOST ping statistics --- string and add map with all ping's result to pingResult
					If Regex.Matcher(mapRegEx.Get("Statistics_regex"), lneResult).Find Then
						pingResult.mapResponse = icmp_seq
						blnStats = True
						bteLine = 0
					End If
				End If
			End If
		Next
		If xui.SubExists(mCallback, mEventName & "_PingFinished", 0) Then
			CallSub(mCallback, mEventName & "_PingFinished")
		End If
	End If
End Sub

Private Sub B4JPinger_ResponseError (values As List)
	Dim sb As StringBuilder
	sb.Initialize
	For Each value In values
		sb.Append(value).Append(CRLF)
	Next
	If xui.SubExists(mCallback, mEventName & "_PingError", 1) Then
		CallSub2(mCallback, mEventName & "_PingError", sb.ToString)
	End If
End Sub

Private Sub getSystemLanguage As String
	Dim defaultLocale As JavaObject
	defaultLocale.InitializeStatic("java.util.Locale")
	Dim systemLocale As JavaObject = defaultLocale.RunMethod("getDefault", Null)
	Return systemLocale.RunMethod("getLanguage", Null)
End Sub
#End If

'B4I Piing Version
#If B4I
Public Sub Start()
	mapSeq.Clear
	icmp_seq.Clear
	Pinger.Initialize("iOSPing", Destination)
	Pinger.Start
	Wait For iOSPing_Start (Success As Boolean)
	pingResult.Success = Success
	pingResult.toHost = Destination
	If pingResult.Success Then
		For i = 1 To Attempts
			lngTStart = DateTime.Now
			Pinger.Send
			Wait For iOSPing_PacketSent (SequenceNumber As Int, Success As Boolean)
			Sleep(Timeout)
		Next
	Else
		If xui.SubExists(mCallback, mEventName & "_PingError", 1) Then
			CallSub2(mCallback, mEventName & "_PingError", LastException)
		End If
	End If
	Pinger.Stop
	pingResult.mapResponse = icmp_seq
	If xui.SubExists(mCallback, mEventName & "_PingFinished", 0) Then
		CallSub(mCallback, mEventName & "_PingFinished")
	End If
End Sub

Private Sub iOSPing_Start (Success As Boolean)
	If xui.SubExists(mCallback, mEventName & "_PingStarted", 0) Then
		CallSub(mCallback, mEventName & "_PingStarted")
	End If
End Sub

Private Sub iOSPing_PacketSent (SequenceNumber As Int, Success As Boolean)

End Sub

Private Sub iOSPing_PacketReceived (SequenceNumber As Int)
	mapSeq.Put("time", DateTime.Now - lngTStart)
	icmp_seq.Put(SequenceNumber + 1, mapSeq)
End Sub

#End If
