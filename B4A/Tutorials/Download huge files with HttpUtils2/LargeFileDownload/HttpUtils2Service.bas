B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=5.5
@EndOfDesignText@
#Region Module Attributes
	#StartAtBoot: False
#End Region

'Modified version of HttpUtils2
'Service module
Sub Process_Globals
	Private hc As OkHttpClient
	Private TaskIdToJob As Map
	Public TempFolder As String
	Private taskCounter As Int
End Sub

Sub Service_Create
	TempFolder = File.DirInternalCache
	hc.Initialize("hc")
	TaskIdToJob.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)
	
End Sub

Sub Service_Destroy

End Sub

Public Sub SubmitJob(job As HttpJob) As Int
	taskCounter = taskCounter + 1
	TaskIdToJob.Put(taskCounter, job)
	If job.Username <> "" And job.Password <> "" Then
		hc.ExecuteCredentials(job.GetRequest, taskCounter, job.Username, job.Password)
	Else
		hc.Execute(job.GetRequest, taskCounter)
	End If
	Return taskCounter
End Sub

Sub hc_ResponseSuccess (Response As OkHttpResponse, TaskId As Int)
	' ********** Modified code *************
	Dim cs As CountingOutputStream
	cs.Initialize(File.OpenOutput(TempFolder, TaskId, False))
	Dim j As HttpJob = TaskIdToJob.Get(TaskId)
	Dim jt As JobTag = j.Tag
	jt.CountingStream = cs
	jt.Total = Response.ContentLength
	If jt.Data.url = "" Then
		Log("Job cancelled before downloaded started")
		cs.Close
	End If
	Response.GetAsynchronously("response", cs , _
		True, TaskId)
	'**************************************
End Sub

Sub Response_StreamFinish (Success As Boolean, TaskId As Int)
	If Success Then
		CompleteJob(TaskId, Success, "")
	Else
		CompleteJob(TaskId, Success, LastException.Message)
	End If
End Sub

Sub hc_ResponseError (Response As OkHttpResponse, Reason As String, StatusCode As Int, TaskId As Int)
	If Response <> Null Then
		Log(Response.ErrorResponse)
		Response.Release
	End If
	CompleteJob(TaskId, False, Reason)
End Sub

Sub CompleteJob(TaskId As Int, success As Boolean, errorMessage As String)
	Dim job As HttpJob
	job = TaskIdToJob.Get(TaskId)
	TaskIdToJob.Remove(TaskId)
	job.success = success
	job.errorMessage = errorMessage
	job.Complete(TaskId)
End Sub

