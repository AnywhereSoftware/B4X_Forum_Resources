B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mJts As JTSManager

	Private cvs As B4XCanvas         ' shared canvas from B4XMainPage (Panel1)
	Private reportLabel As B4XView   ' optional label for the test report

	Private testsPassed As Int
	Private testsFailed As Int
	Private testLog As List
	Private currentTestName As String
End Sub

'Automatic test suite for the JTSDraw library (JTSDrawer and JTSBCDrawer).
'
'Pass the shared B4XCanvas owned by B4XMainPage (Panel1's canvas) and an
'optional report label. The canvas is used as a drawing target during the
'drawer tests; it is left in whatever state the last test drew and should
'be redrawn by the next interactive action after RunAll returns.
'
'Results are written to the Log and, if reportLabel is initialised, to the
'label text (green on all-pass, red on any failure).
'
'This suite is not mode-aware: it always tests both JTSDrawer (Canvas) and
'JTSBCDrawer (BitmapCreator) regardless of the radio-button selection in
'the main UI.
Public Sub Initialize(lbl As B4XView, canvas As B4XCanvas, jts As JTSManager)
	cvs = canvas
	reportLabel = lbl
	mJts = jts
	testLog.Initialize
End Sub

'Runs all test suites and returns True if every test passed.
'Writes a combined summary to the Log and to reportLabel (if initialised).
Public Sub RunAll 
	cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)

	Log("=== JTSDraw Automatic Test Suite ===")
	testsPassed = 0
	testsFailed = 0
	testLog.Clear

	'### JTSStyle ###
	currentTestName = "JTSStyle.Initialize"          : TestStyleInitialize
	currentTestName = "JTSStyle.SetStroke"           : TestStyleSetStroke
	currentTestName = "JTSStyle.SetFill"             : TestStyleSetFill
	currentTestName = "JTSStyle.NoStroke/NoFill"     : TestStyleNoStrokeNoFill
	currentTestName = "JTSStyle.Clone"               : TestStyleClone
	currentTestName = "JTSStyle.ShapeConstants"      : TestStyleShapeConstants
	
	'### JTSDrawer ###
	currentTestName = "JTSDrawer.Initialize"                   : TestDrawerInitialize
	currentTestName = "JTSDrawer.SetViewport"                  : TestDrawerSetViewport
	currentTestName = "JTSDrawer.SetViewportRect"              : TestDrawerSetViewportRect
	currentTestName = "JTSDrawer.SetViewportFromGeometry"      : TestDrawerSetViewportFromGeometry
	currentTestName = "JTSDrawer.SetViewportFromGeometryPad"   : TestDrawerSetViewportFromGeometryPad
	currentTestName = "JTSDrawer.SetViewportFromGeometries"    : TestDrawerSetViewportFromGeometries
	currentTestName = "JTSDrawer.SetTargetRect"                : TestDrawerSetTargetRect
	currentTestName = "JTSDrawer.GetTargetRect"                : TestDrawerGetTargetRect
	currentTestName = "JTSDrawer.PreserveAspect"               : TestDrawerPreserveAspect
	currentTestName = "JTSDrawer.WorldToCanvas"                : TestDrawerWorldToCanvas
	currentTestName = "JTSDrawer.InvalidateTransform"          : TestDrawerInvalidateTransform
	
	'### JTSBCDrawer ###
	currentTestName = "JTSBCDrawer.Initialize"        : TestBCDrawerInitialize
	currentTestName = "JTSBCDrawer.SetViewport"       : TestBCDrawerSetViewport
	currentTestName = "JTSBCDrawer.SetViewportRect"   : TestBCDrawerSetViewportRect
	currentTestName = "JTSBCDrawer.WorldToBC"         : TestBCDrawerWorldToBC
	currentTestName = "JTSBCDrawer.Batch operations"  : TestBCDrawerBatch
	
	'### Geometry drawing ###
	currentTestName = "Draw Point"                : TestDrawPoint
	currentTestName = "Draw MultiPoint"           : TestDrawMultiPoint
	currentTestName = "Draw LineString"           : TestDrawLineString
	currentTestName = "Draw Polygon"              : TestDrawPolygon
	currentTestName = "Draw Polygon with holes"   : TestDrawPolygonWithHoles
	currentTestName = "Draw MultiPolygon"         : TestDrawMultiPolygon
	currentTestName = "Draw GeometryCollection"   : TestDrawGeometryCollection
	currentTestName = "Handle empty geometry"     : TestEmptyGeometry
	
	'### Edge cases ###
	currentTestName = "Large coordinates"    : TestLargeCoordinates
	currentTestName = "Tiny coordinates"     : TestTinyCoordinates
	currentTestName = "Negative coordinates" : TestNegativeCoordinates
	currentTestName = "Zero-width viewport"  : TestZeroWidthViewport
	
	ShowTestReport
	
	cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)	
