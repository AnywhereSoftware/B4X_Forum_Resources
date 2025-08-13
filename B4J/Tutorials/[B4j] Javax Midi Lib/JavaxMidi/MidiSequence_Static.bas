B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Code Module
Sub Process_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private JO As JavaObject
	'Constants / Fields are defined here and initialized in Sub UpdateConstants
	'The tempo-based timing type, for which the resolution is expressed in pulses (ticks) per quarter note.
	Public PPQ As Float
	'The SMPTE-based timing type with 24 frames per second (resolution is expressed in ticks per frame).
	Public SMPTE_24 As Float
	'The SMPTE-based timing type with 25 frames per second (resolution is expressed in ticks per frame).
	Public SMPTE_25 As Float
	'The SMPTE-based timing type with 30 frames per second (resolution is expressed in ticks per frame).
	Public SMPTE_30 As Float
	'The SMPTE-based timing type with 29.97 frames per second (resolution is expressed in ticks per frame).
	Public SMPTE_30DROP As Float
	Private IInitialized As Boolean

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	If IInitialized Then Return
	JO.InitializeStatic("javax.sound.midi.Sequence")
	UpdateConstants
	IInitialized = True
End Sub

Private Sub UpdateConstants
	PPQ = JO.GetField("PPQ")
	SMPTE_24 = JO.GetField("SMPTE_24")
	SMPTE_25 = JO.GetField("SMPTE_25")
	SMPTE_30 = JO.GetField("SMPTE_30")
	SMPTE_30DROP = JO.GetField("SMPTE_30DROP")
End Sub
