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
	
	Public Const ALLNOTESOFF() As Byte = Array As Byte(0xB0,0x78,0x00)
	
	'Sysex Constants
	Public Const SPECIAL_SYSTEM_EXCLUSIVE As Int = 0XF7
	Public Const SYSTEM_EXCLUSIVE As Int = 0XF0
	
	'Short Message Vars
	
	'Status byte for Active Sensing message (0xFE, or 254).
	Public Const STATUS_ACTIVE_SENSING As Int = 0xFE
	'Command value for Channel Pressure (Aftertouch) message (0xD0, or 208)
	Public Const STATUS_CHANNEL_PRESSURE As Int = 0XD0
	'Status byte for Continue message (0xFB, or 251).
	Public Const STATUS_CONTINUE_ As Int = 0xFB
	'Command value for Control Change message (0xB0, or 176)
	Public Const STATUS_CONTROL_CHANGE As Int = 0xB0
	'Status byte for End of System Exclusive message (0xF7, or 247).
	Public Const STATUS_END_OF_EXCLUSIVE As Int = 0xF7
	'Status byte for MIDI Time Code Quarter Frame message (0xF1, or 241).
	Public Const STATUS_MIDI_TIME_CODE As Int = 0xF1
	'Command value for Note Off message (0x80, or 128)
	Public Const STATUS_NOTE_OFF As Int = 0x80
	'Command value for Note On message (0x90, or 144)
	Public Const STATUS_NOTE_ON As Int = 0x90
	'Command value for Pitch Bend message (0xE0, or 224)
	Public Const STATUS_PITCH_BEND As Int = 0xE0
	'Command value for Polyphonic Key Pressure (Aftertouch) message (0xA0, or 160)
	Public Const STATUS_POLY_PRESSURE As Int = 0xA0
	'Command value for Program Change message (0xC0, or 192)
	Public Const STATUS_PROGRAM_CHANGE As Int = 0xC0
	'Status byte for Song Position Pointer message (0xF2, or 242).
	Public Const STATUS_SONG_POSITION_POINTER As Int = 0xF2
	'Status byte for MIDI Song Select message (0xF3, or 243).
	Public Const STATUS_SONG_SELECT As Int = 0xF3
	'Status byte for Start message (0xFA, or 250).
	Public Const STATUS_START As Int = 0xFA
	'Status byte for Stop message (0xFC, or 252).
	Public Const STATUS_STOP As Int = 0xFC
	'Status byte for System Reset message (0xFF, or 255).
	Public Const STATUS_SYSTEM_RESET As Int = 0xFF
	'Status byte for Timing Clock messagem (0xF8, or 248).
	Public Const STATUS_TIMING_CLOCK As Int = 0xF8
	'Status byte for Tune Request message (0xF6, or 246).
	Public Const STATUS_TUNE_REQUEST As Int = 0xF6
	
	'MetaTypes
	Public Const META_SEQUENCE_NUMBER As Byte = 0x00
	Public Const META_TEXT As Byte = 0x01
	Public Const META_COPYRIGHT As Byte = 0x02
	Public Const META_SEQ_OR_TRACK_NAME As Byte = 0x03
	Public Const META_INSTRUMENT_NAME As Byte = 0x04
	Public Const META_LYRIC As Byte = 0x05
	Public Const META_MARKER As Byte = 0x06
	Public Const META_CUEPOINT As Byte = 0x07
	Public Const META_PROGRAM_NAME As Byte = 0x08
	Public Const META_DEVICE_NAME As Byte = 0X09
	Public Const META_MIDI_CHANNEL_PREFIX As Byte = 0x20
	Public Const META_PORT As Byte = 0x21
	Public Const META_EOT As Byte = 0x2F
	Public Const META_TEMPO As Byte = 0x51
	Public Const META_SMTPE_OFFSET As Byte = 0x54
	Public Const META_TIME_SIGNATURE As Byte = 0x58
	Public Const META_KEY_SIGNATURE As Byte = 0x59
	Public Const META_SEQUENCER_SPECIFIC As Byte = 0x7F
	
	'ShortMessage Type
	Public Const TYPE_SHORTMESSAGE As Int = 0
	Public Const TYPE_METAMESSAGE As Int = 1
	Public Const TYPE_SYSEXMESSAGE As Int = 2
	
	'Meta Message Vars
	Public Const METAStatus As Int = 0xFF
End Sub