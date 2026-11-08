B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
End Sub

Public Sub Initialize
	
End Sub

'Returns the first document. The type is likely to be a Map but it can be other types depending on the input.
Public Sub Parse (Text As String) As Object
	Return ParseAllDocuments(Text).Get(0)
End Sub

'Returns all documents.
Public Sub ParseAllDocuments (Text As String) As List
	Dim reader As JavaObject
	reader.InitializeNewInstance("com.esotericsoftware.yamlbeans.YamlReader", Array(Text))
	reader.RunMethodJO("getConfig", Null).GetFieldJO("readConfig").RunMethod("setGuessNumberTypes", Array(True))
	Dim res As List
	res.Initialize
	Do While True
		Dim v As Object = reader.RunMethod("read", Null)
		If v = Null Then Exit
		res.Add(v)
	Loop
	Return res
End Sub