B4J=true
Group=Admin
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private m_Pocketbase As Pocketbase
End Sub

'Only superusers have access to these features
Public Sub Initialize(ThisPocketbase As Pocketbase)
	m_Pocketbase = ThisPocketbase
End Sub

'Authenticate as superuser
'<code>
'	Wait For (xPocketbase.Admin.AuthWithPassword("test@example.com","xxx")) Complete (User As PocketbaseUser) 'Superuser
'	If User.Error.Success Then
'		Log("successfully logged as superuser with " & User.Email)
'	Else
'		Log("Error: " & User.Error.ErrorMessage)
'	End If
'</code>
Public Sub AuthWithPassword(Email As String,Password As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_Authentication = m_Pocketbase.Auth
	AdminRequest.UserCollectionName = "_superusers"
	Wait For (AdminRequest.AuthWithPassword(Email,Password)) Complete (User As PocketbaseUser)
	Return User
	
End Sub

'<code>https://pocketbase.io/docs/api-backups/</code>
Public Sub Backups As Pocketbase_AdminBackups
	
	Dim AdminBackups As Pocketbase_AdminBackups
	AdminBackups.Initialize(m_Pocketbase)
	Return AdminBackups
	
End Sub

'<code>https://pocketbase.io/docs/api-crons/</code>
Public Sub Crons As Pocketbase_AdminCrons
	
	Dim AdminCrons As Pocketbase_AdminCrons
	AdminCrons.Initialize(m_Pocketbase)
	Return AdminCrons
	
End Sub


'<code>https://pocketbase.io/docs/api-logs/</code>
Public Sub Logs As Pocketbase_AdminLogs
	
	Dim AdminLogs As Pocketbase_AdminLogs
	AdminLogs.Initialize(m_Pocketbase)
	Return AdminLogs
	
End Sub

