B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
Private Sub Class_Globals
	Private m_Supabase As Supabase
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisSupabase As Supabase)
	m_Supabase = ThisSupabase
End Sub

'***************************Bucket************************************************

'Creates a new Storage bucket
'Name - A unique identifier for the bucket you are creating
'<code>
'	Dim CreateBucket As Supabase_StorageBucket = xSupabase.Storage.CreateBucket("Avatar")
'	CreateBucket.Options_isPublic(False)
'	CreateBucket.Options_FileSizeLimit(1048576 )
'	CreateBucket.Options_AllowedMimeTypes(Array("image/png","image/jpg"))
'		Wait For (CreateBucket.Execute) Complete (Bucket As SupabaseStorageBucket)
'	If Bucket.Error.Success Then
'		Log($"Bucket ${Bucket.Name} successfully created "$)
'	Else
'		Log("Error: " & Bucket.Error.ErrorMessage)
'	End If
'</code>
Public Sub CreateBucket(Name As String) As Supabase_StorageBucket
	
	Dim StorageBucket As Supabase_StorageBucket
	StorageBucket.Initialize(m_Supabase,Name,"Create")
	Return StorageBucket
	
End Sub

'Retrieves the details of an existing Storage bucket.
'<code>
'	Dim GetBucket As Supabase_StorageBucket = xSupabase.Storage.GetBucket("Avatar")
'	Wait For (GetBucket.Execute) Complete (Bucket As SupabaseStorageBucket)
'	If Bucket.Error.Success Then
'		Log($"Bucket ${Bucket.Name} was created at ${DateUtils.TicksToString(Bucket.CreatedAt)}"$)
'	Else
'		Log("Error: " & Bucket.Error.ErrorMessage)
'	End If
'</code>
Public Sub GetBucket(Name As String) As Supabase_StorageBucket
	
	Dim StorageBucket As Supabase_StorageBucket
	StorageBucket.Initialize(m_Supabase,Name,"Select")
	Return StorageBucket
	
End Sub

'Updates a new Storage bucket
'<code>
'	Dim UpdateBucket As Supabase_StorageBucket = xSupabase.Storage.UpdateBucket("Avatar")
'	UpdateBucket.Options_isPublic(True)
'	UpdateBucket.Options_FileSizeLimit(1048576 )
'	UpdateBucket.Options_AllowedMimeTypes(Array("image/png"))
'	Wait For (UpdateBucket.Execute) Complete (Bucket As SupabaseStorageBucket)
'	If Bucket.Error.Success Then
'		Log($"Bucket ${Bucket.Name} successfully updated "$)
'	Else
'		Log("Error: " & Bucket.Error.ErrorMessage)
'	End If
'</code>
Public Sub UpdateBucket(Name As String) As Supabase_StorageBucket
	
	Dim StorageBucket As Supabase_StorageBucket
	StorageBucket.Initialize(m_Supabase,Name,"Update")
	Return StorageBucket
	
End Sub

'Deletes an existing bucket. A bucket can't be deleted with existing objects inside it. You must first empty() the bucket.
'<code>
'	Dim DelteBucket As Supabase_StorageBucket = xSupabase.Storage.DeleteBucket("Avatar")
'	Wait For (DelteBucket.Execute) Complete (Bucket As SupabaseStorageBucket)
'	If Bucket.Error.Success Then
'		Log($"Bucket ${Bucket.Name} successfully deleted "$)
'	Else
'		Log("Error: " & Bucket.Error.ErrorMessage)
'	End If
'</code>
Public Sub DeleteBucket(Name As String) As Supabase_StorageBucket
	
	Dim StorageBucket As Supabase_StorageBucket
	StorageBucket.Initialize(m_Supabase,Name,"Delete")
	Return StorageBucket
	
End Sub

'Removes all objects inside a single bucket.
'<code>
'	Wait For (xSupabase.Storage.EmptyBucket("Avatar").Execute) Complete (Bucket As SupabaseStorageBucket)
'	If Bucket.Error.Success Then
'		Log($"Bucket ${Bucket.Name} successfully cleared "$)
'	Else
'		Log("Error: " & Bucket.Error.ErrorMessage)
'	End If
'</code>
Public Sub EmptyBucket(Name As String) As Supabase_StorageBucket
	
	Dim StorageBucket As Supabase_StorageBucket
	StorageBucket.Initialize(m_Supabase,Name,"Empty")
	Return StorageBucket
	
End Sub

'***************************File************************************************

