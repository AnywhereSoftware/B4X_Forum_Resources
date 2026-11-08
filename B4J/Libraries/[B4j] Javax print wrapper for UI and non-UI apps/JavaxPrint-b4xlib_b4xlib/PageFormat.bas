B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	

	Private Tjo As JavaObject
End Sub

'Creates a default, portrait-oriented PageFormat.
Public Sub Initialize
	
	'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name
	Tjo.InitializeNewInstance("java.awt.print.PageFormat",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Makes a copy of this PageFormat with the same contents as this PageFormat.
Public Sub Clone As Object
	Return Tjo.RunMethod("clone",Null)
End Sub
'Returns the height, in 1/72nds of an inch, of the page.
Public Sub GetHeight As Double
	Return Tjo.RunMethod("getHeight",Null)
End Sub
'Return the height, in 1/72nds of an inch, of the imageable area of the page.
Public Sub GetImageableHeight As Double
	Return Tjo.RunMethod("getImageableHeight",Null)
End Sub
'Returns the width, in 1/72nds of an inch, of the imageable area of the page.
Public Sub GetImageableWidth As Double
	Return Tjo.RunMethod("getImageableWidth",Null)
End Sub
'Returns the x coordinate of the upper left point of the imageable area of the Paper object associated with this PageFormat.
Public Sub GetImageableX As Double
	Return Tjo.RunMethod("getImageableX",Null)
End Sub
'Returns the y coordinate of the upper left point of the imageable area of the Paper object associated with this PageFormat.
Public Sub GetImageableY As Double
	Return Tjo.RunMethod("getImageableY",Null)
End Sub
'Returns a transformation matrix that translates user space rendering to the requested orientation of the page.
Public Sub GetMatrix As Double()
	Return Tjo.RunMethod("getMatrix",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns the orientation of this PageFormat.
Public Sub GetOrientation As Int
	Return Tjo.RunMethod("getOrientation",Null)
End Sub
'Returns a copy of the Paper object associated with this PageFormat.
Public Sub GetPaper As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("getPaper",Null))
	Return Wrapper
End Sub
'Returns the width, in 1/72nds of an inch, of the page.
Public Sub GetWidth As Double
	Return Tjo.RunMethod("getWidth",Null)
End Sub
'Sets the page orientation.
Public Sub SetOrientation(Orientation As Int)
	Tjo.RunMethod("setOrientation",Array As Object(Orientation))
End Sub
'Sets the Paper object for this PageFormat.
Public Sub SetPaper(tPaper As Paper)
	Tjo.RunMethod("setPaper",Array As Object(tPaper.GetObject))
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

