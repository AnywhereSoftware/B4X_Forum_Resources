B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module
#IgnoreWarnings:12
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

	Dim ProgNameMap As Map
	Dim DrumMap As Map
End Sub
Sub Initialize
	
	ProgNameMap.Initialize
	DrumMap.Initialize
	Add
End Sub
Private Sub Add
	Dim TempList As List
	TempList.Initialize
	
	TempList.Add("Acoustic Grand Piano")
	TempList.Add("Bright Acoustic Piano")
	TempList.Add("Electric Grand Piano")
	TempList.Add("Honky-tonk Piano")
	TempList.Add("Electric Piano 1")
	TempList.Add("Electric Piano 2")
	TempList.Add("Harpsichord")
	TempList.Add("Clavinet")
	TempList.Add("Celesta")
	TempList.Add("Glockenspiel")
	TempList.Add("Music Box")
	TempList.Add("Vibraphone")
	TempList.Add("Marimba")
	TempList.Add("Xylophone")
	TempList.Add("Tubular Bells")
	TempList.Add("Dulcimer")
	TempList.Add("Drawbar Organ")
	TempList.Add("Percussive Organ")
	TempList.Add("Rock Organ")
	TempList.Add("Church Organ")
	TempList.Add("Reed Organ")
	TempList.Add("Accordion")
	TempList.Add("Harmonica")
	TempList.Add("Tango Accordion")
	TempList.Add("Acoustic Guitar (nylon)")
	TempList.Add("Acoustic Guitar (steel)")
	TempList.Add("Electric Guitar (jazz)")
	TempList.Add("Electric Guitar (clean)")
	TempList.Add("Electric Guitar (muted)")
	TempList.Add("Overdriven Guitar")
	TempList.Add("Distortion Guitar")
	TempList.Add("Guitar Harmonics")
	TempList.Add("Acoustic Bass")
	TempList.Add("Electric Bass (finger)")
	TempList.Add("Electric Bass (pick)")
	TempList.Add("Fretless Bass")
	TempList.Add("Slap Bass 1")
	TempList.Add("Slap Bass 2")
	TempList.Add("Synth Bass 1")
	TempList.Add("Synth Bass 2")
	TempList.Add("Violin")
	TempList.Add("Viola")
	TempList.Add("Cello")
	TempList.Add("Contrabass")
	TempList.Add("Tremolo Strings")
	TempList.Add("Pizzicato Strings")
	TempList.Add("Orchestral Harp")
	TempList.Add("Timpani")
	TempList.Add("String Ensemble 1")
	TempList.Add("String Ensemble 2")
	TempList.Add("Synth Strings 1")
	TempList.Add("Synth Strings 2")
	TempList.Add("Choir Aahs")
	TempList.Add("Voice Oohs")
	TempList.Add("Synth Choir")
	TempList.Add("Orchestra Hit")
	TempList.Add("Trumpet")
	TempList.Add("Trombone")
	TempList.Add("Tuba")
	TempList.Add("Muted Trumpet")
	TempList.Add("French Horn")
	TempList.Add("Brass Section")
	TempList.Add("Synth Brass 1")
	TempList.Add("Synth Brass 2")
	TempList.Add("Soprano Sax")
	TempList.Add("Alto Sax")
	TempList.Add("Tenor Sax")
	TempList.Add("Baritone Sax")
	TempList.Add("Oboe")
	TempList.Add("English Horn")
	TempList.Add("Bassoon")
	TempList.Add("Clarinet")
	TempList.Add("Piccolo")
	TempList.Add("Flute")
	TempList.Add("Recorder")
	TempList.Add("Pan Flute")
	TempList.Add("Blown bottle")
	TempList.Add("Shakuhachi")
	TempList.Add("Whistle")
	TempList.Add("Ocarina")
	TempList.Add("Lead 1 (square)")
	TempList.Add("Lead 2 (sawtooth)")
	TempList.Add("Lead 3 (calliope)")
	TempList.Add("Lead 4 (chiff)")
	TempList.Add("Lead 5 (charang)")
	TempList.Add("Lead 6 (voice)")
	TempList.Add("Lead 7 (fifths)")
	TempList.Add("Lead 8 (bass + lead)")
	TempList.Add("Pad 1 (new age)")
	TempList.Add("Pad 2 (warm)")
	TempList.Add("Pad 3 (polysynth)")
	TempList.Add("Pad 4 (choir)")
	TempList.Add("Pad 5 (bowed)")
	TempList.Add("Pad 6 (metallic)")
	TempList.Add("Pad 7 (halo)")
	TempList.Add("Pad 8 (sweep)")
	TempList.Add("FX 1 (rain)")
	TempList.Add("FX 2 (soundtrack)")
	TempList.Add("FX 3 (crystal)")
	TempList.Add("FX 4 (atmosphere)")
	TempList.Add("FX 5 (brightness)")
	TempList.Add("FX 6 (goblins)")
	TempList.Add("FX 7 (echoes)")
	TempList.Add("FX 8 (sci-fi)")
	TempList.Add("Sitar")
	TempList.Add("Banjo")
	TempList.Add("Shamisen")
	TempList.Add("Koto")
	TempList.Add("Kalimba")
	TempList.Add("Bagpipe")
	TempList.Add("Fiddle")
	TempList.Add("Shanai")
	TempList.Add("Tinkle Bell")
	TempList.Add("Agogo")
	TempList.Add("Steel Drums")
	TempList.Add("Woodblock")
	TempList.Add("Taiko Drum")
	TempList.Add("Melodic Tom")
	TempList.Add("Synth Drum")
	TempList.Add("Reverse Cymbal")
	TempList.Add("Guitar Fret Noise")
	TempList.Add("Breath Noise")
	TempList.Add("Seashore")
	TempList.Add("Bird Tweet")
	TempList.Add("Telephone Ring")
	TempList.Add("Helicopter")
	TempList.Add("Applause")
	TempList.Add("Gunshot")
	
	For i = 0 To TempList.Size - 1
		ProgNameMap.Put(i,TempList.Get(i))
		ProgNameMap.Put(TempList.Get(i),i)
	Next
	

	DrumMap.Put(35,"Acoustic Bass Drum")
	DrumMap.Put(59,"Ride Cymbal 2")
	DrumMap.Put(36,"Bass Drum 1")
	DrumMap.Put(60,"Hi Bongo,")
	DrumMap.Put(37,"Side Stick")
	DrumMap.Put(61,"Low Bongo")
	DrumMap.Put(38,"Acoustic Snare")
	DrumMap.Put(62,"Mute Hi Conga")
	DrumMap.Put(39,"Hand Clap")
	DrumMap.Put(63,"Open Hi Conga")
	DrumMap.Put(40,"Electric Snare")
	DrumMap.Put(64,"Low Conga")
	DrumMap.Put(41,"Low Floor Tom")
	DrumMap.Put(65,"High Timbale")
	DrumMap.Put(42,"Closed Hi Hat")
	DrumMap.Put(66,"Low Timbale")
	DrumMap.Put(43,"High Floor Tom")
	DrumMap.Put(67,"High Agogo")
	DrumMap.Put(44,"Pedal Hi-Hat")
	DrumMap.Put(68,"Low Agogo")
	DrumMap.Put(45,"Low Tom")
	DrumMap.Put(69,"Cabasa")
	DrumMap.Put(46,"Open Hi-Hat")
	DrumMap.Put(70,"Maracas")
	DrumMap.Put(47,"Low-Mid Tom")
	DrumMap.Put(71,"Short Whistle")
	DrumMap.Put(48,"Hi-Mid Tom")
	DrumMap.Put(72,"Long Whistle")
	DrumMap.Put(49,"Crash Cymbal 1")
	DrumMap.Put(73,"Short Guiro")
	DrumMap.Put(50,"High Tom")
	DrumMap.Put(74,"Long Guiro")
	DrumMap.Put(51,"Ride Cymbal 1")
	DrumMap.Put(75,"Claves")
	DrumMap.Put(52,"Chinese Cymbal")
	DrumMap.Put(76,"Hi Wood Block")
	DrumMap.Put(53,"Ride Bell")
	DrumMap.Put(77,"Low Wood Block")
	DrumMap.Put(54,"Tambourine")
	DrumMap.Put(78,"Mute Cuica")
	DrumMap.Put(55,"Splash Cymbal")
	DrumMap.Put(79,"Open Cuica")
	DrumMap.Put(56,"Cowbell")
	DrumMap.Put(80,"Mute Triangle")
	DrumMap.Put(57,"Crash Cymbal 2")
	DrumMap.Put(81,"Open Triangle")
	
	For Each Key As Int In DrumMap.Keys
		DrumMap.Put(DrumMap.Get(Key),Key)
	Next
