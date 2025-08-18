B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Automated synchronous FTP-client based on standard FTP-object
'v.0.14
Sub Class_Globals
	Private ph As PhoneEvents
	Private CONST LogFileName As String = "aftp_log.txt"
	Private CONST FTPFilesEntriesFileName As String = "kvs"
	Private owner As Object
	Private FTP1 As FTP
	Private Awake As PhoneWakeState
	Private FTPTimer As Timer
	Private Busy As Boolean
	Private kvs As KeyValueStore
	
	Public CONST EVENT_OK As String = "OK"
	Public CONST EVENT_ERROR As String = "FTP error"
	Public CONST EVENT_FILE_DOWNLOADED As String = "FTP file downloaded OK"
	Public CONST EVENT_FILE_UPLOADED As String = "FTP file uploaded OK"
	Public CONST EVENT_NEW_FILE_FOUND As String = "New file version on FTP is found"
	'Public CONST EVENT_FILE_DELETED As String = "The file was deleted on FTP"
	Public CONST EVENT_ZIP_ERROR As String = "ZIP-archive file integrity failed"
	
	Type FTPEntry2(Name As String, Timestamp As Long, Size As Long, FTPpath As String, LocalPath As String, status As String, DeleteAfter As Boolean)	'writable file info structure (FTP FTPEntry structure is read-only)
	Public FTPfiles As List	'current FTP files info to compare
	Private PrevFiles As List, CurrentFile As Int	'previous FTP files info to compare
	Private FilesToUpload, FilesToDelete As List	'files work queue
	Private Errors_Counter, ZIPerrors_Counter As Int
	Private Errors_Limit As Int = 3	'if Errors_Counter  > this value - alert about the permanent trouble with a file
	Private ZIPerror_File As FTPEntry2
	
	Private ftp_server As String
	Private ftp_login As String
	Private ftp_port As Int = 21
	Private ftp_pass As String

	Public LogMap As Map
	Public InternetConnected As Boolean
	Private ftp_RootFolder As String = "/"	'remote folder for download
	Public local_DownloadFolder As String	'input folder
	Public SecondsTimeout As Int = 60	'timer interval for auto-resync, seconds. if = 0 - no auto-reconnect
	Public ShowModalProgressbar As Boolean

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (CallBackModule As Object, Local_FTPFolder As String, host As String, login As String, password As String, port As Int, ReConnectSecondInterval As Int)
	LogMap.Initialize
	PrevFiles.Initialize
	FTPfiles.Initialize
	FilesToUpload.Initialize
	FilesToDelete.Initialize
	kvs.Initialize(File.DirInternal, FTPFilesEntriesFileName)
	
	If kvs.ContainsKey("ftp_entries") Then
		PrevFiles = kvs.Get("ftp_entries")
	End If
	owner = CallBackModule
	ftp_server = host
	ftp_login = login
	ftp_port = port
	ftp_pass = password
	SecondsTimeout = ReConnectSecondInterval
	
	local_DownloadFolder = Local_FTPFolder
	If File.ExternalWritable = False Then
		Log("Fatal folder trouble...")
		Return
	End If
	CurrentFile = -1	'current file in the FTP file list to be processed
End Sub

Public Sub Connect(remote_folder As String)
	ftp_RootFolder = remote_folder
	Awake.PartialLock
	ph.Initialize("ph")
	Wait for ph_ConnectivityChanged (NetworkType As String, State As String, Intent As Intent)
	ph_ConnectivityChanged(NetworkType, State, Intent)
End Sub

Private Sub ph_ConnectivityChanged (NetworkType As String, State As String, Intent As Intent)
	If State = "CONNECTED" Then
		InternetConnected = True
		Dim a As String = "Internet is now OK, " & NetworkType
		'Log(a)
		Report(EVENT_OK, a, Null)
		Init_Ftp
	Else	'NO INTERNET
		InternetConnected = False
		Log("INTERNET FAILED")
		Report(EVENT_ERROR, "INTERNET FAILED", Null)
		Close_FTP
	End If
End Sub

