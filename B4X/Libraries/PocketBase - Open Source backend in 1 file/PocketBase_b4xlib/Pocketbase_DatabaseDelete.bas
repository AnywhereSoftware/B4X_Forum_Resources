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
End Sub

Private Sub SetApiEndpoint(EndpointName As String) 'Ignore
	m_ApiEndpoint = EndpointName
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisPocketbase As Pocketbase)
	m_Pocketbase = ThisPocketbase
End Sub

Public Sub Collection(TableName As String) As Pocketbase_DatabaseDelete
	m_TableName = TableName
	Return Me
End Sub

Public Sub Execute(RecordId As String) As ResumableSub
	
	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	
	Wait For (m_Pocketbase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Return DatabaseError
	End If
	
	Dim url As String = ""
	url = url & $"${m_Pocketbase.URL}/${m_ApiEndpoint}${m_TableName}"$
	If m_ApiEndpoint = "collections" Then
		url = url & $"/records/${RecordId}"$
	Else
		url = url & $"/${RecordId}"$
	End If
	'Log(url)

	Dim j As HttpJob : j.Initialize("",Me)
	j.Delete(url)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success Then
		DatabaseError.StatusCode = j.Response.StatusCode
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If

	Return DatabaseError
	
End Sub