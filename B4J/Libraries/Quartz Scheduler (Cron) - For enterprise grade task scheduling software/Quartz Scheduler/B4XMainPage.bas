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
	Private XUI As XUI

	Private QS As QuartzScheduler
	Private LstView1 As ListView
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Quartz Scheluler for B4J")

	XUI.SetDataFolder("Simply Software\Quartz Scheduler")

	QS.InitializeAsync("QS")
	QS.StartAsync
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	QS.ShutdownAsync
	Return True
End Sub

' ============================================================
' QUARTZ EVENTS
' ============================================================

Private Sub QS_schedulerstarted
	Log("[Quartz] SchedulerStarted")

	' --------------------------------------------------------
	' 1. SCHEDULE JOBS (NO CHAINING OF RepeatTest)
	' --------------------------------------------------------

	' Cron job every 14 seconds, group "RAD"
	Dim B4XData As Map
		B4XData.Initialize
		B4XData.Put("Message", "Hello from B4X")
		B4XData.Put("Owner", "Erel")
		B4XData.Put("Category", "Boss")
		B4XData.Put("Group", "RAD")
	QS.ScheduleJobAsync2("B4XTest", "RAD", "0/14 * * * * ?", 14, 0, B4XData)

	' Cron job every 10 seconds, group "Maintenance"
	Dim CronData As Map
		CronData.Initialize
		CronData.Put("Message", "Hello from cron")
		CronData.Put("Owner", "Peter")
		CronData.Put("Category", "System")
		CronData.Put("Group", "Maintenance")
	QS.ScheduleJobAsync2("CronTest", "Maintenance", "0/10 * * * * ?", 0, 0, CronData)

	' Repeating job every 5 seconds, group "Background"
	Dim RepeatData As Map
		RepeatData.Initialize
		RepeatData.Put("Message", "Repeating job")
		RepeatData.Put("Owner", "Peter")
		RepeatData.Put("Category", "BackgroundTask")
		RepeatData.Put("Group", "Background")
	QS.ScheduleJobAsync2("RepeatTest", "Background", "", 5, 0, RepeatData)

	' NO SetJobChain here – RepeatTest fires ONLY on its own schedule

	' --------------------------------------------------------
	' 2. INITIAL LOG DUMP
	' --------------------------------------------------------
	Log("[Quartz] Initial Log Dump:")
	For Each line As String In QS.GetLog
		Log(line)
	Next

	' --------------------------------------------------------
	' 3. INITIAL JOB DASHBOARD REFRESH
	' --------------------------------------------------------
	RefreshJobDashboard
End Sub

Private Sub QS_jobstarted(JobName As String)
	Log($"[Quartz] JobStarted: ${JobName}"$)
End Sub

Private Sub QS_jobfinished(JobName As String)
	Log($"[Quartz] JobFinished: ${JobName}"$)

	' Update UI job dashboard
	RefreshJobDashboard

	' Example: append to a ListView named lvLog (if present in layout)
	If LstView1.IsInitialized Then
		LstView1.Items.Add($"Finished: ${JobName} at ${DateTime.Time(DateTime.Now)}"$)
	End If
End Sub

Private Sub QS_joberror(JobName As String, Error As String)
	Log($"[Quartz] JobError: ${JobName} | ${Error}"$)
End Sub

Private Sub QS_jobscheduled(JobName As String)
	Log($"[Quartz] JobScheduled: ${JobName}"$)
	RefreshJobDashboard
End Sub

Private Sub QS_jobdeleted(JobName As String)
	Log($"[Quartz] JobDeleted: ${JobName}"$)
	RefreshJobDashboard
End Sub

Private Sub QS_jobexecute(JobName As String, Data As Map)
	Log($"[Quartz] JobExecute: ${JobName}, Data=${Data}"$)

	' Optional: keep a per-job history in UI
	If LstView1.IsInitialized Then
		LstView1.Items.Add($"Execute: ${JobName} at ${DateTime.Time(DateTime.Now)} | Data=${Data}"$)
	End If
