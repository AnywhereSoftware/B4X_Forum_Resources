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
	Dim ListOfInputs As List
	ListOfInputs.Initialize
	ListOfInputs.Add("Why is the sky blue?")
	ListOfInputs.Add("Why is the grass green?")
	btnSend.Enabled = False
	txtOutput.Text = txtOutput.Text & "*** Why is the sky blue? ***" & CRLF
	txtOutput.Text = txtOutput.Text & "*** Why is the grass green? ***" & CRLF
	Dim Response As Pnd_OllamaEmbedResponseModel = Main.Ollama.Embed(cBox.Value, ListOfInputs)
'	txtOutput.Text = txtOutput.Text & Response.ToString
	Dim SB As StringBuilder
	SB.Initialize
	For Each EmbeddingsList As List In Response.Embeddings
		SB.Append(CRLF & CRLF & CRLF & CRLF & "*** List ***" & CRLF)
		For Each Vectors As Double In EmbeddingsList
			SB.Append(Vectors & ", ")
		Next
	Next
	txtOutput.Text = txtOutput.Text & SB.ToString
	txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)
	btnSend.Enabled = True
End Sub