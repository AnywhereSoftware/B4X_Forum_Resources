B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'#Event: ResponseError(Message as string)
#Event: Response(response As QueryResult)
Sub Class_Globals
	Private xui As XUI
	Private thisIdInstance As String
	Private thisApiTokenInstance As String
	
	Public RequestTimeoutSeconds As Int = 30 'Default 30 seconds
	Private mCallback As Object
	Private mEventName As String
	Private utils As B4XGreenApiUtils
	Type QueryResult(Success As Boolean, StatusCode As String, GetString As String, ErrorMessage As String, ErrorResponse As String)
	
	Private folderApp As String
End Sub

'****************
'<link>Click here to start configurations|https://console.green-api.com/instanceList</link>
'****************
'<code>
'greenApi.Initialize(Me, "GreenApi","710XXX", "6807c0XXXXa1b2cfXXXXX4bf33973efd4XXX", xui.DefaultFolder)
'</code>
Public Sub Initialize(Callback As Object, EventName As String, myIdInstance As String, myApiTokenInstance As String, folder As String)
	mCallback = Callback
	mEventName = EventName
	thisIdInstance = myIdInstance
	thisApiTokenInstance = myApiTokenInstance
	
	folderApp = folder
	utils.Initialize
End Sub

'Gets or sets the IdInstance
Public Sub getIdInstance As String
	Return thisIdInstance
End Sub
Public Sub setIdInstance(myIdInstance As String)
	 thisIdInstance = myIdInstance
End Sub

'Gets or sets the ApiTokenInstance
Public Sub getApiTokenInstance As String
	Return thisApiTokenInstance
End Sub

Public Sub setApiTokenInstance(myApiTokenInstance As String)
	 thisApiTokenInstance = myApiTokenInstance
End Sub

Private Sub RaiseEventError (Error As String)
'	If mCallback = Null Then Return
'	Dim SubEvent As String = mEventName& "_ResponseError"
'	If xui.SubExists(mCallback, SubEvent, 1) = False Then Return
'	CallSubDelayed2(mCallback, SubEvent, Error)
	Log(Error)
End Sub

Private Sub RaiseEventResponse (j As HttpJob)
	If mCallback = Null Then Return
	Dim SubEvent As String = mEventName& "_Response"
	If xui.SubExists(mCallback, SubEvent, 1) = False Then Return
		
	Dim resp As QueryResult
	resp.Initialize
	resp.Success= j.Success
	
	If resp.Success Then
		resp.GetString = j.GetString
		resp.StatusCode = j.Response.StatusCode
	Else
		resp.ErrorMessage = j.ErrorMessage
		#if B4A or B4J 
		resp.ErrorResponse = j.Response.ErrorResponse
		#End If				
	End If'
	CallSubDelayed2(mCallback, SubEvent, resp)
End Sub

Private Sub IsValidJSON(sJson As String) As Map
	Dim Result As Map
	Result.Initialize
	Result.Put("IsValid", False)
	If sJson = "[]" Or sJson = "{}" Then Return Result
	Try
		sJson = sJson.Trim
		If sJson.StartsWith("[") And sJson.EndsWith("]") Then
			Result.Put("IsValid", True)
			Result.Put("Object", sJson.As(JSON).ToList)
		End If
		If sJson.StartsWith("{") And sJson.EndsWith("}") Then
			Result.Put("IsValid", True)
			Result.Put("Object", sJson.As(JSON).ToMap)
		End If
	Catch
		RaiseEventError(LastException.Message) 'display json error
	End Try
	Return Result
End Sub
#Region Account
'The method is aimed for getting QR code. To authorize your account,
' you have to scan a QR code from application WhatsApp Business on your phone. 
'You can also get a QR code and authorize your account in your profile.
Public Sub QR  As ResumableSub
	Dim URL As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/qr/${thisApiTokenInstance}"$
	Dim Result As Map
	
	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download(URL)
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	
	If job.Success Then
'		'Result = job.GetString.As(JSON).ToMap
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Result = parseJson.Get("Object")
		End If
