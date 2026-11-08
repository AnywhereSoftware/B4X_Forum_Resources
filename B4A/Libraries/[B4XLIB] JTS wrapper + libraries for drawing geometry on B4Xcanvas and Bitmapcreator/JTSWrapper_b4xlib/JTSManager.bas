Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
	Private mFactory As JavaObject
	Private mPM As String
End Sub

'Initializes JTSManager with a PrecisionModel and a Spatial Reference ID (SRID).
'
'The pm parameter determines how coordinates are rounded in all geometry operations:
'
'   "FLOATING"        - Full IEEE 754 double precision. Coordinates are not rounded.
'                       This is the default precision model in JTS and suits most use cases.
'
'   "FLOATING_SINGLE" - Limited to single (float) precision. Uses less memory,
'                       but provides lower accuracy than FLOATING.
'
'   number, e.g. 1000 - FIXED precision. Coordinates are rounded to a grid:
'                            roundedValue = round(inputValue * scale) / scale
'                         Scale examples:
'                            scale =  1000 -> 3 decimal places  (nearest 0.001)
'                            scale =   100 -> 2 decimal places  (nearest 0.01)
'                            scale =     1 -> integer precision (nearest 1)
'                            scale = -1000 -> rounds to nearest 1000 (more robust than scale=0.001)
'                         Use FIXED when you need reproducible, deterministic results,
'                         e.g. for topological operations or storage in a GIS system
'                         with a fixed coordinate precision.
'
'srid: Spatial Reference ID, e.g. 4326 for WGS84 or 25833 for EUREF89 UTM zone 33.
'      Use 0 if the SRID is undefined or not relevant.
Public Sub Initialize(pm As String,srid As Int)
	mPM = pm
	Dim pmjo As JavaObject
	If pm = "FLOATING" Then
		pmjo.InitializeNewInstance("org.locationtech.jts.geom.PrecisionModel", Null)
	Else if pm = "FLOATING_SINGLE" Then
		' Must use the static Type constant from PrecisionModel so that JTS's internal
		' identity checks (modelType == FLOATING_SINGLE) work. Constructing a new Type
		' with name "FLOATING_SINGLE" would create a different object and isFloating()
		' would return False.
		Dim pmClass As JavaObject
		pmClass.InitializeStatic("org.locationtech.jts.geom.PrecisionModel")
		Dim typeConst As JavaObject = pmClass.GetField("FLOATING_SINGLE")
		pmjo.InitializeNewInstance("org.locationtech.jts.geom.PrecisionModel", Array(typeConst))
	Else
		pmjo.InitializeNewInstance("org.locationtech.jts.geom.PrecisionModel", Array(pm.As(Double)))
	End If
	mFactory.InitializeNewInstance("org.locationtech.jts.geom.GeometryFactory", Array(pmjo, srid))
'	Log(mFactory.RunMethodJO("getPrecisionModel",Null).RunMethodJO("getType",Null).RunMethod("toString",Null))
End Sub

'Returns the SRID (Spatial Reference ID) of the GeometryFactory.
'Returns 0 if no SRID was set.
Public Sub GetSRID As Int
	Return mFactory.RunMethod("getSRID", Null)
End Sub

'Returns the precision model string that this manager was initialized with.
'The returned value can be passed directly to Initialize on a new JTSManager
'to recreate a manager with the same precision behavior. See Initialize for
'the accepted values ("FLOATING", "FLOATING_SINGLE", or a numeric scale).
Public Sub GetPrecisionModel As String
	Return mPM
End Sub

'Returns True if this manager uses full floating-point precision
'(either "FLOATING" or "FLOATING_SINGLE").
Public Sub IsFloating As Boolean
	Return mFactory.RunMethodJO("getPrecisionModel", Null).RunMethod("isFloating", Null)
End Sub

'Returns the scale factor of a fixed precision model. Returns 0 for floating precision.
Public Sub GetScale As Double
	Return mFactory.RunMethodJO("getPrecisionModel", Null).RunMethod("getScale", Null)
