B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
'@SLHideClass
Sub Class_Globals
	Private mTrack As MidiTrack
	Private mCh As Int
End Sub

'Initializes the object.
'@SLHide
Public Sub Initialize(T As MidiTrack,Ch As Int)
	mTrack = T
	mCh = Ch
End Sub
'@SLHide
Sub getTrack As MidiTrack
	Return mTrack
End Sub
'@SLHide
Sub getChannel As Int
	Return mCh
End Sub
'@SLHide
Sub setChannel(Ch As Int)
	mCh = Ch
End Sub