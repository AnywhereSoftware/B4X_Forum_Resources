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
	Private m_ColumnValue As Map
	Private m_CustomParameters As String = ""
	Private m_Files As List
End Sub

Private Sub SetApiEndpoint(EndpointName As String) 'Ignore
	m_ApiEndpoint = EndpointName
End Sub

Private Sub SetCustomParameters(CustomParameter As String) 'Ignore
	m_CustomParameters = CustomParameter
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisPocketbase As Pocketbase)
	m_Pocketbase = ThisPocketbase
	m_Files.Initialize
End Sub

Public Sub Collection(TableName As String) As Pocketbase_DatabaseInsert
	m_TableName = TableName
	Return Me
End Sub

'Insert one row
'<code>Dim InsertMap As Map = CreateMap("Tasks_Name":"Task 01","Tasks_Checked":True,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now))</code>
Public Sub Insert(ColumnValue As Map) As Pocketbase_DatabaseInsert
	m_ColumnValue = ColumnValue
	Return Me
End Sub

#Region CustomParameters

'Auto expand record relations.
Public Sub Parameter_Expand(Expand As String) As Pocketbase_DatabaseInsert
	m_CustomParameters = m_CustomParameters & $"&expand=${Expand}"$
	Return Me
End Sub

'Comma separated string of the fields to return in the JSON response (by default returns all fields).
'<code>CustomQuery.Parameter_Fields("Task_Name,Task_CompletedAt")</code>
Public Sub Parameter_Fields(Fields As String) As Pocketbase_DatabaseInsert
	m_CustomParameters = m_CustomParameters & $"&fields=${Fields}"$
	Return Me
End Sub

Public Sub Parameter_Files(Files As List)
	m_Files = Files
End Sub

#End Region

Public Sub Execute As ResumableSub
	
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
	If m_CustomParameters.StartsWith("&") Then m_CustomParameters = "?" & m_CustomParameters.SubString(1)
	url = url & $"${m_Pocketbase.URL}/${m_ApiEndpoint}"$
	If m_TableName <> "" Then url = url & $"/${m_TableName}"$
	If m_ApiEndpoint = "collections" Then
		url = url & $"/records${m_CustomParameters}"$
	Else
		url = url & m_CustomParameters
	End If
	'Log(url)
	Dim j As HttpJob : j.Initialize("",Me)
	
	If m_Files.Size = 0 Then
		Dim DataString As String = ""

		If m_ColumnValue.IsInitialized And m_ColumnValue.Size > 0 Then
			Dim jsn As JSONGenerator
			jsn.Initialize(m_ColumnValue)
			DataString = jsn.ToString
		End If
		j.PostString(url,DataString)
		j.GetRequest.SetContentType("application/json")
	Else
		j.PostMultipart(url,m_ColumnValue,m_Files)
	End If
	'Log(url)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success
	'Log(j.GetString)
	If j.Success Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseResult = Pocketbase_InternFunctions.CreateDatabaseResult(j.GetString)
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	DatabaseResult.Error = DatabaseError
	Return DatabaseResult
	
End Sub