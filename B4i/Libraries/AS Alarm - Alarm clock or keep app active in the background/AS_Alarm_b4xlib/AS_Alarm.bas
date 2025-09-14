B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@

'https://github.com/gdelataillade/alarm/blob/main/lib/alarm.dart
Sub Class_Globals
	Private xui As XUI
	Private silentAudioPlayer As MediaPlayer
	Private loudAudioPlayer As MediaPlayer
	Private m_AlarmSoundPath As String
	Private m_AlarmStorage As AS_AlarmStorage
	Private tmrMap As Map
	Private no As NativeObject
	Private Notifications As UserNotificationCenter
End Sub

'Initializes Alarm services.
'Also calls [checkAlarm] that will reschedule alarms that were set before app termination.
Public Sub Initialize
	tmrMap.Initialize
	
	Notifications.Initialize
	
	no = Me
	no.RunMethod("setAudioSession", Null)
	
	m_AlarmStorage.Initialize 'Initializes Alarm services
	CheckAlarm 'that will reschedule alarms that were set before
	
End Sub

'Checks if some alarms were set on previous session.
'If it's the case then reschedules them.
Private Sub CheckAlarm
	
	Dim alarms As List = m_AlarmStorage.GetSavedAlarms
	For Each alarm As AS_AlarmSettings In alarms
		If alarm.Date > DateTime.Now Then
			SetAlarm(alarm)
		Else
			
			Wait For (isRinging(alarm.Id)) Complete (itRings As Boolean)
			
			If itRings Then
				'Let it ring
			Else
				StopAlarm(alarm.Id)
			End If
			
		End If
	Next
	
End Sub

'Schedules an alarm with given [alarmSettings] with its notification.
'If you set an alarm for the same dateTime as an existing one, the new alarm will replace the existing one.
Public Sub SetAlarm(alarmSettings As AS_AlarmSettings) As Boolean
	' Überprüfe die AlarmSettings
	If AlarmSettingsValidation(alarmSettings) = False Then
		Return False
	End If

	' Stoppe bestehende Alarme, die dieselbe ID oder dasselbe Datum/Zeit haben
	Dim alarms As List = m_AlarmStorage.GetSavedAlarms
	For Each alarm As AS_AlarmSettings In alarms
		If alarm.Id = alarmSettings.Id Or (alarm.Date = alarmSettings.Date) Then
			For Each key As Object In tmrMap.Keys
				If tmrMap.Get(key).As(AS_AlarmSettings).Id = alarm.Id Then
					key.As(Timer).Enabled = False 'Deactivate running timer
					tmrMap.Remove(key)
					Exit
				End If
			Next
			m_AlarmStorage.UnsaveAlarm(alarm.Id)
		End If
	Next

	m_AlarmStorage.SaveAlarm(alarmSettings) 'Save the new alarm

	Dim Interval As Long = alarmSettings.Date - DateTime.Now 'Interval when the timer should trigger
	
	'Todo: UserNotificationCenter - set Notifiation


	'To ensure that the main timer is triggered on time, we wake the app from sleep 20 seconds beforehand
	Dim WakeupTimer As Timer
	WakeupTimer.Initialize("WakeupTimer",Interval - (DateTime.TicksPerSecond*20)) '20 seconds before the actual timer starts
	WakeupTimer.Enabled = True
	tmrMap.Put(WakeupTimer,alarmSettings)

	startSilentSound 'Starts the silent sound to keep the app active in the background

	'Start Background Fetch
	Dim no2 As NativeObject = Main.App
	no2.RunMethod("setMinimumBackgroundFetchInterval:", Array(0)) '0 = minimum interval

	Return True
End Sub

Private Sub WakeupTimer_Tick
	
	Dim WakeupTimer As Timer = Sender
	Dim alarmSettings As AS_AlarmSettings = tmrMap.Get(WakeupTimer)
	WakeupTimer.Enabled = False
	
	Sleep(alarmSettings.Date - DateTime.Now)
	DoAlarm(alarmSettings)

End Sub

Private Sub DoAlarm(alarmSettings As AS_AlarmSettings)
	
	If alarmSettings.NotificationBody <> "" And alarmSettings.NotificationTitle <> "" Then
		Notifications.CreateNotificationWithContent(alarmSettings.NotificationTitle,alarmSettings.NotificationBody,"notificationOnAlarm_" & alarmSettings.Id,"",DateTime.TicksPerSecond)
	End If
	
	loudAudioPlayer.Initialize("",alarmSettings.AssetAudioPath,"loudAudioPlayer")
	loudAudioPlayer.Volume = alarmSettings.Volume
	loudAudioPlayer.Looping = alarmSettings.LoopAudio
	
	If alarmSettings.FadeDuration = 0 Then
		loudAudioPlayer.play
	Else
		loudAudioPlayer.Volume = 0.1
		loudAudioPlayer.play
		Dim StartTime As Long = DateTime.Now
		Do While (DateTime.Now - StartTime) < alarmSettings.FadeDuration
			loudAudioPlayer.Volume = 0.1 + ((DateTime.Now - StartTime)/alarmSettings.FadeDuration)*(1-0.1)
			'Log(loudAudioPlayer.Volume)
		Loop
	End If
	
End Sub

Private Sub Application_FetchDownload
	Log("FetchDownload")
	Dim ln As Notification
	ln.Initialize(DateTime.Now + DateTime.TicksPerSecond)
	ln.AlertBody = "Fetch download..."
	ln.PlaySound = True
	ln.Register
End Sub

