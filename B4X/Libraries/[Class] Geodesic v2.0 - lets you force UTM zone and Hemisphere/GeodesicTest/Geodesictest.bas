B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Test module for the Geodesic class.
'Verifies LatLonToUTM math against known reference values and via round-trip conversion.
'Usage from Main: Dim t As GeodesicTest : t.Initialize : t.RunAll
Sub Class_Globals
	Private mGeo As Geodesic
	'Tolerance for pass/fail, now expressed in MILLIMETRES because CheckDouble scales
	'every difference into mm before comparing (0.02 m = 20 mm).
	Private mEastNorthTol As Double	= 20 'millimetres
	Private mPass, mFail As Int
	'Scale factors used by CheckDouble to convert a raw difference into metres before
	'comparing against the (metre-based) tolerance.
	'  UTM eastings/northings are already in metres.
	'  A degree of latitude is ~111 000 m everywhere.
	'  A degree of longitude is ~111 320 m at the equator and must be multiplied by Cos(lat).
	Public Const SCALE_UTM As Double = 1000			'metres per unit -> mm reporting; UTM values pass 1
	Public Const SCALE_LAT As Double = 111000000	'roughly metres-per-degree * 1000 (mm)
	Public Const SCALE_LON As Double = 111320000	'roughly metres-per-degree * 1000 (mm) at equator; * Cos(lat)
	'A single test case definition.
	'ForceHemisphere: 0 = automatic, 1 = force northern, -1 = force southern.
	'ExpEast / ExpNorth / ExpNorth_Hemisphere describe the EXPECTED result AFTER any forcing,
	'so a forced case simply carries the offset reference values.
	Type TestCase (Name As String, Lat As Double, Lon As Double, ForceZone As Int, ForceHemisphere As Int, _
		ExpZone As Int, ExpEast As Double, ExpNorth As Double, ExpNorth_Hemisphere As Boolean)
End Sub

'Initializes the test module.
Public Sub Initialize
	mGeo.Initialize
	
End Sub

'Runs all test groups and prints a summary.
Public Sub RunAll
	mPass = 0
	mFail = 0
	Log("=== Geodesic test run ===")
	TestCases
	TestForcedZone
	Log($"=== Done: ${mPass} passed, ${mFail} failed ==="$)
End Sub

'Builds the shared list of test cases used for both reference and round-trip checks.
'Returns: a List of TestCase
Private Sub BuildCases As List
	Dim cases As List
	cases.Initialize
	'ExpEast / ExpNorth are reference values obtained from epsg.io / movable-type / pyproj.
	'The forced-hemisphere cases reuse those references offset by +/-10 000 000, since only the
	'false northing differs between the two conventions - the projection itself is identical.
	'															lat			lon			force	force	exp		exp					exp					exp
	'																					zone	hemi	zone	easting				northing			hemisphere
	cases.Add(MakeCase("Equator on zone 32 central meridian", 	0, 			9, 			0, 		0, 		32, 	500000, 			0, 			 		True))
	cases.Add(MakeCase("Sunndalsoera area", 					62.6741433, 8.5659027, 	0, 		0, 		32, 	477767.25885411823, 6949358.884942783, 	True))
	'FIXED: zone/easting/northing were swapped between these two rows. Sydney is zone 56, Papua zone 54.
	cases.Add(MakeCase("Sydney (southern)", 					-33.8688, 	151.2093, 	0, 		0, 		56, 	334368.633648097, 	6250948.345385009, 	False))
	cases.Add(MakeCase("Papua (southern)", 						-5.790897, 	142.382812, 0, 		0, 		54, 	653106.9819805127, 	9359723.599882085, 	False))
	cases.Add(MakeCase("Oslo area", 							59.9139, 	10.7522, 	0, 		0, 		32, 	597979.9028839065, 	6643118.991370024, 	True))
	cases.Add(MakeCase("Bremanger", 							61.8394, 	4.990540, 	0, 		0, 		31, 	604795.7839046536, 	6857894.4901016075,	True))
	cases.Add(MakeCase("Bremanger (forced zone 32)",			61.8394, 	4.990540, 	32,		0, 		32, 	288986.3561386554, 	6862802.430308871,	True))
	cases.Add(MakeCase("Svalbard area", 						78.7675, 	20.4848, 	0,	 	0, 		34,		488796.8728694169, 	8744074.707382105, 	True))
	cases.Add(MakeCase("Svalbard area (forced zone 33)", 		78.7675, 	20.4848, 	33,	 	0, 		33,		619101.2469154844, 	8749621.355456432, 	True))
	'--- Forced-hemisphere cases (northing offset by +/-10 000 000 vs the natural convention) ---
	'Northern point forced onto the southern convention: northing = natural + 10 000 000 (above 10e6).
	cases.Add(MakeCase("Oslo forced southern", 					59.9139, 	10.7522, 	0, 		-1, 	32, 	597979.9028839065, 	16643118.991370024, False))
	'Southern point forced onto the northern convention: northing = natural - 10 000 000 (negative).
	'FIXED: Sydney is zone 56 with easting 334368.63 and natural northing 6250948.35, so forced -> -3749051.65.
	cases.Add(MakeCase("Sydney forced northern", 				-33.8688, 	151.2093, 	0, 		1, 		56, 	334368.633648097, 	-3749051.654614991, True))
	'Forcing the natural hemisphere must reproduce the automatic result unchanged.
	cases.Add(MakeCase("Oslo forced northern (natural)", 		59.9139, 	10.7522, 	0, 		1, 		32, 	597979.9028839065, 	6643118.991370024, 	True))
	Return cases