'	Else
'		RaiseEventError(job.ErrorMessage)
	End If
	job.Release
	Return Result
End Sub

'The method is aimed to get information about the WhatsApp account
Public Sub GetWaSettings As ResumableSub
	Dim URL As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/getWaSettings/${thisApiTokenInstance}"$
	Dim Result As Map
	
	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download(URL)
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)

	If job.Success  Then
		'Result = job.GetString.As(JSON).ToMap
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Result = parseJson.Get("Object")
		End If
'	Else
'		RaiseEventError(job.ErrorMessage)
	End If
	job.Release
	Return Result
End Sub

'The method is aimed for getting the account state.
Public Sub GetStateInstance As ResumableSub
	Dim URL As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/getStateInstance/${thisApiTokenInstance}"$
	Dim Result As String
	
	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download(URL)
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then
		'Dim m As Map = job.GetString.As(JSON).ToMap
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Dim m As Map = parseJson.Get("Object")
			Result = m.Get("stateInstance")
		End If
'	Else
'		RaiseEventError(job.ErrorMessage)
	End If
	job.Release
	Return Result
End Sub

'The method is aimed for logging out an account.
Public Sub Logout As ResumableSub
	Dim URL As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/logout/${thisApiTokenInstance}"$
	
	Dim Result As Boolean
	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download(URL)
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then
		'Dim m As Map = job.GetString.As(JSON).ToMap
		'Result = m.Get("isLogout")

		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Dim m As Map = parseJson.Get("Object")
			Result = m.Get("isLogout")
		End If
'	Else
'		RaiseEventError(job.ErrorMessage)
	End If
	job.Release
	Return Result
End Sub

#End Region
#Region Sending
'The method is aimed for sending a text message to a personal or a group chat. The message will be added to the send queue.
'<b>Parameter	Mandatory	Description</b>
'chatId		Yes		Chat Id
'message		Yes		Message text. Emoji 😃 characters supported
'quotedMessageId	No		Quoted message ID. If present, the message will be sent quoting the specified chat message
'linkPreview	No		The parameter includes displaying a preview And a description of the link. Enabled by default. Accepts values: True/False
'Return idMessage (String)
Public Sub SendMessage(chatId As String, message As String, quotedMessageId As String, linkPreview As Boolean) As ResumableSub
	Dim URL, RequestBody As String
	
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/sendMessage/${thisApiTokenInstance}"$
	
	Dim Parameters As Map = CreateMap ("chatId": chatId, "message": message)
	If quotedMessageId <> "" Then Parameters.Put("quotedMessageId", quotedMessageId)
	If linkPreview Then Parameters.Put("linkPreview", linkPreview)
	RequestBody = Parameters.As(JSON).ToCompactString
	
	Dim idMessage As String
	Dim job As HttpJob
	job.Initialize("", Me)
	job.PostString(URL, RequestBody)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then
'		Dim r As Map = job.GetString.As(JSON).ToMap
'		idMessage = r.Get("idMessage")
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Dim m As Map = parseJson.Get("Object")
			idMessage = m.Get("idMessage")
		End If
'	Else
'		RaiseEvent(
	End If
	job.Release
	Return idMessage
End Sub

