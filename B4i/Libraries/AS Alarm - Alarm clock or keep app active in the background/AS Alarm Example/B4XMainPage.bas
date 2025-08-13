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

	Private Picker1 As Picker
	Private Label2 As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	Picker1.SetRowsHeight(35)
	
	Dim lst_Minutes As List
	lst_Minutes.Initialize
	For i = 1 To 121 -1
		Dim s As AttributedString
		s.Initialize(i,xui.CreateDefaultBoldFont(25),xui.Color_White)
		lst_Minutes.Add(s)
	Next
	
	Picker1.SetItems(0,lst_Minutes)
	
	Main.App.RegisterUserNotifications(True,True,True)
	
End Sub

Private Sub xlbl_Start_Click
	
	CreateAlarm(1,DateTime.Now + DateTime.TicksPerMinute*Picker1.GetSelectedItem(0),File.Combine(File.DirAssets,"alarm_1.mp3"),False)

End Sub

Private Sub xlbl_Stop_Click
	Main.Alarm.StopAlarm(1)
	'Main.Alarm.StopAllAlarms
	Label2.Text = "Alarm stopped"
End Sub

Private Sub CreateAlarm(Id As Int,Date As Long,AssetPath As String,LoopAudio As Boolean)
	Dim NewAlarmSettings As AS_AlarmSettings
	NewAlarmSettings.Initialize
	NewAlarmSettings.Id = Id 'Unique id for the alarm
	NewAlarmSettings.Date = Date 'When the alarm should be triggered
	NewAlarmSettings.AssetAudioPath = AssetPath 'Path to the sound file
	NewAlarmSettings.LoopAudio = LoopAudio 'Should the music be played until Alarm.StopAlarm is called up
	NewAlarmSettings.Volume = 1 '0-1 Volume
	NewAlarmSettings.FadeDuration = DateTime.TicksPerSecond*11 'Should the sound be played from quiet to loud

	Main.Alarm.SetAlarm(NewAlarmSettings)
	Label2.Text = "Alarm starts: " & DateUtils.TicksToString(NewAlarmSettings.Date)

End Sub
