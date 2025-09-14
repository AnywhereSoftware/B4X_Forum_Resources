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

'Reports whether two objects are equal.
Public Sub Equals(MDI As MidiDeviceInfo) As Boolean
	Return TJO.RunMethod("equals",Array As Object(MDI.GetObject))
End Sub
'Obtains the description of the device.
Public Sub GetDescription As String
	Return TJO.RunMethod("getDescription",Null)
End Sub
'Obtains the name of the device.
Public Sub GetName As String
	Return TJO.RunMethod("getName",Null)
End Sub
'Obtains the name of the company who supplies the device.
Public Sub GetVendor As String
	Return TJO.RunMethod("getVendor",Null)
End Sub
'Obtains the version of the device.
Public Sub GetVersion As String
	Return TJO.RunMethod("getVersion",Null)
End Sub
'Finalizes the hashcode method.
Public Sub HashCode As Int
	Return TJO.RunMethod("hashCode",Null)
End Sub
'Provides a string representation of the device information.
Public Sub ToString As String
	Return TJO.RunMethod("toString",Null)
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
	Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
	Return TJO
End Sub