'The method is aimed for sending a file uploaded by form (form-data). The message will be added to the send queue, in the response you will receive a link to the downloaded file.
'<b>Parameter	Mandatory	Description </b>
'chatId		Yes		Chat Id
'Dir		Yes		Folder File
'FileName	Yes		File name.
'caption		No		Caption added To video, images.
'quotedMessageId	No		Quoted message Id. If present, the message will be sent quoting the specified chat message.
'fileNameChat	No		File name displayed in chat, must contain file extension. 
'				(Example: file1.jpg, file2.mp3)
Public Sub SendFileByUpload(chatId As String, caption As String, Dir As String, _
	 FileName As String, fileNameChat As String,quotedMessageId As String) As ResumableSub
	Dim URL As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/sendFileByUpload/${thisApiTokenInstance}"$
	
	Dim Parameters As Map = CreateMap ("chatId": chatId)
	If quotedMessageId <> "" Then Parameters.Put("quotedMessageId", quotedMessageId)
	If caption <> "" Then Parameters.Put("caption", caption)
	If FileName <> "" Then Parameters.Put("fileName", fileNameChat)
	Dim fd As MultipartFileData
	fd.Initialize
	fd.KeyName = "file"
	fd.Dir = Dir
	fd.FileName = FileName
	
	Dim Result As Map
	Dim job As HttpJob
	Try
		job.Initialize("", Me)
		job.PostMultipart(URL, Parameters, Array(fd))
		job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
		Wait For (job) JobDone(job As HttpJob)
		RaiseEventResponse(job)
		If job.Success  Then
			'Result = job.GetString.As(JSON).ToMap
			Dim parseJson  As Map = IsValidJSON(job.GetString)
			If	parseJson.Get("IsValid") Then
				Result = parseJson.Get("Object")
			End If
'		Else
'			RaiseEventError(job.ErrorMessage)
		End If
		
	Catch
		RaiseEventError(LastException.Message)
	End Try
	job.Release
	Return Result
End Sub

'The method is intended for forwarding messages to a personal or group chat. The forwarded messages will be added to the send queue
'<b>Parameter	Mandatory	Description</b>
'chatId		Yes		Chat Id, where the message is forwarded
'chatIdFrom	Yes		Chat Id, from which the message is being forwarded
'messages	Yes		Collection of IDs of forwarded messages
Public Sub ForwardMessages(chatId As String, chatIdFrom As String, messages As List) As ResumableSub
	Dim URL, RequestBody As String	
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/forwardMessages/${thisApiTokenInstance}"$
	
	Dim Parameters As Map = CreateMap ("chatId": chatId, "chatIdFrom":chatIdFrom , "messages": messages)
	RequestBody = Parameters.As(JSON).ToCompactString
	
	Dim Result As Map
	Dim job As HttpJob
	job.Initialize("", Me)
	job.PostString(URL, RequestBody)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then		
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Result = parseJson.Get("Object")
		End If
'	Else
'		RaiseEvent(
	End If
	job.Release
	Return Result
End Sub

#End Region
#Region Receiving
'The method is aimed for downloading incoming and outgoing files. Links to incoming files are transmitted
' in Incoming messages, and you can also get them using LastIncomingMessages method
'<b>Parameter	Mandatory	Description</b>
'chatId		Yes		Chat id, For example 7900023125@c.us
'idMessage	Yes		Message Id transmitted in Incoming messages Or when sending files
' 				using SendFileByUrl, SendFileByUpload methods. This parameter Is 
'				transmitted As the final part of the URL request
Public Sub DownloadFile(chatId As String, idMessage As String) As ResumableSub
	Dim URL, RequestBody As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/downloadFile/${thisApiTokenInstance}"$
	
	Dim Parameters As Map = CreateMap ("chatId": chatId, "idMessage": idMessage)
	RequestBody = Parameters.As(JSON).ToCompactString
	Dim payload() As Byte = RequestBody.GetBytes("UTF8")

	Dim Result As String
	Dim job As HttpJob
	job.Initialize("", Me)
	job.PostBytes(URL, payload)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Dim m As Map = parseJson.Get("Object")
			Result = m.Get("downloadUrl")		
		End If
'		Dim Result As Map = job.GetString.As(JSON).ToMap
	End If
	job.Release
	Return Result
End Sub

#Region Queue
'The method is aimed for getting a list of messages in the queue to be sent. 
Public Sub ShowMessagesQueue As ResumableSub
	Dim URL As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/showMessagesQueue/${thisApiTokenInstance}"$
	Dim Result As List
	
	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download(URL)
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then		
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Result = parseJson.Get("Object")
		End If
'	Else
'		RaiseEventError(job.ErrorMessage)
	End If
	job.Release
	Return Result
End Sub

#End Region

