B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=13.4
@EndOfDesignText@
Sub Process_Globals
	Dim rv As RemoteViews
	Dim currenttext As String
	Dim phonevolume As Phone
	Dim normal_ring, normal_music, normal_notification, normal_system As Int
End Sub

Sub Receiver_Receive(FirstTime As Boolean, StartingIntent As Intent)
	If FirstTime Then
		rv = ConfigureHomeWidget("layout1", "rv", 360, "Volume Widget")
	End If
	
'	The size of the base panel in the layout determines the minimum width and minimum height properties of the widget


	StateManager.settingsFileName = "settings.txt"
	StateManager.LoadStateFile

	If StateManager.getSetting("volume_ring") = "" Then set_defaults

	normal_ring         = StateManager.getSetting2("volume_ring",        phonevolume.GetVolume(phonevolume.VOLUME_RING))
	normal_music        = StateManager.getSetting2("volume_music",       phonevolume.GetVolume(phonevolume.VOLUME_MUSIC))
	normal_notification = StateManager.getSetting2("volume_notification",phonevolume.GetVolume(phonevolume.VOLUME_NOTIFICATION))
	normal_system       = StateManager.getSetting2("volume_system",      phonevolume.GetVolume(phonevolume.VOLUME_SYSTEM))

	currenttext = StateManager.GetSetting2("State", "Normal")
	rv.SetText("Label1", currenttext)
	set_sound_state
	rv.UpdateWidget

	If rv.HandleWidgetEvents(StartingIntent) Then Return
End Sub

Sub set_defaults
	normal_ring         = StateManager.getSetting2("volume_ring",        phonevolume.GetVolume(phonevolume.VOLUME_RING))
	normal_music        = StateManager.getSetting2("volume_music",       phonevolume.GetVolume(phonevolume.VOLUME_MUSIC))
	normal_notification = StateManager.getSetting2("volume_notification",phonevolume.GetVolume(phonevolume.VOLUME_NOTIFICATION))
	normal_system       = StateManager.getSetting2("volume_system",      phonevolume.GetVolume(phonevolume.VOLUME_SYSTEM))

	StateManager.SetSetting("volume_ring",         normal_ring)
	StateManager.SetSetting("volume_music",        normal_music)
	StateManager.SetSetting("volume_notification", normal_notification)
	StateManager.SetSetting("volume_system",       normal_system)

	phonevolume.SetVolume(phonevolume.VOLUME_RING,         normal_ring,         False)
	phonevolume.SetVolume(phonevolume.VOLUME_MUSIC,        normal_music,        False)
	phonevolume.SetVolume(phonevolume.VOLUME_NOTIFICATION, normal_notification, False)
	phonevolume.SetVolume(phonevolume.VOLUME_SYSTEM,       normal_system,       False)
	StateManager.SaveSettings
End Sub

Sub rv_RequestUpdate
	rv.UpdateWidget
End Sub

Sub rv_Disabled
	' Cleaning if necessary
End Sub

Sub set_sound_level(per As Float)
	phonevolume.SetRingerMode(phonevolume.RINGER_NORMAL)
	phonevolume.SetVolume(phonevolume.VOLUME_RING,         phonevolume.GetMaxVolume(phonevolume.VOLUME_RING)         * per, False)
	phonevolume.SetVolume(phonevolume.VOLUME_MUSIC,        phonevolume.GetMaxVolume(phonevolume.VOLUME_MUSIC)        * per, False)
	phonevolume.SetVolume(phonevolume.VOLUME_NOTIFICATION, phonevolume.GetMaxVolume(phonevolume.VOLUME_NOTIFICATION) * per, False)
	phonevolume.SetVolume(phonevolume.VOLUME_SYSTEM,       phonevolume.GetMaxVolume(phonevolume.VOLUME_SYSTEM)       * per, False)
	rv.SetImage("imageview1", LoadBitmap(File.DirAssets, "speaker.png"))
End Sub

Sub set_sound_state
	Dim granted As Boolean
	granted = PermissionManager.IsNotificationPolicyGranted
	
	Select currenttext
		Case "Phone Only"
			If granted Then phonevolume.SetRingerMode(phonevolume.RINGER_NORMAL)
			phonevolume.SetVolume(phonevolume.VOLUME_MUSIC,        0,            False)
			phonevolume.SetVolume(phonevolume.VOLUME_NOTIFICATION, 0,            False)
			phonevolume.SetVolume(phonevolume.VOLUME_RING,         normal_ring,  False)
			phonevolume.SetVolume(phonevolume.VOLUME_SYSTEM,       normal_system,False)
			rv.SetImage("imageview1", LoadBitmap(File.DirAssets, "speaker.png"))
		Case "Vibrate"
			If granted Then phonevolume.SetRingerMode(phonevolume.RINGER_VIBRATE)
			rv.SetImage("imageview1", LoadBitmap(File.DirAssets, "vibrate.png"))
		Case "Silent"
			If granted Then phonevolume.SetRingerMode(phonevolume.RINGER_SILENT)
			rv.SetImage("imageview1", LoadBitmap(File.DirAssets, "mute.png"))
		Case "Normal"
			If granted Then phonevolume.SetRingerMode(phonevolume.RINGER_NORMAL)
			phonevolume.SetVolume(phonevolume.VOLUME_RING,         normal_ring,         False)
			phonevolume.SetVolume(phonevolume.VOLUME_MUSIC,        normal_music,        False)
			phonevolume.SetVolume(phonevolume.VOLUME_NOTIFICATION, normal_notification, False)
			phonevolume.SetVolume(phonevolume.VOLUME_SYSTEM,       normal_system,       False)
			rv.SetImage("imageview1", LoadBitmap(File.DirAssets, "speaker.png"))
		Case "Quiet"  : set_sound_level(0.10)
		Case "Medium" : set_sound_level(0.50)
		Case "Loud"   : set_sound_level(0.90)
	End Select
End Sub

Sub update_sound_state
	Select currenttext
		Case "Normal"     : currenttext = "Phone Only"
		Case "Phone Only" : currenttext = "Vibrate"
		Case "Vibrate"    : currenttext = "Silent"
		Case "Silent"     : currenttext = "Quiet"
		Case "Quiet"      : currenttext = "Medium"
		Case "Medium"     : currenttext = "Loud"
		Case "Loud"       : currenttext = "Normal"
	End Select
	
	rv.SetText("Label1", currenttext)
	set_sound_state
	StateManager.SetSetting("State", currenttext)
	StateManager.SaveSettings
	rv.UpdateWidget
End Sub

Sub Label1_Click
	update_sound_state
End Sub

Sub imageview1_Click
	update_sound_state
End Sub

