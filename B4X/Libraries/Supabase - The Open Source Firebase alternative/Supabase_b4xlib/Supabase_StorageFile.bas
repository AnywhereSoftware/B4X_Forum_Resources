B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private m_Supabase As Supabase
	
	Type SupabaseRangeDownloadTracker (CurrentLength As Long, TotalLength As Long, Completed As Boolean, Cancel As Boolean)
	
	Public Tag As Object
	
	Private m_Mode As String
	Private m_BucketName As String
	Private m_Wildcard As String
	Private m_FileBody() As Byte
	Private m_isUpsert As Boolean = False
	Private m_CacheControl As Int = 3600
'	Private m_TransformWidth As Int
'	Private m_TransformHeight As Int
'	Private m_TransformQuality As Int = 80
'	Private m_TransformResize As String
'	Private m_TransformFormat As String

	Private m_Transform As Map

	Private m_DeleteFiles() As Object
	Private m_MovePath_FromPath As String
	Private m_MovePath_ToPath As String
	Private m_MovePath_DestinationBucket As String
	Private m_ExpiresInSeconds As Int
	Private m_SignedURL As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisSupabase As Supabase,BucketName As String,Mode As String)
	m_Supabase = ThisSupabase
	m_BucketName = BucketName
	m_Mode = Mode
	m_Transform.Initialize
End Sub

'The file path, including the file name. Should be of the format `folder/subfolder/filename.png`. The bucket must already exist before attempting to upload.
Public Sub Path(FileName As String) As Supabase_StorageFile
	m_Wildcard = FileName
	Return Me
End Sub

Public Sub SignedURL(Url As String) As Supabase_StorageFile
	m_SignedURL = Url
	Return Me
End Sub

Public Sub ExpiresInSeconds(Seconds As Int) As Supabase_StorageFile
	m_ExpiresInSeconds = Seconds
	Return Me
End Sub

Public Sub FileBody(Data() As Byte) As Supabase_StorageFile
	m_FileBody = Data
	Return Me
End Sub

'Only for UploadFile and UpdateFile
'When upsert is set to true, the file is overwritten if it exists. When set to false, an error is thrown if the object already exists. Defaults to false.
Public Sub Options_Upsert(isUpsert As Boolean)  As Supabase_StorageFile
	m_isUpsert = isUpsert
	Return Me
End Sub

'Only for UploadFile and UpdateFile
'The number of seconds the asset is cached in the browser and in the Supabase CDN. This is set in the `Cache-Control: max-age=<seconds>` header. Defaults to 3600 seconds.
Public Sub Options_CacheControl(CacheControl As Int)  As Supabase_StorageFile
	m_CacheControl = CacheControl
	Return Me
End Sub

'The width of the image in pixels.
Public Sub DownloadOptions_TransformWidth(Width As Int) As Supabase_StorageFile
	m_Transform.Put("width",Width)
	Return Me
End Sub

'The height of the image in pixels.
Public Sub DownloadOptions_TransformHeight(Height As Int) As Supabase_StorageFile
	m_Transform.Put("height",Height)
	Return Me
End Sub

'Set the quality of the returned image. A number from 20 to 100, with 100 being the highest quality. Defaults to 80
Public Sub DownloadOptions_TransformQuality(Quality As Int) As Supabase_StorageFile
	m_Transform.Put("quality",Quality)
	Return Me
End Sub

'The resize mode can be cover, contain or fill. Defaults to cover. Cover resizes the image to maintain it's aspect ratio while filling the entire width and height. Contain resizes the image to maintain it's aspect ratio while fitting the entire image within the width and height. Fill resizes the image to fill the entire width and height. If the object's aspect ratio does not match the width and height, the image will be stretched to fit.
'<code>cover</code>
'<code>contain</code>
'<code>fill</code>
Public Sub DownloadOptions_TransformResize(ResizeMode As String) As Supabase_StorageFile
	m_Transform.Put("resize",ResizeMode)
	Return Me
End Sub

'Specify the format of the image requested. When using 'origin' we force the format to be the same as the original image. When this option is not passed in, images are optimized to modern image formats like Webp.
'<code>origin</code>
Public Sub DownloadOptions_TransformFormat(Format As String) As Supabase_StorageFile
	m_Transform.Put("format",Format)
	Return Me
End Sub

Public Sub Remove(FileNames() As Object) As Supabase_StorageFile
	m_DeleteFiles = FileNames
	Return Me
