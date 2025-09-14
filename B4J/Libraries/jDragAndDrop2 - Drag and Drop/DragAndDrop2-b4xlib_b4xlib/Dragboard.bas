B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class Module
Sub Class_Globals
  'Private fx As JFX ' Uncomment if required. For B4j only
  Private TJO As JavaObject

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'Gets the image used as a drag view.
Public Sub SetDragView(Img As Image,XOffset As Double,YOffset As Double) As Image
  Return TJO.RunMethod("setDragView",Array(Img,XOffset,YOffset))
End Sub
'Gets the image used as a drag view.
Public Sub GetDragView As Image
  Return TJO.RunMethod("getDragView",Null)
End Sub
'Gets the x position of the cursor of the drag view image.
Public Sub GetDragViewOffsetX As Double
  Return TJO.RunMethod("getDragViewOffsetX",Null)
End Sub
'Gets the y position of the cursor of the drag view image.
Public Sub GetDragViewOffsetY As Double
  Return TJO.RunMethod("getDragViewOffsetY",Null)
End Sub
'Sets the x position of the cursor of the drag view image.
Public Sub SetDragViewOffsetX(OffsetX As Double)
  TJO.RunMethod("setDragViewOffsetX",Array As Object(OffsetX))
End Sub
'Sets the y position of the cursor of the drag view image.
Public Sub SetDragViewOffsetY(OffsetY As Double)
  TJO.RunMethod("setDragViewOffsetY",Array As Object(OffsetY))
End Sub

'Returns the content stored in this clipboard of the given type, or null if there is no content with this type.
Public Sub GetContent(Str As String) As Object
	Dim DataFormat As JavaObject
	DataFormat.InitializeStatic("javafx.scene.input.DataFormat")
	Dim LDF As JavaObject = DataFormat.RunMethod("lookupMimeType",Array(Str))
	If LDF.IsInitialized = False Then LDF.InitializeNewInstance("javafx.scene.input.DataFormat",Array(Array As String(Str)))
	Return TJO.RunMethod("getContent",Array As Object(LDF))
End Sub

'Gets the List of Files from the clipboard which had previously been registered.
Public Sub GetFiles As List
  Return TJO.RunMethod("getFiles",Null)
End Sub
'Gets the HTML text String from the clipboard which had previously been registered.
Public Sub GetHtml As String
  Return TJO.RunMethod("getHtml",Null)
End Sub
'Gets the Image from the clipboard which had previously been registered.
Public Sub GetImage As Image
  Return TJO.RunMethod("getImage",Null)
End Sub
'Gets the RTF text String from the clipboard which had previously been registered.
Public Sub GetRtf As String
  Return TJO.RunMethod("getRtf",Null)
End Sub
'Gets the plain text String from the clipboard which had previously been registered.
Public Sub GetString As String
  Return TJO.RunMethod("getString",Null)
End Sub
'Gets the URL String from the clipboard which had previously been registered.
Public Sub GetUrl As String
  Return TJO.RunMethod("getUrl",Null)
End Sub
'Tests whether there is any content on this clipboard of the given DataFormat type.
Public Sub HasContent(Str As String) As Boolean
	Dim DataFormat As JavaObject
	DataFormat.InitializeStatic("javafx.scene.input.DataFormat")
	Dim LDF As JavaObject = DataFormat.RunMethod("lookupMimeType",Array(Str))
	If LDF.IsInitialized = False Then LDF.InitializeNewInstance("javafx.scene.input.DataFormat",Array(Array As String(Str)))
  	Return TJO.RunMethod("hasContent",Array As Object(LDF))
End Sub
'Gets whether an List of Files (DataFormat.FILES) has been registered on this Clipboard.
Public Sub HasFiles As Boolean
  Return TJO.RunMethod("hasFiles",Null)
End Sub
'Gets whether an HTML text String (DataFormat.HTML) has been registered on this Clipboard.
Public Sub HasHtml As Boolean
  Return TJO.RunMethod("hasHtml",Null)
End Sub
'Gets whether an Image (DataFormat.IMAGE) has been registered on this Clipboard.
Public Sub HasImage As Boolean
  Return TJO.RunMethod("hasImage",Null)
End Sub
'Gets whether an RTF String (DataFormat.RTF) has been registered on this Clipboard.
Public Sub HasRtf As Boolean
  Return TJO.RunMethod("hasRtf",Null)
End Sub
'Gets whether a plain text String (DataFormat.PLAIN_TEXT) has been registered on this Clipboard.
Public Sub HasString As Boolean
  Return TJO.RunMethod("hasString",Null)
End Sub
'Gets whether a url String (DataFormat.URL) has been registered on this Clipboard.
Public Sub HasUrl As Boolean
  Return TJO.RunMethod("hasUrl",Null)
End Sub

Public Sub SetContent(Content As Object)
	TJO.RunMethod("setContent",Array(Content))
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
  Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
  Return TJO
End Sub
'Comment if not needed

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
  TJO = Obj
End Sub