Private Sub Init_Ftp
	If SecondsTimeout > 0 Then
		FTPTimer.Initialize("FTPTimer", SecondsTimeout * 1000)
		FTPTimer.Enabled = True
	Else
		AddToLog("SecondsTimeout = 0, FTPTimer is not initialized")
	End If
	
	Try
		If Check_Internet = False Then Return
		If FTP1.IsInitialized Then FTP1.CloseNow
		Log("FTP init...")
		FTP1.TimeoutMs = SecondsTimeout * 1000
		FTP1.Initialize("FTP1",ftp_server, ftp_port, ftp_login, ftp_pass)
		FTP1.PassiveMode = True
		Errors_Counter = 0
		ZIPerrors_Counter = 0: ZIPerror_File = Null
		
		Busy = True
		CallSubDelayed(Me, "FTPTimer_Tick")	'start the work periodically by the timer
	Catch
		Hide_Progress
		ToastMessageShow("Warning: FTP server init trouble: " & LastException.Message, True)
		Log("Init_Ftp ERROR: " & LastException.Message)
	End Try
End Sub

Public Sub Close_FTP
	If InternetConnected = False Then
		FTP1.CloseNow
		Busy = False
	End If
End Sub

Private Sub Hide_Progress
	If ShowModalProgressbar Then
		ProgressDialogHide
	End If
End Sub

Private Sub FTPTimer_Tick
	If FTP1.IsInitialized = False Then
		Return
	End If	
	CallSub2(Me, "Get_FTPList", ftp_RootFolder)
End Sub

Private Sub Get_FTPList (fol As String)
	If FTP1.IsInitialized = False Then
		Init_Ftp
		Return
	End If
	FTP1.List(fol)
End Sub

Private Sub AddToLog (Text As String)
	If LogMap.IsInitialized = False Then
		LogMap.Initialize
		If File.Exists(File.DirInternal, LogFileName) Then
			LogMap = File.ReadMap(File.DirInternal, LogFileName)
		End If
	End If
	If LogMap.Size >0 Then
		If LogMap.GetValueAt(LogMap.Size - 1) = Text Then Return	'the same as before is not added
	End If

	Dim b As String, d, E As Long, f As Float
	DateTime.DateFormat = "dd-MM-yyyy"
	DateTime.TimeFormat = "HH:mm:ss"
	If LogMap.Size > 3000 Then
		LogMap.Remove(LogMap.GetKeyAt(0))	'delete the oldest
	End If

	d = DateTime.Now
	E = d - DateTime.TimeParse(DateTime.Time(d))
	f = E/DateTime.TicksPerSecond
	b = NumberFormat(f, 0, 3)

	LogMap.Put(DateTime.DAte(d) & " " & DateTime.Time(d) & b, Text)
'	If IsPaused(Main) = False Then
'		CallSub2(Main, "Add_Log", (DateTime.DAte(d) & " " & DateTime.Time(d) & b & ": " & Text))
'	End If
End Sub

Private Sub Report(EventKind As String, text As String, fileinfo As FTPEntry2)
	If SubExists(owner, "aftp_event") Then
		Dim m As Map
		m.Initialize
		m.Put("eventkind", EventKind)
		m.Put("message", text)
		If fileinfo <> Null Then
			If fileinfo.IsInitialized Then
				m.Put("file", fileinfo)
			End If
		End If
		CallSub2(owner, "aftp_event", m)
	End If
	Dim a As String = EventKind & ": " & text
	If fileinfo <> Null Then
		If fileinfo.IsInitialized Then
			a = a & "; file = " & fileinfo.Name & ", size = " & fileinfo.Size & ", date = " & DateTime.Date(fileinfo.Timestamp) & " " & DateTime.Time(fileinfo.Timestamp)
		End If
	End If
	AddToLog(a)
End Sub


Sub FTP1_ListCompleted (ServerPath As String, Success As Boolean, Folders() As FTPEntry, Files() As FTPEntry)
	'Log("ListCompleted: " & ServerPath & ", ListingSuccess=" & Success)
	If Success = False Then
		Errors_Counter = Errors_Counter + 1
		Hide_Progress
		Report(EVENT_ERROR, "List: " & ServerPath & ": " & FTP_Error(LastException.Message), Null)
		Close_FTP
		If Check_Internet = False Then
			CallSubDelayed(Me, "Init_Ftp")	'next loop of syncronization is possible
		End If
		Return
	Else
		Errors_Counter = 0
		Report(EVENT_OK, "FTP logged in OK: " & ServerPath & ", files = " & Files.Length, Null)
	End If
	
	FTPTimer.Enabled = False	'stop listings now till all files are syncronized
	Busy = True
	
	If ftp_RootFolder = ServerPath Then	'root folder is to be checked and auto-syncronized first of all
		'Log("ftp_RootFolder = ServerPath")
		Copy_TO_FTPEntry2(Files)	'save the FTP files list info to the writable structure to compare
		If PrevFiles.Size = 0 Then	'init the very beginning
			PrevFiles = FTPfiles
		End If
	End If
	CurrentFile = 0	'start checking from the first file
	CallSubDelayed(Me, "Check_AndDownload")