End Sub

'Returns the number of tests that passed (valid after RunAll).
Public Sub GetPassedCount As Int
	Return testsPassed
End Sub

'Returns the number of tests that failed (valid after RunAll).
Public Sub GetFailedCount As Int
	Return testsFailed
End Sub

'Returns the full test log as a List of strings (valid after RunAll).
Public Sub GetTestLog As List
	Return testLog
End Sub

'##########################################################################
'# Internal helpers
'##########################################################################

'Records a passing result for the current test and returns the log line.
'The caller is expected to wrap this in Log(...) so logging happens at the
'test method (matches the JTSTest pattern).
Private Sub PassTest As String
	testsPassed = testsPassed + 1
	Dim s As String = "PASS: " & currentTestName
	testLog.Add(s)
	Return s
End Sub

'Records a failing result for the current test with the supplied reason
'and returns the log line. The caller is expected to wrap this in Log(...).
Private Sub FailTest(reason As String) As String
	testsFailed = testsFailed + 1
	Dim s As String = "FAIL: " & currentTestName & " - " & reason
	testLog.Add(s)
	Return s
End Sub

'Writes the final report to the Log and to reportLabel (if initialised).
Private Sub ShowTestReport
	Log("")
	Log("=== Test Report ===")
	Log("Total tests: " & (testsPassed + testsFailed))
	Log("Passed: " & testsPassed)
	Log("Failed: " & testsFailed)

	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("=== Test Report ===").Append(CRLF)
	sb.Append("Total:  ").Append(testsPassed + testsFailed).Append(CRLF)
	sb.Append("Passed: ").Append(testsPassed).Append(CRLF)
	sb.Append("Failed: ").Append(testsFailed).Append(CRLF).Append(CRLF)

	If testsFailed = 0 Then
		Log("ALL TESTS PASSED!")
		sb.Append("ALL TESTS PASSED!").Append(CRLF)
	Else
		Log("SOME TESTS FAILED")
		sb.Append("SOME TESTS FAILED").Append(CRLF).Append(CRLF)
		Log("")
		Log("Failed tests:")
		sb.Append("Failed tests:").Append(CRLF)
		For Each logEntry As String In testLog
			If logEntry.StartsWith("FAIL") Then
				Log(logEntry)
				sb.Append(logEntry).Append(CRLF)
			End If
		Next
	End If

	If reportLabel.IsInitialized Then
		reportLabel.Text = $"${testsPassed} PASS / ${testsFailed} FAIL${CRLF}See the log for details."$
	End If
End Sub

'##########################################################################
'# JTSStyle tests
'##########################################################################

