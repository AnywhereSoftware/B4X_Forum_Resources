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

	Private TJO As JavaObject
End Sub

'*
Public Sub Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("org.dizitart.no2.tool.ExportOptions",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Specifies a list of PersistentCollections to be exported.
Public Sub GetCollections As List
	Dim L As List = TJO.RunMethod("getCollections",Null)
	Dim L1 As List
	L1.Initialize
	For Each O As Object In L
		Dim Wrapper As PersistantCollection
		Wrapper.Initialize
		Wrapper.SetObject(O)
		L1.Add(Wrapper)
	Next
	Return L1
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Indicates if the export operation exports collection data.
Public Sub IsExportData As Boolean
	Return TJO.RunMethod("isExportData",Null)
End Sub
'Indicates if the export operation exports indices information.
Public Sub IsExportIndices As Boolean
	Return TJO.RunMethod("isExportIndices",Null)
End Sub
'Specifies a list of PersistentCollections to be exported.
Public Sub SetCollections(Collections As List)
	TJO.RunMethod("setCollections",Array As Object(UnWrapTypedList(Collections,"org.dizitart.no2.PersistentCollections")))
End Sub
'Indicates if the export operation exports collection data.
Public Sub SetExportData(ExportData As Boolean)
	TJO.RunMethod("setExportData",Array As Object(ExportData))
End Sub
'Indicates if the export operation exports indices information.
Public Sub SetExportIndices(ExportIndices As Boolean)
	TJO.RunMethod("setExportIndices",Array As Object(ExportIndices))
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
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