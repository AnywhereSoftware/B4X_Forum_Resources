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

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private llm As LlamaEngine
	
	#If B4A
	Private rp As RuntimePermissions
	Private cc As ContentChooser
	Private sv As ScrollView
	Private nChkDebug As CheckBox
	#End If

	' Config views
	Private etPath As B4XView
	Private btnBrowse As B4XView
	Private etThreads As B4XView
	Private etContext As B4XView
	Private etTemplate As B4XView
	Private etTemp As B4XView
	Private etMaxTok As B4XView
	Private chkDebug As B4XView
	Private btnLoad As B4XView
	Private btnUnload As B4XView

	' Status
	Private lblStatus As B4XView

	' System prompt
	Private etSystem As B4XView

	' Chat area
	Private pnlChat As B4XView
	Private tvChat As B4XView

	' Input
	Private etInput As B4XView
	Private btnSend As B4XView
	Private btnStop As B4XView
	Private btnClear As B4XView

	' State
	Private sResponse As String
	Private sHistory As String
	Private chatH As Float
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	#If B4A
	cc.Initialize("CC")
	#End If
End Sub

Private Sub B4XPage_Created(Root1 As B4XView)
	Root = Root1
	Root.Color = xui.Color_RGB(245, 245, 245)
	
	BuildUI
	
	llm.Initialize( "LLM")
	sResponse = ""
	sHistory = ""
	
	UpdateUIState(False, False)
End Sub

Private Sub BuildUI
	Dim p As Float = 10dip
	Dim bh As Float = 45dip
	Dim sw As Float = Root.Width
	If sw = 0 Then sw = 100%x ' Fallback
	Dim y As Float = p

	' === Model path ===
	Dim browseW As Float = 45dip
	etPath = CreateEditText("etPath", "/sdcard/Download/model.gguf")
	Root.AddView(etPath, p, y, sw - 2*p - browseW - 5dip, bh)
	
	btnBrowse = CreateButton("btnBrowse", "...", xui.Color_RGB(158, 158, 158))
	Root.AddView(btnBrowse, sw - p - browseW, y, browseW, bh)
	y = y + bh + p

	' === Threads | Context | Temp | MaxTok ===
	Dim colW As Float = (sw - 5*p) / 4
	
	Dim lT As B4XView = CreateLabel("Threads")
	Root.AddView(lT, p, y, colW, 20dip)
	etThreads = CreateEditText("etThreads", "4")
	Root.AddView(etThreads, p, y + 20dip, colW, bh)

	Dim lC As B4XView = CreateLabel("Context")
	Root.AddView(lC, p + colW + p, y, colW, 20dip)
	etContext = CreateEditText("etContext", "512")
	Root.AddView(etContext, p + colW + p, y + 20dip, colW, bh)

	Dim lTp As B4XView = CreateLabel("Temp")
	Root.AddView(lTp, p + 2*(colW + p), y, colW, 20dip)
	etTemp = CreateEditText("etTemp", "0.7")
	Root.AddView(etTemp, p + 2*(colW + p), y + 20dip, colW, bh)

	Dim lMx As B4XView = CreateLabel("Max Tok")
	Root.AddView(lMx, p + 3*(colW + p), y, colW, 20dip)
	etMaxTok = CreateEditText("etMaxTok", "256")
	Root.AddView(etMaxTok, p + 3*(colW + p), y + 20dip, colW, bh)
	
	y = y + 20dip + bh + p

	' === Template | Debug checkbox ===
	Dim lTmpl As B4XView = CreateLabel("Template:")
	Root.AddView(lTmpl, p, y + 10dip, 75dip, 25dip)
	etTemplate = CreateEditText("etTemplate", "chatml")
	Root.AddView(etTemplate, p + 80dip, y, sw - 3*p - 80dip - 100dip, bh)
	
	#If B4A
	nChkDebug.Initialize("chkDebug")
	nChkDebug.Text = "Debug Log"
	nChkDebug.TextColor = xui.Color_Black
	chkDebug = nChkDebug
	Root.AddView(chkDebug, sw - p - 100dip, y + 5dip, 100dip, bh)
	#End If
	y = y + bh + p

	' === Load / Unload ===
	Dim half As Float = (sw - 3*p) / 2
	btnLoad = CreateButton("btnLoad", "Load Model", xui.Color_RGB(33, 150, 243))
	Root.AddView(btnLoad, p, y, half, bh)
	
	btnUnload = CreateButton("btnUnload", "Unload", xui.Color_RGB(244, 67, 54))
	Root.AddView(btnUnload, 2*p + half, y, half, bh)
	y = y + bh + p

	' === Status ===
	lblStatus = CreateLabel("Status: Waiting for model...")
	lblStatus.SetTextAlignment("CENTER", "LEFT")
	Root.AddView(lblStatus, p, y, sw - 2*p, 25dip)
	y = y + 25dip + p

	' === System prompt ===
	Dim lSys As B4XView = CreateLabel("System Prompt:")
	Root.AddView(lSys, p, y, sw - 2*p, 20dip)
	y = y + 20dip
	
	etSystem = CreateEditText("etSystem", "You are a helpful AI assistant. Answer concisely.")
	Root.AddView(etSystem, p, y, sw - 2*p, bh)
	y = y + bh + p

	' === Control buttons (Clear, Stop) ===
	Dim third As Float = (sw - 3*p) / 2
	btnStop = CreateButton("btnStop", "Stop Gen", xui.Color_RGB(255, 152, 0))
	Root.AddView(btnStop, p, y, third, bh)
	
	btnClear = CreateButton("btnClear", "Clear Chat", xui.Color_RGB(158, 158, 158))
	Root.AddView(btnClear, 2*p + third, y, third, bh)
	y = y + bh + p

	' === Message input & Send ===
	Dim sendW As Float = 80dip
	etInput = CreateEditText("etInput", "")
	Root.AddView(etInput, p, y, sw - 2*p - sendW - p, bh)
	
	btnSend = CreateButton("btnSend", "Send", xui.Color_RGB(76, 175, 80))
	Root.AddView(btnSend, sw - p - sendW, y, sendW, bh)
	y = y + bh + p

	' === Chat scroll area ===
	chatH = Root.Height - y - p
	If chatH < 100dip Then chatH = 100dip ' Fallback if screen is too small
	
	#If B4A
	sv.Initialize(chatH)
	Dim xSv As B4XView = sv
	Root.AddView(xSv, p, y, sw - 2*p, chatH)
	pnlChat = sv.Panel
	#End If
	
	pnlChat.Color = xui.Color_White
	
	tvChat = CreateLabel("– Chat will appear here –")
	tvChat.SetTextAlignment("TOP", "LEFT")
	pnlChat.AddView(tvChat, 10dip, 10dip, sw - 2*p - 20dip, chatH - 20dip)
End Sub

' --- UI Control Helpers ---
Private Sub CreateEditText(EventName As String, Text As String) As B4XView
	#If B4A
	Dim et As EditText
	et.Initialize(EventName)
	et.Text = Text
	et.Color = xui.Color_White
	et.TextColor = xui.Color_Black
	Return et
	#End If
End Sub

Private Sub CreateLabel(Text As String) As B4XView
	#If B4A
	Dim lbl As Label
	lbl.Initialize("")
	lbl.Text = Text
	lbl.TextColor = xui.Color_Black
	lbl.TextSize = 12
	Return lbl
	#End If
End Sub

Private Sub CreateButton(EventName As String, Text As String, Color As Int) As B4XView
	#If B4A
	Dim btn As Button
	btn.Initialize(EventName)
	btn.Text = Text
	btn.Color = Color
	btn.TextColor = xui.Color_White
	Return btn
	#End If
End Sub


' =================== UI Updates ===================

Private Sub UpdateUIState(IsLoaded As Boolean, IsGenerating As Boolean)
	btnLoad.Enabled = Not(IsLoaded)
	etPath.Enabled = Not(IsLoaded)
	
	btnUnload.Enabled = IsLoaded And Not(IsGenerating)
	btnSend.Enabled = IsLoaded And Not(IsGenerating)
	btnStop.Enabled = IsGenerating
	btnClear.Enabled = Not(IsGenerating)
	
	If Not(IsLoaded) Then
		SetStatus("Waiting for model...", xui.Color_DarkGray)
	Else If IsGenerating Then
		SetStatus("Generating...", xui.Color_RGB(255, 152, 0))
	Else
		SetStatus("Ready", xui.Color_RGB(76, 175, 80))
	End If
End Sub

Private Sub SetStatus(msg As String, color As Int)
	lblStatus.Text = "Status: " & msg
	lblStatus.TextColor = color
End Sub

' =================== Button Handlers ===================

Private Sub btnBrowse_Click
	#If B4A
	cc.Show("*/*", "Choose GGUF Model")
	#End If
End Sub

