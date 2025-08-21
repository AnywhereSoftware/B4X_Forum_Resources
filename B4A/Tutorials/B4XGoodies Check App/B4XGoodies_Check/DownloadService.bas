B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=5.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

Sub Process_Globals
	Private jobs As Map
	Private timer1 As Timer
	Type DownloadData (url As String, Target As Object, EventName As String)
	Type JobTag (Data As DownloadData,  _
		CountingStream As CountingOutputStream, Total As Long)
	Private pw As PhoneWakeState
End Sub
Sub Service_Create
	jobs.Initialize
	timer1.Initialize("timer1", 1000)
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub Service_Destroy

End Sub

Private Sub StartTimer (Target As Object)
	Dim n As Notification
	n.Initialize2(n.IMPORTANCE_LOW)
	n.Icon = "icon"
	n.Vibrate = False
	n.Sound = False
	n.Light = False
	n.SetInfo("Downloading file...", "", Target)
	Service.StartForeground(1, n)
	timer1.Enabled = True
	pw.PartialLock
End Sub

Private Sub EndTimer
	Service.StopForeground(1)
	timer1.Enabled = False
	pw.ReleasePartialLock
End Sub

Public Sub StartDownload(data As DownloadData)
	If jobs.ContainsKey(data.url) Then
		Log("Ignoring duplicate request.")
		Return
	End If
	Dim J As HttpJob
	J.Initialize(data.url, Me)
	Dim tag As JobTag
	tag.Initialize
	tag.data = data
	J.tag = tag
	jobs.Put(data.url, J)
	J.Download(data.url)
	If timer1.Enabled = False Then StartTimer(data.Target)
End Sub

Public Sub CancelDownload(url As String)
	If jobs.ContainsKey(url) = False Then
		Log("Ignoring cancel request.")
		Return
	End If
	Dim job As HttpJob = jobs.Get(url)
	Dim jt As JobTag = job.Tag
	If jt.CountingStream.IsInitialized Then
		jt.CountingStream.Close
	Else
		jt.Data.url = ""
	End If
End Sub

Sub timer1_tick
	For Each job As HttpJob In jobs.Values
		Dim jt As JobTag = job.Tag
		If jt.CountingStream.IsInitialized Then
			CallSub3(jt.Data.Target, jt.Data.EventName & "_Progress", _
				jt.CountingStream.Count, jt.Total)
		End If
	Next
End Sub

Sub JobDone(job As HttpJob)
	jobs.Remove(job.JobName)
	Dim jt As JobTag = job.Tag
	If jobs.Size = 0 Then EndTimer
	If job.Success Then
		CallSubDelayed3(jt.Data.Target, jt.Data.EventName & "_Progress", _
				jt.CountingStream.Count, jt.Total)
		CallSubDelayed2(jt.Data.Target, jt.Data.EventName & "_Complete", _
				job)
	Else
		Log(job.ErrorMessage)
		CallSubDelayed2(jt.Data.Target, jt.Data.EventName & "_Complete", _
				job)
	End If
End Sub
