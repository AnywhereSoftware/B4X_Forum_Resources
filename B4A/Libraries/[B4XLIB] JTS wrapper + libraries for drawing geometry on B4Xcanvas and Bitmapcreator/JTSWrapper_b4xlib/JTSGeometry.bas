Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
    Private mJavaGeom As JavaObject
End Sub

'Wraps an existing JTS Java geometry object.
'raw: the Java geometry object to wrap.
'For internal use. Call JTSManager methods to obtain instances.
Public Sub Initialize(raw As JavaObject)
    mJavaGeom = raw
End Sub

'Returns the underlying JTS Java geometry object.
Public Sub GetJavaGeom As JavaObject
    Return mJavaGeom
End Sub

'Returns the geometry type as a string: "Point", "LineString", "LinearRing", "Polygon",
'"GeometryCollection", "MultiPoint", "MultiLineString" or "MultiPolygon".
Public Sub GetGeometryType As String
    Return mJavaGeom.RunMethod("getGeometryType", Null)
End Sub

'Casts this geometry to a JTSPolygon.
'Only call when GetGeometryType returns "Polygon".
Public Sub AsPolygon As JTSPolygon
    Dim poly As JTSPolygon
    poly.Initialize(mJavaGeom)
    Return poly
End Sub

'Casts this geometry to a JTSLineString.
'Only call when GetGeometryType returns "LineString".
Public Sub AsLineString As JTSLineString
    Dim ls As JTSLineString
    ls.Initialize(mJavaGeom)
    Return ls
End Sub

'Casts this geometry to a JTSPoint.
'Only call when GetGeometryType returns "Point".
Public Sub AsPoint As JTSPoint
    Dim pt As JTSPoint
    pt.Initialize(mJavaGeom)
    Return pt
End Sub

'Returns the Spatial Reference ID (e.g. 4326 for WGS84). Returns 0 if not set.
Public Sub GetSRID As Int
    Return mJavaGeom.RunMethod("getSRID", Null)
End Sub

'Sets the Spatial Reference ID.
'srid: e.g. 4326 for WGS84, 25833 for UTM zone 33N.
Public Sub SetSRID(srid As Int)
    mJavaGeom.RunMethod("setSRID", Array(srid))
End Sub

'Returns the total number of coordinate points in the geometry.
Public Sub GetNumPoints As Int
    Return mJavaGeom.RunMethod("getNumPoints", Null)
End Sub

'Returns the number of sub-geometries. Always 1 for simple types; >1 for collections.
Public Sub GetNumGeometries As Int
    Return mJavaGeom.RunMethod("getNumGeometries", Null)
End Sub

'Returns sub-geometry at index n (0-based). Useful for iterating geometry collections.
'n: zero-based index of the sub-geometry to retrieve.
'   For a simple geometry (Point, LineString, Polygon), only n=0 is valid and returns the geometry itself.
'   Index out of bounds: JTS returns a valid geometry rather than throwing an exception.
Public Sub GetGeometryN(n As Int) As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getGeometryN", Array(n))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns True if the geometry contains no coordinates.
Public Sub IsEmpty As Boolean
    Return mJavaGeom.RunMethod("isEmpty", Null)
End Sub

'Returns True if the geometry has no self-intersections.
Public Sub IsSimple As Boolean
    Return mJavaGeom.RunMethod("isSimple", Null)
End Sub

'Returns True if the geometry is topologically valid.
Public Sub IsValid As Boolean
    Return mJavaGeom.RunMethod("isValid", Null)
End Sub

'Returns the dimension: 0=point, 1=line, 2=area, -1=empty.
Public Sub GetDimension As Int
    Return mJavaGeom.RunMethod("getDimension", Null)
End Sub

'Returns the area of the geometry. Meaningful only for polygons; returns 0 for points and lines.
Public Sub GetArea As Double
    Return mJavaGeom.RunMethod("getArea", Null)
End Sub

'Returns the length or perimeter of the geometry. For polygons this is the perimeter.
Public Sub GetLength As Double
    Return mJavaGeom.RunMethod("getLength", Null)
End Sub

'Returns the shortest Euclidean distance between this geometry and other.
Public Sub Distance(other As JTSGeometry) As Double
    Return mJavaGeom.RunMethod("distance", Array(other.GetJavaGeom))
End Sub

