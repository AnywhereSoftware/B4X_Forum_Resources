B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
'KDB_VV_Mute
Sub MuteVideo(videov As VideoView)
	Dim r1, r2 As Reflector
	r1.Target = videov
	r1.Target = r1.GetField("mMediaPlayer")
	If r1.Target = Null Then
		CallSubDelayed2(Me, "MuteVideo", videov)
		Return
	End If
	Dim mp As MediaPlayer
	r2.Target = mp
	r2.SetField2("mp", r1.Target)
	mp.SetVolume(0,0)
End Sub

Sub UnMuteVideo(videov As VideoView)
	Dim r1, r2 As Reflector
	r1.Target = videov
	r1.Target = r1.GetField("mMediaPlayer")
	If r1.Target = Null Then
		CallSubDelayed2(Me, "UnMuteVideo", videov)
		Return
	End If
	Dim mp As MediaPlayer
	r2.Target = mp
	r2.SetField2("mp", r1.Target)
	mp.SetVolume(1,1)
End Sub