B4J=true
Group=Admin
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private m_Pocketbase As Pocketbase
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisPocketbase As Pocketbase)
	m_Pocketbase = ThisPocketbase
End Sub

'https://pocketbase.io/docs/api-backups/

'Returns list with all available backup files.
'Only superusers can perform this action.
'<code>	Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetFullList("-Task_Name")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)</code>
Public Sub GetFullList(Fields As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseSelect = m_Pocketbase.Database.SelectData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","backups")

	If Fields <> "" Then AdminRequest.Parameter_Fields(Fields)

	Wait For (AdminRequest.GetCustom) Complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub

'Creates a new app data backup.
'This action will return an error if there is another backup/restore operation already in progress.
'Only superusers can perform this action.
'Name - Optional
'The base name of the backup file to create.
'Must be in the format [a-z0-9_-].zip
'If Not set, it will be auto generated.
'<code>
'	Wait For (xPocketbase.Admin.Backups.Create("backup_b4x.zip")) Complete (DatabaseResult As PocketbaseDatabaseResult) 'Name is optional
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub Create(Name As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseInsert = m_Pocketbase.Database.InsertData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","backups")
	
	Dim InsertMap As Map
	If Name = "" Then
		InsertMap.Initialize
	Else
		InsertMap = CreateMap("name":Name)
	End If
	
	Wait For (AdminRequest.Insert(InsertMap).Execute) Complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub

'Uploads an existing backup zip file.
'Only superusers can perform this action.
'ZipFile - The zip archive to upload
'<code>
'	Wait For (xPocketbase.Admin.Backups.Upload(Pocketbase_Functions.ConvertFile2Binary(File.DirAssets,"mybackupfile.zip"))) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub Upload(ZipFile() As Byte) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseInsert = m_Pocketbase.Database.InsertData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","backups")
	
	Wait For (AdminRequest.Insert(CreateMap("file":ZipFile)).Execute) Complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub

'Deletes a single backup by its name.
'This action will return an error if the backup to delete is still being generated or part of a restore operation.
'Only superusers can perform this action.
'Key - The key of the backup file to delete
'<code>
'	Wait For (xPocketbase.Admin.Backups.Delete("pb_backup_acme_20250217182816.zip")) Complete (Result As PocketbaseError)
'	If Result.Success Then
'		Log("Backupfile deleted")
'	Else
'		Log(Result.ErrorMessage)
'	End If
'</code>
Public Sub Delete(Key As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseDelete = m_Pocketbase.Database.DeleteData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","backups")
	
	Wait For (AdminRequest.Execute(Key)) Complete (Result As PocketbaseError)
	Return Result
	
End Sub

'Restore a single backup by its name and restarts the current running PocketBase process.
'This action will return an error if there is another backup/restore operation already in progress.
'Only superusers can perform this action.
'Key - The key of the backup file to restore
'<code>
'	Wait For (xPocketbase.Admin.Backups.Restore("pb_backup_acme_20250217182537.zip")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	Log(DatabaseResult.Error.StatusCode)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub Restore(Key As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseInsert = m_Pocketbase.Database.InsertData.Collection(Key & "/restore")
	CallSub2(AdminRequest,"SetApiEndpoint","backups")
	
	Wait For (AdminRequest.Insert(CreateMap()).Execute) Complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub

'Downloads a single backup file.
'Only superusers can perform this action.
'Token - Superuser file token for granting access to the backup file
'Key - The key of the backup file to restore
'<code>
'	xui.SetDataFolder("B4J Pocketbase")
'
'	Wait For (xPocketbase.Storage.GetToken) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	If DatabaseResult.Error.Success Then
'		Dim AccessToken As String = DatabaseResult.Rows.Get(0).As(Map).Get("token")
'		Wait For (xPocketbase.Admin.Backups.Download(AccessToken,"pb_backup_acme_20250217182537.zip")) Complete (StorageFile As PocketbaseStorageFile)
'		If StorageFile.Error.Success Then
'			File.WriteBytes(xui.DefaultFolder, "Pocketbase_Backup.zip", StorageFile.FileBody)
'		Else
'			Log("Error on download (" & DatabaseResult.Error.ErrorMessage & ")")
'		End If
'
'	Else
'		Log("Failed to generate file token (" & DatabaseResult.Error.ErrorMessage & ")")
'	End If
'</code>
Public Sub Download(Token As String,Key As String) As ResumableSub
		
	Dim AdminRequest As Pocketbase_Storage = m_Pocketbase.Storage
	CallSub2(AdminRequest,"SetApiEndpoint","backups")
	
	Wait For (AdminRequest.DownloadFile("","token=" & Token,Key)) Complete (StorageFile As PocketbaseStorageFile)
	Return StorageFile
	
End Sub