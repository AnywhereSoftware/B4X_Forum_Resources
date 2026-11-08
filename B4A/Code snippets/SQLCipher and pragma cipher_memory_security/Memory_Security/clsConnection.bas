B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.8
@EndOfDesignText@
Sub Class_Globals
	
	Public SQLEncrypted As SQLCipher
	Public SQLUnEncrypted As SQLCipher
	
	Private bEncryptedDBExisted As Boolean
	Private bUnEncryptedDBExisted As Boolean
	
	Public strDBFolder As String = File.DirInternal
	Public strDBNameEncrypted As String = "DB_Encrypted.db3"
	Public strDBNameUnEncrypted As String = "DB_UnEncrypted.db3"
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	bEncryptedDBExisted = File.Exists(strDBFolder, strDBNameEncrypted)
	bUnEncryptedDBExisted = File.Exists(strDBFolder, strDBNameUnEncrypted)
	
	SQLEncrypted.Initialize(strDBFolder, strDBNameEncrypted, bEncryptedDBExisted = False, "abc", "")
	SQLUnEncrypted.Initialize(strDBFolder, strDBNameUnEncrypted, bUnEncryptedDBExisted = False, "", "")
	
End Sub

Public Sub TableExists(strDBName As String, strTable As String) As Boolean
	
	Dim iResult As Int
	
	If strDBName = strDBNameEncrypted Then
		iResult = SQLEncrypted.ExecQuerySingleResult2("select coalesce(max(1), 0) from sqlite_master where type = 'table' and lower(name) = ?", _
													  Array As String(strTable.ToLowerCase))
	Else
		iResult = SQLUnEncrypted.ExecQuerySingleResult2("select coalesce(max(1), 0) from sqlite_master where type = 'table' and lower(name) = ?", _
													  Array As String(strTable.ToLowerCase))
	End If
	
	Return iResult = 1
	
End Sub