B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=2.2
@EndOfDesignText@
'version 2.3 Erel's HttpJob module + Peacemaker's QueueManager
Sub Process_Globals
	Private requestCache(5001) As Byte
	Private responseCache(14000) As Byte
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
	Private ResponseTimer As Timer
	Public ResponseTimeout As UInt = 7000
	Public WorkingFlag As Boolean
	Public HttpErrorsCounter As ULong
	
	'-------------------------------
	Private QueueSlotIndex As UInt = -1
	Private QueueSize As Byte = 0
	Private POSTurl(100) As Byte
	Private timOverload As Timer
	
	'The data will be stored in this buffer.
	'Change its size if you encounter out of bounds errors.
	Private const QueueLimit As Byte = 8	'ignore hardcoded max qty in memory
	Private JobName0(32), JobName1(32), JobName2(32), JobName3(32), JobName4(32), JobName5(32), JobName6(32), JobName7(32) As Byte
	Private Payload0(5001), Payload1(5001), Payload2(5001), Payload3(5001), Payload4(5001), Payload5(5001), Payload6(5001), Payload7(5001) As Byte
	Private RequestTypes(8) As Byte	'0/1 = GET/POST for each slot
End Sub


#Region ------Erel's HTTPJob module code--------------
Public Sub Initialize(JobName() As Byte)
	bc.ArrayCopy(JobName, mJobname)
	headersIndex = 0
	headersLen = 0
	ResponseTimer.Initialize("ResponseTimer_Tick", ResponseTimeout)
	timOverload.Initialize("timOverload_Tick", 2000)
End Sub

Private Sub ResponseTimer_Tick
	Log("Response timeout timer fired !")
	ParseResult
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
'	AddHeader("User-Agent", webapi.UserAgent)
'	AddHeader("Content-Type", "application/json;charset=UTF-8")
'	AddHeader("Id-Client", JoinStrings(Array As String(Main.bc.HexFromBytes(others.MacArray), "_", Main.ver)))
	
	ParseLink(Link, Payload)
	bc.ArrayCopy("POST", mVerb)
	SendRequest(0)
End Sub

Public Sub Put (Link() As Byte, Payload() As Byte)
	ParseLink(Link, Payload)
	bc.ArrayCopy("PUT", mVerb)
	SendRequest(0)
End Sub

Private Sub SendRequest (unused As Byte)
	Dim host As String = bc.StringFromBytes(bc.SubString2(requestCache, hostIndex, hostIndex + hostLen))
	Dim st As Stream = Null
	'Log("trying to connect to: ", host, " port: ", port, " ssl: ", ssl)
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
	Log("connected: ", host)
	responseIndex = 0
	astream.Initialize(st, "Astream_NewData", "Astream_Error")
	astream.Write(mVerb).Write(" ").Write(bc.SubString2(requestCache, pathIndex, pathIndex + pathLen)).Write(" HTTP/1.0").Write(EOL)
	'Log(mVerb," ", bc.SubString2(requestCache, pathIndex, pathIndex + pathLen)," HTTP/1.0")
	astream.Write("Host: ").Write(host).Write(EOL)
	astream.Write("Connection: close").Write(EOL)
	Dim Payload() As Byte = bc.SubString2(requestCache, payloadIndex, payloadIndex + payloadLen)
	If Payload.Length > 0 Then
		astream.Write("Content-Length: ").Write(NumberFormat(Payload.Length, 0, 0)).Write(EOL)
	End If
	If headersLen > 0 Then
		astream.Write(bc.SubString2(requestCache, headersIndex, headersIndex + headersLen))
	End If
	astream.Write(EOL)
	If Payload.Length > 0 Then
		astream.Write(Payload)
	End If
End Sub

Private Sub AStream_NewData (Buffer() As Byte)
	If ResponseTimer.Enabled = False Then ResponseTimer.Enabled = True
	'Log("NewData: " , Buffer)
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
	ResponseTimer.Enabled = False
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
	HttpErrorsCounter = 0	'reset
	ProcessNextRequest(jr)
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
		Log("Invalid link:", Link)
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
	HttpErrorsCounter = HttpErrorsCounter + 1
	Dim jr As JobResult
	jr.JobName = mJobname
	jr.ErrorMessage = msg
	jr.Response = Array As Byte()
	jr.Success = False
	jr.Status = 0
	Main.JobDone(jr)
End Sub
#End Region

#Region -----------QueueManager---------------------

'Add HTTP-request into the FIFO queue and start processing according to the queue
'RequestType = 0/1 = GET/POST for each slot
'URL is saved for GET request, used as the single API URL for all POST requests
'Payload: Null for GET request, payload text for POST request
Public Sub AddRequestToQueue(NewJobName() As Byte, RequestType As Byte, URL() As Byte, Payload() As Byte) As Boolean
	Log("---------AddRequestToQueue: QueueSize1 = ", QueueSize)
	If timOverload.Enabled = False Then timOverload.Enabled = True
	Dim isFullQueue As Boolean = QueueSize >= QueueLimit
	If isFullQueue Then
		Log("Queue is full, addition was ignored")
	Else
		Dim AddingAllowed As Boolean = True