End Sub

'Rounds a coordinate value to the precision defined by this manager's PrecisionModel.
'val: the coordinate value to round.
Public Sub MakePrecise(val As Double) As Double
	Return mFactory.RunMethodJO("getPrecisionModel", Null).RunMethod("makePrecise", Array(val))
End Sub

'Rounds the coordinate's X and Y values in-place to the precision defined by this
'manager's PrecisionModel. The Z value is not modified. The coordinate is mutated;
'there is no return value.
'coordinate: the JTSCoordinate to round.
Public Sub MakePrecise2(coordinate As JTSCoordinate)
	mFactory.RunMethodJO("getPrecisionModel", Null).RunMethod("makePrecise", Array(coordinate.GetJavaCoord))
End Sub

'Returns the maximum number of significant decimal digits supported by this
'manager's PrecisionModel.
Public Sub GetMaximumSignificantDigits As Int
	Return mFactory.RunMethodJO("getPrecisionModel", Null).RunMethod("getMaximumSignificantDigits", Null)
End Sub

'Creates a 2D point geometry.
'x: longitude or easting.
'y: latitude or northing.
Public Sub CreatePoint(x As Double, y As Double) As JTSPoint
	Dim c As JTSCoordinate
	c.Initialize(CreateCoordinateNative(x, y))
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createPoint", Array(c.GetJavaCoord))
	Dim pt As JTSPoint
	pt.Initialize(raw)
	Return pt
End Sub

'Creates a 3D point geometry.
'x: longitude or easting.
'y: latitude or northing.
'z: height or depth.
Public Sub CreatePoint3D(x As Double, y As Double, z As Double) As JTSPoint
	Dim c As JTSCoordinate
	c.Initialize(CreateCoordinateNative3D(x, y, z))
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createPoint", Array(c.GetJavaCoord))
	Dim pt As JTSPoint
	pt.Initialize(raw)
	Return pt
End Sub

'Creates a polyline from a list of coordinates.
'coords: List of JTSCoordinate objects defining the vertices.
'        Empty list: returns a valid empty LineString (no exception).
'        One point: throws IllegalArgumentException.
'        Two or more points: returns a valid LineString.
Public Sub CreateLineString(coords As List) As JTSLineString
	Dim javaCoords As JavaObject = CoordsListToArray(coords)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createLineString", Array(javaCoords))
	Dim ls As JTSLineString
	ls.Initialize(raw)
	Return ls
End Sub

'Creates a closed linear ring and returns it as a JTSLineString.
'Use the returned value with CreatePolygon2 or CreatePolygonWithHoles2,
'or access ring coordinates and points via JTSLineString methods.
'coords: List of JTSCoordinate objects; last must equal first.
'        Not closed (first != last): throws IllegalArgumentException.
'        Fewer than 3 unique points (e.g. 2 unique + closing): returns invalid ring (IsValid = False).
'        4 or more coordinates with valid closure: returns a valid LinearRing.
Public Sub CreateLinearRing(coords As List) As JTSLineString
	Dim javaCoords As JavaObject = CoordsListToArray(coords)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createLinearRing", Array(javaCoords))
	Dim ls As JTSLineString
	ls.Initialize(raw)
	Return ls
End Sub

'Creates a closed linear ring and returns it as a JTSLineString.
'Use the returned value with CreatePolygon2 or CreatePolygonWithHoles2,
'or access ring coordinates and points via JTSLineString methods.
'coords: Array of org.locationtech.jts.geom.Coordinate (use CreateCoordinateNative or CreateCoordinateNative3D); last must equal first.
'        Not closed (first != last): throws IllegalArgumentException.
'        Fewer than 3 unique points (e.g. 2 unique + closing): returns invalid ring (IsValid = False).
'        4 or more coordinates with valid closure: returns a valid LinearRing.
Public Sub CreateLinearRing2(coords() As Object) As JTSLineString
	Dim arr As JavaObject
	arr.InitializeArray("org.locationtech.jts.geom.Coordinate", coords)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createLinearRing", Array(arr))
	Dim ls As JTSLineString
	ls.Initialize(raw)
	Return ls