#Region Groups
'The method is aimed for creating a group chat.
'<b>Parameter	Mandatory	Description</b>
'groupName	Yes		New group chat name
'chatIds		Yes		Collection of group participants Ids
Public Sub CreateGroup(groupName As String, chatIds As List) As ResumableSub
	Dim URL, RequestBody As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/createGroup/${thisApiTokenInstance}"$
	 
	Dim Parameters As Map = CreateMap ("groupName": groupName, "chatIds" : chatIds)
	RequestBody = Parameters.As(JSON).ToCompactString
	
	Dim result  As Map
	Dim job As HttpJob
	job.Initialize("", Me)
	job.PostString(URL, RequestBody)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then
'		Dim result As Map = job.GetString.As(JSON).ToMap
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			result = parseJson.Get("Object")			
		End If
'	Else
'		RaiseEventError(job.ErrorMessage)
	End If
	job.Release
	Return result
End Sub

#End Region

#Region Services
'The method checks WhatsApp account availability on a phone number.
'<b>Parameter	Mandatory	Description</b>
'phoneNumber	Yes		Recipient's phone number in international format: 11 or 12 digits; Example: 11001234567 or 380123456789
'Return Boolean
Public Sub CheckWhatsApp(phoneNumber As String) As ResumableSub
	Dim URL, RequestBody As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/checkWhatsapp/${thisApiTokenInstance}"$
	
	Dim Parameters As Map = CreateMap ("phoneNumber": phoneNumber)
	RequestBody = Parameters.As(JSON).ToCompactString
	Dim payload() As Byte = RequestBody.GetBytes("UTF8")

	Dim Result As Boolean = False
	Dim job As HttpJob
	job.Initialize("", Me)
	job.PostBytes(URL, payload)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then
'		Dim m As Map = job.GetString.As(JSON).ToMap
'		Result = m.Get("existsWhatsapp")
		
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Dim m As Map = parseJson.Get("Object")
			Result = m.Get("existsWhatsapp")
		End If
'	Else
'		RaiseEventError(job.ErrorMessage)
	End If
	job.Release
	Return Result
End Sub

'The method returns a user or a group chat avatar.
'<b>Parameter	Mandatory	Description</b>
'chatId		Yes		User Or group chat Id
Public Sub GetAvatar(chatId As String) As ResumableSub
	Dim URL, RequestBody As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/getAvatar/${thisApiTokenInstance}"$
	
	Dim Parameters As Map = CreateMap ("chatId": chatId)
	RequestBody = Parameters.As(JSON).ToCompactString

	Dim Result As Map
	Dim job As HttpJob
	job.Initialize("", Me)
	job.PostString(URL, RequestBody)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then
'		Result = job.GetString.As(JSON).ToMap
		
		Dim parseJson  As Map = IsValidJSON(job.GetString)
		If	parseJson.Get("IsValid") Then
			Result = parseJson.Get("Object")			
		End If
'	Else
'		RaiseEventError(job.ErrorMessage)
	End If
'	Log(job.ErrorMessage)
	job.Release
	Return Result
End Sub

'The method archives a chat. One can archive chats that have at least one incoming message.
'<b>Parameter	Mandatory	Description</b>
'chatId		Yes		User or group chat Id
Public Sub ArchiveChat(chatId As String) As ResumableSub
	Dim URL, RequestBody As String
	URL = $"https://api.green-api.com/waInstance${thisIdInstance}/archiveChat/${thisApiTokenInstance}"$
	
	Dim Parameters As Map = CreateMap ("chatId": chatId)
	RequestBody = Parameters.As(JSON).ToCompactString

	Dim Result As Boolean = False
	Dim job As HttpJob
	job.Initialize("", Me)
	job.PostString(URL, RequestBody)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds
	
	Wait For (job) JobDone(job As HttpJob)
	RaiseEventResponse(job)
	If job.Success  Then
		Result = (job.Response.StatusCode = 200)
'		Dim parseJson  As Map = IsValidJSON(job.GetString)
'		If	parseJson.Get("IsValid") Then
'			Dim m As Map = parseJson.Get("Object")
'			Result = m.Get("chatId")
'		End If
	End If
	job.Release
	Return Result
End Sub

#End Region