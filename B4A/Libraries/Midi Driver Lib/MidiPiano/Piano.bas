B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Class module
Sub Class_Globals

	Private Gest As Gestures
	Private MainPnl As Panel
	Private Canv As Canvas
	Private SoundMap As Map
	Private PtrMap As Map
	Private TimeDependantMap As Map
	Private ScreenObjects As List
	Type ObjectDefinition (NoteOn() As Byte,NoteOff() As Byte,ObjType As Boolean)
	Private Enabled As Boolean
	Private CurrentOctave As Int = 4
	Private Notes() As Int
	Dim Midi As MidiDriver
	Dim Channel As Int = 0

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Act As Activity)

	'Create the main panel full screen
	MainPnl.Initialize("")
	Act.AddView(MainPnl,0,50%y,100%x,50%y)
	'Initialize the canvas so we can draw our objects
	Canv.Initialize(MainPnl)
	'initialize the maps
	SoundMap.Initialize
	PtrMap.Initialize
	TimeDependantMap.Initialize
	'Set the Gesture On touch listener
	Gest.SetOnTouchListener(MainPnl,"Gest_Touch")
	'Initialize the list to hold the rects for our screen objects
	ScreenObjects.Initialize
	
	'Set our note values for octave 0
	Notes = Array As Int(12,14,16,17,19,21,23,13,15,18,20,22)
	DrawPiano
	Midi.Initialize

End Sub
'Called by the midi library when it is ready to process data
Sub Midi_Midi_Ready
	Enabled = True
End Sub
'Draw a piano keyboard to the main panel
Private Sub DrawPiano
	Canv.DrawColor(Colors.Black)
	Dim KeySpace As Int = 1Dip
	Dim WhiteKeySpace As Float = MainPnl.Width / 7
	Dim WhiteKeyWidth As Float = WhiteKeySpace - KeySpace * 2
	Dim BlackKeyWidth As Float = WhiteKeyWidth * 0.50
	Dim BlackKeyOffset As Float = WhiteKeyWidth * 0.75
	Dim WhiteKeyHeight As Float = MainPnl.Height
	Dim BlackKeyHeight As Float = WhiteKeyHeight * 0.66
	
	Dim BlackKeys As List
	Dim WhiteKeys As List
	BlackKeys.Initialize
	WhiteKeys.Initialize
	
	'Draw the white notes
	For i = 0 To 6
		Dim R As Rect
		Dim Left As Float = i * WhiteKeySpace + KeySpace
		R.Initialize(Left,0,Left + WhiteKeyWidth,WhiteKeyHeight)
		CreateObject(R,64,Colors.White,True)
	Next
	
	'Draw the black notes last so they are found first and are on top of the white notes
	For i = 0 To 5
		If i = 2 Then Continue
		Dim R As Rect
		Dim Left As Float = i * WhiteKeySpace + KeySpace + BlackKeyOffset
		R.Initialize(Left,0,Left + BlackKeyWidth,BlackKeyHeight)
		CreateObject(R,64,Colors.Black,True)
	Next
	'Set the default notes (Octave = 4)
	SetNotes(CurrentOctave)
End Sub
'Set the notes in the Screen objects for the current octave
Private Sub SetNotes(Octave As Int)
	For i = 0 To ScreenObjects.Size - 1
		Dim COD As ObjectDefinition = SoundMap.Get(ScreenObjects.Get(i))
		COD.NoteOn(1) = Notes(i) + Octave * 12
		
		COD.NoteOff(1) = Notes(i) + Octave * 12
	Next
End Sub
'Gesture on touch listener
Private Sub Gest_Touch(V As Object,PtrID As Int,Action As Int,X As Float,Y As Float) As Boolean
	
	If Not(Enabled) Then Return True
	
	Select Action
		Case Gest.ACTION_DOWN, Gest.ACTION_POINTER_DOWN
		'Check if a defined rectangle has been touched
		'Manage pointers so we can play more than one sound at a time
		If Not(PtrMap.GetDefault(PtrID,False)) Then
			PtrMap.Put(PtrID,True)
			'Iterate backwards through the list of screen objects and see if one matches the touch
			For i = ScreenObjects.Size - 1 To 0 Step - 1
				Dim R As Rect = ScreenObjects.Get(i)
				If R.Left <= X AND R.Right >= X AND R.Top <= Y AND R.Bottom >= Y Then
					Dim ObjDef As ObjectDefinition = SoundMap.Get(R)
					Send(ObjDef.NoteOn)
					'Store the ObjDef in time dependant map if it needs to be switched off on pointer up
					If ObjDef.ObjType = True Then
						TimeDependantMap.Put(PtrID,ObjDef)
					End If
					'Only find the first matching ScreenObject
					Exit
				End If
			Next
		End If
		
		'Manage the pointer up
		Case Gest.ACTION_POINTER_UP
			'Turn off the play id if necccessary
			Dim ObjDef As ObjectDefinition  = TimeDependantMap.GetDefault(PtrID,Null)
			If ObjDef <> Null Then
				Send(ObjDef.NoteOff)
				TimeDependantMap.Remove(PtrID)
			End If
			PtrMap.Remove(PtrID)
			
		'The last pointer up may send ACTION_UP instead of ACTION_POINTER_UP on some devices. 
		Case Gest.ACTION_UP
			'Turn off the play id if necccessary
			Dim ObjDef As ObjectDefinition  = TimeDependantMap.GetDefault(PtrID,Null)
			If ObjDef <> Null Then
				Send(ObjDef.NoteOff)
				TimeDependantMap.Remove(PtrID)
			End If
			PtrMap.Clear
	End Select
	
	Return True

End Sub
'Create our screen objects and map them to the sound object
'Objtype determines whether the sound is a one shot (False) or a touch duration dependant timing sound like a piano etc (True)
Private Sub CreateObject(R As Rect,NoteNo As Int,Color As Int,OBjType As Boolean)

'Alternatively pass a bitmap or it's file path and file name to draw
'Sub CreateObject(R as Rect,NoteNo,BitMap1 As Bitmap,ObjType As Boolean)

	Dim ObjDef As ObjectDefinition
	ObjDef.Initialize
	
	ObjDef.NoteOn = Array As Byte(0x90 + Channel,NoteNo,100)
	ObjDef.NoteOff = Array As Byte(0x80 + Channel,NoteNo,0)
	ObjDef.OBjType = OBjType
	
	'Add them to the sound map, with the rect as the key
	SoundMap.Put(R,ObjDef)
	'Add the rect to the screenobjects so we can easily test in Gest_touch if it's the one we want
	ScreenObjects.Add(R)
	'Draw the object.  Change this to Canv.DrawBitmap to draw an image and pass the SampledBitmap to this routine instead of the color.
	Canv.DrawRect(R,Color,True,1)
	'Canv.DrawBitmap(Bitmap1,Null,R)
End Sub
'Start the driver
Sub Start
	Enabled = True
	Midi.Start
End Sub
'Stop the driver
Sub Stop
	Enabled = False
	Midi.Stop
End Sub
'Send the note message to the midi driver
Private Sub Send(Msg() As Byte)
	Midi.SendMidi(Msg)
End Sub
'Set the octave for notes to play in the range (-1 to 9)
'In Octave 9 notes above G are not available and will not play, and others may not respond to the full range 0 - 127
Sub setOctave(Oct As Int)
	CurrentOctave = Max(-1,Min(9,Oct))
	SetNotes(CurrentOctave)
End Sub
