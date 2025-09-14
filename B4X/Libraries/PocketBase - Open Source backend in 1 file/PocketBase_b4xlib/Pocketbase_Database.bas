B4J=true
Group=Default Group
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

'<code>
'	Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetList(0,2,"")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub SelectData As Pocketbase_DatabaseSelect
	
	Dim DatabaseSelect As Pocketbase_DatabaseSelect
	DatabaseSelect.Initialize(m_Pocketbase)
	Return DatabaseSelect
	
End Sub

'<code>
'	Dim Insert As Pocketbase_DatabaseInsert = xPocketbase.Database.InsertData.Collection("dt_Task")
'	Insert.Parameter_Fields("Task_Name,Task_CompletedAt")
'	Dim InsertMap As Map = CreateMap("Task_UserId":xPocketbase.Auth.TokenInformations.Id,"Task_Name":"Task 01","Task_CompletedAt":Pocketbase_Functions.GetISO8601UTC(DateTime.Now))
'	Wait For (Insert.Insert(InsertMap).Execute) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub InsertData As Pocketbase_DatabaseInsert
	
	Dim DatabaseInsert As Pocketbase_DatabaseInsert
	DatabaseInsert.Initialize(m_Pocketbase)
	Return DatabaseInsert
	
End Sub

'<code>
'	Dim UpdateRecord As Pocketbase_DatabaseUpdate = xPocketbase.Database.UpdateData.Collection("dt_Task")
'	UpdateRecord.Parameter_Fields("Task_Name,Task_CompletedAt")
'	UpdateRecord.Update(CreateMap("Task_Name":"Task 02"))
'	Wait For (UpdateRecord.Execute("77avq8zn44ck37m")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)
'</code>
Public Sub UpdateData As Pocketbase_DatabaseUpdate
	
	Dim DatabaseUpdate As Pocketbase_DatabaseUpdate
	DatabaseUpdate.Initialize(m_Pocketbase)
	Return DatabaseUpdate
	
End Sub

'Delete a single collection record
'<code>Wait For (xPocketbase.Database.DeleteData.Collection("dt_Task").Execute("43r7071wtp30l5h")) Complete (Result As PocketbaseError)</code>
Public Sub DeleteData As Pocketbase_DatabaseDelete
	
	Dim DatabaseDelete As Pocketbase_DatabaseDelete
	DatabaseDelete.Initialize(m_Pocketbase)
	Return DatabaseDelete
	
End Sub

Public Sub PrintTable(Table As PocketbaseDatabaseResult)
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