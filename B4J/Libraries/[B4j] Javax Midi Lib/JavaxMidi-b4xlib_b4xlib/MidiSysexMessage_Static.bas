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
	'Status byte for Special System Exclusive message (0xF7, or 247), which is used in MIDI files.
	Public SPECIAL_SYSTEM_EXCLUSIVE As Int
	'Status byte for System Exclusive message (0xF0, or 240).
	Public SYSTEM_EXCLUSIVE As Int
	Private IInitialized As Boolean

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	If IInitialized Then Return
	JO.InitializeStatic("javax.sound.midi.SysexMessage")
	UpdateConstants
	IInitialized = True
End Sub

Private Sub UpdateConstants
	SPECIAL_SYSTEM_EXCLUSIVE = JO.GetField("SPECIAL_SYSTEM_EXCLUSIVE")
	SYSTEM_EXCLUSIVE = JO.GetField("SYSTEM_EXCLUSIVE")
End Sub
