B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.5
@EndOfDesignText@
'Class module
'Version 1.00
Sub Class_Globals
	Private parser As SaxParser
	Private KeyValueStack As List
	Private Root As Map
	Private CurrentKey As String
End Sub

Public Sub Initialize
	parser.Initialize
	
End Sub

Public Sub Parse (In As InputStream) As Map
	KeyValueStack.Initialize
	parser.Parse(In, "parser")
	Return Root
End Sub

Sub Parser_StartElement (Uri As String, Name As String, Attributes As Attributes)
	If Name = "plist" Then Return
	Dim Top As Object = GetTop
	Dim NewValue As Object = Null
	If Name = "dict" Then
		Dim dict As Map
		dict.Initialize
		NewValue = dict
	Else If Name = "array" Then
		Dim lst As List
		lst.Initialize
		NewValue = lst
	End If
	If Top = Null Then
		'first element.
		Root = NewValue
		KeyValueStack.Add(Root)
	Else if NewValue <> Null Then
		If CurrentKey <> "" Then
			'second element inside dict
			Dim m As Map = Top
			m.Put(CurrentKey, NewValue)
			KeyValueStack.Add(NewValue)
			CurrentKey = ""
		Else if Top Is List Then
			'inside array
			Dim l1 As List = Top
			l1.Add(NewValue)
			KeyValueStack.Add(NewValue)
		End If
	End If
End Sub

Private Sub GetTop As Object
	If KeyValueStack.Size = 0 Then Return Null
	Return KeyValueStack.Get(KeyValueStack.Size - 1)
End Sub

Sub Parser_EndElement (Uri As String, Name As String, Text As StringBuilder)
	If Name = "plist" Then Return
	Dim top As Object = GetTop
	If Name = "key" Then
		CurrentKey = Text
	Else If Name = "array" Or Name = "dict" Then
		KeyValueStack.RemoveAt(KeyValueStack.Size - 1)
	Else
		Dim value As Object
		Select Name
			Case "string", "date", "data"
				value = Text.ToString
			Case "real", "integer"
				Dim d As Double = Text.ToString
				value = d
			Case "true", "false"
				value = Name = "true"
		End Select
		If CurrentKey <> "" Then
			Dim m As Map = top
			m.Put(CurrentKey, value)
			CurrentKey = ""
		Else
			Dim l As List = top
			l.Add(value)
		End If
	End If
End Sub


