B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private m_Supabase As Supabase
	
	Private m_TableName As String
	Private m_lstColumnValue As List
	Private m_Upsert As Boolean = False
	Private m_Select As Boolean = False
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisSupabase As Supabase)
	m_Supabase = ThisSupabase
	m_lstColumnValue.Initialize
End Sub

Public Sub From(TableName As String) As Supabase_DatabaseInsert
	m_TableName = TableName
	Return Me
End Sub

'Insert one row
'<code>Dim InsertMap As Map = CreateMap("Tasks_Name":"Task 01","Tasks_Checked":True,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now))</code>
Public Sub Insert(ColumnValue As Map) As Supabase_DatabaseInsert
	m_lstColumnValue.Add(ColumnValue)
	Return Me
End Sub

'Insert many rows
'<code>	Dim lst_BulkInsert As List
'lst_BulkInsert.Initialize	
'lst_BulkInsert.Add(CreateMap("Tasks_Name":"Task 01","Tasks_Checked":True,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now)))
'lst_BulkInsert.Add(CreateMap("Tasks_Name":"Task 02","Tasks_Checked":False,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now)))
'</code>
Public Sub InsertBulk(ColumnValueList As List) As Supabase_DatabaseInsert
	m_lstColumnValue.Add(ColumnValueList)
	Return Me
End Sub

'Upserting is an operation that performs both: Inserting a new row if a matching row doesn't already exist. Either updating the existing row, or doing nothing, if a matching row already exists.
Public Sub Upsert As Supabase_DatabaseInsert
	m_Upsert = True
	Return Me
End Sub

Public Sub SelectData As Supabase_DatabaseInsert
	m_Select = True
	Return Me
End Sub

Public Sub Execute As ResumableSub
	
	Dim DatabaseResult As SupabaseDatabaseResult
	DatabaseResult.Initialize
	DatabaseResult.Columns.Initialize
	DatabaseResult.Rows.Initialize
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		DatabaseResult.Error = DatabaseError
		Return DatabaseResult
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/rest/v1/${m_TableName}"$
		
	Dim jsn As JSONGenerator
	jsn.Initialize2(m_lstColumnValue)
	'Log(jsn.ToString)
	Dim InsertJson As String = jsn.ToString
	'Log(InsertJson.SubString2(1,InsertJson.Length -1))

	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,InsertJson.SubString2(1,InsertJson.Length -1))
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	If m_Upsert Or m_Select Then
		
		If m_Upsert And m_Select Then
			j.GetRequest.SetHeader("Prefer","return=representation, resolution=merge-duplicates")
		Else
			If m_Upsert Then
				j.GetRequest.SetHeader("Prefer","resolution=merge-duplicates")
			Else If m_Select Then
				j.GetRequest.SetHeader("Prefer","return=representation")
			End If
		End If
		
	Else
		j.GetRequest.SetHeader("Prefer","return=minimal")
	End If
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
		If m_Select Then
			DatabaseResult = Supabase_Functions.CreateDatabaseResult(j.GetString)
		End If
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	DatabaseResult.Error = DatabaseError
	Return DatabaseResult
	
End Sub