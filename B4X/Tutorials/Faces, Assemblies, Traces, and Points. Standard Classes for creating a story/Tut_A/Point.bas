B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Public X, Y As Float
End Sub

Public Sub Initialize
End Sub

'Use the Point type to create a new Point object (X, Y)
Public Sub New(X_ As Float, Y_ As Float) As Point
	Dim P As Point: P.Initialize
	P.X = X_: P.Y = Y_
	Return P
End Sub

'Returns a point that is partway (fraction) along the line between two points
Public Sub partwayTo(p As Point, fraction As Float) As Point
	Return New(X + fraction * (p.X - X), Y + fraction * (p.Y - Y))
End Sub

'Copies a Point
Public Sub Copy As Point
	Return New(X, Y)
End Sub

'Subtract second Point from first
Public Sub Minus(p As Point) As Point
	Return New(X - p.X, Y - p.Y)
End Sub

'Multiplies a Point by a constant
Public Sub MultBy(factor As Float) As Point
	Return New(factor * X, factor * Y)
End Sub

'Adds two Points
Public Sub Add(p As Point) As Point
	Return New(X + p.X, Y + p.Y)
End Sub

'Finds distance between two Points
Public Sub distanceTo(p As Point) As Float
	Dim dx As Float = p.X - X
	Dim dy As Float = p.Y - Y
	Return Sqrt(dx * dx + dy * dy)
End Sub

'Finds the mid-Point between two Points
Public Sub halfwayTo(p As Point) As Point
	Return New((X + p.X) / 2, (Y + p.Y) / 2)
End Sub

Public Sub EQ(p As Point) As Boolean
	Return (X = p.X) And (Y = p.Y)
End Sub