End Sub

Public Sub MoveFile(FromPath As String,ToPath As String,DestinationBucket As String) As Supabase_StorageFile
	m_MovePath_FromPath = FromPath
	m_MovePath_ToPath = ToPath
	m_MovePath_DestinationBucket = DestinationBucket
	Return Me
End Sub

Public Sub CopyFile(FromPath As String,ToPath As String,DestinationBucket As String) As Supabase_StorageFile
	m_MovePath_FromPath = FromPath
	m_MovePath_ToPath = ToPath
	m_MovePath_DestinationBucket = DestinationBucket
	Return Me
End Sub

Public Sub Execute As ResumableSub
	
	Select m_Mode
		Case "Upload"
			Wait For (UploadFile) Complete (Result As SupabaseStorageFile)
			Return Result
		Case "Download","DownloadProgress"
			Wait For (DownloadFile) Complete (Result As SupabaseStorageFile)
			Return Result
		Case "Update"
			Wait For (UpdateFile) Complete (Result As SupabaseStorageFile)
			Return Result
		Case "Delete"
			Wait For (DeleteFile) Complete (Result As SupabaseStorageFile)
			Return Result
		Case "MovePath"
			Wait For (MoveOrCopyPath(False)) Complete (Result As SupabaseStorageFile)
			Return Result
		Case "CopyPath"
			Wait For (MoveOrCopyPath(True)) Complete (Result As SupabaseStorageFile)
			Return Result
		Case "CreateSignedUrl"
			Wait For (CreateSignedUrl) Complete (Result As SupabaseStorageFile)
			Return Result
		Case Else
			Dim Bucket As SupabaseStorageBucket
			Bucket.Initialize
			Dim DatabaseError As SupabaseError
			DatabaseError.Initialize
			DatabaseError.Success = False
			DatabaseError.ErrorMessage = "unknown mode"
			Bucket.Error = DatabaseError
			Return Bucket
	End Select

End Sub

Private Sub DeleteFile As ResumableSub
	
	Dim StorageFile As SupabaseStorageFile
	StorageFile.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		StorageFile.Error = DatabaseError
		Return StorageFile
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/object/${m_BucketName}$""$$

	Dim j As HttpJob : j.Initialize("",Me)
	
	Dim tmp_Files(m_DeleteFiles.Length) As String
	
	For i = 0 To m_DeleteFiles.Length -1
		tmp_Files(i) = m_DeleteFiles(I)
	Next
	
	'j.dele(url,Array As stirng("prefixes",))
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	StorageFile.Error = DatabaseError

	Return StorageFile
	
End Sub

Private Sub Track (Tracker As SupabaseRangeDownloadTracker)
	Do While Tracker.Completed = False
		Sleep(100)
		'Label1.Text = $"$1.2{Tracker.CurrentLength / 1024 / 1024}MB / $1.2{Tracker.TotalLength / 1024 / 1024}MB"$
		'AnotherProgressBar1.Value = Tracker.CurrentLength / Tracker.TotalLength * 100
		'Log($"$1.2{Tracker.CurrentLength / 1024 / 1024}MB / $1.2{Tracker.TotalLength / 1024 / 1024}MB"$)
		If Supabase_Functions.SubExists2(Tag.As(Map).Get("EventCallback"),Tag.As(Map).Get("EventName") & "_RangeDownloadTracker",1) Then
			CallSub2(Tag.As(Map).Get("EventCallback"),Tag.As(Map).Get("EventName") & "_RangeDownloadTracker",Tracker)
		End If
	Loop
End Sub