End Sub

'For each case: verifies LatLon -> UTM against reference values, then verifies that
'that UTM survives a UTM -> LatLon -> UTM round-trip within tolerance.
Private Sub TestCases
	Log("--- Cases (LatLon -> UTM reference, then UTM -> LatLon -> UTM round-trip) ---")
	For Each tc As TestCase In BuildCases
		Log($"[${tc.Name}]"$)
		'--- Forward: LatLon -> UTM, checked against reference values ---
		Dim ll As LatLon
		ll.Initialize
		ll.Lat = tc.Lat
		ll.Lon = tc.Lon
		Dim u As UTM
		'CHANGED: route through WGS84LatLonToUTM2 whenever a zone OR a hemisphere is forced.
		'The forced-hemisphere argument is a Boolean; convert 1/-1 accordingly. When only the
		'hemisphere is forced we still need a zone, so fall back to the expected zone.
		If tc.ForceZone > 0 Or tc.ForceHemisphere <> 0 Then
			Dim useZone As Int
			If tc.ForceZone > 0 Then useZone = tc.ForceZone Else useZone = tc.ExpZone
			u = mGeo.WGS84LatLonToUTM2(ll, useZone, tc.ExpNorth_Hemisphere)
		Else
			u = mGeo.WGS84LatLonToUTM(ll)
		End If
		Log(CheckInt("  zone", u.UtmXZone, tc.ExpZone))
		Log(CheckBool("  hemisphere", u.NorthHemisphere, tc.ExpNorth_Hemisphere))
		Log(CheckDouble("  ref easting", u.X, tc.ExpEast, mEastNorthTol, SCALE_UTM))
		Log(CheckDouble("  ref northing", u.Y, tc.ExpNorth, mEastNorthTol, SCALE_UTM))
		'--- Reverse: WGS84UTMTOLatLon from the reference UTM, checked against the case lat/lon ---
		'Builds a UTM straight from the reference values and checks the inverse conversion
		'independently of the forward code. Longitude scale is multiplied by Cos(lat) so the
		'east-west error is measured in real metres at that latitude.
		Dim uRef As UTM
		uRef.Initialize
		uRef.UtmXZone = tc.ExpZone
		uRef.X = tc.ExpEast
		uRef.Y = tc.ExpNorth
		uRef.NorthHemisphere = tc.ExpNorth_Hemisphere
		Dim llRev As LatLon = mGeo.WGS84UTMTOLatLon(uRef)
		Log(CheckDouble("  rev lat", llRev.Lat, tc.Lat, mEastNorthTol, SCALE_LAT))
		Log(CheckDouble("  rev lon", llRev.Lon, tc.Lon, mEastNorthTol, SCALE_LON * Cos(tc.Lat * cPI / 180)))
		'--- Round-trip: UTM -> LatLon -> UTM, must return to the same easting/northing ---
		'The UTM carries its own hemisphere flag, so UTMToLatLon undoes any forced offset
		'and the re-projection reproduces the same easting/northing.
		Dim llBack As LatLon = mGeo.WGS84UTMTOLatLon(u)
		Dim uBack As UTM = mGeo.WGS84LatLonToUTM2(llBack, u.UtmXZone, u.NorthHemisphere)
		Log(CheckDouble("  roundtrip easting", uBack.X, u.X, mEastNorthTol, SCALE_UTM))
		Log(CheckDouble("  roundtrip northing", uBack.Y, u.Y, mEastNorthTol, SCALE_UTM))
	Next
End Sub