End Sub

'Creates a polygon without holes.
'shellCoords: List of JTSCoordinate forming the outer ring; last must equal first.
'        Not closed (first != last): throws IllegalArgumentException.
'        Fewer than 3 unique points: polygon is created but IsValid = False.
'        Self-intersecting ring: polygon is created but IsValid = False.
Public Sub CreatePolygon(shellCoords As List) As JTSPolygon
	Dim javaCoords As JavaObject = CoordsListToArray(shellCoords)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createPolygon", Array(javaCoords))
	Dim poly As JTSPolygon
	poly.Initialize(raw)
	Return poly
End Sub

'Creates a polygon without holes from a LinearRing.
'linearRing: a value returned by CreateLinearRing or CreateLinearRing2.
Public Sub CreatePolygon2(linearRing As JTSLineString) As JTSPolygon
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createPolygon", Array(linearRing.GetJavaGeom))
	Dim poly As JTSPolygon
	poly.Initialize(raw)
	Return poly
End Sub

'Creates a polygon without holes.
'shellCoords: Array of org.locationtech.jts.geom.Coordinate (use CreateCoordinateNative or CreateCoordinateNative3D) forming the outer ring; last must equal first.
'        Not closed (first != last): throws IllegalArgumentException.
'        Fewer than 3 unique points: polygon is created but IsValid = False.
'        Self-intersecting ring: polygon is created but IsValid = False.
Public Sub CreatePolygon3(shellCoords() As Object) As JTSPolygon
	Dim raw As JavaObject
	raw.InitializeArray("org.locationtech.jts.geom.Coordinate", shellCoords)
	raw = mFactory.RunMethod("createPolygon", Array(raw))
	Dim poly As JTSPolygon
	poly.Initialize(raw)
	Return poly
End Sub

'Creates a polygon with one or more holes.
'shellCoords: List of JTSCoordinate for the outer ring; last must equal first.
'holeCoordsList: List of Lists; each inner List is a JTSCoordinate ring defining one hole.
'        Shell or any hole ring:
'			not closed: throws IllegalArgumentException.
'        	Fewer than 3 unique points: polygon is created but IsValid = False.
'        	Self-intersecting ring: polygon is created but IsValid = False.
'        Hole outside shell: polygon is created but IsValid = False.
'        Hole overlapping another hole: polygon is created but IsValid = False.
Public Sub CreatePolygonWithHoles(shellCoords As List, holeCoordsList As List) As JTSPolygon
	Dim javaCoords As JavaObject = CoordsListToArray(shellCoords)
	Dim ring As JavaObject
	ring = mFactory.RunMethod("createLinearRing", Array(javaCoords))
	Dim holesArr(holeCoordsList.Size) As Object
	Dim i As Int
	For i = 0 To holeCoordsList.Size - 1
		Dim hCoords As List = holeCoordsList.Get(i)
		Dim hJavaCoords As JavaObject = CoordsListToArray(hCoords)
		holesArr(i) = mFactory.RunMethod("createLinearRing", Array(hJavaCoords))
	Next
	Dim holes As JavaObject
	holes.InitializeArray("org.locationtech.jts.geom.LinearRing", holesArr)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createPolygon", Array(ring, holes))
	Dim poly As JTSPolygon
	poly.Initialize(raw)
	Return poly
End Sub

'Creates a polygon with one or more holes from LinearRing values.
'shell: a value returned by CreateLinearRing or CreateLinearRing2.
'holes: List of JTSLineString, each returned by CreateLinearRing or CreateLinearRing2.
Public Sub CreatePolygonWithHoles2(shell As JTSLineString, holes As List) As JTSPolygon
	Dim holesArr(holes.Size) As Object
	For i = 0 To holes.Size - 1
		holesArr(i) = holes.Get(i).As(JTSLineString).GetJavaGeom
	Next
	Dim holesJava As JavaObject
	holesJava.InitializeArray("org.locationtech.jts.geom.LinearRing", holesArr)

	Dim raw As JavaObject
	raw = mFactory.RunMethod("createPolygon", Array(shell.GetJavaGeom, holesJava))

	Dim poly As JTSPolygon
	poly.Initialize(raw)
	Return poly