Private Sub DownloadFile As ResumableSub
	
	Dim StorageFile As SupabaseStorageFile
	StorageFile.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		StorageFile.Error = DatabaseError
		Return StorageFile
	End If
	
	Dim j As HttpJob : j.Initialize("",Me)
	
	Dim url As String = $"${m_Supabase.URL}/storage/v1"$
	If m_SignedURL <> "" Then
		url = url & $"/${IIf(m_Transform.Size=0,"object","render/image")}/sign/${m_BucketName}/${m_Wildcard}"$
		
		Dim m As Matcher = Regex.Matcher("token=([^&\s]+)", m_SignedURL)
		If m.Find Then
			Dim token As String = m.Group(1)
			url = url & $"?token=${token}"$
		End If
		
	Else
		url = url & $"/${IIf(m_Transform.Size=0,"object",$"render/image/authenticated"$)}/${m_BucketName}/${m_Wildcard}"$
	End If
	
	Dim Counter As Int = 0
	For Each k As String In m_Transform.Keys
		Counter = Counter +1
		url = url & IIf(Counter = 1,"?","&") & k & "=" & m_Transform.Get(k)
	Next
	'Log(url)
	If m_Mode = "DownloadProgress" Then

		Dim tracker As SupabaseRangeDownloadTracker = RangeDownloader_CreateTracker
		Track(tracker)
		Wait For (RangeDownloader_Download(Tag.As(Map).Get("DownloadPath"),Supabase_Functions.GetFilename(m_Wildcard), url, tracker)) Complete (StorageFile2 As SupabaseStorageFile)
		'Log("Complete, success = " & Success)
		StorageFile = StorageFile2

	Else

		j.Download(url)
		j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
		j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
		Wait For (j) JobDone(j As HttpJob)

		DatabaseError.Success = j.Success

		If j.Success Then
			
			StorageFile.FileBody = Bit.InputStreamToBytes(j.GetInputStream)
			
		Else
			DatabaseError.StatusCode = j.Response.StatusCode
			DatabaseError.ErrorMessage = j.ErrorMessage
		End If

		StorageFile.Error = DatabaseError

	End If


	Return StorageFile
	
End Sub

Private Sub UpdateFile As ResumableSub
	
	Dim StorageFile As SupabaseStorageFile
	StorageFile.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		StorageFile.Error = DatabaseError
		Return StorageFile
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/object/${m_BucketName}/${m_Wildcard}"$

	Dim j As HttpJob : j.Initialize("",Me)
	j.PutBytes(url,m_FileBody)
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	j.GetRequest.SetHeader("upsert",m_isUpsert)
	j.GetRequest.SetHeader("cache_control",m_CacheControl)
	j.GetRequest.SetContentType(Supabase_Functions.GetMimeTypeByExtension(Supabase_Functions.GetFileExt(m_Wildcard)))
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
		'StorageFile
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	StorageFile.Error = DatabaseError
	Return StorageFile
	
End Sub

Private Sub UploadFile As ResumableSub
	
	Dim StorageFile As SupabaseStorageFile
	StorageFile.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		StorageFile.Error = DatabaseError
		Return StorageFile
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/object/${m_BucketName}/${m_Wildcard}"$

	Dim j As HttpJob : j.Initialize("",Me)
	j.PostBytes(url,m_FileBody)
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	j.GetRequest.SetHeader("upsert",m_isUpsert)
	j.GetRequest.SetHeader("cache_control",m_CacheControl)
	j.GetRequest.SetContentType(Supabase_Functions.GetMimeTypeByExtension(Supabase_Functions.GetFileExt(m_Wildcard)))
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
		'StorageFile
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	StorageFile.Error = DatabaseError
	Return StorageFile
	
End Sub

Private Sub MoveOrCopyPath(CopyPath As Boolean) As ResumableSub
	
	Dim StorageFile As SupabaseStorageFile
	StorageFile.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		StorageFile.Error = DatabaseError
		Return StorageFile
	End If

	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/object/"$ & IIf(CopyPath,"copy","move")

	Dim jsn As JSONGenerator
	
	Dim m_Request As Map
	m_Request.Initialize
	m_Request.Put("bucketId",m_BucketName)
	If m_MovePath_DestinationBucket <> "" Then m_Request.Put("destinationBucket",m_MovePath_DestinationBucket)
	m_Request.Put("sourceKey",m_MovePath_FromPath)
	m_Request.Put("destinationKey",m_MovePath_ToPath)
	
	jsn.Initialize(m_Request)

	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,jsn.ToString)
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	'j.GetRequest.SetContentType(Supabase_Functions.GetMimeTypeByExtension(Supabase_Functions.GetFileExt(m_Wildcard)))
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
		'StorageFile
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	StorageFile.Error = DatabaseError
	Return StorageFile
	
End Sub

