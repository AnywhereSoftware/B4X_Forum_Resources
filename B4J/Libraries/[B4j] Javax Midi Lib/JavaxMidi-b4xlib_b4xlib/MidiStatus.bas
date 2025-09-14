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
	'Status byte for Active Sensing message (0xFE, or 254).
	Public ACTIVE_SENSING As Int
	'Command value for Channel Pressure (Aftertouch) message (0xD0, or 208)
	Public CHANNEL_PRESSURE As Int
	'Status byte for Continue message (0xFB, or 251).
	Public CONT As Int
	'Command value for Control Change message (0xB0, or 176)
	Public CONTROL_CHANGE As Int
	'Status byte for End of System Exclusive message (0xF7, or 247).
	Public END_OF_EXCLUSIVE As Int
	'Status byte for MIDI Time Code Quarter Frame message (0xF1, or 241).
	Public MIDI_TIME_CODE As Int
	'Command value for Note Off message (0x80, or 128)
	Public NOTE_OFF As Int
	'Command value for Note On message (0x90, or 144)
	Public NOTE_ON As Int
	'Command value for Pitch Bend message (0xE0, or 224)
	Public PITCH_BEND As Int
	'Command value for Polyphonic Key Pressure (Aftertouch) message (0xA0, or 160)
	Public POLY_PRESSURE As Int
	'Command value for Program Change message (0xC0, or 192)
	Public PROGRAM_CHANGE As Int
	'Status byte for Song Position Pointer message (0xF2, or 242).
	Public SONG_POSITION_POINTER As Int
	'Status byte for MIDI Song Select message (0xF3, or 243).
	Public SONG_SELECT As Int
	'Status byte for Start message (0xFA, or 250).
	Public START As Int
	'Status byte for Stop message (0xFC, or 252).
	Public STOP As Int
	'Status byte for System Reset message (0xFF, or 255).
	Public SYSTEM_RESET As Int
	'Status byte for Timing Clock messagem (0xF8, or 248).
	Public TIMING_CLOCK As Int
	'Status byte for Tune Request message (0xF6, or 246).
	Public TUNE_REQUEST As Int
	'Status byte for System Exclusive message (0xF0, or 240).
	Public SYSTEM_EXCLUSIVE As Int = 240
	'Status byte for Special System Exclusive message (0xF7, or 247), which is used in MIDI files. It has the same value as END_OF_EXCLUSIVE, which is used in the real-time "MIDI wire" protocol.
	Public SPECIAL_SYSTEM_EXCLUSIVE As Int = 247
	Private IInitialized As Boolean
	Private ToStringMap As Map

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	If IInitialized Then Return
	JO.InitializeStatic("javax.sound.midi.ShortMessage")
	ToStringMap.Initialize
	UpdateConstants
	IInitialized = True
End Sub

Private Sub UpdateConstants
	ACTIVE_SENSING = JO.GetField("ACTIVE_SENSING")
	CHANNEL_PRESSURE = JO.GetField("CHANNEL_PRESSURE")
	CONT = JO.GetField("CONTINUE")
	CONTROL_CHANGE = JO.GetField("CONTROL_CHANGE")
	END_OF_EXCLUSIVE = JO.GetField("END_OF_EXCLUSIVE")
	MIDI_TIME_CODE = JO.GetField("MIDI_TIME_CODE")
	NOTE_OFF = JO.GetField("NOTE_OFF")
	NOTE_ON = JO.GetField("NOTE_ON")
	PITCH_BEND = JO.GetField("PITCH_BEND")
	POLY_PRESSURE = JO.GetField("POLY_PRESSURE")
	PROGRAM_CHANGE = JO.GetField("PROGRAM_CHANGE")
	SONG_POSITION_POINTER = JO.GetField("SONG_POSITION_POINTER")
	SONG_SELECT = JO.GetField("SONG_SELECT")
	START = JO.GetField("START")
	STOP = JO.GetField("STOP")
	SYSTEM_RESET = JO.GetField("SYSTEM_RESET")
	TIMING_CLOCK = JO.GetField("TIMING_CLOCK")
	TUNE_REQUEST = JO.GetField("TUNE_REQUEST")
	
	ToStringMap.Put(ACTIVE_SENSING,"ACTIVE_SENSING")
	ToStringMap.Put(CHANNEL_PRESSURE,"CHANNEL_PRESSURE")
	ToStringMap.Put(CONT,"CONT")
	ToStringMap.Put(CONTROL_CHANGE,"CONTROL_CHANGE")
	ToStringMap.Put(END_OF_EXCLUSIVE,"END_OF_EXCLUSIVE")
	ToStringMap.Put(MIDI_TIME_CODE,"MIDI_TIME_CODE")
	ToStringMap.Put(NOTE_OFF,"NOTE_OFF")
	ToStringMap.Put(NOTE_ON,"NOTE_ON")
	ToStringMap.Put(PITCH_BEND,"PITCH_BEND")
	ToStringMap.Put(POLY_PRESSURE,"POLY_PRESSURE")
	ToStringMap.Put(PROGRAM_CHANGE,"PROGRAM_CHANGE")
	ToStringMap.Put(SONG_POSITION_POINTER,"SONG_POSITION_POINTER")
	ToStringMap.Put(SONG_SELECT,"SONG_SELECT")
	ToStringMap.Put(START,"START")
	ToStringMap.Put(STOP,"STOP")
	ToStringMap.Put(SYSTEM_RESET,"SYSTEM_RESET")
	ToStringMap.Put(TIMING_CLOCK,"TIMING_CLOCK")
	ToStringMap.Put(TUNE_REQUEST,"TUNE_REQUEST")
	ToStringMap.Put(SYSTEM_EXCLUSIVE,"SYSTEM_EXCLUSIVE")
	ToStringMap.Put(SPECIAL_SYSTEM_EXCLUSIVE,"SPECIAL_SYSTEM_EXCLUSIVE")
End Sub

Public Sub IsInitilized As Boolean
	Return IInitialized
End Sub

Public Sub ToString(Status As Int) As String
	Return ToStringMap.GetDefault(Status,"Not Found")
End Sub
