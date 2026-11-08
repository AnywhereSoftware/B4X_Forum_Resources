B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
'@SLHide
Sub Class_Globals
	Private mFileType As Int
	Private mDivisionType As Float
	Private mResolution As Int
	Private mUNKNOWN_LENGTH As Int = MidiFileFormat_Static.UNKNOWN_LENGTH
	Private mByteLength As Int = mUNKNOWN_LENGTH
	Private mMicrosecondLength As Long = mUNKNOWN_LENGTH
	
End Sub

'Initializes the object.
Public Sub Initialize(FileType As Int, DivisionType As Int, Resolution As Int, Bytes As Int, Microseconds As Int)
	mFileType = FileType
	mDivisionType = DivisionType
	mResolution = Resolution
	mByteLength = Bytes
	mMicrosecondLength = Microseconds

End Sub
'Get the MIDI file type (0, 1, or 2).
Sub getFileType As Int
	Return mFileType
End Sub
'Get the file division type.
Sub getDivisionType As Float
	Return mDivisionType
End Sub
'Get the file timing resolution.  If the division type is PPQ, then this
 'value represents ticks per beat, otherwise it's ticks per frame (SMPTE).
 Sub getResolution As Int
 	Return mResolution
End Sub
'Get the file length in bytes.
Sub getByteLength As Int
	Return mByteLength
End Sub
'Get the file length in microseconds.
Sub getMicrosecondLength As Long
	Return mMicrosecondLength
End Sub
'Static int representation for unknown length (-1)
Sub getUNKNOWN_LENGTH As Int
	Return mUNKNOWN_LENGTH
End Sub