End Sub

'Creates a polygon with one or more holes.
'shellCoords: Array of org.locationtech.jts.geom.Coordinate (use CreateCoordinateNative or CreateCoordinateNative3D) forming the outer ring; last must equal first.
'holesCoords: Array of arrays of org.locationtech.jts.geom.Coordinate; each inner array defines one hole ring.
'        Shell or any hole ring:
'			not closed: throws IllegalArgumentException.
'        	Fewer than 3 unique points: polygon is created but IsValid = False.
'        	Self-intersecting ring: polygon is created but IsValid = False.
'        Hole outside shell: polygon is created but IsValid = False.
'        Hole overlapping another hole: polygon is created but IsValid = False.
Public Sub CreatePolygonWithHoles3(shellCoords() As Object, holesCoords() As Object) As JTSPolygon
	' Outer ring directly from Coordinate array
	Dim shellArr As JavaObject
	shellArr.InitializeArray("org.locationtech.jts.geom.Coordinate", shellCoords)
	Dim ring As JavaObject
	ring = mFactory.RunMethod("createLinearRing", Array(shellArr))

	' Holes: same pattern per hole
	Dim holesArr(holesCoords.Length) As Object
	Dim i As Int
	For i = 0 To holesCoords.Length - 1
		Dim hArr() As Object = holesCoords(i)
		Dim hJava As JavaObject
		hJava.InitializeArray("org.locationtech.jts.geom.Coordinate", hArr)
		holesArr(i) = mFactory.RunMethod("createLinearRing", Array(hJava))
	Next

	Dim holes As JavaObject
	holes.InitializeArray("org.locationtech.jts.geom.LinearRing", holesArr)

	Dim raw As JavaObject
	raw = mFactory.RunMethod("createPolygon", Array(ring, holes))

	Dim poly As JTSPolygon
	poly.Initialize(raw)
	Return poly
End Sub

'Creates a heterogeneous collection of geometries.
'geomList: List of JTSGeometry objects of any type.
Public Sub CreateGeometryCollection(geomList As List) As JTSGeometry
	Dim arrObj(geomList.Size) As Object
	Dim i As Int
	For i = 0 To geomList.Size - 1
		Dim g As JTSGeometry = geomList.Get(i)
		arrObj(i) = g.GetJavaGeom
	Next
	Dim arr As JavaObject
	arr.InitializeArray("org.locationtech.jts.geom.Geometry", arrObj)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createGeometryCollection", Array(arr))
	Dim col As JTSGeometry
	col.Initialize(raw)
	Return col
End Sub

'Creates a MultiPoint collection.
'pointList: List of JTSPoint objects.
Public Sub CreateMultiPoint(pointList As List) As JTSGeometry
	Dim arrObj(pointList.Size) As Object
	Dim i As Int
	For i = 0 To pointList.Size - 1
		Dim pt As JTSPoint = pointList.Get(i)
		arrObj(i) = pt.GetJavaGeom
	Next
	Dim arr As JavaObject
	arr.InitializeArray("org.locationtech.jts.geom.Point", arrObj)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createMultiPoint", Array(arr))
	Dim col As JTSGeometry
	col.Initialize(raw)
	Return col
End Sub

'Creates a MultiLineString collection.
'lineList: List of JTSLineString objects.
Public Sub CreateMultiLineString(lineList As List) As JTSGeometry
	Dim arrObj(lineList.Size) As Object
	Dim i As Int
	For i = 0 To lineList.Size - 1
		Dim ls As JTSLineString = lineList.Get(i)
		arrObj(i) = ls.GetJavaGeom
	Next
	Dim arr As JavaObject
	arr.InitializeArray("org.locationtech.jts.geom.LineString", arrObj)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createMultiLineString", Array(arr))
	Dim col As JTSGeometry
	col.Initialize(raw)
	Return col