End Sub

Private Sub Copy_TO_FTPEntry2(source() As FTPEntry) As List
	Dim FTPfiles As List
	FTPfiles.initialize
	For i = 0 To source.Length - 1
		Dim src As FTPEntry = source(i)
		Dim fle As FTPEntry2 = CreateFTPEntry2(src.Name,src.Timestamp,src.Size,"","","")
		FTPfiles.Add(fle)
	Next
	Return FTPfiles
End Sub

Private Sub CreateFTPEntry2 (Name As String, Timestamp As Long, Size As Long, FTPpath As String, LocalPath As String, status As String) As FTPEntry2
	Dim t1 As FTPEntry2
	t1.Initialize
	t1.Name = Name
	t1.Timestamp = Timestamp
	t1.Size = Size
	t1.FTPpath = FTPpath
	t1.LocalPath = LocalPath
	t1.status = status
	Return t1
End Sub

'check if file format is of ZIP-archive, to be unpacked
Private Sub isZIPfile (dir As String, fn As String) As Boolean
	If File.Exists(dir, fn) = False Then
		Return False
	End If
	
	Dim ist As InputStream = File.OpenInput(dir, fn)
	
	Dim buffer(4) As Byte
	Dim res As Int = ist.ReadBytes(buffer, 0, 4)
	ist.Close
	If res = 4 Then
		If buffer(0) = 0x50 And buffer(1) = 0x4b And buffer(2) = 0x03 And buffer(3) = 0x04 Then
			Return True
		Else
			Return False
		End If
	Else
		Return False
	End If
End Sub

Sub Check_AndDownload
	If FTPfiles.Size > 0 Then
		Dim f As FTPEntry2 = FTPfiles.Get(CurrentFile)	'current file
		Dim localFolder As String = GetPath(f.LocalPath)
		If localFolder = "" Then	'local folder can be various
			localFolder = local_DownloadFolder
		End If
		FTPfiles.Set(CurrentFile, f)
		Dim Ex As Boolean = File.Exists(localFolder, f.Name)
		If Ex And File.Size(localFolder, f.Name) > 0 Then
			f.LocalPath = File.Combine(localFolder, f.Name)	'add local path for callback processing
			'Log("file exists locally: " & f.Name)
			If NewFileForUpdate(f) Then	'new file for update
				Report(EVENT_NEW_FILE_FOUND, f.Name, f)
				Delete_File(localFolder, f.Name)
				If f.status <> EVENT_ERROR Then
					FTP1.DownloadFile(File.Combine(ftp_RootFolder, f.Name), False, localFolder, f.Name)
					Return
				End If
			End If
		Else
			If f.status <> EVENT_ERROR Then
				Report(EVENT_OK, "New file, non-download yet: " & f.Name, f)
				FTP1.DownloadFile(File.Combine(ftp_RootFolder, f.Name), False, localFolder, f.Name)
				Return
			End If
		End If
	End If
	If NextFile_Pointer Then
		Busy = True
		CallSubDelayed(Me, "Check_AndDownload")
		Return
	End If
	'all files loop is checked
	CurrentFile = -1
	Log("PrevFiles.Size = " & PrevFiles.Size)
	PrevFiles = FTPfiles
	kvs.Put("ftp_entries", PrevFiles)	'save for new app re-start
	
	'----------------delete old local files that were removed from FTP---------------
	If FTPfiles.Size > 0 Then
		Dim L As List = File.ListFiles(localFolder)
		For i = 0 To L.Size - 1
			Dim a As String = L.Get(i)	'local file
			If File.IsDirectory(localFolder, a) Then Continue
			Dim fou As Boolean
			For j = 0 To FTPfiles.Size - 1
				Dim m As FTPEntry2 = FTPfiles.Get(j)
				If m.LocalPath = File.Combine(localFolder, a) Then
					fou = True	'such file exists locally and on FTP, skip
					Exit
				End If
			Next
			If fou = False Then
				Delete_File(localFolder, a)	'no file on FTP, but exists locally - delete it
			End If
		Next
	End If

	#if release
	Log("All FTP root files have been syncronized")
	#end if
	Report(EVENT_OK, "All FTP root files have been synchronized", Null)
	If Errors_Counter > Errors_Limit Then
		Report(EVENT_ERROR, "Permanent network or server trouble: errors qty is > " & Errors_Limit, Null)
	End If
	If ZIPerrors_Counter > Errors_Limit Then
		If File.Exists(ZIPerror_File.LocalPath, "") Then
			Report(EVENT_ZIP_ERROR, "Permanent trouble with ", ZIPerror_File)
		Else
			ZIPerrors_Counter = 0
			ZIPerror_File = Null
		End If
	End If
	Busy = False
	CallSubDelayed(Me, "Check_AndUpload")
