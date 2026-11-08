B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@

'https://github.com/gdelataillade/alarm/blob/main/lib/model/alarm_settings.dart
Sub Class_Globals
	
	Private m_Id As Int
	Private m_Date As Long
	Private m_AssetAudioPath As String
	Private m_LoopAudio As Boolean
	Private m_Vibrate As Boolean
	Private m_Volume As Double
	Private m_FadeDuration As Double
	Private m_NotificationTitle As String
	Private m_NotificationBody As String
	Private m_EnableNotificationOnKill As Boolean = True
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

#Region Methods

'Creates a duplicate of `AlarmSettings`
'Replace it with new values
Public Sub Duplicate As AS_AlarmSettings

	Dim NewAlarmSetting As AS_AlarmSettings
	NewAlarmSetting.Initialize
	NewAlarmSetting.Id = m_Id
	NewAlarmSetting.Date = m_Date
	NewAlarmSetting.AssetAudioPath = m_AssetAudioPath
	NewAlarmSetting.LoopAudio = m_LoopAudio
	NewAlarmSetting.Vibrate = m_Vibrate
	NewAlarmSetting.Volume = m_Volume
	NewAlarmSetting.FadeDuration = m_FadeDuration
	NewAlarmSetting.NotificationTitle = m_NotificationTitle
	NewAlarmSetting.NotificationBody = m_NotificationBody
	NewAlarmSetting.EnableNotificationOnKill = m_EnableNotificationOnKill
	Return NewAlarmSetting

End Sub

'Compares two AlarmSettings.
Public Sub Equals(other As Object) As Boolean
	If other = Me Then Return True
	If other = Null Then Return False
	If GetType(other) <> GetType(Me) Then Return False
    
	Dim otherAlarmSettings As AS_AlarmSettings = other
	Return m_Id = otherAlarmSettings.Id And _
           m_Date = otherAlarmSettings.Date And _
           m_AssetAudioPath = otherAlarmSettings.AssetAudioPath And _
           m_LoopAudio = otherAlarmSettings.LoopAudio And _
           m_Vibrate = otherAlarmSettings.Vibrate And _
           m_Volume = otherAlarmSettings.Volume And _
           m_FadeDuration = otherAlarmSettings.FadeDuration And _
           m_NotificationTitle = otherAlarmSettings.NotificationTitle And _
           m_NotificationBody = otherAlarmSettings.NotificationBody And _
           m_EnableNotificationOnKill = otherAlarmSettings.EnableNotificationOnKill
End Sub

#End Region

#Region Properties

'Unique identifier assiocated with the alarm. Cannot be 0 or -1
Public Sub setId(Id As Int)
	m_Id = Id
End Sub

Public Sub getId As Int
	Return m_Id
End Sub

'Date and time when the alarm will be triggered.
Public Sub setDate(Date As Long)
	m_Date = Date
End Sub

Public Sub getDate As Long
	Return m_Date
End Sub

'Path to audio asset to be used as the alarm ringtone
Public Sub setAssetAudioPath(AssetAudioPath As String)
	m_AssetAudioPath = AssetAudioPath
End Sub

Public Sub getAssetAudioPath As String
	Return m_AssetAudioPath
End Sub

'If true, [assetAudioPath] will repeat indefinitely until alarm is stopped.
Public Sub setLoopAudio(LoopAudio As Boolean)
	m_LoopAudio = LoopAudio
End Sub

Public Sub getLoopAudio As Boolean
	Return m_LoopAudio
End Sub

'If true, device will vibrate for 500ms, pause for 500ms and repeat until alarm is stopped.
'If [loopAudio] is set to false, vibrations will stop when audio ends.
Public Sub setVibrate(Vibrate As Boolean)
	m_Vibrate = Vibrate
End Sub

Public Sub getVibrate As Boolean
	Return m_Vibrate
End Sub

'Specifies the system volume level to be set at the designated [date].
'Accepts a value between 0 (mute) and 1 (maximum volume).
'When the alarm is triggered at [date], the system volume adjusts to this specified level. Upon stopping the alarm, the system volume reverts to its prior setting.
Public Sub setVolume(Volume As Double)
	m_Volume = Min(1,Max(0,Volume))
End Sub

Public Sub getVolume As Double
	Return m_Volume
End Sub

'Duration, in seconds, over which to fade the alarm ringtone.
'Set to 0 by default, which means no fade.
Public Sub setFadeDuration(FadeDuration As Double)
	m_FadeDuration = FadeDuration
End Sub

Public Sub getFadeDuration As Double
	Return m_FadeDuration
End Sub

'Title of the notification to be shown when alarm is triggered.
Public Sub setNotificationTitle(NotificationTitle As String)
	m_NotificationTitle = NotificationTitle
End Sub

Public Sub getNotificationTitle As String
	Return m_NotificationTitle
End Sub

'Body of the notification to be shown when alarm is triggered.
Public Sub setNotificationBody(NotificationBody As String)
	m_NotificationBody = NotificationBody
End Sub

Public Sub getNotificationBody As String
	Return m_NotificationBody
End Sub

'Whether to show a notification when application is killed by user.
'-iOS: the alarm will not trigger if the app is killed.
'Default: True
Public Sub setEnableNotificationOnKill(EnableNotificationOnKill As Boolean)
	m_EnableNotificationOnKill = EnableNotificationOnKill
End Sub

Public Sub getEnableNotificationOnKill As Boolean
	Return m_EnableNotificationOnKill
End Sub

#End Region
