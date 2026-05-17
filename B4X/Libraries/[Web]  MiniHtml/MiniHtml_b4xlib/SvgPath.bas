B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10.3
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "path"
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

'Set d attribute value
Public Sub d (value As String) As Tag
	Return init.d(value)
End Sub

'Set svg path strokes attributes
'<code>path1.strokes("", "1.5", "round", "round")</code>
Public Sub strokes (stroke As String, stroke_width As String, stroke_linecap As String, stroke_linejoin As String) As Tag
	Return init.strokes(stroke, stroke_width, stroke_linecap, stroke_linejoin)
End Sub

'Set fill attribute value
Public Sub fill (value As String) As Tag
	Return init.fill(value)
End Sub

'Set fill-rule and clip-rule attributes
'<code>path1.rules("evenodd", "evenodd")</code>
Public Sub rules (fill_rule As String, clip_rule As String) As Tag
	Return init.rules(fill_rule, clip_rule)
End Sub

'Set key-rule attribute value
'e.g fill-rule, clip-rule
'Public Sub rule (key As String, value As String) As Tag
'	Return init.rule(key, value)
'End Sub