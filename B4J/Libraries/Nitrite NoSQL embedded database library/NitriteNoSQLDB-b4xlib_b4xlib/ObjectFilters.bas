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
	Private mTag As Object
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub
'Class is a subclass with no constructor, we need to set the object on which JavaObject will operate.
Public Sub SetObject(Target As JavaObject)
	Tjo = Target
End Sub

'A filter to select all elements.
Public Sub ALL As ObjectFilters
	Dim JO As JavaObject
	JO.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(JO.GetField("ALL"))
	Wrapper.Tag = "ALL"
	Return Wrapper
End Sub

'Creates an and filter which performs a logical AND operation on two filters and selects the documents that satisfy both filters.
Public Sub And(TFilters As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("and",Array( UnWrapTypedList(TFilters, "org.dizitart.no2.objects.filters.ObjectFilters"))))
	Return Wrapper
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Creates an element match filter that matches documents that contain an array value with at least one element that matches the specified filter.
Public Sub ElemMatch(Field As String, TFilter As ObjectFilters) As ObjectFilters
	Dim Filt As Object
	If TFilter.Tag = "ALL" Then
		Filt = Null
	Else
		Filt = TFilter.GetObject
	End If
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("elemMatch",Array As Object(Field, Filt)))
	Return Wrapper
End Sub
'Creates an equality filter which matches documents where the value of a field equals the specified value.
Public Sub Eq(Field As String, Value As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("eq",Array As Object(Field, Value)))
	Return Wrapper
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Creates a greater than filter which matches those documents where the value of the value is greater than (i.e.
Public Sub Gt(Field As String, Value As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("gt",Array As Object(Field, Value)))
	Return Wrapper
End Sub
'Creates a greater equal filter which matches those documents where the value of the value is greater than or equals to (i.e.
Public Sub Gte(Field As String, Value As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("gte",Array As Object(Field, Value)))
	Return Wrapper
End Sub
'Creates an in filter which matches the documents where the value of a field equals any value in the specified array.
Public Sub IsIn(Field As String, Values() As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("in",Array As Object(Field, Values)))
	Return Wrapper
End Sub
'Creates a lesser than filter which matches those documents where the value of the value is less than (i.e.
Public Sub Lt(Field As String, Value As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("lt",Array As Object(Field, Value)))
	Return Wrapper
End Sub
'Creates a lesser equal filter which matches those documents where the value of the value is lesser than or equals to (i.e.
Public Sub Lte(Field As String, Value As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("lte",Array As Object(Field, Value)))
	Return Wrapper
End Sub
'Creates a not filter which performs a logical NOT operation on a filter and selects the documents that do not satisfy the filter.
Public Sub Not_(TFilter As ObjectFilters) As ObjectFilters
	Dim Filt As Object
	If TFilter.Tag = "ALL" Then
		Filt = Null
	Else
		Filt = TFilter.GetObject
	End If
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("not",Array As Object(Filt)))
	Return Wrapper
End Sub
'Creates a notIn filter which matches the documents where the value of a field not equals any value in the specified array.
Public Sub NotIn(Field As String, Values() As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("notIn",Array As Object(Field, Values)))
	Return Wrapper
End Sub
'Creates an or filter which performs a logical OR operation on two filters and selects the documents that satisfy at least one of the filter.
Public Sub Or_(TFilters As Object) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("or",Array As Object( UnWrapTypedList(TFilters, "org.dizitart.no2.objects.filters.ObjectFilters"))))
	Return Wrapper
End Sub
'Creates a string filter which provides regular expression capabilities for pattern matching strings in documents.
Public Sub Regex_(Field As String, Value As String) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("regex",Array As Object(Field, Value)))
	Return Wrapper
End Sub
'Creates a text filter which performs a text search on the content of the fields indexed with a full-text index.
Public Sub Text(Field As String, Value As String) As ObjectFilters
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.objects.filters.ObjectFilters")
	Dim Wrapper As ObjectFilters
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("text",Array As Object(Field, Value)))
	Return Wrapper
End Sub


'UnWrap a Wrapped array . 
'Arr is an array of wrapped objects
Private Sub UnWrapTypedArray(Arr As Object,UnWrapType As String) As Object
	Dim P1 As JavaObject
	Dim ObjArr() As Object = Arr
	Dim ResultArr(ObjArr.Length) As Object
	For i = 0 To ObjArr.Length - 1
		ResultArr(i) = GetWrappedObject(ObjArr(i))
	Next
	If UnWrapType = "" Then UnWrapType = GetType(ResultArr(0))
	P1.InitializeArray(UnWrapType,ResultArr)
	Return P1
End Sub

'UnWrap a Wrapped List. 
'Arr is an array of wrapped objects
Private Sub UnWrapTypedList(L As JavaObject,UnWrapType As String) As Object
	Dim P1 As JavaObject
	Dim ObjArr() As Object = L.RunMethod("toArray",Null)
	Dim ResultArr(ObjArr.Length) As Object
	For i = 0 To ObjArr.Length - 1
		ResultArr(i) = GetWrappedObject(ObjArr(i))
	Next
	If UnWrapType = "" Then UnWrapType = GetType(ResultArr(0))
	P1.InitializeArray(UnWrapType,ResultArr)
	Return P1
End Sub

'Gets a wrapped object from any wrapper class that has a AsObject Sub 
'without knowing it's type
Private Sub GetWrappedObject(jObj As JavaObject) As JavaObject
	Try
		'Unwrap JOLibs
    #if Debug
		Return jObj.RunMethod("_getobject",Array(jObj))
    #end if
    #if Release
    Return jObj.RunMethod("_getobject",Null)
    #End if
	Catch
		Try
			'Unwrap B4x objects
			Return jObj.RunMethod("getObject",Null)
		Catch
			Log(LastException)
			Log("Invalid type passed to Sub " & GetType(jObj))
		End Try
    
		Return Null
	End Try
End Sub

Public Sub setTag(Tag As Object)
	mTag = Tag
End Sub

Public Sub getTag As Object
	Return mTag
End Sub