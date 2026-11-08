Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
    Private mJavaGeom As JavaObject
End Sub

'Wraps an existing JTS Java point object.
'raw: the Java point object to wrap.
'For internal use. Call JTSManager methods to obtain instances.
Public Sub Initialize(raw As JavaObject)
    mJavaGeom = raw
End Sub

'Returns the underlying JTS Java geometry object.
Public Sub GetJavaGeom As JavaObject
    Return mJavaGeom
End Sub

'Returns the X coordinate (longitude or easting) of this point.
Public Sub GetX As Double
    Return mJavaGeom.RunMethod("getX", Null)
End Sub

'Returns the Y coordinate (latitude or northing) of this point.
Public Sub GetY As Double
    Return mJavaGeom.RunMethod("getY", Null)
End Sub

'Returns the Z coordinate (height or depth). Returns NaN if this is a 2D point.
Public Sub GetZ As Double
    Dim coord As JavaObject
    coord = mJavaGeom.RunMethod("getCoordinate", Null)
    Return coord.GetField("z")
End Sub

'Converts this point to a JTSGeometry to access all spatial predicates and operations.
Public Sub AsGeometry As JTSGeometry
    Dim g As JTSGeometry
    g.Initialize(mJavaGeom)
    Return g
End Sub
