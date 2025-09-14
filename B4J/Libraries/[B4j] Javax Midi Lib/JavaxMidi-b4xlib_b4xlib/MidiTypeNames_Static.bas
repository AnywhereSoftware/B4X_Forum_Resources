B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.01
@EndOfDesignText@
'Code module

#IgnoreWarnings: 12

'Subs in this code module will be accessible from all modules.

Sub Process_Globals
	Dim EMap As Map
	Dim CCMap As Map
	Type MidiETypes(ShortName As String, Name As String)
	Dim NF As MidiETypes
	Dim IInitialized As Boolean
End Sub

'Initializes the object.
Public Sub Initialize
	
	EMap.Initialize
	CCMap.Initialize
	'Set a default EType
	NF.Name = "Not Found"
	NF.ShortName = "Not Found"
	
	PopulateMap
	PopulateCCMap
	IInitialized = True
	
End Sub

Public Sub IsInitialised As Boolean
	Return IInitialized
End Sub

Sub Name (EType As Int) As String
	Dim TType As MidiETypes = EMap.GetDefault(EType,NF)
	Return TType.Name
End Sub

Sub ShortName (EType As Int) As String
	Dim TType As MidiETypes = EMap.GetDefault(EType,NF)
	Return TType.ShortName
End Sub

Sub CCName (ID As Int) As String
	Return "" & CCMap.Get(ID)