'		Dim filter As String = "API_LOAD_command"
'		If QueueSize > 0 And bc.ArrayCompare(NewJobName, filter) = 0 Then
'			If (bc.StartsWith(JobName0, filter) Or bc.StartsWith(JobName1, filter)  Or bc.StartsWith(JobName2, filter)  Or bc.StartsWith(JobName3, filter)  Or bc.StartsWith(JobName4, filter)  Or bc.StartsWith(JobName5, filter)  Or bc.StartsWith(JobName6, filter)  Or bc.StartsWith(JobName7, filter)) Then
'				Log("Such request is already in the queue, addition was ignored: ", filter)
'				Dim AddingAllowed As Boolean = False
'			End If
'		End If		
		
		If AddingAllowed Then
			QueueSize = QueueSize + 1
			Log("Incremented QueueSize = ", QueueSize)
			RequestTypes(QueueSize - 1) = RequestType
			Log("ADDING NEW JOB: ", QueueSize - 1, ": ", NewJobName)
			If RequestType = 0 Then	'GET
				SaveJobNameSlot(QueueSize - 1, NewJobName)
				SavePayloadSlot(QueueSize - 1, URL)
			Else if RequestType = 1 Then	'POST
				bc.ArrayCopy(URL, POSTurl)	'URL for all POST requests
				SaveJobNameSlot(QueueSize - 1, NewJobName)
				SavePayloadSlot(QueueSize - 1, Payload)
			End If
		End If
	End If

	If WorkingFlag = False Then
		Log("Start processing...")
		ProcessNextRequest(Null)
	Else
		'Log("HTTPJob is already working, ignoring")
		Log("StackBufferUsage1 = ", StackBufferUsage)
	End If
	Return Not(isFullQueue)
End Sub

Private Sub SaveJobNameSlot(id As Byte, Value() As Byte) As Byte()
	'Log("SaveJobNameSlot = ", id, ": ", Value)
	Select id
		Case 0
			bc.ArrayCopy(Value, JobName0)
			Return JobName0
		Case 1
			bc.ArrayCopy(Value, JobName1)
			Return JobName1
		Case 2
			bc.ArrayCopy(Value, JobName2)
			Return JobName2
		Case 3
			bc.ArrayCopy(Value, JobName3)
			Return JobName3
		Case 4
			bc.ArrayCopy(Value, JobName4)
			Return JobName4
		Case 5
			bc.ArrayCopy(Value, JobName5)
			Return JobName5
		Case 6
			bc.ArrayCopy(Value, JobName6)
			Return JobName6
		Case 7
			bc.ArrayCopy(Value, JobName7)
			Return JobName7
	End Select
	Return Array As Byte()
End Sub

Private Sub GetJobNameSlot(id As Byte) As Byte()
	Select id
		Case 0
			Return JobName0
		Case 1
			Return JobName1
		Case 2
			Return JobName2
		Case 3
			Return JobName3
		Case 4
			Return JobName4
		Case 5
			Return JobName5
		Case 6
			Return JobName6
		Case 7
			Return JobName7
	End Select
	Return Array As Byte()
End Sub

Private Sub SavePayloadSlot(id As Byte, Value() As Byte) As Byte()
	'Log("SavePayloadSlot = ", id, ": ", Value)
	Select id
		Case 0
			bc.ArrayCopy(Value, Payload0)
			Return Payload0
		Case 1
			bc.ArrayCopy(Value, Payload1)
			Return Payload1
		Case 2
			bc.ArrayCopy(Value, Payload2)
			Return Payload2
		Case 3
			bc.ArrayCopy(Value, Payload3)
			Return Payload3
		Case 4
			bc.ArrayCopy(Value, Payload4)
			Return Payload4
		Case 5
			bc.ArrayCopy(Value, Payload5)
			Return Payload5
		Case 6
			bc.ArrayCopy(Value, Payload6)
			Return Payload6
		Case 7
			bc.ArrayCopy(Value, Payload7)
			Return Payload7
	End Select
	Return Array As Byte()
End Sub

Private Sub timOverload_Tick
	If QueueSize = QueueLimit Or HttpErrorsCounter > 0 Then
		Log("~~~~~Overload processing~~~~~...")
		ProcessNextRequest(Null)
	End If
End Sub

