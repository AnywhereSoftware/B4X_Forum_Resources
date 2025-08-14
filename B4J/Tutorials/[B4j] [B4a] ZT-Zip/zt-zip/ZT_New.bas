B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.78
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Create a new byte source
'Path = location of the new file in the zip file.
Public Sub NewByteSource(Path As String, Bytes() As Byte) As ByteSource
	Dim BS As ByteSource
	BS.Initialize
	BS.Create(Path, Bytes)
	Return BS
End Sub

'Create a new file source
'Path = location of the new file in the zip file.
Public Sub NewFileSource(Path As String, Dirname As String, FileName As String) As FileSource
	Dim FS As FileSource
	FS.Initialize
	FS.Create(Path, Dirname, FileName)
	Return FS
End Sub

'Create an empty Zips object to which you can add files
Public Sub NewZips As Zips
	Dim Zip As Zips
	Zip.Initialize
	Zip.Create
	Return Zip
End Sub

'Create a Zips object from an existing zip file.
Public Sub NewZipsExisting(FileDir As String, FileName As String) As Zips
	Dim Zip As Zips
	Zip.Initialize
	Zip.Get(FileDir,FileName)
	Return Zip
End Sub