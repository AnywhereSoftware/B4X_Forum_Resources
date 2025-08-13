B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.01
@EndOfDesignText@
' ---- ---- ---- ---- ---- ---- ---- ---- 
' GoogleDrive via API V3
' created by: mw71 --> https://www.b4x.com/android/forum/threads/googledrive-via-api-v3.80775/
' ---- ---- ---- ---- ---- ---- ---- ---- 
'
' Last modified by: fredo 2018-08-29T06:02:37+00:00       ' RFC 3339 from here --> https://de.infobyip.com/epochtimeconverter.php
'
#region --- Some useful info ---
'
'   Google Drive Reference --> https://developers.google.com/drive/api/v3/reference/files/create#auth
' 	Google Drive Guide --> https://developers.google.com/drive/api/v3/manage-uploads
'   Google drive API --> https://console.developers.google.com/apis/library/drive.googleapis.com?filter=category:gsuite&project=meigekarten
'   Google drive API explorer --> https://developers.google.com/apis-explorer/?hl=en_GB#p/drive/v3/
'
'   Google API Errors --> --> https://developers.google.com/drive/api/v3/handle-errors#401_invalid_credentials
'
'   API console --> https://code.google.com/apis/console
'
'   Daimto blog --> http://www.daimto.com/category/googledrive/
'					https://www.daimto.com/google-drive-authentication-c/
'					http://www.daimto.com/google-development-beginners/
'
'					"Private data is data that is owned by a user".  "We use Oauth2 to access private data."
'					"The application should _____store_the_refresh_token_for_future use_____ and use the _____access_token_to_access_a_Google_API_____. 
'					 Once the access token expires, the _____application_uses_the refresh_token_to_obtain_a_new_one_____."
'
' ---- ---- ---- ---- ---- ---- ---- ---- 
'   ^\s*\t*\Log\(\"\#\-			F3, Find options, Type Regex:  Finds all lines beginning with Log("#-	
'   	                                                       Replaces all lines beginning with Log("#-	with  'yyy-Log("#-
' ---- ---- ---- ---- ---- ---- ---- ---- 
#end region
'
Sub Class_Globals
	Public oauth2 As GoogleOAuth2
	Private myClientID As String
	Private clientSecret As String
	Private myAccessToken As String
	Private myRefreshToken As String
	Private evName As String
	Private evModule As Object
	
	Private scope As String = "https://www.googleapis.com/auth/drive"
End Sub
'
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallbackModule As Object, cEventname As String, YourClientID As String, YourClientSecret As String) ', YourApiKey As String)
	myClientID = YourClientID
	clientSecret = YourClientSecret
	evModule = CallbackModule
	evName = cEventname
	oauth2.Initialize(Me, "oauth2", myClientID, scope)
End Sub
' 
' Starts the authenticated connection
Sub ConnectToDrive As ResumableSub
	'Log("#-GoogleDrive.Sub ConnectToDrive")
	oauth2.GetAccessToken
	Wait For OAuth2_AccessTokenAvailable (Success As Boolean, Token As TokenInformation)
	' ww~~-- ww~~-- ────────────────────
	'
	If Success = True Then
		' ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~--
		myAccessToken	= Token.AccessToken  ' Use to ACCESS the API
		myRefreshToken	= Token.RefreshToken ' SAVE for later use
		' ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~-- ~~--
		'
		'Test connection to Drive
		oauth2.TestConnect
		Wait For oauth2_TestFinish(strResult As String)
		' ww~~-- ww~~-- ────────────────────
		'Log("#-  x69, strResult=" & strResult)
		'
		CallSubDelayed(Me, "SendConnected")
		Return True
	Else
		Return False
	End If
End Sub

#Region Events
'
' Answers to the waiting "ConnectToDrive"-caller
Private Sub SendConnected
	Dim mm As Map
	mm.Initialize
	mm.Put("access_token", myAccessToken)
	mm.Put("refresh_token", myRefreshToken)
	mm.Put("clientid", myClientID)
	mm.Put("client_secret", clientSecret)
	'mm.Put("authorization", AuthorizationCode)
	CallSubDelayed2(evModule, evName & "_Connected", mm)
End Sub

#End Region

