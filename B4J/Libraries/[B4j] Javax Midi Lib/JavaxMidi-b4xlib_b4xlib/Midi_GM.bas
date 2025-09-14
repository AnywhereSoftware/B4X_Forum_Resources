B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Code_module_Midi_GM
'Requires_initializing_-_Midi_GM.Initialize
'Subs_in_this_code_module_will_be_accessible_from_all_modules.

Sub Process_Globals
	'These_global_variables_will_be_declared_once_when_the_application_starts.
	'These_variables_can_be_accessed_from_all_modules.
	
	Public Const Acoustic_Grand_Piano As Int = 1
	Public Const Bright_Acoustic_Piano As Int = 2
	Public Const Electric_Grand_Piano As Int = 3
	Public Const Honky_tonk_Piano As Int = 4
	Public Const Electric_Piano_1 As Int = 5
	Public Const Electric_Piano_2 As Int = 6
	Public Const Harpsichord As Int = 7
	Public Const Clavinet As Int = 8
	Public Const Celesta As Int = 9
	Public Const Glockenspiel As Int = 10
	Public Const Music_Box As Int = 11
	Public Const Vibraphone As Int = 12
	Public Const Marimba As Int = 13
	Public Const Xylophone As Int = 14
	Public Const Tubular_Bells As Int = 15
	Public Const Dulcimer As Int = 16
	Public Const Drawbar_Organ As Int = 17
	Public Const Percussive_Organ As Int = 18
	Public Const Rock_Organ As Int = 19
	Public Const Church_Organ As Int = 20
	Public Const Reed_Organ As Int = 21
	Public Const Accordion As Int = 22
	Public Const Harmonica As Int = 23
	Public Const Tango_Accordion As Int = 24
	Public Const Acoustic_Guitar_nylon As Int = 25
	Public Const Acoustic_Guitar_steel As Int = 26
	Public Const Electric_Guitar_jazz As Int = 27
	Public Const Electric_Guitar_clean As Int = 28
	Public Const Electric_Guitar_muted As Int = 29
	Public Const Overdriven_Guitar As Int = 30
	Public Const Distortion_Guitar As Int = 31
	Public Const Guitar_Harmonics As Int = 32
	Public Const Acoustic_Bass As Int = 33
	Public Const Electric_Bass_finger As Int = 34
	Public Const Electric_Bass_pick As Int = 35
	Public Const Fretless_Bass As Int = 36
	Public Const Slap_Bass_1 As Int = 37
	Public Const Slap_Bass_2 As Int = 38
	Public Const Synth_Bass_1 As Int = 39
	Public Const Synth_Bass_2 As Int = 40
	Public Const Violin As Int = 41
	Public Const Viola As Int = 42
	Public Const Cello As Int = 43
	Public Const Contrabass As Int = 44
	Public Const Tremolo_Strings As Int = 45
	Public Const Pizzicato_Strings As Int = 46
	Public Const Orchestral_Harp As Int = 47
	Public Const Timpani As Int = 48
	Public Const String_Ensemble_1 As Int = 49
	Public Const String_Ensemble_2 As Int = 50
	Public Const Synth_Strings_1 As Int = 51
	Public Const Synth_Strings_2 As Int = 52
	Public Const Choir_Aahs As Int = 53
	Public Const Voice_Oohs As Int = 54
	Public Const Synth_Choir As Int = 58
	Public Const Orchestra_Hit As Int = 56
	Public Const Trumpet As Int = 57
	Public Const Trombone As Int = 58
	Public Const Tuba As Int = 59
	Public Const Muted_Trumpet As Int = 60
	Public Const French_Horn As Int = 61
	Public Const Brass_Section As Int = 62
	Public Const Synth_Brass_1 As Int = 63
	Public Const Synth_Brass_2 As Int = 64
	Public Const Soprano_Sax As Int = 65
	Public Const Alto_Sax As Int = 66
	Public Const Tenor_Sax As Int = 67
	Public Const Baritone_Sax As Int = 68
	Public Const Oboe As Int = 69
	Public Const English_Horn As Int = 70
	Public Const Bassoon As Int = 71
	Public Const Clarinet As Int = 72
	Public Const Piccolo As Int = 73
	Public Const Flute As Int = 74
	Public Const Recorder As Int = 75
	Public Const Pan_Flute As Int = 76
	Public Const Blown_bottle As Int =77 
	Public Const Shakuhachi As Int = 78
	Public Const Whistle As Int = 79
	Public Const Ocarina As Int = 80
	Public Const Lead_1_square As Int = 81
	Public Const Lead_2_sawtooth As Int = 82
	Public Const Lead_3_calliope As Int = 83
	Public Const Lead_4_chiff As Int = 84
	Public Const Lead_5_charang As Int = 85
	Public Const Lead_6_voice As Int = 86
	Public Const Lead_7_fifths As Int = 87
	Public Const Lead_8_bass_lead As Int = 88
	Public Const Pad_1_new_age As Int = 89
	Public Const Pad_2_warm As Int = 90
	Public Const Pad_3_polysynth As Int = 91
	Public Const Pad_4_choir As Int = 92
	Public Const Pad_5_bowed As Int = 93
	Public Const Pad_6_metallic As Int =94 
	Public Const Pad_7_halo As Int = 95
	Public Const Pad_8_sweep As Int = 96
	Public Const FX_1_rain As Int = 97
	Public Const FX_2_soundtrack As Int = 98
	Public Const FX_3_crystal As Int = 99
	Public Const FX_4_atmosphere As Int = 100
	Public Const FX_5_brightness As Int = 101
	Public Const FX_6_goblins As Int = 102
	Public Const FX_7_echoes As Int = 103
	Public Const FX_8_sci_fi As Int = 104
	Public Const Sitar As Int = 105
	Public Const Banjo As Int = 106
	Public Const Shamisen As Int = 107
	Public Const Koto As Int = 108
	Public Const Kalimba As Int = 109
	Public Const Bagpipe As Int = 110
	Public Const Fiddle As Int = 111
	Public Const Shanai As Int = 112
	Public Const Tinkle_Bell As Int = 113
	Public Const Agogo As Int = 114
	Public Const Steel_Drums As Int = 115
	Public Const Woodblock As Int = 116
	Public Const Taiko_Drum As Int = 117
	Public Const Melodic_Tom As Int = 118
	Public Const Synth_Drum As Int = 119
	Public Const Reverse_Cymbal As Int = 120
	Public Const Guitar_Fret_Noise As Int = 121
	Public Const Breath_Noise As Int = 122
	Public Const Seashore As Int = 123
	Public Const Bird_Tweet As Int = 124
	Public Const Telephone_Ring As Int = 125
	Public Const Helicopter As Int = 126
	Public Const Applause As Int = 127
	Public Const Gunshot As Int = 128

	Dim ProgNameMap As Map
	Dim DrumMap As Map
