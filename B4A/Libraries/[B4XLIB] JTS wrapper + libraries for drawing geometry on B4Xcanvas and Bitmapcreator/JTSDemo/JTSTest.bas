Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
	Private mJts As JTSManager
	Private mPass As Int
	Private mFail As Int

	' Shared test geometries (used by Geometry tests)
	Private polyA     As JTSGeometry   ' 10-11 / 59-60
	Private polyB     As JTSGeometry   ' 10.5-11.5 / 59.5-60.5  (overlaps A)
	Private polyC     As JTSGeometry   ' 12-13 / 59-60           (separate from A)
	Private polyD     As JTSGeometry   ' 10.2-10.8 / 59.2-59.8  (inside A)
	Private pointInA  As JTSGeometry   ' 10.5 / 59.5             (inside A)
	Private pointOutA As JTSGeometry   ' 11.5 / 59.5             (outside A)
	Private lineThruA As JTSGeometry   ' crosses the boundary of A
	Private lineInA   As JTSGeometry   ' entirely inside A
End Sub

'Unit test suite for the JTSWrapper library.
'
'Call Initialize with a shared JTSManager, then RunAll to execute all
'test suites. Results are written to the Log. pass and fail counts are
'accumulated across suites and printed as a final summary.
'
'Accepts the same JTSManager instance used by B4XMainPage.
Public Sub Initialize(jts As JTSManager)
	mJts = jts
	mPass = 0
	mFail = 0
End Sub

'Returns the number of tests that passed (valid after RunAll).
Public Sub GetPassedCount As Int
	Return mPass
End Sub

'Returns the number of tests that failed (valid after RunAll).
Public Sub GetFailedCount As Int
	Return mFail
End Sub

'Runs all test suites and writes a combined summary to the log.
Public Sub RunAll
	mPass = 0
	mFail = 0

	RunManagerTests
	RunCoordinateTests
	RunEnvelopeTests
	RunGeometryTests
	RunTypesTests
	RunSTRtreeTests
	RunAffineTransformationTests
	RunNegativeTests

	Log("")
	Log("========================================")
	Log(" TOTAL  PASS: " & mPass & "   FAIL: " & mFail)
	Log("========================================")
End Sub


'##########################################################################
'# JTSManager
'##########################################################################

Private Sub RunManagerTests
	Log("")
	Log("========================================")
	Log(" JTSManager Test Suite")
	Log("========================================")

	Dim passBefore As Int = mPass
	Dim failBefore As Int = mFail

	Test_Mgr_CreatePoint
	Test_Mgr_CreatePoint3D
	Test_Mgr_CreateLineString
	Test_Mgr_CreateLinearRing
	Test_Mgr_CreateLinearRing2
	Test_Mgr_CreatePolygon
	Test_Mgr_CreatePolygon2
	Test_Mgr_CreatePolygon3
	Test_Perf_CreatePolygon_vs_3
	Test_Mgr_CreatePolygonWithHoles
	Test_Mgr_CreatePolygonWithHoles2
	Test_Mgr_CreatePolygonWithHoles3
	Test_Perf_CreatePolygonWithHoles_vs_3
	Test_Mgr_CreateGeometryCollection
	Test_Mgr_CreateMultiPoint
	Test_Mgr_CreateMultiLineString
	Test_Mgr_CreateMultiPolygon
	Test_Mgr_CreateEmpty
	Test_Mgr_CreateCoordinate
	Test_Mgr_CreateCoordinate3D
	Test_Mgr_CreateCoordinateNative3D
	Test_Mgr_GetSRID_FromInitialize
	Test_Mgr_CreateEnvelope
	Test_Mgr_FromWKT_Point
	Test_Mgr_FromWKT_LineString
	Test_Mgr_FromWKT_Polygon
	Test_Mgr_ToWKT
	Test_Mgr_ToWKTPrecision
	Test_Mgr_FromWKB_ToWKB
	Test_Mgr_ToWKBHex_FromWKBHex

	' --- Documented edge cases (no exception expected) ---
	Test_Mgr_CreateLineString_EmptyList_Accepted
	Test_Mgr_CreateLinearRing_TooFewPoints_Invalid
	Test_Mgr_Initialize_ZeroScale_Accepted
	Test_Mgr_Initialize_NegativeScale_AsGridSize
	Test_Mgr_Initialize_DecimalScale_Accepted

	Log("  Suite  PASS: " & (mPass - passBefore) & "   FAIL: " & (mFail - failBefore))
End Sub

