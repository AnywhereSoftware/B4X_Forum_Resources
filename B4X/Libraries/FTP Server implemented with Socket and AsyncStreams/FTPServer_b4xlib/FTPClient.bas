B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.5
@EndOfDesignText@
'Class module
Sub Class_Globals
	Type FTPTask (Path As String, Command As String)
	Private mServer As FTPServer
	Public mDataPort As Int
	Private AST As FTPAsyncStreamsText
	Private user As FTPUser
	Private loggedIn As Boolean
	Private currentPath As String
	Private currentDataConnection As FTPDataConnection
	Private closed As Boolean
	Private timeout As Timer
	Private lastCommand As Long
	Private RenameFrom As String
	Private Const TIMEOUT_MINUTES As Int = 5
	
End Sub

Public Sub Initialize (server As FTPServer, socket As Socket, DataPort As Int)
	mServer = server
	mDataPort = DataPort
	AST.Initialize(Me, "ast", socket.InputStream, socket.OutputStream)
	SendResponse(220, "B4X FTP Server")
	currentPath = "/"
	timeout.Initialize("timeout", 10000)
	timeout.Enabled = True
	If DataPort <= 0 Then
		Error(500, "Data ports not available.")
		CloseConnection
	End If
End Sub

Private Sub Timeout_Tick
	If DateTime.Now - lastCommand > TIMEOUT_MINUTES * DateTime.TicksPerMinute Then
		Log("Timeout!!!")
		CloseConnection
	End If
End Sub

Public Sub SendResponse(code As Int, message As String)
	AST.Write(code & " " & message & mServer.EOL)
End Sub

Private Sub AST_NewText(text As String)
	Log("client: " & text)
	Dim i As Int = text.IndexOf(" ")
	If i = -1 Then
		HandleClientCommand (text, "")
	Else
		HandleClientCommand (text.SubString2(0, i), text.SubString(i + 1))
	End If
	
End Sub

Private Sub HandleClientCommand(command As String, parameters As String)
	lastCommand = DateTime.Now
	Try
		If loggedIn = False Then
			Select command.ToUpperCase
				Case "USER"
					user.Name = parameters
					SendResponse(331, "")
				Case "PASS"
					user.Password = parameters
					HandleCredentials
				Case Else
					SendResponse(451, "Not logged in")
			End Select
		Else
			Select command.ToUpperCase
				Case "SYST"
					SendResponse(215, "UNIX")
				Case "PWD"
					Dim p As String = currentPath
					SendResponse (257, $""${p}""$)
				Case "PASV"
					PrepareDataConnection
					Dim ip As String
					If mServer.ForcedServerIp <> "" Then ip = mServer.ForcedServerIp Else ip = mServer.ssocket.GetMyIP
					SendResponse (227, ip.Replace(".", ",") & "," & Floor(mDataPort / 256) & "," & (mDataPort Mod 256))
				Case "EPSV"
					PrepareDataConnection
					SendResponse (229, $"Entering Extended Passive Mode (|||${mDataPort}|)"$)
				Case "CWD"
					ChangeDir(parameters)
				Case "LIST"
					SetCurrentTask(currentPath, "LIST")
				Case "RETR"
					Dim FileToDownload As String = CombineWithCurrent(parameters)
					If FileToDownload <> "" Then SetCurrentTask(FileToDownload, "RETR")
				Case "CDUP"
					ChangeDir("..")
				Case "STOR"
					Dim FileToUpload As String = CombineWithCurrent(parameters)
					If FileToUpload <> "" Then SetCurrentTask(FileToUpload, "STOR")
				Case "TYPE"
					'ignoring type
					SendResponse(200, "")
				Case "QUIT"
					SendResponse(200, "")
					CloseConnection
				Case "MKD"
					Dim folder As String = CombineWithCurrent(parameters)
					If folder <> "" Then 
						File.MakeDir(mServer.BaseDir, folder)
						SendResponse(200, "")
					End If
					
				Case "RNFR"
					RenameFrom = CombineWithCurrent(parameters)
					If RenameFrom <> "" Then SendResponse(300, "")
				Case "RNTO"
					Dim RenameTo As String = CombineWithCurrent(parameters)
					If RenameFrom <> "" And RenameTo <> "" Then
						RenameFile(File.Combine(mServer.BaseDir, RenameFrom), File.Combine(mServer.BaseDir, RenameTo))
						SendResponse(200, "")
					End If
				Case "DELE", "RMD"
					Dim DeleteFile As String = CombineWithCurrent(parameters)
					If DeleteFile <> "" Then 
						If File.Delete(mServer.BaseDir, DeleteFile) Then SendResponse(200, "") Else SendResponse(500, "")
					End If
				Case "NOOP"
					SendResponse(200, "")
				Case "FEAT"
					AST.Write("211-Features:" & mServer.EOL)
					AST.Write("UTF8" & mServer.EOL)
					SendResponse(211, "End")
				Case Else
					SendResponse(500, "Unknown command: " & command)
			End Select
		End If
	Catch
		Log(LastException)
		SendResponse(500, "Error: " & LastException.Message)
	End Try