'Verifies that forcing a zone changes the result and that a forced zone equal to the
'automatic zone produces identical output.
Private Sub TestForcedZone
	Log("--- Forced zone behaviour ---")
	'A South-Norway point that automatically falls in zone 31 but is often mapped as 32.
	Dim ll As LatLon
	ll.Initialize
	ll.Lat = 58.97
	ll.Lon = 5.73	'Stavanger area
	Dim uAuto As UTM = mGeo.WGS84LatLonToUTM(ll)
	'CHANGED: pass hemisphere (northern point -> True).
	Dim uForced As UTM = mGeo.WGS84LatLonToUTM2(ll, 32, True)
	Log(CheckBool("forced zone differs from auto", uAuto.UtmXZone <> uForced.UtmXZone, True))
	Log(CheckInt("forced zone value", uForced.UtmXZone, 32))
	'Forcing the same zone as auto must reproduce the automatic result exactly.
	'CHANGED: pass the automatic hemisphere so only the zone is under test.
	Dim uSame As UTM = mGeo.WGS84LatLonToUTM2(ll, uAuto.UtmXZone, uAuto.NorthHemisphere)
	'0.001 mm tolerance (was 0.000001 m) - these must be bit-for-bit identical.
	Log(CheckDouble("force==auto easting", uSame.X, uAuto.X, 0.001, SCALE_UTM))
	Log(CheckDouble("force==auto northing", uSame.Y, uAuto.Y, 0.001, SCALE_UTM))
End Sub

'Builds a TestCase record.
'Returns: a populated TestCase
Private Sub MakeCase(Name As String, Lat As Double, Lon As Double, ForceZone As Int, ForceHemisphere As Int, _
	ExpZone As Int, ExpEast As Double, ExpNorth As Double, NorthHemisphere As Boolean) As TestCase
	Dim tc As TestCase
	tc.Initialize
	tc.Name = Name
	tc.Lat = Lat
	tc.Lon = Lon
	tc.ForceZone = ForceZone
	tc.ForceHemisphere = ForceHemisphere
	tc.ExpZone = ExpZone
	tc.ExpEast = ExpEast
	tc.ExpNorth = ExpNorth
	tc.ExpNorth_Hemisphere = NorthHemisphere
	Return tc
End Sub

'Asserts that a value is within tolerance after scaling the raw difference into millimetres.
'Scale converts a raw difference into mm: UTM values are metres, so SCALE_UTM (1000) gives mm;
'latitude/longitude are degrees, so SCALE_LAT / SCALE_LON (metres-per-degree * 1000) give mm.
'For longitude the caller must pass SCALE_LON * Cos(latRad) to account for meridian convergence.
'Returns: a result line describing pass/fail, for the caller to log
'Label - description of the value being checked
'Actual - value produced by the code under test
'Expected - reference value
'Tol - maximum allowed scaled difference, in millimetres
'Scale - factor that turns the raw difference into millimetres
Private Sub CheckDouble(Label As String, Actual As Double, Expected As Double, Tol As Double, Scale As Double) As String
	Dim diffMm As Double = Abs(Actual - Expected) * Scale
	If diffMm <= Tol Then
		mPass = mPass + 1
		Return $"  PASS ${Label}: ${Actual} (diff $1.3{diffMm} mm)"$
	Else
		mFail = mFail + 1
		Return $"  FAIL ${Label}: got ${Actual}, expected ${Expected} (diff $1.3{diffMm} mm)"$
	End If
End Sub

'Asserts that an Int equals the expected value.
'Returns: a result line describing pass/fail, for the caller to log
'Label - description of the value being checked
'Actual - value produced by the code under test
'Expected - reference value
Private Sub CheckInt(Label As String, Actual As Int, Expected As Int) As String
	If Actual = Expected Then
		mPass = mPass + 1
		Return $"  PASS ${Label}: ${Actual}"$
	Else
		mFail = mFail + 1
		Return $"  FAIL ${Label}: got ${Actual}, expected ${Expected}"$
	End If
End Sub

'Asserts that a Boolean equals the expected value.
'Returns: a result line describing pass/fail, for the caller to log
'Label - description of the value being checked
'Actual - value produced by the code under test
'Expected - reference value
Private Sub CheckBool(Label As String, Actual As Boolean, Expected As Boolean) As String
	If Actual = Expected Then
		mPass = mPass + 1
		Return $"  PASS ${Label}: ${Actual}"$
	Else
		mFail = mFail + 1
		Return $"  FAIL ${Label}: got ${Actual}, expected ${Expected}"$
	End If
End Sub
