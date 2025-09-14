B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
#Event: ChatResponse(Response as string)
#Event: ImageResponse(Image as B4XBitmap)
#Event: TTSResponse(Folder as string, Filename as string)
#Event: Error(message as string)

Sub Class_Globals
	Private apiKey As String
	Private chatList As List
	Private mTarget As Object
	Private mEventname As String
	Public MODEL_GPT4 As Int = 2
	Public MODEL_GPT35_TURBO As Int = 1
	Private CurrentChatModel As Int
	Public IMAGE_1_1 As Int = 1
	Public IMAGE_16_9 As Int = 2
	Public IMAGE_9_16 As Int = 3
	Public TTS_ALLOY As Int = 1
	Public TTS_ECHO As Int = 2
	Public TTS_FABLE As Int = 3
	Public TTS_ONYX As Int = 4
	Public TTS_NOVA As Int = 5
	Public TTS_SHIMMER As Int = 6
	Private TTS_VOICE as int
	Private ImageAspectRatio As Int
	Private xui As XUI
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Target As Object, EventName As String, key As String)
	apiKey = key
	mTarget=Target
	mEventname=EventName
	chatList.Initialize
End Sub

public Sub SystemMessage(promt As String)
	chatList.Add(CreateMap("role" : "system", "content" : promt))
End Sub

Public Sub ResetChat
	chatList.Clear
End Sub

Public Sub ChatMessage(promt As String)
	chatList.Add(CreateMap("role" : "user", "content" : promt))
	sendChat
End Sub

private Sub sendChat
	If chatList.Size>0 Then
		GetChatGPTResponse
	End If
End Sub

Public Sub setChatModel(model As Int)
	CurrentChatModel=model
End Sub

Public Sub setImageAspectRatio(ratio As Int)
	ImageAspectRatio=ratio
End Sub

Public Sub setTTSVoice(voice As Int)
	TTS_VOICE=voice
End Sub

private Sub getModel As String
	Select CurrentChatModel
		Case Model_GPT35_Turbo
			Return "gpt-3.5-turbo"
		Case Model_GPT4
			Return "gpt-4"
	End Select
	Return "gpt-3.5-turbo"
End Sub

private Sub getAspectRatio As String
	Select ImageAspectRatio
		Case IMAGE_1_1
			Return "1024x1024"
		Case IMAGE_16_9
			Return "1024x1792"
		Case IMAGE_9_16
			Return "1792x1024"
	End Select
	Return "1024x1024"
End Sub

private Sub getVoice As String
	Select TTS_VOICE
		Case TTS_ALLOY
			Return "alloy"
		Case TTS_ECHO
			Return "echo"
		Case TTS_FABLE
			Return "fable"
		Case TTS_ONYX
			Return "onyx"
		Case TTS_NOVA
			Return "nova"
		Case TTS_SHIMMER
			Return "shimmer"
	End Select
	Return "alloy"
End Sub

private Sub GetChatGPTResponse
	Dim j As HttpJob
	j.Initialize("", Me)
	Dim JSONGenerator As JSONGenerator
	JSONGenerator.Initialize2(chatList)
	Dim chat_string As String
	chat_string = $"{"model":"${getModel}","messages":${JSONGenerator.ToString}}"$
	j.PostString("https://api.openai.com/v1/chat/completions", chat_string)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	j.GetRequest.SetHeader("OpenAI-Organization", "")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		Log("OpenAI: ChatResponse ready!")
		Dim response As String = j.GetString
		If xui.SubExists(mTarget,mEventname & "_ChatResponse",0 )Then
			CallSub2(mTarget,mEventname & "_ChatResponse", ParseJson(response))
		Else
			Log("OpenAI: ChatResponse sub is missing")
		End If	
		Else
		error(j.ErrorMessage)
	End If
	j.Release
End Sub

private Sub ParseJson(json As String) As String
	Dim parser As JSONParser
	parser.Initialize(json)
	Dim Root1 As Map
	Root1 = parser.NextObject
	Dim choices As List
	choices = Root1.Get("choices")
	Dim choiceIndex As Int
	Dim content As String
	For choiceIndex = 0 To choices.Size - 1
		Dim choice As Map
		choice = choices.Get(choiceIndex)
		Dim message As Map
		message = choice.Get("message")
		If content <> "" Then content = content & CRLF
		content = content & message.Get("content")
		chatList.Add(CreateMap("role" : "assistant", "content" : content))
	Next
	Return content
End Sub

public Sub generateImage(Prompt As String)
	Dim j As HttpJob
	j.Initialize("", Me)
	Dim request As String
	request = $"{"model":"dall-e-3","prompt":"${Prompt}","n":1,"size":"${getAspectRatio}"}"$
	j.PostString("https://api.openai.com/v1/images/generations", request)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	j.GetRequest.SetHeader("OpenAI-Organization", "")
	Log("OpenAI: Generate Image...")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		Dim response As String = ""
		response = j.GetString
		Dim jp As JSONParser
		jp.Initialize(response)
		Dim m As Map = jp.NextObject
		Dim url As String = m.Get("data").As(List).Get(0).As(Map).Get("url")
		wait for (DownloadImage(url)) Complete (image As B4XBitmap)
		If xui.SubExists(mTarget,mEventname& "_ImageResponse",0 )Then
			CallSub2(mTarget,mEventname & "_ImageResponse", image)
		Else
			Log("OpenAI: ImageResponse sub is missing")
		End If
		Else
		error(j.ErrorMessage)
	End If
	j.Release
End Sub

private Sub DownloadImage(Link As String) As ResumableSub
	Log("OpenAI: Download Image...")
	Dim job As HttpJob
	job.Initialize("", Me) 'note that the name parameter is no longer needed.
	job.Download(Link)
	Wait For (job) JobDone(job As HttpJob)
	If job.Success Then
		Dim b As B4XBitmap = job.GetBitmap
		Log("OpenAI: Image ready!")
		Return b
	End If
	job.Release
	Return Null
End Sub

Public Sub TextToSpeech(Prompt As String)
	Dim j As HttpJob
	j.Initialize("", Me)
	Dim request As String
	request = $"{"model":"tts-1","input":"${Prompt}","voice":"${getVoice}"}"$
	j.PostString("https://api.openai.com/v1/audio/speech", request)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("Authorization", "Bearer " & apiKey)
	j.GetRequest.SetHeader("OpenAI-Organization", "")
	Log("OpenAI: Generate TTS...")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		Dim out As OutputStream = File.OpenOutput(xui.DefaultFolder, "tts.mp3", False)
		File.Copy2(j.GetInputStream, out)
		out.Close
		Log("OpenAI: TTS ready!")
		If xui.SubExists(mTarget,mEventname& "_TTSResponse",0 )Then
			CallSub3(mTarget,mEventname & "_TTSResponse", xui.DefaultFolder,"tts.mp3")
		Else
			Log("OpenAI: TTSResponse sub is missing")
		End If
		Else
		error(j.ErrorMessage)
	End If
	j.Release
End Sub

Sub error(message As String)
	Dim jp As JSONParser
	jp.Initialize(message)
	If xui.SubExists(mTarget,mEventname& "_Error",0 )Then
		CallSub2(mTarget,mEventname & "_Error", jp.NextObject.Get("error").As(Map).Get("message"))
	Else
		Log("OpenAI: TTSResponse sub is missing")
	End If
End Sub