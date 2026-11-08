B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private m_Supabase As Supabase
	
	Private m_Mode As String
	
	Private m_BucketName As String
	Private m_AllowedMimeTypes() As Object
	Private m_FileSizeLimit As Int
	Private m_isPublic As Boolean
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
'Name - A unique identifier for the bucket
Public Sub Initialize(ThisSupabase As Supabase,Name As String,Mode As String)
	m_Supabase = ThisSupabase
	m_BucketName = Name
	m_Mode = Mode
End Sub

'The visibility of the bucket. Public buckets don't require an authorization token to download objects, but still require a valid token for all other operations. By default, buckets are private.
Public Sub Options_isPublic(isPublic As Boolean) As Supabase_StorageBucket
	m_isPublic = isPublic
	Return Me
End Sub

'specifies the max file size in bytes that can be uploaded to this bucket. The global file size limit takes precedence over this value. The default value is null, which doesn't set a per bucket file size limit.
'The Limit is in bytes

Public Sub Options_FileSizeLimit(Limit As Int) As Supabase_StorageBucket
	m_FileSizeLimit = Limit
	Return Me
End Sub

'specifies the allowed mime types that this bucket can accept during upload. The default value is null, which allows files with all mime types to be uploaded. Each mime type specified can be a wildcard, e.g. image/*, or a specific mime type, e.g. image/png.
Public Sub Options_AllowedMimeTypes(MimeTypes() As Object) As Supabase_StorageBucket
	m_AllowedMimeTypes = MimeTypes
	Return Me
End Sub

Public Sub Execute As ResumableSub
	
	If m_Mode = "Create" Then
		
		Wait For (CreateBucket) Complete (Result As SupabaseStorageBucket)
		Return Result
		
	else If m_Mode = "Select" Then
		
		Wait For (GetBucket) Complete (Result As SupabaseStorageBucket)
		Return Result
		
	else If m_Mode = "Update" Then
		
		Wait For (UpdateBucket) Complete (Result As SupabaseStorageBucket)
		Return Result
		
	else If m_Mode = "Delete" Then
		
		Wait For (DeleteBucket) Complete (Result As SupabaseStorageBucket)
		Return Result
		
	else If m_Mode = "Empty" Then
		
		Wait For (EmptyBucket) Complete (Result As SupabaseStorageBucket)
		Return Result
		
		Else
			
		Dim Bucket As SupabaseStorageBucket
		Bucket.Initialize
		Dim DatabaseError As SupabaseError
		DatabaseError.Initialize
		DatabaseError.Success = False
		DatabaseError.ErrorMessage = "unknown mode"
		Bucket.Error = DatabaseError	
		Return Bucket
	End If
	
End Sub

Private Sub GetBucket As ResumableSub
	
	Dim Bucket As SupabaseStorageBucket
	Bucket.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Bucket.Error = DatabaseError
		Return Bucket
	End If

	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/bucket/${m_BucketName}"$

	'Log(url)
	Dim j As HttpJob : j.Initialize("",Me)
	j.Download(url)
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
		'Log(j.GetString)
		Dim parser As JSONParser
		parser.Initialize(j.GetString)
		Dim jRoot As Map = parser.NextObject
		
		Bucket.Owner = jRoot.Get("owner")
		Bucket.FileSizeLimit = jRoot.Get("file_size_limit")
		Bucket.isPublic = jRoot.Get("public")
		Bucket.UpdatedAt= Supabase_Functions.ParseDateTime(jRoot.Get("updated_at"))
		Bucket.Name = jRoot.Get("name")
		Bucket.CreatedAt = Supabase_Functions.ParseDateTime(jRoot.Get("created_at"))
		Bucket.Id = jRoot.Get("id")
		Bucket.AllowedMimeTypes = jRoot.Get("allowed_mime_types")
		
		Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage	
	End If
	
	Bucket.Error = DatabaseError
	
	Return Bucket
	
End Sub

Private Sub CreateBucket As ResumableSub
	
	Dim Bucket As SupabaseStorageBucket
	Bucket.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Bucket.Error = DatabaseError
		Return Bucket
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/bucket"$
		
	Dim jsn As JSONGenerator
	
	Dim m_Request As Map
	m_Request.Initialize
	m_Request.Put("name",m_BucketName)
	m_Request.Put("public",m_isPublic)
	m_Request.Put("file_size_limit",m_FileSizeLimit)
	m_Request.Put("allowed_mime_types",m_AllowedMimeTypes)
	
	jsn.Initialize(m_Request)
	'Log(jsn.ToString)

	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,jsn.ToString.Replace("\",""))
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	Bucket.Name = m_BucketName
	Bucket.Id = m_BucketName
	Bucket.isPublic = m_isPublic
	Bucket.FileSizeLimit = m_FileSizeLimit
	Bucket.CreatedAt = DateTime.Now
	Bucket.UpdatedAt = DateTime.Now
	
	Wait For (m_Supabase.Auth.GetUser) Complete (User As SupabaseUser)
	Bucket.Owner = User.id

	Bucket.Error = DatabaseError
	Return Bucket
	
End Sub

Private Sub UpdateBucket As ResumableSub
	
	Dim Bucket As SupabaseStorageBucket
	Bucket.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Bucket.Error = DatabaseError
		Return Bucket
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/bucket/${m_BucketName}"$
		
	Dim jsn As JSONGenerator
	
	Dim m_Request As Map
	m_Request.Initialize
	m_Request.Put("public",m_isPublic)
	m_Request.Put("file_size_limit",m_FileSizeLimit)
	m_Request.Put("allowed_mime_types",m_AllowedMimeTypes)
	
	jsn.Initialize(m_Request)
	'Log(jsn.ToString)

	Dim j As HttpJob : j.Initialize("",Me)
	j.PutString(url,jsn.ToString.Replace("\",""))
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	Bucket.Name = m_BucketName
	Bucket.Id = m_BucketName
	Bucket.isPublic = m_isPublic
	Bucket.FileSizeLimit = m_FileSizeLimit
	Bucket.UpdatedAt = DateTime.Now

	Bucket.Error = DatabaseError
	Return Bucket
	
End Sub

Private Sub DeleteBucket As ResumableSub
	
	Dim Bucket As SupabaseStorageBucket
	Bucket.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Bucket.Error = DatabaseError
		Return Bucket
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/bucket/${m_BucketName}"$

	Dim j As HttpJob : j.Initialize("",Me)
	j.Delete(url)
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	Bucket.Name = m_BucketName

	Bucket.Error = DatabaseError
	Return Bucket
	
End Sub

Private Sub EmptyBucket As ResumableSub
	
	Dim Bucket As SupabaseStorageBucket
	Bucket.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Bucket.Error = DatabaseError
		Return Bucket
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/storage/v1/bucket/${m_BucketName}/empty"$

	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,"")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	Bucket.Name = m_BucketName

	Bucket.Error = DatabaseError
	Return Bucket
	
End Sub