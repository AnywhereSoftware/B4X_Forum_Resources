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

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisPocketbase As Pocketbase)
	m_Pocketbase = ThisPocketbase
	m_Files.Initialize
	
End Sub

Public Sub Collection(TableName As String) As Pocketbase_DatabaseUpdate
	m_TableName = TableName
	Return Me
End Sub

Public Sub Update(ColumnValue As Map) As Pocketbase_DatabaseUpdate
	m_ColumnValue = ColumnValue
	Return Me
End Sub

#Region CustomParameters

'Auto expand record relations.
Public Sub Parameter_Expand(Expand As String) As Pocketbase_DatabaseUpdate
	m_CustomParameters = m_CustomParameters & $"&expand=${Expand}"$
	Return Me
End Sub

'Comma separated string of the fields to return in the JSON response (by default returns all fields).
'<code>CustomQuery.Parameter_Fields("Task_Name,Task_CompletedAt")</code>
Public Sub Parameter_Fields(Fields As String) As Pocketbase_DatabaseUpdate
	m_CustomParameters = m_CustomParameters & $"&fields=${Fields}"$
	Return Me
End Sub
  
 
Public Sub Parameter_Files(Files As List)
	m_Files = Files
End Sub
  
#End Region

Public Sub Execute(RecordId As String) As ResumableSub
	
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
	url = url & $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_TableName}/records/${RecordId}${m_CustomParameters}"$

	Dim j As HttpJob : j.Initialize("",Me)
	
	If m_Files.Size = 0 Then
		
		Dim DataString As String = ""

		If m_ColumnValue.IsInitialized And m_ColumnValue.Size > 0 Then
			Dim jsn As JSONGenerator
			jsn.Initialize(m_ColumnValue)
			DataString = jsn.ToString
		End If
		'Log(jsn.ToString)
		'Log(url)
		
		j.PatchString(url,DataString)
		j.GetRequest.SetContentType("application/json")
		j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	Else		
		Pocketbase_InternFunctions.PatchMultipart(j,url,m_ColumnValue,m_Files)
	End If
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

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


'Sub UploadFileToPocketBase(FilePath As String, FileName As String)
'	Dim Http As HttpJob
'	Http.Initialize("UploadFile", Me)
'
'	' API-URL für die Ziel-Collection (ersetze "my_collection" mit dem Namen deiner Collection)
'	Dim url As String = "http://127.0.0.1:8090/api/collections/my_collection/records"
'
'	' Erstelle Multipart-Daten (Datei hochladen)
'	Dim fileData As MultipartFileData
'	fileData.Initialize
'	fileData.Dir = File.DirRootExternal ' Oder ein anderer Pfad (z. B. File.DirInternal)
'	fileData.FileName = FileName
'	fileData.KeyName = "file" ' Name des File-Felds in der Collection
'	fileData.ContentType = "application/octet-stream" ' Oder anderer MIME-Typ (z. B. "image/png")
'
'	' Optionale JSON-Daten (z. B. Task_Name hinzufügen)
'	Dim jsonData As String = $"{
'        "Task_Name": "Neuer Task",
'        "Task_UserId": "86jzh49x5k2m387"
'    }"$
'    
'	' Header setzen und Anfrage senden
'	Dim data As Map
'	data.Initialize
'	data.Put("data", jsonData) ' JSON als weiteres Form-Feld senden
'
'	Http.PostMultipart(url, data, Array(fileData)) ' Datei & Daten senden
'	Http.GetRequest.SetHeader("Authorization", "Bearer Dein_Api_Token") ' Falls Auth benötigt wird
'
'	Log("Datei-Upload gestartet...")
'End Sub
