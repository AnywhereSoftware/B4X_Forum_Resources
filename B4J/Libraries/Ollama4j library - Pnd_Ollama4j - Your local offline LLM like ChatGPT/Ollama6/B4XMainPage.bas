B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private btnSend As Button
	Private txtOutput As TextArea
	Private cBox As ComboBox
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub


Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Main.Ollama.Initialize("Ollama", "http://localhost:11434/")
	Main.Ollama.Verbose = True
	Main.Ollama.RequestTimeoutSeconds = 180
	Log("Ollama server online: " & Main.Ollama.Ping)
	If Main.Ollama.Ping Then
		GetModels
	Else
		txtOutput.Text = "Ollama server is OFFLINE."
	End If
	
End Sub


Sub GetModels
	cBox.Items.Clear
	For Each Model As Pnd_Model In Main.Ollama.ListModels
		cBox.Items.Add(Model.Model)
	Next
	If cBox.Items.Size < 1 Then
		xui.MsgboxAsync("You don't have any model to use.", "Info")
	End If		
End Sub


Private Sub btnSend_Click
	
	'  - Chat API lets you create a conversation with LLMs.
	'  - Using this API enables you to ask questions to the model including information using the history
	'    of already asked questions and the respective answers.
	
	' Tested with model: mistral:7b
	
	Dim OllamaChatRequestBuilder As Pnd_OllamaChatRequestBuilder
	OllamaChatRequestBuilder.Initialize(cBox.Value)
	Dim Role As Pnd_OllamaChatMessageRole
	Role.Initialize
	Dim OllamaChatRequest As Pnd_OllamaChatRequest
	
			
	' Build first question
	txtOutput.Text = txtOutput.Text &  "*** What is the capital of France? ***" & CRLF
	OllamaChatRequestBuilder.WithMessage(Role.USER, "What is the capital of France?")
	OllamaChatRequest.Initialize(OllamaChatRequestBuilder.Build)
	Dim Result As Pnd_OllamaChatResult = Main.Ollama.Chat(OllamaChatRequest)
	'Log (Result.ToString)
	txtOutput.Text = txtOutput.Text & Result.ResponseModel.Message.Content.Replace("\n", CRLF) & CRLF & CRLF
	txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)

	Sleep(1)


	' Build any other question
	txtOutput.Text = txtOutput.Text &  "*** And what is the second largest city? ***" & CRLF
	OllamaChatRequestBuilder.WithMessages(Result.ChatHistory)
	OllamaChatRequestBuilder.WithMessage(Role.USER, "And what is the second largest city?")
	OllamaChatRequest = OllamaChatRequestBuilder.Build
	Result = Main.Ollama.Chat(OllamaChatRequest)
	txtOutput.Text = txtOutput.Text & Result.ResponseModel.Message.Content.Replace("\n", CRLF) & CRLF & CRLF
	txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)
	
	Sleep(1)
	
	
	' Build any other question
	txtOutput.Text = txtOutput.Text &  "*** And which model of their cars is the fastest? ***" & CRLF
	OllamaChatRequestBuilder.WithMessages(Result.ChatHistory)
	OllamaChatRequestBuilder.WithMessage(Role.USER, "And which model of their cars is the fastest?")
	OllamaChatRequest = OllamaChatRequestBuilder.Build
	Result = Main.Ollama.Chat(OllamaChatRequest)
	txtOutput.Text = txtOutput.Text & Result.ResponseModel.Message.Content.Replace("\n", CRLF) & CRLF & CRLF
	txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)
	
	Sleep(1)
	
	
	' Build any other question
	txtOutput.Text = txtOutput.Text &  "*** When they start to produce it? ***" & CRLF
	OllamaChatRequestBuilder.WithMessages(Result.ChatHistory)
	OllamaChatRequestBuilder.WithMessage(Role.USER, "When they start to produce it?")
	OllamaChatRequest = OllamaChatRequestBuilder.Build
	Result = Main.Ollama.Chat(OllamaChatRequest)
	txtOutput.Text = txtOutput.Text & Result.ResponseModel.Message.Content.Replace("\n", CRLF) & CRLF & CRLF
	txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)
				
	Sleep(1)
	
	
	' ChatHistory is Java list
	Log (Result.ChatHistory)
	
	' ChatHistoryList is B4X List and have same values as ChatHistory.
	For Each OllamaChatMessage As Pnd_OllamaChatMessage In Result.ChatHistoryList
		If OllamaChatMessage.Role = Role.USER Then
			Log(Role.USER & " : " & OllamaChatMessage.Content)
		Else
			Log(Role.ASSISTANT & " : " & OllamaChatMessage.Content)
		End If		
	Next

End Sub