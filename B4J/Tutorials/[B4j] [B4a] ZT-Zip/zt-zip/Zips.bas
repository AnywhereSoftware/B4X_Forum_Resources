B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.78
@EndOfDesignText@
#IgnoreWarnings:12
#RaisesSynchronousEvents: iterate_event
#Event: Item(ZEntry As ZipEntry)
'Class Module
'A FluentAPI for zip handling
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private TJO As JavaObject
	Private mModule As Object
	Private mEventName As String
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
		
End Sub

'Specifies entries to add or change to the output when this Zips executes.
'Entries is an object array containing either FileSource or ByteSource or both.
Public Sub AddEntries(Entries() As Object) As Zips
	TJO.RunMethod("addEntries",Array As Object( UnWrapTypedArray(Entries, "org.zeroturnaround.zip.ZipEntrySource")))
	Return Me
End Sub
'Specifies an entry to add or change to the output when this Zips executes.
'Entry can be either a FileSource or a ByteSource
Public Sub AddEntry(Entry As Object) As Zips
	TJO.RunMethod("addEntry",Array As Object(CallSub(Entry,"GetObject")))
	Return Me
End Sub
'Adds a file entry.
Public Sub AddFile(DirName As String, FileName As String) As Zips
	'Code for File Object Creation
	Dim TFile As JavaObject
	TFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))
	TJO.RunMethod("addFile",Array As Object(TFile))
	Return Me
End Sub
'Adds a file entry.
Public Sub AddFile2(DirName As String, FileName As String, PreserveRoot As Boolean) As Zips
	'Code for File Object Creation
	Dim TFile As JavaObject
	TFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))
	TJO.RunMethod("addFile",Array As Object(TFile, PreserveRoot))
	Return Me
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Specifies charset for this Zips execution
Public Sub Charset(TCharset As String) As Zips
	Dim ChrSet As JavaObject
	ChrSet.InitializeStatic("java.nio.charset.Charset")
	TJO.RunMethod("charset",Array As Object(ChrSet.RunMethod("forName",Array(TCharset))))
	Return Me
End Sub
'Checks for the existence of the specified path/name
Public Sub ContainsEntry(Name As String) As Boolean
	Return TJO.RunMethod("containsEntry",Array As Object(Name))
End Sub
'Static factory method to obtain an instance of Zips without source file.
Public Sub Create As Zips
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.Zips")
	SetObject(TJO1.RunMethod("create",Null))
	Return Me
End Sub
'Specifies destination file for this Zips execution, if destination is null (default value), then source file will be overwritten.
'Will create a new file if it doesn't exist
Public Sub Destination(DirName As String, FileName As String) As Zips
	'Code for File Object Creation
	Dim TDestination As JavaObject
	TDestination.InitializeNewInstance("java.io.File",Array(DirName,FileName))
	If TDestination.RunMethod("exists",Null) = False Then TDestination.RunMethod("createNewFile",Null)
	TJO.RunMethod("destination",Array As Object(TDestination))
	Return Me
End Sub
'Static factory method to obtain an instance of Zips.
Public Sub Get(DirName As String, FileName As String) As Zips
	'Code for File Object Creation
	Dim Src As JavaObject
	Src.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.zeroturnaround.zip.Zips")
	SetObject(TJO1.RunMethod("get",Array As Object(Src)))
	Return Me
End Sub
'Get an entry by path/name as an array of bytes
Public Sub GetEntry(Name As String) As Byte()
	Return TJO.RunMethod("getEntry",Array As Object(Name))
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub

'Scans the source ZIP file and executes the given callback for each entry.
Public Sub Iterate(Module As Object, EventName As String)
	mModule = Module
	mEventName = EventName
	Dim O As Object = TJO.CreateEvent("org.zeroturnaround.zip.ZipInfoCallback","Iterate",Null)
	If SubExists(Module,EventName & "_Item") Then TJO.RunMethod("iterate",Array As Object(O))
End Sub

Private Sub Iterate_Event (MethodName As String, Args() As Object)
	If MethodName = "process" Then
		Dim ZE As ZipEntry
		ZE.Initialize
		ZE.SetObject(Args(0))
		CallSub2(mModule,mEventName & "_Item",ZE)
	End If
End Sub

'*
Public Sub NameMapper(NameMapper1 As JavaObject) As Zips
	TJO.RunMethod("nameMapper",Array As Object(NameMapper1))
	Return Me
End Sub
'Enables timestamp preserving for this Zips execution
Public Sub PreserveTimestamps As Zips
	TJO.RunMethod("preserveTimestamps",Null)
	Return Me
End Sub
'Iterates through source Zip entries removing or changing them according to set parameters.
Public Sub Process
	TJO.RunMethod("process",Null)
End Sub
'Specifies entries to remove to the output when this Zips executes.
'Entries is String Array of Paths / Names
Public Sub RemoveEntries(Entries() As String) As Zips
	TJO.RunMethod("removeEntries",Array As Object(Entries))
	Return Me
End Sub
'Specifies an entry to remove to the output when this Zips executes.
Public Sub RemoveEntry(Entry As String) As Zips
	TJO.RunMethod("removeEntry",Array As Object(Entry))
	Return Me
End Sub
'Specifies timestamp preserving for this Zips execution
Public Sub SetPreserveTimestamps(Preserve As Boolean) As Zips
	TJO.RunMethod("setPreserveTimestamps",Array As Object(Preserve))
	Return Me
End Sub
'*
Public Sub Unpack As Zips
	TJO.RunMethod("unpack",Null)
	Return Me
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
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