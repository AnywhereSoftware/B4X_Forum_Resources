B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@

Sub Class_Globals
	Private Timer As Timer
	Private TimerTickMs As Int = 5000
End Sub

Public Sub Initialize
	Timer.Initialize("Timer", TimerTickMs)
	Timer.Enabled = True
	
	StartMessageLoop '<- don't forget!
End Sub

Sub Timer_Tick
	'do the work required
	Log("Worker 2: every " & TimerTickMs)
End Sub