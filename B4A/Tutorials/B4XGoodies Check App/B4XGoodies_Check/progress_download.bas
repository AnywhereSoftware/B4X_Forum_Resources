B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

	Public success, inProgress As Boolean
	Public OutFolder, OutFile As String
	
	success = False
	inProgress = False
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private ProgressBar1 As ProgressBar
	Private Label1 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("progress_download")
	Sleep(50)
	Log(Main.cUrl)
	btnDownload_Click
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub btnDownload_Click
	success = False
	inProgress = True
	Dim dd As DownloadData
	dd.url = Main.cUrl
	dd.EventName = "dd"
	dd.Target = Me
	CallSubDelayed2(DownloadService, "StartDownload", dd)
	
End Sub

Sub btnCancel_Click
	CallSubDelayed2(DownloadService, "CancelDownload", Main.cUrl)
	Sleep(100)
	inProgress = False
	success = False
	Activity.Finish
End Sub

Sub dd_Progress(Progress As Long, Total As Long)
	ProgressBar1.Progress = Progress / Total * 100
	Label1.Text = NumberFormat(Progress / 1024, 0, 0) & "KB / " & _
		NumberFormat(Total / 1024, 0, 0) & "KB"
End Sub

Sub dd_Complete(Job As HttpJob)
	LogColor("***** Job completed: " & Job.Success, Colors.Green )
	Dim out As OutputStream = File.OpenOutput(OutFolder, OutFile, False)
	File.Copy2(Job.GetInputStream, out)
	out.Close

	Job.Release
'	MsgboxAsync("Job completed: " & Job.Success,"")
	success = True
	inProgress = False
	Activity.Finish
End Sub