Private Sub CreateSignedUrl As ResumableSub
	
	Dim StorageFile As SupabaseStorageFile
	StorageFile.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		StorageFile.Error = DatabaseError
		Return StorageFile
	End If
	
	Dim jsn As JSONGenerator
	
	Dim m_Request As Map
	m_Request.Initialize
	m_Request.Put("expiresIn",m_ExpiresInSeconds)
	
	jsn.Initialize(m_Request)
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/object/sign/${m_BucketName}/${m_Wildcard}"$

	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,jsn.ToString)
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	j.GetRequest.SetHeader("accept","application/json")
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
	
		Dim parser As JSONParser
		parser.Initialize(j.GetString)
		Dim jRoot As Map = parser.NextObject
	
		StorageFile.SignedURL = m_Supabase.URL & jRoot.Get("signedURL")
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	StorageFile.Error = DatabaseError
	Return StorageFile
	
End Sub


#Region RangeDownloader

Public Sub RangeDownloader_CreateTracker As SupabaseRangeDownloadTracker
	Dim t As SupabaseRangeDownloadTracker
	t.Initialize
	Return t
End Sub

Public Sub RangeDownloader_Download (Dir As String, FileName As String, URL As String, Tracker As SupabaseRangeDownloadTracker) As ResumableSub
	
	Dim StorageFile As SupabaseStorageFile
	StorageFile.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Dim head As HttpJob
	head.Initialize("", Me)
	head.Head(URL)
	head.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	head.GetRequest.SetHeader("Authorization","Bearer " & m_Supabase.Auth.TokenInformations.AccessToken)
	Wait For (head) JobDone (head As HttpJob)
	'Log(head.ErrorMessage)
	head.Release 'the actual content is not needed
	DatabaseError.Success = head.Success
	If head.Success Then
		Tracker.TotalLength = head.Response.ContentLength
		If Tracker.TotalLength = 0 Then Tracker.TotalLength = RangeDownloader_GetCaseInsensitiveHeaderValue(head, "content-length", "0")
'		Log(head.Response.GetHeaders.As(JSON).ToString)
		If RangeDownloader_GetCaseInsensitiveHeaderValue(head, "Accept-Ranges", "").As(String) <> "bytes" Then
			Log("SupabaseStorage: accept ranges not supported")
			Tracker.Completed = True
			DatabaseError.StatusCode = 400
			DatabaseError.ErrorMessage = "accept ranges not supported"
			Return StorageFile
		End If
	Else
		DatabaseError.StatusCode = head.Response.StatusCode
		DatabaseError.ErrorMessage = head.ErrorMessage
		Tracker.Completed = True
		Return StorageFile
	End If
	
	'Log("Total length: " & NumberFormat(Tracker.TotalLength, 0, 0))
	If File.Exists(Dir, FileName) Then
		Tracker.CurrentLength = File.Size(Dir, FileName)
	End If
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, True) 'append = true
	Do While Tracker.CurrentLength < Tracker.TotalLength
		Dim j As HttpJob
		j.Initialize("", Me)
		j.Download(URL)
		Dim range As String = $"bytes=${Tracker.CurrentLength}-${(Min(Tracker.TotalLength, Tracker.CurrentLength + 300 * 1024) - 1).As(Int)}"$
		'Log(range)
		j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
		j.GetRequest.SetHeader("Authorization","Bearer " & m_Supabase.Auth.TokenInformations.AccessToken)
		j.GetRequest.SetHeader("Range", range)
		Wait For (j) JobDone (j As HttpJob)
		DatabaseError.Success = j.Success
		Dim good As Boolean = j.Success
		If j.Success Then
			Wait For (File.Copy2Async(j.GetInputStream, out)) Complete (Success As Boolean)		
			
			#if B4A or B4J
			out.Flush
			#end if
			good = good 
		
				Tracker.CurrentLength = File.Size(Dir, FileName)

Else
			DatabaseError.StatusCode = j.Response.StatusCode
			DatabaseError.ErrorMessage = j.ErrorMessage

		End If
		j.Release
		If good = False Or Tracker.Cancel = True Then
			Tracker.Completed = True
			Return StorageFile
		End If
	Loop
	out.Close
	Tracker.Completed = True
	
	StorageFile.FileBody = File.ReadBytes(Dir,FileName)
	StorageFile.Error = DatabaseError
	Return StorageFile
End Sub

Private Sub RangeDownloader_GetCaseInsensitiveHeaderValue (job As HttpJob, Key As String, DefaultValue As String) As String
	Dim headers As Map = job.Response.GetHeaders
	For Each k As String In headers.Keys
		If K.EqualsIgnoreCase(Key) Then
			Return headers.Get(k).As(String).Replace("[", "").Replace("]", "").Trim
		End If
	Next
	Return DefaultValue
End Sub

#End Region


