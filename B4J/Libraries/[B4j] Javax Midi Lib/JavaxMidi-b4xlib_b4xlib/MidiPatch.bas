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

	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub

'Constructs a new patch object from the specified bank and program numbers.
Public Sub Create(Bank As Int, Program As Int)
	TJO.InitializeNewInstance("javax.sound.midi.Patch",Array As Object(Bank, Program))
End Sub

'Returns the number of the bank that contains the instrument whose location this Patch specifies.
Public Sub GetBank As Int
	Return TJO.RunMethod("getBank",Null)
End Sub
'Returns the index, within a bank, of the instrument whose location this Patch specifies.
Public Sub GetProgram As Int
	Return TJO.RunMethod("getProgram",Null)
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
	Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
	Return TJO
End Sub
'Comment if not needed

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub


