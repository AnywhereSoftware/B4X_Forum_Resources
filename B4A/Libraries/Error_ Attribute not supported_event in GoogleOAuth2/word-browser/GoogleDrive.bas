B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.9
@EndOfDesignText@
'Code copied from https://www.b4x.com/android/forum/threads/googledrive-via-api-v3.80775/
Type=Class
Version=7.01
ModulesStructureVersion=1
B4A=True
@EndOfDesignText@
Sub Class_Globals
	'Log
	Private Logstream As TextWriter
	Private DoWriteLog, LoginFileCreated, DoNotToast As Boolean
	
	Dim oauth2 As GoogleOAuth2

	Private myClientID As String
	Private clientSecret As String
	Private  myAccessToken, myRefreshToken As String
	
	Private evName As String
	Private evModule As Object


End Sub

#Region propertys
Public Sub setLogging(Val As Boolean)
	DoWriteLog = Val
End Sub
Public Sub setToast(Val As Boolean)
	DoNotToast=Val
End Sub
#End Region


'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallbackModule As Object, cEventname As String, YourClientID As String, YourClientSecret As String)
	Log("GoogleDrive Initiaize")
	myClientID = YourClientID
	clientSecret = YourClientSecret
	
	WriteLog("Init HttpUtils")
	evModule = CallbackModule
	evName = cEventname

	oauth2.Initialize(Me,"oauth2",myClientID,"https://www.googleapis.com/auth/drive")
End Sub

Sub ConnectToDrive
	Log("GoogleDrive ConnectToDrive")
	
	'Write log files
	If DoWriteLog Then CreateLogFile
	
	Log("GoogleDrive, Access Token request")
	oauth2.GetAccessToken
	Wait For OAuth2_AccessTokenAvailable (Success As Boolean, Token As TokenInformation)
	
	If Success = True Then
		myAccessToken=Token.AccessToken
		myRefreshToken=Token.RefreshToken
			
		Log("GoolgeDrive, Run Test Connect")
		oauth2.TestConnect
		Wait For oauth2_TestFinish(Erfolg As Boolean, Token As TokenInformation)
	
		If Erfolg=True Then
			Log("GoogleDrive, Run Test Connect")
			myAccessToken=Token.AccessToken
			myRefreshToken=Token.RefreshToken
			SendConnected
			Return
		Else
			Log("Google Drive, Test Connect Error")
		End If
	Else
		WriteLog("Google Drive, No Access Token")
	End If
	
	ProgressDialogHide
	CallSub(Main,"ConnectFaild")
End Sub

#Region Events
Private Sub SendConnected
	Log("Google Drive, SendConnected")
	Dim mm As Map
	mm.Initialize
	mm.Put("access_token", myAccessToken)
	mm.Put("refresh_token", myRefreshToken)
	mm.Put("clientid", myClientID)
	mm.Put("client_secret", clientSecret)
	CallSubDelayed2(evModule, evName & "_Connected", mm)
			
End Sub
#End Region

Sub SearchForFolderID(suchFolder As String, parrent As String)
	Log("-------------------")
	Log("Google Drive, SearchForFolerID")
	Log("SuchFolder:" & suchFolder)
	Log("Parrent:" & parrent)

	Dim H_SFO As HttpJob
	H_SFO.Initialize("", Me)
	If parrent="" Then
		H_SFO.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q","mimeType='application/vnd.google-apps.folder' and " & _
							 "name='" & suchFolder & "' and " & _ 
						 	"trashed=false"))
	Else
		H_SFO.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q","mimeType='application/vnd.google-apps.folder' and " & _
							 "name='" & suchFolder & "' and " & _ 
							 "'" & parrent & "' in parents and " & _
						 	"trashed=false"))
	End If
	Wait For (H_SFO) JobDone(H_SFO As HttpJob)
	
	If H_SFO.Success Then
		Log("Google Drive, SearchForFolderID Success")
		Dim j As JSONParser
		Dim Map1,fileEntry As Map
		Dim files As List
		
		J.Initialize(H_SFO.GetString)
		files.Initialize
		Map1 = J.NextObject
		files = Map1.Get("files")
		H_SFO.Release
		
		For i = 0 To files.Size - 1
			fileEntry = files.Get(i)
			If  fileEntry.Get("name") = suchFolder And _
				fileEntry.Get("mimeType") = "application/vnd.google-apps.folder" Then
				CallSub2(evModule, evName & "_FolderFound", fileEntry.Get("id"))
				Return
			End If
		Next
	Else
		Log("GoolgeDrive, SearchForFolderID, ERROR")
		Log(H_SFO.ErrorMessage)
	End If
	H_SFO.Release
	CallSub2(evModule, evName & "_FolderFound", "")