Sub ShowFileList(ParentFolderID As String) As ResumableSub
	'Log("#--")
	'Log("#-GoogleDrive.Sub ShowFileList")
	'Log("#-  Parent  : " & ParentFolderID)
	'
	Dim h_sfl As HttpJob
	h_sfl.Initialize("", Me)
	If ParentFolderID="" Then
		h_sfl.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q","mimeType!='application/vnd.google-apps.folder' and trashed=false"))
	Else
		h_sfl.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q", $"mimeType!='application/vnd.google-apps.folder' and '${ParentFolderID}' in parents and trashed=false"$))
	End If
	Wait For (h_sfl) JobDone(h_sfl As HttpJob)
	' ww~~-- ww~~-- ────────────────────
	'Log("#-  x207, h_sfl.Success=" & h_sfl.Success)
	'
	If h_sfl.Success Then
		'Log("#-  x209, h_sfl.GetString=" & h_sfl.GetString)
		' Example:
		'		{
		'		 "kind": "drive#fileList",
		'		 "incompleteSearch": False,
		'		 "files": [
		'		  {
		'		   "kind": "drive#file",
		'		   "id": "1wDFrasdfdsadasdasd4KtY",
		'		   "name": "testfile1",
		'		   "mimeType": "application/vnd.google-apps.spreadsheet"
		'		  },
		'		  {
		'		   "kind": "drive#file",
		'		   "id": "10yudsadsdfNwcX5XIne",
		'		   "name": "VEGAN IN A BOWL EBOOK.pdf",
		'		   "mimeType": "application/pdf"
		'		  },

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
			FilelisteExport.Add(fileEntry.Get("name") & "; " & fileEntry.Get("id"))
		Next
		CallSub2(evModule, evName & "_FileListResult", FilelisteExport)
	Else
		'Log("#-  x231, h_sfl.ErrorMessage=" &  h_sfl.ErrorMessage)
	End If
	h_sfl.Release
	'	Log("#-        x233, end of ShowFileList >>>")
	'	Log("#-")
	'	Log("#-")
	Return Null
	
End Sub

'Download a file from Google Drive
'		FileID : Is needed To download the correct File.
'		LocalPath : Is all allowed excepted File.DirAssets
'		LocalFilename : Name of the File. If the name should be the same like on Google Drive, pass with ""
'
'Event: FileDownloaded
Sub DownloadFile(FileID As String, LocalPath As String, LocalFilename As String) As ResumableSub
	'Log("#--")
	'Log("#-GoogleDrive.Sub 	DownloadFile")
	'Log("#-  FileID       : " & FileID)
	'Log("#-  LocalPath    : " & LocalPath)
	'Log("#-  LocalFilename: " & LocalFilename)
	
	Dim h_dl As HttpJob
	h_dl.Initialize("",Me)
	h_dl.Download("https://www.googleapis.com/drive/v3/files/" & FileID & "?alt=media")
	h_dl.GetRequest.SetHeader("Authorization", "Bearer " & myAccessToken)
	
	Wait For (h_dl) JobDone(h_dl As HttpJob)
	' ww~~-- ww~~-- ────────────────────
	
	If h_dl.Success Then
		Dim inStr As InputStream
		Dim out As OutputStream

		If LocalPath= "" Then LocalPath= File.DirRootExternal
		If LocalFilename = "" Then LocalFilename= "Download-" & DateTime.Time(DateTime.Now) & ".x"
		inStr = h_dl.GetInputStream
	
		out = File.OpenOutput(LocalPath, LocalFilename, False)
		File.Copy2(inStr, out)
		out.Close
	
		CallSubDelayed2(evModule, evName & "_FileDownloaded", "{OK}")
	Else
		'Log("#-  x307, h_dl.ErrorMessage=" & h_dl.ErrorMessage)
		CallSubDelayed2(evModule, evName & "_FileDownloaded", "{ERR}")
	End If
	
	h_dl.Release
	Return Null
End Sub

