B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "form"
End Sub

Public Sub init As Tag
	Return Html.create(tagname)
End Sub

Public Sub attr (key As String, value As String) As Tag
	Return init.attr(key, value)
End Sub

Public Sub attr2 (keyvals As Map) As Tag
	Return init.attr2(keyvals)
End Sub

'Add a Child and return the added tag (child)
Public Sub add (Child As Tag) As Tag
	Return init.add(Child)
End Sub

'(same as AddTo)
'Add to Parent and return current tag (child)
Public Sub up (Parent As Tag) As Tag
	Return init.up(Parent)
End Sub

Public Sub text (value As String) As Tag
	Return init.text(value)
End Sub

'Set id attribute
Public Sub id (value As String) As Tag
	Return init.id(value)
End Sub

'Set name attribute
Public Sub name (value As String) As Tag
	Return init.name(value)
End Sub

'Set action attribute
Public Sub action (value As String) As Tag
	Return init.action(value)
End Sub

'Add a class
Public Sub cls (value As String) As Tag
	Return init.cls(value)
End Sub

'Add one or more styles separated by semicolon
Public Sub sty (value As String) As Tag
	Return init.sty(value)
End Sub

Public Sub hxGet (url As String) As Tag
	Return init.attr("hx-get", url)
End Sub

Public Sub hxPost (url As String) As Tag
	Return init.attr("hx-post", url)
End Sub

Public Sub hxPut (url As String) As Tag
	Return init.attr("hx-put", url)
End Sub

Public Sub hxPatch (url As String) As Tag
	Return init.attr("hx-patch", url)
End Sub

Public Sub hxDelete (url As String) As Tag
	Return init.attr("hx-delete", url)
End Sub