Private Sub TestStyleInitialize
	Dim style As JTSStyle
	style.Initialize

	If style.Stroke <> True Then        : Log(FailTest("Stroke should be True"))   : Return : End If
		If style.StrokeColor <> xui.Color_Black Then : Log(FailTest("StrokeColor wrong")) : Return : End If
			If style.StrokeWidth <> 2 Then      : Log(FailTest("StrokeWidth wrong"))       : Return : End If
				If style.Fill <> False Then         : Log(FailTest("Fill should be False"))    : Return : End If
					If style.PointShape <> style.SHAPE_CIRCLE Then : Log(FailTest("PointShape wrong")) : Return : End If
						If style.PointRadius <> 4 Then      : Log(FailTest("PointRadius wrong"))       : Return : End If
							Log(PassTest)
						End Sub

Private Sub TestStyleSetStroke
	Dim style As JTSStyle
	style.Initialize
	style.SetStroke(xui.Color_Blue, 5)

	If style.Stroke <> True Then            : Log(FailTest("Stroke not enabled"))    : Return : End If
		If style.StrokeColor <> xui.Color_Blue Then : Log(FailTest("StrokeColor wrong")) : Return : End If
			If style.StrokeWidth <> 5 Then          : Log(FailTest("StrokeWidth wrong"))     : Return : End If
				Log(PassTest)
			End Sub

Private Sub TestStyleSetFill
	Dim style As JTSStyle
	style.Initialize
	style.SetFill(xui.Color_Red)

	If style.Fill <> True Then              : Log(FailTest("Fill not enabled"))    : Return : End If
		If style.FillColor <> xui.Color_Red Then : Log(FailTest("FillColor wrong"))    : Return : End If
			Log(PassTest)
		End Sub

Private Sub TestStyleNoStrokeNoFill
	Dim style As JTSStyle
	style.Initialize
	style.NoStroke
	style.NoFill

	If style.Stroke <> False Then : Log(FailTest("Stroke should be False")) : Return : End If
		If style.Fill   <> False Then : Log(FailTest("Fill should be False"))   : Return : End If
			Log(PassTest)
		End Sub

Private Sub TestStyleClone
	Dim original As JTSStyle
	original.Initialize
	original.SetStroke(xui.Color_Blue, 3)
	original.SetFill(xui.Color_Red)

	Dim clone As JTSStyle = original.Clone

	clone.SetStroke(xui.Color_Green, 7)

	If original.StrokeColor <> xui.Color_Blue Then : Log(FailTest("Clone mutated original StrokeColor")) : Return : End If
		If original.StrokeWidth <> 3 Then              : Log(FailTest("Clone mutated original StrokeWidth")) : Return : End If
			Log(PassTest)
		End Sub

Private Sub TestStyleShapeConstants
	Dim style As JTSStyle
	style.Initialize

	If style.SHAPE_CIRCLE   <> 0 Then : Log(FailTest("SHAPE_CIRCLE wrong"))   : Return : End If
		If style.SHAPE_SQUARE   <> 1 Then : Log(FailTest("SHAPE_SQUARE wrong"))   : Return : End If
			If style.SHAPE_CROSS    <> 2 Then : Log(FailTest("SHAPE_CROSS wrong"))    : Return : End If
				If style.SHAPE_TRIANGLE <> 3 Then : Log(FailTest("SHAPE_TRIANGLE wrong")) : Return : End If
					Log(PassTest)
				End Sub

'##########################################################################
'# JTSDrawer tests
'##########################################################################

Private Sub TestDrawerInitialize
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	If drawer.Style.Stroke <> True Then  : Log(FailTest("Style not initialized"))     : Return : End If
		If drawer.PreserveAspect <> True Then : Log(FailTest("PreserveAspect wrong default")) : Return : End If
			
			Dim rect As B4XRect = drawer.GetTargetRect
			If rect.Width <= 0 Or rect.Height <= 0 Then : Log(FailTest("TargetRect not set")) : Return : End If
				Log(PassTest)
			End Sub

