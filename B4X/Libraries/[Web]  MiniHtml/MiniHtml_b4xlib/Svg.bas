B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10.3
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "svg"
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

'Set src attribute
Public Sub src (value As String) As Tag
	Return init.srcOf(value)
End Sub

Public Sub width (value As String) As Tag
	Return init.width(value)
End Sub

Public Sub height (value As String) As Tag
	Return init.height(value)
End Sub

'Public Sub viewBox (value As String) As Tag
'	Return init.viewBox(value)
'End Sub

Public Sub fill (value As String) As Tag
	Return init.fill(value)
End Sub

'Public Sub xmlns (value As String) As Tag
'	Return init.xmlns(value)
'End Sub

Public Sub viewBox2 (value1 As String, value2 As String, value3 As String) As Tag
	Return init.viewBox2(value1, value2, value3)
End Sub

'Set viewBox value 
'Add attributes for fill="none" and xmlns="http://www.w3.org/2000/svg"
Public Sub viewBox (value As String) As Tag
	Return init.viewBox(value)
End Sub

'Set aria- attribute
Public Sub aria (key As String, value As Object) As Tag
	Return init.aria(key, value)
End Sub

'Set id attribute
Public Sub id (value As String) As Tag
	Return init.id(value)
End Sub

'Add a class
Public Sub cls (value As String) As Tag
	Return init.cls(value)
End Sub

'Add one or more styles separated by semicolon
Public Sub sty (value As String) As Tag
	Return init.sty(value)
End Sub