End Sub
Sub SearchForFileID(suchFile As String, parrent As String)
	Log("-------------------")
	Log("GoogleDrive, SearchForFIleID")
	Log("File:" & suchFile)
	Log("Parrent" & parrent)

	Dim H_SFI As HttpJob
	H_SFI.Initialize("", Me)
	If parrent="" Then
		H_SFI.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q","mimeType!='application/vnd.google-apps.folder' and" & _
							 "name='" & suchFile & "' and " & _ 
						 	"trashed=false"))
	Else
		H_SFI.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q","mimeType!='application/vnd.google-apps.folder' and" & _
							 "name='" & suchFile & "' and " & _ 
							 "'" & parrent & "' in parents and " & _
						 	"trashed=false"))
	End If
	Wait For (H_SFI) JobDone(H_SFI As HttpJob)

	If H_SFI.Success Then
		Log("GoogleDrive, SearchForFileID, Success")
		'Log(H_SFI.GetString)
		Dim j As JSONParser
		Dim Map1,fileEntry As Map
		Dim files As List
		
		J.Initialize(H_SFI.GetString)
		files.Initialize
		Map1 = J.NextObject
		files = Map1.Get("files")
		H_SFI.Release

		For i = 0 To files.Size - 1
			fileEntry = files.Get(i)
			If  fileEntry.Get("name") = suchFile Then
				CallSub2(evModule, evName & "_FileFound", fileEntry.Get("id"))
				Return
			End If
		Next
	Else
		Log(H_SFI.ErrorMessage)
	End If
	H_SFI.Release
	CallSub2(evModule, evName & "_FileFound", "")
End Sub
Sub ShowFileList(parrent As String)
	Log ("GoogleDrive, Show the File List")

	Dim h_sfl As HttpJob
	h_sfl.Initialize("", Me)
	If parrent="" Then
		h_sfl.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q","mimeType!='application/vnd.google-apps.folder' and" & _
						 	"trashed=false"))
	Else
		h_sfl.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q","mimeType!='application/vnd.google-apps.folder' and" & _
							 "'" & parrent & "' in parents and " & _
						 	"trashed=false"))
	End If
	Wait For (h_sfl) JobDone(h_sfl As HttpJob)
	
	If h_sfl.Success Then
		Log("GoogleDrive, ShowFileList, Success")

		Dim FilelisteExport As List
		Dim Map1, fileEntry As Map
		Dim J As JSONParser
		Dim files As List

		J.Initialize(h_sfl.GetString)
		files.Initialize
		Map1 = J.NextObject
		files = Map1.Get("files")
				
		If FilelisteExport.IsInitialized=False Then
			FilelisteExport.Initialize
			FilelisteExport.Clear
		End If
		For i = 0 To files.Size - 1
			fileEntry = files.Get(i)
			FilelisteExport.Add(fileEntry.Get("name") & ";" & fileEntry.Get("id"))
		Next
	Else
		Log(h_sfl.ErrorMessage)
	End If
	CallSub2(evModule, evName & "_FileListResult", FilelisteExport)
	h_sfl.Release