Private Sub TestDrawerSetViewport
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	' Get an envelope from a geometry (JTSEnvelope cannot be constructed directly).
	Dim refGeom As JTSGeometry = mJts.FromWKT("POLYGON((0 0, 100 0, 100 100, 0 100, 0 0))")
	Dim env As JTSEnvelope = refGeom.GetEnvelopeInternal
	drawer.SetViewport(env)

	Dim x As Float = drawer.WorldToCanvasX(50)
	If x < 0 Or x > cvs.TargetRect.Width Then
		Log(FailTest("Viewport not applied, got x=" & x))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerSetViewportRect
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)

	Dim x As Float = drawer.WorldToCanvasX(50)
	Dim expectedX As Float = cvs.TargetRect.Width / 2
	If Abs(x - expectedX) > 2 Then
		Log(FailTest("SetViewportRect failed, x=" & x & " expected=" & expectedX))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerSetViewportFromGeometry
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	Dim geom As JTSGeometry = mJts.FromWKT("POLYGON((10 10, 90 10, 90 90, 10 90, 10 10))")
	drawer.SetViewportFromGeometry(geom)

	Dim x1 As Float = drawer.WorldToCanvasX(10)
	Dim x2 As Float = drawer.WorldToCanvasX(90)
	If Abs(x2 - x1) < cvs.TargetRect.Width * 0.8 Then
		Log(FailTest("Viewport not fitted to geometry"))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerSetViewportFromGeometryPad
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	Dim geom As JTSGeometry = mJts.FromWKT("POLYGON((40 40, 60 40, 60 60, 40 60, 40 40))")
	drawer.SetViewportFromGeometryPad(geom, 20)

	Dim x1 As Float = drawer.WorldToCanvasX(40)
	Dim x2 As Float = drawer.WorldToCanvasX(60)
	If x1 <= 0 Or x2 >= cvs.TargetRect.Width Then
		Log(FailTest("Padding not applied correctly"))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerSetViewportFromGeometries
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	Dim geoms As List
	geoms.Initialize
	geoms.Add(mJts.FromWKT("POINT(10 10)"))
	geoms.Add(mJts.FromWKT("POINT(90 90)"))
	drawer.SetViewportFromGeometries(geoms, 5)

	Dim x1 As Float = drawer.WorldToCanvasX(10)
	Dim x2 As Float = drawer.WorldToCanvasX(90)
	If x1 < 0 Or x2 > cvs.TargetRect.Width Then
		Log(FailTest("Multi-geometry viewport failed"))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerSetTargetRect
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	Dim targetRect As B4XRect
	targetRect.Initialize(50, 50, 350, 350) 'ignore
	drawer.SetTargetRect(targetRect)

	Dim retrieved As B4XRect = drawer.GetTargetRect
	If retrieved.Left <> 50 Or retrieved.Width <> 300 Then
		Log(FailTest("SetTargetRect failed"))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerGetTargetRect
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	Dim rect As B4XRect = drawer.GetTargetRect
	If rect.Width <= 0 Or rect.Height <= 0 Then
		Log(FailTest("GetTargetRect returned invalid rect"))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerPreserveAspect
	' For the midpoint (50) the result is identical regardless of PreserveAspect.
	' A non-square target rect is needed to make the difference visible; we use
	' a hardcoded 400x200 rect (2:1) so the test is independent of canvas size.
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	Dim r As B4XRect
	r.Initialize(0, 0, 400, 200) 'ignore
	drawer.SetTargetRect(r)
	drawer.SetViewportRect(0, 0, 100, 100)   ' square viewport (1:1)

	' Test a corner point (90) where aspect handling makes the biggest difference.
	drawer.PreserveAspect = True
	drawer.InvalidateTransform
	Dim x1 As Float = drawer.WorldToCanvasX(90)

	drawer.PreserveAspect = False
	drawer.InvalidateTransform
	Dim x2 As Float = drawer.WorldToCanvasX(90)

	Log("PreserveAspect=True  x(90)=" & x1)
	Log("PreserveAspect=False x(90)=" & x2)

	If Abs(x1 - x2) < 1 Then
		Log(FailTest("PreserveAspect has no effect, x1=" & x1 & " x2=" & x2))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerWorldToCanvas
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)

	Dim x As Float = drawer.WorldToCanvasX(50)
	Dim y As Float = drawer.WorldToCanvasY(50)
	Dim centerX As Float = cvs.TargetRect.Width / 2
	Dim centerY As Float = cvs.TargetRect.Height / 2

	If Abs(x - centerX) > 2 Or Abs(y - centerY) > 2 Then
		Log(FailTest("WorldToCanvas wrong, x=" & x & " y=" & y))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestDrawerInvalidateTransform
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)

	drawer.SetViewportRect(0, 0, 100, 100)
	Dim x1 As Float = drawer.WorldToCanvasX(50)

	drawer.SetViewportRect(0, 0, 200, 200)
	drawer.InvalidateTransform
	Dim x2 As Float = drawer.WorldToCanvasX(50)

	If Abs(x1 - x2) < 1 Then
		Log(FailTest("InvalidateTransform not working"))
		Return
	End If
	Log(PassTest)
