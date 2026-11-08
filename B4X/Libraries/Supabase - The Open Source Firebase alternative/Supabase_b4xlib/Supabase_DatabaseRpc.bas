B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	
	Private m_Supabase As Supabase
	
	Private m_ParamValue As Map
	Private m_WhereList As List
	Private m_OrderBy As String
	Private m_Range As String
	Private m_Limit As Int = 0
	Private m_Offset As Int
	Private m_FunctionName As String
	
	Private str As StringUtils
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisSupabase As Supabase)
	m_Supabase = ThisSupabase
	m_WhereList.Initialize
	m_ParamValue.Initialize
End Sub

'Perform a function call.
'You can call Postgres functions As Remote Procedure Calls, logic in your database that you can Execute From anywhere.
'Functions are useful when the logic rarely changes—like For password resets And updates.
Public Sub Rpc(FunctionName As String) As Supabase_DatabaseRpc
	m_FunctionName = FunctionName.ToLowerCase
	Return Me
End Sub

'The arguments to pass to the function call.
'<code>CallFunction.Parameters(CreateMap("ParameterName":"ParameterValue"))</code>
Public Sub Parameters(ParamValue As Map) As Supabase_DatabaseRpc
	m_ParamValue = ParamValue
	Return Me
End Sub

#Region Filters

