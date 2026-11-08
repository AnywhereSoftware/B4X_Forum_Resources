B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
'	Private fx As JFX
End Sub

'Creates an IndexOptions with the specified indexType.
'Index type is one of the PresistantCollection INDEXTYPE constants
Public Sub NewIndexOptions(IndexType As String) As IndexOptions
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.dizitart.no2.IndexOptions")
	Dim Wrapper As IndexOptions
	Wrapper.Initialize
	Wrapper.SetObject(TJO1.RunMethod("indexOptions",Array As Object(IndexType)))
	Return Wrapper
End Sub