'Uploads a file to an existing bucket.
'<code>
'	Dim UploadFile As Supabase_StorageFile = xSupabase.Storage.UploadFile("Avatar","test.png")
'	UploadFile.FileBody(xSupabase.Storage.ConvertFile2Binary(File.DirAssets,"test.jpg"))
'	Wait For (UploadFile.Execute) Complete (StorageFile As SupabaseStorageFile)
'	If StorageFile.Error.Success Then
'		Log($"File ${"test.jpg"} successfully uploaded "$)
'	Else
'		Log("Error: " & StorageFile.Error.ErrorMessage)
'	End If
'</code>
Public Sub UploadFile(BucketName As String,Path As String) As Supabase_StorageFile
	
	Dim StorageFile As Supabase_StorageFile
	StorageFile.Initialize(m_Supabase,BucketName,"Upload")
	StorageFile.Path(Path)
	Return StorageFile
	
End Sub

'Downloads a file.
'<code>
'	Dim DownloadFile As Supabase_StorageFile = xSupabase.Storage.DownloadFile("Avatar","test.png")
'	Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)
'	If StorageFile.Error.Success Then
'		Log($"File ${"test.jpg"} successfully downloaded "$)
'		ImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))
'	Else
'		Log("Error: " & StorageFile.Error.ErrorMessage)
'	End If
'</code>
Public Sub DownloadFile(BucketName As String,Path As String) As Supabase_StorageFile
	
	Dim StorageFile As Supabase_StorageFile
	StorageFile.Initialize(m_Supabase,BucketName,"Download")
	StorageFile.Path(Path)
	Return StorageFile
	
End Sub

'<code>
'	xui.SetDataFolder("supabase")
'	Dim DownloadFile As Supabase_StorageFile = xSupabase.Storage.DownloadFileProgress("Avatar","test.png",Me,"DownloadProfileImage",xui.DefaultFolder)
'	Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)
'	If StorageFile.Error.Success Then
'		Log($"File ${"test.jpg"} successfully downloaded "$)
'		B4XImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))
'		If File.Exists(xui.DefaultFolder,"test.png") Then File.Delete(xui.DefaultFolder,"test.png") 'Clean the download path, or do what ever you want
'	Else
'		Log("Error: " & StorageFile.Error.ErrorMessage)
'	End If
'
'Private Sub DownloadProfileImage_RangeDownloadTracker(Tracker As SupabaseRangeDownloadTracker)
'	Log($"$1.2{Tracker.CurrentLength / 1024 / 1024}MB / $1.2{Tracker.TotalLength / 1024 / 1024}MB"$)
'	AnotherProgressBar1.Value = Tracker.CurrentLength / Tracker.TotalLength * 100
'End Sub
'</code>
Public Sub DownloadFileProgress(BucketName As String,Path As String,EventCallback As Object, EventName As String,DownloadPath As String) As Supabase_StorageFile
	
	Dim StorageFile As Supabase_StorageFile
	StorageFile.Initialize(m_Supabase,BucketName,"DownloadProgress")
	StorageFile.Path(Path)
	StorageFile.Tag = CreateMap("EventCallback":EventCallback,"EventName":EventName,"DownloadPath":DownloadPath)
	Return StorageFile
	
End Sub

'Replaces an existing file at the specified path with a new one.
'<code>
'	Dim UpdateFile As Supabase_StorageFile = xSupabase.Storage.UpdateFile("Avatar","test.png")
'	UpdateFile.FileBody(xSupabase.Storage.ConvertFile2Binary(File.DirAssets,"test2.jpg"))
'	Wait For (UpdateFile.Execute) Complete (StorageFile As SupabaseStorageFile)
'	If StorageFile.Error.Success Then
'		Log($"File ${"test.jpg"} successfully updated "$)
'	Else
'		Log("Error: " & StorageFile.Error.ErrorMessage)
'	End If
'</code>
Public Sub UpdateFile(BucketName As String,Path As String) As Supabase_StorageFile
	
	Dim StorageFile As Supabase_StorageFile
	StorageFile.Initialize(m_Supabase,BucketName,"Update")
	StorageFile.Path(Path)
	Return StorageFile
	
End Sub

'Deletes files within the same bucket

'Public Sub DeleteFile(BucketName As String) As Supabase_StorageFile
'	
'	Dim StorageFile As Supabase_StorageFile
'	StorageFile.Initialize(m_Supabase,BucketName,"Delete")
'	Return StorageFile
'	
'End Sub

