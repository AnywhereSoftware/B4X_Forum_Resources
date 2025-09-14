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
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name
End Sub

'It builds the bean.
Public Sub Create(Width As Int, Height As Int)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("ws.schild.jave.info.VideoSize",Array As Object(Width, Height))
End Sub

'*
Public Sub AsEncoderArgument As String
	Return Tjo.RunMethod("asEncoderArgument",Null)
End Sub
'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'*
Public Sub AspectRatioExpression As String
	Return Tjo.RunMethod("aspectRatioExpression",Null)
End Sub
'*
Public Sub Equals(O As Object) As Boolean
	Return Tjo.RunMethod("equals",Array As Object(O))
End Sub
'Returns the video height.
Public Sub GetHeight As JavaObject
	Return Tjo.RunMethod("getHeight",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns the video width.
Public Sub GetWidth As JavaObject
	Return Tjo.RunMethod("getWidth",Null)
End Sub
'*
Public Sub HashCode As Int
	Return Tjo.RunMethod("hashCode",Null)
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