'Finds all rows whose value on the stated column match the specified value
Public Sub Filter_Equal(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=eq." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

'Public Sub Filter_Fts(ColumnValue As Map) As Supabase_DatabaseRpc
'	For Each key As String In ColumnValue.Keys
'		m_WhereList.Add(key & "=fts." & ColumnValue.Get(key))
'	Next
'	Return Me
'End Sub

'Finds all rows whose value in the stated column matches the supplied pattern (case insensitive)
Public Sub Filter_Ilike(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=ilike." & str.EncodeUrl(ColumnValue.Get(key),"UTF8"))
	Next
	Return Me
End Sub

'Finds all rows whose value on the stated column is found on the specified values
Public Sub Filter_In(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=in." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

'A check for exact equality (null, true, false), finds all rows whose value on the stated column exactly match the specified value
Public Sub Filter_Is(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=is." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

'Finds all rows whose value on the stated column is greater than the specified value
Public Sub Filter_GreatherThan(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=gt." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

'Finds all rows whose value on the stated column is greater than or equal to the specified value
Public Sub Filter_GreatherThanOrEqual(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=gte." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

'Finds all rows whose value in the stated column matches the supplied pattern (case sensitive)
Public Sub Filter_Like(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=like." & "*" & ColumnValue.Get(key) & "")
	Next
	Return Me
End Sub

'Finds all rows whose value on the stated column is less than the specified value
Public Sub Filter_LessThan(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=lt." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

'Finds all rows whose value on the stated column is less than or equal to the specified value
Public Sub Filter_LessThanOrEqual(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=lte." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

'Finds all rows whose value on the stated column doesn't match the specified value.
Public Sub Filter_NotEqual(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=neq." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

Public Sub Filter_Or(ColumnValue As Map) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		m_WhereList.Add(key & "=Or." & ColumnValue.Get(key))
	Next
	Return Me
End Sub

'Example:
'<code>"Task_Id.desc"</code>
'<code>"Task_Id.desc,Task_Name.asc"</code>
'Available sorting commands:
'<code>desc</code>
'<code>asc</code>
'<code>nullsfirst</code>
'<code>nullslast</code>
Public Sub OrderBy(ColumnSortDirection As String)
	'https://postgrest.org/en/stable/references/api/tables_views.html#ordering
	m_OrderBy = ColumnSortDirection
End Sub

Public Sub Limit(RowLimit As Int)
	m_Limit = RowLimit
End Sub

'Says to skip that many rows before beginning to return rows. OFFSET 0 is the same as omitting the OFFSET clause, as is OFFSET with a NULL argument.
Public Sub Offset(RowOffset As Int)
	'https://postgrest.org/en/stable/references/api/tables_views.html#ordering
	m_Offset = RowOffset
End Sub

'Public Sub Filter_Plfts(ColumnValue As Map) As Supabase_DatabaseRpc
'	For Each key As String In ColumnValue.Keys
'		m_WhereList.Add(key & "=plfts." & ColumnValue.Get(key))
'	Next
'	Return Me
'End Sub

'Public Sub Filter_Phfts(ColumnValue As Map) As Supabase_DatabaseRpc
'	For Each key As String In ColumnValue.Keys
'		m_WhereList.Add(key & "=phfts." & ColumnValue.Get(key))
'	Next
'	Return Me
'End Sub

'Public Sub Filter_Wfts(ColumnValue As Map) As Supabase_DatabaseRpc
'	For Each key As String In ColumnValue.Keys
'		m_WhereList.Add(key & "=wfts." & ColumnValue.Get(key))
'	Next
'	Return Me
'End Sub

'FilterType:
	'<code>plain</code>
	'<code>phrase</code>
	'<code>websearch</code>
	'<code>""</code>
Public Sub Filter_TextSearch(ColumnValue As Map,FilterType As String) As Supabase_DatabaseRpc
	For Each key As String In ColumnValue.Keys
		If FilterType = "plain" Then
			m_WhereList.Add(key & "=plfts." & ColumnValue.Get(key).As(String).Replace(" ","%20"))
			'Log(ColumnValue.Get(key).As(String).Replace(" ","%20"))
		else If FilterType = "phrase" Then
			m_WhereList.Add(key & "=phfts." & ColumnValue.Get(key).As(String).Replace(" ","%20"))
		else If FilterType = "websearch" Then
			m_WhereList.Add(key & "=wfts." &  ColumnValue.Get(key).As(String).Replace(" ","%20"))
		Else 
			m_WhereList.Add(key & "=fts." & ColumnValue.Get(key).As(String).Replace(" ","%20"))
		End If
	Next
	Return Me
End Sub

#End Region

Public Sub Range(FirstPage As Int,LastPage As Int) As Supabase_DatabaseRpc
	m_Range = FirstPage & "-" & LastPage
	Return Me
End Sub

Public Sub Execute As ResumableSub
	
	Dim RpcResult As SupabaseRpcResult
	RpcResult.Initialize

	Dim RpcError As SupabaseError
	RpcError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)

	If AccessToken = "" Then
		RpcError.StatusCode = 401
		RpcError.ErrorMessage = "Unauthorized"
		RpcResult.Error = RpcError
		Return RpcResult
	End If

	Dim url As String = $"${m_Supabase.URL}/rest/v1/rpc/${m_FunctionName}"$
		
	For i = 0 To m_WhereList.Size -1
		url = url & IIf(url.Contains("?"),"&","?") & m_WhereList.Get(i)
	Next
	
	If m_OrderBy <> "" Then
		url = url & IIf(url.Contains("?"),"&","?") & "order=" & m_OrderBy
	End If
	
	'https://www.postgresql.org/docs/current/queries-limit.html
	If m_Limit > 0 Then
		url = url & IIf(url.Contains("?"),"&","?") & "limit=" & m_Limit
	End If
	
	If m_Offset > 0 Then
		url = url & IIf(url.Contains("?"),"&","?") & "offset=" & m_Offset
	End If

	'Log(url)
	Dim j As HttpJob : j.Initialize("",Me)
	If m_ParamValue.Size > 0 Then
		Dim jsn As JSONGenerator
		jsn.Initialize(m_ParamValue)
		Dim ParamJson As String = jsn.ToString
		j.PostString(url.ToLowerCase,ParamJson)
		j.GetRequest.SetContentType("application/json")
	Else
		j.Download(url.ToLowerCase)
		j.GetRequest.SetHeader("Content-Type","application/json")
	End If
	
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	If m_Range <> "" Then j.GetRequest.SetHeader("Range",m_Range)
	
	Wait For (j) JobDone(j As HttpJob)

	RpcError.Success = j.Success

	If j.Success Then
		'Log(j.GetString)
		Dim Result As String = j.GetString
		If Result = "[]" Then

		Else

			'Log(j.GetString)
			RpcResult.Data = j.GetString
				
		End If
		
	Else
		RpcError.StatusCode = j.Response.StatusCode
		RpcError.ErrorMessage = j.ErrorMessage
	End If

	RpcResult.Error = RpcError
	Return RpcResult
	
End Sub
