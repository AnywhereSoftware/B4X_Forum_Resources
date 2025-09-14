B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals

End Sub

Public Sub Arc(CenterX As Double, CenterY As Double, RadiusX As Double, RadiusY As Double, StartAngle As Double, Length As Double) As GLArc
	Dim Wrapper As GLArc
	Wrapper.Initialize
	Wrapper.Create2(CenterX, CenterY, RadiusX, RadiusY, StartAngle, Length)
	Return Wrapper
End Sub

Public Sub Circle(CenterX As Double, CenterY As Double, Radius As Double) As GLCircle
	Dim Wrapper As GLCircle
	Wrapper.Initialize
	Wrapper.Create3(CenterX, CenterY, Radius)
	Return Wrapper
End Sub

Public Sub CubicCurve(StartX As Double, StartY As Double, ControlX1 As Double, ControlY1 As Double, ControlX2 As Double, ControlY2 As Double, EndX As Double, EndY As Double) As GLCubicCurve
	Dim Wrapper As GLCubicCurve
	Wrapper.Initialize
	Wrapper.Create2(StartX, StartY, ControlX1, ControlY1, ControlX2, ControlY2, EndX, EndY)
	Return Wrapper
End Sub

Public Sub Ellipse(RadiusX As Double, RadiusY As Double) As GLEllipse
	Dim Wrapper As GLEllipse
	Wrapper.Initialize
	Wrapper.Create2(RadiusX,RadiusY)
	Return Wrapper
End Sub

Public Sub Line(StartX As Double, StartY As Double, EndX As Double, EndY As Double) As GLLine
	Dim Wrapper As GLLine
	Wrapper.Initialize
	Wrapper.Create2(StartX, StartY, EndX, EndY)
	Return Wrapper
End Sub

Public Sub LinearGradient(StartX As Double, StartY As Double, EndX As Double, EndY As Double, Proportional As Boolean, CycleMethod As String, Stops As List) As GLLinearGradient
	Dim Wrapper As GLLinearGradient
	Wrapper.Initialize
	Wrapper.Create(StartX, StartY, EndX, EndY, Proportional, CycleMethod, Stops)
	Return Wrapper
End Sub

Public Sub Path(Elements As List) As GLPath
	Dim Wrapper As GLPath
	Wrapper.Initialize
	Wrapper.Create2(Elements)
	Return Wrapper
End Sub

Public Sub Polygon(Points() As Double) As GLPolygon
	Dim Wrapper As GLPolygon
	Wrapper.Initialize
	Wrapper.Create2(Points)
	Return Wrapper
End Sub

Public Sub QuadCurve(StartX As Double, StartY As Double, ControlX As Double, ControlY As Double, EndX As Double, EndY As Double) As GLQuadCurve
	Dim Wrapper As GLQuadCurve
	Wrapper.Initialize
	Wrapper.Create2(StartX, StartY, ControlX, ControlY, EndX, EndY)
	Return Wrapper
End Sub

Public Sub RadialGradient(FocusAngle As Double, FocusDistance As Double, CenterX As Double, CenterY As Double, Radius As Double, Proportional As Boolean, CycleMethod As String, Stops As List) As GLRadialGradient
	Dim Wrapper As GLRadialGradient
	Wrapper.Initialize
	Wrapper.Create(FocusAngle, FocusDistance, CenterX, CenterY, Radius, Proportional, CycleMethod, Stops)
	Return Wrapper
End Sub

Public Sub Rectangle(X As Double, Y As Double, Width As Double, Height As Double) As GLRectangle
	Dim Wrapper As GLRectangle
	Wrapper.Initialize
	Wrapper.Create3(X, Y, Width, Height)
	Return Wrapper
End Sub
Public Sub Stop(Offset As Double, Color As Paint) As GLStop
	Dim Wrapper As GLStop
	Wrapper.Initialize
	Wrapper.Create(Offset, Color)
	Return Wrapper
End Sub

Public Sub SVGPath As GLSVGPath
	Dim Wrapper As GLSVGPath
	Wrapper.Initialize
	Return Wrapper
End Sub

Public Sub Text(X As Double, Y As Double, tText As String) As GLText
	Dim Wrapper As GLText
	Wrapper.Initialize
	Wrapper.Create2(X ,Y , tText)
	Return Wrapper
End Sub

Public Sub ArcTo As GLArcTo
	Dim Wrapper As GLArcTo
	Wrapper.Initialize
	Wrapper.Create
	Return Wrapper
End Sub

Public Sub CubicCurveTo As GLCubicCurveTo
	Dim Wrapper As GLCubicCurveTo
	Wrapper.Initialize
	Wrapper.Create
	Return Wrapper
End Sub

Public Sub HLineTo(X As Double) As GLHLineTo
	Dim Wrapper As GLHLineTo
	Wrapper.Initialize
	Wrapper.Create2(X)
	Return Wrapper
End Sub

Public Sub LineTo(X As Double, Y As Double) As GLLineTo
	Dim Wrapper As GLLineTo
	Wrapper.Initialize
	Wrapper.Create2(X,Y)
	Return Wrapper
End Sub

Public Sub MoveTo(X As Double, Y As Double) As GLMoveTo
	Dim Wrapper As GLMoveTo
	Wrapper.Initialize
	Wrapper.Create2(X,Y)
	Return Wrapper
End Sub

Public Sub QuadCurveTo(ControlX As Double, ControlY As Double, X As Double, Y As Double) As GLQuadCurveTo
	Dim Wrapper As GLQuadCurveTo
	Wrapper.Initialize
	Wrapper.Create2(ControlX, ControlY, X, Y)
	Return Wrapper
End Sub

Public Sub VLineTo(Y As Double) As GLVLineTo
	Dim Wrapper As GLVLineTo
	Wrapper.Initialize
	Wrapper.Create2(Y)
	Return Wrapper
End Sub