End Sub
Sub CreateFolder(FolderName As String, ParentFolder As String)
	Log("-------------------")
	Log("GoogleDrive, CreateFolder")
	Log("FolderName:" & FolderName)
	Log("Parent" & ParentFolder)
	
	Dim h_cf As HttpJob
	Dim m As Map : m.Initialize
	
	Dim jg As JSONGenerator
	Dim data() As Byte
	m.Put("name",  FolderName)
	m.Put("mimeType", "application/vnd.google-apps.folder")
	If ParentFolder<>"" Then m.Put("parents",Array As String(ParentFolder))

	jg.Initialize(m)						'Map zu JSON wandeln
	Log(jg.ToPrettyString(1))				'JSON Anzeigen, mit Zeilenumbruch
	data = (jg.ToString).GetBytes("UTF-8")	'in Datenstream wandeln
	
	h_cf.Initialize("",Me)
	h_cf.PostBytes("https://www.googleapis.com/drive/v3/files?UploadType=multipart",data)
	h_cf.GetRequest.SetHeader("Authorization", "Bearer " & myAccessToken)
	h_cf.GetRequest.SetContentType("application/json;charset=UTF-8")

	wait For (h_cf) JobDone(h_cf As HttpJob)
	
	If h_cf.Success Then
		'Log(h_cf.GetString)
		Log("GoogleDrive, Create Folder, Success")
		Dim j As JSONParser
		Dim Map1 As Map
		
		J.Initialize(h_cf.GetString)
		Map1 = J.NextObject
		CallSub2(evModule, evName & "_FolderCreated", Map1.Get("id"))
	Else
		Log("GoogleDrive, FolderCreate, ERROR")
		Log(h_cf.ErrorMessage)
	End If
	h_cf.Release
	CallSub2(evModule, evName & "_FolderCreated", "")
End Sub

'Download a file from Google Drive
'FileID : Is needed to download the correct file.
'LocalPath : Is all allowed excepted File.DirAssets
'LocalFilename : Name of the file. If the name should be the same like on Google Drive, pass with ""
'
'Event : FileDownloaded
Sub DownloadFile(FileID As String, LocalPath As String, LocalFilename As String)
	Log("-------------------")
	Log("GoogleDrive, DownloadFile")
	Log("LocalPath:" & LocalPath)
	Log("LocalFile" & LocalFilename)
	
	Dim h_dl As HttpJob
	h_dl.Initialize("",Me)
	h_dl.Download("https://www.googleapis.com/drive/v3/files/" & FileID & "?alt=media")
	h_dl.GetRequest.SetHeader("Authorization", "Bearer " & myAccessToken)
	
	Wait For (h_dl) JobDone(h_dl As HttpJob)
	
	If h_dl.Success Then
		Log("GoolgleDrive, Download Success")
		Dim inStr As InputStream
		Dim out As OutputStream

		If LocalPath= "" Then LocalPath= File.DirRootExternal
		If LocalFilename = "" Then LocalFilename= "Download-" & DateTime.Time(DateTime.Now) & ".x"
		inStr = h_dl.GetInputStream
	
		out = File.OpenOutput(LocalPath, LocalFilename, False)
		File.Copy2(inStr, out)
		out.Close
		CallSubDelayed2(evModule, evName & "_FileDownloaded",True)
	Else
		Log("GoogleDrive, Download ERROR")
		Log(h_dl.ErrorMessage)
		CallSubDelayed2(evModule, evName & "_FileDownloaded",False)
	End If
	
	h_dl.Release

End Sub

