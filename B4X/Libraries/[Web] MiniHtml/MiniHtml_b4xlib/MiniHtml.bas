B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
'	Type Table (attribute As attribute, attribute2 As attribute2, Parent As Tag, addClass As Classes, addStyle As Styles)
'	Type attribute (key As String, value As String)
'	Type attribute2 (keyvals As Map)
'	'Type attributes (key As String, value As String)
'	'Type Parent (Parent As Tag)
'	Type Classes (name As String)
'	Type Styles (name As String)
End Sub

Public Sub Initialize
	
End Sub

Public Sub Create (name As String) As Tag
	Dim tag1 As Tag
	tag1.Initialize(name)
	Return tag1
End Sub