'Upload a file to Google Drive
'		Name       - The Name of the filename (Name at Google Drive)
'		UploadDir  - The (local) folder of the upload File.
'		UploadFile - Filename (local) of the upload File
'		FileID     - The file ID on Google Drive. If not known, a new file will created.
' 
'Event: FileUploadDone(FileID as string)  
Sub UploadFile(FileId As String, LocalPath As String, LocalFilename As String, ParentFolderID As String, Name As String) As ResumableSub
	'Log("#--")
	'Log("#-GoogleDrive.Sub 	UploadFile")
	'Log("#-  FileID       : " & FileId)
	'Log("#-  LocalPath    : " & LocalPath)
	'Log("#-  LocalFilename: " & LocalFilename)
	'Log("#-  Name         : " & Name)

	Dim data() As Byte
	If Name = "" Then Name = LocalFilename
	Try
		Dim h_ul As HttpJob
		h_ul.Initialize("",Me)
		'
		If FileId = "" Then
			'Create the stream
			Dim boundary As String = "foo_bar_baz"
			Dim ContentType As String = "application/octet-stream"
			Dim EOL As String= Chr(13) & Chr(10)
			'
			Dim In As InputStream = File.OpenInput(LocalPath, LocalFilename)
			Dim out2 As OutputStream
			out2.InitializeToBytesArray(1000)
			'
			Dim m As Map
			m.Initialize
			m.Put("name", Name)
			If ParentFolderID <>"" Then m.Put("parents",Array As String(ParentFolderID))
			'
			Dim Jg As JSONGenerator
			Jg.Initialize(m)
			'
			'The first half of the POST contains the JSON data AND the Content Type from above.
			Dim RR As String = "--" & boundary & EOL & "Content-Type: application/json; charset=UTF-8" & EOL & EOL & Jg.ToString & EOL & EOL & "--" & boundary & EOL & "Content-Type: " & ContentType & EOL & EOL
			data = (RR).GetBytes("UTF-8")
			out2.WriteBytes(data, 0, data.Length)							'Write it To the Stream.
			File.Copy2(In, out2)											'Add the File itself To the Stream.
			data = (EOL & EOL & "--" & boundary & "--").GetBytes("UTF-8")	'Add the final boundary to the POST
			out2.WriteBytes(data, 0, data.Length)							'Write it To the Stream Then make the Bytes the complete Stream.
			data = out2.ToBytesArray

			'Log("#-  x369, h_ul.PostBytes(..)")
			h_ul.PostBytes("https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart", data)
			h_ul.GetRequest.SetContentType("multipart/related; boundary=" & boundary)
			h_ul.GetRequest.SetHeader("Authorization", "Bearer " &  myAccessToken)
			'
		Else
			'Create a new stream
			Dim OutUpdate As OutputStream
			Dim InUpate As InputStream = File.OpenInput(LocalPath, LocalFilename)
		
			OutUpdate.InitializeToBytesArray(1000)			'Initialize the stream
			File.Copy2(InUpate, OutUpdate)					'Copy the filestream in the output stream
			data = OutUpdate.ToBytesArray					'Fill export data array
			h_ul.PatchBytes($"https://www.googleapis.com/upload/drive/v3/files/${FileId}?uploadType=media"$, data)
			h_ul.GetRequest.SetHeader("Authorization", "Bearer " & myAccessToken)
		End If
		'
		wait For (h_ul) JobDone(h_ul As HttpJob)
		' ww~~-- ww~~-- ────────────────────
		'
		If h_ul.Success Then
			Dim j As JSONParser
			Dim map1 As Map
			J.Initialize(h_ul.GetString)
			map1 = J.NextObject
			CallSub2(evModule, evName & "_FileUploadDone", map1.Get("id"))
			'Log("#-  x385, h_ul.GetString=" & h_ul.GetString)
			'   {
			'	 "kind": "drive#file",
			'	 "id": "1Uqwqwqwqwetx2u9qnBck7_U-I3Lk9VsadasdOZr5",
			'	 "name": "testdatafile00002",
			'	 "mimeType": "application/octet-stream"
			'	}
			'
		Else
			'Log("#-  x387, h_ul.ErrorMessage =" & h_ul.ErrorMessage)
			CallSub2(evModule, evName & "_FileUploadDone", "{ERR1}")
			
			' Maybe this --> https://developers.google.com/drive/api/v3/handle-errors#401_invalid_credentials
			'				{
			'				 "error": {
			'				  "errors": [
			'				   {
			'				    "domain": "global",
			'				    "reason": "authError",
			'				    "message": "Invalid Credentials",
			'				    "locationType": "header",
			'				    "location": "Authorization"
			'				   }
			'				  ],
			'				  "code": 401,
			'				  "message": "Invalid Credentials"
			'				 }
			'				}
			
		End If
		'
	Catch
		'Log("#-  x429, Upload File fail:" &CRLF & LastException.Message)
		CallSub2(evModule, evName & "_FileUploadDone", "{ERR2}")
	End Try
	Return Null

End Sub

