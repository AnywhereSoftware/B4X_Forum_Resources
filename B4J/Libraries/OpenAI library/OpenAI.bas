B4A=true
B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#Event: Response(Response as string)
#Event: ImageResponse(ImageStream As InputStream)
#Event: TTSResponse(AudioStream As InputStream)
#Event: Error(message as string)

Sub Class_Globals
	LogColor("Sub OpAI.Class_Globals started", 0xFF210099)
	Private apiKey As String
	Private chatList As List
	Private mTarget As Object
	Private mEventname As String
	Private xui As XUI
	LogColor("Sub OpAI.Class_Globals finished", 0xFF210099)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Target As Object, EventName As String, key As String)
	LogColor("Sub OpAI.Initialize started", 0xFF210099)
	apiKey = key
	mTarget = Target
	mEventname = EventName
	chatList.Initialize
	LogColor("Sub OpAI.Initialize finished", 0xFF210099)
End Sub

'CHAT

public Sub SystemMessage(Model As String, promt As String)
	LogColor("Sub OpAI.SystemMessage started", 0xFF210099)
	Dim sanitizedPrompt As String = SanitizeInput(promt)
	Dim textChunks As List = SplitText(sanitizedPrompt)
    
	For Each chunk As String In textChunks
		chatList.Add(CreateMap("role": "system", "content": chunk))
	Next
    
	If chatList.Size > 0 Then
		Dim j As HttpJob
		j.Initialize("GetChatGPTResponse", Me)
		Dim JSONGenerator As JSONGenerator
		JSONGenerator.Initialize2(chatList)
		Log("JSON Chatlist: " & JSONGenerator.ToPrettyString(4))
		Dim chat_string As String
		chat_string = $"{"model":"${Model}","messages":${JSONGenerator.ToString}}"$
		j.PostString("https://api.openai.com/v1/chat/completions", chat_string)
		j.GetRequest.SetContentType("application/json")
		j.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
		j.GetRequest.SetHeader("OpenAI-Organization", "")
    
		' Log the request
		LogHttpRequest("GetChatGPTResponse", chat_string)
    
		Log("OpenAI: Generate Chat Response...")
	End If
	LogColor("Sub OpAI.SystemMessage finished", 0xFF210099)
End Sub

Public Sub ResetChat
	LogColor("Sub OpAI.ResetChat started", 0xFF210099)
	chatList.Clear
	LogColor("Sub OpAI.ResetChat finished", 0xFF210099)
End Sub

Public Sub ChatMessage(Model As String, promt As String)
	LogColor("Sub OpAI.ChatMessage started", 0xFF210099)
	Dim sanitizedPrompt As String = SanitizeInput(promt)
	Dim textChunks As List = SplitText(sanitizedPrompt)
    
	For Each chunk As String In textChunks
		chatList.Add(CreateMap("role": "user", "content": chunk))
	Next
    
	If chatList.Size > 0 Then
		Dim j As HttpJob
		j.Initialize("GetChatGPTResponse", Me)
		Dim JSONGenerator As JSONGenerator
		JSONGenerator.Initialize2(chatList)
		Log("JSON Chatlist: " & JSONGenerator.ToPrettyString(4))
		Dim chat_string As String
		chat_string = $"{"model":"${Model}","messages":${JSONGenerator.ToString}}"$
		j.PostString("https://api.openai.com/v1/chat/completions", chat_string)
		j.GetRequest.SetContentType("application/json")
		j.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
		j.GetRequest.SetHeader("OpenAI-Organization", "")
    
		' Log the request
		LogHttpRequest("GetChatGPTResponse", chat_string)
    
		Log("OpenAI: Generate Chat Response...")
	End If
	LogColor("Sub OpAI.ChatMessage finished", 0xFF210099)
End Sub

'TTS

Public Sub TextToSpeech(Model As String, Voice As String, Prompt As String, Speed As Float)
	LogColor("Sub OpAI.TextToSpeech started", 0xFF210099)
	Dim sanitizedPrompt As String = SanitizeInput(Prompt)
	Dim textChunks As List = SplitText(sanitizedPrompt)
    
	If textChunks.Size = 0 Then
		Log("Error: Empty prompt provided for TTS")
		If xui.SubExists(mTarget, mEventname & "_Error", 1) Then
			HandleError("Empty prompt provided for TTS")
		End If
		Return
	End If

	Dim config As Map = CreateMap("model": Model, "voice": Voice, "speed": Speed, "apiKey": apiKey)
	Dim rpm As Int = 100 ' Maximum requests per minute
	Dim interval As Int = 60000 / rpm ' Time between requests in milliseconds
    
	For i = 0 To textChunks.Size - 1
		Dim chunk As String = textChunks.Get(i)
        
		If i > 0 And i Mod rpm = 0 Then
			Sleep(60000) ' Wait for a minute after 100 requests
		Else If i > 0 Then
			Sleep(interval) ' Wait the required interval before the next request
		End If
        
		Dim j As HttpJob
		j.Initialize("ttsJob", Me)
		Dim request As String = $"{"model":"${config.Get("model")}","input":"${chunk}","voice":"${config.Get("voice")}","speed":${config.Get("speed")}}"$
		j.PostString("https://api.openai.com/v1/audio/speech", request)
		j.GetRequest.SetContentType("application/json")
		j.GetRequest.SetHeader("Authorization", "Bearer " & config.Get("apiKey"))
		
		' Log the request
		LogHttpRequest("ttsJob", request)
	Next
	LogColor("Sub OpAI.TextToSpeech finished", 0xFF210099)
End Sub

'IMAGE

