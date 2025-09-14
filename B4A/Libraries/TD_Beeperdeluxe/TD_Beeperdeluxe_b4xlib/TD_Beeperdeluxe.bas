B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.1
@EndOfDesignText@
' ###############################################
' (C) TechDoc G. Becker - https://gbecker.de
' ###############################################
' Custom Class    	TD_BeeperDeLuxe
' Language:        	B4A
' Designer:        	No
' Version:        	2.5/2025
' Used Libs:    	Audio, Phone, XUI
' Files:			mixkit-classic-alarm995.wav, mixkit-critical-alarm-1004.wav
' ###############################################
' Usage is Roayalty free for Private and commercial
' use only for B4X-Anywhere Board Members.
' sound files royalty free from https://mixkit.co/free-sound-effects/alarm/
' ###############################################

#region Globals & Initialize
'## Function:	Globals
'## Tested:		2025/03
Sub Class_Globals
	Dim MP As MediaPlayer
	Dim useAlarm As Boolean = False
	Dim b As Beeper
	Dim timer1,timer2 As Timer
	Dim DurationMilliseconds As Long = 300
	Dim Frequency As Long = 300
	Dim mvib As Boolean = False
End Sub
'## Function:	Initialize
'## Tested:		2025/03
Public Sub Initialize
    b.initialize(300,300)
	timer1.Initialize("timer1", 200)
	timer2.Initialize("timer2", 200)
	'MP.Initialize2("mp")
End Sub
#end region

' ###############################################

#region Custom Properties
'## Function:	Play audio single beep tone
'## Parameter:	Duration beep, freq frequency, vib True vibrate
'## Tested:		2025/03
Public Sub beep(Duration As Long, freq As Long,vib As Boolean)
	useAlarm = False
	If DurationMilliseconds > 0 Then
		b.Initialize(DurationMilliseconds, 	Frequency)
	Else
		b.Initialize(Duration, freq)
	End If
	If vib Then 
		mvib=vib
		Vibrate(Duration)
	End If
	b.Beep
End Sub
'## Function:	vibrate phone
'## Parameter:	Duration vibrate
'## Tested:		2025/03
Public Sub Vibrate(Duration As Long)
		useAlarm = False
		Dim p As PhoneVibrate
		p.Vibrate(Duration)
End Sub
'## Function:	Play audio multiple beep tone as alarm
'## Parameter:	BeepDuration beep, freq frequency, AlarmDuration, Vi True vibrate
'## Tested:		2025/03
public Sub Alarm(BeepDuration As Long, Freq As Long, AlarmDuration As Long,vib As Boolean)
	useAlarm = False
	DurationMilliseconds=BeepDuration
	Frequency=Freq
	timer2.Interval=AlarmDuration
	timer1.Interval=BeepDuration
	timer1.enabled=True
	timer2.Enabled=True
	If vib Then 
		mvib = True
		Vibrate(AlarmDuration)
	End If
End Sub
'## Function:	Play alarm soundfile
'## Parameter:	AlarmDuration in Milliseconds, Typ 1-classic,2-critical,3-own
'##				Vib True vibrate
'##				Filename only if Typ = 3
'## Tested:		2025/03
public Sub AlarmX(Duration As Long,Typ As Int,Filename As String,Volume As Double,Vib As Boolean)
	Try
		useAlarm = True
		'# load soundfile
		' files royalty free from https://mixkit.co/free-sound-effects/alarm/
		If Typ = 1 Then
			MP.Initialize2("mp")
			MP.Load(File.DirAssets,"mixkit-critical-alarm-1004.mp3")
			MP.SetVolume(Volume,Volume)
			MP.Play
		Else If Typ = 2 Then
			MP.Initialize2("mp")
			MP.Load(File.DirAssets,"mixkit-classic-alarm-995.mp3")
			MP.Play
		Else
			If File.Exists(File.DirAssets,Filename) Then
				MP.Initialize2("mp")
				MP.Load(File.DirAssets,Filename)
				MP.SetVolume(Volume,Volume)
				MP.Play
			End If
		End If
		If Vib Then 
			Vibrate(Duration)
		End If
		timer2.Interval=Duration
		timer1.enabled=True
		timer2.Enabled=True
		
	Catch
		Log(LastException)
	End Try
End Sub
#end region

' ###############################################

#region timer
'##Function:	timer to play sound
'## tested:		2025/03
Sub timer1_tick
	If useAlarm Then
		MP.Play
	Else
		beep(DurationMilliseconds, Frequency,mvib)
	End If
End Sub
'##Function:	duration timer to stop playing
'## tested:		2025/03
Sub timer2_tick
	timer1.Enabled=False
	timer2.Enabled=False
	if mp.isinitialized then MP.Stop
	useAlarm=False
	b.Release
	mvib=False
End Sub
#end region

'###############################################
' (C) TechDoc G. Becker
'###############################################