'Upload a file to Google Drive
'Name       - The Name of the filename (Name at Google Drive)
'UploadDir  - The (local) folder of the upload file.
'UploadFile - Filename (local) of the upload file
'FileID     - The file ID on Google Drive. If not known, a new file will created.
' 
'Events : FileUploadDone(FileID as string)  
Sub UploadFile(Name As String, LocalDir As String, LocalFilename As String, Parrent As String, FileId As String)

	Log("-------------------")
	Log("GoogleDrive, UploadFile")

	Dim data() As Byte

	If Name = "" Then Name = LocalFilename

	Log("LocalDir:" & LocalDir)
	Log("LocalFilename:" & LocalFilename)
	Log("Parent:" & Parrent)
	Log("FileID:" & FileId)
	
	Try
		Dim h_ul As HttpJob
		h_ul.Initialize("",Me)
	
		If FileId = "" Then
			Log("Upload w/o File ID (new File)")
			'Create the stream
			Dim boundary As String = "foo_bar_baz"
			Dim ContentType As String = "application/octet-stream"
			Dim EOL As String= Chr(13) & Chr(10)

			Dim In As InputStream = File.OpenInput(LocalDir, LocalFilename)
			Dim out2 As OutputStream
			out2.InitializeToBytesArray(1000)

			Dim m As Map
			m.Initialize
			m.Put("name", Name)
			If Parrent <>"" Then m.Put("parents",Array As String(Parrent))

			Dim Jg As JSONGenerator
			Jg.Initialize(m)

			'The first half of the POST contains the JSON data AND the Content Type from above.
			Dim RR As String = "--" & boundary & EOL & _
							"Content-Type: application/json; charset=UTF-8" & EOL & EOL & _ 
							Jg.ToString & EOL & EOL & _
							"--" & boundary & EOL & _
							"Content-Type: " & ContentType & EOL & EOL
							
			data = (RR).GetBytes("UTF-8")
	
			out2.WriteBytes(data, 0, data.Length)							'Write it To the Stream.
			File.Copy2(In, out2)											'Add the File itself To the Stream.
			data = (EOL & EOL & "--" & boundary & "--").GetBytes("UTF-8")	'Add the final boundary to the POST
			out2.WriteBytes(data, 0, data.Length)							'Write it To the Stream Then make the Bytes the complete Stream.
			data = out2.ToBytesArray
		
			h_ul.PostBytes("https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart", data)
			h_ul.GetRequest.SetContentType("multipart/related; boundary=" & boundary)
			h_ul.GetRequest.SetHeader("Authorization", "Bearer " & myAccessToken)
		Else
			Log("Upload with File ID (File Content Update)")
			'Create a new stream
			Dim OutUpdate As OutputStream
			Dim InUpate As InputStream = File.OpenInput(LocalDir, LocalFilename)
		
			OutUpdate.InitializeToBytesArray(1000)			'Initialize the stream
			File.Copy2(InUpate, OutUpdate)					'Copy the filestream in the output stream
			data = OutUpdate.ToBytesArray					'Fill export data array
		
			h_ul.PatchBytes("https://www.googleapis.com/upload/drive/v3/files" & "/" & FileId & "?uploadType=media", data)
			h_ul.getrequest.SetHeader("Authorization", "Bearer " & myAccessToken)
		End If

		wait For (h_ul) JobDone(h_ul As HttpJob)

		If h_ul.Success Then
			Log("Upload File Success")
			Dim j As JSONParser
			Dim Map1 As Map
		
			J.Initialize(h_ul.GetString)
			Map1 = J.NextObject
			FileId=Map1.Get("id")
		End If

	Catch
		Log("GoogleUpload File Error")
		Log(LastException.Message)
		Dim writer As TextWriter
		writer.Initialize(File.OpenOutput(File.DirRootExternal,"Bakup_Err.txt",True))
		writer.WriteLine(LocalFilename & ", " & LastException.Message)
		writer.Close
	End Try
	
	CallSubDelayed2(evModule, evName & "_FileUploaded", FileId)
End Sub



#Region "Logs"

Private Sub CreateLogFile
	If LoginFileCreated = False Then
		DateTime.DateFormat = "dd.MM.yyyy"
		DateTime.TimeFormat = "hh:mm"
		Logstream.Initialize(File.OpenOutput(File.DirRootExternal, "GoogleDriveLog.txt", True))
		Logstream.WriteLine("<---------------------------------------------------------------------------------------->")
		Logstream.WriteLine("")
		Logstream.WriteLine("")
		Logstream.WriteLine(DateTime.Date(DateTime.Now) & " " & DateTime.Time(DateTime.Now))
		Logstream.Flush
		LoginFileCreated = True
	End If
End Sub
Sub WriteLog(Text As String)
	'Private Sub WriteLog(Text As String)
	If DoWriteLog = False Then Return
	If Logstream.IsInitialized = False Then CreateLogFile
	Logstream.WriteLine(Text)
	If Text <> "" And DoNotToast = False Then ToastMessageShow(Text, False)
	Logstream.Flush
	Log(Text)
End Sub

#End Region