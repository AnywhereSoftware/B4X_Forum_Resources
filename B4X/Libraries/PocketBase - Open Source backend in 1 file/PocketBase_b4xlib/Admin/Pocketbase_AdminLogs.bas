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

'Returns a paginated logs list.
'Only superusers can perform this action.
'<code>
'	Wait For (xPocketbase.Admin.Logs.GetList(0,20,"","")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub GetList(Page As Int, PerPage As Int, Filter As String,Fields As String) As ResumableSub

	Dim AdminRequest As Pocketbase_DatabaseSelect = m_Pocketbase.Database.SelectData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","logs")

	If Fields <> "" Then AdminRequest.Parameter_Fields(Fields)

	Wait For (AdminRequest.GetList(Page,PerPage,Filter)) complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub

'Returns a single log by its ID.
'Only superusers can perform this action.
'<code>
'	Wait For (xPocketbase.Admin.Logs.GetOne("ea54zev6hs7sp2p","")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub GetOne(RecordID As String,Fields As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseSelect = m_Pocketbase.Database.SelectData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","logs")

	If Fields <> "" Then AdminRequest.Parameter_Fields(Fields)

	Wait For (AdminRequest.GetOne(RecordID)) complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub

'Returns hourly aggregated logs statistics.
'Only superusers can perform this action.
'<code>
'	Wait For (xPocketbase.Admin.Logs.GetStats("","")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub GetStats(Filter As String,Fields As String) As ResumableSub
	
	Dim AdminRequest As Pocketbase_DatabaseSelect = m_Pocketbase.Database.SelectData.Collection("")
	CallSub2(AdminRequest,"SetApiEndpoint","logs/stats")

	AdminRequest.Parameter_PerPage(30)
	If Fields <> "" Then AdminRequest.Parameter_Fields(Fields)
	If Filter <> "" Then AdminRequest.Parameter_Filter(Filter)

	Wait For (AdminRequest.GetCustom) complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
	
End Sub