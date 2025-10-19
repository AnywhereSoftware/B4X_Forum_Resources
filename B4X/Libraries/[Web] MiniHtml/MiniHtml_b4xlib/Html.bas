B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "html"
End Sub

Public Sub init As Tag
	Return create(tagname)
End Sub

Public Sub create (newtag As String) As Tag
	Dim tag1 As Tag
	tag1.Initialize(newtag)
	Return tag1
End Sub

Public Sub attr (key As String, value As String) As Tag
	Return init.attr(key, value)
End Sub

Public Sub attr2 (keyvals As Map) As Tag
	Return init.attr2(keyvals)
End Sub

'code: <code>Html.lang("en")</code>
Public Sub lang (value As String) As Tag
	Return init.attr("lang", value)
End Sub

' Add comment on new line
Public Sub comment (value As String) As Tag
	Return create("").comment(value)
End Sub

' Add comment on same line
Public Sub comment2 (value As String) As Tag
	Return create("").comment2(value)
End Sub