B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	
	Private m_Pocketbase As Pocketbase
	Private m_ApiEndpoint As String = "collections"
	Private m_TableName As String
	Private m_WhereList As List
	Private m_CustomParameters As String = ""
End Sub

Private Sub SetApiEndpoint(EndpointName As String) 'Ignore
	m_ApiEndpoint = EndpointName
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisPocketbase As Pocketbase)
	m_Pocketbase = ThisPocketbase
	m_WhereList.Initialize
End Sub

Public Sub Collection(TableName As String) As Pocketbase_DatabaseSelect
	m_TableName = TableName
	Return Me
End Sub

' Returns the first found list item by the specified filter.
'<code>	Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetFirstListItem("","")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)</code>
Public Sub GetFirstListItem(Filter As String, Expand As String) As ResumableSub
	Wait For (Execute($"?filter=${Filter}&expand=${Expand}&perPage=1"$)) complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
End Sub

' Returns a list with all items batch fetched at once.
'<code>	Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetFullList("-Task_Name")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)</code>
Public Sub GetFullList(Sort As String) As ResumableSub
	Wait For (Execute($"?sort=${Sort}&perPage=10000"$)) complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
End Sub

' Returns paginated items list.
'<code>
'	Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetList(0,2,"")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)</code>
Public Sub GetList(Page As Int, PerPage As Int, Filter As String) As ResumableSub
	Dim Parameter As String = "?"
	Parameter = Parameter & $"page=${Page}&perPage=${PerPage}&filter=${Filter}"$
	Wait For (Execute(Parameter)) complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
End Sub

' Returns single item by its ID.
'<code>	Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetOne("77avq8zn44ck37m")) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)</code>
Public Sub GetOne(RecordID As String) As ResumableSub
	Wait For (Execute("/" & RecordID)) complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
End Sub

#Region CustomParameters

'Only for GetCustom
'The page (aka. offset) of the paginated list (default to 1).
'<code>CustomQuery.Parameter_Page(0)</code>
Public Sub Parameter_Page(Page As Int) As Pocketbase_DatabaseSelect
	m_CustomParameters = m_CustomParameters & $"&page=${Page}"$
	Return Me
End Sub

'Only for GetCustom
'Specify the max returned records per page (default to 30).
'<code>CustomQuery.Parameter_PerPage(4)</code>
Public Sub Parameter_PerPage(perPage As Int) As Pocketbase_DatabaseSelect
	m_CustomParameters = m_CustomParameters & $"&perPage=${perPage}"$
	Return Me
End Sub

'Only for GetCustom
'Specify the records order attribute(s).
'Add - / + (default) in front of the attribute for DESC / ASC order.
'<code>CustomQuery.Parameter_Sort("-Task_Name") 'DESC</code>
Public Sub Parameter_Sort(Sort As String) As Pocketbase_DatabaseSelect
	m_CustomParameters = m_CustomParameters & $"&sort=${Sort}"$
	Return Me
End Sub

'Only for GetCustom
'Filter the returned records.
'Single filter:
'<code>CustomQuery.Parameter_Filter("Task_Name='Task 05'")</code>
'Multiple filter:
'<code>CustomQuery.Parameter_Filter("Task_Name='Task 05' && Task_UserId='86jzh49x5k2m387'")</code>
Public Sub Parameter_Filter(Filter As String) As Pocketbase_DatabaseSelect
	m_CustomParameters = m_CustomParameters & $"&filter=${Filter}"$
	Return Me
End Sub

'Only for GetCustom
'Auto expand record relations.
Public Sub Parameter_Expand(Expand As String) As Pocketbase_DatabaseSelect
	m_CustomParameters = m_CustomParameters & $"&expand=${Expand}"$
	Return Me
End Sub

'Only for GetCustom
'Comma separated string of the fields to return in the JSON response (by default returns all fields).
'<code>CustomQuery.Parameter_Fields("Task_Name,Task_CompletedAt")</code>
Public Sub Parameter_Fields(Fields As String) As Pocketbase_DatabaseSelect
	m_CustomParameters = m_CustomParameters & $"&fields=${Fields}"$
	Return Me
End Sub

'Only for GetCustom
'If it is set the total counts query will be skipped and the response fields totalItems and totalPages will have -1 value.
'This could drastically speed up the search queries when the total counters are not needed or cursor based pagination is used.
'For optimization purposes, it is set by default for the getFirstListItem() and getFullList() SDKs methods.
Public Sub Parameter_SkipTotal(skipTotal As Boolean) As Pocketbase_DatabaseSelect
	m_CustomParameters = m_CustomParameters & $"&skipTotal=${skipTotal}"$
	Return Me
End Sub

#End Region

'Create your own query with all available filters
'Use the "Parameter_" properties
'<code>
'	Dim CustomQuery As Pocketbase_DatabaseSelect = xPocketbase.Database.SelectData.Collection("dt_Task")
'	CustomQuery.Parameter_Page(0)
'	CustomQuery.Parameter_PerPage(2)
'	CustomQuery.Parameter_Fields("Task_Name,Task_CompletedAt")
'	CustomQuery.Parameter_Sort("-Task_Name") 'DESC
'	Wait For (CustomQuery.GetCustom) Complete (DatabaseResult As PocketbaseDatabaseResult)
'	xPocketbase.Database.PrintTable(DatabaseResult)</code>
Public Sub GetCustom As ResumableSub	
	If m_CustomParameters.StartsWith("&") Then m_CustomParameters = m_CustomParameters.SubString(1)		
	Wait For (Execute("?" & m_CustomParameters)) complete (DatabaseResult As PocketbaseDatabaseResult)
	Return DatabaseResult
End Sub

Private Sub Execute(Parameters As String) As ResumableSub
	
	Dim DatabaseResult As PocketbaseDatabaseResult
	DatabaseResult.Initialize
	DatabaseResult.Columns.Initialize
	DatabaseResult.Rows.Initialize
	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	
	Wait For (m_Pocketbase.Auth.GetAccessToken) Complete (AccessToken As String)

	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		DatabaseResult.Error = DatabaseError
		Return DatabaseResult
	End If

	Dim url As String = ""
	url = url & $"${m_Pocketbase.URL}/${m_ApiEndpoint}"$
	If m_TableName <> "" Then url = url & $"/${m_TableName}/records${Parameters}"$
	If m_ApiEndpoint = "collections" Then
		'url = url & $"/records${Parameters}"$
	Else
		url = url & Parameters
		If m_CustomParameters <> "" Then
			If m_CustomParameters.StartsWith("&") Then m_CustomParameters = m_CustomParameters.SubString(1)
			url = url & IIf(url.Contains("?"),"&", "?") & m_CustomParameters
		End If
	End If

	'Log(url)
	Dim j As HttpJob : j.Initialize("",Me)
	j.Download(url)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
		'Log(j.GetString)
		Dim Result As String = j.GetString
		If Result = "[]" Then
'			Log("User not Authenticated or check your RLS policy!")
'			DatabaseError.Success = False
'			DatabaseError.StatusCode = 401
'			DatabaseError.ErrorMessage = "User not Authenticated or check your RLS policy!"
			DatabaseError.StatusCode = j.Response.StatusCode
		Else
				
			'Log(j.GetString)
			DatabaseError.StatusCode = j.Response.StatusCode
			DatabaseResult = Pocketbase_InternFunctions.CreateDatabaseResult(j.GetString)
				
		End If
		
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	DatabaseResult.Error = DatabaseError
	Return DatabaseResult

	'Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)
	
End Sub
