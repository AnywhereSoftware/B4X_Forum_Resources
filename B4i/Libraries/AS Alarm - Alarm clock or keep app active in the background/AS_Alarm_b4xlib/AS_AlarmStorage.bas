B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@

'https://github.com/gdelataillade/alarm/blob/main/lib/service/alarm_storage.dart
'Class that handles the local storage of the alarm info.
Sub Class_Globals
	
	Private xui As XUI
	
	'Prefix to be used in local storage to identify alarm info.
	Private CONST constPrefix As String = "__alarm_id__"
	
	'Key To be used in local storage To identify
	'notification on app kill title.
	Private CONST constNotificationOnAppKillTitle As String = "notificationOnAppKillTitle"
	
	'Key To be used in local storage To identify
	'notification on app kill body.
	Private CONST constNotificationOnAppKillBody As String = "notificationOnAppKillBody"
	
	Private SharedPreferences As KeyValueStore
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	#If B4J
	SharedPreferences.Initialize(File.DirApp,"as_alarm.db")
	#Else
	SharedPreferences.Initialize(xui.DefaultFolder,"as_alarm.db")
	#End If
	'SharedPreferences.DeleteAll
End Sub

'Saves alarm info in local storage so we can restore it later in the Case app Is terminated.
Public Sub SaveAlarm(AlarmSettings As AS_AlarmSettings)
	SharedPreferences.Put(constPrefix & AlarmSettings.Id,AlarmSettings)
End Sub

'Removes alarm from local storage.
Public Sub UnsaveAlarm(Id As Int)
	SharedPreferences.Remove(constPrefix & Id)
End Sub

'Whether at least one alarm is set.
Public Sub HasAlarm As Boolean
	For Each key As String In SharedPreferences.ListKeys
		If key.StartsWith(constPrefix) Then Return True
	Next
	Return False
End Sub

'Returns all alarms info from local storage in the case app is terminated and we need to restore previously scheduled alarms.
Public Sub GetSavedAlarms As List
	Dim alarms As List
	alarms.Initialize
	For Each key As String In SharedPreferences.ListKeys
		alarms.Add(SharedPreferences.Get(key))
	Next
	Return alarms
End Sub

Public Sub GetAlarm(Id As Int) As AS_AlarmSettings
	Return SharedPreferences.Get(constPrefix & Id)
End Sub

Public Sub ContainId(Id As Int) As Boolean
	Return SharedPreferences.ContainsKey(constPrefix & Id)
End Sub
'Saves on app kill notification custom [title] and [body].
Public Sub SetNotificationContentOnAppKill(Title As String,Body As String)
	SharedPreferences.Put(constNotificationOnAppKillTitle,Title)
	SharedPreferences.Put(constNotificationOnAppKillBody,Body)
End Sub

Public Sub getNotificationOnAppKillTitle As String
	Return SharedPreferences.GetDefault(constNotificationOnAppKillTitle,"Your alarms may not ring")
End Sub

Public Sub getNotificationOnAppKillBody As String
	Return SharedPreferences.GetDefault(constNotificationOnAppKillBody,"You killed the app. Please reopen so your alarms can be rescheduled.")
End Sub