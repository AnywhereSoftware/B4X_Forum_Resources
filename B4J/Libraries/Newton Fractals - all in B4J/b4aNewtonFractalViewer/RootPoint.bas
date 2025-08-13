B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Dim point As Complex
	Dim numIter As Int
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (point1 As Complex, numInter1 As Int)
	point = point1
	numIter = numInter1
	
End Sub

public Sub getPoint() As Complex
	Return point
End Sub	

public Sub getNumIter() As Int
	
	Return numIter

End Sub


    