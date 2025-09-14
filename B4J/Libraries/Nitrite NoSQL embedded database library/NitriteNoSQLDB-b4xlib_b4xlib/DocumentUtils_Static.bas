B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module

'Static Code Module
Sub Process_Globals
  'Private fx As JFX ' Uncomment if required. For B4j only

End Sub

'Create unique filter to identify the document.
Public Sub CreateUniqueFilter(Document As NitriteDocument) As Filter
  Dim Tjo1 As JavaObject
  Tjo1.InitializeStatic("org.dizitart.no2.util.DocumentUtils")
  Dim Wrapper As Filter
  Wrapper.Initialize
  Wrapper.SetObject(Tjo1.RunMethod("createUniqueFilter",Array As Object(Document.GetObject)))
  Return Wrapper
End Sub
'Gets all first level fields of a document.
Public Sub GetFields(Document As NitriteDocument) As List
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.util.DocumentUtils")
	Dim Arr() As Object = Tjo1.RunMethodJO("getFields",Array As Object(Document.GetObject)).RunMethod("toArray",Null)
	Dim L As List
	L.Initialize
	For Each O As Object In Arr
		L.Add(O)
	Next
	Return L
End Sub
'Gets the value of a value inside a document.
Public Sub GetFieldValue(Document As NitriteDocument, Field As String) As Object
  Dim Tjo1 As JavaObject
  Tjo1.InitializeStatic("org.dizitart.no2.util.DocumentUtils")
  Return Tjo1.RunMethod("getFieldValue",Array As Object(Document.GetObject, Field))
End Sub
'Determines whether a document has recently been updated/created than the other.
Public Sub IsRecent(Recent As NitriteDocument, Older As NitriteDocument) As Boolean
  Dim Tjo1 As JavaObject
  Tjo1.InitializeStatic("org.dizitart.no2.util.DocumentUtils")
  Return Tjo1.RunMethod("isRecent",Array As Object(Recent.GetObject, Older.GetObject))
End Sub
