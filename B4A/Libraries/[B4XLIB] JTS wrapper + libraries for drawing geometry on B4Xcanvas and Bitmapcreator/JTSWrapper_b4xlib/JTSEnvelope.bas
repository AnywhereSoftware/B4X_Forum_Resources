Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
    Private mJavaEnv As JavaObject
End Sub

'Wraps an existing Java Envelope object. Use JTSManager.CreateEnvelope to create envelopes.
'raw: the Java Envelope to wrap.
Public Sub Initialize(raw As JavaObject)
    mJavaEnv = raw
End Sub

'Internal: returns the underlying Java Envelope object. Used by JTSSTRtree.
Public Sub GetJavaEnv As JavaObject
    Return mJavaEnv
End Sub

'Returns the minimum X value (western boundary) of this envelope.
Public Sub GetMinX As Double
    Return mJavaEnv.RunMethod("getMinX", Null)
End Sub

'Returns the maximum X value (eastern boundary) of this envelope.
Public Sub GetMaxX As Double
    Return mJavaEnv.RunMethod("getMaxX", Null)
End Sub

'Returns the minimum Y value (southern boundary) of this envelope.
Public Sub GetMinY As Double
    Return mJavaEnv.RunMethod("getMinY", Null)
End Sub

'Returns the maximum Y value (northern boundary) of this envelope.
Public Sub GetMaxY As Double
    Return mJavaEnv.RunMethod("getMaxY", Null)
End Sub

'Returns the width of this envelope (maxX - minX).
Public Sub GetWidth As Double
    Return mJavaEnv.RunMethod("getWidth", Null)
End Sub

'Returns the height of this envelope (maxY - minY).
Public Sub GetHeight As Double
    Return mJavaEnv.RunMethod("getHeight", Null)
End Sub

'Returns the area of this envelope (width * height).
Public Sub GetArea As Double
    Return mJavaEnv.RunMethod("getArea", Null)
End Sub

'Returns the X coordinate of the centre of this envelope.
Public Sub GetMidX As Double
    Dim centre As JavaObject
    centre = mJavaEnv.RunMethod("centre", Null)
    Return centre.GetField("x")
End Sub

'Returns the Y coordinate of the centre of this envelope.
Public Sub GetMidY As Double
    Dim centre As JavaObject
    centre = mJavaEnv.RunMethod("centre", Null)
    Return centre.GetField("y")
End Sub

'Returns True if this envelope is empty (no area has been set).
Public Sub IsNull As Boolean
    Return mJavaEnv.RunMethod("isNull", Null)
End Sub

'Expands this envelope to include the given point if it lies outside.
'x: X coordinate of the point.
'y: Y coordinate of the point.
Public Sub ExpandToIncludePoint(x As Double, y As Double)
    mJavaEnv.RunMethod("expandToInclude", Array(x, y))
End Sub

'Expands this envelope to include another envelope entirely.
'other: the envelope to include.
Public Sub ExpandToIncludeEnvelope(other As JTSEnvelope)
    mJavaEnv.RunMethod("expandToInclude", Array(other.GetJavaEnv))
End Sub

'Expands this envelope by delta on all four sides.
'delta: amount to expand in each direction.
Public Sub ExpandBy(delta As Double)
    mJavaEnv.RunMethod("expandBy", Array(delta))
End Sub

'Returns True if this envelope overlaps with other. Used for fast spatial pre-filtering.
'other: the envelope to test against.
Public Sub Intersects(other As JTSEnvelope) As Boolean
    Return mJavaEnv.RunMethod("intersects", Array(other.GetJavaEnv))
End Sub

'Returns True if the given point lies inside or on the boundary of this envelope.
'x: X coordinate. y: Y coordinate.
Public Sub ContainsPoint(x As Double, y As Double) As Boolean
    Return mJavaEnv.RunMethod("contains", Array(x, y))
End Sub

'Returns True if this envelope completely contains other.
'other: the envelope to test.
Public Sub ContainsEnvelope(other As JTSEnvelope) As Boolean
    Return mJavaEnv.RunMethod("contains", Array(other.GetJavaEnv))
End Sub

'Returns True if the given point lies within or on the boundary of this envelope.
'x: X coordinate. y: Y coordinate.
Public Sub CoversPoint(x As Double, y As Double) As Boolean
    Return mJavaEnv.RunMethod("covers", Array(x, y))
End Sub

'Returns the length of the diagonal of this envelope.
Public Sub GetDiameter As Double
    Return mJavaEnv.RunMethod("getDiameter", Null)
End Sub

'Returns a string representation, e.g. "Env[10.0 : 11.0, 59.0 : 60.0]".
Public Sub ToString As String
    Return mJavaEnv.RunMethod("toString", Null)
End Sub
