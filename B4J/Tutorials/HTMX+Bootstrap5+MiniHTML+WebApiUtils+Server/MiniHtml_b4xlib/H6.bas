B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "h6"
End Sub

Public Sub init As Tag
	Return Html.create(tagname)
End Sub

Public Sub attribute (key As String, value As String) As Tag
	Return init.attribute(key, value)
End Sub

Public Sub attribute2 (keyvals As Map) As Tag
	Return init.attribute2(keyvals)
End Sub

Public Sub up (Parent As Tag) As Tag
	Return init.up(Parent)
End Sub

Public Sub Text (value As String) As Tag
	Return init.Text(value)
End Sub

Public Sub addClass (name As String) As Tag
	Return init.addClass(name)
End Sub

Public Sub addStyle (name As String) As Tag
	Return init.addStyle(name)
End Sub