'Moves an existing file to a new path in the same bucket.
'FromPath - The original file path, including the current file name. For example `folder/image.png`
'ToPath - The new file path, including the new file name. For example `folder/image-copy.png`
'<code>
'	Wait For (xSupabase.Storage.MoveFile("Avatar","public/avatar1.png", "private/avatar2.png").Execute) Complete (StorageFile As SupabaseStorageFile)
'	If StorageFile.Error.Success Then
'		Log($"Files successfully moved "$)
'	Else
'		Log("Error: " & StorageFile.Error.ErrorMessage)
'	End If
'</code>
Public Sub MoveFile(BucketName As String,FromPath As String,ToPath As String,DestinationBucket As String) As Supabase_StorageFile
	
	Dim StorageFile As Supabase_StorageFile
	StorageFile.Initialize(m_Supabase,BucketName,"MovePath")
	StorageFile.MoveFile(FromPath,ToPath,DestinationBucket)
	Return StorageFile
	
End Sub

'Copies an existing file to a new path in the same bucket.
'FromPath - The original file path, including the current file name. For example `folder/image.png`
'ToPath - The new file path, including the new file name. For example `folder/image-copy.png`
'<code>
'	Wait For (xSupabase.Storage.CopyFile("Avatar","public/avatar1.png", "private/avatar2.png").Execute) Complete (StorageFile As SupabaseStorageFile)
'	If StorageFile.Error.Success Then
'		Log($"Files successfully copied "$)
'	Else
'		Log("Error: " & StorageFile.Error.ErrorMessage)
'	End If
'</code>
Public Sub CopyFile(BucketName As String,FromPath As String,ToPath As String,DestinationBucket As String) As Supabase_StorageFile
	
	Dim StorageFile As Supabase_StorageFile
	StorageFile.Initialize(m_Supabase,BucketName,"CopyPath")
	StorageFile.CopyFile(FromPath,ToPath,DestinationBucket)
	Return StorageFile
	
End Sub

'Retrieve public URL
'A simple convenience function to get the URL for an asset in a public bucket. If you do not want to use this function, you can construct the public URL by concatenating the bucket URL with the path to the asset.
'This function does not verify if the bucket is public. If a public URL is created for a bucket which is not public, you will not be able to download the asset.
'<code>Log(xSupabase.Storage.GetPublicUrl("Avatar","test.png"))</code>
Public Sub GetPublicUrl(BucketName As String,Path As String) As String
	
	Return $"${m_Supabase.URL}/storage/v1/object/public/${BucketName}/${Path}"$
	
End Sub

'Create signed url to download file without requiring permissions. This URL can be valid for a set number of seconds.
'<code>
'	Wait For (xSupabase.Storage.CreateSignedUrl("Avatar","test.png",60).Execute) Complete (StorageFile As SupabaseStorageFile)
'	If StorageFile.Error.Success Then
'		Log(StorageFile.SignedURL)
'		
'		Dim DownloadFile As Supabase_StorageFile = xSupabase.Storage.DownloadFile("Avatar")
'		DownloadFile.Path("test.png")
'		DownloadFile.SignedURL(StorageFile.SignedURL)
'		Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)
'		If StorageFile.Error.Success Then
'			Log($"File from signed URL successfully downloaded "$)
'			ImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))
'		Else
'			Log("Error: " & StorageFile.Error.ErrorMessage)
'		End If
'		
'	Else
'		Log("Error: " & StorageFile.Error.ErrorMessage)
'	End If
'</code>
Public Sub CreateSignedUrl(BucketName As String,Path As String,ExpiresInSeconds As Int) As Supabase_StorageFile
	
	Dim StorageFile As Supabase_StorageFile
	StorageFile.Initialize(m_Supabase,BucketName,"CreateSignedUrl")
	StorageFile.Path(Path)
	StorageFile.ExpiresInSeconds(ExpiresInSeconds)
	Return StorageFile
	
End Sub

#Region Functions

Public Sub ConvertFile2Binary(Dir As String, FileName As String) As Byte()
	Return Bit.InputStreamToBytes(File.OpenInput(Dir, FileName))
End Sub

#If B4A OR B4I OR UI
Public Sub BytesToImage(bytes() As Byte) As B4XBitmap
	Dim In As InputStream
	In.InitializeFromBytesArray(bytes, 0, bytes.Length)
#if B4A or B4i
   Dim bmp As Bitmap
   bmp.Initialize2(In)
   Return bmp
#else
	Dim bmp As Image
	bmp.Initialize2(In)
	Return bmp
#end if
End Sub

#End Region
#End If