End Sub

'Creates a MultiPolygon collection.
'polyList: List of JTSPolygon objects.
Public Sub CreateMultiPolygon(polyList As List) As JTSGeometry
	Dim arrObj(polyList.Size) As Object
	Dim i As Int
	For i = 0 To polyList.Size - 1
		Dim poly As JTSPolygon = polyList.Get(i)
		arrObj(i) = poly.GetJavaGeom
	Next
	Dim arr As JavaObject
	arr.InitializeArray("org.locationtech.jts.geom.Polygon", arrObj)
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createMultiPolygon", Array(arr))
	Dim col As JTSGeometry
	col.Initialize(raw)
	Return col
End Sub

'Creates an empty geometry with dimension -1. Useful as a null-safe placeholder.
Public Sub CreateEmpty As JTSGeometry
	Dim raw As JavaObject
	raw = mFactory.RunMethod("createEmpty", Array(-1))
	Dim geom As JTSGeometry
	geom.Initialize(raw)
	Return geom
End Sub

'Creates a 2D JTSCoordinate.
'x: longitude or easting.
'y: latitude or northing.
Public Sub CreateCoordinate(x As Double, y As Double) As JTSCoordinate
	Dim c As JTSCoordinate
	c.Initialize(CreateCoordinateNative(x, y))
	Return c
End Sub

'Creates a 3D JTSCoordinate.
'x: longitude or easting.
'y: latitude or northing.
'z: height or depth.
Public Sub CreateCoordinate3D(x As Double, y As Double, z As Double) As JTSCoordinate
	Dim c As JTSCoordinate
	c.Initialize(CreateCoordinateNative3D(x, y, z))
	Return c
End Sub

'Creates a 2D org.locationtech.jts.geom.Coordinate, usefull for making array of native JTS coordinates.
'x: longitude or easting. y: latitude or northing.
'
'Example usage:
'	Dim coords(4) As Object
'	coords(0) = CreateCoordinateNative(1,1)
'	coords(1) = CreateCoordinateNative(1,2)
'	coords(2) = CreateCoordinateNative(2,2)
'	coords(3) = CreateCoordinateNative(1,1)
'   Dim polygon as JTSPolygon = CreatePolygon3(shellCoords() As Object)
Public Sub CreateCoordinateNative(x As Double, y As Double) As JavaObject
	Dim args(2) As Object
	args(0) = x
	args(1) = y
	Dim raw As JavaObject
	raw.InitializeNewInstance("org.locationtech.jts.geom.Coordinate", args)
	Return raw
End Sub

'Creates a 3D org.locationtech.jts.geom.Coordinate, usefull for making array of native JTS coordinates.
'x: longitude or easting.
'y: latitude or northing.
'z: height or depth.
Public Sub CreateCoordinateNative3D(x As Double, y As Double, z As Double) As JavaObject
	Dim args(3) As Object
	args(0) = x
	args(1) = y
	args(2) = z
	Dim raw As JavaObject
	raw.InitializeNewInstance("org.locationtech.jts.geom.Coordinate", args)
	Return raw
End Sub



'Creates a bounding box directly from coordinate extents.
'minX: western boundary. maxX: eastern boundary.
'minY: southern boundary. maxY: northern boundary.
Public Sub CreateEnvelope(minX As Double, maxX As Double, minY As Double, maxY As Double) As JTSEnvelope
	Dim args(4) As Object
	args(0) = minX
	args(1) = maxX
	args(2) = minY
	args(3) = maxY
	Dim raw As JavaObject
	raw.InitializeNewInstance("org.locationtech.jts.geom.Envelope", args)
	Dim e As JTSEnvelope
	e.Initialize(raw)
	Return e
End Sub

