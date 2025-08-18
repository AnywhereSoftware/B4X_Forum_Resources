B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private math As BANanoObject
	Private banano As BANano
End Sub

Sub Init
	'initialize the math object
	math.Initialize("Math")
	'
	Dim res As Double = min1(Array As Int(1, 2, 3, 4, 5))
	banano.Alert(res)
End Sub

'find the min of the list elements
Sub min1(args As List) As Double
	'this does not work
	Dim rslt As Double = math.GetFunction("min").Execute(args).Result
	'this works
	'Dim rslt As Double = math.GetFunction("min").Execute(Array As Int(1,2,3,4,5)).Result
	Return rslt
End Sub