B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private TJO As JavaObject

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub
'Class is a subclass with no constructor, we need to set the object on which JavaObject will operate.
Public Sub SetObject(Target As JavaObject)
	TJO = Target
End Sub

'Turns off all notes that are currently sounding on this channel.
Public Sub AllNotesOff
	TJO.RunMethod("allNotesOff",Null)
End Sub
'Immediately turns off all sounding notes on this channel, ignoring the state of the Hold Pedal and the internal decay rate of the current Instrument.
Public Sub AllSoundOff
	TJO.RunMethod("allSoundOff",Null)
End Sub
'Reacts to a change in the specified controller's value.
Public Sub ControlChange(Controller As Int, Value As Int)
	TJO.RunMethod("controlChange",Array As Object(Controller, Value))
End Sub
'Obtains the channel's keyboard pressure.
Public Sub GetChannelPressure As Int
	Return TJO.RunMethod("getChannelPressure",Null)
End Sub
'Obtains the current value of the specified controller.
Public Sub GetController(Controller As Int) As Int
	Return TJO.RunMethod("getController",Array As Object(Controller))
End Sub
'Obtains the current mono/poly mode.
Public Sub GetMono As Boolean
	Return TJO.RunMethod("getMono",Null)
End Sub
'Obtains the current mute state for this channel.
Public Sub GetMute As Boolean
	Return TJO.RunMethod("getMute",Null)
End Sub
'Obtains the current omni mode.
Public Sub GetOmni As Boolean
	Return TJO.RunMethod("getOmni",Null)
End Sub
'Obtains the upward or downward pitch offset for this channel.
Public Sub GetPitchBend As Int
	Return TJO.RunMethod("getPitchBend",Null)
End Sub
'Obtains the pressure with which the specified key is being depressed.
Public Sub GetPolyPressure(NoteNumber As Int) As Int
	Return TJO.RunMethod("getPolyPressure",Array As Object(NoteNumber))
End Sub
'Obtains the current program number for this channel.
Public Sub GetProgram As Int
	Return TJO.RunMethod("getProgram",Null)
End Sub
'Obtains the current solo state for this channel.
Public Sub GetSolo As Boolean
	Return TJO.RunMethod("getSolo",Null)
End Sub
'Turns local control on or off.
Public Sub LocalControl(On As Boolean) As Boolean
	Return TJO.RunMethod("localControl",Array As Object(On))
End Sub
'Turns the specified note off.
Public Sub NoteOff(NoteNumber As Int)
	TJO.RunMethod("noteOff",Array As Object(NoteNumber))
End Sub
'Turns the specified note off.
Public Sub NoteOff2(NoteNumber As Int, Velocity As Int)
	TJO.RunMethod("noteOff",Array As Object(NoteNumber, Velocity))
End Sub
'Starts the specified note sounding.
Public Sub NoteOn(NoteNumber As Int, Velocity As Int)
	TJO.RunMethod("noteOn",Array As Object(NoteNumber, Velocity))
End Sub
'Changes a program (patch).
Public Sub ProgramChange(Program As Int)
	TJO.RunMethod("programChange",Array As Object(Program))
End Sub
'Changes the program using bank and program (patch) numbers.
Public Sub ProgramChange2(Bank As Int, Program As Int)
	TJO.RunMethod("programChange",Array As Object(Bank, Program))
End Sub
'Resets all the implemented controllers to their default values.
Public Sub ResetAllControllers
	TJO.RunMethod("resetAllControllers",Null)
End Sub
'Reacts to a change in the keyboard pressure.
Public Sub SetChannelPressure(Pressure As Int)
	TJO.RunMethod("setChannelPressure",Array As Object(Pressure))
End Sub
'Turns mono mode on or off.
Public Sub SetMono(On As Boolean)
	TJO.RunMethod("setMono",Array As Object(On))
End Sub
'Sets the mute state for this channel.
Public Sub SetMute(Mute As Boolean)
	TJO.RunMethod("setMute",Array As Object(Mute))
End Sub
'Turns omni mode on or off.
Public Sub SetOmni(On As Boolean)
	TJO.RunMethod("setOmni",Array As Object(On))
End Sub
'Changes the pitch offset for all notes on this channel.
Public Sub SetPitchBend(Bend As Int)
	TJO.RunMethod("setPitchBend",Array As Object(Bend))
End Sub
'Reacts to a change in the specified note's key pressure.
Public Sub SetPolyPressure(NoteNumber As Int, Pressure As Int)
	TJO.RunMethod("setPolyPressure",Array As Object(NoteNumber, Pressure))
End Sub
'Sets the solo state for this channel.
Public Sub SetSolo(SoloState As Boolean)
	TJO.RunMethod("setSolo",Array As Object(SoloState))
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
	Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
	Return TJO
End Sub


