B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Default compression level
Public Sub DEFAULT_COMPRESSION_LEVEL As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO.GetField("DEFAULT_COMPRESSION_LEVEL")
End Sub

'Changes a zip file appends new entries.
'Entries is an object array containing either FileSource or ByteSource or both.
Public Sub AddEntries(DirName As String, FileName As String, Entries() As Object)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("addEntries",Array As Object(Zip, UnWrapTypedArray(Entries,"org.zeroturnaround.zip.ZipEntrySource")))
End Sub

'Copies an existing ZIP file and appends it with new entries.
'Entries is an object array containing either FileSource or ByteSource or both.
Public Sub AddEntries2(SourceDir As String, SourceName As String, Entries() As Object, DestDir As String, DestName As String)
	'Code for File Object Creation
	Dim Source As JavaObject
	Source.InitializeNewInstance("java.io.File",Array(SourceDir,SourceName))
	
	Dim Dest As JavaObject
	Dest.InitializeNewInstance("java.io.File",Array(DestDir,DestName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("addEntries",Array As Object(Source, UnWrapTypedArray(Entries,"org.zeroturnaround.zip.ZipEntrySource"), Dest))
End Sub


'Changes a zip file, adds one new entry in-place.
Public Sub AddEntry(DirName As String, FileName As String, Path As String, Bytes() As Byte)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("addEntry",Array As Object(Zip, Path, Bytes))
End Sub

'Copies an existing ZIP file and appends it with one new entry.
Public Sub AddEntry2(DirName As String, FileName As String, Path As String, Bytes() As Byte, DestDir As String, DestName As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim Dest As JavaObject
	Dest.InitializeNewInstance("java.io.File",Array(DestDir,DestName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("addEntry",Array As Object(Zip, Path, Bytes, Dest))
End Sub

'Changes a zip file, adds one new entry in-place.
Public Sub AddEntry3(DirName As String, FileName As String, Path As String, TFileDir As String, TFileName As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TF As JavaObject
	TF.InitializeNewInstance("java.io.File",Array(TFileDir,TFileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("addEntry",Array As Object(Zip, Path, TF))
End Sub
'Copies an existing ZIP file and appends it with one new entry.
Public Sub AddEntry4(DirName As String, FileName As String, Path As String, TFileDir As String, TFileName As String, DestZipDir As String, DestZipName As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))
	
	Dim TF As JavaObject
	TF.InitializeNewInstance("java.io.File",Array(TFileDir,TFileName))
	
	Dim Dest As JavaObject
	Dest.InitializeNewInstance("java.io.File",Array(DestZipDir,DestZipName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("addEntry",Array As Object(Zip, Path, TF, Dest))
End Sub

'Changes a ZIP file: adds/replaces the given entries in it.
'Entries is an object array containing either FileSource or ByteSource or both.
Public Sub AddOrReplaceEntries(DirName As String, FileName As String, Entries() As Object)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("addOrReplaceEntries",Array As Object(Zip,  UnWrapTypedArray(Entries, "org.zeroturnaround.zip.ZipEntrySource")))
End Sub

'Copies an existing ZIP file and adds/replaces the given entries in it.
'Entries is an object array containing either FileSource or ByteSource or both.
Public Sub AddOrReplaceEntries2(DirName As String, FileName As String, Entries() As Object, DestZipDir As String, DestZipName As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim DestZip As JavaObject
	DestZip.InitializeNewInstance("java.io.File",Array(DestZipDir,DestZipName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("addOrReplaceEntries",Array As Object(Zip,  UnWrapTypedArray(Entries, "org.zeroturnaround.zip.ZipEntrySource"), DestZip))
End Sub

'Compares two ZIP files and returns true if they contain same entries.
Public Sub ArchiveEquals(DirName As String, FileName As String, DirName2 As String, FileName2 As String) As Boolean
	'Code for File Object Creation
	Dim F1 As JavaObject
	F1.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim F2 As JavaObject
	F2.InitializeNewInstance("java.io.File",Array(DirName2,FileName2))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("archiveEquals",Array As Object(F1, F2))
End Sub

'Checks if the ZIP file contains any of the given entries.
Public Sub ContainsAnyEntry(DirName As String, FileName As String, Names() As String) As Boolean
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("containsAnyEntry",Array As Object(Zip, Names))
End Sub
'Checks if the ZIP file contains the given entry.
Public Sub ContainsEntry(DirName As String, FileName As String, Name As String) As Boolean
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("containsEntry",Array As Object(Zip, Name))
End Sub

'Unpacks a ZIP file to its own location.
Public Sub Explode(DirName As String, FileName As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("explode",Array As Object(Zip))
End Sub

'Compresses the given directory and all its sub-directories into a ZIP file.
Public Sub Pack(DirName As String, ZipDir As String, ZipName As String)
	
	'Code for File Object Creation
	Dim RootDir As JavaObject
	RootDir.InitializeNewInstance("java.io.File",Array(DirName))
	
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(ZipDir,ZipName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("pack",Array As Object(RootDir, Zip))
End Sub

'Compresses the given directory and all its sub-directories into a ZIP file.
Public Sub Pack2(DirName As String, ZipDir As String, ZipName As String, PreserveRoot As Boolean)
	
	'Code for File Object Creation
	Dim RootDir As JavaObject
	RootDir.InitializeNewInstance("java.io.File",Array(DirName))
	
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(ZipDir,ZipName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("pack",Array As Object(RootDir, Zip, PreserveRoot))
End Sub


'Compresses the given entries into a new ZIP file.
'Entries is an object array containing either FileSource or ByteSource or both.
Public Sub Pack3(Entries() As Object, DirName As String, FileName As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("pack",Array As Object(UnWrapTypedArray(Entries,"org.zeroturnaround.zip.ZipEntrySource"), Zip))
End Sub

'Changes an existing ZIP file: removes entries with given paths.
Public Sub RemoveEntries(ZipDir As String, ZipName As String, Paths() As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(ZipName,ZipName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("removeEntries",Array As Object(Zip, Paths))
End Sub

'Copies an existing ZIP file and removes entries with given paths.
Public Sub RemoveEntries2(SourceDir As String, SourceName As String, Paths() As String, DestDir As String, DestName As String)
	'Code for File Object Creation
	Dim Source As JavaObject
	Source.InitializeNewInstance("java.io.File",Array(SourceDir,SourceName))
	
	Dim Dest As JavaObject
	Dest.InitializeNewInstance("java.io.File",Array(DestDir,DestName))


	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("removeEntries",Array As Object(Source, Paths, Dest))
End Sub

'Changes an existing ZIP file: removes entry with a given path.
Public Sub RemoveEntry(ZipDir As String, ZipName As String, Path As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(ZipName,ZipName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("removeEntry",Array As Object(Zip, Path))
End Sub
'Copies an existing ZIP file and removes entry with a given path.
Public Sub RemoveEntry2(SourceDir As String, SourceName As String, Path As String, DestDir As String, DestName As String)
	'Code for File Object Creation
	Dim Source As JavaObject
	Source.InitializeNewInstance("java.io.File",Array(SourceDir,SourceName))
	
	Dim Dest As JavaObject
	Dest.InitializeNewInstance("java.io.File",Array(DestDir,DestName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("removeEntry",Array As Object(Source, Path, Dest))
End Sub

'Repacks a provided ZIP file into a new ZIP with a given compression level.
Public Sub Repack(SourceDir As String, SourceName As String, DestDir As String, DestName As String, CompressionLevel As Int)
	'Code for File Object Creation
	Dim Source As JavaObject
	Source.InitializeNewInstance("java.io.File",Array(SourceDir,SourceName))
	
	Dim Dest As JavaObject
	Dest.InitializeNewInstance("java.io.File",Array(DestDir,DestName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("repack",Array As Object(Source, Dest, CompressionLevel))
End Sub
'Repacks a provided ZIP file and replaces old file with the new one.
Public Sub Repack2(DirName As String, FileName As String, CompressionLevel As Int)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("repack",Array As Object(Zip, CompressionLevel))
End Sub


'Changes an existing ZIP file: replaces a given entry in it.
'Entries is an object array containing either FileSource or ByteSource or both.
Public Sub ReplaceEntries(DirName As String, FileName As String, Entries() As Object) As Boolean
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("replaceEntries",Array As Object(Zip,  UnWrapTypedArray(Entries, "org.zeroturnaround.zip.ZipEntrySource")))
End Sub
'Copies an existing ZIP file and replaces the given entries in it.
'Entries is an object array containing either FileSource or ByteSource or both.
Public Sub ReplaceEntries2(SourceDir As String, SourceName As String, Entries() As Object,  DestDir As String, DestName As String) As Boolean
	'Code for File Object Creation
	Dim Source As JavaObject
	Source.InitializeNewInstance("java.io.File",Array(SourceDir,SourceName))
	
	Dim Dest As JavaObject
	Dest.InitializeNewInstance("java.io.File",Array(DestDir,DestName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("replaceEntries",Array As Object(Source,  UnWrapTypedArray(Entries, "org.zeroturnaround.zip.ZipEntrySource"), Dest))
End Sub
'Changes an existing ZIP file: replaces a given entry in it.
Public Sub ReplaceEntry(DirName As String, FileName As String, Path As String, Bytes() As Byte) As Boolean
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("replaceEntry",Array As Object(Zip, Path, Bytes))
End Sub

'Compresses a given directory in its own location.
Public Sub Unexplode(DirName As String, FileName As String)
	'Code for File Object Creation
	Dim Dir As JavaObject
	Dir.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("unexplode",Array As Object(Dir))
End Sub
'Compresses a given directory in its own location.
Public Sub Unexplode2(DirName As String, FileName As String, CompressionLevel As Int)
	'Code for File Object Creation
	Dim Dir As JavaObject
	Dir.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("unexplode",Array As Object(Dir, CompressionLevel))
End Sub

'Unpacks a ZIP file to the given directory.
Public Sub Unpack(DirName As String, FileName As String, OutputDir As String)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))
	
	Dim Dir As JavaObject
	Dir.InitializeNewInstance("java.io.File",Array(OutputDir))
	
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("unpack",Array As Object(Zip, Dir))
End Sub
'Unpacks a ZIP file to the given directory using a specific Charset for the input file.
Public Sub Unpack2(DirName As String, FileName As String, OutputDir As String, Charset As JavaObject)
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim Dir As JavaObject
	Dir.InitializeNewInstance("java.io.File",Array(OutputDir))

	Dim ChrSet As JavaObject
	ChrSet.InitializeStatic("java.nio.charset.Charset")

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	TJO1.RunMethod("unpack",Array As Object(Zip, Dir, ChrSet.RunMethod("forName",Array(Charset))))
End Sub

'Unpacks a single entry from a ZIP file.
Public Sub UnpackEntry(DirName As String, FileName As String, Name As String) As Byte()
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("unpackEntry",Array As Object(Zip, Name))
End Sub
'Unpacks a single entry from a ZIP file.
Public Sub UnpackEntry2(DirName As String, FileName As String, Name As String, Charset As JavaObject) As Byte()
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))
	
	Dim ChrSet As JavaObject
	ChrSet.InitializeStatic("java.nio.charset.Charset")

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("unpackEntry",Array As Object(Zip, Name, ChrSet.RunMethod("forName",Array(Charset))))
End Sub
'Unpacks a single file from a ZIP archive to a file.
Public Sub UnpackEntry3(DirName As String, FileName As String, Name As String, DestDir As String, DestName As String) As Boolean
	'Code for File Object Creation
	Dim Zip As JavaObject
	Zip.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim Dest As JavaObject
	Dest.InitializeNewInstance("java.io.File",Array(DestName,DestName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.ZipUtil")
	Return TJO1.RunMethod("unpackEntry",Array As Object(Zip, Name, Dest))
End Sub

#Region Utils

'UnWrap a Wrapped array . 
'Arr is an array of wrapped objects
Private Sub UnWrapTypedArray(Arr() As Object,UnWrapType As String) As Object
	Dim P1 As JavaObject
'	Dim ObjArr() As Object = Arr
	Dim ResultArr(Arr.Length) As Object
	For i = 0 To Arr.Length - 1
		ResultArr(i) = GetWrappedObject(Arr(i))
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

#End Region Utils