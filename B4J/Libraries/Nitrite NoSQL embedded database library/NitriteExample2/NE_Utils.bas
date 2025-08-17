B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub NotNull(O As Object) As String
	If O = Null Then Return ""
	Return O
End Sub

Public Sub ToArray(L As JavaObject) As Object()
	Return L.RunMethod("toArray",Null)
End Sub

Public Sub ToDouble(D As Double) As Double
	Return D
End Sub

Public Sub ToInt(I As Int) As Int
	Return I
End Sub