#If B4A
Private Sub CC_Result (Success As Boolean, Dir As String, FilePath As String)
	If Success Then
		If Dir = "ContentDir" Then
			' Da direkte Pfade in Android 11+ oft durch Berechtigungen (MANAGE_EXTERNAL_STORAGE) blockiert sind,
			' kopieren wir die Datei sicher in den App-Ordner, falls sie dort noch nicht liegt.
			Dim targetDir As String = xui.DefaultFolder
			Dim targetFile As String = "model.gguf"
			
			' Versuchen den Original-Namen aus dem URI zu bekommen (oft nach dem %2F oder in der URI)
			If FilePath.Contains("%2F") Then
				Dim parts() As String = Regex.Split("%2F", FilePath)
				targetFile = parts(parts.Length - 1)
			Else If FilePath.Contains("/") Then
				Dim parts() As String = Regex.Split("/", FilePath)
				targetFile = parts(parts.Length - 1)
			End If
			
			Dim fullTargetPath As String = File.Combine(targetDir, targetFile)
			
			' Wenn sie schon da ist und ähnlich groß, nicht nochmal kopieren (spart Zeit!)
			If File.Exists(targetDir, targetFile) Then
				etPath.Text = fullTargetPath
				SetStatus("Model already in app storage.", xui.Color_RGB(76, 175, 80))
				Return
			End If

			xui.MsgboxAsync("Copying model to internal app storage. This might take a few moments for large files. Please wait...", "Copying Model")
			
			Try
				' Wait a moment to let the Msgbox show up
				Sleep(500)
				File.Copy(Dir, FilePath, targetDir, targetFile)
				etPath.Text = fullTargetPath
				SetStatus("Model copied to app storage!", xui.Color_RGB(76, 175, 80))
			Catch
				xui.MsgboxAsync("Error copying file: " & LastException.Message, "Error")
			End Try
		Else
			etPath.Text = File.Combine(Dir, FilePath)
		End If
	End If
End Sub
#End If

Private Sub btnLoad_Click
	Dim path As String = etPath.Text.Trim
	If path = "" Then
		xui.MsgboxAsync("Please enter a valid model path.", "Error")
		Return
	End If
	
	#If B4A
	' Request permission if we are loading from an external path
	If path.StartsWith("/sdcard") Or path.StartsWith("/storage") Then
		Dim p As Phone
		If p.SdkVersion >= 30 Then
			' Android 11+ requires MANAGE_EXTERNAL_STORAGE
			Dim GetStorageManager As JavaObject
			GetStorageManager.InitializeStatic("android.os.Environment")
			If GetStorageManager.RunMethod("isExternalStorageManager", Null) = False Then
				xui.MsgboxAsync("On Android 11+, you must grant 'All Files Access' to read GGUF models directly from /sdcard. Please enable it in the next screen.", "Permission Required")
				Dim in As Intent
				in.Initialize("android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION", "package:" & Application.PackageName)
				StartActivity(in)
				Return
			End If
		Else
			' Android 10 and below
			rp.CheckAndRequest(rp.PERMISSION_READ_EXTERNAL_STORAGE)
			Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
			If Result = False Then
				xui.MsgboxAsync("Storage permission is required to load the model.", "Permission Denied")
				Return
			End If
		End If
	End If
	#End If

	' Parse parameters with fallbacks
	Dim thr As Int = ParseInt(etThreads.Text, 4)
	If thr < 1 Then thr = 1
	If thr > 16 Then thr = 16
	
	Dim ctx As Int = ParseInt(etContext.Text, 512)
	If ctx < 64 Then ctx = 64

	' Apply settings
	#If B4A
	llm.DebugMode = nChkDebug.Checked
	#End If
	llm.ChatTemplate = etTemplate.Text.Trim
	
	SetStatus("Loading model...", xui.Color_RGB(33, 150, 243))
	btnLoad.Enabled = False
	etPath.Enabled = False
	
	' Load the model asynchronously
	Try
		llm.LoadModel(path, thr, ctx)
	Catch
		SetStatus("Exception starting load: " & LastException.Message, xui.Color_Red)
		UpdateUIState(False, False)
	End Try
End Sub

Private Sub btnUnload_Click
	If llm.IsGenerating Then
		llm.StopGeneration
	End If
	
	SetStatus("Unloading...", xui.Color_DarkGray)
	llm.Unload
	UpdateUIState(False, False)
	AppendLine("[System: Model unloaded]")
End Sub