End Sub

'##########################################################################
'# JTSBCDrawer tests
'# Each test creates its own BitmapCreator at a known size (400x400) so
'# that coordinate assertions are canvas-size-independent.
'##########################################################################

Private Sub TestBCDrawerInitialize
	Dim bc As bitmapcreator
	bc.Initialize(400, 400)
	Dim drawer As JTSBCDrawer
	drawer.Initialize(bc)

	If drawer.Style.Stroke <> True Then  : Log(FailTest("Style not initialized"))        : Return : End If
		If drawer.PreserveAspect <> True Then : Log(FailTest("PreserveAspect wrong default")) : Return : End If
			
			Dim rect As B4XRect = drawer.GetTargetRect
			If rect.Width <> 400 Or rect.Height <> 400 Then
				Log(FailTest("TargetRect wrong"))
				Return
			End If
			Log(PassTest)
		End Sub

Private Sub TestBCDrawerSetViewport
	Dim bc As bitmapcreator
	bc.Initialize(400, 400)
	Dim drawer As JTSBCDrawer
	drawer.Initialize(bc)

	Dim refGeom As JTSGeometry = mJts.FromWKT("POLYGON((0 0, 100 0, 100 100, 0 100, 0 0))")
	Dim env As JTSEnvelope = refGeom.GetEnvelopeInternal
	drawer.SetViewport(env)

	Dim x As Float = drawer.WorldToBCX(50)
	If x < 0 Or x > 400 Then : Log(FailTest("Viewport not applied")) : Return : End If
		Log(PassTest)
	End Sub

Private Sub TestBCDrawerSetViewportRect
	Dim bc As bitmapcreator
	bc.Initialize(400, 400)
	Dim drawer As JTSBCDrawer
	drawer.Initialize(bc)
	drawer.SetViewportRect(0, 0, 100, 100)

	Dim x As Float = drawer.WorldToBCX(50)
	If Abs(x - 200) > 2 Then
		Log(FailTest("SetViewportRect failed, x=" & x))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestBCDrawerWorldToBC
	Dim bc As bitmapcreator
	bc.Initialize(400, 400)
	Dim drawer As JTSBCDrawer
	drawer.Initialize(bc)
	drawer.SetViewportRect(0, 0, 100, 100)

	Dim x As Float = drawer.WorldToBCX(50)
	Dim y As Float = drawer.WorldToBCY(50)
	If Abs(x - 200) > 2 Or Abs(y - 200) > 2 Then
		Log(FailTest("WorldToBC wrong, x=" & x & " y=" & y))
		Return
	End If
	Log(PassTest)
End Sub

Private Sub TestBCDrawerBatch
	Dim bc As bitmapcreator
	bc.Initialize(400, 400)
	Dim drawer As JTSBCDrawer
	drawer.Initialize(bc)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)

	drawer.BeginBatch
	drawer.AddGeometry(mJts.FromWKT("POINT(50 50)"))
	Log(PassTest)