Private Sub ProcessNextRequest (PreviosJob As JobResult)
	Log("********PROCESSNextRequest***********************")
	If PreviosJob <> Null Then	'previous request result
		Log("----------------Prev JobName: ", PreviosJob.JobName, ", success = ", PreviosJob.Success)
		If PreviosJob.Success = False Or PreviosJob.Status = 0 Then
			Log("Prev Job ErrorMessage: ", PreviosJob.ErrorMessage)
			're-try
			Log("Re-trying HTTP-request: ", PreviosJob.JobName, "; QueueSlotIndex = ", QueueSlotIndex)
		Else
			'finished OK, reset finished JobName
			Dim CurType As Byte = RequestTypes(QueueSlotIndex)
			If CurType = 0 Then	'GET
				Log("Reset = ", SaveJobNameSlot(QueueSlotIndex, "_"))
				SavePayloadSlot(QueueSlotIndex, "")
			Else if CurType = 1 Then	'POST
				Log("Reset = ", SaveJobNameSlot(QueueSlotIndex, "_"))
				SavePayloadSlot(QueueSlotIndex, "")
			End If
			
			'...go to next one
			QueueSize = QueueSize - 1
			Log("Request in the queue is finished OK, DEcremented QueueSize = ", QueueSize)
		End If
	End If
	Log("StackBufferUsage2 = ", StackBufferUsage)
	
	If HttpErrorsCounter > 5 Then
		Log("HttpErrorsCounter = ", HttpErrorsCounter)
		Main.tim.Enabled = False
		Main.AppStart
		Return
	End If
	
	If QueueSize = 0 Then	'queue is out, stop working
		WorkingFlag = False
		QueueSlotIndex = -1
		timOverload.Enabled = False
		Log("----------------------------------------Queue is out, stop working--------")
		Return
	End If
	
	Dim i As Byte
	Dim Changed As Boolean
	For i = 0 To QueueLimit - 1
		If bc.ArrayCompare(GetJobNameSlot(i), "_".GetBytes) <> 0 Then
			QueueSlotIndex = i
			Changed = True
			Exit
		End If
	Next
	If Not(Changed) Then	'all finished
		QueueSlotIndex = -1
		Log("STOP")
		Return
	End If
		
	WorkingFlag = True	'start working
	Log("QueueSize2 = ", QueueSize)
	Log("QueueSlotIndex5 = ", QueueSlotIndex)
	Log("Starting job: ", GetJobNameSlot(QueueSlotIndex))
	Select QueueSlotIndex
		Case 0
			'Log("JobName0 = ", JobName0)
			'Log("Payload0 = ", Payload0)
			If JobName0 = "" Then
				Log("Empty JobName0")
				Return
			End If
			Initialize(JobName0)
			If RequestTypes(QueueSlotIndex) = 0 Then 'GET
				Download(Payload0)
			Else if RequestTypes(QueueSlotIndex) = 1 Then	'POST
				Post(POSTurl, Payload0)
			End If
		Case 1
			'Log("JobName1 = ", JobName1)
			'Log("Payload1 = ", Payload1)
			If JobName1 = "" Then
				Log("Empty JobName1")
				Return
			End If
			Initialize(JobName1)
			If RequestTypes(QueueSlotIndex) = 0 Then 'GET
				Download(Payload1)
			Else if RequestTypes(QueueSlotIndex) = 1 Then	'POST
				Post(POSTurl, Payload1)
			End If
		Case 2
			'Log("Payload2 = ", Payload2)
			If JobName2 = "" Then
				Log("Empty JobName2")
				Return
			End If
			Initialize(JobName2)
			If RequestTypes(QueueSlotIndex) = 0 Then 'GET
				Download(Payload2)
			Else if RequestTypes(QueueSlotIndex) = 1 Then	'POST
				Post(POSTurl, Payload2)
			End If
		Case 3
			'Log("Payload3 = ", Payload3)
			If JobName3 = "" Then
				Log("Empty JobName3")
				Return
			End If
			Initialize(JobName3)
			If RequestTypes(QueueSlotIndex) = 0 Then 'GET
				Download(Payload3)
			Else if RequestTypes(QueueSlotIndex) = 1 Then	'POST
				Post(POSTurl, Payload3)
			End If
		Case 4
			'Log("Payload4 = ", Payload4)
			If JobName4 = "" Then
				Log("Empty JobName4")
				Return
			End If
			Initialize(JobName4)
			If RequestTypes(QueueSlotIndex) = 0 Then 'GET
				Download(Payload4)
			Else if RequestTypes(QueueSlotIndex) = 1 Then	'POST
				Post(POSTurl, Payload4)
			End If
		Case 5
			'Log("Payload5 = ", Payload5)
			If JobName5 = "" Then
				Log("Empty JobName5")
				Return
			End If
			Initialize(JobName5)
			If RequestTypes(QueueSlotIndex) = 0 Then 'GET
				Download(Payload5)
			Else if RequestTypes(QueueSlotIndex) = 1 Then	'POST
				Post(POSTurl, Payload5)
			End If
		Case 6
			'Log("Payload6 = ", Payload6)
			If JobName6 = "" Then
				Log("Empty JobName6")
				Return
			End If
			Initialize(JobName6)
			If RequestTypes(QueueSlotIndex) = 0 Then 'GET
				Download(Payload6)
			Else if RequestTypes(QueueSlotIndex) = 1 Then	'POST
				Post(POSTurl, Payload6)
			End If
		Case 7
			'Log("Payload7 = ", Payload7)
			If JobName7 = "" Then
				Log("Empty JobName7")
				Return
			End If
			Initialize(JobName7)
			If RequestTypes(QueueSlotIndex) = 0 Then 'GET
				Download(Payload7)
			Else if RequestTypes(QueueSlotIndex) = 1 Then	'POST
				Post(POSTurl, Payload7)
			End If
	End Select
End Sub
