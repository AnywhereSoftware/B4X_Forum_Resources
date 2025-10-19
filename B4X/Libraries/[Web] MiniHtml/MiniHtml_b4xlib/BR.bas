B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "br"
End Sub

Public Sub init As Tag
	Return Html.create(tagname)
End Sub

Public Sub up (Parent As Tag) As Tag
	Return init.up(Parent)
End Sub