Sub CreateFolder(FolderName As String, ParentFolderID As String) As ResumableSub
	'Log("#--")
	'Log("#-GoogleDrive.Sub 	CreateFolder")
	'Log("#-  FolderName  : " & FolderName)
	'Log("#-  ParentFolder: " & ParentFolderID)
	
	Dim h_cf As HttpJob
	Dim m As Map : m.Initialize
	
	Dim jg As JSONGenerator
	Dim data() As Byte
	m.Put("name",  FolderName)
	m.Put("mimeType", "application/vnd.google-apps.folder")
	If ParentFolderID<>"" Then m.Put("parents",Array As String(ParentFolderID))

	jg.Initialize(m)						'Map zu JSON wandeln
	'Log("#-  x252, jg.ToPrettyString(1)=" & jg.ToPrettyString(1))				'JSON Anzeigen, mit Zeilenumbruch
	data = (jg.ToString).GetBytes("UTF-8")	'in Datenstream wandeln
	
	h_cf.Initialize("",Me)
	h_cf.PostBytes("https://www.googleapis.com/drive/v3/files?UploadType=multipart",data)
	h_cf.GetRequest.SetHeader("Authorization", "Bearer " & myAccessToken)
	h_cf.GetRequest.SetContentType("application/json;charset=UTF-8")

	wait For (h_cf) JobDone(h_cf As HttpJob)
	' ww~~-- ww~~-- ────────────────────
	
	If h_cf.Success Then
		'Log("#-  x264, h_cf.GetString=" & h_cf.GetString)
		Dim j As JSONParser
		Dim Map1 As Map
		J.Initialize(h_cf.GetString)
		Map1 = J.NextObject
		CallSub2(evModule, evName & "_FolderCreated", Map1.Get("id"))
	Else
		'Log("#-  x272, h_cf.ErrorMessage=" & h_cf.ErrorMessage)
		CallSub2(evModule, evName & "_FolderCreated", "")
	End If
	h_cf.Release
	Return Null
End Sub

Sub SearchForFolderID(SearchFolder As String, ParentFolderID As String) As ResumableSub
	Log("#--")
	Log("#-GoogleDrive.Sub SearchForFolerID")
	Log("#-  SearchFolder: " & SearchFolder)
	Log("#-  Parent      : " & ParentFolderID)
	
	Dim H_SFO As HttpJob
	H_SFO.Initialize("", Me)
	If ParentFolderID="" Then
		H_SFO.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q",$"mimeType='application/vnd.google-apps.folder' and name='${SearchFolder}' and trashed=false"$))
	Else
		H_SFO.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q",$"mimeType='application/vnd.google-apps.folder' and name='${SearchFolder}' and '${ParentFolderID}' in parents and trashed=false"$))
	End If
	Wait For (H_SFO) JobDone(H_SFO As HttpJob)
	' ww~~-- ww~~-- ────────────────────
	'
	If H_SFO.Success Then
		'Log("#-  x107, H_SFO.GetString=" & H_SFO.GetString)
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
			If  fileEntry.Get("name") = SearchFolder And _
				fileEntry.Get("mimeType") = "application/vnd.google-apps.folder" Then
				CallSub2(evModule, evName & "_FolderFound", fileEntry.Get("id"))
				Return Null ' Exit search after first hit
			End If
		Next
		CallSub2(evModule, evName & "_FolderFound", "")
	Else
		'Log("#-  x128, H_SFO.ErrorMessage=" & H_SFO.ErrorMessage)
		CallSub2(evModule, evName & "_FolderFound", "{ERR}")
	End If
	H_SFO.Release
	Return Null
End Sub

Sub SearchForFileID(SearchFile As String, ParentFolderID As String) As ResumableSub
	'Log("#--")
	'Log("#-GoogleDrive.Sub SearchForFileID")
	'Log("#-  SearchFile: " & SearchFile)
	'Log("#-  Parent    : " & ParentFolderID)

	Dim H_SFI As HttpJob
	H_SFI.Initialize("", Me)
	If ParentFolderID="" Then
		H_SFI.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q",$"mimeType!='application/vnd.google-apps.folder' and name='${SearchFile}' and trashed=false"$))
	Else
		H_SFI.Download2("https://www.googleapis.com/drive/v3/files", _
	         Array As String("access_token", myAccessToken, _
		    	             "corpora", "user", _
							 "q",$"mimeType!='application/vnd.google-apps.folder' and name='${SearchFile}' and '${ParentFolderID}' in parents and trashed=false"$))
	End If
	Wait For (H_SFI) JobDone(H_SFI As HttpJob)
	' ww~~-- ww~~-- ────────────────────

	If H_SFI.Success Then
		'Log("#-  x161, H_SFI.GetString=" & H_SFI.GetString)
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
			If  fileEntry.Get("name") = SearchFile Then
				CallSub2(evModule, evName & "_FileFound", fileEntry.Get("id"))
				Return Null ' Exit search if found
			End If
		Next
		CallSub2(evModule, evName & "_FileFound", "")
	Else
		'Log("#-  x198, H_SFI.ErrorMessage=" & H_SFI.ErrorMessage)
		CallSub2(evModule, evName & "_FileFound", "{ERR}")
	End If
	H_SFI.Release
	Return Null
End Sub