End Sub

Private Sub CombineWithCurrent (Rel As String) As String
	Rel = Rel.Replace("\", "/")
	Dim Dir As String
	If Rel.StartsWith("/") Then Dir = Rel Else Dir = File.Combine(currentPath, Rel)
	Dim res As String = NormalizePath(Dir)
	If res = "" Then
		SendResponse(500, "Invalid path")
	End If
	Return res
End Sub

Private Sub ChangeDir (RelDir As String)
	Dim Dir As String = CombineWithCurrent(RelDir)
	If Dir <> "" And File.Exists(mServer.BaseDir, Dir) And File.IsDirectory(mServer.BaseDir, Dir) Then
		currentPath = Dir
		Log("CurrentPath: " & currentPath)
		SendResponse(200, "")
	Else if Dir <> "" Then 'Dir = "" was already handled in CombineWithCurrent
		SendResponse (500, "Invalid path")
	End If
End Sub

Private Sub PrepareDataConnection
	'create a new FTPDataConnection that will be used to handle the next task
	CloseDataConnection
	Dim currentDataConnection As FTPDataConnection
	currentDataConnection.Initialize(Me, mServer, mDataPort)
End Sub

Private Sub SetCurrentTask (Path As String, Command As String)
	Dim currentTask As FTPTask
	currentTask.Initialize
	currentTask.Command = Command
	currentTask.Path = Path
	SendResponse(150, "")
	currentDataConnection.SetTask(currentTask)
End Sub


Private Sub HandleCredentials
	If mServer.Users.ContainsKey(user.Name) Then
		Dim u As FTPUser = mServer.Users.Get(user.Name)
		If u.Password = user.Password Or u.Name = "anonymous" Then
			user = u
			loggedIn = True
			SendResponse(230, "")
			Log("User logged in: " & user.Name)
			Return
		End If
	End If
	Error(530, "Invalid username or password.")
End Sub

Private Sub NormalizePath(p As String) As String
	If p.StartsWith("/") Or p.StartsWith("\") Then p = p.SubString(1)
	
	#if B4A Or B4J
	Dim jo As JavaObject
	jo.InitializeNewInstance("java.io.File", Array(File.Combine(mServer.BaseDir, p)))
	Dim CanonicalPath As String = jo.RunMethod("getCanonicalPath", Null)
	If CanonicalPath.ToLowerCase.StartsWith(mServer.BaseDir.ToLowerCase) Then
		Dim r As String = CanonicalPath.SubString(mServer.BaseDir.Length).Replace("\", "/")
		If r.Length = 0 Then Return "/" Else Return r
	Else
		SendResponse(450, "Invalid path: " & p)
		Return ""
	End If
	#else if B4i
	
		Dim parts As List
		parts.Initialize
		For Each part As String In Regex.Split("/", p)
			If part = "." Or part = "" Then Continue
			If part = ".." Then
				If parts.Size = 0 Then
					SendResponse(450, "Invalid path: " & p)
					Return ""
				Else
					parts.RemoveAt(parts.Size - 1)
				End If
			Else
				parts.Add(part)
			End If
		Next
		Dim sb As StringBuilder
		sb.Initialize
		For Each part As String In parts
			sb.Append("/").Append(part)
		Next
		If sb.Length <= 1 Then
			Return "/"
		Else
			Return sb.ToString
		End If
	#End If
End Sub

Private Sub Error (code As Int, msg As String)
	SendResponse(code, msg)
	Log("Error: " & msg)
	AST.CloseGracefully		
End Sub

Private Sub CloseDataConnection
	If currentDataConnection <> Null And currentDataConnection.IsInitialized Then
		currentDataConnection.Close
	End If
End Sub

Public Sub CloseConnection
	If closed Then Return
	AST.Close
	CloseDataConnection
	mServer.ClientClosed(Me)
	timeout.Enabled = False
	closed = True
End Sub

Private Sub AST_Terminated
	Log("terminated")
	CloseConnection
End Sub


Private Sub RenameFile(source As String, target As String)
#if B4A OR B4J
	Dim joFileSource As JavaObject
	Dim joFileTarget As JavaObject
	joFileSource.InitializeNewInstance("java.io.File", Array(source))
	joFileTarget.InitializeNewInstance("java.io.File", Array(target))
	joFileSource.RunMethod("renameTo", Array(joFileTarget))
#else if B4i
	Dim no As NativeObject = Me
	no.RunMethod("renameFile::", Array(source, target))
#End If
End Sub

#if objc
- (BOOL)renameFile: (NSString*)source :(NSString*)target {
return [[NSFileManager defaultManager] moveItemAtPath:source toPath:target error:nil];
}
#end if
