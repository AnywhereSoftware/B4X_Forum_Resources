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

'Obtains the Patch object that indicates the bank and program numbers where this instrument is to be stored in the synthesizer.
Public Sub GetPatch As MidiPatch
	Dim Wrapper As MidiPatch
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getPatch",Null))
	Return Wrapper
End Sub
'Obtains the sampled audio that is stored in this SoundbankResource.
Public Sub GetData As Object
	Return TJO.RunMethod("getData",Null)
End Sub
'Obtains the class used by this sample to represent its data.
Public Sub GetDataClass As JavaObject
	Return TJO.RunMethod("getDataClass",Null)
End Sub
'Obtains the name of the resource.
Public Sub GetName As String
	Return TJO.RunMethod("getName",Null)
End Sub
'Obtains the sound bank that contains this SoundbankResource.
Public Sub GetSoundbank As MidiSoundbank
	Dim Wrapper As MidiSoundbank
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getSoundbank",Null))
	Return Wrapper
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
	Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
	Return TJO
End Sub


