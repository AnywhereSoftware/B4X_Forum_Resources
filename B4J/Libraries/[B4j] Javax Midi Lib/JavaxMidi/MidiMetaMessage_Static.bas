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
	'Status byte for MidiMetaMessage (0xFF, or 255), which is used in MIDI files.
	Public META As Int
	Private IInitialized As Boolean
	Private MMetaType As Map
	
	Public Const SEQUENCE_NUMBER As Byte = 0x00
	Public Const TEXT As Byte = 0x01
	Public Const COPYRIGHT As Byte = 0x02
	Public Const SEQ_OR_TRACK_NAME As Byte = 0x03
	Public Const INSTRUMENT_NAME As Byte = 0x04
	Public Const LYRIC As Byte = 0x05
	Public Const MARKER As Byte = 0x06
	Public Const CUEPOINT As Byte = 0x07
	Public Const PROGRAM_NAME As Byte = 0x08
	Public Const DEVICE_NAME As Byte = 0X09
	Public Const MIDI_CHANNEL_PREFIX As Byte = 0x20
	Public Const PORT As Byte = 0x21
	Public Const EOT As Byte = 0x2F
	Public Const TEMPO As Byte = 0x51
	Public Const SMTPE_OFFSET As Byte = 0x54
	Public Const TIME_SIGNATURE As Byte = 0x58
	Public Const KEY_SIGNATURE As Byte = 0x59
	Public Const SEQUENCER_SPECIFIC As Byte = 0x7F

End Sub

Public Sub Initialize
	If IInitialized Then Return
	JO.InitializeStatic("javax.sound.midi.MetaMessage")
	MMetaType.Initialize
	UpdateConstants
	IInitialized = True
End Sub

Private Sub UpdateConstants
	META = JO.GetField("META")
End Sub

'Helper sub to create Time Signature Meta Message
Public Sub TimeSignatureMsg(Numerator As Int, Denom As Int) As MidiMetaMessage
	
	Dim TicksPerMeterClick As Byte = 24
	Dim ThirtySecondNotesPerquarter As Byte = 8
	
	Dim Data As Byte = Logarithm(Denom,10) / Logarithm(2,10)
	
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create2(TIME_SIGNATURE,Array As Byte(Numerator, Data, TicksPerMeterClick, ThirtySecondNotesPerquarter),4)
	
	Return MM
End Sub

'Helper sub to create tempo Meta Message
Public Sub TempoMsg(BPM As Int) As MidiMetaMessage
	
	Dim mpq As Int = 60000000 / BPM
	Dim data() As Byte = MidiUtils.int24bit(mpq)
	
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create
	MM.setMessage(TEMPO, data, 3)
	
	Return MM
End Sub

'Helper sub to create End of Track Meta Message
Public Sub EOTMsg() As MidiMetaMessage
	
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create2(EOT,Array As Byte(),0)
	Return MM
	
End Sub

Public Sub GetTypeName(MMSg As MidiMetaMessage) As String
	Return MidiTypeNames_Static.Name(MMSg.GetMessage(1))
End Sub