End Sub

Public Sub Initialize
	
	ProgNameMap.Initialize
	DrumMap.Initialize
	Add
End Sub

Private Sub Add
	Dim TempList As List
	TempList.Initialize
	
	TempList.Add("Acoustic_Grand_Piano")
	TempList.Add("Bright_Acoustic_Piano")
	TempList.Add("Electric_Grand_Piano")
	TempList.Add("Honky-tonk_Piano")
	TempList.Add("Electric_Piano_1")
	TempList.Add("Electric_Piano_2")
	TempList.Add("Harpsichord")
	TempList.Add("Clavinet")
	TempList.Add("Celesta")
	TempList.Add("Glockenspiel")
	TempList.Add("Music_Box")
	TempList.Add("Vibraphone")
	TempList.Add("Marimba")
	TempList.Add("Xylophone")
	TempList.Add("Tubular_Bells")
	TempList.Add("Dulcimer")
	TempList.Add("Drawbar_Organ")
	TempList.Add("Percussive_Organ")
	TempList.Add("Rock_Organ")
	TempList.Add("Church_Organ")
	TempList.Add("Reed_Organ")
	TempList.Add("Accordion")
	TempList.Add("Harmonica")
	TempList.Add("Tango_Accordion")
	TempList.Add("Acoustic_Guitar_(nylon)")
	TempList.Add("Acoustic_Guitar_(steel)")
	TempList.Add("Electric_Guitar_(jazz)")
	TempList.Add("Electric_Guitar_(clean)")
	TempList.Add("Electric_Guitar_(muted)")
	TempList.Add("Overdriven_Guitar")
	TempList.Add("Distortion_Guitar")
	TempList.Add("Guitar_Harmonics")
	TempList.Add("Acoustic_Bass")
	TempList.Add("Electric_Bass_(finger)")
	TempList.Add("Electric_Bass_(pick)")
	TempList.Add("Fretless_Bass")
	TempList.Add("Slap_Bass_1")
	TempList.Add("Slap_Bass_2")
	TempList.Add("Synth_Bass_1")
	TempList.Add("Synth_Bass_2")
	TempList.Add("Violin")
	TempList.Add("Viola")
	TempList.Add("Cello")
	TempList.Add("Contrabass")
	TempList.Add("Tremolo_Strings")
	TempList.Add("Pizzicato_Strings")
	TempList.Add("Orchestral_Harp")
	TempList.Add("Timpani")
	TempList.Add("String_Ensemble_1")
	TempList.Add("String_Ensemble_2")
	TempList.Add("Synth_Strings_1")
	TempList.Add("Synth_Strings_2")
	TempList.Add("Choir_Aahs")
	TempList.Add("Voice_Oohs")
	TempList.Add("Synth_Choir")
	TempList.Add("Orchestra_Hit")
	TempList.Add("Trumpet")
	TempList.Add("Trombone")
	TempList.Add("Tuba")
	TempList.Add("Muted_Trumpet")
	TempList.Add("French_Horn")
	TempList.Add("Brass_Section")
	TempList.Add("Synth_Brass_1")
	TempList.Add("Synth_Brass_2")
	TempList.Add("Soprano_Sax")
	TempList.Add("Alto_Sax")
	TempList.Add("Tenor_Sax")
	TempList.Add("Baritone_Sax")
	TempList.Add("Oboe")
	TempList.Add("English_Horn")
	TempList.Add("Bassoon")
	TempList.Add("Clarinet")
	TempList.Add("Piccolo")
	TempList.Add("Flute")
	TempList.Add("Recorder")
	TempList.Add("Pan_Flute")
	TempList.Add("Blown_bottle")
	TempList.Add("Shakuhachi")
	TempList.Add("Whistle")
	TempList.Add("Ocarina")
	TempList.Add("Lead_1_(square)")
	TempList.Add("Lead_2_(sawtooth)")
	TempList.Add("Lead_3_(calliope)")
	TempList.Add("Lead_4_(chiff)")
	TempList.Add("Lead_5_(charang)")
	TempList.Add("Lead_6_(voice)")
	TempList.Add("Lead_7_(fifths)")
	TempList.Add("Lead_8_(bass_+_lead)")
	TempList.Add("Pad_1_(new_age)")
	TempList.Add("Pad_2_(warm)")
	TempList.Add("Pad_3_(polysynth)")
	TempList.Add("Pad_4_(choir)")
	TempList.Add("Pad_5_(bowed)")
	TempList.Add("Pad_6_(metallic)")
	TempList.Add("Pad_7_(halo)")
	TempList.Add("Pad_8_(sweep)")
	TempList.Add("FX_1_(rain)")
	TempList.Add("FX_2_(soundtrack)")
	TempList.Add("FX_3_(crystal)")
	TempList.Add("FX_4_(atmosphere)")
	TempList.Add("FX_5_(brightness)")
	TempList.Add("FX_6_(goblins)")
	TempList.Add("FX_7_(echoes)")
	TempList.Add("FX_8_(sci-fi)")
	TempList.Add("Sitar")
	TempList.Add("Banjo")
	TempList.Add("Shamisen")
	TempList.Add("Koto")
	TempList.Add("Kalimba")
	TempList.Add("Bagpipe")
	TempList.Add("Fiddle")
	TempList.Add("Shanai")
	TempList.Add("Tinkle_Bell")
	TempList.Add("Agogo")
	TempList.Add("Steel_Drums")
	TempList.Add("Woodblock")
	TempList.Add("Taiko_Drum")
	TempList.Add("Melodic_Tom")
	TempList.Add("Synth_Drum")
	TempList.Add("Reverse_Cymbal")
	TempList.Add("Guitar_Fret_Noise")
	TempList.Add("Breath_Noise")
	TempList.Add("Seashore")
	TempList.Add("Bird_Tweet")
	TempList.Add("Telephone_Ring")
	TempList.Add("Helicopter")
	TempList.Add("Applause")
	TempList.Add("Gunshot")
	
	For i = 0 To TempList.Size - 1
		ProgNameMap.Put(i,TempList.Get(i))
		ProgNameMap.Put(TempList.Get(i),i)
	Next
	

	DrumMap.Put(35,"Acoustic_Bass_Drum")
	DrumMap.Put(59,"Ride_Cymbal_2")
	DrumMap.Put(36,"Bass_Drum_1")
	DrumMap.Put(60,"Hi_Bongo,")
	DrumMap.Put(37,"Side_Stick")
	DrumMap.Put(61,"Low_Bongo")
	DrumMap.Put(38,"Acoustic_Snare")
	DrumMap.Put(62,"Mute_Hi_Conga")
	DrumMap.Put(39,"Hand_Clap")
	DrumMap.Put(63,"Open_Hi_Conga")
	DrumMap.Put(40,"Electric_Snare")
	DrumMap.Put(64,"Low_Conga")
	DrumMap.Put(41,"Low_Floor_Tom")
	DrumMap.Put(65,"High_Timbale")
	DrumMap.Put(42,"Closed_Hi_Hat")
	DrumMap.Put(66,"Low_Timbale")
	DrumMap.Put(43,"High_Floor_Tom")
	DrumMap.Put(67,"High_Agogo")
	DrumMap.Put(44,"Pedal_Hi-Hat")
	DrumMap.Put(68,"Low_Agogo")
	DrumMap.Put(45,"Low_Tom")
	DrumMap.Put(69,"Cabasa")
	DrumMap.Put(46,"Open_Hi-Hat")
	DrumMap.Put(70,"Maracas")
	DrumMap.Put(47,"Low-Mid_Tom")
	DrumMap.Put(71,"Short_Whistle")
	DrumMap.Put(48,"Hi-Mid_Tom")
	DrumMap.Put(72,"Long_Whistle")
	DrumMap.Put(49,"Crash_Cymbal_1")
	DrumMap.Put(73,"Short_Guiro")
	DrumMap.Put(50,"High_Tom")
	DrumMap.Put(74,"Long_Guiro")
	DrumMap.Put(51,"Ride_Cymbal_1")
	DrumMap.Put(75,"Claves")
	DrumMap.Put(52,"Chinese_Cymbal")
	DrumMap.Put(76,"Hi_Wood_Block")
	DrumMap.Put(53,"Ride_Bell")
	DrumMap.Put(77,"Low_Wood_Block")
	DrumMap.Put(54,"Tambourine")
	DrumMap.Put(78,"Mute_Cuica")
	DrumMap.Put(55,"Splash_Cymbal")
	DrumMap.Put(79,"Open_Cuica")
	DrumMap.Put(56,"Cowbell")
	DrumMap.Put(80,"Mute_Triangle")
	DrumMap.Put(57,"Crash_Cymbal_2")
	DrumMap.Put(81,"Open_Triangle")
	
	Dim DM1 As Map
	DM1.Initialize
	For Each Key As Int In DrumMap.Keys
		DM1.Put(DrumMap.Get(Key),Key)
	Next
	DrumMap.As(JavaObject).RunMethod("putAll",Array(DM1))