End Sub

Private Sub NextFile_Pointer As Boolean
	If CurrentFile = FTPfiles.Size - 1 Or FTPfiles.Size = 0 Then	'the final file in the list
		Return False	'stop the loop over the files
	Else
		CurrentFile = CurrentFile + 1	'next file
		Return True
	End If
End Sub

'search and compare file info "f" from FTP and existing local one
Private Sub NewFileForUpdate (f As FTPEntry2) As Boolean
	For i = 0 To PrevFiles.Size - 1
		Dim oldf As FTPEntry2 = PrevFiles.Get(i)
		If oldf.Name = f.Name Then
			If oldf.Timestamp = f.Timestamp And oldf.Size = f.Size Then
				Return False	'file exists, not changed
			Else
				'Log("oldf.Timestamp=" &  oldf.Timestamp & "_" & "f.Timestamp=" & f.Timestamp)
				PrevFiles.Set(i, CreateFTPEntry2(f.Name, f.Timestamp, f.Size, f.FTPpath, f.LocalPath, "new"))
				Return True	'not exist, new version of file !
			End If
		End If
	Next
	Return False
End Sub

'update this sub to have more readable error texts as needed according to FTP error codes
Private Sub FTP_Error(errortext As String) As String
	If errortext.Contains("530") Then
		Return "Wrong login or password"
	Else If errortext.Contains("550") Then
		Return "File not found or inaccessible"
	Else If errortext.Contains("421") Or errortext.Contains("Connection reset") Or errortext.Contains("Broken pipe") Or errortext.Contains("ETIMEDOUT") Or errortext.Contains("IOException") Then
		'FTP error: FTP_ListCompleted with ERROR: org.apache.commons.net.ftp.FTPConnectionClosedException: FTP response 421 received.  Server closed connection.
		'FTP error: FTP_ListCompleted with ERROR: java.net.SocketException: Connection reset
		'FTP error: FTP_ListCompleted with ERROR: java.net.SocketException: Broken pipe
		'FTP error: android.system.ErrnoException: connect failed: ETIMEDOUT (Connection timed out)
		'FTP error: Download: /test.apk: org.apache.commons.net.io.CopyStreamException: IOException caught while copying.
		Return "Connection is interrupted by server"
	Else If errortext.Contains("500") Then
		Return "Error uploading File"
	Else If errortext.Contains("EAI_NODATA") Then
		'FTP error: List: /: android.system.GaiException: android_getaddrinfo failed: EAI_NODATA (No address associated with hostname)
		Return "Unknown server host"
	Else If errortext.Contains("EISDIR") Or errortext.Contains("ENOENT") Then
		'FTP error: Download2: /: android.system.ErrnoException: open failed: EISDIR (Is a directory)
		'android.system.ErrnoException: open failed: ENOENT (No such file or directory)
		Return "Wrong file name (folder ?)"
	Else
		Return errortext
	End If
End Sub