Private Sub AlarmSettingsValidation(alarmSettings As AS_AlarmSettings) As Boolean
	If alarmSettings.Id = 0 Or alarmSettings.Id = -1 Then
		Log("AlarmException: Alarm id cannot be 0 or -1. Provided: " & alarmSettings.Id)
		Return False
	End If
	If alarmSettings.Id > 2147483647 Then
		Log("AlarmException: Alarm id cannot be set larger than Int max value (2147483647). Provided: " & alarmSettings.Id)
		Return False
	End If
	If alarmSettings.Id < -2147483648 Then
		Log("AlarmException: Alarm id cannot be set smaller than Int min value (-2147483648). Provided: " & alarmSettings.Id)
		Return False
	End If
	If alarmSettings.Volume < 0 Or alarmSettings.Volume > 1 Then
		Log("AlarmException: Volume must be between 0 and 1. Provided: " & alarmSettings.Volume)
		Return False
	End If
	If alarmSettings.FadeDuration < 0 Then
		Log("AlarmException: Fade duration must be positive. Provided: " & alarmSettings.FadeDuration)
		Return False
	End If
	Return True
End Sub

'When the app is killed, all the processes are terminated
'so the alarm may never ring. By default, to warn the user, a notification is shown at the moment he kills the app.
'This methods allows you to customize this notification content.
Public Sub SetNotificationOnAppKillContent(Title As String,Body As String)
	m_AlarmStorage.SetNotificationContentOnAppKill(Title,Body)
End Sub

'Stops alarm.
Public Sub StopAlarm(Id As Int) As Boolean
	For Each key As Object In tmrMap.Keys
		If tmrMap.Get(key).As(AS_AlarmSettings).Id = Id Then
			key.As(Timer).Enabled = False 'Deactivate running timer
			tmrMap.Remove(key)
			Exit
		End If
	Next
	m_AlarmStorage.UnsaveAlarm(Id)
	Return True
End Sub

'Stops all the alarms.
Public Sub StopAllAlarms As Boolean
	Dim alarms As List = m_AlarmStorage.GetSavedAlarms
	For Each alarm As AS_AlarmSettings In alarms
		StopAlarm(alarm.id)
	Next
	Return True
End Sub

'Whether the alarm is ringing.
Public Sub isRinging(Id As Int) As ResumableSub
	If loudAudioPlayer.IsInitialized = False Then Return False
	Dim CurrentDuration As Int = loudAudioPlayer.Position
	Sleep(50)
	If loudAudioPlayer.Position <> CurrentDuration Then Return True
	Return False
End Sub

'Whether an alarm is set.
Public Sub getHasAlarm As Boolean
	Return m_AlarmStorage.HasAlarm
End Sub

'Returns alarm by given id. Returns null if not found.
Public Sub GetAlarm(Id As Int) As AS_AlarmSettings
	If m_AlarmStorage.ContainId(Id) Then
		Return m_AlarmStorage.GetAlarm(Id)
	Else
		Log($"Alarm with id ${Id} not found."$)
		Return Null
	End If
End Sub

Public Sub GetAlarms As List
	Return m_AlarmStorage.GetSavedAlarms
End Sub

Private Sub startSilentSound
	'Plays a silent sound, so the app keeps active in the background
	silentAudioPlayer.Initialize(File.DirAssets,"long_blank.mp3","silentAudioPlayer")
	silentAudioPlayer.Volume = 0.1
	silentAudioPlayer.Looping = True
	silentAudioPlayer.play
	
End Sub

'Display notification when app is closed if an alarm is set and therefore cannot be triggered
Public Sub ApplicationTerminated
	
	Dim alarms As List = m_AlarmStorage.GetSavedAlarms
	For Each alarm As AS_AlarmSettings In alarms
		If alarm.Date > DateTime.Now And alarm.EnableNotificationOnKill Then
			Notifications.CreateNotificationWithContent(m_AlarmStorage.NotificationOnAppKillTitle,m_AlarmStorage.NotificationOnAppKillBody,"notificationOnAppKill","",DateTime.TicksPerSecond)
			Exit
		End If
	Next
	
End Sub

#Region Properties

Public Sub setAlarmSoundPath(AlarmSoundPath As String)
	m_AlarmSoundPath = AlarmSoundPath
End Sub

Public Sub getAlarmSoundPath As String
	Return m_AlarmSoundPath
End Sub

#End Region

#Region Functions

Public Sub FindNextTime(Time As Double) As Long
	If SetHours(Time) > DateTime.Now Then
		Return SetHours(Time)
	End If
	Return DateTime.Add(SetHours(Time), 0, 0, 1)
End Sub

Private Sub SetHours(st As Double) As Long
	Dim hours As Int = Floor(st)
	Dim minutes As Int = Round(60 * (st - hours))
	Return DateUtils.SetDateAndTime(DateTime.GetYear(DateTime.Now), _
  DateTime.GetMonth(DateTime.Now), DateTime.GetDayOfMonth(DateTime.Now), hours, minutes, 0)
End Sub

#End Region

'https://www.b4x.com/android/forum/threads/how-to-let-music-play-in-background-while-app-makes-sounds.50998/post-319051
#If OBJC
#import <AVFoundation/AVFoundation.h>
- (void) setAudioSession {
  AVAudioSession *audioSession = [AVAudioSession sharedInstance];
  BOOL ok;
  NSError *setCategoryError = nil;
  ok = [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers
  error:&setCategoryError];
  if (!ok) {
  NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);
  }
}

//Wenn app terminated wird, dann event auslösen
@end
@implementation B4IAppDelegate (terminate)
- (void)applicationWillTerminate:(UIApplication *)application {
    B4I* bi = [b4i_main new].bi;
[bi raiseEvent:nil event:@"application_terminate" params:nil];
}


#end if