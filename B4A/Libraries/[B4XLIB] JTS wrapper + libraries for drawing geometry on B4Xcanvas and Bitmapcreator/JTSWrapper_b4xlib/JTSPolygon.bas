Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
    Private mJavaGeom As JavaObject
End Sub

'Wraps an existing JTS Java polygon object.
'raw: the Java polygon object to wrap.
'For internal use. Call JTSManager methods to obtain instances.
Public Sub Initialize(raw As JavaObject)
    mJavaGeom = raw
End Sub

'Returns the underlying JTS Java geometry object.
Public Sub GetJavaGeom As JavaObject
    Return mJavaGeom
End Sub

'Returns the outer boundary ring of this polygon as a JTSLineString.
'The underlying type is LinearRing, which is a closed LineString with no unique extra methods.
Public Sub GetExteriorRing As JTSLineString
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getExteriorRing", Null)
    Dim ls As JTSLineString
    ls.Initialize(raw)
    Return ls
End Sub

'Returns the number of interior holes in this polygon. Returns 0 if no holes exist.
Public Sub GetNumInteriorRing As Int
    Return mJavaGeom.RunMethod("getNumInteriorRing", Null)
End Sub

'Returns the interior hole ring at index n as a JTSLineString.
'The underlying type is LinearRing, which is a closed LineString with no unique extra methods.
'n: zero-based index of the hole to retrieve.
Public Sub GetInteriorRingN(n As Int) As JTSLineString
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getInteriorRingN", Array(n))
    Dim ls As JTSLineString
    ls.Initialize(raw)
    Return ls
End Sub

'Converts this polygon to a JTSGeometry to access all spatial predicates and operations.
Public Sub AsGeometry As JTSGeometry
    Dim g As JTSGeometry
    g.Initialize(mJavaGeom)
    Return g
End Sub
