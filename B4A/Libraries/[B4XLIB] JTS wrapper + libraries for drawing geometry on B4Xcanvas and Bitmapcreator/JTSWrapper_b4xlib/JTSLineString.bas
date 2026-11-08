Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
    Private mJavaGeom As JavaObject
End Sub

'Wraps an existing JTS Java line string object.
'raw: the Java line string object to wrap.
'For internal use. Call JTSManager methods to obtain instances.
Public Sub Initialize(raw As JavaObject)
    mJavaGeom = raw
End Sub

'Returns the underlying JTS Java geometry object.
Public Sub GetJavaGeom As JavaObject
    Return mJavaGeom
End Sub

'Returns the first point of the line string.
Public Sub GetStartPoint As JTSPoint
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getStartPoint", Null)
    Dim pt As JTSPoint
    pt.Initialize(raw)
    Return pt
End Sub

'Returns the last point of the line string.
Public Sub GetEndPoint As JTSPoint
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getEndPoint", Null)
    Dim pt As JTSPoint
    pt.Initialize(raw)
    Return pt
End Sub

'Returns the vertex at index n (0-based).
'n: zero-based index of the vertex to retrieve.
Public Sub GetPointN(n As Int) As JTSPoint
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getPointN", Array(n))
    Dim pt As JTSPoint
    pt.Initialize(raw)
    Return pt
End Sub

'Returns True if the start point and end point are identical (forms a closed ring).
Public Sub IsClosed As Boolean
    Return mJavaGeom.RunMethod("isClosed", Null)
End Sub

'Returns True if the line is both closed and simple (no self-intersections).
Public Sub IsRing As Boolean
    Return mJavaGeom.RunMethod("isRing", Null)
End Sub

'Converts this line string to a JTSGeometry to access all spatial predicates and operations.
Public Sub AsGeometry As JTSGeometry
    Dim g As JTSGeometry
    g.Initialize(mJavaGeom)
    Return g
End Sub
