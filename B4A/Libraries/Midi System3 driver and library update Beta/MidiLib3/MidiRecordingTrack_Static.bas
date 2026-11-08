B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module

'Subs in this code module will be accessible from all modules.

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private Lock As Lock
	Lock.Initialize(False)  'ignore
	
End Sub
'@SLHide
Sub GetRT(RT As List,T As MidiTrack) As MidiRecordingTrack
	Lock.Wait
	For Each R As MidiRecordingTrack In RT
		If R.Track = T Then 
			Lock.Unlock
			Return R
		End If
	Next
	Lock.Unlock
	Dim R As MidiRecordingTrack
	Return R
End Sub
'@SLHide
Sub getTrack(RT As List,ch As Int) As MidiTrack
	Lock.Wait
	For Each R As MidiRecordingTrack In RT
		If R.channel = ch Or ch = -1 Then 
			Lock.Unlock
			Return R.Track
		End If
	Next
	Lock.Unlock
	Dim T As MidiTrack
	Return T
End Sub