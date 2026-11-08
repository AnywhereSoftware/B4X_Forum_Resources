B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private Driver As JavaObject
	Private Instance As JavaObject
	Private mCallback As Object
	
	Public const REVERB_OFF As Int = -1
	Public const REVERB_LARGE_HALL As Int = 0
	Public const REVERB_HALL As Int = 1
	Public const REVERB_CHAMBER As Int = 2
	Public const REVERB_ROOM As Int = 3

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallBack As Object)
	mCallback = CallBack
	
	Driver.InitializeStatic("org.billthefarmer.mididriver.MidiDriver")
	
	If SubExists(mCallback,"Midi_Ready") Then
		Dim O As Object = Driver.CreateEvent("org.billthefarmer.mididriver.MidiDriver$OnMidiStartListener","MidiStart",Null)
		Instance = Driver.RunMethod("getInstance",Array(O))
	Else
		Instance = Driver.RunMethod("getInstance",Null)
	End If
End Sub

Private Sub MidiStart_Event (MethodName As String, Args() As Object)
	CallSubDelayed(mCallback,"Midi_Ready")
End Sub

Public Sub Start
	Instance.RunMethod("start",Null)
End Sub

Public Sub Stop
	Instance.RunMethod("stop",Null)
End Sub

Public Sub Close
	Instance.RunMethod("shutdown",Null)
End Sub

Public Sub SendMidi(msg() As Byte)
	Instance.RunMethod("write",Array(msg))
End Sub

'Volume value between 0  and 100.
Public Sub SetVolume(Volume As Int)
	Instance.RunMethod("setVolume",Array(Volume))
End Sub

'Preset - One of the REVERB_ Constants
Public Sub SetReverb(Preset As Int)
	Instance.RunMethod("setReverb",Array(Preset))
End Sub