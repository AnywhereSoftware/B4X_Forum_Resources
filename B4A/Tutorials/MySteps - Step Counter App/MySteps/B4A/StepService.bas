B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=14
@EndOfDesignText@
#Region  Service Attributes
    #StartAtBoot: True
#End Region

Sub Process_Globals
	Private xui As XUI
    Private ps As PhoneSensors
    Private kvs As KeyValueStore
	Private smiley As Bitmap
    Private const KEY_DAY_START As String = "day_start_steps"
    Private const KEY_LAST_DATE As String = "last_saved_date"
    Private const KEY_STEPS_TODAY As String = "steps_today"
    Private const NOTIFICATION_ID As Int = 1001
	Private const KEY_DAILY_TARGET As String = "daily_target_steps"
	Private const KEY_GOAL_NOTIFIED_DATE As String = "goal_notified_date"
	Private const DEFAULT_TARGET As Int = 10000
End Sub

Sub Service_Create
    ' Initialize KVS
    kvs.Initialize(xui.DefaultFolder, "step_data.dat")
	
	smiley = LoadBitmapResize(File.DirAssets, "smiley.png", 24dip, 24dip, False)
	
    ' TYPE_STEP_COUNTER = 19
    ps.Initialize(19)
End Sub

Sub Service_Start (StartingIntent As Intent)
    ' 1. Start Foreground Service with Persistent Notification (Required on modern Android)
	Dim nb As NB6 ' Requires NB6 or NotificationBuilder library
	nb.Initialize("default", Application.LabelName, "DEFAULT").AutoCancel(True).SmallIcon(smiley)
	'nb.Build("Title", "Content", "tag1", Me).Notify(4) 'It will be Main (or any other activity) instead of Me if called from a service.
	nb.Build("Hi Aeric", "Keep walking!", "tag1", Main).Notify(4)
	
    ' Set Service to Foreground
	Dim n As Notification = nb.Build("Step Counter", "Tracking steps in background...", "tag1", Main)
	Service.StartForeground(NOTIFICATION_ID, n)
	
    ' 2. Start Listening to Sensor
    If ps.StartListening("Sensor") = False Then
        Log("Step counter sensor not available on this device.")
    End If
    
    ' Ensure service stays alive
    Service.StopAutomaticForeground 
End Sub

Sub Service_Destroy
	ps.StopListening
End Sub

Private Sub Sensor_SensorChanged (Values() As Float)
	Dim totalStepsSinceReboot As Int = Values(0)
	Dim todayDate As String = DateTime.Date(DateTime.Now)
    
	Dim lastSavedDate As String = kvs.GetDefault(KEY_LAST_DATE, "")
	Dim dayStartSteps As Int = kvs.GetDefault(KEY_DAY_START, -1)
    
	' 1. Handle Midnight Reset or Initial Run
	If todayDate <> lastSavedDate Or dayStartSteps = -1 Then
		dayStartSteps = totalStepsSinceReboot
		kvs.Put(KEY_DAY_START, dayStartSteps)
		kvs.Put(KEY_LAST_DATE, todayDate)
	End If
    
	' 2. Handle Device Reboot
	If totalStepsSinceReboot < dayStartSteps Then
		dayStartSteps = 0
		kvs.Put(KEY_DAY_START, dayStartSteps)
	End If
    
	' 3. Calculate & Save Steps
	Dim stepsToday As Int = totalStepsSinceReboot - dayStartSteps
	kvs.Put(KEY_STEPS_TODAY, stepsToday)
    
	' 4. Check for Daily Goal Achievement
	CheckAndNotifyGoalReached(stepsToday, todayDate)
    
	' 5. Update UI if active
	CallSubUtils_UpdateUI(stepsToday)
End Sub

Private Sub CheckAndNotifyGoalReached (stepsToday As Int, todayDate As String)
	Dim dailyTarget As Int = kvs.GetDefault(KEY_DAILY_TARGET, DEFAULT_TARGET)
	Dim lastNotifiedDate As String = kvs.GetDefault(KEY_GOAL_NOTIFIED_DATE, "")
    
	' Trigger only if steps exceed target AND haven't notified today
	If stepsToday >= dailyTarget And lastNotifiedDate <> todayDate Then
		' Mark as notified for today
		kvs.Put(KEY_GOAL_NOTIFIED_DATE, todayDate)
        
		' Show Goal Reached Notification using NB6
		Dim nbGoal As NB6
		nbGoal.Initialize("goal_channel", "Goal Achievements", "HIGH").SmallIcon(smiley)
        
		Dim nGoal As Notification = nbGoal.Build( _
            "🎉 Goal Reached!", _
            "Congratulations! You hit your goal of " & dailyTarget & " steps today!", _
            "goal_tag", _
            Main)
            
		nGoal.Notify(2001) ' Separate notification ID from background service
	End If
End Sub

Private Sub CallSubUtils_UpdateUI (steps As Int)
	If B4XPages.IsInitialized Then
		If B4XPages.GetManager.IsForeground Then
			CallSub2(B4XPages.MainPage, "UpdateStepDisplay", steps)
		End If
	End If
End Sub