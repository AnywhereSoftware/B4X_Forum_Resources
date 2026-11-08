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

'https://pocketbase.io/docs/api-crons/

'Returns list with all registered app level cron jobs.
'Only superusers can perform this action.
'<code>
'	Wait For (xPocketbase.Admin.Crons.GetFullList("")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub GetFullList(Fields As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseSelect = m_Pocketbase.Database.SelectData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","crons")

	If Fields <> "" Then AdminRequest.Parameter_Fields(Fields)

	Wait For (AdminRequest.GetCustom) Complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub

'Triggers a single cron job by its id.
'Only superusers can perform this action.
'<code>
'	Wait For (xPocketbase.Admin.Crons.Run("__pbDBOptimize__")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	Log(DatabaseResult.Error.StatusCode)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub Run(JobId As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseInsert = m_Pocketbase.Database.InsertData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","crons")
	CallSub2(AdminRequest,"SetCustomParameters","/" & JobId)
	
	Wait For (AdminRequest.Insert(CreateMap()).Execute) Complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub