B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Public X, Y As Float
End Sub

Public Sub Initialize(x_ As Float, y_ As Float) As Point
	X = x_
	Y = y_
	Return Me
End Sub

Public Sub new(x_ As Float, y_ As Float) As Point
	Dim t1 As Point
	t1.Initialize(x_, y_)
	Return t1
End Sub

Public Sub subtract(p0 As Point) As Point
	Return new(X - p0.X, Y - p0.y)
End Sub

Public Sub multBy(factor As Float, p As Point) As Point
	Return new(factor * p.X, factor * p.y)
End Sub

Public Sub add(p0 As Point) As Point
	Return new(X + p0.X, Y + p0.y)
End Sub

Public Sub distance(p0 As Point) As Float
	Dim dx As Float = X - p0.X
	Dim dy As Float = Y - p0.Y
	Return Sqrt(dx * dx + dy * dy)
End Sub

Public Sub middle(p0 As Point) As Point
	Return new((X + p0.X) / 2, (Y + p0.Y) / 2)
End Sub

Public Sub copy As Point
	Return new(X, Y)
End Sub