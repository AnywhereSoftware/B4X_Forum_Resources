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
	' Tested on vison model llava:7b
	
	' Question: What's in this image?
	' Response: In the image, there is a light-colored dog standing on a dock with a boat. 
	'           The boat is a white vessel with a cabin top and is docked in calm waters. 
	'           Behind the boat, you can see a body of water that appears to be a lake or river, 
	'           given the clear sky and lack of waves. The dog seems relaxed and alert at the same time, 
	'           possibly looking for something interesting or waiting for someone.
	'           The surroundings include what looks like a marina or boating area with docks and other boats in the background.
	
	' Question: Is dog in this image?
	' Response: Yes, there is a dog in the image. It appears to be a medium-sized dog standing on the bow of a boat.
	
	
	' You need to use LIST but diffrent models gives you a different response.
	' Some combine images and give response, some will give per image response.
	' Some will ignore evry image after first one.


	' Sync method
	Dim ListOfFiles As List
	ListOfFiles.Initialize
	ListOfFiles.Add("https://t3.ftcdn.net/jpg/02/96/63/80/360_F_296638053_0gUVA4WVBKceGsIr7LNqRWSnkusi07dq.jpg")

	btnSend.Enabled = False
	txtOutput.Text = txtOutput.Text & "*** " & txtInput.Text & " ***" & CRLF
	Dim Result As Pnd_OllamaResult = Main.Ollama.GenerateWithImageURLs(cBox.Value, txtInput.Text, ListOfFiles)
	txtOutput.Text = txtOutput.Text & Result.Response.Replace("\n", CRLF) & CRLF & CRLF
	txtOutput.SetSelection(txtOutput.Text.Length, txtOutput.Text.Length)
	btnSend.Enabled = True
End Sub