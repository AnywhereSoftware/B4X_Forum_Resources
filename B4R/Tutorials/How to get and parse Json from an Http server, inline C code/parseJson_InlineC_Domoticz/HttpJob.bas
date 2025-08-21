B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=1.78
@EndOfDesignText@
'version 0.9
Sub Process_Globals
	Private requestCache(500) As Byte
	Private responseCache(8000) As Byte
	Private responseIndex As Int
	Private mJobname(32) As Byte
	Private mVerb(8) As Byte
	Private bc As ByteConverter
	Private ssl As Boolean
	Private port As Int
	Private hostIndex, hostLen, pathIndex, pathLen, payloadIndex, payloadLen, headersIndex, headersLen As Int
	Private astream As AsyncStreams
	Private socket As WiFiSocket
	Private sslsocket As WiFiSSLSocket
	Public EOL() As Byte = Array As Byte(13, 10)
	Type JobResult (JobName() As Byte, ErrorMessage() As Byte, Success As Boolean, Response() As Byte, Status As Int)
End Sub

Public Sub Initialize(JobName As String)
	bc.ArrayCopy(JobName, mJobname)
	headersIndex = 0
	headersLen = 0
	
End Sub

Public Sub AddHeader(Key() As Byte, Value() As Byte)
	Dim b() As Byte = JoinBytes(Array(Key, ": ".GetBytes, Value, EOL))
	bc.ArrayCopy2(b, 0, requestCache, headersIndex + headersLen, b.Length)
	headersLen = headersLen + b.Length
End Sub

Public Sub Download (Link() As Byte)
	ParseLink(Link, Null)
	bc.ArrayCopy("GET", mVerb)
	SendRequest(0)
End Sub

Public Sub Post (Link() As Byte, Payload() As Byte)
	ParseLink(Link, Payload)
	bc.ArrayCopy("POST", mVerb)
	SendRequest(0)
End Sub

Private Sub SendRequest (unused As Byte)
	Dim host As String = bc.StringFromBytes(bc.SubString2(requestCache, hostIndex, hostIndex + hostLen))
	Dim st As Stream = Null
	'Log("trying to connect to: ", host, "port: ", port, " ssl: ", ssl)
	If ssl Then
		sslsocket.Close
		If sslsocket.ConnectHost(host, port) Then
			st = sslsocket.Stream
		End If
	Else
		socket.Close
		If socket.ConnectHost(host, port) Then
			st = socket.Stream
		End If
	End If
	If st = Null Then
		SetError("Failed to connect")
		Return
	End If
	'Log("connected: ", host)
	responseIndex = 0
	astream.Initialize(st, "Astream_NewData", "Astream_Error")
	astream.Write(mVerb).Write(" ").Write(bc.SubString2(requestCache, pathIndex, pathIndex + pathLen)).Write(" HTTP/1.0").Write(EOL)
	'Log(mVerb," ", bc.SubString2(requestCache, pathIndex, pathIndex + pathLen)," HTTP/1.0")
	astream.Write("Host: ").Write(host).Write(EOL)
	astream.Write("Connection: close").Write(EOL)
	Dim payload() As Byte = bc.SubString2(requestCache, payloadIndex, payloadIndex + payloadLen)
	If payload.Length > 0 Then
		astream.Write("Content-Length: ").Write(NumberFormat(payload.Length, 0, 0)).Write(EOL)
	End If
	If headersLen > 0 Then
		astream.Write(bc.SubString2(requestCache, headersIndex, headersIndex + headersLen))
	End If
	astream.Write(EOL)
	If payload.Length > 0 Then
		astream.Write(payload)
	End If
End Sub

Private Sub AStream_NewData (Buffer() As Byte)
	If responseIndex + Buffer.Length > responseCache.Length Then
		Log("ResponseCache is full (", Buffer.Length, ")")
		Return
	End If
	bc.ArrayCopy2(Buffer, 0, responseCache, responseIndex, Buffer.Length)
	responseIndex = responseIndex + Buffer.Length
End Sub

Private Sub AStream_Error
	ParseResult
End Sub

Private Sub ParseResult
	If responseIndex = 0 Then
		SetError("Response not available.")
		Return
	End If
	Dim response() As Byte = bc.SubString2(responseCache, 0, responseIndex)
	Dim i As Int = bc.IndexOf(response, EOL)
	Dim statusLine() As Byte = bc.SubString2(response, 0, i)
	Dim i1 As Int = bc.IndexOf(statusLine, " ")
	Dim i2 As Int = bc.IndexOf2(statusLine, " ", i1 + 1)
	Dim status As Int = bc.StringFromBytes(bc.SubString2(statusLine, i1 + 1, i2))
	If Floor(status / 100) = 3 Then 'handle redirections
		i1 = bc.IndexOf(response, "Location:")
		If i1 > -1 Then
			i2 = bc.IndexOf2(response, EOL, i1 + 1)
			Dim NewPath() As Byte = bc.Trim(bc.SubString2(response, i1 + 9, i2))
			Log("Redirecting to: ", NewPath)
			ParseLink(NewPath, bc.SubString2(requestCache, payloadIndex, payloadIndex + payloadLen))
			CallSubPlus("SendRequest", 1, 0) 'to avoid stack overflows
			Return
		End If
	End If
	Dim jr As JobResult
	jr.Success = Floor(status / 100) = 2
	i = bc.IndexOf(response, Array As Byte(13, 10, 13, 10))
	jr.Response = bc.SubString(response, i + 4)
	jr.JobName = mJobname
	jr.ErrorMessage = Array As Byte()
	jr.Status = status
	Main.JobDone(jr)
End Sub

Private Sub ParseLink (Link() As Byte, Payload() As Byte)
	Dim hostStart As Int
	If bc.StartsWith(Link, "https://") Then
		ssl = True
		hostStart = 8
	Else if bc.StartsWith(Link, "http://") Then
		ssl = False
		hostStart = 7
	Else
		SetError("Invalid link")		
		Return
	End If
	Dim i As Int = bc.IndexOf2(Link, "/", hostStart)
	Dim path() As Byte
	If i = -1 Then
		i = Link.Length
		path = "/"
	End If
	Dim host() As Byte = bc.SubString2(Link, hostStart, i)
	If i < Link.Length Then path = bc.SubString(Link, i)
	Dim colonStart As Int = bc.IndexOf(host, ":")
	If colonStart > -1 Then
		port = bc.StringFromBytes(bc.SubString(host, colonStart + 1))
		host = bc.SubString2(host, 0, colonStart)
	Else
		If ssl Then port = 443 Else port = 80
	End If
	SetRequestCache(host, path, Payload)
End Sub

Private Sub SetRequestCache(host() As Byte, path() As Byte, payload() As Byte)
	If payload = Null Then payload = Array As Byte()
	payloadIndex = headersIndex + headersLen
	payloadLen = payload.Length
	bc.ArrayCopy2(payload, 0, requestCache, payloadIndex, payloadLen)
	hostIndex = payloadIndex + payloadLen
	hostLen = host.Length
	bc.ArrayCopy2(host, 0, requestCache, hostIndex, hostLen)
	pathIndex = hostIndex + hostLen
	pathLen = path.Length
	bc.ArrayCopy2(path, 0, requestCache, pathIndex, pathLen)
End Sub

Private Sub SetError (msg() As Byte)
	Dim jr As JobResult
	jr.JobName = mJobname
	jr.ErrorMessage = msg
	jr.Response = Array As Byte()
	jr.Success = False
	jr.Status = 0
	Main.JobDone(jr)
End Sub

