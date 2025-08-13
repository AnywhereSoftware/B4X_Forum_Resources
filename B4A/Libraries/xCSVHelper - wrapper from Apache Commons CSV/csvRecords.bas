B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private id As Int
	Private custid As String
	Private fname As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub setid(value As Int)
	id = value
End Sub

Public Sub setcustomerid(value As String)
	custid = value
End Sub

Public Sub setfirstname(value As String)
	fname = value
End Sub