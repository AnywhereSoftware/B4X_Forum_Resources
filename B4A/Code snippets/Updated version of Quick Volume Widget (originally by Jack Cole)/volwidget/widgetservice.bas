Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=1.60
@EndOfDesignText@
#Region Module Attributes
	#StartAtBoot: False
#End Region

'Service module
Sub Process_Globals
	Dim rv As RemoteViews
	Dim currenttext As String
	Dim phonevolume As Phone
	Dim normal_ring, normal_music, normal_notification, normal_system As Int	
End Sub
Sub Service_Create
	rv = ConfigureHomeWidget("L1", "rv", 360, "Volume Widget")
End Sub


Sub set_defaults
	normal_ring=StateManager.getSetting2("volume_ring",phonevolume.GetVolume(phonevolume.VOLUME_RING))
	normal_music=StateManager.getSetting2("volume_music",phonevolume.GetVolume(phonevolume.VOLUME_MUSIC))
	normal_notification=StateManager.getSetting2("volume_notification",phonevolume.GetVolume(phonevolume.VOLUME_NOTIFICATION))
	normal_system=StateManager.getSetting2("volume_system",phonevolume.GetVolume(phonevolume.VOLUME_SYSTEM))
	
	StateManager.SetSetting("volume_ring", normal_ring)
	StateManager.SetSetting("volume_music",normal_music)
	StateManager.SetSetting("volume_notification",normal_notification)
	StateManager.SetSetting("volume_system",normal_system)
	phonevolume.SetVolume(phonevolume.VOLUME_RING,normal_ring,False)
	phonevolume.SetVolume(phonevolume.VOLUME_MUSIC,normal_music,False)
	phonevolume.SetVolume(phonevolume.VOLUME_NOTIFICATION,normal_notification,False)
	phonevolume.SetVolume(phonevolume.VOLUME_SYSTEM,normal_system,False)
	StateManager.SaveSettings
End Sub

Sub Service_Start (StartingIntent As Intent)
	
	StateManager.settingsFileName="settings.txt"
	StateManager.loadStateFile
	If StateManager.getSetting("volume_ring")="" Then set_defaults
	normal_ring=StateManager.getSetting2("volume_ring",phonevolume.GetVolume(phonevolume.VOLUME_RING))
	normal_music=StateManager.getSetting2("volume_music",phonevolume.GetVolume(phonevolume.VOLUME_MUSIC))
	normal_notification=StateManager.getSetting2("volume_notification",phonevolume.GetVolume(phonevolume.VOLUME_NOTIFICATION))
	normal_system=StateManager.getSetting2("volume_system",phonevolume.GetVolume(phonevolume.VOLUME_SYSTEM))
	currenttext=StateManager.GetSetting2("State","Normal")
	rv.Settext("label1",currenttext)
	set_sound_state
	rv.UpdateWidget
	If rv.HandleWidgetEvents(StartingIntent) Then Return
End Sub

Sub rv_RequestUpdate
	rv.UpdateWidget
End Sub

Sub rv_Disabled
	StopService("")
End Sub

Sub Service_Destroy

End Sub

Sub set_sound_level(per As Float)
	phonevolume.SetRingerMode(phonevolume.RINGER_NORMAL)
	phonevolume.SetVolume(phonevolume.VOLUME_RING,phonevolume.GetMaxVolume(phonevolume.VOLUME_RING)*per,False)
	phonevolume.SetVolume(phonevolume.VOLUME_MUSIC,phonevolume.GetMaxVolume(phonevolume.VOLUME_MUSIC)*per,False)
	phonevolume.SetVolume(phonevolume.VOLUME_NOTIFICATION,phonevolume.GetMaxVolume(phonevolume.VOLUME_NOTIFICATION)*per,False)
	phonevolume.SetVolume(phonevolume.VOLUME_SYSTEM,phonevolume.GetMaxVolume(phonevolume.VOLUME_SYSTEM)*per,False)
	rv.SetImage("imageview1",LoadBitmap(File.DirAssets,"speaker.png"))
End Sub

Sub set_sound_state
Select currenttext
Case "Phone Only":
						phonevolume.SetRingerMode(phonevolume.RINGER_NORMAL)
						phonevolume.SetVolume(phonevolume.VOLUME_MUSIC,0,False)
						phonevolume.SetVolume(phonevolume.VOLUME_NOTIFICATION,0,False)
						phonevolume.SetVolume(phonevolume.VOLUME_RING,normal_ring,False)
						phonevolume.SetVolume(phonevolume.VOLUME_SYSTEM,normal_system,False)
						rv.SetImage("imageview1",LoadBitmap(File.DirAssets,"speaker.png"))
Case "Vibrate":
						phonevolume.SetRingerMode(phonevolume.RINGER_VIBRATE)
						rv.SetImage("imageview1",LoadBitmap(File.DirAssets,"vibrate.png"))
Case "Silent":
						phonevolume.SetRingerMode(phonevolume.RINGER_SILENT)
						rv.SetImage("imageview1",LoadBitmap(File.DirAssets,"mute.png"))
Case "Normal":
						phonevolume.SetRingerMode(phonevolume.RINGER_NORMAL)
						phonevolume.SetVolume(phonevolume.VOLUME_RING,normal_ring,False)
						phonevolume.SetVolume(phonevolume.VOLUME_MUSIC,normal_music,False)
						phonevolume.SetVolume(phonevolume.VOLUME_NOTIFICATION,normal_notification,False)
						phonevolume.SetVolume(phonevolume.VOLUME_SYSTEM,normal_system,False)
						rv.SetImage("imageview1",LoadBitmap(File.DirAssets,"speaker.png"))
Case "Quiet":			set_sound_level(.10)
Case "Medium":			set_sound_level(.5)
Case "Loud":			set_sound_level(.90)						
End Select
End Sub

Sub update_sound_state
	
	Select currenttext
		Case "Normal" : rv.SetText("Label1","Phone Only")
						currenttext="Phone Only"
		Case "Phone Only" : rv.SetText("Label1","Vibrate")
						currenttext="Vibrate"
		Case "Vibrate" : rv.Settext("label1","Silent")
						 currenttext="Silent"
		Case "Silent" : rv.Settext("label1","Quiet")
						 currenttext="Quiet"
		Case "Quiet" :rv.Settext("label1","Medium")
						 currenttext="Medium"
		Case "Medium":rv.Settext("label1","Loud")
						 currenttext="Loud"
		Case "Loud"	 :rv.Settext("label1","Normal")
						 currenttext="Normal"
	End Select
	set_sound_state
	StateManager.SetSetting("State",currenttext)
	StateManager.SaveSettings
	rv.UpdateWidget
End Sub

Sub Label1_Click
	update_sound_state
End Sub

Sub imageview1_Click
	update_sound_state
End Sub