End Sub

Private Sub QS_schedulererror(Error As String)
	If Error = Null Or Error = "" Then Return
	Log($"[Quartz] SchedulerError: ${Error}"$)
End Sub

Private Sub QS_schedulershutdown
	Log("[Quartz] SchedulerShutdown")
End Sub


' ============================================================
' JOB DASHBOARD / STATUS / NEXT RUN / GROUPS / METADATA
' ============================================================

Private Sub RefreshJobDashboard
	' This assumes a ListView named lvJobs in the layout.
	' Each line: JobName | Group | Status | NextRun
	If LstView1.IsInitialized = False Then Return
	LstView1.Items.Clear

	Dim Jobs As List = QS.ListJobs
	For Each j As String In Jobs
		Dim status As String
		If QS.JobExists(j) Then
			status = "Scheduled"
		Else
			status = "Deleted"
		End If

		Dim nextRun As Long = QS.GetNextRunTime(j)
		Dim nextRunText As String
		If nextRun = 0 Then
			nextRunText = "None"
		Else
			nextRunText = DateTime.Time(nextRun)
		End If

		Dim info As Map = QS.GetJobDetailInfo(j) ' expected to contain Group, Description, etc.
		Dim groupName As String
		If info.IsInitialized And info.ContainsKey("Group") Then
			groupName = info.Get("Group")
		Else
			groupName = "(default)"
		End If

		LstView1.Items.Add($"${j} | Group=${groupName} | Status=${status} | Next=${nextRunText}"$)
	Next
End Sub

' ============================================================
' UI BUTTONS – RUN NOW / STATUS / METADATA / HISTORY / GROUPS
' ============================================================

' --- RUN NOW (B) ---

Public Sub btnRunCronNow_Click
	QS.RunJobNow("CronTest")
	Log("[UI] RunNow: CronTest")
End Sub

Public Sub btnRunRepeatNow_Click
	QS.RunJobNow("RepeatTest")
	Log("[UI] RunNow: RepeatTest")
End Sub

' --- REFRESH DASHBOARD (C + D + F) ---

Public Sub btnRefreshJobs_Click
	RefreshJobDashboard
	Log("[UI] Refreshed job dashboard")
End Sub

' --- JOB METADATA VIEWER (E) ---

Public Sub btnShowCronMetadata_Click
	Dim data As Map = QS.GetJobData("CronTest")
	Dim info As Map = QS.GetJobDetailInfo("CronTest")
	Log("[UI] CronTest JobData: " & data)
	Log("[UI] CronTest JobInfo: " & info)
End Sub

Public Sub btnShowRepeatMetadata_Click
	Dim data As Map = QS.GetJobData("RepeatTest")
	Dim info As Map = QS.GetJobDetailInfo("RepeatTest")
	Log("[UI] RepeatTest JobData: " & data)
	Log("[UI] RepeatTest JobInfo: " & info)
End Sub

' --- JOB HISTORY (G) ---

Public Sub btnShowCronHistory_Click
	Dim hist As List = QS.GetJobLog("CronTest") ' last N entries per job
	Log("[UI] CronTest history:")
	For Each line As String In hist
		Log(line)
	Next
End Sub

Public Sub btnShowRepeatHistory_Click
	Dim hist As List = QS.GetJobLog("RepeatTest")
	Log("[UI] RepeatTest history:")
	For Each line As String In hist
		Log(line)
	Next
End Sub

' --- JOB CONTROL (CANCEL / PAUSE / RESUME / DELETE) ---

Public Sub btnPauseCron_Click
	QS.PauseJob("CronTest")
	Log("[UI] Paused CronTest")
	RefreshJobDashboard
End Sub

Public Sub btnResumeCron_Click
	QS.ResumeJob("CronTest")
	Log("[UI] Resumed CronTest")
	RefreshJobDashboard
End Sub

Public Sub btnDeleteCron_Click
	QS.DeleteJob("CronTest")
	Log("[UI] Deleted CronTest")
	RefreshJobDashboard