Public Sub generateImage(Prompt As String, ImageModel As String, N As Int, Size As String, Quality As String, Style As String, ResponseFormat As String, User As String)
	LogColor("Sub OpAI.generateImage started", 0xFF210099)

	' Validate prompt
	Dim sanitizedPrompt As String = SanitizeInput(Prompt)
	Dim textChunks As List = SplitText(sanitizedPrompt)

	If textChunks.Size = 0 Then
		Log("Error: Empty prompt provided for image generation")
		Return
	End If

	' Combine all chunks into a single prompt, separated by spaces
	Dim fullPrompt As StringBuilder
	fullPrompt.Initialize
	For Each chunk As String In textChunks
		If fullPrompt.Length > 0 Then
			fullPrompt.Append(" ")
		End If
		fullPrompt.Append(chunk)
	Next

	' Truncate if exceeds maximum length
	Dim maxPromptLength As Int = IIf(ImageModel = "dall-e-3", 4000, 1000)
	If fullPrompt.Length > maxPromptLength Then
		fullPrompt.Remove(maxPromptLength, fullPrompt.Length)
		xui.MsgboxAsync("Warning: Prompt truncated to " & maxPromptLength & " characters for image generation", "Prompt Truncated")
	End If

	Dim job As HttpJob
	job.Initialize("generateImage", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	
	' Construct the request parameters as a single JSON string
	Dim parameters As String
	parameters = ""

	' Add the model parameter
	If ImageModel <> "" Then
		parameters = parameters & Quote1("model") & ":" & Quote1(ImageModel) & ","
	End If
	
	' Add the prompt parameter
	parameters = parameters & Quote1("prompt") & ":" & Quote1(fullPrompt.ToString) & ","
	
	' Add the number of images if it's valid
	If N > 0 Then
		parameters = parameters & Quote1("n") & ":" & N & ","
	End If
	
	' Add size parameter if provided
	If Size <> "" Then
		parameters = parameters & Quote1("size") & ":" & Quote1(Size) & ","
	End If
	
	' Add quality parameter if provided
	If Quality <> "" Then
		parameters = parameters & Quote1("quality") & ":" & Quote1(Quality) & ","
	End If
	
	' Add style parameter if provided
	If Style <> "" Then
		parameters = parameters & Quote1("style") & ":" & Quote1(Style) & ","
	End If
	
	' Add response format parameter if provided
	If ResponseFormat <> "" Then
		parameters = parameters & Quote1("response_format") & ":" & Quote1(ResponseFormat) & ","
	End If
	
	' Add user parameter if provided
	If User <> "" Then
		parameters = parameters & Quote1("user") & ":" & Quote1(User) ' No comma needed because this is the last field
	End If
	
	' Trim the last comma if needed and complete the JSON request
	If parameters.EndsWith(",") Then
		parameters = parameters.Substring2(0, parameters.Length - 1) ' Remove last comma
	End If
    
	' Complete the JSON request wrapping parameters with curly braces
	Dim request As String = "{" & parameters & "}"
    
	' Send the request to OpenAI
	job.PostString("https://api.openai.com/v1/images/generations", request)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.GetRequest.SetContentType("application/json")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Organization", "")
    
	' Log the request
	LogHttpRequest("generateImage", request)
	Log("OpenAI: Generate Image.")
	LogColor("Sub OpAI.generateImage finished", 0xFF210099)
End Sub

' Helper function to add quotes around string values
Private Sub Quote1(value As String) As String
	LogColor("Sub OpAI.Quote1 started", 0xFF210099)
    Return """" & value & """"
	LogColor("Sub OpAI.Quote1 finished", 0xFF210099)
End Sub

'UTILITIES FOR CHAT,TTS,IMAGE

Private Sub SanitizeInput(input As String) As String
	LogColor("Sub OpAI.SanitizeInput started", 0xFF210099)
	LogColor("Sub OpAI.SanitizeInput finished", 0xFF210099)
	Return input.Replace(CRLF, " ").Replace(Chr(34), "'")
End Sub

Private Sub SplitText(text As String) As List
	LogColor("Sub OpAI.SplitText started", 0xFF210099)
	Dim chunks As List
	chunks.Initialize
    
	Dim maxChunkSize As Int = 4096
	Dim delimiters As List
	delimiters.Initialize
	delimiters.AddAll(Array As String(". ", "? ", "! ", CRLF))
    
	Do While text.Length > 0
		If text.Length <= maxChunkSize Then
			chunks.Add(text)
			Exit
		End If
        
		Dim end1 As Int = maxChunkSize
		For Each delimiter As String In delimiters
			Dim pos As Int = text.SubString2(0, maxChunkSize).LastIndexOf(delimiter)
			If pos > -1 Then
				end1 = pos + delimiter.Length
				Exit
			End If
		Next
        
		If end1 = maxChunkSize Then
			' If no delimiter was found, force a split at maxChunkSize
			end1 = maxChunkSize
		End If
        
		chunks.Add(text.SubString2(0, end1))
		text = text.SubString(end1)
	Loop
	LogColor("Sub OpAI.SplitText finished", 0xFF210099)
	Return chunks
End Sub

'OPENAI FILE LIST TABLE

Public Sub RetrieveFile(fileId As String, FileName As String)
	LogColor("Sub OpAI.RetrieveFile started", 0xFF210099)
	
	Dim url As String = "https://api.openai.com/v1/files/" & fileId
	Dim job As HttpJob
	job.Initialize("retrieveFileJob", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.Download(url)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	
	LogHttpRequest("retrieveFileJob", url) ' Log the request.
	LogColor("Sub OpAI.RetrieveFile finished", 0xFF210099)
End Sub

Sub RetrieveFileContent(fileId As String, FileName As String)
	LogColor("Sub OpAI.RetrieveFileContent started", 0xFF210099)
	Dim url As String = "https://api.openai.com/v1/files/" & fileId & "/content"
	Dim job As HttpJob
	job.Initialize("retrieveFileContent", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.Tag = FileName
	
	job.Download(url)

	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)

	LogColor("Sub OpAI.RetrieveFileContent finished", 0xFF210099)
End Sub

Public Sub ListFiles
	LogColor("Sub OpAI.ListFiles started", 0xFF210099)
	Dim url As String = "https://api.openai.com/v1/files"
	Dim job As HttpJob
	job.Initialize("listFilesJob", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.Download(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	job.GetRequest.SetHeader("limit", "100")

	LogHttpRequest("listFilesJob", url) ' Log the request.
	LogColor("Sub OpAI.ListFiles finished", 0xFF210099)
End Sub

Public Sub DeleteFile(fileId As String)
	LogColor("Sub OpAI.DeleteFile started", 0xFF210099)
	Log("Here at DeleteFile")
	Dim url As String = "https://api.openai.com/v1/files"
    Dim job As HttpJob
    job.Initialize("deleteFileJob", Me)
    job.Tag = fileId ' Store the fileId in the job's tag
	job.Delete(url & "/" & fileId)
    job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogHttpRequest("deleteFileJob", url & "/" & fileId) ' Log the request.
	LogColor("Sub OpAI.DeleteFile finished", 0xFF210099)
End Sub

'ASSISTANTS

Public Sub CreateAssistant(assistantName As String, assistantInstructions As String, assistantModel As String, assistantTools As List)
	LogColor("Sub OpAI.CreateAssistant started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("CreateAssistant", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	' Create a map for the JSON body
	Dim jsonMap As Map
	jsonMap.Initialize
	jsonMap.Put("instructions", assistantInstructions)
	jsonMap.Put("name", assistantName)
	jsonMap.Put("tools", assistantTools) ' Ensure this is a list of maps
	jsonMap.Put("model", assistantModel)
    
	' Convert the map to a JSON string
	Dim json As JSONGenerator
	json.Initialize(jsonMap)
	Dim jsonString As String = json.ToString
    
	' Post the JSON string directly
	job.PostString("https://api.openai.com/v1/assistants", jsonString)
    
	' Set headers
	job.GetRequest.SetContentType("application/json")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.CreateAssistant finished", 0xFF210099)
End Sub

Public Sub ListAssistants(limit As String, order As String, after As String, before As String)
    LogColor("Sub OpAI.ListAssistants started", 0xFF210099)
    
    Dim job As HttpJob
    job.Initialize("ListAssistants", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
    ' Start with the base URL
    Dim url As String = "https://api.openai.com/v1/assistants"
    
    Dim parameters As String = ""
    
    ' Add the limit parameter if it's not blank
    If limit <> "" Then
        parameters = parameters & $"limit=${limit}"$
    End If
    
    ' Add the order parameter if it's not blank
    If order <> "" Then
        If parameters <> "" Then parameters = parameters & "&"
        parameters = parameters & $"order=${order}"$
    End If
    
    ' Add the after parameter if it's not blank
    If after <> "" Then
        If parameters <> "" Then parameters = parameters & "&"
        parameters = parameters & $"after=${after}"$
    End If
    
    ' Add the before parameter if it's not blank
    If before <> "" Then
        If parameters <> "" Then parameters = parameters & "&"
        parameters = parameters & $"before=${before}"$
    End If
    
    ' If parameters are present, append them to the URL
    If parameters <> "" Then
        url = url & "?" & parameters
    End If

    job.Download(url)
    job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
    job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
    ' Log the request
    LogHttpRequest("ListAssistants", url)
    LogColor("Sub OpAI.ListAssistants finished", 0xFF210099)
End Sub

Public Sub DeleteAssistant(AssistantID As String)
	LogColor("Sub OpAI.DeleteAssistant started", 0xFF210099)
	Private Job1 As HttpJob
	' Initialize the HTTP job
	Job1.Initialize("DeleteAssistant", Me)
    
	' Set the DELETE request URL
	Dim url As String = $"https://api.openai.com/v1/assistants/${AssistantID}"$
	Job1.Delete(url) ' Send a DELETE request to the specified URL

	' Set the necessary headers
	Job1.GetRequest.SetHeader("Content-Type", "application/json")
	Job1.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	Job1.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.DeleteAssistant finished", 0xFF210099)
End Sub

Public Sub EditAssistant(AssistantID As String)
	LogColor("Sub OpAI.EditAssistant started", 0xFF210099)
	'*** Add code for this.
	LogColor("Sub OpAI.EditAssistant finished", 0xFF210099)
End Sub

Public Sub RetrieveAssistant(AssistantID As String) 'This is really activating an assistant that already exists, not retrieving it.
	LogColor("Sub OpAI.RetrieveAssistant started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("RetrieveAssistant", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	'https://api.openai.com/v1/assistants/{assistant_id}
	job.PostString("https://api.openai.com/v1/assistants/" & AssistantID,"")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.RetrieveAssistant finished", 0xFF210099)
End Sub

Public Sub AddVectorStoreToAssistant(assistantId As String, vectorStoreId As String)
	
	LogColor("Sub OpAI.AddVectorStoreToAssistant started", 0xFF210099)
    
	Dim job As HttpJob
	job.Initialize("UpdateAssistantWithVectorStore", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	' Create a map for the JSON body
	Dim jsonMap As Map
	jsonMap.Initialize
	
	Dim toolResources As Map
	toolResources.Initialize
	
	Dim fileSearch As Map
	fileSearch.Initialize
	
	Dim vectorStoreIds As List
	vectorStoreIds.Initialize
    
	' Add the vectorStoreId to the list
	vectorStoreIds.Add(vectorStoreId)
    
	' Build the nested maps
	fileSearch.Put("vector_store_ids", vectorStoreIds)
	toolResources.Put("file_search", fileSearch)
	jsonMap.Put("tool_resources", toolResources)
    
	' Convert the map to a JSON string
	Dim json As JSONGenerator
	json.Initialize(jsonMap)
	Dim request As String = json.ToString
    
	' Post the JSON string to the URL
	job.PostString("https://api.openai.com/v1/assistants/" & assistantId, request)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("UpdateAssistantWithVectorStore", request)
	LogColor("Sub OpAI.AddVectorStoreToAssistant finished", 0xFF210099)
End Sub

'Runs
Public Sub CreateRun(assistantId As String, threadID As String)
    LogColor("Sub OpAI.CreateRun started", 0xFF210099)
    
    Dim job As HttpJob
    job.Initialize("CreateRun", Me) 'Object response is "thread.run"
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
    ' Create a map for the JSON body
    Dim jsonMap As Map
    jsonMap.Initialize
    jsonMap.Put("assistant_id", assistantId) ' Set the assistant ID
    
    ' Convert the map to a JSON string
    Dim json As JSONGenerator
    json.Initialize(jsonMap)
    Dim parameters As String = json.ToString
    
    ' Post the JSON string to the URL
    job.PostString("https://api.openai.com/v1/threads/" & threadID & "/runs", parameters)
    job.GetRequest.SetContentType("application/json")
    job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
    job.GetRequest.SetHeader("OpenAI-Organization", "")
    job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
    LogColor("Sub OpAI.CreateRun finished", 0xFF210099)
End Sub

Public Sub ListRuns(ThreadID As String, limit As String, after As String, before As String, order As String)
	LogColor("Sub OpAI.ListRuns started", 0xFF210099)
    
	' Start with the base URL
	Dim baseUrl As String = $"https://api.openai.com/v1/threads/${ThreadID}/runs"$

	Dim url As String = baseUrl
	Dim parameters As String = ""

	' Add the before parameter if it's not blank
	If before <> "" Then
		If parameters <> "" Then parameters = parameters & "&" ' Add '&' if parameters are already present
		parameters = parameters & $"before=${before}"$
	End If
    
	' Add the after parameter if it's not blank
	If after <> "" Then
		If parameters <> "" Then parameters = parameters & "&" ' Add '&' if parameters are already present
		parameters = parameters & $"after=${after}"$
	End If
    
	' Add the limit parameter if it's not blank
	If limit <> "" Then
		If parameters <> "" Then parameters = parameters & "&" ' Add '&' if parameters are already present
		parameters = parameters & $"limit=${limit}"$
	End If

	' Add the order parameter if it's not blank
	If order <> "" Then
		If parameters <> "" Then parameters = parameters & "&" ' Add '&' if parameters are already present
		parameters = parameters & $"order=${order}"$  ' Assuming order is the string parameter you want to add
	End If

	' Check if we have any parameters to append
	If parameters <> "" Then
		url = url & "?" & parameters ' Append parameters to the URL
	End If

	Dim job As HttpJob
	job.Initialize("ListRuns", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.Download(url)  ' Download the constructed URL
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("ListRuns", url)
	LogColor("Sub OpAI.ListRuns finished", 0xFF210099)
End Sub

Public Sub RunAssistant(assistantId As String, threadId As String)
	LogColor("Sub OpAI.RunAssistant started", 0xFF210099)
    
	Dim job As HttpJob
	job.Initialize("RunAssistant", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	' Create a map for the JSON body
	Dim jsonMap As Map
	jsonMap.Initialize
	jsonMap.Put("assistant_id", assistantId) ' Set the assistant ID
    
	' Convert the map to a JSON string
	Dim json As JSONGenerator
	json.Initialize(jsonMap)
	Dim request As String = json.ToString
    
	' Post the JSON string to the URL
	job.PostString($"https://api.openai.com/v1/threads/${threadId}/runs"$, request)
	job.GetRequest.SetContentType("application/json")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("RunAssistant", request)
    
	LogColor("Sub OpAI.RunAssistant finished", 0xFF210099)
End Sub

Public Sub CheckRunStatus(threadId As String, runId As String)
	LogColor("Sub OpAI.CheckRunStatus started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("CheckRunStatus", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	Dim url As String = $"https://api.openai.com/v1/threads/${threadId}/runs/${runId}"$
	job.Download(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("CheckRunStatus", url)
	LogColor("Sub OpAI.CheckRunStatus finished", 0xFF210099)
End Sub

Public Sub RetrieveRun(threadId As String, runId As String)
	LogColor("Sub OpAI.RetrieveRun started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("RetrieveRun", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.Download("https://api.openai.com/v1/threads/" & threadId & "/runs/" & runId)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("CheckRunStatus", "https://api.openai.com/v1/threads/" & threadId & "/runs/" & runId)
	LogColor("Sub OpAI.RetrieveRun finished", 0xFF210099)
End Sub

Public Sub CancelRun(threadId As String, runId As String)
	LogColor("Sub OpAI.CancelRun started", 0xFF210099)
    
	Dim job As HttpJob
	job.Initialize("CancelRun", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.

	' Construct the URL for the cancel operation
	Dim url As String = $"https://api.openai.com/v1/threads/${threadId}/runs/${runId}/cancel"$

	job.PostString(url, "")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	job.GetRequest.SetHeader("Content-Type", "application/json")

	' Log the request
	LogHttpRequest("CancelRun", url)

	LogColor("Sub OpAI.CancelRun finished", 0xFF210099)
End Sub

'Run Steps

Public Sub ListRunSteps(ThreadID As String, RunID As String, limit As String, order As String, after As String, before As String, include As String)
	LogColor("Sub OpAI.ListRunSteps started", 0xFF210099)
    
    Dim job As HttpJob
    job.Initialize("ListRunSteps", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
    ' Start with the base URL
	Dim url As String = "https://api.openai.com/v1/threads/" & ThreadID & "/runs/" & RunID & "/steps"
    
    Dim parameters As String = ""
    
    ' Add the limit parameter if it's not blank
    If limit <> "" Then
        parameters = parameters & $"limit=${limit}"$
    End If
    
    ' Add the order parameter if it's not blank
    If order <> "" Then
        If parameters <> "" Then parameters = parameters & "&"
        parameters = parameters & $"order=${order}"$
    End If
    
    ' Add the after parameter if it's not blank
    If after <> "" Then
        If parameters <> "" Then parameters = parameters & "&"
        parameters = parameters & $"after=${after}"$
    End If
    
    ' Add the before parameter if it's not blank
    If before <> "" Then
        If parameters <> "" Then parameters = parameters & "&"
        parameters = parameters & $"before=${before}"$
    End If
    
	' Add the include parameter if it's not blank
	If order <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"include=${include}"$
	End If
	
    ' If parameters are present, append them to the URL
    If parameters <> "" Then
        url = url & "?" & parameters
    End If

    job.Download(url)
    job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
    job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
    ' Log the request
    LogHttpRequest("ListAssistants", url)
	LogColor("Sub OpAI.ListRunSteps finished", 0xFF210099)
End Sub

'Threads
Public Sub CreateThread()
	LogColor("Sub OpAI.CreateThread started", 0xFF210099)
	Dim Job As HttpJob
	Job.Initialize("CreateThread", Me)
	Job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	Job.PostString("https://api.openai.com/v1/threads", "{}")
	Job.GetRequest.SetContentType("application/json")
	Job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	Job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.CreateThread finished", 0xFF210099)
End Sub

Public Sub ListThreads  'Can't list Threads due to OpenAI not supporting it. Spreadsheet is used.
	LogColor("Sub OpAI.ListThreads started", 0xFF210099)
	'Listing threads is not allowed by the API at this time.  See my text file about this in the B4J folder.
	'So, this commented code can't be used until this is fixed and an endpoint in the API is established for it.
'	Dim job As HttpJob
'	job.Initialize("ListThreads", Me)
'	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
'	job.Download("https://api.openai.com/v1/threads")
'	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
'	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
'	LogHttpRequest("ListThreads", "https://api.openai.com/v1/threads") ' Log the request.
	LogColor("Sub OpAI.ListThreads finished", 0xFF210099)
End Sub

Public Sub AddMessageToThread(threadId As String, role As String, content As String)
	LogColor("Sub OpAI.AddMessageToThread started", 0xFF210099)

	' Initialize HttpJob
	Dim Job As HttpJob
	Job.Initialize("CreateThreadMessageJob", Me)
	Job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	' Create a map for the JSON body
	Dim jsonMap As Map
	jsonMap.Initialize
	jsonMap.Put("role", role) ' Set the role
	jsonMap.Put("content", content) ' Set the content
	jsonMap.Put("attachments", Null) ' Set attachments to null
	jsonMap.Put("metadata", CreateMap()) ' Create an empty map for metadata

	' Convert the map to a JSON string
	Dim json As JSONGenerator
	json.Initialize(jsonMap)
	Dim request As String = json.ToString
    
	' Set the API endpoint for creating a message in the thread
	Dim createMessageApiUrl As String = $"https://api.openai.com/v1/threads/${threadId}/messages"$

	' Send the POST request
	Job.PostString(createMessageApiUrl, request)
    
	' Set the request headers
	Job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	Job.GetRequest.SetContentType("application/json")
	Job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	LogColor("Sub OpAI.AddMessageToThread finished", 0xFF210099)
End Sub

Public Sub DeleteThread(threadId As String)
	LogColor("Sub OpAI.DeleteThread started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("DeleteThread", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	' Set the API endpoint for deleting a thread
	Dim url As String = $"https://api.openai.com/v1/threads/${threadId}"$

	' Send the DELETE request
	job.Delete(url)
    
	' Set the request headers
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")

	' Log the request
	LogHttpRequest("DeleteThread", url)
	'*** Add to the code to allow the user to select where to store the LogHttpRequest
	LogColor("Sub OpAI.DeleteThread finished", 0xFF210099)
End Sub

'Messages

Public Sub GetMessagesFromThread(thread_id As String, limit As String, order As String, after As String, before As String, run_id As String)
	LogColor("Sub OpAI.GetMessagesFromThread started", 0xFF210099)
    
	Dim job As HttpJob
	job.Initialize("GetMessagesFromThread", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	' Start with the base URL
	Dim baseUrl As String = $"https://api.openai.com/v1/threads/${thread_id}/messages"$

	Dim url As String = baseUrl
	Dim parameters As String = ""

	' Add the limit parameter if it's not blank
	If limit <> "" Then
		parameters = parameters & $"limit=${limit}"$
	End If

	' Add the order parameter if it's not blank
	If order <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"order=${order}"$
	End If

	' Add the after parameter if it's not blank
	If after <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"after=${after}"$
	End If

	' Add the before parameter if it's not blank
	If before <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"before=${before}"$
	End If

	' Add the run_id parameter if it's not blank
	If run_id <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"run_id=${run_id}"$
	End If

	' If parameters are present, append them to the URL
	If parameters <> "" Then
		url = url & "?" & parameters
	End If

	job.Download(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("GetMessagesFromThread", url)
	LogColor("Sub OpAI.GetMessagesFromThread finished", 0xFF210099)
End Sub

Public Sub DeleteMessageFromThread(threadId As String, messageId As String)
	LogColor("Sub OpAI.DeleteMessageFromThread started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("DeleteMessage", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.

	' Set the URL for the API call
	Dim url As String = $"https://api.openai.com/v1/threads/${threadId}/messages/${messageId}"$

	' Set the request headers
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
    job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")

	' Send the DELETE request
	job.Delete(url)
	LogColor("Sub OpAI.DeleteMessageFromThread finished", 0xFF210099)
End Sub

' Subroutine to retrieve a specific message from a thread
Public Sub RetrieveMessageFromThread(threadId As String, messageId As String)
	LogColor("Sub OpAI.RetrieveMessageFromThread started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("GetMessage", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.Download("https://api.openai.com/v1/threads/" & threadId & "/messages/" & messageId)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.RetrieveMessageFromThread finished", 0xFF210099)
End Sub

'UPLOAD FILES

Public Sub UploadFile(filePath As String, purpose As String)
	LogColor("Sub OpAI.UploadFile started", 0xFF210099)
	Log("Here Upload File")
    Dim job As HttpJob
    job.Initialize("UploadFile", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    job.Tag = filePath
	
    Dim mfd As MultipartFileData
    mfd.Initialize
    mfd.Dir = File.GetFileParent(filePath)
    mfd.FileName = File.GetName(filePath)
    mfd.KeyName = "file"
    mfd.ContentType = GetMimeType(mfd.FileName)
    
    ' Create the map for purpose
    Dim purposeMap As Map
    purposeMap.Initialize
    purposeMap.Put("purpose", purpose)
    
    ' Convert file data to a string for logging
    Dim fileDataString As String
    fileDataString = $"Dir: ${mfd.Dir}, FileName: ${mfd.FileName}, KeyName: ${mfd.KeyName}, ContentType: ${mfd.ContentType}"$
    
    ' Log the request including purpose and file data
    Dim requestString As String = $"Purpose: ${purpose}, FileData: ${fileDataString}"$
    LogHttpRequest("UploadFile", requestString)
    
    ' Post the multipart request
    job.PostMultipart("https://api.openai.com/v1/files", purposeMap, Array(mfd))
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.UploadFile finished", 0xFF210099)
End Sub

Public Sub InitializeUpload(Purpose As String, Folder As String, FileName As String)
	LogColor("Sub OpAI.InitializeUpload started", 0xFF210099)
	Log("Folder = " & Folder)
	Log("FileName = " & FileName)
	Private url As String = "https://api.openai.com/v1/uploads"
	'Dim FilePath As String = Folder & "\" & FileName
	Dim fileSize As Long = File.Size(Folder, FileName)
	Dim mimeType As String = GetMimeType(FileName) ' Adjust MIME type as needed

	Dim Job As HttpJob
	Job.Initialize("initializeUploadJob", Me)
	Job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.

	' Create a map for the JSON body
	Dim jsonMap As Map
	jsonMap.Initialize
	jsonMap.Put("filename", FileName) ' Set the filename
	jsonMap.Put("purpose", Purpose) ' Set the purpose
	jsonMap.Put("bytes", fileSize) ' Set the file size
	jsonMap.Put("mime_type", mimeType) ' Set the MIME type

	' Convert the map to a JSON string
	Dim json As JSONGenerator
	json.Initialize(jsonMap)
	Dim request As String = json.ToString

	' Post the JSON string to the upload API URL
	Job.PostString(url, request)

	' Set the request headers
	Job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	Job.GetRequest.SetContentType("application/json")
	Job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	Wait For (Job) JobDone (Job As HttpJob)
    
	If Job.Success Then
		Log("Initialize Upload Job Response = " & Job.GetString)
		Dim parser As JSONParser
		parser.Initialize(Job.GetString)
		Dim result As Map = parser.NextObject
		Dim FileID As String = result.Get("id")
		Log("File ID = " & FileID)

		'Reply to the user code
		' Modify the "object" field
		result.Put("object", "initializeupload") ' Change from "file" to "uploadfile"
		' Reassemble the Map to JSON
		Dim jsonGen As JSONGenerator
		jsonGen.Initialize(result)
		Dim newJson As String = jsonGen.ToString ' Create the new JSON string
		' Log the newly created JSON
		Log("Modified JSON: " & newJson)
		If xui.SubExists(mTarget, mEventname & "_Response", 2) Then
			CallSub2(mTarget, mEventname & "_Response",newJson)
		Else
			xui.MsgboxAsync("There is no Sub OpenAI_Response(response As String) in the user's code.","ERROR")
		End If

		' Proceed to upload parts
		Dim partSize As Long = 64 * 1024 * 1024 ' 64 MB
		Dim partCount As Int = Ceil(fileSize / partSize)
		Log("PartCount = " & partCount)
		Dim partIds As List
		partIds.Initialize
        Job.Release
		
		For i = 0 To partCount - 1
			Dim start As Long = i * partSize
			Dim end1 As Long = Min((i + 1) * partSize, fileSize)
			Dim length As Long = end1 - start
			Log("Uploading part " & (i + 1) & " of " & partCount & ", bytes " & start & " to " & end1)
            
			' Read the part data
			Dim raf As RandomAccessFile
			raf.Initialize(Folder, FileName, False)
			Dim partData(length) As Byte
			raf.ReadBytes(partData, 0, length, start)
			raf.Close
            
			' Build the multipart form-data body
			Dim stream As OutputStream
			stream.InitializeToBytesArray(0)
            
			' Define boundary
			Dim boundary As String = "---------------------------1461124740692"
			Dim eol As String = Chr(13) & Chr(10)
            
			' Build the header
			Dim fileHeader As String = _
$"--${boundary}
Content-Disposition: form-data; name="data"; filename="${FileName}"
Content-Type: ${mimeType}

"$
			fileHeader = fileHeader.Replace(CRLF, eol)
			Dim headerBytes() As Byte = fileHeader.GetBytes("UTF8")
			stream.WriteBytes(headerBytes, 0, headerBytes.Length)
            
			' Write the data
			stream.WriteBytes(partData, 0, partData.Length)
            
			' Write the end boundary
			Dim endBoundary As String = eol & "--" & boundary & "--" & eol
			Dim endBoundaryBytes() As Byte = endBoundary.GetBytes("UTF8")
			stream.WriteBytes(endBoundaryBytes, 0, endBoundaryBytes.Length)
            
			' Initialize and send the job
			Dim partJob As HttpJob
			Dim ix As Int = i + 1
			partJob.Tag = "File # "& ix & " of " & partCount
			partJob.Initialize("uploadPartJob", Me)
			Job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
			Dim url As String = "https://api.openai.com/v1/uploads/" & FileID & "/parts"
			partJob.PostBytes(url, stream.ToBytesArray)
			partJob.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
			partJob.GetRequest.SetContentType("multipart/form-data; boundary=" & boundary)

			' Log the Request Details
			Log("Uploading to URL: " & url)
			Log("Authorization: Bearer " & apiKey)
			Log("Content-Type: multipart/form-data; boundary=" & boundary)
			' Log partial stream content, first 256 characters, for inspection
			'Dim streamContent As String = BytesToString(stream.ToBytesArray, 0, Min(256, stream.ToBytesArray.Length), "UTF8")
			'Log("Request Body Content (partial): " & streamContent)
            
			Wait For (partJob) JobDone (partJob As HttpJob)
            
			If partJob.Success Then
				' Parse the response
				Dim parser2 As JSONParser
				parser2.Initialize(partJob.GetString)
				Dim result2 As Map = parser2.NextObject
				Dim partId As String = result2.Get("id")
				
				'Report back to the user's code
				If xui.SubExists(mTarget, mEventname & "_Response", 2) Then
					CallSub2(mTarget, mEventname & "_Response",partJob.GetString)
				Else
					xui.MsgboxAsync("There is no Sub OpenAI_Response(response As String) in the user's code.","ERROR")
				End If
				partIds.Add(partId)
				Log("Uploaded part " & (i + 1) & " with id " & partId)
			Else
				Log("Error uploading part " & (i + 1) & ": " & partJob.ErrorMessage)
				' Handle the error appropriately
				Return ' Exit the sub if there's an error
			End If
            
			partJob.Release
		Next
        
		' Complete the upload
		Dim partIdsJson As String = "["
		For i = 0 To partIds.Size - 1
			Dim partId As String = partIds.Get(i)
			partIdsJson = partIdsJson & $" "${partId}" "$
			If i < partIds.Size - 1 Then
				partIdsJson = partIdsJson & ","
			End If
		Next
		partIdsJson = partIdsJson & "]"
        
		' Build the complete request JSON
		Dim completeJson As String = $"{"part_ids": ${partIdsJson}}"$

		' Send the complete request
		Dim completeJob As HttpJob
		completeJob.Initialize("completeUploadJob", Me)
		completeJob.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
		Dim completeUrl As String = "https://api.openai.com/v1/uploads/" & FileID & "/complete"
		completeJob.PostString(completeUrl, completeJson)
		completeJob.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
		completeJob.GetRequest.SetContentType("application/json")

		Wait For (completeJob) JobDone (completeJob As HttpJob)

		If completeJob.Success Then
			Log("Upload completed successfully.")
			Log("Response: " & completeJob.GetString)
			
			'Report back to the user's code
			If xui.SubExists(mTarget, mEventname & "_Response", 2) Then
				CallSub2(mTarget, mEventname & "_Response",completeJob.GetString)
			Else
				xui.MsgboxAsync("There is no Sub OpenAI_Response(response As String) in the user's code.","ERROR")
			End If
		Else
			Log("Error completing upload: " & completeJob.ErrorMessage)
		End If

		completeJob.Release
	Else
		Log("Error initializing upload: " & Job.ErrorMessage)
	End If
	Job.Release
	LogColor("Sub OpAI.InitializeUpload finished", 0xFF210099)
End Sub

Sub CancelUpload(uploadId As String)
	LogColor("Sub OpAI.CancelUpload started", 0xFF210099)
	Dim url As String = "https://api.openai.com/v1/uploads"
	Dim job As HttpJob
	job.Initialize("CancelUpload", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	
	job.PostString(url & "/" & uploadId & "/cancel", "")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	
	LogHttpRequest("CancelUpload", url & "/" & uploadId & "/cancel") ' Log the request.
	LogColor("Sub OpAI.CancelUpload finished", 0xFF210099)
End Sub

Public Sub CreateVectorStore(VectorStoreName As String)
	'NOTE This sub does not work.  It gives a Forbidden error.
	LogColor("Sub CreateVectorStore CreateAssistant started", 0xFF210099)
		
	Dim Job As HttpJob
	Job.Initialize("CreateVectorStore", Me)
	Job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	' Create a map for the JSON body
	Dim jsonMap As Map
	jsonMap.Initialize
	jsonMap.Put("name", VectorStoreName)
    
	' Convert the map to a JSON string
	Dim json As JSONGenerator
	json.Initialize(jsonMap)
	Dim jsonString As String = json.ToString
    
	' Post the JSON string directly
	Job.PostString("https://api.openai.com/v1/vector_stores", jsonString)
    
	' Set headers
	Job.GetRequest.SetContentType("application/json")
	Job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	Job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub CreateVectorStore CreateAssistant finished", 0xFF210099)
End Sub

Private Sub GetMimeType(fileName As String) As String
	LogColor("Sub OpenAI Library GetMimeType started", 0xFF009901)
	'Supported File Types:
	'https://platform.openai.com/docs/assistants/tools/code-interpreter/supported-files
	Dim extension As String = fileName.SubString(fileName.LastIndexOf(".") + 1).ToLowerCase
	LogColor("Sub OpenAI Library GetMimeType finished", 0xFFFF7100)
	Select extension
		Case "txt"
			Return "text/plain"
		Case "html", "htm"
			Return "text/html"
		Case "jpg", "jpeg"
			Return "image/jpeg"
		Case "png"
			Return "image/png"
		Case "pdf"
			Return "application/pdf"
		Case "doc"
			Return "application/msword"
		Case "docx"
			Return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
		Case "xls"
			Return "application/vnd.ms-excel"
		Case "xlsx"
			Return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
		Case "c"
			Return "text/x-c"
		Case "cs"
			Return "text/x-csharp"
		Case "cpp"
			Return "text/x-c++"
		Case "java"
			Return "text/x-java"
		Case "json"
			Return "application/json"
		Case "md"
			Return "text/markdown"
		Case "php"
			Return "text/x-php"
		Case "pptx"
			Return "application/vnd.openxmlformats-officedocument.presentationml.presentation"
		Case "py"
			Return "text/x-python"
		Case "rb"
			Return "text/x-ruby"
		Case "tex"
			Return "text/x-tex"
		Case "css"
			Return "text/css"
		Case "js"
			Return "text/javascript"
		Case "sh"
			Return "application/x-sh"
		Case "ts"
			Return "application/typescript"
		Case "csv"
			Return "application/csv"
		Case "gif"
			Return "image/gif"
		Case "pkl"
			Return "application/octet-stream"
		Case "tar"
			Return "application/x-tar"
		Case "xml"
			Return "text/xml"
		Case "zip"
			Return "application/zip"
		Case Else
			Return "application/octet-stream" ' Default MIME type for unknown extensions
	End Select
End Sub

'VECTOR STORES

Public Sub ListVectorStores(limit As String, order As String, after As String, before As String, filter As String)
	LogColor("Sub OpAI.ListVectorStores started", 0xFF210099)
    
	Dim job As HttpJob
	job.Initialize("ListVectorStores", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	Dim url As String = "https://api.openai.com/v1/vector_stores"
	Dim parameters As String = ""

	' Add the limit parameter if it's not blank and is a valid number
	If limit <> "" Then
		parameters = parameters & $"limit=${limit}"$
	End If

	' Add the order parameter if it's not blank
	If order <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"order=${order}"$
	End If

	' Add the after parameter if it's not blank
	If after <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"after=${after}"$
	End If

	' Add the before parameter if it's not blank
	If before <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"before=${before}"$
	End If

	' Add the filter parameter if it's not blank
	If filter <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"filter=${filter}"$
	End If

	' If parameters are present, append them to the URL
	If parameters <> "" Then
		url = url & "?" & parameters
	End If

	job.Download(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("ListVectorStores", url)
	LogColor("Sub OpAI.ListVectorStores finished", 0xFF210099)
End Sub

Public Sub AddFileToVectorStore(vectorStoreId As String, fileId As String)
	LogColor("Sub OpAI.AddFileToVectorStore started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("AddFileToVectorStore", Me) 'Object response is "thread.run"
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.

	Dim parameters As String
	parameters = $"{"file_id":"${fileId}"}"$
	'https://api.openai.com/v1/vector_stores/{vector_store_id}/files
	job.PostString("https://api.openai.com/v1/vector_stores/" & vectorStoreId & "/files", parameters)
	job.GetRequest.SetContentType("application/json")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Organization", "")
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.AddFileToVectorStore finished", 0xFF210099)
	
	' Log the request
	LogHttpRequest("AddFileToVectorStore", "https://api.openai.com/v1/vector_stores/" & vectorStoreId & "/files?" & parameters)
	LogColor("Sub OpAI.CreateVectorStore finished", 0xFF210099)
End Sub

Public Sub DeleteVectorStore(vectorStoreId As String)
	LogColor("Sub OpAI.DeleteVectorStore started", 0xFF210099)
	Private Job As HttpJob
	' Initialize the HTTP job
	Job.Initialize("DeleteVectorStore", Me)
	Job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.

	Job.Delete("https://api.openai.com/v1/vector_stores/" & vectorStoreId) ' Send a DELETE request to the specified URL

	' Set the necessary headers
	Job.GetRequest.SetHeader("Content-Type", "application/json")
	Job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	Job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.DeleteVectorStore finished", 0xFF210099)
End Sub

Public Sub RetrieveVectorStore(vectorStoreId As String)
	LogColor("Sub OpAI.RetrieveVectorStore started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("RetrieveVectorStore", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	'https://api.openai.com/v1/vector_stores/vs_abc123
	job.PostString("https://api.openai.com/v1/vector_stores/" & vectorStoreId,"")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("Content-Type", "application/json")
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogColor("Sub OpAI.RetrieveVectorStore finished", 0xFF210099)
End Sub

'VECTOR STORE FILES

Public Sub ListVectorStoreFiles(VectorStoreID As String, limit As String, order As String, after As String, before As String, filter As String)
	LogColor("Sub OpAI.ListVectorStoreFiles started", 0xFF210099)
    
	Dim job As HttpJob
	job.Initialize("ListVectorStoreFiles", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	Dim url As String = "https://api.openai.com/v1/vector_stores/" & VectorStoreID & "/files"
	Dim parameters As String = ""

	' Add the limit parameter if it's not blank and is a valid number
	If limit <> "" Then
		parameters = parameters & $"limit=${limit}"$
	End If

	' Add the order parameter if it's not blank
	If order <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"order=${order}"$
	End If

	' Add the after parameter if it's not blank
	If after <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"after=${after}"$
	End If

	' Add the before parameter if it's not blank
	If before <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"before=${before}"$
	End If

	' Add the filter parameter if it's not blank
	If filter <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"filter=${filter}"$
	End If

	' If parameters are present, append them to the URL
	If parameters <> "" Then
		url = url & "?" & parameters
	End If
	job.Download(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")

	' Log the request
	LogHttpRequest("ListVectorStoreFiles", url)
	LogColor("Sub OpAI.ListVectorStoreFiles finished", 0xFF210099)
End Sub

'FINE TUNING JOBS

Public Sub ListFineTuningJobs(limit As String, after As String, before As String)
	LogColor("Sub OpAI.ListFineTuningJobs started", 0xFF210099)
    
	Dim job As HttpJob
	job.Initialize("ListFineTuningJobs", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
    
	Dim url As String = "https://api.openai.com/v1/fine_tuning/jobs"
	Dim parameters As String = ""

	' Add limit parameter if it's not blank
	If limit <> "" Then
		parameters = parameters & $"limit=${limit}"$
	End If

	' Add after parameter if it's not blank
	If after <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"after=${after}"$
	End If

	' Add before parameter if it's not blank
	If before <> "" Then
		If parameters <> "" Then parameters = parameters & "&"
		parameters = parameters & $"before=${before}"$
	End If

	' If parameters are present, append them to the URL
	If parameters <> "" Then
		url = url & "?" & parameters
	End If

	job.Download(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("ListFineTuningJobs", url)
	LogColor("Sub OpAI.ListFineTuningJobs finished", 0xFF210099)
End Sub

Public Sub RetrieveFineTuningJob(fine_tuning_job_id As String)
	LogColor("Sub OpAI.RetrieveFineTuningJob started", 0xFF210099)

	Dim job As HttpJob
	job.Initialize("RetrieveFineTuningJob", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.

	' Construct URL
	Dim url As String = $"https://api.openai.com/v1/fine_tuning/jobs/${fine_tuning_job_id}"$

	job.Download(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("Content-Type", "application/json")

	' New lines added for support
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogHttpRequest("RetrieveFineTuningJob", url)
	LogColor("Sub OpAI.RetrieveFineTuningJob finished", 0xFF210099)
End Sub

Public Sub CancelFineTuningJob(fine_tuning_job_id As String)
	LogColor("Sub OpAI.CancelFineTuningJob started", 0xFF210099)

	Dim job As HttpJob
	job.Initialize("CancelFineTuningJob", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.

	' Construct URL for cancellation
	Dim url As String = $"https://api.openai.com/v1/fine_tuning/jobs/${fine_tuning_job_id}/cancel"$

	job.PostString(url, "")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("Content-Type", "application/json")

	' New lines added for support
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogHttpRequest("CancelFineTuningJob", url)
	LogColor("Sub OpAI.CancelFineTuningJob finished", 0xFF210099)
End Sub

'FINE TUNING EVENTS

Public Sub ListFineTuningEvents(FineTuningJobID As String, limit As String, after As String)
	LogColor("Sub OpAI.ListFineTuningEvents started", 0xFF210099)
    
	' Start with the base URL
	Dim baseUrl As String = $"https://api.openai.com/v1/fine_tuning/jobs/${FineTuningJobID}/events"$

	Dim url As String = baseUrl
	Dim parameters As String = ""

	' Add the after parameter if it's not blank
	If after <> "" Then
		If parameters <> "" Then parameters = parameters & "&" ' Add '&' if parameters are already present
		parameters = parameters & $"after=${after}"$
	End If
    
	' Add the limit parameter if it's not blank
	If limit <> "" Then
		If parameters <> "" Then parameters = parameters & "&" ' Add '&' if parameters are already present
		parameters = parameters & $"limit=${limit}"$
	End If

	' Check if we have any parameters to append
	If parameters <> "" Then
		url = url & "?" & parameters ' Append parameters to the URL
	End If

	Dim job As HttpJob
	job.Initialize("ListFineTuningEvents", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.Download(url)  ' Download the constructed URL
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
    
	' Log the request
	LogHttpRequest("ListFineTuningEvents", url)
	LogColor("Sub OpAI.ListFineTuningEvents finished", 0xFF210099)
End Sub

'MODELs

Public Sub ListModels
	LogColor("Sub OpAI.ListModels started", 0xFF210099)
	Dim job As HttpJob
	job.Initialize("ListModels", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.
	job.Download("https://api.openai.com/v1/models")
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogHttpRequest("ListModels", "https://api.openai.com/v1/models") ' Log the request.
	LogColor("Sub OpAI.ListModels finished", 0xFF210099)
End Sub

Public Sub DeleteFineTunedModel(ModelID As String)
	LogColor("Sub OpAI.DeleteFineTunedModel started", 0xFF210099)

	Dim job As HttpJob
	job.Initialize("DeleteFineTunedModel", Me)

	' Construct URL
	Dim url As String = $"https://api.openai.com/v1/models/${ModelID}"$

	' Send the DELETE request
	job.Delete(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("Content-Type", "application/json")

	' New lines added for support
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogHttpRequest("DeleteFineTunedModel", url)
End Sub

Public Sub RetrieveModel(ModelID As String)
	LogColor("Sub OpAI.RetrieveModel started", 0xFF210099)

	Dim job As HttpJob
	job.Initialize("RetrieveModel", Me)
	job.GetRequest.Timeout = 120000 'That is 120 seconds or two minutes.  Default is 30 seconds.

	' Construct URL
	Dim url As String = $"https://api.openai.com/v1/models/${ModelID}"$

	job.Download(url)
	job.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	job.GetRequest.SetHeader("Content-Type", "application/json")

	' New lines added for support
	job.GetRequest.SetHeader("OpenAI-Beta", "assistants=v2")
	LogHttpRequest("RetrieveModel", url)
End Sub

'JOBDONE

Private Sub JobDone(Job As HttpJob)
	LogColor("Sub OpAI.JobDone started", 0xFF210099)
	Log("Job Name = " & Job.JobName)
	
	If Job.Success Then
		'Log("Job.GetString = " & Job.GetString)
		'Note that Job.Getstring will give a string with JSON format.
		
		'This Select...Case is to create a resultMap for the Cases that have a JSON response.
		Select Job.JobName
			
			Case "ttsJob", "DownloadImage", "retrieveFileContent"
				'No action needed here.  These two don't give a JSON response.
				
			Case Else
				Dim NewObject As String = Job.JobName
				' Create a Map from the JSON object
				Dim parser As JSONParser
				parser.Initialize(Job.GetString)
				' Assuming parser is already initialized and pointing to the JSON structure
				Dim resultMap As Map = parser.NextObject()
		End Select
		
		'This Select...Case is to route the response back to the main code.  Special cases first then Case Else for all the rest.
		Select Job.JobName

			Case "retrieveFileContent"
				Log("retrieveFileContent")
				Dim FileStream As InputStream = Job.GetInputStream
				If xui.SubExists(mTarget, mEventname & "_FileResponse", 1) Then
					CallSub3(mTarget, mEventname & "_FileResponse", FileStream, Job.Tag) 'Job.Tag = Filename gotten from OpenAI.
				Else
					Log("OpenAI_FileResponse(inputStream As InputStream) sub is missing from user code.")
				End If

			Case "generateImage"
				Dim url As String = resultMap.Get("data").As(List).Get(0).As(Map).Get("url")
				Log("url for generateImage = " & url)
	
				Log("OpenAI: Image response ready!")
    
				' Check if the resultMap contains "data" and handle it accordingly
				Dim data As List
				data = resultMap.Get("data")
    
				' Check if we have at least one entry in data
				If data.Size = 0 Then
					Return ' Exit if the data array has no entries
				End If

				' Extract the first entry from the data array
				Dim imageData As Map = data.Get(0)
    
				' Extract required fields
				Dim revisedPrompt As String = imageData.Get("revised_prompt")
				Dim url As String = imageData.Get("url")
				Dim created As Long = resultMap.Get("created") ' Getting created timestamp from resultMap
				'Log("URL = " & url)
				' Construct a new response map
				Dim finalResponseMap As Map
				finalResponseMap.Initialize
				finalResponseMap.Put("object", "imageresponse") ' Adding the "object" level
				finalResponseMap.Put("revised_prompt", revisedPrompt)
				finalResponseMap.Put("url", url)
				finalResponseMap.Put("created", created)

				' Convert finalResponseMap to JSON string to pass to main code
				Dim jsonGen As JSONGenerator
				jsonGen.Initialize(finalResponseMap)
				Dim resultJson As String = jsonGen.ToString
				Log("resultJson = " & resultJson)
				
				' Call back to the main code with the constructed JSON response
				If xui.SubExists(mTarget, mEventname & "_Response", 2) Then
					CallSub2(mTarget, mEventname & "_Response", resultJson)
				Else
					xui.MsgboxAsync("There is no Sub OpenAI_Response(response As String) in the user's code.", "ERROR")
				End If

				Dim j As HttpJob
				j.Initialize("DownloadImage", Me)
				'LogHttpRequest("DownloadImage", url) ' Log the request
				Log("Download URL = " & url)
				j.Download(url)
				
			Case "DownloadImage"
				Log("Here in Library Download Image Case.")
				'Log("Here DownloadImage1")
				Dim ImageStream As InputStream = Job.GetInputStream
				If xui.SubExists(mTarget, mEventname & "_ImageResponse", 1) Then
					CallSub2(mTarget, mEventname & "_ImageResponse", ImageStream)
				Else
					Log("OpenAI_ImageResponse(inputStream As InputStream) sub is missing from user code.")
				End If
				
			Case "ttsJob"
				Dim AudioStream As InputStream = Job.GetInputStream
				If xui.SubExists(mTarget, mEventname & "_TTSResponse", 1) Then
					CallSub2(mTarget, mEventname & "_TTSResponse", AudioStream)
				Else
					Log("OpenAI_TTSResponse(inputStream As InputStream) sub is missing from user code.")
				End If

				'Those responses that require the object to be changed are handled here:
				'The reason for the object change is becaause many of the responses from OpenAI have the same object name.  The main code needs a way to differentiate between
				'jobs to respond correctly.
			Case "ListVectorStoreFiles", "retrieveFileJob", "ListRunSteps", "CreateThreadMessageJob", "ListModels", "DeleteFineTunedModel", "ListFineTuningJobs", "ListFineTuningEvents", "ListFineTuningJobs", "CheckRunStatus", "DeleteVectorStore", "RetrieveVectorStore", "ListVectorStores", "ListRuns", "RetrieveRun", "GetMessagesFromThread", "RetrieveAssistant", "ListAssistants", "listFilesJob", "CancelUpload", "completeUploadJob", "deleteFileJob", "UploadFile"
				' Modify the "object" field
				resultMap.Put("object", NewObject)

				' Reassemble the Map to JSON
				Dim jsonGen As JSONGenerator
				jsonGen.Initialize(resultMap)
    
				Dim newJson As String = jsonGen.ToString ' Create the new JSON string

				' Log the newly created JSON
				Log("Modified JSON: " & newJson)
				If xui.SubExists(mTarget, mEventname & "_Response", 2) Then
					CallSub2(mTarget, mEventname & "_Response",newJson)
				Else
					xui.MsgboxAsync("There is no Sub OpenAI_Response(response As String) in the user's code.","ERROR")
				End If
				
			Case Else 'Handles every job that is not a special case and does not need the Object changed.
				
				Log("CASE ELSE in JobDone")
				If xui.SubExists(mTarget, mEventname & "_Response", 2) Then
					CallSub2(mTarget, mEventname & "_Response",Job.GetString)
				Else
					xui.MsgboxAsync("There is no Sub OpenAI_Response(response As String) in the user's code.","ERROR")
				End If
		End Select
	Else
		' Call error sub for error handling
		HandleError(Job.JobName & ": " & Job.ErrorMessage)
	End If
	Job.Release
	LogColor("Sub OpAI.JobDone finished", 0xFFFF7100)
End Sub

Private Sub HandleError(errorMessage As String)
	LogColor("Sub OpAI.HandleError started", 0xFF210099)
	If xui.SubExists(mTarget, mEventname & "_Error", 1) Then
		CallSub2(mTarget, mEventname & "_Error", errorMessage)
	End If
	LogColor("Sub OpAI.HandleError finished", 0xFF210099)
End Sub

Private Sub LogHttpRequest(jobName As String, request As String)
	'LogColor("Sub OpAI.LogHttpRequest started", 0xFF210099)
	Log("HTTP Request Job Name: " & jobName)
	Log("HTTP Request String: " & request)
	'LogColor("Sub OpAI.LogHttpRequest finished", 0xFF210099)
End Sub