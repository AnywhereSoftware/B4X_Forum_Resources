B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
'The exporter exports byte arrays as a Base64 String, but the importer has no way of knowing the format of the data
'The data in affected fields will need to be unencoded before it can be used.
Sub Process_Globals
'	Private fx As JFX
End Sub

'Creates a new Importer instance.
Public Sub ImporterOf(Db As Nitrite) As Importer
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.tool.Importer")
	Dim Wrapper As Importer
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("of",Array As Object(Db.GetObject)))
	Return Wrapper
End Sub