End Sub
'Get the General Midi Program Number from a Name (0 based)
Public Sub GetProgNo(ProgName As String) As Int
	Return ProgNameMap.GetDefault(ProgName,-1)
End Sub
'Get the General Midi Name for a Program Number (0 based)
Public Sub GetProgName(ProgNo As Int) As String
	Return ProgNameMap.GetDefault(ProgNo,"Not Found")
End Sub
'Get a list of patch names defined
Public Sub GetPatchNames As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each Item As Object In ProgNameMap.Keys
		If Item Is String Then ReturnList.Add(Item)
	Next
	Return ReturnList
End Sub
'Get Filtered map or patches
Public Sub GetFilteredProgs(Filter As String) As Map
	Dim M As Map
	M.Initialize
	For Each K As Object In ProgNameMap.Keys
		Dim S As String = ProgNameMap.Get(K)
		If S.ToLowerCase.Contains(Filter.ToLowerCase) Then M.Put(K,S)
	Next
	Return M
End Sub
'Get a list or program numbers defined
Public Sub GetProgNumbers As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each Item As Object In ProgNameMap.Keys
		If Item Is Int Then ReturnList.Add(Item)
	Next
	Return ReturnList
End Sub
'Get the drum name from it's note number
Public Sub GetDrumName(NoteNum As Int) As String
	Return DrumMap.GetDefault(NoteNum,"Not Found")
End Sub
'Get the drum note number from it's name
Public Sub GetDrumNoteNum(DrumName As String) As Int
	Return DrumMap.GetDefault(DrumName,-1)
End Sub
'Get a list of available Durm Names
Public Sub GetDrumNames As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each Item As Object In DrumMap.Keys
		If Item Is String Then ReturnList.Add(Item)
	Next
	Return ReturnList
End Sub
'Get a list of available Drum Note Numbers
Public Sub GetDrumNotes As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each Item As Object In DrumMap.Keys
		If Item Is Int Then ReturnList.Add(Item)
	Next
	Return ReturnList
End Sub