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
	Private txtInput As TextArea
	Private btnSend As Button
	Private txtOutput As TextArea
	Private pDownload As PageDownload
	Private pDelete As PageDelete
	Private btnDownload As Button
	Private cBox As ComboBox
	Private btnDelete As Button
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub


Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	pDownload.Initialize
	pDelete.Initialize
	B4XPages.AddPage("Download", pDownload)
	B4XPages.AddPage("Delete", pDelete)
	
	
	Main.Ollama.Initialize("Ollama", "http://localhost:11434/")
	Main.Ollama.Verbose = True
	Main.Ollama.RequestTimeoutSeconds = 60
	Log("Ollama server online: " & Main.Ollama.Ping)
	If Main.Ollama.Ping Then
		GetModels
	Else
		txtOutput.Text = "Ollama server is OFFLINE."
	End If
	
End Sub


Sub Ollama_PullModelComplete
	GetModels
	pDelete.GetModels
	xui.MsgboxAsync("Successful Download", "Download")
End Sub


Sub GetModels
	cBox.Items.Clear
	For Each Model As Pnd_Model In Main.Ollama.ListModels
		cBox.Items.Add(Model.Model)
	Next
	If cBox.Items.Size < 1 Then
		xui.MsgboxAsync("You don't have any model to use." & CRLF & "Click on DOWNLOAD MODELS button.", "Info")
	End If		
End Sub


Private Sub btnSend_Click
	' Async (non blocking) method
	btnSend.Enabled = False
	txtOutput.Text = txtOutput.Text & "*** " & txtInput.Text & " ***" & CRLF
	Dim Result As Pnd_OllamaAsyncResult = Main.Ollama.GenerateAsync(cBox.Value, txtInput.Text, False)
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
		


	' Sync (blocking) method, will return respons at once
'	txtOutput.Text = txtOutput.Text & "*** " & txtInput.Text & " ***" & CRLF  & CRLF
'	Dim Result2 As Pnd_OllamaResult = Main.Ollama.GenerateSync(cBox.Value, txtInput.Text, False)
'		
'	txtOutput.Text = txtOutput.Text & Result2.Response.Replace("\n", CRLF) & CRLF & CRLF & CRLF
'	txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)



	' Sync (partialy blocking) method - Output streamed text in Ollama_SyncStreamed part by part. In every part will be text from previous part + text from new part
'	txtOutput.Text = txtOutput.Text & "*** " & txtInput.Text & " ***" & CRLF  & CRLF
'	Main.Ollama.GenerateSyncStreamed(cBox.Value, txtInput.Text, False)		

End Sub




Private Sub Ollama_SyncStreamed (Text As String)
	Log(Text)
	txtOutput.Text = Text
End Sub


Private Sub btnDownload_Click
	B4XPages.ShowPage("Download")
End Sub

Private Sub btnDelete_Click
	B4XPages.ShowPage("Delete")
End Sub