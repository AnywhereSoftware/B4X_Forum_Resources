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
	
	'PPQ - Test
	Dim Const DIVTYPE_PPQ As Float = 0
	Dim Const DIVTYPE_SMPTE_24 As Float = 24.0
	Dim Const DIVTYPE_SMPTE_25 As Float = 25.0
	Dim Const DIVTYPE_SMPTE_30 As Float = 30.0
	Dim Const DIVTYPE_SMPTE_30DROP As Float = 29.969999313354492
	Private CurrentSequencer As MidiSequencer
	
'	Dim IndexedEvents As Map
	'Type IndexedEventsType(Tick As Long,msg() As Byte)

End Sub
'@SLHide
Sub SetSequencer(Seqr As MidiSequencer) As MidiSequencer
	CurrentSequencer = Seqr
	Return Seqr
End Sub
'@SLHide
Sub GetSequencer As MidiSequencer
	Return CurrentSequencer
End Sub