End Sub
'Get the General Midi Program Number from a Name (0 based)
Sub GetProgNo(ProgName As String) As Int
	Return ProgNameMap.GetDefault(ProgName,-1)
End Sub
'Get the General Midi Name for a Program Number (0 based)
Sub GetProgName(ProgNo As Int) As String
	Return ProgNameMap.GetDefault(ProgNo,"Not Found")
End Sub
'Get a list of patch names defined
Sub GetPatchNames As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each Item As Object In ProgNameMap.Keys
		If Item Is String Then ReturnList.Add(Item)
	Next
	Return ReturnList
End Sub
'Get a list or program numbers defined
Sub GetProgNumbers As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each Item As Object In ProgNameMap.Keys
		If Item Is Int Then ReturnList.Add(Item)
	Next
	Return ReturnList
End Sub
'Get the drum name from it's note number
Sub GetDrumName(NoteNum As Int) As String
	Return DrumMap.GetDefault(NoteNum,"Not Found")
End Sub
'Get the drum note number from it's name
Sub GetDrumNoteNum(DrumName As String) As Int
	Return DrumMap.GetDefault(DrumName,-1)
End Sub
'Get a list of available Durm Names
Sub GetDrumNames As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each Item As Object In DrumMap.Keys
		If Item Is String Then ReturnList.Add(Item)
	Next
	Return ReturnList
End Sub
'Get a list of available Drum Note Numbers
Sub GetDrumNotes As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each Item As Object In DrumMap.Keys
		If Item Is Int Then ReturnList.Add(Item)
	Next
	Return ReturnList
End Sub