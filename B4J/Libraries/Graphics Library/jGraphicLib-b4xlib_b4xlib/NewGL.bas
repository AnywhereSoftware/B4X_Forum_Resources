B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.01
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub Rectangle(Width As Double,Height As Double,Fill As Paint) As GLRectangle
	Dim R As GLRectangle
	R.Initialize
	R.Create4(Width,Height,Fill)
	Return R
End Sub