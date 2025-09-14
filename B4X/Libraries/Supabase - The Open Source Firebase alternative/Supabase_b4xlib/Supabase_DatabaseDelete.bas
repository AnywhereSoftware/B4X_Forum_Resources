B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private m_Supabase As Supabase
	
	Private m_TableName As String
	Private m_WhereMap As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisSupabase As Supabase)
	m_Supabase = ThisSupabase
	m_WhereMap.Initialize
End Sub

Public Sub From(TableName As String) As Supabase_DatabaseDelete
	m_TableName = TableName
	Return Me
End Sub

Public Sub Eq(ColumnValue As Map) As Supabase_DatabaseDelete
	For Each key As String In ColumnValue.Keys
		m_WhereMap.Put(key,ColumnValue.Get(key))
	Next
	Return Me
End Sub

Public Sub Execute As ResumableSub
	
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Return DatabaseError
	End If
	
	Dim url As String = ""
	url = url & $"${m_Supabase.URL}/rest/v1/${m_TableName}?"$
	
	For Each key As String In m_WhereMap.Keys
		url = url & "&" & key & "=eq." & m_WhereMap.Get(key)
	Next

	Dim j As HttpJob : j.Initialize("",Me)
	j.Delete(url)
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	Return DatabaseError
	
End Sub