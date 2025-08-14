B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub
'Get the Views Parent
Sub GetParent(V As JavaObject) As Object
	Return V.RunMethod("getParent",Null)
End Sub
'Check two Object arrays for equality (Length and Data)
Public Sub ArrEqualsObj(A() As Object, A2() As Object) As Boolean
    Dim JO As JavaObject
    JO.InitializeStatic("java.util.Arrays")
    Return JO.RunMethod("equals",Array As Object(A, A2))
End Sub
'Check two Byte arrays for equality (Length and Data)
Public Sub ArrEqualsByte(A() As Byte, A2() As Byte) As Boolean
    Dim JO As JavaObject
    JO.InitializeStatic("java.util.Arrays")
    Return JO.RunMethod("equals",Array As Object(A, A2))
End Sub
'Log all Track Events
Sub LogTrackEvents(Track As MidiTrack)
	LogColor("_____________________",Colors.Blue)
	For Each Evt As MidiEvent In Track.EventList
		Log(Evt.ToString("UTF-8"))
	Next
End Sub
'Returns an Int Number as it's Hex String representation
Sub AsHex(Num As Int) As String

	'Create the Formatter Object
    Dim Format As JavaObject
    Format.InitializeStatic("java.lang.String")
	Dim FormatString As String = "%#4X"
	
	Return Format.RunMethod("format",Array As Object(FormatString,Array As Object(Num)))
End Sub
'Copies all Midi Events from Merge, into MergeWith
Sub MergeMidiTracks(Merge As MidiTrack,MergeWith As MidiTrack)
	For Each Evt As MidiEvent In Merge.EventList
		MergeWith.Add(Evt)
	Next
End Sub
'Copies all Midi Events from each Midi Track in Merge, into MergeWith
Sub MergeMidiTracks2(Merge As List,MergeWith As MidiTrack)
	For Each T As MidiTrack In Merge
		For Each Evt As MidiEvent In T.EventList
			MergeWith.Add(Evt)
		Next
	Next
End Sub
'Copies all Midi Events from Both Midi Tracks and Returns a New Midi Track
Sub MergeMidiTracksToNew(Track1 As MidiTrack,Track2 As MidiTrack) As MidiTrack
	Dim Tracks As List = Array As MidiTrack(Track1,Track2)
	Return MergeMidiTracksToNew2(Tracks)
End Sub
'Copies all Midi Events from each Midi Track in List Tracks and Returns a New Midi Track
Sub MergeMidiTracksToNew2(Tracks As List) As MidiTrack
	Dim New As MidiTrack
	New.Initialize
	For Each T As MidiTrack In Tracks
		For Each Evt As MidiEvent In T.EventList
			New.Add(Evt)
		Next
	Next
	Return New
End Sub
