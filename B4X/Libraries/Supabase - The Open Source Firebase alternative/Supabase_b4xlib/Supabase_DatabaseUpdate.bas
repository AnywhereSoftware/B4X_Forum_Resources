B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private m_Supabase As Supabase
	
	Private m_TableName As String
	Private m_ColumnValue As Map
	Private m_WhereMap As Map
	Private m_Select As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisSupabase As Supabase)
	m_Supabase = ThisSupabase
	m_WhereMap.Initialize
	
End Sub

Public Sub From(TableName As String) As Supabase_DatabaseUpdate
	m_TableName = TableName
	Return Me
End Sub

Public Sub Update(ColumnValue As Map) As Supabase_DatabaseUpdate
	m_ColumnValue = ColumnValue
	Return Me
End Sub

Public Sub SelectData As Supabase_DatabaseUpdate
	m_Select = True
	Return Me
End Sub

Public Sub Eq(ColumnValue As Map) As Supabase_DatabaseUpdate
	For Each key As String In ColumnValue.Keys
		m_WhereMap.Put(key,ColumnValue.Get(key))
	Next
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
	url = url & $"${m_Supabase.URL}/rest/v1/${m_TableName}?"$
	
	For Each key As String In m_WhereMap.Keys
		url = url & "&" & key & "=eq." & m_WhereMap.Get(key)
	Next
		
	Dim jsn As JSONGenerator
	jsn.Initialize(m_ColumnValue)
	'Log(jsn.ToString)

	Dim j As HttpJob : j.Initialize("",Me)
	j.PatchString(url,jsn.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	If m_Select Then
		j.GetRequest.SetHeader("Prefer","return=representation")
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