B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
  'Private fx As JFX ' Uncomment if required. For B4j only

  'Constants / Fields are defined here and initialized in Sub UpdateConstants
  
  Private JO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
 	'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name
	MidiSequence_Static.Initialize
	If MidiStatus.IsInitilized = False Then MidiStatus.Initialize
End Sub

'Constructs a new MIDI sequence with the specified timing division type and timing resolution.
Public Sub Create(divType As Float, ThisResolution As Int)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.Sequence",Array As Object(divType, ThisResolution))
End Sub

'Constructs a new MIDI sequence with the specified timing division type, timing resolution, and number of tracks.
Public Sub Create2(divType As Float, ThisResolution As Int, NumTracks As Int)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.Sequence",Array As Object(divType, ThisResolution, NumTracks))
End Sub

'Creates a new, initially empty track as part of this sequence.
Public Sub CreateTrack As MidiTrack
	Dim T As MidiTrack
	T.initialize
	T.SetObject(JO.RunMethod("createTrack",Null))
  	Return T
End Sub
'Removes the specified track from the sequence.
Public Sub DeleteTrack(ThisTrack As MidiTrack) As Boolean
  Return JO.RunMethod("deleteTrack",Array As Object(ThisTrack.GetObject))
End Sub
'Obtains the timing division type for this sequence.
Public Sub GetDivisionType As Float
  Return JO.RunMethod("getDivisionType",Null)
End Sub
'Obtains the duration of this sequence, expressed in microseconds.
Public Sub GetMicrosecondLength As Long
  Return JO.RunMethod("getMicrosecondLength",Null)
End Sub
'Obtains a list of patches referenced in this sequence.
Public Sub GetPatchList As List
	Dim WrapperList As List
	WrapperList.Initialize
	Dim L As List = JO.RunMethod("getPatchList",Null)
	For Each O As Object In L
		Dim Wrapper As MidiPatch
		Wrapper.Initialize
		Wrapper.SetObject(O)
		WrapperList.Add(Wrapper)
	Next
	Return WrapperList
  
End Sub
'Obtains the timing resolution for this sequence.
Public Sub GetResolution As Int
  Return JO.RunMethod("getResolution",Null)
End Sub
'Obtains the duration of this sequence, expressed in MIDI ticks.
Public Sub GetTickLength As Long
  Return JO.RunMethod("getTickLength",Null)
End Sub
'Obtains an array containing all the tracks in this sequence.
Public Sub GetTracks As MidiTrack()
	Dim OArr() As Object = JO.RunMethod("getTracks",Null)
	Dim Tracks(OArr.length) As MidiTrack
	For i = 0 To OArr.length - 1
		Tracks(i).Initialize
		Tracks(i).SetObject(OArr(i))
	Next
  Return Tracks
End Sub

Public Sub GetTracksNative As Object()
	Return JO.RunMethod("getTracks",Null)
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
  Return JO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
  Return JO
End Sub
'Comment if not needed

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	JO = Obj
End Sub

