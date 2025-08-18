B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private TempCounter As Int
	Private TrackerIndex As Int
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	xui.SetDataFolder("MultipartWithProgress")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Dim fd As MultipartFileData
	fd.Initialize
	fd.KeyName = "file"
	fd.Dir = File.DirAssets
	fd.FileName = "1.txt"
	Dim job As HttpJob = CreateMultipartJob("https://ptsv2.com/t/y84m6-1619521716/post", Null, Array(fd))
	Wait For (job) JobDone (job As HttpJob)
	Log(job)
	File.Delete(xui.DefaultFolder, job.Tag)
	job.Release
End Sub

Public Sub CreateMultipartJob(Link As String, NameValues As Map, Files As List) As HttpJob
	Dim boundary As String = "---------------------------1461124740692"
	TempCounter = TempCounter + 1
	Dim TempFileName As String = "post-" & TempCounter
	Dim stream As OutputStream = File.OpenOutput(xui.DefaultFolder, TempFileName, False)
	Dim b() As Byte
	Dim eol As String = Chr(13) & Chr(10)
	Dim empty As Boolean = True
	If NameValues <> Null And NameValues.IsInitialized Then
		For Each key As String In NameValues.Keys
			Dim value As String = NameValues.Get(key)
			empty = MultipartStartSection (stream, empty)
			Dim s As String = _
$"--${boundary}
Content-Disposition: form-data; name="${key}"

${value}"$
			b = s.Replace(CRLF, eol).GetBytes("UTF8")
			stream.WriteBytes(b, 0, b.Length)
		Next
	End If
	If Files <> Null And Files.IsInitialized Then
		For Each fd As MultipartFileData In Files
			empty = MultipartStartSection (stream, empty)
			Dim s As String = _
$"--${boundary}
Content-Disposition: form-data; name="${fd.KeyName}"; filename="${fd.FileName}"
Content-Type: ${fd.ContentType}

"$
			b = s.Replace(CRLF, eol).GetBytes("UTF8")
			stream.WriteBytes(b, 0, b.Length)
			Dim in As InputStream = File.OpenInput(fd.Dir, fd.FileName)
			File.Copy2(in, stream)
		Next
	End If
	empty = MultipartStartSection (stream, empty)
	s = _
$"--${boundary}--
"$
	b = s.Replace(CRLF, eol).GetBytes("UTF8")
	stream.WriteBytes(b, 0, b.Length)
	Dim job As HttpJob
	job.Initialize("", Me)
	stream.Close
	Dim length As Int = File.Size(xui.DefaultFolder, TempFileName)
	Dim in As InputStream = File.OpenInput(xui.DefaultFolder, TempFileName)
	Dim cin As CountingInputStream
	cin.Initialize(in)
	Dim req As OkHttpRequest = job.GetRequest
	req.InitializePost(Link, cin, length)
	req.SetContentType("multipart/form-data; boundary=" & boundary)
	req.SetContentEncoding("UTF8")
	TrackProgress(cin, length)
	job.Tag = TempFileName
	CallSubDelayed2(HttpUtils2Service, "SubmitJob", job)
	Return job
End Sub

Private Sub MultipartStartSection (stream As OutputStream, empty As Boolean) As Boolean
	If empty = False Then
		stream.WriteBytes(Array As Byte(13, 10), 0, 2)
	Else
		empty = False
	End If
	Return empty
End Sub

Private Sub TrackProgress (cin As CountingInputStream, length As Int)
	TrackerIndex = TrackerIndex + 1
	Dim MyIndex As Int = TrackerIndex
	Do While MyIndex = TrackerIndex
		Log($"$1.2{cin.Count * 100 / length}%"$)
		If cin.Count = length Then Exit
		Sleep(100)
	Loop
	
End Sub