Private Sub Test_Mgr_CreatePoint
	Try
		Dim pt As JTSPoint = mJts.CreatePoint(10.5, 59.9)
		Log(AssertEqual("Mgr.CreatePoint - GetX",    "10.5",  pt.GetX))
		Log(AssertEqual("Mgr.CreatePoint - GetY",    "59.9",  pt.GetY))
		Log(AssertEqual("Mgr.CreatePoint - Type",    "Point", pt.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreatePoint - IsValid",           pt.AsGeometry.IsValid))
		Log(AssertTrue ("Mgr.CreatePoint - Not empty",         pt.AsGeometry.IsEmpty = False))
	Catch
		Log(Fail("Mgr.CreatePoint - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreatePoint3D
	Try
		Dim pt As JTSPoint = mJts.CreatePoint3D(10.5, 59.9, 100.0)
		Log(AssertEqual("Mgr.CreatePoint3D - GetX", "10.5",  pt.GetX))
		Log(AssertEqual("Mgr.CreatePoint3D - GetY", "59.9",  pt.GetY))
		Log(AssertEqual("Mgr.CreatePoint3D - GetZ", "100.0", pt.GetZ))
	Catch
		Log(Fail("Mgr.CreatePoint3D - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateLineString
	Try
		Dim coords As List = BuildCoords(Array As Double(10.0, 59.0, 11.0, 59.0, 11.0, 60.0))
		Dim ls As JTSLineString = mJts.CreateLineString(coords)
		Log(AssertEqual("Mgr.CreateLineString - Type",      "LineString", ls.AsGeometry.GetGeometryType))
		Log(AssertEqual("Mgr.CreateLineString - NumPoints", "3",          ls.AsGeometry.GetNumPoints))
		Log(AssertTrue ("Mgr.CreateLineString - IsValid",                 ls.AsGeometry.IsValid))
		Log(AssertTrue ("Mgr.CreateLineString - Not closed",              ls.IsClosed = False))
	Catch
		Log(Fail("Mgr.CreateLineString - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateLinearRing
	Try
		Dim coords As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim ring As JTSLineString = mJts.CreateLinearRing(coords)
		'CreateLinearRing returns JTSLineString - verify by building a polygon from it
		Dim poly As JTSPolygon = mJts.CreatePolygon2(ring)
		Log(AssertEqual("Mgr.CreateLinearRing - Polygon type",    "Polygon", poly.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreateLinearRing - Polygon isValid",            poly.AsGeometry.IsValid))
		Log(AssertTrue ("Mgr.CreateLinearRing - Polygon area > 0",           poly.AsGeometry.GetArea > 0))
		Log(AssertEqual("Mgr.CreateLinearRing - No holes",         "0",     poly.GetNumInteriorRing))
	Catch
		Log(Fail("Mgr.CreateLinearRing - Exception: " & LastException.Message))
	End Try
End Sub


Private Sub Test_Mgr_CreateLinearRing2
	Try
		Dim coords() As Object = BuildRingCoords2(10.0, 59.0, 11.0, 60.0)
		Dim ring As JTSLineString = mJts.CreateLinearRing2(coords)
		'CreateLinearRing2 returns JTSLineString - verify by building a polygon from it
		Dim poly As JTSPolygon = mJts.CreatePolygon2(ring)
		Log(AssertEqual("Mgr.CreateLinearRing2 - Polygon type",    "Polygon", poly.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreateLinearRing2 - Polygon isValid",            poly.AsGeometry.IsValid))
		Log(AssertTrue ("Mgr.CreateLinearRing2 - Polygon area > 0",           poly.AsGeometry.GetArea > 0))
		Log(AssertEqual("Mgr.CreateLinearRing2 - No holes",         "0",     poly.GetNumInteriorRing))
	Catch
		Log(Fail("Mgr.CreateLinearRing2 - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreatePolygon
	Try
		Dim coords As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim poly As JTSPolygon = mJts.CreatePolygon(coords)
		Log(AssertEqual("Mgr.CreatePolygon - Type",       "Polygon", poly.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreatePolygon - IsValid",               poly.AsGeometry.IsValid))
		Log(AssertTrue ("Mgr.CreatePolygon - Area > 0",              poly.AsGeometry.GetArea > 0))
		Log(AssertEqual("Mgr.CreatePolygon - No holes",   "0",       poly.GetNumInteriorRing))
	Catch
		Log(Fail("Mgr.CreatePolygon - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreatePolygon2
	Try
		Dim coords As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim ring As JTSLineString = mJts.CreateLinearRing(coords)
		Dim poly As JTSPolygon = mJts.CreatePolygon2(ring)
		Log(AssertEqual("Mgr.CreatePolygon2 - Type",     "Polygon", poly.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreatePolygon2 - IsValid",             poly.AsGeometry.IsValid))
		Log(AssertTrue ("Mgr.CreatePolygon2 - Area > 0",            poly.AsGeometry.GetArea > 0))
		Log(AssertEqual("Mgr.CreatePolygon2 - No holes", "0",       poly.GetNumInteriorRing))
	Catch
		Log(Fail("Mgr.CreatePolygon2 - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreatePolygon3
	Try
		Dim coords() As Object = BuildRingCoords2(10.0, 59.0, 11.0, 60.0)
		Dim poly As JTSPolygon = mJts.CreatePolygon3(coords)
		Log(AssertEqual("Mgr.CreatePolygon3 - Type",       "Polygon", poly.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreatePolygon3 - IsValid",               poly.AsGeometry.IsValid))
		Log(AssertTrue ("Mgr.CreatePolygon3 - Area > 0",              poly.AsGeometry.GetArea > 0))
		Log(AssertEqual("Mgr.CreatePolygon3 - No holes",   "0",       poly.GetNumInteriorRing))
	Catch
		Log(Fail("Mgr.CreatePolygon3 - Exception: " & LastException.Message))
	End Try
End Sub


Private Sub Test_Perf_CreatePolygon_vs_3
	Dim iterations As Int = 1000

	Dim coords As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
	Dim coords2() As Object = BuildRingCoords2(10.0, 59.0, 11.0, 60.0)

	' --- CreatePolygon ---
	Dim t1 As Long = DateTime.Now
	Dim i As Int
	For i = 0 To iterations - 1
		mJts.CreatePolygon(coords)
	Next
	Dim ms1 As Long = DateTime.Now - t1

	' --- CreatePolygon3 ---
	Dim t2 As Long = DateTime.Now
	For i = 0 To iterations - 1
		mJts.CreatePolygon3(coords2)
	Next
	Dim ms2 As Long = DateTime.Now - t2

	Log("")
	Log("  --- Perf: CreatePolygon vs CreatePolygon3 (" & iterations & " iterations) ---")
	Log("  CreatePolygon  : " & ms1 & " ms")
	Log("  CreatePolygon3 : " & ms2 & " ms")
	Dim diff As Long = ms1 - ms2
	If diff > 0 Then
		Log("  Result: CreatePolygon3 is " & diff & " ms faster")
	Else If diff < 0 Then
		Log("  Result: CreatePolygon is " & Abs(diff) & " ms faster")
	Else
		Log("  Result: No measurable difference")
	End If
	Log("")
End Sub

Private Sub Test_Mgr_CreatePolygonWithHoles
	Try
		Dim shell As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim hole  As List = BuildRingCoords(10.2, 59.2, 10.8, 59.8)
		Dim holes As List
		holes.Initialize
		holes.Add(hole)
		Dim poly As JTSPolygon = mJts.CreatePolygonWithHoles(shell, holes)
		Log(AssertEqual("Mgr.CreatePolygonWithHoles - Type",    "Polygon", poly.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreatePolygonWithHoles - IsValid",            poly.AsGeometry.IsValid))
		Log(AssertEqual("Mgr.CreatePolygonWithHoles - 1 hole",  "1",       poly.GetNumInteriorRing))
		Log(AssertTrue ("Mgr.CreatePolygonWithHoles - Area > 0",           poly.AsGeometry.GetArea > 0))
	Catch
		Log(Fail("Mgr.CreatePolygonWithHoles - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreatePolygonWithHoles2
	Try
		Dim shellCoords As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim holeCoords  As List = BuildRingCoords(10.2, 59.2, 10.8, 59.8)
		Dim shellRing As JTSLineString = mJts.CreateLinearRing(shellCoords)
		Dim holeRing  As JTSLineString = mJts.CreateLinearRing(holeCoords)
		Dim holes As List
		holes.Initialize
		holes.Add(holeRing)
		Dim poly As JTSPolygon = mJts.CreatePolygonWithHoles2(shellRing, holes)
		Log(AssertEqual("Mgr.CreatePolygonWithHoles2 - Type",    "Polygon", poly.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreatePolygonWithHoles2 - IsValid",            poly.AsGeometry.IsValid))
		Log(AssertEqual("Mgr.CreatePolygonWithHoles2 - 1 hole",  "1",       poly.GetNumInteriorRing))
		Log(AssertTrue ("Mgr.CreatePolygonWithHoles2 - Area > 0",           poly.AsGeometry.GetArea > 0))
	Catch
		Log(Fail("Mgr.CreatePolygonWithHoles2 - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreatePolygonWithHoles3
	Try
		Dim shell() As Object = BuildRingCoords2(10.0, 59.0, 11.0, 60.0)
		Dim hole()  As Object = BuildRingCoords2(10.2, 59.2, 10.8, 59.8)
		Dim holes(1) As Object
		holes(0) = hole
		Dim poly As JTSPolygon = mJts.CreatePolygonWithHoles3(shell, holes)
		Log(AssertEqual("Mgr.CreatePolygonWithHoles3 - Type",    "Polygon", poly.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Mgr.CreatePolygonWithHoles3 - IsValid",            poly.AsGeometry.IsValid))
		Log(AssertEqual("Mgr.CreatePolygonWithHoles3 - 1 hole",  "1",       poly.GetNumInteriorRing))
		Log(AssertTrue ("Mgr.CreatePolygonWithHoles3 - Area > 0",           poly.AsGeometry.GetArea > 0))
	Catch
		Log(Fail("Mgr.CreatePolygonWithHoles3 - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Perf_CreatePolygonWithHoles_vs_3
	Dim iterations As Int = 1000

	Dim shell As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
	Dim hole  As List = BuildRingCoords(10.2, 59.2, 10.8, 59.8)
	Dim holes As List
	holes.Initialize
	holes.Add(hole)

	Dim shell2() As Object = BuildRingCoords2(10.0, 59.0, 11.0, 60.0)
	Dim hole2()  As Object = BuildRingCoords2(10.2, 59.2, 10.8, 59.8)
	Dim holes2(1) As Object
	holes2(0) = hole2

	' --- CreatePolygonWithHoles ---
	Dim t1 As Long = DateTime.Now
	Dim i As Int
	For i = 0 To iterations - 1
		mJts.CreatePolygonWithHoles(shell, holes)
	Next
	Dim ms1 As Long = DateTime.Now - t1

	' --- CreatePolygonWithHoles3 ---
	Dim t2 As Long = DateTime.Now
	For i = 0 To iterations - 1
		mJts.CreatePolygonWithHoles3(shell2, holes2)
	Next
	Dim ms2 As Long = DateTime.Now - t2

	Log("")
	Log("  --- Perf: CreatePolygonWithHoles vs CreatePolygonWithHoles3 (" & iterations & " iterations) ---")
	Log("  CreatePolygonWithHoles  : " & ms1 & " ms")
	Log("  CreatePolygonWithHoles3 : " & ms2 & " ms")
	Dim diff As Long = ms1 - ms2
	If diff > 0 Then
		Log("  Result: WithHoles3 is " & diff & " ms faster")
	Else If diff < 0 Then
		Log("  Result: WithHoles is " & Abs(diff) & " ms faster")
	Else
		Log("  Result: No measurable difference")
	End If
	Log("")
End Sub

Private Sub Test_Mgr_CreateGeometryCollection
	Try
		Dim geoms As List
		geoms.Initialize
		geoms.Add(mJts.CreatePoint(10.0, 59.0).AsGeometry)
		geoms.Add(mJts.CreatePoint(11.0, 60.0).AsGeometry)
		Dim col As JTSGeometry = mJts.CreateGeometryCollection(geoms)
		Log(AssertEqual("Mgr.CreateGeometryCollection - Type",     "GeometryCollection", col.GetGeometryType))
		Log(AssertEqual("Mgr.CreateGeometryCollection - NumGeoms", "2",                  col.GetNumGeometries))
		Log(AssertTrue ("Mgr.CreateGeometryCollection - Not empty",                      col.IsEmpty = False))
	Catch
		Log(Fail("Mgr.CreateGeometryCollection - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateMultiPoint
	Try
		Dim pts As List
		pts.Initialize
		pts.Add(mJts.CreatePoint(10.0, 59.0))
		pts.Add(mJts.CreatePoint(11.0, 60.0))
		pts.Add(mJts.CreatePoint(12.0, 61.0))
		Dim col As JTSGeometry = mJts.CreateMultiPoint(pts)
		Log(AssertEqual("Mgr.CreateMultiPoint - Type",     "MultiPoint", col.GetGeometryType))
		Log(AssertEqual("Mgr.CreateMultiPoint - NumGeoms", "3",          col.GetNumGeometries))
	Catch
		Log(Fail("Mgr.CreateMultiPoint - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateMultiLineString
	Try
		Dim lines As List
		lines.Initialize
		lines.Add(mJts.CreateLineString(BuildCoords(Array As Double(10.0, 59.0, 11.0, 60.0))))
		lines.Add(mJts.CreateLineString(BuildCoords(Array As Double(12.0, 59.0, 13.0, 60.0))))
		Dim col As JTSGeometry = mJts.CreateMultiLineString(lines)
		Log(AssertEqual("Mgr.CreateMultiLineString - Type",     "MultiLineString", col.GetGeometryType))
		Log(AssertEqual("Mgr.CreateMultiLineString - NumGeoms", "2",               col.GetNumGeometries))
	Catch
		Log(Fail("Mgr.CreateMultiLineString - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateMultiPolygon
	Try
		Dim polys As List
		polys.Initialize
		polys.Add(mJts.CreatePolygon(BuildRingCoords(10.0, 59.0, 11.0, 60.0)))
		polys.Add(mJts.CreatePolygon(BuildRingCoords(12.0, 59.0, 13.0, 60.0)))
		Dim col As JTSGeometry = mJts.CreateMultiPolygon(polys)
		Log(AssertEqual("Mgr.CreateMultiPolygon - Type",     "MultiPolygon", col.GetGeometryType))
		Log(AssertEqual("Mgr.CreateMultiPolygon - NumGeoms", "2",            col.GetNumGeometries))
		Log(AssertTrue ("Mgr.CreateMultiPolygon - Area > 0",                 col.GetArea > 0))
	Catch
		Log(Fail("Mgr.CreateMultiPolygon - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateEmpty
	Try
		Dim geom As JTSGeometry = mJts.CreateEmpty
		Log(AssertTrue("Mgr.CreateEmpty - IsEmpty", geom.IsEmpty))
	Catch
		Log(Fail("Mgr.CreateEmpty - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateCoordinate
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate(10.5, 59.9)
		Log(AssertEqual("Mgr.CreateCoordinate - GetX", "10.5", c.GetX))
		Log(AssertEqual("Mgr.CreateCoordinate - GetY", "59.9", c.GetY))
		Log(AssertTrue ("Mgr.CreateCoordinate - Not 3D",       c.GetIs3D = False))
	Catch
		Log(Fail("Mgr.CreateCoordinate - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateCoordinate3D
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate3D(10.5, 59.9, 200.0)
		Log(AssertEqual("Mgr.CreateCoordinate3D - GetX", "10.5",  c.GetX))
		Log(AssertEqual("Mgr.CreateCoordinate3D - GetY", "59.9",  c.GetY))
		Log(AssertEqual("Mgr.CreateCoordinate3D - GetZ", "200.0", c.GetZ))
		Log(AssertTrue ("Mgr.CreateCoordinate3D - Is3D",               c.GetIs3D))
	Catch
		Log(Fail("Mgr.CreateCoordinate3D - Exception: " & LastException.Message))
	End Try
End Sub

' Verifies that CreateCoordinateNative3D returns a usable JavaObject wrapping
' a 3D org.locationtech.jts.geom.Coordinate. We wrap it in a JTSCoordinate
' to inspect the X, Y and Z fields.
Private Sub Test_Mgr_CreateCoordinateNative3D
	Try
		Dim raw As JavaObject = mJts.CreateCoordinateNative3D(10.5, 59.9, 200.0)
		Dim c As JTSCoordinate
		c.Initialize(raw)
		Log(AssertEqual("Mgr.CreateCoordinateNative3D - GetX", "10.5",  c.GetX))
		Log(AssertEqual("Mgr.CreateCoordinateNative3D - GetY", "59.9",  c.GetY))
		Log(AssertEqual("Mgr.CreateCoordinateNative3D - GetZ", "200.0", c.GetZ))
		Log(AssertTrue ("Mgr.CreateCoordinateNative3D - Is3D",          c.GetIs3D))
	Catch
		Log(Fail("Mgr.CreateCoordinateNative3D - Exception: " & LastException.Message))
	End Try
End Sub

' Verifies that the SRID passed to Initialize is reflected by Mgr.GetSRID,
' and that newly created geometries inherit this SRID from the GeometryFactory.
Private Sub Test_Mgr_GetSRID_FromInitialize
	Try
		Dim mgr As JTSManager
		mgr.Initialize("FLOATING", 4326)
		Log(AssertEqual("Mgr.GetSRID - After Initialize",    "4326", mgr.GetSRID))
		Dim pt As JTSPoint = mgr.CreatePoint(10.0, 59.0)
		Log(AssertEqual("Mgr.GetSRID - Point inherits SRID", "4326", pt.AsGeometry.GetSRID))
	Catch
		Log(Fail("Mgr.GetSRID FromInitialize - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_CreateEnvelope
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertEqual("Mgr.CreateEnvelope - MinX",   "10.0", e.GetMinX))
		Log(AssertEqual("Mgr.CreateEnvelope - MaxX",   "11.0", e.GetMaxX))
		Log(AssertEqual("Mgr.CreateEnvelope - MinY",   "59.0", e.GetMinY))
		Log(AssertEqual("Mgr.CreateEnvelope - MaxY",   "60.0", e.GetMaxY))
		Log(AssertEqual("Mgr.CreateEnvelope - Width",  "1.0",  e.GetWidth))
		Log(AssertEqual("Mgr.CreateEnvelope - Height", "1.0",  e.GetHeight))
		Log(AssertTrue ("Mgr.CreateEnvelope - Area > 0",       e.GetArea > 0))
	Catch
		Log(Fail("Mgr.CreateEnvelope - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_FromWKT_Point
	Try
		Dim geom As JTSGeometry = mJts.FromWKT("POINT (10.5 59.9)")
		Log(AssertEqual("Mgr.FromWKT Point - Type", "Point", geom.GetGeometryType))
		Log(AssertTrue ("Mgr.FromWKT Point - IsValid",        geom.IsValid))
	Catch
		Log(Fail("Mgr.FromWKT Point - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_FromWKT_LineString
	Try
		Dim geom As JTSGeometry = mJts.FromWKT("LINESTRING (10 59, 11 59, 11 60)")
		Log(AssertEqual("Mgr.FromWKT LineString - Type",      "LineString", geom.GetGeometryType))
		Log(AssertEqual("Mgr.FromWKT LineString - NumPoints", "3",          geom.GetNumPoints))
	Catch
		Log(Fail("Mgr.FromWKT LineString - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_FromWKT_Polygon
	Try
		Dim geom As JTSGeometry = mJts.FromWKT("POLYGON ((10 59, 11 59, 11 60, 10 60, 10 59))")
		Log(AssertEqual("Mgr.FromWKT Polygon - Type",    "Polygon", geom.GetGeometryType))
		Log(AssertTrue ("Mgr.FromWKT Polygon - IsValid",            geom.IsValid))
		Log(AssertTrue ("Mgr.FromWKT Polygon - Area > 0",           geom.GetArea > 0))
	Catch
		Log(Fail("Mgr.FromWKT Polygon - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_ToWKT
	Try
		Dim poly As JTSPolygon = mJts.CreatePolygon(BuildRingCoords(10.0, 59.0, 11.0, 60.0))
		Dim wkt As String = mJts.ToWKT(poly.AsGeometry)
		Log(AssertTrue("Mgr.ToWKT - Contains POLYGON", wkt.StartsWith("POLYGON")))
		Log(AssertTrue("Mgr.ToWKT - Not empty",        wkt.Length > 10))
	Catch
		Log(Fail("Mgr.ToWKT - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_ToWKTPrecision
	Try
		Dim pt As JTSPoint = mJts.CreatePoint(10.123456789, 59.987654321)
		Dim wkt As String = mJts.ToWKTPrecision(pt.AsGeometry, 3)
		Log(AssertTrue("Mgr.ToWKTPrecision - Contains POINT",    wkt.StartsWith("POINT")))
		Log(AssertTrue("Mgr.ToWKTPrecision - Max 3 decimals",    wkt.Contains("10.123") Or wkt.Contains("10.12")))
	Catch
		Log(Fail("Mgr.ToWKTPrecision - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_FromWKB_ToWKB
	Try
		Dim original As JTSGeometry = mJts.FromWKT("POINT (10.5 59.9)")
		Dim bytes() As Byte = mJts.ToWKB(original)
		Log(AssertTrue("Mgr.ToWKB - Bytes not empty", bytes.Length > 0))
		Dim restored As JTSGeometry = mJts.FromWKB(bytes)
		Log(AssertEqual("Mgr.FromWKB - Type",    "Point", restored.GetGeometryType))
		Log(AssertTrue ("Mgr.FromWKB - IsValid",          restored.IsValid))
		Log(AssertTrue ("Mgr.FromWKB - Equals original",  original.EqualsTopologically(restored)))
	Catch
		Log(Fail("Mgr.FromWKB/ToWKB - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Mgr_ToWKBHex_FromWKBHex
	Try
		Dim original As JTSGeometry = mJts.FromWKT("LINESTRING (10 59, 11 60)")
		Dim hex As String = mJts.ToWKBHex(original)
		Log(AssertTrue("Mgr.ToWKBHex - Not empty",          hex.Length > 0))
		Dim restored As JTSGeometry = mJts.FromWKBHex(hex)
		Log(AssertEqual("Mgr.FromWKBHex - Type",            "LineString", restored.GetGeometryType))
		Log(AssertTrue ("Mgr.FromWKBHex - Equals original",               original.EqualsTopologically(restored)))
	Catch
		Log(Fail("Mgr.ToWKBHex/FromWKBHex - Exception: " & LastException.Message))
	End Try
End Sub

' Documented behavior: CreateLineString with an empty coordinate list returns
' a valid empty LineString without throwing. See JTSManager.CreateLineString doc.
Private Sub Test_Mgr_CreateLineString_EmptyList_Accepted
	Dim coords As List
	coords.Initialize
	Try
		Dim ls As JTSLineString = mJts.CreateLineString(coords)
		Log(AssertTrue ("Mgr.CreateLineString EmptyList - IsEmpty",  ls.AsGeometry.IsEmpty))
		Log(AssertTrue ("Mgr.CreateLineString EmptyList - IsValid",  ls.AsGeometry.IsValid))
		Log(AssertEqual("Mgr.CreateLineString EmptyList - Type",     "LineString", ls.AsGeometry.GetGeometryType))
	Catch
		Log(Fail("Mgr.CreateLineString EmptyList - Exception: " & LastException.Message))
	End Try
End Sub

' Documented behavior: CreateLinearRing with too few unique points (e.g. 2 unique
' + closing) returns an invalid ring rather than throwing. See JTSManager.CreateLinearRing doc.
Private Sub Test_Mgr_CreateLinearRing_TooFewPoints_Invalid
	Dim coords As List
	coords.Initialize
	coords.Add(mJts.CreateCoordinate(10.0, 59.0))
	coords.Add(mJts.CreateCoordinate(11.0, 60.0))
	coords.Add(mJts.CreateCoordinate(10.0, 59.0))
	Try
		Dim ring As JTSLineString = mJts.CreateLinearRing(coords)
		Log(AssertTrue("Mgr.CreateLinearRing TooFewPoints - IsValid = False", ring.AsGeometry.IsValid = False))
	Catch
		Log(Fail("Mgr.CreateLinearRing TooFewPoints - Exception: " & LastException.Message))
	End Try
End Sub

' Documented behavior: Scale = 0 is accepted by JTS without exception.
' The resulting model is fixed (IsFloating = False) with a degenerate scale.
Private Sub Test_Mgr_Initialize_ZeroScale_Accepted
	Try
		Dim mgr As JTSManager
		mgr.Initialize("0", 0)
		Log(AssertTrue("Mgr.Initialize ZeroScale - IsFloating = False", mgr.IsFloating = False))
	Catch
		Log(Fail("Mgr.Initialize ZeroScale - Exception: " & LastException.Message))
	End Try
End Sub

' Documented behavior: A negative scale value is interpreted as an exact grid size.
' For scale = -100, JTS sets gridSize = 100 and scale = 1/100 = 0.01.
' This is the recommended way to specify a precise grid size.
Private Sub Test_Mgr_Initialize_NegativeScale_AsGridSize
	Try
		Dim mgr As JTSManager
		mgr.Initialize("-100", 0)
		Log(AssertTrue ("Mgr.Initialize NegativeScale - IsFloating = False", mgr.IsFloating = False))
		Log(AssertEqual("Mgr.Initialize NegativeScale - GetScale = 0.01",   "0.01", mgr.GetScale))
		' Round 12345 with grid size 100 -> nearest 100 = 12300
		Log(AssertEqual("Mgr.Initialize NegativeScale - MakePrecise(12345)", "12300.0", mgr.MakePrecise(12345)))
	Catch
		Log(Fail("Mgr.Initialize NegativeScale - Exception: " & LastException.Message))
	End Try
End Sub

' Documented behavior: A decimal/fractional scale value is accepted by JTS.
' For scale = 0.001, coordinates are rounded to the nearest 1000.
Private Sub Test_Mgr_Initialize_DecimalScale_Accepted
	Try
		Dim mgr As JTSManager
		mgr.Initialize("0.001", 0)
		Log(AssertTrue ("Mgr.Initialize DecimalScale - IsFloating = False", mgr.IsFloating = False))
		Log(AssertEqual("Mgr.Initialize DecimalScale - GetScale = 0.001",  "0.001", mgr.GetScale))
		' 12345.6 with scale 0.001 -> nearest 1000 = 12000
		Log(AssertEqual("Mgr.Initialize DecimalScale - MakePrecise(12345.6)", "12000.0", mgr.MakePrecise(12345.6)))
	Catch
		Log(Fail("Mgr.Initialize DecimalScale - Exception: " & LastException.Message))
	End Try
End Sub


'##########################################################################
'# JTSCoordinate
'##########################################################################

Private Sub RunCoordinateTests
	Log("")
	Log("========================================")
	Log(" JTSCoordinate Test Suite")
	Log("========================================")

	Dim passBefore As Int = mPass
	Dim failBefore As Int = mFail

	Test_Coord_GetX_GetY
	Test_Coord_GetZ_2D
	Test_Coord_GetIs3D_False
	Test_Coord_GetIs3D_True
	Test_Coord_SetX_SetY
	Test_Coord_SetZ
	Test_Coord_Distance2D
	Test_Coord_Distance2D_SamePoint
	Test_Coord_Distance3D
	Test_Coord_Equals2D_True
	Test_Coord_Equals2D_False
	Test_Coord_Equals2DTolerance_Within
	Test_Coord_Equals2DTolerance_Outside
	Test_Coord_Equals3D_True
	Test_Coord_Equals3D_False
	Test_Coord_ToString

	Log("  Suite  PASS: " & (mPass - passBefore) & "   FAIL: " & (mFail - failBefore))
End Sub

Private Sub Test_Coord_GetX_GetY
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate(10.5, 59.9)
		Log(AssertEqual("Coord.GetX", "10.5", c.GetX))
		Log(AssertEqual("Coord.GetY", "59.9", c.GetY))
	Catch
		Log(Fail("Coord.GetX/GetY - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_GetZ_2D
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Dim z As Double = c.GetZ
		Log(AssertTrue("Coord.GetZ 2D - Is NaN", z <> z))
	Catch
		Log(Fail("Coord.GetZ 2D - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_GetIs3D_False
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Log(AssertTrue("Coord.GetIs3D - 2D is False", c.GetIs3D = False))
	Catch
		Log(Fail("Coord.GetIs3D False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_GetIs3D_True
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate3D(10.0, 59.0, 150.0)
		Log(AssertTrue ("Coord.GetIs3D - 3D is True", c.GetIs3D))
		Log(AssertEqual("Coord.GetZ 3D",              "150.0", c.GetZ))
	Catch
		Log(Fail("Coord.GetIs3D True - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_SetX_SetY
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate(1.0, 2.0)
		c.SetX(10.5)
		c.SetY(59.9)
		Log(AssertEqual("Coord.SetX - After set", "10.5", c.GetX))
		Log(AssertEqual("Coord.SetY - After set", "59.9", c.GetY))
	Catch
		Log(Fail("Coord.SetX/SetY - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_SetZ
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Log(AssertTrue("Coord.SetZ - Before: not 3D", c.GetIs3D = False))
		c.SetZ(200.0)
		Log(AssertTrue ("Coord.SetZ - After: is 3D",  c.GetIs3D))
		Log(AssertEqual("Coord.SetZ - Value",          "200.0", c.GetZ))
	Catch
		Log(Fail("Coord.SetZ - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Distance2D
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate(0.0, 0.0)
		Dim b As JTSCoordinate = mJts.CreateCoordinate(3.0, 4.0)
		Log(AssertEqual("Coord.Distance2D - 3-4-5", "5.0", a.Distance2D(b)))
	Catch
		Log(Fail("Coord.Distance2D - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Distance2D_SamePoint
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Log(AssertEqual("Coord.Distance2D - Same point", "0.0", a.Distance2D(a)))
	Catch
		Log(Fail("Coord.Distance2D SamePoint - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Distance3D
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate3D(0.0, 0.0, 0.0)
		Dim b As JTSCoordinate = mJts.CreateCoordinate3D(1.0, 0.0, 0.0)
		Log(AssertEqual("Coord.Distance3D - Unit step", "1.0", a.Distance3D(b)))
	Catch
		Log(Fail("Coord.Distance3D - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Equals2D_True
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Dim b As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Log(AssertTrue("Coord.Equals2D - Same XY", a.Equals2D(b)))
	Catch
		Log(Fail("Coord.Equals2D True - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Equals2D_False
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Dim b As JTSCoordinate = mJts.CreateCoordinate(11.0, 60.0)
		Log(AssertTrue("Coord.Equals2D - Different XY", a.Equals2D(b) = False))
	Catch
		Log(Fail("Coord.Equals2D False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Equals2DTolerance_Within
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Dim b As JTSCoordinate = mJts.CreateCoordinate(10.0001, 59.0001)
		Log(AssertTrue("Coord.Equals2DTolerance - Within 0.001", a.Equals2DTolerance(b, 0.001)))
	Catch
		Log(Fail("Coord.Equals2DTolerance Within - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Equals2DTolerance_Outside
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate(10.0, 59.0)
		Dim b As JTSCoordinate = mJts.CreateCoordinate(10.1, 59.1)
		Log(AssertTrue("Coord.Equals2DTolerance - Outside 0.001", a.Equals2DTolerance(b, 0.001) = False))
	Catch
		Log(Fail("Coord.Equals2DTolerance Outside - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Equals3D_True
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate3D(10.0, 59.0, 100.0)
		Dim b As JTSCoordinate = mJts.CreateCoordinate3D(10.0, 59.0, 100.0)
		Log(AssertTrue("Coord.Equals3D - Same XYZ", a.Equals3D(b)))
	Catch
		Log(Fail("Coord.Equals3D True - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_Equals3D_False
	Try
		Dim a As JTSCoordinate = mJts.CreateCoordinate3D(10.0, 59.0, 100.0)
		Dim b As JTSCoordinate = mJts.CreateCoordinate3D(10.0, 59.0, 200.0)
		Log(AssertTrue("Coord.Equals3D - Different Z", a.Equals3D(b) = False))
	Catch
		Log(Fail("Coord.Equals3D False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Coord_ToString
	Try
		Dim c As JTSCoordinate = mJts.CreateCoordinate(10.5, 59.9)
		Dim s As String = c.ToString
		Log(AssertTrue("Coord.ToString - Not empty",   s.Length > 0))
		Log(AssertTrue("Coord.ToString - Contains X",  s.Contains("10.5")))
		Log(AssertTrue("Coord.ToString - Contains Y",  s.Contains("59.9")))
	Catch
		Log(Fail("Coord.ToString - Exception: " & LastException.Message))
	End Try
End Sub


'##########################################################################
'# JTSEnvelope
'##########################################################################

Private Sub RunEnvelopeTests
	Log("")
	Log("========================================")
	Log(" JTSEnvelope Test Suite")
	Log("========================================")

	Dim passBefore As Int = mPass
	Dim failBefore As Int = mFail

	Test_Env_GetMinMaxXY
	Test_Env_GetWidth_GetHeight
	Test_Env_GetArea
	Test_Env_GetMidX_GetMidY
	Test_Env_IsNull_False
	Test_Env_IsNull_True
	Test_Env_ExpandToIncludePoint_Inside
	Test_Env_ExpandToIncludePoint_Outside
	Test_Env_ExpandToIncludeEnvelope
	Test_Env_ExpandBy
	Test_Env_Intersects_True
	Test_Env_Intersects_False
	Test_Env_ContainsPoint_Inside
	Test_Env_ContainsPoint_Outside
	Test_Env_ContainsPoint_OnBoundary
	Test_Env_ContainsEnvelope_True
	Test_Env_ContainsEnvelope_False
	Test_Env_CoversPoint_Inside
	Test_Env_CoversPoint_Outside
	Test_Env_GetDiameter
	Test_Env_ToString

	Log("  Suite  PASS: " & (mPass - passBefore) & "   FAIL: " & (mFail - failBefore))
End Sub

Private Sub Test_Env_GetMinMaxXY
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertDouble("Env.GetMinX", 10.0, e.GetMinX))
		Log(AssertDouble("Env.GetMaxX", 11.0, e.GetMaxX))
		Log(AssertDouble("Env.GetMinY", 59.0, e.GetMinY))
		Log(AssertDouble("Env.GetMaxY", 60.0, e.GetMaxY))
	Catch
		Log(Fail("Env.GetMinMax - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_GetWidth_GetHeight
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 12.0, 59.0, 61.5)
		Log(AssertDouble("Env.GetWidth",  2.0, e.GetWidth))
		Log(AssertDouble("Env.GetHeight", 2.5, e.GetHeight))
	Catch
		Log(Fail("Env.GetWidth/Height - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_GetArea
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertDouble("Env.GetArea - 1x1", 1.0, e.GetArea))
	Catch
		Log(Fail("Env.GetArea - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_GetMidX_GetMidY
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 12.0, 58.0, 62.0)
		Log(AssertDouble("Env.GetMidX", 11.0, e.GetMidX))
		Log(AssertDouble("Env.GetMidY", 60.0, e.GetMidY))
	Catch
		Log(Fail("Env.GetMidX/MidY - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_IsNull_False
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertTrue("Env.IsNull - Set envelope is not null", e.IsNull = False))
	Catch
		Log(Fail("Env.IsNull False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_IsNull_True
	Try
		Dim raw As JavaObject
		raw.InitializeNewInstance("org.locationtech.jts.geom.Envelope", Null)
		Dim e As JTSEnvelope
		e.Initialize(raw)
		Log(AssertTrue("Env.IsNull - Default envelope is null", e.IsNull))
	Catch
		Log(Fail("Env.IsNull True - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ExpandToIncludePoint_Inside
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		e.ExpandToIncludePoint(10.5, 59.5)
		Log(AssertDouble("Env.ExpandToIncludePoint Inside - MaxX", 11.0, e.GetMaxX))
		Log(AssertDouble("Env.ExpandToIncludePoint Inside - MaxY", 60.0, e.GetMaxY))
	Catch
		Log(Fail("Env.ExpandToIncludePoint Inside - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ExpandToIncludePoint_Outside
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		e.ExpandToIncludePoint(12.0, 61.0)
		Log(AssertDouble("Env.ExpandToIncludePoint Outside - MaxX", 12.0, e.GetMaxX))
		Log(AssertDouble("Env.ExpandToIncludePoint Outside - MaxY", 61.0, e.GetMaxY))
	Catch
		Log(Fail("Env.ExpandToIncludePoint Outside - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ExpandToIncludeEnvelope
	Try
		Dim a As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Dim b As JTSEnvelope = mJts.CreateEnvelope(10.5, 13.0, 59.5, 62.0)
		a.ExpandToIncludeEnvelope(b)
		Log(AssertDouble("Env.ExpandToIncludeEnvelope - MaxX", 13.0, a.GetMaxX))
		Log(AssertDouble("Env.ExpandToIncludeEnvelope - MaxY", 62.0, a.GetMaxY))
		Log(AssertDouble("Env.ExpandToIncludeEnvelope - MinX", 10.0, a.GetMinX))
	Catch
		Log(Fail("Env.ExpandToIncludeEnvelope - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ExpandBy
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		e.ExpandBy(1.0)
		Log(AssertDouble("Env.ExpandBy - MinX",  9.0, e.GetMinX))
		Log(AssertDouble("Env.ExpandBy - MaxX", 12.0, e.GetMaxX))
		Log(AssertDouble("Env.ExpandBy - MinY", 58.0, e.GetMinY))
		Log(AssertDouble("Env.ExpandBy - MaxY", 61.0, e.GetMaxY))
	Catch
		Log(Fail("Env.ExpandBy - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_Intersects_True
	Try
		Dim a As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Dim b As JTSEnvelope = mJts.CreateEnvelope(10.5, 11.5, 59.5, 60.5)
		Log(AssertTrue("Env.Intersects - Overlapping", a.Intersects(b)))
	Catch
		Log(Fail("Env.Intersects True - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_Intersects_False
	Try
		Dim a As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Dim b As JTSEnvelope = mJts.CreateEnvelope(12.0, 13.0, 59.0, 60.0)
		Log(AssertTrue("Env.Intersects - Disjoint", a.Intersects(b) = False))
	Catch
		Log(Fail("Env.Intersects False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ContainsPoint_Inside
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertTrue("Env.ContainsPoint - Inside", e.ContainsPoint(10.5, 59.5)))
	Catch
		Log(Fail("Env.ContainsPoint Inside - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ContainsPoint_Outside
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertTrue("Env.ContainsPoint - Outside", e.ContainsPoint(12.0, 59.5) = False))
	Catch
		Log(Fail("Env.ContainsPoint Outside - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ContainsPoint_OnBoundary
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertTrue("Env.ContainsPoint - On boundary is contained", e.ContainsPoint(10.0, 59.0)))
	Catch
		Log(Fail("Env.ContainsPoint OnBoundary - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ContainsEnvelope_True
	Try
		Dim outer As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Dim inner As JTSEnvelope = mJts.CreateEnvelope(10.2, 10.8, 59.2, 59.8)
		Log(AssertTrue("Env.ContainsEnvelope - Inner inside outer", outer.ContainsEnvelope(inner)))
	Catch
		Log(Fail("Env.ContainsEnvelope True - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ContainsEnvelope_False
	Try
		Dim a As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Dim b As JTSEnvelope = mJts.CreateEnvelope(10.5, 12.0, 59.5, 61.0)
		Log(AssertTrue("Env.ContainsEnvelope - Partial overlap not contained", a.ContainsEnvelope(b) = False))
	Catch
		Log(Fail("Env.ContainsEnvelope False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_CoversPoint_Inside
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertTrue("Env.CoversPoint - Inside",      e.CoversPoint(10.5, 59.5)))
		Log(AssertTrue("Env.CoversPoint - On boundary", e.CoversPoint(10.0, 59.0)))
	Catch
		Log(Fail("Env.CoversPoint Inside - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_CoversPoint_Outside
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Log(AssertTrue("Env.CoversPoint - Outside", e.CoversPoint(12.0, 59.5) = False))
	Catch
		Log(Fail("Env.CoversPoint Outside - Exception: " & LastException.Message))
	End Try
End Sub

' GetDiameter is the length of the envelope's diagonal:
' sqrt(width^2 + height^2). For a 3x4 envelope this is the 3-4-5 triangle.
Private Sub Test_Env_GetDiameter
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(0.0, 3.0, 0.0, 4.0)
		Log(AssertEqual("Env.GetDiameter - 3-4-5 triangle", "5.0", e.GetDiameter))
	Catch
		Log(Fail("Env.GetDiameter - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Env_ToString
	Try
		Dim e As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Dim s As String = e.ToString
		Log(AssertTrue("Env.ToString - Not empty",     s.Length > 0))
		Log(AssertTrue("Env.ToString - Contains MinX", s.Contains("10")))
		Log(AssertTrue("Env.ToString - Contains MaxX", s.Contains("11")))
	Catch
		Log(Fail("Env.ToString - Exception: " & LastException.Message))
	End Try
End Sub


'##########################################################################
'# JTSGeometry
'##########################################################################

Private Sub RunGeometryTests
	Log("")
	Log("========================================")
	Log(" JTSGeometry Test Suite")
	Log("========================================")

	Dim passBefore As Int = mPass
	Dim failBefore As Int = mFail

	SetupGeometries

	Test_Geom_GetGeometryType
	Test_Geom_AsPoint
	Test_Geom_AsLineString
	Test_Geom_AsPolygon
	Test_Geom_GetSRID_SetSRID
	Test_Geom_GetNumPoints
	Test_Geom_GetNumGeometries
	Test_Geom_GetGeometryN
	Test_Geom_IsEmpty
	Test_Geom_IsSimple
	Test_Geom_IsValid
	Test_Geom_GetDimension
	Test_Geom_GetArea
	Test_Geom_GetLength
	Test_Geom_Distance
	Test_Geom_IsWithinDistance
	Test_Geom_Intersects
	Test_Geom_Contains
	Test_Geom_Within
	Test_Geom_Overlaps
	Test_Geom_Touches
	Test_Geom_Crosses
	Test_Geom_Disjoint
	Test_Geom_EqualsTopologically
	Test_Geom_EqualsExact
	Test_Geom_Covers
	Test_Geom_CoveredBy
	Test_Geom_Relate
	Test_Geom_GetIntersectionMatrix
	Test_Geom_Buffer
	Test_Geom_BufferWithSegments
	Test_Geom_ConvexHull
	Test_Geom_GetEnvelopeInternal
	Test_Geom_GetEnvelope
	Test_Geom_Intersection
	Test_Geom_Union
	Test_Geom_UnionAll
	Test_Geom_Difference
	Test_Geom_SymDifference
	Test_Geom_GetCentroid
	Test_Geom_GetInteriorPoint
	Test_Geom_Normalize
	Test_Geom_Reverse
	Test_Geom_SimplifyDP
	Test_Geom_SimplifyTP
	Test_Geom_GetValidationError
	Test_Geom_MakeValid
	Test_Geom_GetCoordinates
	Test_Geom_GetCoordinate
	Test_Geom_CompareTo
	Test_Geom_HashCode
	Test_Geom_ToString

	Log("  Suite  PASS: " & (mPass - passBefore) & "   FAIL: " & (mFail - failBefore))
End Sub

Private Sub SetupGeometries
	polyA     = BuildPolygonGeom(10.0, 59.0, 11.0, 60.0)
	polyB     = BuildPolygonGeom(10.5, 59.5, 11.5, 60.5)
	polyC     = BuildPolygonGeom(12.0, 59.0, 13.0, 60.0)
	polyD     = BuildPolygonGeom(10.2, 59.2, 10.8, 59.8)
	pointInA  = mJts.CreatePoint(10.5, 59.5).AsGeometry
	pointOutA = mJts.CreatePoint(11.5, 59.5).AsGeometry
	lineThruA = BuildLineGeom(9.0, 59.5, 11.5, 59.5)
	lineInA   = BuildLineGeom(10.2, 59.2, 10.8, 59.8)
End Sub

Private Sub Test_Geom_GetGeometryType
	Try
		Log(AssertEqual("Geom.GetGeometryType - Polygon",    "Polygon",    polyA.GetGeometryType))
		Log(AssertEqual("Geom.GetGeometryType - Point",      "Point",      pointInA.GetGeometryType))
		Log(AssertEqual("Geom.GetGeometryType - LineString", "LineString", lineThruA.GetGeometryType))
	Catch
		Log(Fail("Geom.GetGeometryType - Exception: " & LastException.Message))
	End Try
End Sub

' AsPoint casts a JTSGeometry of type Point to JTSPoint so that point-specific
' methods (GetX, GetY) can be accessed. Common use: after FromWKT("POINT(...)").
Private Sub Test_Geom_AsPoint
	Try
		Dim geom As JTSGeometry = mJts.FromWKT("POINT (10.5 59.9)")
		Dim pt As JTSPoint = geom.AsPoint
		Log(AssertEqual("Geom.AsPoint - GetX", "10.5", pt.GetX))
		Log(AssertEqual("Geom.AsPoint - GetY", "59.9", pt.GetY))
	Catch
		Log(Fail("Geom.AsPoint - Exception: " & LastException.Message))
	End Try
End Sub

' AsLineString casts a JTSGeometry of type LineString to JTSLineString so that
' linestring-specific methods (GetNumPoints, IsClosed, ...) can be accessed.
Private Sub Test_Geom_AsLineString
	Try
		Dim geom As JTSGeometry = mJts.FromWKT("LINESTRING (0 0, 3 0, 3 4)")
		Dim ls As JTSLineString = geom.AsLineString
		Log(AssertEqual("Geom.AsLineString - GetNumPoints", "3",   ls.AsGeometry.GetNumPoints))
		Log(AssertEqual("Geom.AsLineString - Length",        "7.0", ls.AsGeometry.GetLength))
	Catch
		Log(Fail("Geom.AsLineString - Exception: " & LastException.Message))
	End Try
End Sub

' AsPolygon casts a JTSGeometry of type Polygon to JTSPolygon so that
' polygon-specific methods (GetExteriorRing, GetNumInteriorRing, ...) can be accessed.
Private Sub Test_Geom_AsPolygon
	Try
		Dim geom As JTSGeometry = mJts.FromWKT("POLYGON ((0 0, 1 0, 1 1, 0 1, 0 0))")
		Dim poly As JTSPolygon = geom.AsPolygon
		Log(AssertEqual("Geom.AsPolygon - Area",              "1.0", poly.AsGeometry.GetArea))
		Log(AssertEqual("Geom.AsPolygon - GetNumInteriorRing", "0",  poly.GetNumInteriorRing))
	Catch
		Log(Fail("Geom.AsPolygon - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetSRID_SetSRID
	Try
		Log(AssertEqual("Geom.GetSRID - Default",   "0",    polyA.GetSRID))
		polyA.SetSRID(4326)
		Log(AssertEqual("Geom.SetSRID - After set", "4326", polyA.GetSRID))
		polyA.SetSRID(0)
	Catch
		Log(Fail("Geom.GetSRID/SetSRID - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetNumPoints
	Try
		Log(AssertEqual("Geom.GetNumPoints - Polygon", "5", polyA.GetNumPoints))
		Log(AssertEqual("Geom.GetNumPoints - Point",   "1", pointInA.GetNumPoints))
		Log(AssertEqual("Geom.GetNumPoints - Line",    "2", lineThruA.GetNumPoints))
	Catch
		Log(Fail("Geom.GetNumPoints - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetNumGeometries
	Try
		Log(AssertEqual("Geom.GetNumGeometries - Simple", "1", polyA.GetNumGeometries))
	Catch
		Log(Fail("Geom.GetNumGeometries - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetGeometryN
	Try
		Dim g As JTSGeometry = polyA.GetGeometryN(0)
		Log(AssertEqual("Geom.GetGeometryN - Type", "Polygon", g.GetGeometryType))
	Catch
		Log(Fail("Geom.GetGeometryN - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_IsEmpty
	Try
		Log(AssertTrue("Geom.IsEmpty - Polygon not empty", polyA.IsEmpty = False))
		Log(AssertTrue("Geom.IsEmpty - Empty geom",        mJts.CreateEmpty.IsEmpty))
	Catch
		Log(Fail("Geom.IsEmpty - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_IsSimple
	Try
		Log(AssertTrue("Geom.IsSimple - Polygon",    polyA.IsSimple))
		Log(AssertTrue("Geom.IsSimple - LineString", lineThruA.IsSimple))
	Catch
		Log(Fail("Geom.IsSimple - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_IsValid
	Try
		Log(AssertTrue("Geom.IsValid - Polygon", polyA.IsValid))
		Log(AssertTrue("Geom.IsValid - Point",   pointInA.IsValid))
		Log(AssertTrue("Geom.IsValid - Line",    lineThruA.IsValid))
	Catch
		Log(Fail("Geom.IsValid - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetDimension
	Try
		Log(AssertEqual("Geom.GetDimension - Polygon", "2", polyA.GetDimension))
		Log(AssertEqual("Geom.GetDimension - Line",    "1", lineThruA.GetDimension))
		Log(AssertEqual("Geom.GetDimension - Point",   "0", pointInA.GetDimension))
	Catch
		Log(Fail("Geom.GetDimension - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetArea
	Try
		Log(AssertEqual("Geom.GetArea - Polygon 1x1", "1.0", polyA.GetArea))
		Log(AssertEqual("Geom.GetArea - Point is 0",  "0.0", pointInA.GetArea))
		Log(AssertEqual("Geom.GetArea - Line is 0",   "0.0", lineThruA.GetArea))
	Catch
		Log(Fail("Geom.GetArea - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetLength
	Try
		Log(AssertEqual("Geom.GetLength - Polygon perimeter", "4.0", polyA.GetLength))
		Log(AssertEqual("Geom.GetLength - Line",              "2.5", lineThruA.GetLength))
		Log(AssertEqual("Geom.GetLength - Point is 0",        "0.0", pointInA.GetLength))
	Catch
		Log(Fail("Geom.GetLength - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Distance
	Try
		Log(AssertEqual("Geom.Distance - A to C",     "1.0", polyA.Distance(polyC)))
		Log(AssertEqual("Geom.Distance - A to self",  "0.0", polyA.Distance(polyA)))
		Log(AssertEqual("Geom.Distance - Point in A", "0.0", polyA.Distance(pointInA)))
	Catch
		Log(Fail("Geom.Distance - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_IsWithinDistance
	Try
		Log(AssertTrue("Geom.IsWithinDistance - A to C within 2",       polyA.IsWithinDistance(polyC, 2.0)))
		Log(AssertTrue("Geom.IsWithinDistance - A to C not within 0.5", polyA.IsWithinDistance(polyC, 0.5) = False))
	Catch
		Log(Fail("Geom.IsWithinDistance - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Intersects
	Try
		Log(AssertTrue("Geom.Intersects - A and B (overlap)",    polyA.Intersects(polyB)))
		Log(AssertTrue("Geom.Intersects - A and D (D inside A)", polyA.Intersects(polyD)))
		Log(AssertTrue("Geom.Intersects - A and pointInA",       polyA.Intersects(pointInA)))
		Log(AssertTrue("Geom.Intersects - A and C (separate)",   polyA.Intersects(polyC) = False))
		Log(AssertTrue("Geom.Intersects - A and pointOutA",      polyA.Intersects(pointOutA) = False))
	Catch
		Log(Fail("Geom.Intersects - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Contains
	Try
		Log(AssertTrue("Geom.Contains - A contains D",        polyA.Contains(polyD)))
		Log(AssertTrue("Geom.Contains - A contains pointInA", polyA.Contains(pointInA)))
		Log(AssertTrue("Geom.Contains - A not contains B",    polyA.Contains(polyB) = False))
		Log(AssertTrue("Geom.Contains - A not contains C",    polyA.Contains(polyC) = False))
	Catch
		Log(Fail("Geom.Contains - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Within
	Try
		Log(AssertTrue("Geom.Within - D within A",        polyD.Within(polyA)))
		Log(AssertTrue("Geom.Within - pointInA within A", pointInA.Within(polyA)))
		Log(AssertTrue("Geom.Within - B not within A",    polyB.Within(polyA) = False))
		Log(AssertTrue("Geom.Within - C not within A",    polyC.Within(polyA) = False))
	Catch
		Log(Fail("Geom.Within - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Overlaps
	Try
		Log(AssertTrue("Geom.Overlaps - A and B",          polyA.Overlaps(polyB)))
		Log(AssertTrue("Geom.Overlaps - A not overlaps D", polyA.Overlaps(polyD) = False))
		Log(AssertTrue("Geom.Overlaps - A not overlaps C", polyA.Overlaps(polyC) = False))
	Catch
		Log(Fail("Geom.Overlaps - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Touches
	Try
		Dim left  As JTSGeometry = BuildPolygonGeom(10.0, 59.0, 11.0, 60.0)
		Dim right As JTSGeometry = BuildPolygonGeom(11.0, 59.0, 12.0, 60.0)
		Log(AssertTrue("Geom.Touches - Left and right share edge", left.Touches(right)))
		Log(AssertTrue("Geom.Touches - A and C do not touch",      polyA.Touches(polyC) = False))
	Catch
		Log(Fail("Geom.Touches - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Crosses
	Try
		Log(AssertTrue("Geom.Crosses - Line crosses A",        lineThruA.Crosses(polyA)))
		Log(AssertTrue("Geom.Crosses - Line in A not crosses", lineInA.Crosses(polyA) = False))
	Catch
		Log(Fail("Geom.Crosses - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Disjoint
	Try
		Log(AssertTrue("Geom.Disjoint - A and C",         polyA.Disjoint(polyC)))
		Log(AssertTrue("Geom.Disjoint - A and pointOutA", polyA.Disjoint(pointOutA)))
		Log(AssertTrue("Geom.Disjoint - A and B",         polyA.Disjoint(polyB) = False))
	Catch
		Log(Fail("Geom.Disjoint - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_EqualsTopologically
	Try
		Dim copy As JTSGeometry = BuildPolygonGeom(10.0, 59.0, 11.0, 60.0)
		Log(AssertTrue("Geom.EqualsTopologically - Same polygon",     polyA.EqualsTopologically(copy)))
		Log(AssertTrue("Geom.EqualsTopologically - Different polygon",polyA.EqualsTopologically(polyB) = False))
	Catch
		Log(Fail("Geom.EqualsTopologically - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_EqualsExact
	Try
		Dim copy As JTSGeometry = BuildPolygonGeom(10.0, 59.0, 11.0, 60.0)
		Log(AssertTrue("Geom.EqualsExact - Same polygon",      polyA.EqualsExact(copy, 0.0)))
		Log(AssertTrue("Geom.EqualsExact - Within tolerance",  polyA.EqualsExact(copy, 0.001)))
		Log(AssertTrue("Geom.EqualsExact - Different polygon", polyA.EqualsExact(polyB, 0.0) = False))
	Catch
		Log(Fail("Geom.EqualsExact - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Covers
	Try
		Log(AssertTrue("Geom.Covers - A covers D",        polyA.Covers(polyD)))
		Log(AssertTrue("Geom.Covers - A covers pointInA", polyA.Covers(pointInA)))
		Log(AssertTrue("Geom.Covers - A not covers C",    polyA.Covers(polyC) = False))
	Catch
		Log(Fail("Geom.Covers - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_CoveredBy
	Try
		Log(AssertTrue("Geom.CoveredBy - D covered by A",        polyD.CoveredBy(polyA)))
		Log(AssertTrue("Geom.CoveredBy - pointInA covered by A", pointInA.CoveredBy(polyA)))
		Log(AssertTrue("Geom.CoveredBy - C not covered by A",    polyC.CoveredBy(polyA) = False))
	Catch
		Log(Fail("Geom.CoveredBy - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Relate
	Try
		Log(AssertTrue("Geom.Relate - A contains D (T*****FF*)", polyA.Relate(polyD, "T*****FF*")))
		Log(AssertTrue("Geom.Relate - A not contains C",         polyA.Relate(polyC, "T*****FF*") = False))
	Catch
		Log(Fail("Geom.Relate - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetIntersectionMatrix
	Try
		Dim matrix As String = polyA.GetIntersectionMatrix(polyD)
		Log(AssertTrue("Geom.GetIntersectionMatrix - Length 9",  matrix.Length = 9))
		Log(AssertTrue("Geom.GetIntersectionMatrix - Not empty", matrix.Length > 0))
	Catch
		Log(Fail("Geom.GetIntersectionMatrix - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Buffer
	Try
		Dim buf As JTSGeometry = polyA.Buffer(0.5)
		Log(AssertEqual("Geom.Buffer - Type",       "Polygon", buf.GetGeometryType))
		Log(AssertTrue ("Geom.Buffer - Area > A",              buf.GetArea > polyA.GetArea))
		Log(AssertTrue ("Geom.Buffer - IsValid",               buf.IsValid))
		Dim shrunk As JTSGeometry = polyA.Buffer(-0.1)
		Log(AssertTrue ("Geom.Buffer - Shrink area < A",       shrunk.GetArea < polyA.GetArea))
	Catch
		Log(Fail("Geom.Buffer - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_BufferWithSegments
	Try
		Dim buf8  As JTSGeometry = polyA.BufferWithSegments(0.5, 8)
		Dim buf32 As JTSGeometry = polyA.BufferWithSegments(0.5, 32)
		Log(AssertTrue("Geom.BufferWithSegments - Valid",                buf8.IsValid))
		Log(AssertTrue("Geom.BufferWithSegments - More segs = more pts", buf32.GetNumPoints > buf8.GetNumPoints))
	Catch
		Log(Fail("Geom.BufferWithSegments - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_ConvexHull
	Try
		Dim hull As JTSGeometry = polyA.ConvexHull
		Log(AssertTrue("Geom.ConvexHull - IsValid",   hull.IsValid))
		Log(AssertTrue("Geom.ConvexHull - Area >= A", hull.GetArea >= polyA.GetArea))
	Catch
		Log(Fail("Geom.ConvexHull - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetEnvelopeInternal
	Try
		Dim env As JTSEnvelope = polyA.GetEnvelopeInternal
		Log(AssertEqual("Geom.GetEnvelopeInternal - MinX", "10.0", env.GetMinX))
		Log(AssertEqual("Geom.GetEnvelopeInternal - MaxX", "11.0", env.GetMaxX))
		Log(AssertEqual("Geom.GetEnvelopeInternal - MinY", "59.0", env.GetMinY))
		Log(AssertEqual("Geom.GetEnvelopeInternal - MaxY", "60.0", env.GetMaxY))
	Catch
		Log(Fail("Geom.GetEnvelopeInternal - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetEnvelope
	Try
		Dim env As JTSGeometry = polyA.GetEnvelope
		Log(AssertEqual("Geom.GetEnvelope - Type",    "Polygon", env.GetGeometryType))
		Log(AssertTrue ("Geom.GetEnvelope - Area = A", env.GetArea = polyA.GetArea))
	Catch
		Log(Fail("Geom.GetEnvelope - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Intersection
	Try
		Dim inter As JTSGeometry = polyA.Intersection(polyB)
		Log(AssertTrue("Geom.Intersection - A∩B IsValid",  inter.IsValid))
		Log(AssertTrue("Geom.Intersection - A∩B Area > 0", inter.GetArea > 0))
		Log(AssertTrue("Geom.Intersection - A∩B Area < A", inter.GetArea < polyA.GetArea))
		Dim empty As JTSGeometry = polyA.Intersection(polyC)
		Log(AssertTrue("Geom.Intersection - A∩C IsEmpty",  empty.IsEmpty))
	Catch
		Log(Fail("Geom.Intersection - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Union
	Try
		Dim uni As JTSGeometry = polyA.Union(polyB)
		Log(AssertTrue("Geom.Union - A∪B IsValid",  uni.IsValid))
		Log(AssertTrue("Geom.Union - A∪B Area > A", uni.GetArea > polyA.GetArea))
		Log(AssertTrue("Geom.Union - A∪B Area > B", uni.GetArea > polyB.GetArea))
	Catch
		Log(Fail("Geom.Union - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_UnionAll
	Try
		Dim polys As List
		polys.Initialize
		polys.Add(mJts.CreatePolygon(BuildRingCoords(10.0, 59.0, 11.0, 60.0)))
		polys.Add(mJts.CreatePolygon(BuildRingCoords(11.0, 59.0, 12.0, 60.0)))
		polys.Add(mJts.CreatePolygon(BuildRingCoords(12.0, 59.0, 13.0, 60.0)))
		Dim col As JTSGeometry = mJts.CreateMultiPolygon(polys)
		Dim uni As JTSGeometry = col.UnionAll
		Log(AssertTrue("Geom.UnionAll - IsValid",  uni.IsValid))
		Log(AssertTrue("Geom.UnionAll - Area = 3", uni.GetArea = 3.0))
	Catch
		Log(Fail("Geom.UnionAll - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Difference
	Try
		Dim diff As JTSGeometry = polyA.Difference(polyB)
		Log(AssertTrue ("Geom.Difference - A-B IsValid",   diff.IsValid))
		Log(AssertTrue ("Geom.Difference - A-B Area < A",  diff.GetArea < polyA.GetArea))
		Log(AssertTrue ("Geom.Difference - A-B Area > 0",  diff.GetArea > 0))
		Dim same As JTSGeometry = polyA.Difference(polyC)
		Log(AssertEqual("Geom.Difference - A-C = A area",  polyA.GetArea, same.GetArea))
	Catch
		Log(Fail("Geom.Difference - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_SymDifference
	Try
		Dim symDiff As JTSGeometry = polyA.SymDifference(polyB)
		Log(AssertTrue("Geom.SymDifference - IsValid",  symDiff.IsValid))
		Log(AssertTrue("Geom.SymDifference - Area > 0", symDiff.GetArea > 0))
		Dim copy As JTSGeometry = BuildPolygonGeom(10.0, 59.0, 11.0, 60.0)
		Dim empty As JTSGeometry = polyA.SymDifference(copy)
		Log(AssertTrue("Geom.SymDifference - Self = empty", empty.IsEmpty Or empty.GetArea = 0))
	Catch
		Log(Fail("Geom.SymDifference - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetCentroid
	Try
		Dim c As JTSPoint = polyA.GetCentroid
		Log(AssertEqual("Geom.GetCentroid - X", "10.5", c.GetX))
		Log(AssertEqual("Geom.GetCentroid - Y", "59.5", c.GetY))
		Log(AssertTrue ("Geom.GetCentroid - Within A", c.AsGeometry.Within(polyA)))
	Catch
		Log(Fail("Geom.GetCentroid - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetInteriorPoint
	Try
		Dim pt As JTSPoint = polyA.GetInteriorPoint
		Log(AssertTrue("Geom.GetInteriorPoint - Within A", pt.AsGeometry.Within(polyA)))
	Catch
		Log(Fail("Geom.GetInteriorPoint - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Normalize
	Try
		Dim poly As JTSGeometry = BuildPolygonGeom(10.0, 59.0, 11.0, 60.0)
		poly.Normalize
		Log(AssertTrue("Geom.Normalize - Still valid", poly.IsValid))
	Catch
		Log(Fail("Geom.Normalize - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_Reverse
	Try
		Dim rev As JTSGeometry = lineThruA.Reverse
		Log(AssertEqual("Geom.Reverse - Type",           "LineString", rev.GetGeometryType))
		Log(AssertEqual("Geom.Reverse - Same numpoints",  lineThruA.GetNumPoints, rev.GetNumPoints))
		Log(AssertTrue ("Geom.Reverse - IsValid",         rev.IsValid))
	Catch
		Log(Fail("Geom.Reverse - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_SimplifyDP
	Try
		Dim coords As List
		coords.Initialize
		Dim i As Int
		For i = 0 To 20
			coords.Add(mJts.CreateCoordinate(10.0 + i * 0.05, 59.0 + Sin(i) * 0.01))
		Next
		Dim line As JTSGeometry = mJts.CreateLineString(coords).AsGeometry
		Dim simplified As JTSGeometry = line.SimplifyDP(0.05)
		Log(AssertTrue("Geom.SimplifyDP - Fewer points", simplified.GetNumPoints < line.GetNumPoints))
		Log(AssertTrue("Geom.SimplifyDP - IsValid",      simplified.IsValid))
	Catch
		Log(Fail("Geom.SimplifyDP - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_SimplifyTP
	Try
		Dim coords As List
		coords.Initialize
		Dim i As Int
		For i = 0 To 20
			coords.Add(mJts.CreateCoordinate(10.0 + i * 0.05, 59.0 + Sin(i) * 0.01))
		Next
		Dim line As JTSGeometry = mJts.CreateLineString(coords).AsGeometry
		Dim simplified As JTSGeometry = line.SimplifyTP(0.05)
		Log(AssertTrue("Geom.SimplifyTP - Fewer points", simplified.GetNumPoints < line.GetNumPoints))
		Log(AssertTrue("Geom.SimplifyTP - IsValid",      simplified.IsValid))
	Catch
		Log(Fail("Geom.SimplifyTP - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetValidationError
	Try
		Log(AssertEqual("Geom.GetValidationError - Valid polygon", "", polyA.GetValidationError))
		Dim coords As List
		coords.Initialize
		coords.Add(mJts.CreateCoordinate(10.0, 59.0))
		coords.Add(mJts.CreateCoordinate(11.0, 60.0))
		coords.Add(mJts.CreateCoordinate(11.0, 59.0))
		coords.Add(mJts.CreateCoordinate(10.0, 60.0))
		coords.Add(mJts.CreateCoordinate(10.0, 59.0))
		Dim invalid As JTSGeometry = mJts.CreatePolygon(coords).AsGeometry
		Log(AssertTrue("Geom.GetValidationError - Invalid polygon has error", invalid.GetValidationError.Length > 0))
	Catch
		Log(Fail("Geom.GetValidationError - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_MakeValid
	Try
		Dim coords As List
		coords.Initialize
		coords.Add(mJts.CreateCoordinate(10.0, 59.0))
		coords.Add(mJts.CreateCoordinate(11.0, 60.0))
		coords.Add(mJts.CreateCoordinate(11.0, 59.0))
		coords.Add(mJts.CreateCoordinate(10.0, 60.0))
		coords.Add(mJts.CreateCoordinate(10.0, 59.0))
		Dim invalid As JTSGeometry = mJts.CreatePolygon(coords).AsGeometry
		Dim fixed As JTSGeometry = invalid.MakeValid
		Log(AssertTrue("Geom.MakeValid - IsValid after repair", fixed.IsValid))
	Catch
		Log(Fail("Geom.MakeValid - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetCoordinates
	Try
		Dim coords As List = polyA.GetCoordinates
		Log(AssertEqual("Geom.GetCoordinates - Count", "5", coords.Size))
		Dim first As JTSCoordinate = coords.Get(0)
		Log(AssertEqual("Geom.GetCoordinates - First X", "10.0", first.GetX))
		Log(AssertEqual("Geom.GetCoordinates - First Y", "59.0", first.GetY))
	Catch
		Log(Fail("Geom.GetCoordinates - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_GetCoordinate
	Try
		Dim c As JTSCoordinate = pointInA.GetCoordinate
		Log(AssertEqual("Geom.GetCoordinate - X", "10.5", c.GetX))
		Log(AssertEqual("Geom.GetCoordinate - Y", "59.5", c.GetY))
	Catch
		Log(Fail("Geom.GetCoordinate - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_CompareTo
	Try
		Dim copy As JTSGeometry = BuildPolygonGeom(10.0, 59.0, 11.0, 60.0)
		Log(AssertEqual("Geom.CompareTo - Same polygon", "0", polyA.CompareTo(copy)))
	Catch
		Log(Fail("Geom.CompareTo - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_HashCode
	Try
		Dim copy As JTSGeometry = BuildPolygonGeom(10.0, 59.0, 11.0, 60.0)
		Log(AssertEqual("Geom.HashCode - Same polygon same hash", polyA.HashCode, copy.HashCode))
	Catch
		Log(Fail("Geom.HashCode - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Geom_ToString
	Try
		Dim wkt As String = polyA.ToString
		Log(AssertTrue("Geom.ToString - Contains POLYGON", wkt.StartsWith("POLYGON")))
		Log(AssertTrue("Geom.ToString - Not empty",        wkt.Length > 10))
	Catch
		Log(Fail("Geom.ToString - Exception: " & LastException.Message))
	End Try
End Sub


'##########################################################################
'# JTSTypes  (Point / LineString / Polygon / GeometryCollection /
'#            PrecisionModel / STRtree)
'##########################################################################

Private Sub RunTypesTests
	Log("")
	Log("========================================")
	Log(" JTSTypes Test Suite")
	Log(" (Point / LineString / Polygon /")
	Log("  GeometryCollection / PrecisionModel)")
	Log("========================================")

	Dim passBefore As Int = mPass
	Dim failBefore As Int = mFail

	' --- JTSPoint ---
	Test_Point_GetXY
	Test_Point_GetZ_2D
	Test_Point_GetZ_3D
	Test_Point_IsEmpty_False
	Test_Point_IsEmpty_True
	Test_Point_IsValid
	Test_Point_Distance
	Test_Point_GetCoordinate
	Test_Point_AsGeometry

	' --- JTSLineString ---
	Test_LineString_GetStartEndPoint
	Test_LineString_GetNumPoints
	Test_LineString_GetPointN
	Test_LineString_IsClosed_False
	Test_LineString_IsClosed_True
	Test_LineString_IsRing
	Test_LineString_IsEmpty_False
	Test_LineString_IsValid
	Test_LineString_GetLength
	Test_LineString_GetCoordinates
	Test_LineString_AsGeometry
	Test_LineString_ToString

	' --- JTSPolygon ---
	Test_Polygon_GetExteriorRing
	Test_Polygon_GetNumInteriorRing_NoHoles
	Test_Polygon_GetNumInteriorRing_WithHole
	Test_Polygon_GetInteriorRingN
	Test_Polygon_GetArea
	Test_Polygon_GetLength
	Test_Polygon_IsEmpty_False
	Test_Polygon_IsValid
	Test_Polygon_GetNumPoints
	Test_Polygon_GetCentroid
	Test_Polygon_GetEnvelopeInternal
	Test_Polygon_GetCoordinates
	Test_Polygon_AsGeometry
	Test_Polygon_ToString

	' --- JTSGeometryCollection ---
	Test_Collection_GetNumGeometries
	Test_Collection_GetGeometryN
	Test_Collection_IsEmpty_False
	Test_Collection_IsValid
	Test_Collection_GetArea_MultiPolygon
	Test_Collection_GetLength_MultiLine
	Test_Collection_GetNumPoints
	Test_Collection_GetGeometryType_MultiPoint
	Test_Collection_GetGeometryType_MultiPolygon
	Test_Collection_GetEnvelopeInternal
	Test_Collection_UnionAll
	Test_Collection_AsGeometry
	Test_Collection_ToString

	' --- JTSManager PrecisionModel ---
	Test_PM_IsFloating_Default
	Test_PM_IsFloating_FloatingSingle
	Test_PM_IsFloating_Fixed
	Test_PM_GetScale_Floating
	Test_PM_GetScale_Fixed
	Test_PM_MakePrecise
	Test_PM_MakePrecise2
	Test_PM_MakePrecise2_Preserves_Z
	Test_PM_GetMaximumSignificantDigits_Floating
	Test_PM_GetMaximumSignificantDigits_Fixed
	Test_PM_GetPrecisionModel_RoundTrip_Floating
	Test_PM_GetPrecisionModel_RoundTrip_FloatingSingle
	Test_PM_GetPrecisionModel_RoundTrip_Fixed

	Log("  Suite  PASS: " & (mPass - passBefore) & "   FAIL: " & (mFail - failBefore))
End Sub

'--- JTSPoint ---

Private Sub Test_Point_GetXY
	Try
		Dim pt As JTSPoint = mJts.CreatePoint(10.5, 59.9)
		Log(AssertEqual("Point.GetX", "10.5", pt.GetX))
		Log(AssertEqual("Point.GetY", "59.9", pt.GetY))
	Catch
		Log(Fail("Point.GetXY - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Point_GetZ_2D
	Try
		Dim pt As JTSPoint = mJts.CreatePoint(10.0, 59.0)
		Dim z As Double = pt.GetZ
		Log(AssertTrue("Point.GetZ 2D - Is NaN", z <> z))
	Catch
		Log(Fail("Point.GetZ 2D - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Point_GetZ_3D
	Try
		Dim pt As JTSPoint = mJts.CreatePoint3D(10.0, 59.0, 150.0)
		Log(AssertEqual("Point.GetZ 3D", "150.0", pt.GetZ))
	Catch
		Log(Fail("Point.GetZ 3D - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Point_IsEmpty_False
	Try
		Dim pt As JTSPoint = mJts.CreatePoint(10.0, 59.0)
		Log(AssertTrue("Point.IsEmpty - Not empty", pt.AsGeometry.IsEmpty = False))
	Catch
		Log(Fail("Point.IsEmpty False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Point_IsEmpty_True
	Try
		Dim empty As JTSGeometry = mJts.CreateEmpty
		Dim pt As JTSPoint
		pt.Initialize(empty.GetJavaGeom)
		Log(AssertTrue("Point.IsEmpty - Empty", pt.AsGeometry.IsEmpty))
	Catch
		Log(Fail("Point.IsEmpty True - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Point_IsValid
	Try
		Dim pt As JTSPoint = mJts.CreatePoint(10.0, 59.0)
		Log(AssertTrue("Point.IsValid", pt.AsGeometry.IsValid))
	Catch
		Log(Fail("Point.IsValid - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Point_Distance
	Try
		Dim a As JTSPoint = mJts.CreatePoint(0.0, 0.0)
		Dim b As JTSPoint = mJts.CreatePoint(3.0, 4.0)
		Log(AssertEqual("Point.Distance - 3-4-5", "5.0", a.AsGeometry.Distance(b.AsGeometry)))
		Log(AssertEqual("Point.Distance - Self",  "0.0", a.AsGeometry.Distance(a.AsGeometry)))
	Catch
		Log(Fail("Point.Distance - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Point_GetCoordinate
	Try
		Dim pt As JTSPoint = mJts.CreatePoint(10.5, 59.9)
		Dim c As JTSCoordinate = pt.AsGeometry.GetCoordinate
		Log(AssertEqual("Point.GetCoordinate - X", "10.5", c.GetX))
		Log(AssertEqual("Point.GetCoordinate - Y", "59.9", c.GetY))
	Catch
		Log(Fail("Point.GetCoordinate - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Point_AsGeometry
	Try
		Dim pt As JTSPoint = mJts.CreatePoint(10.0, 59.0)
		Dim g As JTSGeometry = pt.AsGeometry
		Log(AssertEqual("Point.AsGeometry - Type", "Point", g.GetGeometryType))
		Log(AssertTrue ("Point.AsGeometry - IsValid",        g.IsValid))
	Catch
		Log(Fail("Point.AsGeometry - Exception: " & LastException.Message))
	End Try
End Sub

'--- JTSLineString ---

Private Sub Test_LineString_GetStartEndPoint
	Try
		Dim ls As JTSLineString = BuildLineStr(10.0, 59.0, 11.0, 60.0)
		Log(AssertEqual("LineString.GetStartPoint - X", "10.0", ls.GetStartPoint.GetX))
		Log(AssertEqual("LineString.GetStartPoint - Y", "59.0", ls.GetStartPoint.GetY))
		Log(AssertEqual("LineString.GetEndPoint   - X", "11.0", ls.GetEndPoint.GetX))
		Log(AssertEqual("LineString.GetEndPoint   - Y", "60.0", ls.GetEndPoint.GetY))
	Catch
		Log(Fail("LineString.GetStartEndPoint - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_GetNumPoints
	Try
		Dim coords As List = BuildCoords(Array As Double(10.0, 59.0, 10.5, 59.5, 11.0, 60.0))
		Dim ls As JTSLineString = mJts.CreateLineString(coords)
		Log(AssertEqual("LineString.GetNumPoints", "3", ls.AsGeometry.GetNumPoints))
	Catch
		Log(Fail("LineString.GetNumPoints - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_GetPointN
	Try
		Dim coords As List = BuildCoords(Array As Double(10.0, 59.0, 10.5, 59.5, 11.0, 60.0))
		Dim ls As JTSLineString = mJts.CreateLineString(coords)
		Dim mid As JTSPoint = ls.GetPointN(1)
		Log(AssertEqual("LineString.GetPointN(1) - X", "10.5", mid.GetX))
		Log(AssertEqual("LineString.GetPointN(1) - Y", "59.5", mid.GetY))
	Catch
		Log(Fail("LineString.GetPointN - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_IsClosed_False
	Try
		Dim ls As JTSLineString = BuildLineStr(10.0, 59.0, 11.0, 60.0)
		Log(AssertTrue("LineString.IsClosed - Open line", ls.IsClosed = False))
	Catch
		Log(Fail("LineString.IsClosed False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_IsClosed_True
	Try
		Dim coords As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim ls As JTSLineString = mJts.CreateLineString(coords)
		Log(AssertTrue("LineString.IsClosed - Closed ring", ls.IsClosed))
	Catch
		Log(Fail("LineString.IsClosed True - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_IsRing
	Try
		Dim coords As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim ls As JTSLineString = mJts.CreateLineString(coords)
		Log(AssertTrue("LineString.IsRing - Closed simple LS is ring", ls.IsRing))
	Catch
		Log(Fail("LineString.IsRing - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_IsEmpty_False
	Try
		Dim ls As JTSLineString = BuildLineStr(10.0, 59.0, 11.0, 60.0)
		Log(AssertTrue("LineString.IsEmpty - Not empty", ls.AsGeometry.IsEmpty = False))
	Catch
		Log(Fail("LineString.IsEmpty False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_IsValid
	Try
		Dim ls As JTSLineString = BuildLineStr(10.0, 59.0, 11.0, 60.0)
		Log(AssertTrue("LineString.IsValid", ls.AsGeometry.IsValid))
	Catch
		Log(Fail("LineString.IsValid - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_GetLength
	Try
		Dim ls As JTSLineString = BuildLineStr(10.0, 59.0, 13.0, 59.0)
		Log(AssertEqual("LineString.GetLength - 3 units", "3.0", ls.AsGeometry.GetLength))
	Catch
		Log(Fail("LineString.GetLength - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_GetCoordinates
	Try
		Dim coords As List = BuildCoords(Array As Double(10.0, 59.0, 11.0, 60.0))
		Dim ls As JTSLineString = mJts.CreateLineString(coords)
		Dim result As List = ls.AsGeometry.GetCoordinates
		Log(AssertEqual("LineString.GetCoordinates - Count", "2", result.Size))
		Dim first As JTSCoordinate = result.Get(0)
		Log(AssertEqual("LineString.GetCoordinates - First X", "10.0", first.GetX))
	Catch
		Log(Fail("LineString.GetCoordinates - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_AsGeometry
	Try
		Dim ls As JTSLineString = BuildLineStr(10.0, 59.0, 11.0, 60.0)
		Dim g As JTSGeometry = ls.AsGeometry
		Log(AssertEqual("LineString.AsGeometry - Type", "LineString", g.GetGeometryType))
		Log(AssertTrue ("LineString.AsGeometry - IsValid",            g.IsValid))
	Catch
		Log(Fail("LineString.AsGeometry - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_LineString_ToString
	Try
		Dim ls As JTSLineString = BuildLineStr(10.0, 59.0, 11.0, 60.0)
		Dim s As String = ls.AsGeometry.ToString
		Log(AssertTrue("LineString.ToString - Contains LINESTRING", s.StartsWith("LINESTRING")))
	Catch
		Log(Fail("LineString.ToString - Exception: " & LastException.Message))
	End Try
End Sub

'--- JTSPolygon ---

Private Sub Test_Polygon_GetExteriorRing
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Dim ring As JTSLineString = poly.GetExteriorRing
		Log(AssertEqual("Polygon.GetExteriorRing - Type", "LinearRing", ring.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Polygon.GetExteriorRing - IsClosed",             ring.IsClosed))
		Log(AssertTrue ("Polygon.GetExteriorRing - NumPoints > 0",        ring.AsGeometry.GetNumPoints > 0))

	Catch
		Log(Fail("Polygon.GetExteriorRing - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetNumInteriorRing_NoHoles
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Log(AssertEqual("Polygon.GetNumInteriorRing - No holes", "0", poly.GetNumInteriorRing))
	Catch
		Log(Fail("Polygon.GetNumInteriorRing NoHoles - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetNumInteriorRing_WithHole
	Try
		Dim shell As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim hole  As List = BuildRingCoords(10.2, 59.2, 10.8, 59.8)
		Dim holes As List
		holes.Initialize
		holes.Add(hole)
		Dim poly As JTSPolygon = mJts.CreatePolygonWithHoles(shell, holes)
		Log(AssertEqual("Polygon.GetNumInteriorRing - 1 hole", "1", poly.GetNumInteriorRing))
	Catch
		Log(Fail("Polygon.GetNumInteriorRing WithHole - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetInteriorRingN
	Try
		Dim shell As List = BuildRingCoords(10.0, 59.0, 11.0, 60.0)
		Dim hole  As List = BuildRingCoords(10.2, 59.2, 10.8, 59.8)
		Dim holes As List
		holes.Initialize
		holes.Add(hole)
		Dim poly As JTSPolygon = mJts.CreatePolygonWithHoles(shell, holes)
		Dim holeRing As JTSLineString = poly.GetInteriorRingN(0)
		Log(AssertEqual("Polygon.GetInteriorRingN - Type", "LinearRing", holeRing.AsGeometry.GetGeometryType))
		Log(AssertTrue ("Polygon.GetInteriorRingN - IsClosed",             holeRing.IsClosed))

	Catch
		Log(Fail("Polygon.GetInteriorRingN - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetArea
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Log(AssertEqual("Polygon.GetArea - 1x1 = 1.0", "1.0", poly.AsGeometry.GetArea))
	Catch
		Log(Fail("Polygon.GetArea - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetLength
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Log(AssertEqual("Polygon.GetLength - Perimeter 4.0", "4.0", poly.AsGeometry.GetLength))
	Catch
		Log(Fail("Polygon.GetLength - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_IsEmpty_False
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Log(AssertTrue("Polygon.IsEmpty - Not empty", poly.AsGeometry.IsEmpty = False))
	Catch
		Log(Fail("Polygon.IsEmpty False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_IsValid
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Log(AssertTrue("Polygon.IsValid", poly.AsGeometry.IsValid))
	Catch
		Log(Fail("Polygon.IsValid - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetNumPoints
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Log(AssertEqual("Polygon.GetNumPoints - 5", "5", poly.AsGeometry.GetNumPoints))
	Catch
		Log(Fail("Polygon.GetNumPoints - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetCentroid
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 12.0, 61.0)
		Dim cen As JTSPoint = poly.AsGeometry.GetCentroid
		Log(AssertEqual("Polygon.GetCentroid - X", "11.0", cen.GetX))
		Log(AssertEqual("Polygon.GetCentroid - Y", "60.0", cen.GetY))
	Catch
		Log(Fail("Polygon.GetCentroid - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetEnvelopeInternal
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Dim env As JTSEnvelope = poly.AsGeometry.GetEnvelopeInternal
		Log(AssertEqual("Polygon.GetEnvelope - MinX", "10.0", env.GetMinX))
		Log(AssertEqual("Polygon.GetEnvelope - MaxX", "11.0", env.GetMaxX))
		Log(AssertEqual("Polygon.GetEnvelope - MinY", "59.0", env.GetMinY))
		Log(AssertEqual("Polygon.GetEnvelope - MaxY", "60.0", env.GetMaxY))
	Catch
		Log(Fail("Polygon.GetEnvelopeInternal - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_GetCoordinates
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Dim coords As List = poly.AsGeometry.GetCoordinates
		Log(AssertEqual("Polygon.GetCoordinates - Count", "5", coords.Size))
		Dim first As JTSCoordinate = coords.Get(0)
		Log(AssertEqual("Polygon.GetCoordinates - First X", "10.0", first.GetX))
	Catch
		Log(Fail("Polygon.GetCoordinates - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_AsGeometry
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Dim g As JTSGeometry = poly.AsGeometry
		Log(AssertEqual("Polygon.AsGeometry - Type", "Polygon", g.GetGeometryType))
		Log(AssertTrue ("Polygon.AsGeometry - IsValid",          g.IsValid))
	Catch
		Log(Fail("Polygon.AsGeometry - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Polygon_ToString
	Try
		Dim poly As JTSPolygon = BuildPolygonTyped(10.0, 59.0, 11.0, 60.0)
		Dim s As String = poly.AsGeometry.ToString
		Log(AssertTrue("Polygon.ToString - Contains POLYGON", s.StartsWith("POLYGON")))
	Catch
		Log(Fail("Polygon.ToString - Exception: " & LastException.Message))
	End Try
End Sub

'--- JTSGeometryCollection ---

Private Sub Test_Collection_GetNumGeometries
	Try
		Dim col As JTSGeometry = BuildMultiPoint(3)
		Log(AssertEqual("Collection.GetNumGeometries - 3", "3", col.GetNumGeometries))
	Catch
		Log(Fail("Collection.GetNumGeometries - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_GetGeometryN
	Try
		Dim col As JTSGeometry = BuildMultiPoint(3)
		Dim g As JTSGeometry = col.GetGeometryN(0)
		Log(AssertEqual("Collection.GetGeometryN(0) - Type", "Point", g.GetGeometryType))
	Catch
		Log(Fail("Collection.GetGeometryN - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_IsEmpty_False
	Try
		Dim col As JTSGeometry = BuildMultiPoint(2)
		Log(AssertTrue("Collection.IsEmpty - Not empty", col.IsEmpty = False))
	Catch
		Log(Fail("Collection.IsEmpty False - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_IsValid
	Try
		Dim col As JTSGeometry = BuildMultiPoint(2)
		Log(AssertTrue("Collection.IsValid", col.IsValid))
	Catch
		Log(Fail("Collection.IsValid - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_GetArea_MultiPolygon
	Try
		Dim polys As List
		polys.Initialize
		polys.Add(BuildPolygonTyped(10.0, 59.0, 11.0, 60.0))
		polys.Add(BuildPolygonTyped(12.0, 59.0, 13.0, 60.0))
		Dim col As JTSGeometry = mJts.CreateMultiPolygon(polys)
		Log(AssertEqual("Collection.GetArea - 2 polygons", "2.0", col.GetArea))
	Catch
		Log(Fail("Collection.GetArea - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_GetLength_MultiLine
	Try
		Dim lines As List
		lines.Initialize
		lines.Add(mJts.CreateLineString(BuildCoords(Array As Double(10.0, 59.0, 13.0, 59.0))))
		lines.Add(mJts.CreateLineString(BuildCoords(Array As Double(10.0, 60.0, 12.0, 60.0))))
		Dim col As JTSGeometry = mJts.CreateMultiLineString(lines)
		Log(AssertEqual("Collection.GetLength - 5.0", "5.0", col.GetLength))
	Catch
		Log(Fail("Collection.GetLength - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_GetNumPoints
	Try
		Dim col As JTSGeometry = BuildMultiPoint(4)
		Log(AssertEqual("Collection.GetNumPoints - 4", "4", col.GetNumPoints))
	Catch
		Log(Fail("Collection.GetNumPoints - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_GetGeometryType_MultiPoint
	Try
		Dim col As JTSGeometry = BuildMultiPoint(2)
		Log(AssertEqual("Collection.GetGeometryType - MultiPoint", "MultiPoint", col.GetGeometryType))
	Catch
		Log(Fail("Collection.GetGeometryType MultiPoint - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_GetGeometryType_MultiPolygon
	Try
		Dim polys As List
		polys.Initialize
		polys.Add(BuildPolygonTyped(10.0, 59.0, 11.0, 60.0))
		polys.Add(BuildPolygonTyped(12.0, 59.0, 13.0, 60.0))
		Dim col As JTSGeometry = mJts.CreateMultiPolygon(polys)
		Log(AssertEqual("Collection.GetGeometryType - MultiPolygon", "MultiPolygon", col.GetGeometryType))
	Catch
		Log(Fail("Collection.GetGeometryType MultiPolygon - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_GetEnvelopeInternal
	Try
		Dim polys As List
		polys.Initialize
		polys.Add(BuildPolygonTyped(10.0, 59.0, 11.0, 60.0))
		polys.Add(BuildPolygonTyped(12.0, 59.0, 13.0, 60.0))
		Dim col As JTSGeometry = mJts.CreateMultiPolygon(polys)
		Dim env As JTSEnvelope = col.GetEnvelopeInternal
		Log(AssertEqual("Collection.Envelope - MinX", "10.0", env.GetMinX))
		Log(AssertEqual("Collection.Envelope - MaxX", "13.0", env.GetMaxX))
	Catch
		Log(Fail("Collection.GetEnvelopeInternal - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_UnionAll
	Try
		Dim polys As List
		polys.Initialize
		polys.Add(BuildPolygonTyped(10.0, 59.0, 11.0, 60.0))
		polys.Add(BuildPolygonTyped(11.0, 59.0, 12.0, 60.0))
		Dim col As JTSGeometry = mJts.CreateMultiPolygon(polys)
		Dim merged As JTSGeometry = col.UnionAll
		Log(AssertTrue("Collection.UnionAll - IsValid",   merged.IsValid))
		Log(AssertTrue("Collection.UnionAll - Area >= 2", merged.GetArea >= 1.9))
	Catch
		Log(Fail("Collection.UnionAll - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_AsGeometry
	Try
		Dim col As JTSGeometry = BuildMultiPoint(2)
		Dim g As JTSGeometry = col
		Log(AssertEqual("Collection.AsGeometry - Type", "MultiPoint", g.GetGeometryType))
		Log(AssertTrue ("Collection.AsGeometry - IsValid",            g.IsValid))
	Catch
		Log(Fail("Collection.AsGeometry - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Collection_ToString
	Try
		Dim col As JTSGeometry = BuildMultiPoint(2)
		Dim s As String = col.ToString
		Log(AssertTrue("Collection.ToString - Contains MULTIPOINT", s.StartsWith("MULTIPOINT")))
	Catch
		Log(Fail("Collection.ToString - Exception: " & LastException.Message))
	End Try
End Sub

'--- JTSManager PrecisionModel ---

Private Sub Test_PM_IsFloating_Default
	Try
		Dim mgr As JTSManager
		mgr.Initialize("FLOATING", 0)
		Log(AssertTrue("PrecisionModel.IsFloating - Floating", mgr.IsFloating))
	Catch
		Log(Fail("PM.IsFloating Default - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_IsFloating_FloatingSingle
	Try
		Dim mgr As JTSManager
		mgr.Initialize("FLOATING_SINGLE", 0)
		Log(AssertTrue("PrecisionModel.IsFloating - FloatingSingle", mgr.IsFloating))
	Catch
		Log(Fail("PM.IsFloating FloatingSingle - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_IsFloating_Fixed
	Try
		Dim mgr As JTSManager
		mgr.Initialize("1000", 0)
		Log(AssertTrue("PrecisionModel.IsFloating - Fixed is False", mgr.IsFloating = False))
	Catch
		Log(Fail("PM.IsFloating Fixed - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_GetScale_Floating
	Try
		Dim mgr As JTSManager
		mgr.Initialize("FLOATING", 0)
		Log(AssertEqual("PrecisionModel.GetScale - Floating = 0", "0.0", mgr.GetScale))
	Catch
		Log(Fail("PM.GetScale Floating - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_GetScale_Fixed
	Try
		Dim mgr As JTSManager
		mgr.Initialize("1000", 0)
		Log(AssertEqual("PrecisionModel.GetScale - Fixed 1000", "1000.0", mgr.GetScale))
	Catch
		Log(Fail("PM.GetScale Fixed - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_MakePrecise
	Try
		Dim mgr As JTSManager
		mgr.Initialize("10", 0)
		Dim rounded As Double = mgr.MakePrecise(1.15)
		Log(AssertTrue("PrecisionModel.MakePrecise - 1.15 -> 1.1 or 1.2", rounded = 1.1 Or rounded = 1.2))
	Catch
		Log(Fail("PM.MakePrecise - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_MakePrecise2
	' MakePrecise2 mutates the coordinate in-place. Verify X and Y are rounded.
	Try
		Dim mgr As JTSManager
		mgr.Initialize("1000", 0)   ' 3 decimal places
		Dim c As JTSCoordinate = mgr.CreateCoordinate(1.23456, 9.87654)
		mgr.MakePrecise2(c)
		Log(AssertEqual("PrecisionModel.MakePrecise2 - X rounded to 3 decimals", "1.235", c.GetX))
		Log(AssertEqual("PrecisionModel.MakePrecise2 - Y rounded to 3 decimals", "9.877", c.GetY))
	Catch
		Log(Fail("PM.MakePrecise2 - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_MakePrecise2_Preserves_Z
	' JTS PrecisionModel.makePrecise(Coordinate) only touches X and Y - Z must stay.
	Try
		Dim mgr As JTSManager
		mgr.Initialize("1000", 0)
		Dim c As JTSCoordinate = mgr.CreateCoordinate3D(1.23456, 9.87654, 42.99999)
		mgr.MakePrecise2(c)
		Log(AssertEqual("PrecisionModel.MakePrecise2 - X rounded",   "1.235",   c.GetX))
		Log(AssertEqual("PrecisionModel.MakePrecise2 - Y rounded",   "9.877",   c.GetY))
		Log(AssertEqual("PrecisionModel.MakePrecise2 - Z preserved", "42.99999", c.GetZ))
	Catch
		Log(Fail("PM.MakePrecise2 Preserves Z - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_GetMaximumSignificantDigits_Floating
	Try
		Dim mgr As JTSManager
		mgr.Initialize("FLOATING", 0)
		Log(AssertTrue("PrecisionModel.MaxDigits - Floating >= 16", mgr.GetMaximumSignificantDigits >= 16))
	Catch
		Log(Fail("PM.GetMaximumSignificantDigits Floating - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_GetMaximumSignificantDigits_Fixed
	Try
		Dim mgr As JTSManager
		mgr.Initialize("100", 0)
		Dim digits As Int = mgr.GetMaximumSignificantDigits
		Log(AssertTrue("PrecisionModel.MaxDigits - Fixed scale=100", digits >= 1 And digits < 16))
	Catch
		Log(Fail("PM.GetMaximumSignificantDigits Fixed - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_GetPrecisionModel_RoundTrip_Floating
	' GetPrecisionModel must return the exact pm string passed to Initialize.
	Try
		Dim mgr As JTSManager
		mgr.Initialize("FLOATING", 0)
		Log(AssertEqual("PrecisionModel.GetPrecisionModel - Floating", "FLOATING", mgr.GetPrecisionModel))
		' And the returned string must be usable to construct an equivalent manager.
		Dim mgr2 As JTSManager
		mgr2.Initialize(mgr.GetPrecisionModel, 0)
		Log(AssertTrue("PrecisionModel.GetPrecisionModel - Round-trip Floating IsFloating", mgr2.IsFloating))
	Catch
		Log(Fail("PM.GetPrecisionModel RoundTrip Floating - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_GetPrecisionModel_RoundTrip_FloatingSingle
	Try
		Dim mgr As JTSManager
		mgr.Initialize("FLOATING_SINGLE", 0)
		Log(AssertEqual("PrecisionModel.GetPrecisionModel - FloatingSingle", "FLOATING_SINGLE", mgr.GetPrecisionModel))
		Dim mgr2 As JTSManager
		mgr2.Initialize(mgr.GetPrecisionModel, 0)
		Log(AssertTrue("PrecisionModel.GetPrecisionModel - Round-trip FloatingSingle IsFloating", mgr2.IsFloating))
	Catch
		Log(Fail("PM.GetPrecisionModel RoundTrip FloatingSingle - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_PM_GetPrecisionModel_RoundTrip_Fixed
	Try
		Dim mgr As JTSManager
		mgr.Initialize("1000", 0)
		Log(AssertEqual("PrecisionModel.GetPrecisionModel - Fixed 1000", "1000", mgr.GetPrecisionModel))
		Dim mgr2 As JTSManager
		mgr2.Initialize(mgr.GetPrecisionModel, 0)
		Log(AssertEqual("PrecisionModel.GetPrecisionModel - Round-trip Fixed GetScale", "1000.0", mgr2.GetScale))
	Catch
		Log(Fail("PM.GetPrecisionModel RoundTrip Fixed - Exception: " & LastException.Message))
	End Try
End Sub

'--- JTSSTRtree ---

'##########################################################################
'# JTSSTRtree
'##########################################################################

Private Sub RunSTRtreeTests
	Log("")
	Log("========================================")
	Log(" JTSSTRtree Test Suite")
	Log("========================================")

	Dim passBefore As Int = mPass
	Dim failBefore As Int = mFail

	Test_STR_Initialize
	Test_STR_IsEmpty_AfterInit
	Test_STR_InsertAndSize
	Test_STR_BuildMakesNotEmpty
	Test_STR_QueryHit
	Test_STR_QueryMiss
	Test_STR_QueryPartialOverlap
	Test_STR_QueryMultipleHits
	Test_STR_QueryReturnsStringPayload
	Test_STR_QueryReturnsMixedPayloads
	Test_STR_RemoveKnownElement
	Test_STR_RemoveReducesSize
	Test_STR_QueryAfterRemove
	Test_STR_QueryEmptyTree
	Test_STR_SingleNodeCapacity
	Test_STR_LargeInsert
	Test_STR_TouchingEnvelopes
	Test_STR_PointEnvelope
	Test_STR_Build_IsIdempotent
	Test_STR_QueryContainedEnvelope
	Test_STR_QueryExactEnvelope
	Test_STR_InsertSameEnvelopeTwice
	Test_STR_QueryReturnsAllOnFullOverlap

	Log("  Suite  PASS: " & (mPass - passBefore) & "   FAIL: " & (mFail - failBefore))
End Sub

' Kan initialisera utan unntak
Private Sub Test_STR_Initialize
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Log(Pass("STRtree.Initialize - No exception"))
	Catch
		Log(Fail("STRtree.Initialize - Exception: " & LastException.Message))
	End Try
End Sub

' Nytt tre er tomt
Private Sub Test_STR_IsEmpty_AfterInit
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Log(AssertTrue ("STRtree.IsEmpty after init", tree.IsEmpty))
		Log(AssertEqual("STRtree.GetSize after init", "0", tree.GetSize))
	Catch
		Log(Fail("STRtree.IsEmpty AfterInit - Exception: " & LastException.Message))
	End Try
End Sub

' Insert aukar storleiken
Private Sub Test_STR_InsertAndSize
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		tree.Insert(mJts.CreateEnvelope(12.0, 13.0, 59.0, 60.0), "B")
		Log(AssertEqual("STRtree.InsertAndSize - GetSize after 2 inserts", "2", tree.GetSize))
	Catch
		Log(Fail("STRtree.InsertAndSize - Exception: " & LastException.Message))
	End Try
End Sub

' Build tømer ikkje treet
Private Sub Test_STR_BuildMakesNotEmpty
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		tree.Build
		Log(AssertTrue ("STRtree.BuildMakesNotEmpty - IsEmpty = False", tree.IsEmpty = False))
		Log(AssertEqual("STRtree.BuildMakesNotEmpty - GetSize", "1", tree.GetSize))
	Catch
		Log(Fail("STRtree.BuildMakesNotEmpty - Exception: " & LastException.Message))
	End Try
End Sub

' Query som treffer
Private Sub Test_STR_QueryHit
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		Dim result As List = tree.Query(mJts.CreateEnvelope(10.5, 10.8, 59.5, 59.8))
		Log(AssertEqual("STRtree.QueryHit - size", "1", result.Size))
	Catch
		Log(Fail("STRtree.QueryHit - Exception: " & LastException.Message))
	End Try
End Sub

' Query utan treff
Private Sub Test_STR_QueryMiss
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		Dim result As List = tree.Query(mJts.CreateEnvelope(20.0, 21.0, 70.0, 71.0))
		Log(AssertEqual("STRtree.QueryMiss - size", "0", result.Size))
	Catch
		Log(Fail("STRtree.QueryMiss - Exception: " & LastException.Message))
	End Try
End Sub

' Query med delvis overlapp treffer
Private Sub Test_STR_QueryPartialOverlap
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		' Envelope A: x=[10,11], y=[59,60]
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		' Søk som overlapper berre delvis med A sin envelope
		Dim result As List = tree.Query(mJts.CreateEnvelope(10.5, 12.0, 59.5, 61.0))
		Log(AssertEqual("STRtree.QueryPartialOverlap - size", "1", result.Size))
	Catch
		Log(Fail("STRtree.QueryPartialOverlap - Exception: " & LastException.Message))
	End Try
End Sub

' Query returnerer fleire treff
Private Sub Test_STR_QueryMultipleHits
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		tree.Insert(mJts.CreateEnvelope(10.2, 10.8, 59.2, 59.8), "B")
		tree.Insert(mJts.CreateEnvelope(20.0, 21.0, 70.0, 71.0), "C")
		' Søk som treffer A og B, men ikkje C
		Dim result As List = tree.Query(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0))
		Log(AssertEqual("STRtree.QueryMultipleHits - size", "2", result.Size))
	Catch
		Log(Fail("STRtree.QueryMultipleHits - Exception: " & LastException.Message))
	End Try
End Sub

' Payload kjem korrekt tilbake som String
Private Sub Test_STR_QueryReturnsStringPayload
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim env As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		tree.Insert(env, "MyLabel")
		Dim result As List = tree.Query(env)
		Log(AssertEqual("STRtree.QueryReturnsStringPayload - value", "MyLabel", result.Get(0)))
	Catch
		Log(Fail("STRtree.QueryReturnsStringPayload - Exception: " & LastException.Message))
	End Try
End Sub

' Kan lagra ulike payload-typar (String og Int)
Private Sub Test_STR_QueryReturnsMixedPayloads
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim envA As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Dim envB As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		tree.Insert(envA, "StringPayload")
		tree.Insert(envB, 42)
		Dim result As List = tree.Query(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0))
		Log(AssertEqual("STRtree.QueryReturnsMixedPayloads - size", "2", result.Size))
	Catch
		Log(Fail("STRtree.QueryReturnsMixedPayloads - Exception: " & LastException.Message))
	End Try
End Sub

' Remove returnerer True for kjent element
Private Sub Test_STR_RemoveKnownElement
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim env As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		tree.Insert(env, "A")
		Dim removed As Boolean = tree.Remove(env, "A")
		Log(AssertTrue("STRtree.RemoveKnownElement - returns True", removed))
	Catch
		Log(Fail("STRtree.RemoveKnownElement - Exception: " & LastException.Message))
	End Try
End Sub

' Remove reduserer GetSize
Private Sub Test_STR_RemoveReducesSize
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim env As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		tree.Insert(env, "A")
		tree.Insert(mJts.CreateEnvelope(12.0, 13.0, 59.0, 60.0), "B")
		tree.Remove(env, "A")
		Log(AssertEqual("STRtree.RemoveReducesSize - size after remove", "1", tree.GetSize))
	Catch
		Log(Fail("STRtree.RemoveReducesSize - Exception: " & LastException.Message))
	End Try
End Sub

' Query returnerer 0 etter remove av einaste elementet
Private Sub Test_STR_QueryAfterRemove
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim env As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		tree.Insert(env, "A")
		tree.Remove(env, "A")
		Dim result As List = tree.Query(env)
		Log(AssertEqual("STRtree.QueryAfterRemove - size", "0", result.Size))
	Catch
		Log(Fail("STRtree.QueryAfterRemove - Exception: " & LastException.Message))
	End Try
End Sub

' Query på tomt tre gjev tom liste
Private Sub Test_STR_QueryEmptyTree
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim result As List = tree.Query(mJts.CreateEnvelope(0.0, 100.0, 0.0, 100.0))
		Log(AssertEqual("STRtree.QueryEmptyTree - size", "0", result.Size))
	Catch
		Log(Fail("STRtree.QueryEmptyTree - Exception: " & LastException.Message))
	End Try
End Sub

' nodeCapacity=2 fungerer (lågaste lovlege verdi - JTS krev > 1)
Private Sub Test_STR_SingleNodeCapacity
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(2)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		tree.Insert(mJts.CreateEnvelope(12.0, 13.0, 61.0, 62.0), "B")
		Dim result As List = tree.Query(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0))
		Log(AssertEqual("STRtree.SingleNodeCapacity - hit A", "1", result.Size))
	Catch
		Log(Fail("STRtree.SingleNodeCapacity - Exception: " & LastException.Message))
	End Try
End Sub

' 500 element - storleik og query fungerer
Private Sub Test_STR_LargeInsert
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim i As Int
		For i = 0 To 499
			Dim x As Double = i Mod 50
			Dim y As Double = i / 50
			tree.Insert(mJts.CreateEnvelope(x, x + 1.0, y, y + 1.0), i)
		Next
		Log(AssertEqual("STRtree.LargeInsert - GetSize", "500", tree.GetSize))
		' Søk midt i - skal gje minst eitt treff
		Dim hits As List = tree.Query(mJts.CreateEnvelope(24.5, 25.5, 4.5, 5.5))
		Log(AssertTrue("STRtree.LargeInsert - Query hits > 0", hits.Size > 0))
	Catch
		Log(Fail("STRtree.LargeInsert - Exception: " & LastException.Message))
	End Try
End Sub

' Nærliggande/kantande envelope-ar treffer rett
Private Sub Test_STR_TouchingEnvelopes
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		' A: x=[10,11], B: x=[11,12] - kantane rører kvarandre
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		tree.Insert(mJts.CreateEnvelope(11.0, 12.0, 59.0, 60.0), "B")
		' Søk berre innanfor A sin region
		Dim hitA As List = tree.Query(mJts.CreateEnvelope(10.0, 10.9, 59.0, 60.0))
		Log(AssertEqual("STRtree.TouchingEnvelopes - only A hit", "1", hitA.Size))
	Catch
		Log(Fail("STRtree.TouchingEnvelopes - Exception: " & LastException.Message))
	End Try
End Sub

' Punkt-envelope (zero-area) kan inserta og finnast
Private Sub Test_STR_PointEnvelope
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		' Punkt-envelope: minX=maxX, minY=maxY
		tree.Insert(mJts.CreateEnvelope(10.5, 10.5, 59.5, 59.5), "Pt")
		' Søk med ein boks rundt punktet
		Dim result As List = tree.Query(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0))
		Log(AssertEqual("STRtree.PointEnvelope - found", "1", result.Size))
	Catch
		Log(Fail("STRtree.PointEnvelope - Exception: " & LastException.Message))
	End Try
End Sub

' Build fleire gonger kastar ikkje unntak (idempotent)
Private Sub Test_STR_Build_IsIdempotent
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		tree.Build
		tree.Build   ' andre kall skal ikkje kasta unntak
		Log(Pass("STRtree.Build IsIdempotent - No exception on double Build"))
	Catch
		Log(Fail("STRtree.Build IsIdempotent - Exception: " & LastException.Message))
	End Try
End Sub

' Søk-envelope heilt inni ein insertert envelope - treffer
Private Sub Test_STR_QueryContainedEnvelope
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "Outer")
		' Søk heilt innanfor "Outer"
		Dim result As List = tree.Query(mJts.CreateEnvelope(10.2, 10.8, 59.2, 59.8))
		Log(AssertEqual("STRtree.QueryContainedEnvelope - hit", "1", result.Size))
	Catch
		Log(Fail("STRtree.QueryContainedEnvelope - Exception: " & LastException.Message))
	End Try
End Sub

' Query med nøyaktig same envelope som insert - treffer
Private Sub Test_STR_QueryExactEnvelope
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim env As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		tree.Insert(env, "Exact")
		Dim result As List = tree.Query(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0))
		Log(AssertEqual("STRtree.QueryExactEnvelope - hit", "1", result.Size))
	Catch
		Log(Fail("STRtree.QueryExactEnvelope - Exception: " & LastException.Message))
	End Try
End Sub

' Same envelope to gonger - begge kjem i søkeresultatet
Private Sub Test_STR_InsertSameEnvelopeTwice
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		Dim env As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		tree.Insert(env, "First")
		tree.Insert(env, "Second")
		Dim result As List = tree.Query(env)
		Log(AssertEqual("STRtree.InsertSameEnvelopeTwice - size", "2", result.Size))
	Catch
		Log(Fail("STRtree.InsertSameEnvelopeTwice - Exception: " & LastException.Message))
	End Try
End Sub

' Søk som dekkjer alle inserterte envelope-ar - alle kjem tilbake
Private Sub Test_STR_QueryReturnsAllOnFullOverlap
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		tree.Insert(mJts.CreateEnvelope(12.0, 13.0, 61.0, 62.0), "B")
		tree.Insert(mJts.CreateEnvelope(14.0, 15.0, 63.0, 64.0), "C")
		' Søk som inneheld alle tre
		Dim result As List = tree.Query(mJts.CreateEnvelope(9.0, 16.0, 58.0, 65.0))
		Log(AssertEqual("STRtree.QueryReturnsAllOnFullOverlap - size", "3", result.Size))
	Catch
		Log(Fail("STRtree.QueryReturnsAllOnFullOverlap - Exception: " & LastException.Message))
	End Try
End Sub


'##########################################################################
'# JTSNegative
'##########################################################################

Private Sub RunNegativeTests
	Log("")
	Log("========================================")
	Log(" JTSNegative Test Suite")
	Log(" (wrapper level - invalid input)")
	Log("========================================")

	Dim passBefore As Int = mPass
	Dim failBefore As Int = mFail

	Test_Neg_CreateLineString_OnePoint
	Test_Neg_CreateLinearRing_NotClosed
	Test_Neg_CreatePolygon_NotClosed
	Test_Neg_CreatePolygon_SelfIntersecting
	Test_Neg_FromWKT_InvalidSyntax
	Test_Neg_FromWKT_EmptyString
	Test_Neg_FromWKB_InvalidBytes
	Test_Neg_Buffer_NegativeDistance
	Test_Neg_GetPointN_OutOfBounds
	Test_Neg_GetGeometryN_OutOfBounds
	Test_Neg_GetInteriorRingN_NoHoles
	Test_Neg_STRtree_QueryAfterBuild_Insert
	Test_Neg_STRtree_Remove_NotInserted
	Test_Neg_STRtree_ZeroNodeCapacity
	Test_Neg_STRtree_OneNodeCapacity

	Log("  Suite  PASS: " & (mPass - passBefore) & "   FAIL: " & (mFail - failBefore))
End Sub

Private Sub Test_Neg_CreateLineString_OnePoint
	Dim coords As List
	coords.Initialize
	coords.Add(mJts.CreateCoordinate(10.0, 59.0))
	Try
		Dim ls As JTSLineString = mJts.CreateLineString(coords)
		Log(Fail($"Neg.CreateLineString OnePoint - Expected exception, got none (isValid=${ls.AsGeometry.IsValid})"$))
	Catch
		Log(Pass("Neg.CreateLineString OnePoint - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_CreateLinearRing_NotClosed
	Dim coords As List
	coords.Initialize
	coords.Add(mJts.CreateCoordinate(10.0, 59.0))
	coords.Add(mJts.CreateCoordinate(11.0, 59.0))
	coords.Add(mJts.CreateCoordinate(11.0, 60.0))
	coords.Add(mJts.CreateCoordinate(10.0, 60.0))
	Try
		mJts.CreateLinearRing(coords)
		Log(Fail("Neg.CreateLinearRing NotClosed - Expected exception, got none"))
	Catch
		Log(Pass("Neg.CreateLinearRing NotClosed - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_CreatePolygon_NotClosed
	Dim coords As List
	coords.Initialize
	coords.Add(mJts.CreateCoordinate(10.0, 59.0))
	coords.Add(mJts.CreateCoordinate(11.0, 59.0))
	coords.Add(mJts.CreateCoordinate(11.0, 60.0))
	coords.Add(mJts.CreateCoordinate(10.0, 60.0))
	Try
		Dim poly As JTSPolygon = mJts.CreatePolygon(coords)
		Log(Fail($"Neg.CreatePolygon NotClosed - Expected exception, got none (isValid=${poly.AsGeometry.IsValid})"$))
	Catch
		Log(Pass("Neg.CreatePolygon NotClosed - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_CreatePolygon_SelfIntersecting
	Try
		Dim coords As List
		coords.Initialize
		coords.Add(mJts.CreateCoordinate(10.0, 59.0))
		coords.Add(mJts.CreateCoordinate(11.0, 60.0))
		coords.Add(mJts.CreateCoordinate(11.0, 59.0))
		coords.Add(mJts.CreateCoordinate(10.0, 60.0))
		coords.Add(mJts.CreateCoordinate(10.0, 59.0))
		Dim poly As JTSPolygon = mJts.CreatePolygon(coords)
		Log(AssertTrue("Neg.CreatePolygon SelfIntersecting - IsValid er False", poly.AsGeometry.IsValid = False))
	Catch
		Log(Fail("Neg.CreatePolygon SelfIntersecting - Unexpected exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_FromWKT_InvalidSyntax
	Try
		Dim geom As JTSGeometry = mJts.FromWKT("NOT VALID WKT")
		Log(Fail($"Neg.FromWKT InvalidSyntax - Expected exception, got none (isValid=${geom.IsValid})"$))
	Catch
		Log(Pass("Neg.FromWKT InvalidSyntax - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_FromWKT_EmptyString
	Try
		Dim geom As JTSGeometry = mJts.FromWKT("")
		Log(Fail($"Neg.FromWKT EmptyString - Expected exception, got none (isValid=${geom.IsValid})"$))
	Catch
		Log(Pass("Neg.FromWKT EmptyString - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_FromWKB_InvalidBytes
	Try
		Dim bytes(4) As Byte
		bytes(0) = 0
		bytes(1) = 1
		bytes(2) = 2
		bytes(3) = 3
		Dim geom As JTSGeometry = mJts.FromWKB(bytes)
		Log(Fail($"Neg.FromWKB InvalidBytes - Expected exception, got none (isValid=${geom.IsValid})"$))
	Catch
		Log(Pass("Neg.FromWKB InvalidBytes - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_Buffer_NegativeDistance
	Try
		Dim poly As JTSGeometry = mJts.CreatePolygon(BuildRingCoords(10.0, 59.0, 11.0, 60.0)).AsGeometry
		Dim shrunk As JTSGeometry = poly.Buffer(-0.1)
		Log(AssertTrue("Neg.Buffer NegativeDistance - IsValid",        shrunk.IsValid))
		Log(AssertTrue("Neg.Buffer NegativeDistance - Area < original",shrunk.GetArea < poly.GetArea))
	Catch
		Log(Fail("Neg.Buffer NegativeDistance - Unexpected exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_GetPointN_OutOfBounds
	Try
		Dim ls As JTSLineString = mJts.CreateLineString(BuildTwoCoords)
		Dim pt As JTSPoint = ls.GetPointN(99)
		Log(Fail($"Neg.GetPointN OutOfBounds - Expected exception, got none (isValid=${pt.AsGeometry.IsValid})"$))
	Catch
		Log(Pass("Neg.GetPointN OutOfBounds - Exception: " & LastException.Message))
	End Try
End Sub

' For a simple geometry, getGeometryN returns the geometry itself for any index
' (documented in JTSGeometry.GetGeometryN). For a real collection, out-of-bounds
' access throws ArrayIndexOutOfBoundsException - which is what this test exercises.
Private Sub Test_Neg_GetGeometryN_OutOfBounds
	Try
		Dim pt1 As JTSPoint = mJts.CreatePoint(10.0, 59.0)
		Dim pt2 As JTSPoint = mJts.CreatePoint(11.0, 60.0)
		Dim geoms As List
		geoms.Initialize
		geoms.Add(pt1.AsGeometry)
		geoms.Add(pt2.AsGeometry)
		Dim col As JTSGeometry = mJts.CreateGeometryCollection(geoms)
		Dim g As JTSGeometry = col.GetGeometryN(5)
		Log(Fail($"Neg.GetGeometryN OutOfBounds - Expected exception, got none (isValid=${g.IsValid})"$))
	Catch
		Log(Pass("Neg.GetGeometryN OutOfBounds - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_GetInteriorRingN_NoHoles
	Try
		Dim poly As JTSPolygon = mJts.CreatePolygon(BuildRingCoords(10.0, 59.0, 11.0, 60.0))
		poly.GetInteriorRingN(0)
		Log(Fail("Neg.GetInteriorRingN NoHoles - Expected exception, got none"))
	Catch
		Log(Pass("Neg.GetInteriorRingN NoHoles - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_STRtree_QueryAfterBuild_Insert
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		tree.Build
		tree.Insert(mJts.CreateEnvelope(12.0, 13.0, 59.0, 60.0), "B")
		Log(Fail($"Neg.STRtree InsertAfterBuild - Expected exception, got none (size=${tree.GetSize})"$))
	Catch
		Log(Pass("Neg.STRtree InsertAfterBuild - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_STRtree_Remove_NotInserted
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(10)
		tree.Insert(mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0), "A")
		Dim env As JTSEnvelope = mJts.CreateEnvelope(10.0, 11.0, 59.0, 60.0)
		Dim removed As Boolean = tree.Remove(env, "NOT_FOUND")
		Log(AssertTrue("Neg.STRtree Remove NotInserted - Returns False", removed = False))
	Catch
		Log(Fail("Neg.STRtree Remove NotInserted - Unexpected exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_STRtree_ZeroNodeCapacity
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(0)
		Log(Fail($"Neg.STRtree ZeroNodeCapacity - Expected exception, got none (size=${tree.GetSize})"$))
	Catch
		Log(Pass("Neg.STRtree ZeroNodeCapacity - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Neg_STRtree_OneNodeCapacity
	' JTS krev nodeCapacity > 1 - verdi 1 skal kasta AssertionFailedException
	Try
		Dim tree As JTSSTRtree
		tree.Initialize(1)
		Log(Fail($"Neg.STRtree OneNodeCapacity - Expected exception, got none (size=${tree.GetSize})"$))
	Catch
		Log(Pass("Neg.STRtree OneNodeCapacity - Exception: " & LastException.Message))
	End Try
End Sub


'##########################################################################
'# JTSAffineTransformation
'##########################################################################

Private Sub RunAffineTransformationTests
	Log("")
	Log("========================================")
	Log(" JTSAffineTransformation Test Suite")
	Log("========================================")

	Dim passBefore As Int = mPass
	Dim failBefore As Int = mFail

	Test_Affine_Initialize_IsIdentity
	Test_Affine_Initialize_Determinant
	Test_Affine_IdentityInstance_Independent
	Test_Affine_Translate
	Test_Affine_Rotate_SinCos_90Deg
	Test_Affine_Rotate_Theta
	Test_Affine_Scale
	Test_Affine_Shear
	Test_Affine_Reflect
	Test_Affine_ChainedCompose
	Test_Affine_SetToIdentity_Recycle
	Test_Affine_SetTransformation_MatrixEntries
	Test_Affine_SetTransformation2_Copy
	Test_Affine_Compose_Order
	Test_Affine_ComposeBefore_Order
	Test_Affine_GetMatrixEntries_Length6
	Test_Affine_GetInverse_Roundtrip
	Test_Affine_GetDeterminant_Scale
	Test_Affine_CreateFromControlVectors3_Translation
	Test_Affine_CreateFromControlVectors2_SimTransform
	Test_Affine_CreateFromControlVectors_GeneralAffine
	Test_Affine_CreateFromControlVectors4_List
	Test_Affine_CreateFromBaseLines
	Test_Affine_Transform_Polygon_Area
	Test_Affine_Transform2_PreservesSrc
	Test_Affine_Clone_Independent
	Test_Affine_Equals
	Test_Affine_ToString_NotEmpty

	Log("  Suite  PASS: " & (mPass - passBefore) & "   FAIL: " & (mFail - failBefore))
End Sub

Private Sub Test_Affine_Initialize_IsIdentity
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		Log(AssertTrue("Affine.Initialize - IsIdentity", at.IsIdentity))
	Catch
		Log(Fail("Affine.Initialize_IsIdentity - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Initialize_Determinant
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		Log(AssertDouble("Affine.Initialize - Determinant = 1", 1.0, at.GetDeterminant))
	Catch
		Log(Fail("Affine.Initialize_Determinant - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_IdentityInstance_Independent
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Translate(100, 100)
		Dim fresh As JTSAffineTransformation = at.IdentityInstance
		Log(AssertTrue ("Affine.IdentityInstance - fresh IsIdentity", fresh.IsIdentity))
		Log(AssertTrue ("Affine.IdentityInstance - original unchanged (not identity)", at.IsIdentity = False))
	Catch
		Log(Fail("Affine.IdentityInstance - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Translate
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Translate(10, 20)
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(1, 2))
		Log(AssertDouble("Affine.Translate - x", 11.0, cOut.GetX))
		Log(AssertDouble("Affine.Translate - y", 22.0, cOut.GetY))
	Catch
		Log(Fail("Affine.Translate - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Rotate_SinCos_90Deg
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Rotate2(1, 0)  ' sin=1, cos=0 -> eksakt 90 grader
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(1, 0))
		Log(AssertDouble("Affine.Rotate2(1,0) - x = 0", 0.0, cOut.GetX))
		Log(AssertDouble("Affine.Rotate2(1,0) - y = 1", 1.0, cOut.GetY))
	Catch
		Log(Fail("Affine.Rotate_SinCos_90Deg - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Rotate_Theta
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Rotate(cPI / 2)  ' 90 grader
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(1, 0))
		Log(AssertTrue("Affine.Rotate(PI/2) - x near 0",  Abs(cOut.GetX - 0.0) < 1e-9))
		Log(AssertTrue("Affine.Rotate(PI/2) - y near 1",  Abs(cOut.GetY - 1.0) < 1e-9))
	Catch
		Log(Fail("Affine.Rotate_Theta - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Scale
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Scale(2, 3)
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(4, 5))
		Log(AssertDouble("Affine.Scale - x", 8.0,  cOut.GetX))
		Log(AssertDouble("Affine.Scale - y", 15.0, cOut.GetY))
	Catch
		Log(Fail("Affine.Scale - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Shear
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Shear(1, 0)  ' x' = x + y, y' = y
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(1, 1))
		Log(AssertDouble("Affine.Shear - x", 2.0, cOut.GetX))
		Log(AssertDouble("Affine.Shear - y", 1.0, cOut.GetY))
	Catch
		Log(Fail("Affine.Shear - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Reflect
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Reflect2(1, 0)  ' refleksjon om x-aksen (linje gjennom (0,0) og (1,0))
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(3, 4))
		Log(AssertDouble("Affine.Reflect2 - x", 3.0,  cOut.GetX))
		Log(AssertDouble("Affine.Reflect2 - y", -4.0, cOut.GetY))
	Catch
		Log(Fail("Affine.Reflect - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_ChainedCompose
	' Rotér 90° (sin=1, cos=0), så translater (5,0). (1,0) -> rot -> (0,1) -> trans -> (5,1)
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Rotate2(1, 0).Translate(5, 0)
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(1, 0))
		Log(AssertDouble("Affine.Chain - x = 5", 5.0, cOut.GetX))
		Log(AssertDouble("Affine.Chain - y = 1", 1.0, cOut.GetY))
	Catch
		Log(Fail("Affine.ChainedCompose - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_SetToIdentity_Recycle
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Rotate(0.5).Translate(99, 99)
		Dim cOut As JTSCoordinate = at.SetToIdentity.Translate(7, 8).Transform2(mJts.CreateCoordinate(0, 0))
		Log(AssertDouble("Affine.SetToIdentity_Recycle - x", 7.0, cOut.GetX))
		Log(AssertDouble("Affine.SetToIdentity_Recycle - y", 8.0, cOut.GetY))
	Catch
		Log(Fail("Affine.SetToIdentity_Recycle - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_SetTransformation_MatrixEntries
	' Manuelt sett matrisa til scale 2x + translate (3,4):
	'   | 2 0 3 |
	'   | 0 2 4 |
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.SetTransformation(2, 0, 3, 0, 2, 4)
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(1, 1))
		Log(AssertDouble("Affine.SetTransformation - x = 5", 5.0, cOut.GetX))
		Log(AssertDouble("Affine.SetTransformation - y = 6", 6.0, cOut.GetY))
	Catch
		Log(Fail("Affine.SetTransformation_MatrixEntries - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_SetTransformation2_Copy
	Try
		Dim src As JTSAffineTransformation
		src.Initialize
		src.Rotate(0.5).Scale(1.5, 1.5)
		Dim dst As JTSAffineTransformation
		dst.Initialize
		dst.SetTransformation2(src)
		Log(AssertTrue("Affine.SetTransformation2 - copies matrix", dst.Equals(src)))
	Catch
		Log(Fail("Affine.SetTransformation2_Copy - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Compose_Order
	' a.Compose(b) skal vere: bruk a først, så b. Test med translate så scale.
	'   p = (1, 1), a = translate (1, 0), b = scale (2, 2)
	'   a alone: (1,1) -> (2,1).  Then b: (2,1) -> (4,2).
	Try
		Dim a As JTSAffineTransformation
		a.Initialize
		a.Translate(1, 0)
		Dim b As JTSAffineTransformation
		b.Initialize
		b.Scale(2, 2)
		a.Compose(b)
		Dim cOut As JTSCoordinate = a.Transform2(mJts.CreateCoordinate(1, 1))
		Log(AssertDouble("Affine.Compose - x", 4.0, cOut.GetX))
		Log(AssertDouble("Affine.Compose - y", 2.0, cOut.GetY))
	Catch
		Log(Fail("Affine.Compose_Order - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_ComposeBefore_Order
	' a.ComposeBefore(b): bruk b først, så a.
	'   p = (1, 1), a = translate (1, 0), b = scale (2, 2)
	'   b alone: (1,1) -> (2,2).  Then a: (2,2) -> (3,2).
	Try
		Dim a As JTSAffineTransformation
		a.Initialize
		a.Translate(1, 0)
		Dim b As JTSAffineTransformation
		b.Initialize
		b.Scale(2, 2)
		a.ComposeBefore(b)
		Dim cOut As JTSCoordinate = a.Transform2(mJts.CreateCoordinate(1, 1))
		Log(AssertDouble("Affine.ComposeBefore - x", 3.0, cOut.GetX))
		Log(AssertDouble("Affine.ComposeBefore - y", 2.0, cOut.GetY))
	Catch
		Log(Fail("Affine.ComposeBefore_Order - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_GetMatrixEntries_Length6
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		Dim m() As Double = at.GetMatrixEntries
		Log(AssertEqual("Affine.GetMatrixEntries - length", "6", m.Length))
		' Identitet: m00=1, m11=1, resten=0
		Log(AssertDouble("Affine.GetMatrixEntries - m00", 1.0, m(0)))
		Log(AssertDouble("Affine.GetMatrixEntries - m11", 1.0, m(4)))
	Catch
		Log(Fail("Affine.GetMatrixEntries_Length6 - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_GetInverse_Roundtrip
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Rotate(0.7).Translate(3, -2).Scale(1.5, 0.5)
		Dim inv As JTSAffineTransformation = at.GetInverse
		Dim cIn As JTSCoordinate = mJts.CreateCoordinate(7.5, -3.25)
		Dim cBack As JTSCoordinate = inv.Transform2(at.Transform2(cIn))
		Log(AssertTrue("Affine.GetInverse - roundtrip x",  Abs(cBack.GetX - 7.5)   < 1e-9))
		Log(AssertTrue("Affine.GetInverse - roundtrip y",  Abs(cBack.GetY - (-3.25)) < 1e-9))
	Catch
		Log(Fail("Affine.GetInverse_Roundtrip - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_GetDeterminant_Scale
	' Skala (2,3) -> determinant = 2*3 = 6
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Scale(2, 3)
		Log(AssertDouble("Affine.GetDeterminant - scale (2,3)", 6.0, at.GetDeterminant))
	Catch
		Log(Fail("Affine.GetDeterminant_Scale - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_CreateFromControlVectors3_Translation
	' 1 kontrollvektor -> rein translasjon
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.CreateFromControlVectors3(mJts.CreateCoordinate(0, 0), mJts.CreateCoordinate(5, 7))
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(2, 3))
		Log(AssertDouble("Affine.CreateFromControlVectors3 - x", 7.0,  cOut.GetX))
		Log(AssertDouble("Affine.CreateFromControlVectors3 - y", 10.0, cOut.GetY))
	Catch
		Log(Fail("Affine.CreateFromControlVectors3_Translation - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_CreateFromControlVectors2_SimTransform
	' 2 kontrollvektorar -> uniform skala + rotasjon + translasjon
	' src: (0,0)->(1,0). dest: (0,0)->(0,1). Skal vere 90° rotasjon, ingen skala/translasjon.
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.CreateFromControlVectors2( _
			mJts.CreateCoordinate(0, 0), mJts.CreateCoordinate(1, 0), _
			mJts.CreateCoordinate(0, 0), mJts.CreateCoordinate(0, 1))
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(1, 0))
		Log(AssertTrue("Affine.CreateFromControlVectors2 - x near 0", Abs(cOut.GetX - 0.0) < 1e-9))
		Log(AssertTrue("Affine.CreateFromControlVectors2 - y near 1", Abs(cOut.GetY - 1.0) < 1e-9))
	Catch
		Log(Fail("Affine.CreateFromControlVectors2_SimTransform - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_CreateFromControlVectors_GeneralAffine
	' Mapper enhetstriangelen (0,0)-(1,0)-(0,1) til (10,20)-(12,20)-(10,23).
	' Forventa: skala (2,3) + translasjon (10,20).
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.CreateFromControlVectors( _
			mJts.CreateCoordinate(0, 0), mJts.CreateCoordinate(1, 0), mJts.CreateCoordinate(0, 1), _
			mJts.CreateCoordinate(10, 20), mJts.CreateCoordinate(12, 20), mJts.CreateCoordinate(10, 23))
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(0.5, 0.5))
		Log(AssertDouble("Affine.CreateFromControlVectors - x", 11.0,  cOut.GetX))
		Log(AssertDouble("Affine.CreateFromControlVectors - y", 21.5,  cOut.GetY))
	Catch
		Log(Fail("Affine.CreateFromControlVectors_GeneralAffine - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_CreateFromControlVectors4_List
	' Same som CreateFromControlVectors men via List.
	Try
		Dim src As List : src.Initialize
		src.Add(mJts.CreateCoordinate(0, 0))
		src.Add(mJts.CreateCoordinate(1, 0))
		src.Add(mJts.CreateCoordinate(0, 1))
		Dim dst As List : dst.Initialize
		dst.Add(mJts.CreateCoordinate(10, 20))
		dst.Add(mJts.CreateCoordinate(12, 20))
		dst.Add(mJts.CreateCoordinate(10, 23))
		Dim at As JTSAffineTransformation
		at.Initialize
		at.CreateFromControlVectors4(src, dst)
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(0.5, 0.5))
		Log(AssertDouble("Affine.CreateFromControlVectors4 - x", 11.0, cOut.GetX))
		Log(AssertDouble("Affine.CreateFromControlVectors4 - y", 21.5, cOut.GetY))
	Catch
		Log(Fail("Affine.CreateFromControlVectors4_List - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_CreateFromBaseLines
	' Basislinje (0,0)-(1,0) avbildast til (10,10)-(10,12). (1,0) skal hamne på (10,12).
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.CreateFromBaseLines( _
			mJts.CreateCoordinate(0, 0), mJts.CreateCoordinate(1, 0), _
			mJts.CreateCoordinate(10, 10), mJts.CreateCoordinate(10, 12))
		Dim cOut As JTSCoordinate = at.Transform2(mJts.CreateCoordinate(1, 0))
		Log(AssertDouble("Affine.CreateFromBaseLines - x", 10.0, cOut.GetX))
		Log(AssertDouble("Affine.CreateFromBaseLines - y", 12.0, cOut.GetY))
	Catch
		Log(Fail("Affine.CreateFromBaseLines - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Transform_Polygon_Area
	' Skala 2x av eit 4x3-rektangel -> areal 4x.
	Try
		Dim shell As List
		shell.Initialize
		shell.Add(mJts.CreateCoordinate(0, 0))
		shell.Add(mJts.CreateCoordinate(4, 0))
		shell.Add(mJts.CreateCoordinate(4, 3))
		shell.Add(mJts.CreateCoordinate(0, 3))
		shell.Add(mJts.CreateCoordinate(0, 0))
		Dim rect As JTSPolygon = mJts.CreatePolygon(shell)
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Scale(2, 2)
		Dim rect2 As JTSGeometry = at.Transform(rect.AsGeometry)
		Log(AssertDouble("Affine.Transform - polygon area", rect.AsGeometry.GetArea * 4, rect2.GetArea))
	Catch
		Log(Fail("Affine.Transform_Polygon_Area - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Transform2_PreservesSrc
	' Transform2 må ikkje endre src.
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Translate(100, 200)
		Dim src As JTSCoordinate = mJts.CreateCoordinate(1, 2)
		Dim dest As JTSCoordinate = at.Transform2(src)
		Log(AssertDouble("Affine.Transform2 - src.x unchanged", 1.0, src.GetX))
		Log(AssertDouble("Affine.Transform2 - src.y unchanged", 2.0, src.GetY))
		Log(AssertDouble("Affine.Transform2 - dest.x",          101.0, dest.GetX))
		Log(AssertDouble("Affine.Transform2 - dest.y",          202.0, dest.GetY))
	Catch
		Log(Fail("Affine.Transform2_PreservesSrc - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Clone_Independent
	' Endring i klone skal ikkje påverke original.
	Try
		Dim orig As JTSAffineTransformation
		orig.Initialize
		orig.Translate(1, 1)
		Dim cp As JTSAffineTransformation = orig.Clone
		cp.Translate(9, 9)
		Dim cOut As JTSCoordinate = orig.Transform2(mJts.CreateCoordinate(0, 0))
		Log(AssertDouble("Affine.Clone - original x untouched", 1.0, cOut.GetX))
		Log(AssertDouble("Affine.Clone - original y untouched", 1.0, cOut.GetY))
	Catch
		Log(Fail("Affine.Clone_Independent - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_Equals
	Try
		Dim a As JTSAffineTransformation
		a.Initialize
		a.Rotate(0.5)
		Dim b As JTSAffineTransformation
		b.Initialize
		b.Rotate(0.5)
		Dim c As JTSAffineTransformation
		c.Initialize
		c.Rotate(0.6)
		Log(AssertTrue("Affine.Equals - same matrix",   a.Equals(b)))
		Log(AssertTrue("Affine.Equals - different matrix", a.Equals(c) = False))
	Catch
		Log(Fail("Affine.Equals - Exception: " & LastException.Message))
	End Try
End Sub

Private Sub Test_Affine_ToString_NotEmpty
	Try
		Dim at As JTSAffineTransformation
		at.Initialize
		Dim s As String = at.ToString
		Log(AssertTrue("Affine.ToString - not empty", s.Length > 0))
		Log(AssertTrue("Affine.ToString - contains 'AffineTransformation'", s.Contains("AffineTransformation")))
	Catch
		Log(Fail("Affine.ToString_NotEmpty - Exception: " & LastException.Message))
	End Try
End Sub

'##########################################################################
'# Assert helpers - return String, logged locally with Log(...)
'##########################################################################

Private Sub AssertEqual(testName As String, expected As Object, actual As Object) As String
	If (expected & "") = (actual & "") Then
		Return Pass(testName)
	Else
		Return Fail(testName & " | Expected: " & expected & "  Got: " & actual)
	End If
End Sub

Private Sub AssertTrue(testName As String, condition As Boolean) As String
	If condition Then
		Return Pass(testName)
	Else
		Return Fail(testName & " | Expected: True  Got: False")
	End If
End Sub

Private Sub AssertDouble(testName As String, expected As Double, actual As Double) As String
	If Abs(expected - actual) < 0.000001 Then
		Return Pass(testName)
	Else
		Return Fail(testName & " | Expected: " & expected & "  Got: " & actual)
	End If
End Sub

Private Sub Pass(testName As String) As String
	mPass = mPass + 1
	Return "  PASS  " & testName
End Sub

Private Sub Fail(testName As String) As String
	mFail = mFail + 1
	Return "  FAIL  " & testName
End Sub


'##########################################################################
'# Geometry helpers (internal)
'##########################################################################

'Builds a rectangular JTSGeometry polygon from corner coordinates.
Private Sub BuildPolygonGeom(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As JTSGeometry
	Return mJts.CreatePolygon(BuildRingCoords(x1, y1, x2, y2)).AsGeometry
End Sub

'Builds a rectangular JTSPolygon (typed) from corner coordinates.
Private Sub BuildPolygonTyped(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As JTSPolygon
	Return mJts.CreatePolygon(BuildRingCoords(x1, y1, x2, y2))
End Sub

'Builds a two-point JTSLineString.
Private Sub BuildLineStr(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As JTSLineString
	Dim coords As List
	coords.Initialize
	coords.Add(mJts.CreateCoordinate(x1, y1))
	coords.Add(mJts.CreateCoordinate(x2, y2))
	Return mJts.CreateLineString(coords)
End Sub

'Builds a two-point line and returns it as JTSGeometry.
Private Sub BuildLineGeom(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As JTSGeometry
	Return BuildLineStr(x1, y1, x2, y2).AsGeometry
End Sub

'Builds a closed rectangular ring coordinate list.
Private Sub BuildRingCoords(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As List
	Dim result As List
	result.Initialize
	result.Add(mJts.CreateCoordinate(x1, y1))
	result.Add(mJts.CreateCoordinate(x2, y1))
	result.Add(mJts.CreateCoordinate(x2, y2))
	result.Add(mJts.CreateCoordinate(x1, y2))
	result.Add(mJts.CreateCoordinate(x1, y1))
	Return result
End Sub

Private Sub BuildRingCoords2(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Object()
	Dim arr(5) As Object
	arr(0) = (mJts.CreateCoordinateNative(x1, y1))
	arr(1) = (mJts.CreateCoordinateNative(x2, y1))
	arr(2) = (mJts.CreateCoordinateNative(x2, y2))
	arr(3) = (mJts.CreateCoordinateNative(x1, y2))
	arr(4) = (mJts.CreateCoordinateNative(x1, y1))
	Return arr
End Sub

'Builds a List of JTSCoordinate from a flat x/y pair array.
Private Sub BuildCoords(xyPairs() As Double) As List
	Dim result As List
	result.Initialize
	Dim i As Int
	For i = 0 To xyPairs.Length - 1 Step 2
		result.Add(mJts.CreateCoordinate(xyPairs(i), xyPairs(i + 1)))
	Next
	Return result
End Sub

'Builds a JTSGeometryCollection (MultiPoint) with n evenly spaced points.
Private Sub BuildMultiPoint(n As Int) As JTSGeometry
	Dim pts As List
	pts.Initialize
	Dim i As Int
	For i = 0 To n - 1
		pts.Add(mJts.CreatePoint(10.0 + i, 59.0))
	Next
	Return mJts.CreateMultiPoint(pts)
End Sub

'Builds a two-coordinate list (used by negative tests).
Private Sub BuildTwoCoords As List
	Dim result As List
	result.Initialize
	result.Add(mJts.CreateCoordinate(10.0, 59.0))
	result.Add(mJts.CreateCoordinate(11.0, 60.0))
	Return result
End Sub