Private Sub FTP1_DownloadCompleted (ServerPath As String, Success As Boolean)
'	Log("DownloadCompleted: " & ServerPath & ", Success=" & Success)
	Dim fentry As FTPEntry2 = FTPfiles.Get(CurrentFile)
	Dim fn As String = GetFilename(ServerPath)
	Dim localFolder As String = GetPath(fentry.LocalPath)
	If localFolder = "" Then
		localFolder = local_DownloadFolder
	End If
	
	If Success = False Then
		Errors_Counter = Errors_Counter + 1
		Report(EVENT_ERROR, "Download: " & ServerPath & ": " & FTP_Error(LastException.Message), Null)
		Close_FTP
		Hide_Progress
		Set_CurrentFile_Status(EVENT_ERROR)	'save status of the file error downloading, to skip this file
		NextFile_Pointer	'next file
		CallSubDelayed(Me, "Check_AndDownload")
		Return
	Else
		Errors_Counter = 0
		Report(EVENT_FILE_DOWNLOADED, ServerPath, FTPfiles.Get(CurrentFile))
	End If

	'process the downloaded file
	fentry.FTPpath = ServerPath
	
	'file paths
	If File.Exists(localFolder, fn) And File.Size(localFolder, fn) = fentry.Size Then
		fentry.LocalPath = File.Combine(localFolder, fn)
		FTPfiles.Set(CurrentFile, fentry)
	End If
	'file integrity, if it is ZIP-like archive
	If isZIPfile(localFolder, fn) Then
		If isOK_ZIP(localFolder, fn) = False Then	'unpack to be sure
			ZIPerror_File = fentry
			ZIPerrors_Counter = ZIPerrors_Counter + 1
			Dim a As String = "Integrity test unpacking failed, bad ZIP-archive: " & fn
			AddToLog(a)
			Log(a)
			Report(EVENT_OK, "But ZIP-archive is CORRUPTED !", fentry)
			
			If ZIPerrors_Counter > Errors_Limit Then
				'stop blocking loop
			Else
				Delete_File(localFolder, fn)
				FTP1.DownloadFile(ServerPath, False, localFolder, fn)	're-download the corrupted ZIP-like file
				Return
			End If
		Else
			ZIPerrors_Counter = 0
			ZIPerror_File = Null
		End If
	End If
	'finally
	CallSubDelayed(Me, "Check_AndDownload")	're-check the version and go checking next file
End Sub

Private Sub Set_CurrentFile_Status(status As String)
	Dim f As FTPEntry2 = FTPfiles.Get(CurrentFile)	'current file
	f.status = status
	FTPfiles.Set(CurrentFile, f)	'save
End Sub

Private Sub isOK_ZIP (ZIP_folder As String, ZIP_fn As String) As Boolean
	Dim res As Boolean = True
	Try
		Dim zip As ABZipUnzip
		res = zip.ABUnzip(ZIP_folder & "/" & ZIP_fn, File.DirInternalCache)
		DeleteFolder(File.DirInternalCache)
		'AddToLog("Correct ZIP: " & ZIP_fn)
		Return res
	Catch
		Return False
	End Try
End Sub

Private Sub DeleteFolder (Folder1 As String)
	For Each f As String In File.ListFiles(Folder1)
		If File.IsDirectory(Folder1, f) Then
			DeleteFolder(File.Combine(Folder1, f))
		End If
		File.Delete(Folder1, f)
	Next
End Sub

Private Sub Delete_File(dir As String, fn As String) As Boolean
	Dim deleted, exists As Boolean
	exists = File.Exists(dir, fn)
	If exists Then
		deleted = File.Delete(dir, fn)
	End If
	If exists And Not(deleted) Then
		AddToLog("Locked, not deleted: " & File.Combine(dir, fn))
	End If
	Return deleted
End Sub

Private Sub GetFilename(fullpath As String) As String
	Return fullpath.SubString(fullpath.LastIndexOf("/") + 1)
End Sub

' Depends on: GetFilename
' Example
'Log(GetBasename("http://www.domain.tld/SomePage.html")) ' -> SomePage
Private Sub GetPath(Path As String) As String
	Dim Path1 As String
	If Path = "/" Or Path = "" Then
		Return Path
	End If
	Dim L As Int = Path.LastIndexOf("/")
	If L = Path.Length - 1 Then
		'Strip the last slash
		Path1 = Path.SubString2(0,L)
	Else
		Path1 = Path
	End If
	L = Path.LastIndexOf("/")
	If L = 0 Then
		L = 1
	End If
	Dim res As String
	Try
		res = Path1.SubString2(0,L)
	Catch
		Log("GetPath(" & Path & ").error = " & LastException)
	End Try
	Return res
End Sub


#Region SUBS FOR UPLOADING
Public Sub Upload_File(local_filedir As String, local_filename As String, FTPfolderTO As String, delete_after_upload As Boolean)
	If Check_Internet = False Then Return
	Dim f As FTPEntry2 = CreateFTPEntry2(local_filename, File.LastModified(local_filedir, local_filename), File.Size(local_filedir, local_filename), File.Combine(FTPfolderTO, local_filename), File.Combine(local_filedir, local_filename), "to_be_uploaded")
	f.DeleteAfter = delete_after_upload
	FilesToUpload.Add(f)
	If Busy = False Then
		Check_AndUpload
	End If
End Sub