Private Sub btnSend_Click
	Dim msg As String = etInput.Text.Trim
	If msg = "" Then Return
	
	If llm.IsGenerating Then
		xui.MsgboxAsync("Generation is already running.", "Busy")
		Return
	End If
	
	If Not(llm.IsLoaded) Then
		xui.MsgboxAsync("Please load a model first.", "Error")
		Return
	End If

	' If it's the first message after a clear or load, apply the system prompt
	If llm.HistorySize = 0 Then
		Dim sys As String = etSystem.Text.Trim
		If sys <> "" Then
			llm.AddSystemMessage(sys)
		End If
	End If

	' Parse generation parameters
	Dim maxTok As Int = ParseInt(etMaxTok.Text, 256)
	Dim temp As Float = ParseFloat(etTemp.Text, 0.7)
	
	' Clear input field immediately
	etInput.Text = ""
	
	' Update UI and chat
	sResponse = ""
	AppendLine("You: " & msg)
	sHistory = sHistory & "AI: "
	tvChat.Text = sHistory
	ResizeChat
	
	UpdateUIState(True, True)
	
	Try
		llm.AddUserMessage(msg)
		llm.GenerateChat(maxTok, temp)
	Catch
		SetStatus("Generation error: " & LastException.Message, xui.Color_Red)
		UpdateUIState(True, False)
	End Try
End Sub

Private Sub btnStop_Click
	If llm.IsGenerating Then
		SetStatus("Stopping...", xui.Color_RGB(255, 152, 0))
		llm.StopGeneration
	End If
End Sub

Private Sub btnClear_Click
	llm.ClearHistory
	sHistory = ""
	sResponse = ""
	tvChat.Text = "– Chat cleared –"
	tvChat.TextColor = xui.Color_DarkGray
	ResizeChat
End Sub

Private Sub chkDebug_CheckedChange(Checked As Boolean)
	llm.DebugMode = Checked
End Sub

' =================== LlamaEngine Events ===================

Private Sub LLM_ModelLoaded(Success As Boolean)
	If Success Then
		UpdateUIState(True, False)
		tvChat.Text = ""
		tvChat.TextColor = xui.Color_Black
		AppendLine("[System: Model loaded successfully]")
	Else
		UpdateUIState(False, False)
		SetStatus("Failed to load model", xui.Color_Red)
		xui.MsgboxAsync("Could not load the model. Check the path and ensure it is a valid GGUF file.", "Load Error")
	End If
End Sub

Private Sub LLM_LoadProgress(Progress As Float)
	Dim pct As Int = Progress * 100
	SetStatus("Loading... " & pct & "%", xui.Color_RGB(33, 150, 243))
End Sub

Private Sub LLM_TokenGenerated(Token As String)
	sResponse = sResponse & Token
	tvChat.Text = sHistory & sResponse
	ResizeChat
End Sub

Private Sub LLM_Complete(Response As String)
	' Add the completed response to history properly
	llm.AddAssistantMessage(Response)
	sHistory = sHistory & Response & CRLF & CRLF
	sResponse = ""
	tvChat.Text = sHistory.Trim
	ResizeChat
	
	UpdateUIState(True, False)
End Sub

Private Sub LLM_Error(Message As String)
	UpdateUIState(llm.IsLoaded, False)
	SetStatus("Error: " & Message, xui.Color_Red)
	AppendLine(CRLF & "[ERROR: " & Message & "]")
End Sub

Private Sub LLM_DebugLog(Message As String)
	Log("LlamaEngine: " & Message)
End Sub

' =================== Helpers ===================

Private Sub AppendLine(line As String)
	sHistory = sHistory & line & CRLF
	tvChat.Text = sHistory.Trim
	ResizeChat
End Sub

Private Sub ResizeChat
	Dim text As String = tvChat.Text
	Dim lines As Int = 1
	For i = 0 To text.Length - 1
		If text.CharAt(i) = Chr(10) Then lines = lines + 1
	Next
	
	Dim expectedHeight As Float = Max(chatH - 20dip, lines * 22dip + 40dip)
	
	tvChat.Height = expectedHeight
	pnlChat.Height = expectedHeight + 20dip
	
	#If B4A
	sv.ScrollPosition = pnlChat.Height
	#End If
End Sub

Private Sub ParseInt(value As String, defaultVal As Int) As Int
	Try
		Return value
	Catch
		Return defaultVal
	End Try
End Sub

Private Sub ParseFloat(value As String, defaultVal As Float) As Float
	Try
		Return value
	Catch
		Return defaultVal
	End Try
End Sub
