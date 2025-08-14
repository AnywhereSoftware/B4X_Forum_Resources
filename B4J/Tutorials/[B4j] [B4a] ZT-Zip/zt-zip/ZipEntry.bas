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
	'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name
	
End Sub

'Creates a new zip entry with the specified name.
Public Sub Create(Name As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("java.util.zip.ZipEntry",Array As Object(Name))
End Sub

'Creates a new zip entry with fields taken from the specified zip entry.
Public Sub Create2(E As ZipEntry)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("java.util.zip.ZipEntry",Array As Object(E.GetObject))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Returns a copy of this entry.
Public Sub Clone As Object
	Return TJO.RunMethod("clone",Null)
End Sub
'Returns the comment string for the entry, or null if none.
Public Sub GetComment As String
	Return TJO.RunMethod("getComment",Null)
End Sub
'Returns the size of the compressed entry data, or -1 if not known.
Public Sub GetCompressedSize As Long
	Return TJO.RunMethod("getCompressedSize",Null)
End Sub
'Returns the CRC-32 checksum of the uncompressed entry data, or -1 if not known.
Public Sub GetCrc As Long
	Return TJO.RunMethod("getCrc",Null)
End Sub
'Returns the extra field data for the entry, or null if none.
Public Sub GetExtra As Byte()
	Return TJO.RunMethod("getExtra",Null)
End Sub
'Returns the compression method of the entry, or -1 if not specified.
Public Sub GetMethod As Int
	Return TJO.RunMethod("getMethod",Null)
End Sub
'Returns the name of the entry.
Public Sub GetName As String
	Return TJO.RunMethod("getName",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Returns the uncompressed size of the entry data, or -1 if not known.
Public Sub GetSize As Long
	Return TJO.RunMethod("getSize",Null)
End Sub
'Returns the modification time of the entry, or -1 if not specified.
Public Sub GetTime As Long
	Return TJO.RunMethod("getTime",Null)
End Sub
'Returns the hash code value for this entry.
Public Sub HashCode As Int
	Return TJO.RunMethod("hashCode",Null)
End Sub
'Returns true if this is a directory entry.
Public Sub IsDirectory As Boolean
	Return TJO.RunMethod("isDirectory",Null)
End Sub
'Sets the optional comment string for the entry.
Public Sub SetComment(Comment As String)
	TJO.RunMethod("setComment",Array As Object(Comment))
End Sub
'Sets the size of the compressed entry data.
Public Sub SetCompressedSize(Csize As Long)
	TJO.RunMethod("setCompressedSize",Array As Object(Csize))
End Sub
'Sets the CRC-32 checksum of the uncompressed entry data.
Public Sub SetCrc(Crc As Long)
	TJO.RunMethod("setCrc",Array As Object(Crc))
End Sub
'Sets the optional extra field data for the entry.
Public Sub SetExtra(Extra() As Byte)
	TJO.RunMethod("setExtra",Array As Object(Extra))
End Sub
'Sets the compression method for the entry.
Public Sub SetMethod(Method As Int)
	TJO.RunMethod("setMethod",Array As Object(Method))
End Sub
'Sets the uncompressed size of the entry data.
Public Sub SetSize(Size As Long)
	TJO.RunMethod("setSize",Array As Object(Size))
End Sub
'Sets the modification time of the entry.
Public Sub SetTime(Time As Long)
	TJO.RunMethod("setTime",Array As Object(Time))
End Sub
'Returns a string representation of the ZIP entry.
Public Sub ToString As String
	Return TJO.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

