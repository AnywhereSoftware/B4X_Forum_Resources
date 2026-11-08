B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private Tjo As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Instantiates a new find options with pagination criteria.
Public Sub Create(Offset As Int, Size As Int)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("org.dizitart.no2.FindOptions",Array As Object(Offset, Size))
End Sub

'Instantiates a new find options with sorting criteria.
Public Sub Create2(Field As String, Ascending As Boolean)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Dim SortOrder As String = "Ascending"
	If Ascending = False Then SortOrder = "Descending"
	Tjo.InitializeNewInstance("org.dizitart.no2.FindOptions",Array As Object(Field, SortOrder))
End Sub

'Instantiates a new find options with sorting criteria.
Public Sub Create3(Field As String, Ascending As Boolean, Collator As RuleBasedCollator)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Dim SortOrder As String = "Ascending"
	If Ascending = False Then SortOrder = "Descending"
	Tjo.InitializeNewInstance("org.dizitart.no2.FindOptions",Array As Object(Field, SortOrder, Collator.GetObject))
End Sub

'Instantiates a new find options with sorting criteria and null value order.
'NullOrder should be one of "Default", "First" or "Last"
Public Sub Create4(Field As String, Ascending As Boolean, Collator As RuleBasedCollator, NullOrder As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Dim SortOrder As String = "Ascending"
	If Ascending = False Then SortOrder = "Descending"
	Tjo.InitializeNewInstance("org.dizitart.no2.FindOptions",Array As Object(Field, SortOrder, Collator.GetObject, NullOrder))
End Sub

'Instantiates a new find options with sorting criteria and null value order.
'NullOrder should be one of "Default", "First" or "Last"
Public Sub Create5(Field As String, Ascending As Boolean, NullOrder As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Dim SortOrder As String = "Ascending"
	If Ascending = False Then SortOrder = "Descending"
	Tjo.InitializeNewInstance("org.dizitart.no2.FindOptions",Array As Object(Field, SortOrder, NullOrder))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Gets the collator instance for sorting of String.
Public Sub GetCollator As RuleBasedCollator
	Dim Wrapper As RuleBasedCollator
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("getCollator",Null))
	Return Wrapper
End Sub
'Gets the target value name for sorting the find results.
Public Sub GetField As String
	Return Tjo.RunMethod("getField",Null)
End Sub
'Gets the null values order of the find result.
Public Sub GetNullOrder As String
	Return Tjo.RunMethod("getNullOrder",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Gets the offset for pagination in find operation.
Public Sub GetOffset As Int
	Return Tjo.RunMethod("getOffset",Null)
End Sub
'Gets the number of records in each page for pagination in find operation results.
Public Sub GetSize As Int
	Return Tjo.RunMethod("getSize",Null)
End Sub
'Gets the sort order of the find result.
Public Sub GetAscending As Boolean
	Return Tjo.RunMethod("getSortOrder",Null)
End Sub

'Sets the pagination criteria of a @FindOptions with sorting updateOptions.
Public Sub ThenLimit(Offset As Int, Size As Int) As FindOptions
	Dim Wrapper As FindOptions
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("thenLimit",Array As Object(Offset, Size)))
	Return Wrapper
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

