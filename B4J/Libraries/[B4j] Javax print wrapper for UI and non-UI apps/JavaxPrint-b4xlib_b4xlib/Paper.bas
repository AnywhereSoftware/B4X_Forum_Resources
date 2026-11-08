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

'Creates a letter sized piece of paper with one inch margins.
Public Sub Initialize
	
	Tjo.InitializeNewInstance("java.awt.print.Paper",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Creates a copy of this Paper with the same contents as this Paper.
Public Sub Clone As Object
	Return Tjo.RunMethod("clone",Null)
End Sub
'Returns the height of the page in 1/72nds of an inch.
Public Sub GetHeight As Double
	Return Tjo.RunMethod("getHeight",Null)
End Sub
'Returns the height of this Paper object's imageable area. in 1/72nds of an inch.
Public Sub GetImageableHeight As Double
	Return Tjo.RunMethod("getImageableHeight",Null)
End Sub
'Returns the width of this Paper object's imageable area in 1/72nds of an inch..
Public Sub GetImageableWidth As Double
	Return Tjo.RunMethod("getImageableWidth",Null)
End Sub
'Returns the x coordinate of the upper-left corner of this Paper object's imageable area in 1/72nds of an inch..
Public Sub GetImageableX As Double
	Return Tjo.RunMethod("getImageableX",Null)
End Sub
'Returns the y coordinate of the upper-left corner of this Paper object's imageable area in 1/72nds of an inch..
Public Sub GetImageableY As Double
	Return Tjo.RunMethod("getImageableY",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns the width of the page in 1/72nds of an inch.
Public Sub GetWidth As Double
	Return Tjo.RunMethod("getWidth",Null)
End Sub
'Sets the imageable area of this Paper in in 1/72nds of an inch..
Public Sub SetImageableArea(X As Double, Y As Double, Width As Double, Height As Double)
	Tjo.RunMethod("setImageableArea",Array As Object(X, Y, Width, Height))
End Sub
'Sets the width and height of this Paper object, which represents the properties of the page onto which printing occurs.
Public Sub SetSize(Width As Double, Height As Double)
	Tjo.RunMethod("setSize",Array As Object(Width, Height))
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub
