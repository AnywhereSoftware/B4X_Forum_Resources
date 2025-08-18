Type=Service
Version=2.71
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

Sub Process_Globals
	Private cache As Map
	Private tasks As Map
	Private ongoingTasks As Map
End Sub

Sub Service_Create
	tasks.Initialize
	cache.Initialize
	ongoingTasks.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub Service_Destroy

End Sub

Sub Download (ImageViewsMap As Map)
	For i = 0 To ImageViewsMap.Size - 1
		tasks.Put(ImageViewsMap.GetKeyAt(i), ImageViewsMap.GetValueAt(i))
		Dim link As String = ImageViewsMap.GetValueAt(i)
		If cache.ContainsKey(link) Then
			Dim iv As ImageView = ImageViewsMap.GetKeyAt(i)
			iv.SetBackgroundImage(cache.Get(link))
		Else If ongoingTasks.ContainsKey(link) = False Then
			ongoingTasks.Put(link, "")
			Dim j As HttpJob
			j.Initialize(link, Me)
			j.Download(link)
		End If
	Next
End Sub

Sub JobDone(Job As HttpJob)
	ongoingTasks.Remove(Job.JobName)
	If Job.Success Then
		Dim bmp As Bitmap = Job.GetBitmap
		cache.Put(Job.JobName, bmp)
		If tasks.IsInitialized Then
			For i = 0 To tasks.Size - 1
				Dim link As String = tasks.GetValueAt(i)
				If link = Job.JobName Then
					Dim iv As ImageView = tasks.GetKeyAt(i)
					iv.SetBackgroundImage(bmp)
				End If
			Next
		End If
	Else
		Log("Error downloading image: " & Job.JobName & CRLF & Job.ErrorMessage)
	End If
	Job.Release
End Sub
Sub ActivityIsPaused
	tasks.Clear
End Sub
