B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.1
@EndOfDesignText@
' ###############################################
' (C) TechDoc G. Becker - http://gbecker.de
' ###############################################
' Custom View:    BeeperDeLuxe
' Language:        	B4A
' Designer:        	No
' Version:        	2/2025
' Used Libs:    	Audio, Core, fiddlearound
'                	Phone,XUI
' ###############################################
' Usage is Roayalty free for Private and commercial
' use only for B4X-Anywhere Board Members.
' ###############################################
Sub Class_Globals
	Dim b As Beeper
	Dim timer1,timer2 As Timer
	Dim DurationMilliseconds As Long = 300
	Dim Frequency As Long = 300
End Sub

Public Sub Initialize
    b.initialize(300,300)
	timer1.Initialize("timer1", 200)
	timer2.Initialize("timer2", 200)
End Sub

Public Sub beep(Duration As Long, freq As Long)
	If DurationMilliseconds > 0 Then
		b.Initialize(DurationMilliseconds, 	Frequency)
	Else
		b.Initialize(Duration, freq)
	End If
	b.Beep
End Sub

Public Sub Vibrate(Duration As Long)
		Dim p As PhoneVibrate
		p.Vibrate(Duration)
End Sub

Public Sub beepAndVibrate(Duration As Long,Freq As Long)
	beep(Duration,Freq)
	Vibrate(Duration)
End Sub

public Sub Alarm(BeepDuration As Long, Freq As Long, AlarmDuration As Long)
	DurationMilliseconds=BeepDuration
	Frequency=Freq
	timer2.Interval=AlarmDuration
	timer1.Interval=BeepDuration
	timer1.enabled=True
	timer2.Enabled=True
End Sub

Sub timer1_tick
	beep(DurationMilliseconds, Frequency)
End Sub

Sub timer2_tick
	timer1.Enabled=False
	timer2.Enabled=False
	b.Release
End Sub


