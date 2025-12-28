B4A=true
Group=Library Modules
ModulesStructureVersion=1
Type=Receiver
Version=7.28
@EndOfDesignText@
'Service module
Sub Process_Globals
#if HU2_PUBLIC
	#if B4A or B4J
		Public hc As OkHttpClient
	#else
		Public hc As HttpClient
	#end if
	Public TaskIdToJob As Map
#else
	#if B4A or B4J
		Private hc As OkHttpClient
	#else
		Private hc As HttpClient
	#end if
	Private TaskIdToJob As Map
#End If
	
	Public TempFolder As String
	#if B4J and SERVER
	Private atomicTaskCounter As AtomicInteger
	#else
	Private taskCounter As Int
	#End If
End Sub

Sub Service_Create
#if B4A
	TempFolder = File.DirInternalCache
	Try
		File.WriteString(TempFolder, "~test.test", "test")
		File.Delete(TempFolder, "~test.test")
	Catch
		Log(LastException)
		Log("Switching to File.DirInternal")
		TempFolder = File.DirInternal
	End Try
#Else If B4J
	TempFolder = File.DirTemp
#End If
	If hc.IsInitialized = False Then
#if HU2_ACCEPTALL
		Log("(Http client initialized with accept all option.)")
		hc.InitializeAcceptAll("hc")
#else
		hc.Initialize("hc")
#End If
	End If
#if B4J and SERVER
	Log("OkHttpUtils2 - server mode!")
	atomicTaskCounter.Initialize
	TaskIdToJob = Main.srvr.CreateThreadSafeMap
#else
	TaskIdToJob.Initialize
#End If
End Sub
#If B4A
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	If FirstTime Then
		Service_Create	
	End If
End Sub

Sub Service_Start (StartingIntent As Intent)
	'Service.StopAutomaticForeground
End Sub

Sub Service_Destroy

End Sub
#End If


Public Sub SubmitJob(job As HttpJob)
	If TaskIdToJob.IsInitialized = False Then Service_Create
	#if B4J and SERVER
	Dim TaskId As Int = atomicTaskCounter.Increment
	#else
	taskCounter = taskCounter + 1
	Dim TaskId As Int = taskCounter
	#End If
	TaskIdToJob.Put(TaskId, job)
	If job.Username <> "" And job.Password <> "" Then
		hc.ExecuteCredentials(job.GetRequest, TaskId, job.Username, job.Password)
	Else
		hc.Execute(job.GetRequest, TaskId)
	End If
End Sub


#if B4A or B4J
Sub hc_ResponseSuccess (Response As OkHttpResponse, TaskId As Int)
	Dim job As HttpJob = TaskIdToJob.Get(TaskId)
	If job = Null Then
		Log("HttpUtils2Service (hc_ResponseSuccess): job completed multiple times - " & TaskId)
		Return
	End If
	job.Response = Response
	Dim out As OutputStream = File.OpenOutput(TempFolder, TaskId, False)
	#if HU2_PUBLIC
	job.Out = out
	#end if
	Response.GetAsynchronously("response", out , _
		True, TaskId)
End Sub

Private Sub Response_StreamFinish (Success As Boolean, TaskId As Int)
	If Success Then
		CompleteJob(TaskId, Success, "")
	Else
		CompleteJob(TaskId, Success, LastException.Message)
	End If
End Sub

Sub hc_ResponseError (Response As OkHttpResponse, Reason As String, StatusCode As Int, TaskId As Int)
	#if Not(HU2_NOLOGS)
	Log($"ResponseError. Reason: ${Reason}, Response: ${Response.ErrorResponse}"$)
	#end if
	Response.Release
	Dim job As HttpJob = TaskIdToJob.Get(TaskId)
	If job = Null Then
		Log("HttpUtils2Service (hc_ResponseError): job completed multiple times - " & TaskId)
		Return
	End If
	job.Response = Response
	If Response.ErrorResponse <> "" Then
		CompleteJob(TaskId, False, Response.ErrorResponse)
	Else
		CompleteJob(TaskId, False, Reason)
	End If
End Sub
#Else
Sub hc_ResponseError (Response As HttpResponse, Reason As String, StatusCode As Int, TaskId As Int)
	#if Not(HU2_NOLOGS)
	Log("ResponseError: " & Reason & ", status code: " & StatusCode)
	#end if
	Try
		Dim j As String = Response.GetString
		If j <> "" Then Reason = j
	Catch
		Reason = "(Error decoding response)"
	End Try
	CompleteJob(TaskId, False, Reason, Response)
End Sub

Sub hc_ResponseSuccess (Response As HttpResponse, TaskId As Int)
	CompleteJob(TaskId, True, "", Response)
End Sub
#End If

#If B4A or B4J
Sub CompleteJob(TaskId As Int, success As Boolean, errorMessage As String)
#Else
Sub CompleteJob(TaskId As Int, success As Boolean, errorMessage As String, res As HttpResponse)
#End If
	Dim job As HttpJob = TaskIdToJob.Get(TaskId)
	If job = Null Then
		Log("HttpUtils2Service: job completed multiple times - " & TaskId)
		Return
	End If
	TaskIdToJob.Remove(TaskId)
	job.success = success
	job.errorMessage = errorMessage
#if B4A or B4J
	job.Complete(TaskId)
#Else
	job.Complete(res)
#End If
End Sub



