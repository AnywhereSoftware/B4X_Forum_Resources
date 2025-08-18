Type=Service
Version=2.51
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

Sub Process_Globals
	Private JobsIndex As Map
	Private links As List
	Private images() As Bitmap
End Sub
Sub Service_Create
	
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub StartDownload
	'first we download the main page.
	'the second step is to find the image links and download them
	Dim pageJob As HttpJob
	pageJob.Initialize("PageJob", Me)
	pageJob.Download("http://www.loc.gov/rr/print/list/listguid.html#architecture")
	JobsIndex.Initialize
	links.Initialize
End Sub

Sub JobDone(Job As HttpJob)
	If Job.Success = True Then
		If Job.JobName = "PageJob" Then
			ParseMainPage(Job.GetString)
		Else If Job.JobName = "Image" Then
			Dim index As Int = JobsIndex.Get(Job) 'find the index of the job
			Dim bmp As Bitmap = Job.GetBitmapSampled(100dip, 100dip)
			images(index) = bmp 'store for future use.
			CallSubDelayed3(Main, "ShowImage", bmp, index) 'show the image if the activity is currently running
			'note that this call will actually start the activity if there is a different activity running.
			'you can use IsPaused to check whether the activity is running or not.
		End If
	Else
		Log(Job.ErrorMessage)
		ToastMessageShow(Job.ErrorMessage, False)
	End If
	Job.Release
End Sub

Sub ParseMainPage(page As String)
	Dim m As Matcher = Regex.Matcher("class=\""darkbox\""><img src=\""([^""]+)""", page)
	Do While m.Find
		links.Add(m.Group(1))
		Dim Job As HttpJob
		Job.Initialize("Image", Me)
		JobsIndex.Put(Job, links.Size - 1) 'we need to know the index of each job. This will allow us to later match the item with the image
		Job.Download("http://www.loc.gov/rr/print/list/" & m.Group(1))
	Loop
	Dim images(links.Size) As Bitmap
	CallSubDelayed2(Main,"CreateItems", links)
End Sub

Sub AfterActivityResume
	If links.IsInitialized Then
		CallSubDelayed2(Main,"CreateItems", links)
		For i = 0 To links.Size - 1
			If images.Length > i AND images(i).IsInitialized Then
				CallSubDelayed3(Main, "ShowImage", images(i), i)
			End If
		Next
	End If
End Sub

Sub Service_Destroy

End Sub
