B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	
	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(TImage As Image, Widths As BorderWidths, Insets As BorderImageInsets, Slices As BorderWidths, Filled As Boolean, RepeatX As String, RepeatY As String)
	TJO.InitializeNewInstance("javafx.scene.layout.BorderImage",Array As Object(TImage, Widths.GetObject, Insets.GetObject, Slices.GetObject, Filled, RepeatX, RepeatY))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'The image to be used.
Public Sub GetImage As Image
	Return TJO.RunMethod("getImage",Null)
End Sub
'The insets of the BorderImage define where the border should be positioned relative to the edge of the Region.
Public Sub GetInsets As BorderImageInsets
	Return TJO.RunMethod("getInsets",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Indicates in what manner (if at all) the border image is to be repeated along the x-axis of the region.
Public Sub GetRepeatX As String
	Return TJO.RunMethod("getRepeatX",Null)
End Sub
'Indicates in what manner (if at all) the border image is to be repeated along the y-axis of the region.
Public Sub GetRepeatY As String
	Return TJO.RunMethod("getRepeatY",Null)
End Sub
'Defines the slices of the image.
Public Sub GetSlices As BorderWidths
	Dim Wrapper As BorderWidths
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getSlices",Null))
	Return Wrapper
End Sub
'The widths of the border on each side.
Public Sub GetWidths As BorderWidths
	Dim Wrapper As BorderWidths
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getWidths",Null))
	Return Wrapper
End Sub
'Returns a hash code value for the object.
Public Sub HashCode As Int
	Return TJO.RunMethod("hashCode",Null)
End Sub
'Specifies whether or not the center patch (as defined by the left, right, top, and bottom slices) should be drawn.
Public Sub IsFilled As Boolean
	Return TJO.RunMethod("isFilled",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