'Parses a geometry from a WKT string.
'wktString: e.g. "POINT(10.5 59.9)" or "POLYGON((10 59, 11 59, 11 60, 10 60, 10 59))".
Public Sub FromWKT(wktString As String) As JTSGeometry
	Dim reader As JavaObject
	reader.InitializeNewInstance("org.locationtech.jts.io.WKTReader", Null)
	Dim raw As JavaObject
	raw = reader.RunMethod("read", Array(wktString))
	Dim geom As JTSGeometry
	geom.Initialize(raw)
	Return geom
End Sub

'Converts a geometry to its WKT string representation.
'geom: the geometry to serialize.
Public Sub ToWKT(geom As JTSGeometry) As String
	Dim writer As JavaObject
	writer.InitializeNewInstance("org.locationtech.jts.io.WKTWriter", Null)
	Return writer.RunMethod("write", Array(geom.GetJavaGeom))
End Sub

'Converts a geometry to WKT with a fixed number of decimal places.
'geom: the geometry to serialize.
'decimals: number of decimal places in the output coordinates.
Public Sub ToWKTPrecision(geom As JTSGeometry, decimals As Int) As String
	Dim args(1) As Object
	args(0) = decimals
	Dim writer As JavaObject
	writer.InitializeNewInstance("org.locationtech.jts.io.WKTWriter", args)
	Return writer.RunMethod("write", Array(geom.GetJavaGeom))
End Sub

'Parses a geometry from a WKB byte array.
'wkbBytes: raw binary WKB data, e.g. read from a database BLOB.
Public Sub FromWKB(wkbBytes() As Byte) As JTSGeometry
	Dim reader As JavaObject
	reader.InitializeNewInstance("org.locationtech.jts.io.WKBReader", Null)
	Dim raw As JavaObject
	raw = reader.RunMethod("read", Array(wkbBytes))
	Dim geom As JTSGeometry
	geom.Initialize(raw)
	Return geom
End Sub

'Converts a geometry to a WKB byte array.
'geom: the geometry to serialize.
Public Sub ToWKB(geom As JTSGeometry) As Byte()
	Dim writer As JavaObject
	writer.InitializeNewInstance("org.locationtech.jts.io.WKBWriter", Null)
	Return writer.RunMethod("write", Array(geom.GetJavaGeom))
End Sub

'Converts a geometry to a WKB hex string. Useful for storing in SQL databases.
'geom: the geometry to serialize.
Public Sub ToWKBHex(geom As JTSGeometry) As String
	Dim writer As JavaObject
	writer.InitializeNewInstance("org.locationtech.jts.io.WKBWriter", Null)
	Dim bytes() As Byte = writer.RunMethod("write", Array(geom.GetJavaGeom))
	Return writer.RunMethod("toHex", Array(bytes))
End Sub

'Parses a geometry from a WKB hex string.
'hexString: hex-encoded WKB, e.g. as stored in a spatial database column.
Public Sub FromWKBHex(hexString As String) As JTSGeometry
	Dim reader As JavaObject
	reader.InitializeNewInstance("org.locationtech.jts.io.WKBReader", Null)
	Dim bytes() As Byte = reader.RunMethod("hexToBytes", Array(hexString))
	Dim raw As JavaObject
	raw = reader.RunMethod("read", Array(bytes))
	Dim geom As JTSGeometry
	geom.Initialize(raw)
	Return geom
End Sub

'Internal helper: converts a List of JTSCoordinate to a typed Java Coordinate array.
'coords: List of JTSCoordinate objects (2D or 3D).
Private Sub CoordsListToArray(coords As List) As JavaObject
	Dim arrCoords(coords.Size) As Object
	Dim i As Int
	For i = 0 To coords.Size - 1
		Dim c As JTSCoordinate = coords.Get(i)
		arrCoords(i) = c.GetJavaCoord
	Next
	Dim arr As JavaObject
	arr.InitializeArray("org.locationtech.jts.geom.Coordinate", arrCoords)
	Return arr
End Sub

