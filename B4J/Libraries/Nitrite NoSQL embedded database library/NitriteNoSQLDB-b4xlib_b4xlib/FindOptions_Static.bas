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

'Creates a find options with pagination criteria.
Public Sub Limit(Offset As Int, Size As Int) As FindOptions
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.FindOptions")
	Dim Wrapper As FindOptions
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("limit",Array As Object(Offset, Size)))
	Return Wrapper
End Sub
'Creates a find options with sorting criteria.
Public Sub Sort(Field As String, Ascending As Boolean) As FindOptions
	Dim SortOrder As String = "Ascending"
	If Ascending = False Then SortOrder = "Descending"
	
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.FindOptions")
	Dim Wrapper As FindOptions
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("sort",Array As Object(Field, SortOrder)))
	Return Wrapper
End Sub
'Creates a find options with sorting criteria.
Public Sub Sort2(Field As String, Ascending As Boolean, Collator As RuleBasedCollator) As FindOptions
	Dim SortOrder As String = "Ascending"
	If Ascending = False Then SortOrder = "Descending"
	
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.FindOptions")
	Dim Wrapper As FindOptions
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("sort",Array As Object(Field, SortOrder, Collator.GetObject)))
	Return Wrapper
End Sub
'Creates a find options with sorting criteria.
Public Sub Sort3(Field As String, Ascending As Boolean, Collator As RuleBasedCollator, NullOrder As JavaObject) As FindOptions
	Dim SortOrder As String = "Ascending"
	If Ascending = False Then SortOrder = "Descending"
	
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.FindOptions")
	Dim Wrapper As FindOptions
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("sort",Array As Object(Field, SortOrder, Collator.GetObject, NullOrder)))
	Return Wrapper
End Sub
'Creates a find options with sorting criteria.
'NullOrder should be one of "Default", "First" or "Last"
Public Sub Sort4(Field As String, Ascending As Boolean, NullOrder As String) As FindOptions
	Dim SortOrder As String = "Ascending"
	If Ascending = False Then SortOrder = "Descending"
	
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.FindOptions")
	Dim Wrapper As FindOptions
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("sort",Array As Object(Field, SortOrder, NullOrder)))
	Return Wrapper
End Sub