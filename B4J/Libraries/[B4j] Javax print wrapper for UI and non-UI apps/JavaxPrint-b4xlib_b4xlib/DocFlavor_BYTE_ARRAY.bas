B4J=true
Group=DocFlavor
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	

	Private Tjo As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name

End Sub

'Constructs a new doc flavor with the given MIME type and a print data representation class name of "[B" (byte array).
Public Sub Create(MimeType As String)
	
	Tjo.InitializeNewInstance("javax.print.DocFlavor.BYTE_ARRAY",Array As Object(MimeType))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub

'Determines if this doc flavor object is equal to the given object.
Public Sub Equals(Obj As Object) As Boolean
	Return Tjo.RunMethod("equals",Array As Object(Obj))
End Sub
'Returns this doc flavor object's media subtype (from the MIME type).
Public Sub GetMediaSubtype As String
	Return Tjo.RunMethod("getMediaSubtype",Null)
End Sub
'Returns this doc flavor object's media type (from the MIME type).
Public Sub GetMediaType As String
	Return Tjo.RunMethod("getMediaType",Null)
End Sub
'Returns this doc flavor object's MIME type string based on the canonical form.
Public Sub GetMimeType As String
	Return Tjo.RunMethod("getMimeType",Null)
End Sub
'Returns a String representing a MIME parameter.
Public Sub GetParameter(ParamName As String) As String
	Return Tjo.RunMethod("getParameter",Array As Object(ParamName))
End Sub
'Returns the name of this doc flavor object's representation class.
Public Sub GetRepresentationClassName As String
	Return Tjo.RunMethod("getRepresentationClassName",Null)
End Sub
'Returns a hash code for this doc flavor object.
Public Sub HashCode As Int
	Return Tjo.RunMethod("hashCode",Null)
End Sub
'Converts this DocFlavor to a string.
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

