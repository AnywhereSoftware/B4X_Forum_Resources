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
	' Tested with model: qwen2.5-coder:14b
	'
	' Output:
	'
	' ```b4x
	' Sub ReadFileAndPrint(filePath As String)
	'     Dim reader As TextReader
	'     Try
	'         reader.Initialize(File.OpenInput(filePath))
	'         Do While reader.IsInitialized And Not reader.Eof
	'             Log(reader.ReadLine())
	'         Loop
	'         reader.Close()
	'     Catch
	'         Log("Error reading file: " & LastException.Message)
	'     End Try
	' End Sub
	
	Dim PromptBuilder As Pnd_PromptBuilder
	PromptBuilder.Initialize
	PromptBuilder.AddLine("You are an expert coder and understand different programming languages.")
	PromptBuilder.AddLine("Given a question, answer ONLY with code.")
	PromptBuilder.AddLine("Produce clean, formatted and indented code in markdown format.")
	PromptBuilder.AddLine("DO NOT include ANY extra text apart from code. Follow this instruction very strictly!")
	PromptBuilder.AddLine("If there's any additional information you want to add, use comments within code.")
	PromptBuilder.AddLine("Answer only in the programming language that has been asked for.")
	PromptBuilder.AddSeparator
	PromptBuilder.AddLine("Example: Sum 2 numbers in Python")
	PromptBuilder.AddLine("Answer:")
	PromptBuilder.AddLine("```python")
	PromptBuilder.AddLine("def sum(num1: int, num2: int) -> int:")
	PromptBuilder.AddLine("    return num1 + num2")
	PromptBuilder.AddLine("```")
	PromptBuilder.AddSeparator
	PromptBuilder.Add("How do I read a file as String in B4X language and print its contents to log?")
	
	btnSend.Enabled = False
	Dim Result As Pnd_OllamaAsyncResult = Main.Ollama.GenerateAsync(cBox.Value, PromptBuilder.Build, False)
	Do While True
		Dim Token As String = Result.StreamPool
		txtOutput.Text = txtOutput.Text & Token.Replace("\n", CRLF)
		txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)
		If Result.IsAlive = False Then
			txtOutput.Text = txtOutput.Text & CRLF & CRLF
			txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)
			Exit
		End If
		Sleep(100)
	Loop
	'Log(Result.CompleteResponse.Replace("\n", CRLF))
	btnSend.Enabled = True
End Sub