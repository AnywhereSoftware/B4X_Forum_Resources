B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.51
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private TJO As JavaObject
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'*
Public Sub GetEntry As ZipEntry
	Dim Wrapper As ZipEntry
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getEntry",Null))
	Return Wrapper
End Sub
'*
Public Sub GetInputStream As InputStream
	Return TJO.RunMethod("getInputStream",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'*
Public Sub GetPath As String
	Return TJO.RunMethod("getPath",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

