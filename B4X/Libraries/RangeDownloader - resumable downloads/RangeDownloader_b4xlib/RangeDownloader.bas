B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Type RangeDownloadTracker (CurrentLength As Long, TotalLength As Long, Completed As Boolean, Cancel As Boolean)
End Sub

Public Sub Initialize
End Sub

Public Sub CreateTracker As RangeDownloadTracker
	Dim t As RangeDownloadTracker
	t.Initialize
	Return t
End Sub

Public Sub Download (Dir As String, FileName As String, URL As String, Tracker As RangeDownloadTracker) As ResumableSub
	Dim head As HttpJob
	head.Initialize("", Me)
	head.Head(URL)
	Wait For (head) JobDone (head As HttpJob)
	head.Release 'the actual content is not needed
	If head.Success Then
		Tracker.TotalLength = head.Response.ContentLength
		If Tracker.TotalLength = 0 Then Tracker.TotalLength = GetCaseInsensitiveHeaderValue(head, "content-length", "0")
'		Log(head.Response.GetHeaders.As(JSON).ToString)
		If GetCaseInsensitiveHeaderValue(head, "Accept-Ranges", "").As(String) <> "bytes" Then
			Log("accept ranges not supported")
			Tracker.Completed = True
			Return False
		End If
	Else
		Tracker.Completed = True
		Return False
	End If
	
	Log("Total length: " & NumberFormat(Tracker.TotalLength, 0, 0))
	If File.Exists(Dir, FileName) Then
		Tracker.CurrentLength = File.Size(Dir, FileName)
	End If
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, True) 'append = true
	Do While Tracker.CurrentLength < Tracker.TotalLength
		Dim j As HttpJob
		j.Initialize("", Me)
		j.Download(URL)
		Dim range As String = $"bytes=${Tracker.CurrentLength}-${(Min(Tracker.TotalLength, Tracker.CurrentLength + 300 * 1024) - 1).As(Int)}"$
		Log(range)
		j.GetRequest.SetHeader("Range", range)
		Wait For (j) JobDone (j As HttpJob)
		Dim good As Boolean = j.Success
		If j.Success Then
			Wait For (File.Copy2Async(j.GetInputStream, out)) Complete (Success As Boolean)
			#if B4A or B4J
			out.Flush
			#end if
			good = good And Success
			If Success Then
				Tracker.CurrentLength = File.Size(Dir, FileName)
			End If
		End If
		j.Release
		If good = False Or Tracker.Cancel = True Then
			Tracker.Completed = True
			Return False
		End If
	Loop
	out.Close
	Tracker.Completed = True
	Return True
End Sub

Private Sub GetCaseInsensitiveHeaderValue (job As HttpJob, Key As String, DefaultValue As String) As String
	Dim headers As Map = job.Response.GetHeaders
	For Each k As String In headers.Keys
		If K.EqualsIgnoreCase(Key) Then
			Return headers.Get(k).As(String).Replace("[", "").Replace("]", "").Trim
		End If
	Next
	Return DefaultValue
End Sub