End Sub
Private Sub PopulateMap

	'Note Off
	Dim i As Int
	For i = 0x80 To 0x8F
		Dim TType As MidiETypes
		TType.ShortName = "NoteOff"
		TType.Name = "Note Off Chan " & (Bit.And(i,0x0F) + 1)
		EMap.Put(i,TType)
	Next
	
	'Note On
	For i = 0x90 To 0x9F
		Dim TType As MidiETypes
		TType.ShortName = "NoteOn"
		TType.Name = "Note On Chan " & (Bit.And(i,0x0F) + 1)
		EMap.Put(i,TType)
	Next
	
	'Polyphonic Aftertouch
	For i = 0xA0 To 0xAF
		Dim TType As MidiETypes
		TType.ShortName = "PolyAT"
		TType.Name = "Poly After Touch Chan " & (Bit.And(i,0x0F) + 1)
		EMap.Put(i,TType)
	Next
	
	'Control/Mode Change
	For i = 0xB0 To 0xBF
		Dim TType As MidiETypes
		TType.ShortName = "ContCh"
		TType.Name = "Control/Mode Change Chan " & (Bit.And(i,0x0F) + 1)
		EMap.Put(i,TType)
	Next
	
	'ProgChange
	For i = 0xC0 To 0xCF
		Dim TType As MidiETypes
		TType.ShortName = "PChange"
		TType.Name = "Program Change Chan " & (Bit.And(i,0x0F) + 1)
		EMap.Put(i,TType)
	Next
	
	'Channel Aftertouch
	For i = 0xD0 To 0xDF
		Dim TType As MidiETypes
		TType.ShortName = "ATouch"
		TType.Name = "Aftertouch Change Chan " & (Bit.And(i,0x0F) + 1)
		EMap.Put(i,TType)
	Next
	
	'Picth bend
	For i = 0xE0 To 0xEF
		Dim TType As MidiETypes
		TType.ShortName = "PBend"
		TType.Name = "PitchBend Change Chan " & (Bit.And(i,0x0F) + 1)
		EMap.Put(i,TType)
	Next
	
	Dim TType As MidiETypes
	TType.ShortName = "SysEx"
	TType.Name = "System Exclusive"
	EMap.Put(0xF0,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "MTC"
	TType.Name = "Midi Time Code"
	EMap.Put(0xF1,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "SPP"
	TType.Name = "Song Position Pointer"
	EMap.Put(0xF2,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "SongSel"
	TType.Name = "Song Select"
	EMap.Put(0xF3,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "UnDef"
	TType.Name = "Undefined"
	EMap.Put(0xF4,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "UnDef"
	TType.Name = "Undefined"
	EMap.Put(0xF5,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "TuneReq"
	TType.Name = "Tune Request"
	EMap.Put(0xF6,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "EOX"
	TType.Name = "End of System Exclusive"
	EMap.Put(0xF7,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Clock"
	TType.Name = "Timing Clock"
	EMap.Put(0xF8,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "UnDef"
	TType.Name = "Undefined"
	EMap.Put(0xF9,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Start"
	TType.Name = "Start"
	EMap.Put(0xFA,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Cont"
	TType.Name = "Continue"
	EMap.Put(0xFB,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Stop"
	TType.Name = "Stop"
	EMap.Put(0xFC,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "UnDef"
	TType.Name = "Undefined"
	EMap.Put(0xFD,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "ActSens"
	TType.Name = "Active Sensing"
	EMap.Put(0xFE,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Reset"
	TType.Name = "System Reset"
	EMap.Put(0xFF,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "SeqNum"
	TType.Name = "Sequence Number"
	EMap.Put(0x00,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Text"
	TType.Name = "Text Event"
	EMap.Put(0x01,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Copyright"
	TType.Name = "Copyright"
	EMap.Put(0x02,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Name"
	TType.Name = "Seq/Track Name"
	EMap.Put(0x03,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "InstName"
	TType.Name = "Instrument Name"
	EMap.Put(0x04,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Lyrics"
	TType.Name = "Lyrics"
	EMap.Put(0x05,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Marker"
	TType.Name = "Marker"
	EMap.Put(0x06,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "CuePoint"
	TType.Name = "Cue-Point"
	EMap.Put(0x07,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "DeviceName"
	TType.Name = "Device Name"
	EMap.Put(0x08,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "ProgName"
	TType.Name = "Program Name"
	EMap.Put(0x09,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "ChanPref"
	TType.Name = "Channel Prefix"
	EMap.Put(0x20,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "MidiPort"
	TType.Name = "Midi Port"
	EMap.Put(0x21,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "EOT"
	TType.Name = "End Of Track"
	EMap.Put(0x2F,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Tempo"
	TType.Name = "Tempo"
	EMap.Put(0x51,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "SMTPEOff"
	TType.Name = "SMTPE Offset"
	EMap.Put(0x54,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Time Sig"
	TType.Name = "Time Signature"
	EMap.Put(0x58,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Key Sig"
	TType.Name = "Key Signature"
	EMap.Put(0x59,TType)
	
	Dim TType As MidiETypes
	TType.ShortName = "Seq Spec."
	TType.Name = "Sequencer Specific"
	EMap.Put(0x7F,TType)
End Sub
Private Sub PopulateCCMap
'	High resolution continuous controllers (MSB)
	CCMap.Put(0,"Bank Select (MSB)")
	CCMap.Put(1,"Modulation Wheel (MSB)")
	CCMap.Put(2,"Breath Controller (MSB)")
	CCMap.Put(4,"Foot Controller (MSB)")
	CCMap.Put(5,"Portamento Time (MSB)")
	CCMap.Put(6,"Data Entry  (MSB used with RPNs/NRPNs)")
	CCMap.Put(7,"Channel Volume  (MSB)")
	CCMap.Put(8,"Balance (MSB)")
	CCMap.Put(10,"Pan (MSB)")
	CCMap.Put(11,"Expression Controller (MSB)")
	CCMap.Put(12,"Effect Control 1 (MSB)")
	CCMap.Put(13,"Effect Control 2 (MSB)")
	CCMap.Put(16,"Gen Purpose Controller 1 (MSB)")
	CCMap.Put(17,"Gen Purpose Controller 2 (MSB)")
	CCMap.Put(18,"Gen Purpose Controller 3 (MSB)")
	CCMap.Put(19,"Gen Purpose Controller 4 (MSB)")
'	High resolution continuous controllers (LSB)
	CCMap.Put(32,"Bank Select (LSB)")
	CCMap.Put(33,"Modulation Wheel (LSB)")
	CCMap.Put(34,"Breath Controller (LSB)")
	CCMap.Put(36,"Foot Controller (LSB)")
	CCMap.Put(37,"Portamento Time (LSB)")
	CCMap.Put(38,"Data Entry (LSB)")
	CCMap.Put(39,"Channel Volume (LSB)")
	CCMap.Put(40,"Balance (LSB)")
	CCMap.Put(42,"Pan (LSB)")
	CCMap.Put(43,"Expression Controller (LSB)")
	CCMap.Put(44,"Effect Control 1 (LSB)")
	CCMap.Put(45,"Effect Control 2 (LSB)")
	CCMap.Put(48,"General Purpose Controller 1 (LSB)")
	CCMap.Put(49,"General Purpose Controller 2 (LSB)")
	CCMap.Put(50,"General Purpose Controller 3 (LSB)")
	CCMap.Put(51,"General Purpose Controller 4 (LSB)")
'	Switches
	CCMap.Put(64,"Sustain On/Off")
	CCMap.Put(65,"Portamento On/Off")
	CCMap.Put(66,"Sostenuto On/Off")
	CCMap.Put(67,"Soft Pedal On/Off")
	CCMap.Put(68,"Legato On/Off")
	CCMap.Put(69,"Hold 2 On/Off")
'	Low resolution continuous controllers
	CCMap.Put(70,"Sound Controller 1")
	CCMap.Put(71,"Sound Controller 2")
	CCMap.Put(72,"Sound Controller 3")
	CCMap.Put(73,"Sound Controller 4")
	CCMap.Put(74,"Sound Controller 5")
	CCMap.Put(75,"Sound Controller 6")
	CCMap.Put(76,"Sound Controller 7")
	CCMap.Put(77,"Sound Controller 8")
	CCMap.Put(78,"Sound Controller 9")
	CCMap.Put(79,"Sound Controller 10")
	CCMap.Put(80,"General Purpose Controller 5")
	CCMap.Put(81,"General Purpose Controller 6")
	CCMap.Put(82,"General Purpose Controller 7")
	CCMap.Put(83,"General Purpose Controller 8")
	CCMap.Put(84,"Portamento Control")
	CCMap.Put(91,"Effects 1 (Reverb Send Level)")
	CCMap.Put(92,"Effects 2 (Tremelo Depth)")
	CCMap.Put(93,"Effects 3 (Chorus Send Level)")
	CCMap.Put(94,"Effects 4 (Celeste Depth)")
	CCMap.Put(95,"Effects 5 (Phaser Depth)")
'	RPNs / NRPNs - (Detail)
	CCMap.Put(96,"Data Increment")
	CCMap.Put(97,"Data Decrement")
	CCMap.Put(98,"Non Registered Parameter Number (LSB)")
	CCMap.Put(99,"Non Registered Parameter Number (MSB)")
	CCMap.Put(100,"Registered Parameter Number (LSB)")
	CCMap.Put(101,"Registered Parameter Number (MSB)")
'	Channel Mode messages - (Detail)
	CCMap.Put(120,"All Sound Off")
	CCMap.Put(121,"Reset All Controllers")
	CCMap.Put(122,"Local Control On/Off")
	CCMap.Put(123,"All Notes Off")
	CCMap.Put(124,"Omni Mode Off")
	CCMap.Put(125,"Omni Mode On")
	CCMap.Put(126,"Mono Mode On")
	CCMap.Put(127,"Poly Mode On")
End Sub