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

'<code>
'	Dim Query As Supabase_DatabaseSelect = xSupabase.Database.SelectData
'	Query.Columns("*").From("dt_Tasks")
'	Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)
'	xSupabase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub SelectData As Supabase_DatabaseSelect
	
	Dim DatabaseSelect As Supabase_DatabaseSelect
	DatabaseSelect.Initialize(m_Supabase)
	Return DatabaseSelect
	
End Sub

'<code>
'	Dim CallFunction As Supabase_DatabaseRpc = xSupabase.Database.CallFunction
'	CallFunction.Rpc("hello_world")
'	Wait For (CallFunction.Execute) Complete (RpcResult As SupabaseRpcResult)
'	If RpcResult.Error.Success Then
'		Log(RpcResult.Data)
'	End If
'</code>
Public Sub CallFunction As Supabase_DatabaseRpc
	
	Dim DatabaseRpc As Supabase_DatabaseRpc
	DatabaseRpc.Initialize(m_Supabase)
	Return DatabaseRpc
	
End Sub

'One Row:
'<code>
	'Dim Insert As Supabase_DatabaseInsert = xSupabase.Database.InsertData
	'Insert.From("dt_Tasks")
	'Dim InsertMap As Map = CreateMap("Tasks_Name":"Task 07","Tasks_Checked":False,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks_UpdatedAt":DateUtils.TicksToString(DateTime.Now))
	'Wait For (Insert.Insert(InsertMap).Upsert.Execute) Complete (Result As SupabaseDatabaseResult)
'</code>
'Bulk Insert:
'<code>
'	Dim Insert As Supabase_DatabaseInsert = xSupabase.Database.InsertData
'	Insert.From("dt_Tasks")	
'	Dim lst_BulkInsert As List
'	lst_BulkInsert.Initialize
'	lst_BulkInsert.Add(CreateMap("Tasks_Name":"Task 05","Tasks_Checked":True,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks_UpdatedAt":DateUtils.TicksToString(DateTime.Now)))
'	lst_BulkInsert.Add(CreateMap("Tasks_Name":"Task 06","Tasks_Checked":True,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks_UpdatedAt":DateUtils.TicksToString(DateTime.Now)))
'	Wait For (Insert.InsertBulk(lst_BulkInsert).Execute) Complete (Result As SupabaseDatabaseResult)
'</code>
Public Sub InsertData As Supabase_DatabaseInsert
	
	Dim DatabaseInsert As Supabase_DatabaseInsert
	DatabaseInsert.Initialize(m_Supabase)
	Return DatabaseInsert
	
End Sub

'<code>
'	Dim Update As Supabase_DatabaseUpdate = xSupabase.Database.UpdateData
'	Update.From("dt_Tasks")
'	Update.Update(CreateMap("Tasks_Name":"Task 08"))
'	Update.Eq(CreateMap("Tasks_Id":15))
'	Wait For (Update.Execute) Complete (Result As SupabaseDatabaseResult)
'</code>
Public Sub UpdateData As Supabase_DatabaseUpdate
	
	Dim DatabaseUpdate As Supabase_DatabaseUpdate
	DatabaseUpdate.Initialize(m_Supabase)
	Return DatabaseUpdate
	
End Sub

'<code>
'	Dim Delete As Supabase_DatabaseDelete = xSupabase.Database.DeleteData
'	Delete.From("dt_Tasks")
'	Delete.Eq(CreateMap("Tasks_Id":15))	
'	Wait For (Delete.Execute) Complete (Result As SupabaseError)
'</code>
Public Sub DeleteData As Supabase_DatabaseDelete
	
	Dim DatabaseDelete As Supabase_DatabaseDelete
	DatabaseDelete.Initialize(m_Supabase)
	Return DatabaseDelete
	
End Sub

Public Sub PrintTable(Table As SupabaseDatabaseResult)
	Log("Tag: " & Table.Tag & ", Columns: " & Table.Columns.Size & ", Rows: " & Table.Rows.Size)
	Dim sb As StringBuilder
	sb.Initialize
	
	For Each key As String In Table.Columns.Keys
		sb.Append(key).Append(TAB)
	Next
	
	Log(sb.ToString)
	For Each row As Map In Table.Rows
		Dim sb As StringBuilder
		sb.Initialize
			
		For Each key As String In row.Keys
			sb.Append(row.Get(key)).Append(TAB)
		Next

		Log(sb.ToString)
	Next
End Sub
