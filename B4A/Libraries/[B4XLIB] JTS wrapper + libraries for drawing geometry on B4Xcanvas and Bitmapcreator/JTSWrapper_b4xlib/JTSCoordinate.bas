Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
	Private mJavaCoord As JavaObject
	Private mIs3D As Boolean
End Sub

'Wraps an existing Java Coordinate object. Use JTSManager.CreateCoordinate to create coordinates.
'raw: the Java Coordinate to wrap.
Public Sub Initialize(raw As JavaObject)
	mJavaCoord = raw
	' Z is NaN in Java for 2D coordinates. NaN is the only number where x <> x is true.
	Dim zVal As Double = mJavaCoord.GetField("z")
	mIs3D = (zVal = zVal)
End Sub

'Internal: returns the underlying Java Coordinate object. Used by JTSManager factory methods.
Public Sub GetJavaCoord As JavaObject
	Return mJavaCoord
End Sub

'Returns True if this coordinate has a valid Z value (3D), False if Z is Null/NaN (2D).
Public Sub GetIs3D As Boolean
	Return mIs3D
End Sub

'Returns the X value (longitude or easting) of this coordinate.
Public Sub GetX As Double
	Return mJavaCoord.GetField("x")
End Sub

'Returns the Y value (latitude or northing) of this coordinate.
Public Sub GetY As Double
	Return mJavaCoord.GetField("y")
End Sub

'Returns the Z value (height or depth). Returns NaN if this is a 2D coordinate.
'Check GetIs3D before using this value.
Public Sub GetZ As Double
	Return mJavaCoord.GetField("z")
End Sub

'Sets the X value of this coordinate.
'val: the new X value.
Public Sub SetX(val As Double)
	mJavaCoord.SetField("x", val)
End Sub

'Sets the Y value of this coordinate.
'val: the new Y value.
Public Sub SetY(val As Double)
	mJavaCoord.SetField("y", val)
End Sub

'Sets the Z value of this coordinate. Also marks this coordinate as 3D.
'val: the new Z value.
Public Sub SetZ(val As Double)
	mJavaCoord.SetField("z", val)
	mIs3D = True
End Sub

'Returns the 2D Euclidean distance to another coordinate (ignores Z).
'other: the coordinate to measure distance to.
Public Sub Distance2D(other As JTSCoordinate) As Double
	Return mJavaCoord.RunMethod("distance", Array(other.GetJavaCoord))
End Sub

'Returns the 3D Euclidean distance to another coordinate (includes Z).
'other: the coordinate to measure distance to.
Public Sub Distance3D(other As JTSCoordinate) As Double
	Return mJavaCoord.RunMethod("distance3D", Array(other.GetJavaCoord))
End Sub

'Returns True if X and Y values are identical (ignores Z).
'other: the coordinate to compare against.
Public Sub Equals2D(other As JTSCoordinate) As Boolean
	Return mJavaCoord.RunMethod("equals2D", Array(other.GetJavaCoord))
End Sub

'Returns True if X and Y are within tolerance of each other.
'other: the coordinate to compare against.
'tolerance: maximum allowed difference in each axis.
Public Sub Equals2DTolerance(other As JTSCoordinate, tolerance As Double) As Boolean
	Return mJavaCoord.RunMethod("equals2D", Array(other.GetJavaCoord, tolerance))
End Sub

'Returns True if X, Y and Z values are all identical.
'other: the coordinate to compare against.
Public Sub Equals3D(other As JTSCoordinate) As Boolean
	Return mJavaCoord.RunMethod("equals3D", Array(other.GetJavaCoord))
End Sub

'Returns this coordinate as a string in the format "(x, y, z)".
Public Sub ToString As String
	Return mJavaCoord.RunMethod("toString", Null)
End Sub
