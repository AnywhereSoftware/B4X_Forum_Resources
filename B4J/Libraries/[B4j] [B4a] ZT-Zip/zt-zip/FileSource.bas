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
Public Sub Create(Path As String,DirName As String, FileName As String)
	Dim TFile As JavaObject
	TFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	TJO.InitializeNewInstance("org.zeroturnaround.zip.FileSource",Array As Object(Path, TFile))
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
'Creates a sequence of FileSource objects via mapping a sequence of FileDir And FileNames to the sequence of corresponding names for the entries
Public Sub Pair(FileDir() As String, FileNames() As String, Names() As String) As FileSource()
	Dim Files(FileDir.Length) As JavaObject
	For i = 0 To FileDir.Length - 1
		Files(i).InitializeNewInstance("java.io.File",Array(FileDir(i),FileNames(i)))
	Next
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.FileSource")
	Dim Temp() As Object = TJO1.RunMethod("pair",Array As Object(Files, Names))
	Dim Wrapper(Temp.length) As FileSource
	For i = 0 To Temp.Length - 1
		Wrapper(i).Initialize
		Wrapper(i).SetObject(Temp(i))
	Next
	Return Wrapper
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

