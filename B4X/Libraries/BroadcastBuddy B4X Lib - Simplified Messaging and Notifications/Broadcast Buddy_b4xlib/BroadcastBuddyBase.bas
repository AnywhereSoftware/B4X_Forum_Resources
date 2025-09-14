B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' BroadcastBuddyBase.bas
Private Sub Class_Globals
	Private const BASE_URL As String = "https://api.broadcastbuddy.app/v1/"
	Private apiKey As String
End Sub

Public Sub Initialize(key As String)
	apiKey = key
End Sub

Public Sub MakeRequest(endpoint As String, method As String, data As Map) As ResumableSub
	Dim job As HttpJob
	job.Initialize("", Me)
	Dim fullUrl As String = BASE_URL & endpoint
    
	If method = "GET" Then
		job.Download(fullUrl)
	Else If method = "POST" Then
		Dim JsonGenerator As JSONGenerator
		JsonGenerator.Initialize(data)
		job.PostString(fullUrl, JsonGenerator.ToString)
	End If
    
	job.GetRequest.SetHeader("X-Authorization", apiKey)
	job.GetRequest.SetHeader("Content-Type", "application/json")
    
	Wait For (job) JobDone(job As HttpJob)
	If job.Success Then
		Dim parser As JSONParser
		parser.Initialize(job.GetString)
    
		job.Release
		Return parser.NextObject
	Else
		Log("Error: " & job.ErrorMessage)
    
		job.Release
		Return Null
	End If
End Sub