Private Sub Check_AndUpload
	If FilesToUpload.Size = 0 Then
		Busy = False
		CallSubDelayed(Me, "Check_AndDelete")	'3rd spet after auto-sync download and upload
		Return
	End If
	Busy = True
	Dim f As FTPEntry2 = FilesToUpload.Get(0)
	FTP1.UploadFile(GetPath(f.LocalPath), f.Name, False, f.FTPpath)
End Sub

Sub FTP1_UploadCompleted (ServerPath As String, Success As Boolean)
	If FilesToUpload.Size > 0 Then
		Dim f As FTPEntry2 = FilesToUpload.Get(0)
		f.FTPpath = ServerPath
		If Success = False Then
			Errors_Counter = Errors_Counter + 1
			f.status = EVENT_ERROR
			Report(EVENT_ERROR, "Upload: " & ServerPath & ": " & FTP_Error(LastException.Message), f)
			Close_FTP
			Hide_Progress
			If Check_Internet = False Then
				CallSubDelayed(Me, "Init_Ftp")	'next loop of syncronization is possible
				Return
			End If
		Else
			Errors_Counter = 0
			f.status = EVENT_FILE_UPLOADED
			Report(EVENT_FILE_UPLOADED, ServerPath, f)
			If f.DeleteAfter Then
				File.Delete(f.LocalPath, f.Name)
			End If
		End If
		FilesToUpload.RemoveAt(0)
	End If
	CallSubDelayed(Me, "Check_AndUpload")
End Sub
#end region

#Region SUBS FOR DELETING
Public Sub Delete_FTP_File(FTPfolderFROM As String, local_filename As String)
	If Check_Internet = False Then Return
	Dim f As FTPEntry2 = CreateFTPEntry2(local_filename, 0, 0, File.Combine(FTPfolderFROM, local_filename), "", "to_be_deleted")
	Log("Delete queue: " & f.FTPpath)
	FilesToDelete.Add(f)
	If Busy = False Then
		Check_AndDelete
	End If
End Sub

Private Sub Check_AndDelete
	If FilesToDelete.Size = 0 Then
		Busy = False
		FTPTimer.Enabled = True	'next loop of syncronization is possible
		Return
	End If
	Busy = True
	Dim f As FTPEntry2 = FilesToDelete.Get(0)
	FTP1.DeleteFile(f.FTPpath)
End Sub

Private Sub FTP1_DeleteCompleted (ServerPath As String, Success As Boolean)
	If FilesToDelete.Size > 0 Then
		Dim f As FTPEntry2 = FilesToDelete.Get(0)
		f.FTPpath = ServerPath
		If Success = False Then
			Errors_Counter = Errors_Counter + 1
			f.status = EVENT_ERROR
			Report(EVENT_ERROR, "Delete: " & ServerPath & ": " & FTP_Error(LastException.Message), f)
			Close_FTP
			Hide_Progress
			If Check_Internet = False Then
				CallSubDelayed(Me, "Init_Ftp")	'next loop of syncronization is possible
				Return
			End If
		Else
			Errors_Counter = 0
			f.status = EVENT_OK
			Report(EVENT_OK, "Deleted", f)
		End If
		FilesToDelete.RemoveAt(0)
	End If
	CallSubDelayed(Me, "Check_AndDelete")
End Sub
#end Region

#Region SUBS FOR manual DOWNLOADING
Public Sub Download_FTP_File(filename As String, FTPfolderFROM As String, local_filedir As String)
	If Check_Internet = False Then Return
	Dim f As FTPEntry2 = CreateFTPEntry2(filename, 0, 0, File.Combine(FTPfolderFROM, filename), File.Combine(local_filedir, filename), "to_be_downloaded")
	Log("Download queue: " & f.LocalPath)
	Dim found As Boolean
	For j = 0 To FTPfiles.Size - 1
		Dim m As FTPEntry2 = FTPfiles.Get(j)
		If m.Name = f.Name Then
			If m.LocalPath <> "" Then
				If m.LocalPath = f.LocalPath Then
					found = True
					Exit
				End If
			End If
		End If
	Next
	If found = False Then
		FTPfiles.Add(f)
		If Busy = False Then
			Busy = True
			CurrentFile = FTPfiles.Size - 1
			'PrevFiles = FTPfiles
			CallSubDelayed(Me, "Check_AndDownload")
		End If
	End If
End Sub

#end Region

Private Sub Check_Internet As Boolean
	If InternetConnected = False Then
		Report(EVENT_ERROR, "Check Internet connection", Null)
		Return False
	Else
		Return True
	End If
End Sub