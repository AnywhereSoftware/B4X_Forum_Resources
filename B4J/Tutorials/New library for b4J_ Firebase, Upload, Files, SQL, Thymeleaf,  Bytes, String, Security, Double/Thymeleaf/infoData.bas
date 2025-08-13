B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Dim xname As String
	Dim xemail As String
	Dim xage As String
End Sub

Public Sub Initialize
	xname = ""
	xemail = ""
	xage = ""
End Sub

Public Sub setName(value As String)
	xname = value
End Sub

Public Sub getName() As String
	Return xname
End Sub

Public Sub setAge(value As String)
	xage = value
End Sub

Public Sub getAge() As String
	Return xage
End Sub

Public Sub User() As String
	Return "BAJ"
End Sub

Public Sub Roles() As String
	Return "775"
End Sub