End Sub

Public Sub btnPauseRepeat_Click
	QS.PauseJob("RepeatTest")
	Log("[UI] Paused RepeatTest")
	RefreshJobDashboard
End Sub

Public Sub btnResumeRepeat_Click
	QS.ResumeJob("RepeatTest")
	Log("[UI] Resumed RepeatTest")
	RefreshJobDashboard
End Sub

Public Sub btnDeleteRepeat_Click
	QS.DeleteJob("RepeatTest")
	Log("[UI] Deleted RepeatTest")
	RefreshJobDashboard
End Sub

' --- GROUP DASHBOARD / CONTROL (F) ---

Public Sub btnPauseMaintenanceGroup_Click
	QS.PauseGroup("Maintenance")
	Log("[UI] Paused group Maintenance")
	RefreshJobDashboard
End Sub

Public Sub btnResumeMaintenanceGroup_Click
	QS.ResumeGroup("Maintenance")
	Log("[UI] Resumed group Maintenance")
	RefreshJobDashboard
End Sub

Public Sub btnDeleteMaintenanceGroup_Click
	QS.DeleteGroup("Maintenance")
	Log("[UI] Deleted group Maintenance")
	RefreshJobDashboard
End Sub

Public Sub btnPauseBackgroundGroup_Click
	QS.PauseGroup("Background")
	Log("[UI] Paused group Background")
	RefreshJobDashboard
End Sub

Public Sub btnResumeBackgroundGroup_Click
	QS.ResumeGroup("Background")
	Log("[UI] Resumed group Background")
	RefreshJobDashboard
End Sub

Public Sub btnDeleteBackgroundGroup_Click
	QS.DeleteGroup("Background")
	Log("[UI] Deleted group Background")
	RefreshJobDashboard
End Sub

' --- GLOBAL LOG VIEWER (JOB LOGGING) ---

Public Sub btnShowGlobalLog_Click
	Log("[UI] Full Quartz log:")
	Dim all As List = QS.GetLog
	For Each line As String In all
		Log(line)
	Next
End Sub

' --- TEST TRIGGER INSPECTION ---

Public Sub btnTestTriggers_Click
	Log("[TEST] Inspecting triggers for CronTest...")

	Try
		Dim triggers As List = QS.GetTriggerInfo("CronTest") 

		If triggers.Size = 0 Then
			Log("[TEST] No triggers found.")
			Return
		End If

		For Each t As Map In triggers
			Log("TriggerKey: " & t.Get("TriggerKey"))
			Log("NextFireTime: " & IIf(t.Get("NextFireTime").As(Int) = 0, "None", DateTime.Time(t.Get("NextFireTime"))))

			Log("PreviousFireTime: " & IIf(t.Get("PreviousFireTime").As(Int) = 0, "None", DateTime.Time(t.Get("PreviousFireTime"))))
			Log("----------------------------")
		Next
	Catch
		Log("[TEST] Trigger inspection ERROR: " & LastException.Message)
	End Try
End Sub

' --- TEST GROUP LISTING ---

Public Sub btnTestGroups_Click
	Log("[TEST] Listing all job groups...")

	Try
		Dim groups As List = QS.ListGroups

		If groups.Size = 0 Then
			Log("[TEST] No groups found.")
			Return
		End If

		For Each g As String In groups
			Log("Group: " & g)
		Next
	Catch
		Log("[TEST] Group listing ERROR: " & LastException.Message)
	End Try
End Sub

' --- TEST JOB STATE ---

Public Sub btnTestJobState_Click
	Log("[TEST] Checking job states...")

	Try
		Dim Jobs As List
			Jobs.Initialize
			Jobs.Add("CronTest")
			Jobs.Add("RepeatTest")
			Jobs.Add("B4XTest")

		For Each j As String In Jobs
			Dim state As String = QS.GetJobState(j)
			Log($"Job: ${j} | State: ${state}"$)
		Next

	Catch
		Log("[TEST] Job state ERROR: " & LastException.Message)
	End Try
End Sub
