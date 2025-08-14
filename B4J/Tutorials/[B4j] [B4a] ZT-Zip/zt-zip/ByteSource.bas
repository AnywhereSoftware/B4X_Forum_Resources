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

'*
Public Sub Create(Path As String, Bytes() As Byte)
	TJO.InitializeNewInstance("org.zeroturnaround.zip.ByteSource",Array As Object(Path, Bytes))
End Sub

'*
Public Sub Create2(Path As String, Bytes() As Byte, CompressionMethod As Int)
	TJO.InitializeNewInstance("org.zeroturnaround.zip.ByteSource",Array As Object(Path, Bytes, CompressionMethod))
End Sub

'*
Public Sub Create3(Path As String, Bytes() As Byte, Time As Long)
	TJO.InitializeNewInstance("org.zeroturnaround.zip.ByteSource",Array As Object(Path, Bytes, Time))
End Sub

'*
Public Sub Create4(Path As String, Bytes() As Byte, Time As Long, CompressionMethod As Int)
	TJO.InitializeNewInstance("org.zeroturnaround.zip.ByteSource",Array As Object(Path, Bytes, Time, CompressionMethod))
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
'*
Public Sub ToString As String
	Return TJO.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

