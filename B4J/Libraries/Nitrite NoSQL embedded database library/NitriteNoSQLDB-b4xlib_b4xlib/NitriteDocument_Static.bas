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
'Created a new Document from a key-value pair.
Public Sub CreateDocument(Key As String, Value As Object) As NitriteDocument
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.dizitart.no2.Document")
	Dim Wrapper As NitriteDocument
	Wrapper.Initialize
	Wrapper.SetObject(TJO1.RunMethod("createDocument",Array As Object(Key, Value)))
	Return Wrapper
End Sub

'Creates a document with all the fields and values within the passed Map
Public Sub CreateDocument2(M As Map) As NitriteDocument
	Dim NI As NitriteDocument
	NI.Initialize
	NI.Create2(Nitrite_Utils.UnwrapMap(M))
	Return NI
End Sub

'Creates an empty document
Public Sub CreateDocument3 As NitriteDocument
	Dim NI As NitriteDocument
	NI.Initialize
	NI.Create
	Return NI
End Sub