'Returns True if the distance to other is <= dist.
Public Sub IsWithinDistance(other As JTSGeometry, dist As Double) As Boolean
    Return mJavaGeom.RunMethod("isWithinDistance", Array(other.GetJavaGeom, dist))
End Sub

'Returns True if this geometry shares at least one point with other.
Public Sub Intersects(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("intersects", Array(other.GetJavaGeom))
End Sub

'Returns True if other lies entirely within the interior of this geometry.
Public Sub Contains(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("contains", Array(other.GetJavaGeom))
End Sub

'Returns True if this geometry lies entirely within other.
Public Sub Within(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("within", Array(other.GetJavaGeom))
End Sub

'Returns True if the geometries share some but not all interior points and have the same dimension.
Public Sub Overlaps(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("overlaps", Array(other.GetJavaGeom))
End Sub

'Returns True if the geometries share boundary points only, with no shared interior points.
Public Sub Touches(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("touches", Array(other.GetJavaGeom))
End Sub

'Returns True if the geometries have some interior points in common with lower-dimension intersection.
Public Sub Crosses(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("crosses", Array(other.GetJavaGeom))
End Sub

'Returns True if the geometries share no points at all.
Public Sub Disjoint(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("disjoint", Array(other.GetJavaGeom))
End Sub

'Returns True if the geometries are topologically equal, ignoring coordinate order.
Public Sub EqualsTopologically(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("equals", Array(other.GetJavaGeom))
End Sub

'Returns True if the geometries are identical within the given coordinate tolerance.
Public Sub EqualsExact(other As JTSGeometry, tolerance As Double) As Boolean
    Return mJavaGeom.RunMethod("equalsExact", Array(other.GetJavaGeom, tolerance))
End Sub

'Returns True if every point of other lies within this geometry (including boundary).
Public Sub Covers(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("covers", Array(other.GetJavaGeom))
End Sub

'Returns True if every point of this geometry lies within other.
Public Sub CoveredBy(other As JTSGeometry) As Boolean
    Return mJavaGeom.RunMethod("coveredBy", Array(other.GetJavaGeom))
End Sub

'Tests the DE-9IM intersection matrix against a pattern string.
'pattern: 9-character pattern, e.g. "T*****FF*" for Contains.
Public Sub Relate(other As JTSGeometry, pattern As String) As Boolean
    Return mJavaGeom.RunMethod("relate", Array(other.GetJavaGeom, pattern))
End Sub

'Returns the full DE-9IM intersection matrix as a 9-character string.
Public Sub GetIntersectionMatrix(other As JTSGeometry) As String
    Dim im As JavaObject
    im = mJavaGeom.RunMethod("relate", Array(other.GetJavaGeom))
    Return im.RunMethod("toString", Null)
End Sub

'Returns a new geometry expanded by bufDist on all sides. Negative values shrink the geometry.
'bufDist: buffer distance in the coordinate system units.
Public Sub Buffer(bufDist As Double) As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("buffer", Array(bufDist))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns a buffered geometry with controlled smoothness.
'bufDist: buffer distance in the coordinate system units.
'quadrantSegments: number of line segments per quarter circle (higher = rounder, default 8).
Public Sub BufferWithSegments(bufDist As Double, quadrantSegments As Int) As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("buffer", Array(bufDist, quadrantSegments))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns the smallest convex polygon that encloses all points of this geometry.
Public Sub ConvexHull As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("convexHull", Null)
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns the bounding box of this geometry as a JTSEnvelope object.
Public Sub GetEnvelopeInternal As JTSEnvelope
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getEnvelopeInternal", Null)
    Dim e As JTSEnvelope
    e.Initialize(raw)
    Return e
End Sub

'Returns the bounding box of this geometry as a rectangular polygon geometry.
Public Sub GetEnvelope As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getEnvelope", Null)
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns a geometry representing the shared area/points between this geometry and other.
Public Sub Intersection(other As JTSGeometry) As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("intersection", Array(other.GetJavaGeom))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns a geometry representing the combined area of this geometry and other.
Public Sub Union(other As JTSGeometry) As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("union", Array(other.GetJavaGeom))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Merges all sub-geometries within a collection into a single geometry.
'Use on MultiPolygon, MultiLineString or GeometryCollection.
Public Sub UnionAll As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("union", Null)
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns the part of this geometry that does not overlap with other.
Public Sub Difference(other As JTSGeometry) As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("difference", Array(other.GetJavaGeom))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns the parts of each geometry that do not overlap the other (XOR).
Public Sub SymDifference(other As JTSGeometry) As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("symDifference", Array(other.GetJavaGeom))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns the geometric centroid (centre of mass) of the geometry as a JTSPoint.
Public Sub GetCentroid As JTSPoint
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getCentroid", Null)
    Dim pt As JTSPoint
    pt.Initialize(raw)
    Return pt
End Sub

'Returns a point guaranteed to lie inside the geometry.
'Unlike GetCentroid, this point is always inside concave shapes.
Public Sub GetInteriorPoint As JTSPoint
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getInteriorPoint", Null)
    Dim pt As JTSPoint
    pt.Initialize(raw)
    Return pt
End Sub

'Normalizes the geometry to a canonical coordinate order.
'Useful for reliable equality comparisons.
Public Sub Normalize
    mJavaGeom.RunMethod("normalize", Null)
End Sub

'Returns a new geometry with coordinates in reversed order.
Public Sub Reverse As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("reverse", Null)
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Simplifies the geometry using the Douglas-Peucker algorithm. May not preserve topology.
'distanceTolerance: maximum allowed deviation from the original geometry.
Public Sub SimplifyDP(distanceTolerance As Double) As JTSGeometry
    Dim simplifier As JavaObject
    simplifier.InitializeStatic("org.locationtech.jts.simplify.DouglasPeuckerSimplifier")
    Dim raw As JavaObject
    raw = simplifier.RunMethod("simplify", Array(mJavaGeom, distanceTolerance))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Simplifies the geometry while preserving topology (no new self-intersections introduced).
'distanceTolerance: maximum allowed deviation from the original geometry.
Public Sub SimplifyTP(distanceTolerance As Double) As JTSGeometry
    Dim simplifier As JavaObject
    simplifier.InitializeStatic("org.locationtech.jts.simplify.TopologyPreservingSimplifier")
    Dim raw As JavaObject
    raw = simplifier.RunMethod("simplify", Array(mJavaGeom, distanceTolerance))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns the reason why the geometry is invalid, or an empty string if valid.
'Always call IsValid first; use this for diagnostic messages.
Public Sub GetValidationError As String
    Dim args(1) As Object
    args(0) = mJavaGeom
    Dim validator As JavaObject
    validator.InitializeNewInstance("org.locationtech.jts.operation.valid.IsValidOp", args)
    If validator.RunMethod("isValid", Null) Then
        Return ""
    End If
    Dim err As JavaObject
    err = validator.RunMethod("getValidationError", Null)
    Return err.RunMethod("toString", Null)
End Sub

'Attempts to repair an invalid geometry using a buffer(0) operation.
'Returns the repaired geometry. Use when IsValid returns False.
Public Sub MakeValid As JTSGeometry
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("buffer", Array(0.0))
    Dim g As JTSGeometry
    g.Initialize(raw)
    Return g
End Sub

'Returns all coordinate points as a List of JTSCoordinate objects.
Public Sub GetCoordinates As List
    Dim result As List
    result.Initialize
    Dim rawCoords() As Object
    rawCoords = mJavaGeom.RunMethod("getCoordinates", Null)
    Dim i As Int
    For i = 0 To rawCoords.Length - 1
        Dim c As JTSCoordinate
        c.Initialize(rawCoords(i))
        result.Add(c)
    Next
    Return result
End Sub

'Returns the first coordinate of the geometry as a JTSCoordinate.
Public Sub GetCoordinate As JTSCoordinate
    Dim raw As JavaObject
    raw = mJavaGeom.RunMethod("getCoordinate", Null)
    Dim c As JTSCoordinate
    c.Initialize(raw)
    Return c
End Sub

'Compares this geometry to other. Returns -1, 0 or 1.
Public Sub CompareTo(other As JTSGeometry) As Int
    Return mJavaGeom.RunMethod("compareTo", Array(other.GetJavaGeom))
End Sub

'Returns a hash code for this geometry.
'Geometries that are topologically equal have the same hash code.
Public Sub HashCode As Int
    Return mJavaGeom.RunMethod("hashCode", Null)
End Sub

'Returns the WKT representation of this geometry, e.g. "POLYGON ((10 59, 11 59, ...))".
Public Sub ToString As String
    Return mJavaGeom.RunMethod("toText", Null)
End Sub
