B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

'Return a positive number if o1 greater than o2 (=o1 comes after o2), 0 if o1 equals to o2 and a negative number if o1 smaller than o2.
Public Sub Compare (o1 As Object, o2 As Object) As Int
	Dim p1 As Person = o1
	Dim p2 As Person = o2
	If p1.Status = "Employee" And p2.Status <> "Employee" Then Return -1
	If p2.Status = "Employee" And p1.Status <> "Employee" Then Return 1
	If p1.Name = p2.Name Then
		If p1.Age > p2.Age Then Return 1
		If p1.Age < p2.Age Then Return - 1
	End If
	Return p1.Name.CompareTo(p2.Name)
End Sub