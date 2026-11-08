B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private Tjo As JavaObject
	'You may need to remove this if another class has already defined it.
	Type FileType(SourceDirName As String,SourceFileName As String)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'It builds an extractor using a DefaultFFMPEGLocator instance to locate the ffmpeg executable to use.
Public Sub Create(SourceDirName As String, SourceFileName As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	'Code for File Object Creation
	Dim Input As JavaObject
	Input.InitializeNewInstance("java.io.File",Array(SourceDirName,SourceFileName))

	Tjo.InitializeNewInstance("ws.schild.jave.MultimediaObject",Array As Object(Input))
End Sub

'It builds an extractor using a DefaultFFMPEGLocator instance to locate the ffmpeg executable to use.
Public Sub Create2(Url As String)
	Dim U As JavaObject
	U.InitializeNewInstance("java.net.URL",Array(Url))
	
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("ws.schild.jave.MultimediaObject",Array As Object(U))
End Sub

'It builds an extractor using a DefaultFFMPEGLocator instance to locate the ffmpeg executable to use.
Public Sub Create3(Url As String, ReadURLOnce As Boolean)
	Dim U As JavaObject
	U.InitializeNewInstance("java.net.URL",Array(Url))
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("ws.schild.jave.MultimediaObject",Array As Object(U, ReadURLOnce))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'*
Public Sub GetFile As FileType
	Dim FileObject As JavaObject =Tjo.RunMethod("getFile",Null)
	Dim FT As FileType
	FT.Initialize
	FT.SourceDirName = FileObject.RunMethod("getPath",Null)
	FT.SourceFileName = FileObject.RunMethod("getName",Null)
	Return FT
End Sub
'Returns a set informations about a multimedia file, if its format is supported for decoding.
Public Sub GetInfo As JavaObject
	Return Tjo.RunMethod("getInfo",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'*
Public Sub GetURL As JavaObject
	Return Tjo.RunMethod("getURL",Null)
End Sub
'*
Public Sub IsReadURLOnce As Boolean
	Return Tjo.RunMethod("isReadURLOnce",Null)
End Sub
'Check if we have a file or an URL
Public Sub IsURL As Boolean
	Return Tjo.RunMethod("isURL",Null)
End Sub
'*
Public Sub SetFile(SourceDirName As String, SourceFileName As String)
	'Code for File Object Creation
	Dim TFile As JavaObject
	TFile.InitializeNewInstance("java.io.File",Array(SourceDirName,SourceFileName))

	Tjo.RunMethod("setFile",Array As Object(TFile))
End Sub
'*
Public Sub SetReadURLOnce(ReadURLOnce As Boolean)
	Tjo.RunMethod("setReadURLOnce",Array As Object(ReadURLOnce))
End Sub
'*
Public Sub SetURL(Input As JavaObject)
	Tjo.RunMethod("setURL",Array As Object(Input))
End Sub
'*
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub


