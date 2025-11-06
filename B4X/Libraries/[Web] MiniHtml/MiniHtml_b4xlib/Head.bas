B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "head"
End Sub

Public Sub init As Tag
	Return Html.create(tagname)
End Sub

'code: <code>script("js/bootstrap.js")</code>
'output: <code><script src="js/bootstrap.js"></script></code>
Public Sub script (value As String) As Tag
	Return init.script(value)
End Sub

'code: <code>script2(CreateMap("src": "js/bootstrap.js"))</code>
Public Sub script2 (keyvals As Map) As Tag
	Return init.script2(keyvals)
End Sub

'code: <code>script3("$cdn$/dist/htmx.min.js", "sha384...", "anonymous")</code>
Public Sub script3 (src As String, integrity As String, crossorigin As String) As Tag
	Return init.script3(src, integrity, crossorigin)
End Sub

'Public Sub attr (key As String, value As String) As Tag
'	Return init.attr(key, value)
'End Sub

'Public Sub attr2 (keyvals As Map) As Tag
'	Return init.attr2(keyvals)
'End Sub

'Add a Child and return the added tag (child)
Public Sub add (Child As Tag) As Tag
	Return init.add(Child)
End Sub

'(same as AddTo)
'Add to Parent and return current tag (child)
Public Sub up (Parent As Tag) As Tag
	Return init.up(Parent)
End Sub

'Set id attribute
Public Sub id (value As String) As Tag
	Return init.attr("id", value)
End Sub