End Sub

'##########################################################################
'# Geometry drawing tests
'# Each test draws to the shared canvas (cnv). The canvas content is
'# transient; the next interactive action redraws it.
'##########################################################################

Private Sub TestDrawPoint
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.Style.SetFill(xui.Color_Yellow)
	drawer.DrawGeometry(mJts.CreatePoint(50, 50).AsGeometry)
	Log(PassTest)
End Sub

Private Sub TestDrawMultiPoint
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)

	Dim pts As List
	pts.Initialize
	pts.Add(mJts.CreatePoint(20, 20))
	pts.Add(mJts.CreatePoint(80, 80))
	drawer.DrawGeometry(mJts.CreateMultiPoint(pts))
	Log(PassTest)
End Sub

Private Sub TestDrawLineString
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.DrawGeometry(mJts.FromWKT("LINESTRING(10 10, 90 90)"))
	Log(PassTest)
End Sub

Private Sub TestDrawPolygon
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.Style.SetFill(xui.Color_Yellow)
	drawer.DrawGeometry(mJts.FromWKT("POLYGON((20 20, 80 20, 80 80, 20 80, 20 20))"))
	Log(PassTest)
End Sub

Private Sub TestDrawPolygonWithHoles
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.Style.SetFill(xui.Color_Yellow)
	Dim wkt As String = "POLYGON((10 10, 90 10, 90 90, 10 90, 10 10), " _
		& "(30 30, 70 30, 70 70, 30 70, 30 30))"
	drawer.DrawGeometry(mJts.FromWKT(wkt))
	Log(PassTest)
End Sub

Private Sub TestDrawMultiPolygon
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.Style.SetFill(xui.Color_Cyan)
	Dim wkt As String = "MULTIPOLYGON(((10 10, 40 10, 40 40, 10 40, 10 10))," _
		& "((60 60, 90 60, 90 90, 60 90, 60 60)))"
	drawer.DrawGeometry(mJts.FromWKT(wkt))
	Log(PassTest)
End Sub

Private Sub TestDrawGeometryCollection
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.Style.SetFill(xui.Color_Magenta)

	Dim items As List
	items.Initialize
	items.Add(mJts.FromWKT("POINT(50 50)"))
	items.Add(mJts.FromWKT("LINESTRING(10 10, 90 90)"))
	drawer.DrawGeometry(mJts.CreateGeometryCollection(items))
	Log(PassTest)
End Sub

Private Sub TestEmptyGeometry
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0, 0, 100, 100)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.DrawGeometry(mJts.FromWKT("POINT EMPTY"))
	drawer.DrawGeometry(mJts.FromWKT("LINESTRING EMPTY"))
	drawer.DrawGeometry(mJts.FromWKT("POLYGON EMPTY"))
	Log(PassTest)
End Sub

'##########################################################################
'# Edge case tests
'##########################################################################

Private Sub TestLargeCoordinates
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(1000000, 2000000, 1000100, 2000100)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.DrawGeometry(mJts.FromWKT("POINT(1000050 2000050)"))
	Log(PassTest)
End Sub

Private Sub TestTinyCoordinates
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(0.0001, 0.0001, 0.0002, 0.0002)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.DrawGeometry(mJts.FromWKT("POINT(0.00015 0.00015)"))
	Log(PassTest)
End Sub

Private Sub TestNegativeCoordinates
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(-100, -100, 0, 0)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.DrawGeometry(mJts.FromWKT("POINT(-50 -50)"))
	Log(PassTest)
End Sub

Private Sub TestZeroWidthViewport
	Dim drawer As JTSDrawer
	drawer.Initialize(cvs)
	drawer.SetViewportRect(50, 50, 50, 50)
	drawer.Style.SetStroke(xui.Color_Black, 2)
	drawer.DrawGeometry(mJts.FromWKT("POINT(50 50)"))
	Log(PassTest)
End Sub
