B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mjts As JTSManager

	Private statusLabel As B4XView
	Private cnv As B4XCanvas        ' shared canvas from B4XMainPage
	Private bc As BitmapCreator     ' sized to match cnv at Initialize time

	Private bcMode As Boolean       ' True = draw via BitmapCreator, False = direct Canvas
	Private currentTestIndex As Int
	Private testNames As List
End Sub

'Interactive visual test suite for the JTSDraw library.
'
'Displays one test at a time on the shared B4XCanvas. The active drawing
'mode (Canvas or BitmapCreator) is controlled by SetMode; call it before
'or after navigating tests and the current test redraws automatically.
'
'Usage from B4XMainPage:
'   testSuite.Initialize(lblStatus, cnv)
'   testSuite.SetMode(False)        ' start in Canvas mode
'   testSuite.RunTest(0)            ' show first test
'   testSuite.NextTest              ' navigate forward
'   testSuite.PrevTest              ' navigate backward
'   testSuite.GetTestCount          ' number of tests
Public Sub Initialize(lStatusLabel As B4XView, canvas As B4XCanvas, jts As JTSManager)
	statusLabel = lStatusLabel
	cnv = canvas

	' Size the BitmapCreator to match the canvas. If the canvas has not yet
	' been laid out (TargetRect is zero), fall back to a safe default size.
	Dim bcW As Int = canvas.TargetRect.Width
	Dim bcH As Int = canvas.TargetRect.Height
	If bcW <= 0 Then bcW = 800
	If bcH <= 0 Then bcH = 600
	bc.Initialize(bcW, bcH)

	mjts = jts
	InitializeTests
End Sub

'Sets the drawing mode. Redraws the current test immediately.
'enabled = True  → BitmapCreator mode
'enabled = False → direct Canvas mode
Public Sub SetMode(enabled As Boolean)
	bcMode = enabled
	If testNames.IsInitialized And testNames.Size > 0 Then
		ExecuteCurrentTest
	End If
End Sub

'Returns the number of tests in the suite.
Public Sub GetTestCount As Int
	Return testNames.Size
End Sub

'Returns the index of the currently displayed test.
Public Sub GetCurrentIndex As Int
	Return currentTestIndex
End Sub

'Returns the name of the currently displayed test.
Public Sub GetCurrentTestName As String
	If currentTestIndex < 0 Or currentTestIndex >= testNames.Size Then Return ""
	Return testNames.Get(currentTestIndex)
End Sub

'Displays the test at the given index.
Public Sub RunTest(index As Int)
	If index < 0 Then index = 0
	If index >= testNames.Size Then index = testNames.Size - 1
	currentTestIndex = index
	ExecuteCurrentTest
End Sub

'Navigates to the next test.
Public Sub NextTest
	If currentTestIndex < testNames.Size - 1 Then
		currentTestIndex = currentTestIndex + 1
		ExecuteCurrentTest
	End If
End Sub

'Navigates to the previous test.
Public Sub PrevTest
	If currentTestIndex > 0 Then
		currentTestIndex = currentTestIndex - 1
		ExecuteCurrentTest
	End If
End Sub

'##########################################################################
'# Internal - test list and dispatch
'##########################################################################

Private Sub InitializeTests
	testNames.Initialize

	' Geometry types
	testNames.Add("Point")
	testNames.Add("MultiPoint")
	testNames.Add("LineString")
	testNames.Add("LinearRing")
	testNames.Add("MultiLineString")
	testNames.Add("Polygon")
	testNames.Add("Polygon with holes")
	testNames.Add("MultiPolygon")
	testNames.Add("GeometryCollection")

	' Point shapes
	testNames.Add("Point SHAPE_CIRCLE")
	testNames.Add("Point SHAPE_SQUARE")
	testNames.Add("Point SHAPE_CROSS")
	testNames.Add("Point SHAPE_TRIANGLE")
	testNames.Add("Point varying radius")

	' Style variants
	testNames.Add("Style: only stroke")
	testNames.Add("Style: only fill")
	testNames.Add("Style: stroke and fill")
	testNames.Add("Style: thick stroke")

	' Viewport
	testNames.Add("PreserveAspect=True")
	testNames.Add("PreserveAspect=False")
	testNames.Add("SetViewportFromGeometries")
	testNames.Add("SetTargetRect: split view")

	' Edge cases
	testNames.Add("Empty geometry")
	testNames.Add("Negative coordinates")
	testNames.Add("Large coordinates")
	testNames.Add("Tiny coordinates")
	testNames.Add("Overlapping MultiPolygon w/ holes")
	testNames.Add("Nested GeometryCollection")
	testNames.Add("All 4 shape constants")
End Sub

Private Sub ExecuteCurrentTest
	If statusLabel.IsInitialized Then
		Dim modeStr As String
		If bcMode Then modeStr = "BC" Else modeStr = "Canvas"
		statusLabel.Text = (currentTestIndex + 1) & "/" & testNames.Size _
			& "  [" & modeStr & "]  " _
			& testNames.Get(currentTestIndex)
	End If

	ClearCanvas
	If bcMode Then ClearBC

	Dim testName As String = testNames.Get(currentTestIndex)
	Select testName
		Case "Point":                         DrawTest_Point
		Case "MultiPoint":                    DrawTest_MultiPoint
		Case "LineString":                    DrawTest_LineString
		Case "LinearRing":                    DrawTest_LinearRing
		Case "MultiLineString":               DrawTest_MultiLineString
		Case "Polygon":                       DrawTest_Polygon
		Case "Polygon with holes":            DrawTest_PolygonWithHoles
		Case "MultiPolygon":                  DrawTest_MultiPolygon
		Case "GeometryCollection":            DrawTest_GeometryCollection
		Case "Point SHAPE_CIRCLE":            DrawTest_PointShape(0, "CIRCLE")
		Case "Point SHAPE_SQUARE":            DrawTest_PointShape(1, "SQUARE")
		Case "Point SHAPE_CROSS":             DrawTest_PointShape(2, "CROSS")
		Case "Point SHAPE_TRIANGLE":          DrawTest_PointShape(3, "TRIANGLE")
		Case "Point varying radius":          DrawTest_VaryingRadius
		Case "Style: only stroke":            DrawTest_OnlyStroke
		Case "Style: only fill":              DrawTest_OnlyFill
		Case "Style: stroke and fill":        DrawTest_StrokeAndFill
		Case "Style: thick stroke":           DrawTest_ThickStroke
		Case "PreserveAspect=True":           DrawTest_PreserveAspectDemo(True)
		Case "PreserveAspect=False":          DrawTest_PreserveAspectDemo(False)
		Case "SetViewportFromGeometries":     DrawTest_ViewportFromGeometries
		Case "SetTargetRect: split view":     DrawTest_SplitView
		Case "Empty geometry":                DrawTest_Empty
		Case "Negative coordinates":          DrawTest_Negative
		Case "Large coordinates":             DrawTest_Large
		Case "Tiny coordinates":              DrawTest_Tiny
		Case "Overlapping MultiPolygon w/ holes": DrawTest_OverlappingHoles
		Case "Nested GeometryCollection":     DrawTest_NestedCollection
		Case "All 4 shape constants":         DrawTest_AllShapes
	End Select
End Sub

'##########################################################################
'# Internal - drawing helpers
'##########################################################################

'Fills the canvas with white.
Private Sub ClearCanvas
	cnv.DrawRect(cnv.TargetRect, xui.Color_White, True, 0)
	cnv.Invalidate
End Sub

'Fills the BitmapCreator with white.
Private Sub ClearBC
	Dim full As B4XRect
	full.Initialize(0, 0, bc.mWidth, bc.mHeight)
	bc.FillRect(xui.Color_White, full)
End Sub

'Draws a single geometry on the shared canvas using a JTSDrawer.
Private Sub DrawOnCanvas(geom As JTSGeometry, style As JTSStyle, pad As Double)
	Dim drawer As JTSDrawer
	drawer.Initialize(cnv)
	drawer.Style = style
	drawer.SetViewportFromGeometryPad(geom, pad)
	drawer.DrawGeometry(geom)
	cnv.Invalidate
End Sub

'Draws a single geometry via BitmapCreator and renders the result onto the
'shared canvas. Fire-and-forget: caller does not Wait For this sub.
Private Sub DrawOnBC(geom As JTSGeometry, style As JTSStyle, pad As Double) As ResumableSub
	Dim drawer As JTSBCDrawer
	drawer.Initialize(bc)
	drawer.Style = style
	drawer.SetViewportFromGeometryPad(geom, pad)
	drawer.BeginBatch
	drawer.AddGeometry(geom)
	Wait For (drawer.EndBatchAsync) Complete (bmp As B4XBitmap)
	cnv.DrawBitmap(bmp, cnv.TargetRect)
	cnv.Invalidate
	Return True
End Sub

'Builds a JTSStyle with the given stroke/fill settings.
Private Sub MakeStyle(strokeColor As Int, strokeWidth As Float, fillColor As Int, hasFill As Boolean) As JTSStyle
	Dim s As JTSStyle
	s.Initialize
	s.SetStroke(strokeColor, strokeWidth)
	If hasFill Then
		s.SetFill(fillColor)
	Else
		s.NoFill
	End If
	s.PointRadius = 8
	Return s
End Sub

'##########################################################################
'# Tests - geometry types
'##########################################################################

Private Sub DrawTest_Point
	Dim geom As JTSGeometry = mjts.CreatePoint(50, 50).AsGeometry
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Yellow, True)
	If bcMode Then DrawOnBC(geom, style, 10) Else DrawOnCanvas(geom, style, 10)
End Sub

Private Sub DrawTest_MultiPoint
	Dim pts As List
	pts.Initialize
	' Spiral av punkt utover frå sentrum (50,50)
	Dim cx As Double = 50, cy As Double = 50
	For i = 0 To 11
		Dim ang As Double = i * 36 ' grader
		Dim r As Double = 5 + i * 3.6
		pts.Add(mjts.CreatePoint(cx + r * CosD(ang), cy + r * SinD(ang)))
	Next
	Dim geom As JTSGeometry = mjts.CreateMultiPoint(pts)
	Dim style As JTSStyle = MakeStyle(xui.Color_Blue, 2, xui.Color_Cyan, True)
	style.PointRadius = 6
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_LineString
	Dim geom As JTSGeometry = mjts.FromWKT("LINESTRING(10 10, 30 80, 70 20, 90 90)")
	Dim style As JTSStyle = MakeStyle(xui.Color_Red, 3, 0, False)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_LinearRing
	Dim geom As JTSGeometry = mjts.FromWKT("LINEARRING(20 10, 90 35, 75 90, 30 95, 5 50, 20 10)")
	Dim style As JTSStyle = MakeStyle(xui.Color_DarkGray, 3, 0, False)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_MultiLineString
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("MULTILINESTRING(")
	Dim cx As Double = 50, cy As Double = 50
	' Fleire korte, spreidde strekar som IKKJE deler endepunkt
	Dim n As Int = 7
	For i = 0 To n - 1
		Dim a As Double = i * (360 / n)
		' kvar strek startar eit stykke ute og peikar utover, med eit lite knekk
		Dim rIn As Double = 18, rMid As Double = 32, rOut As Double = 44
		Dim x1 As Double = cx + rIn * CosD(a),      y1 As Double = cy + rIn * SinD(a)
		Dim x2 As Double = cx + rMid * CosD(a + 8), y2 As Double = cy + rMid * SinD(a + 8)
		Dim x3 As Double = cx + rOut * CosD(a - 4), y3 As Double = cy + rOut * SinD(a - 4)
		If i > 0 Then sb.Append(",")
		sb.Append($"(${NumberFormat(x1,0,2)} ${NumberFormat(y1,0,2)}, ${NumberFormat(x2,0,2)} ${NumberFormat(y2,0,2)}, ${NumberFormat(x3,0,2)} ${NumberFormat(y3,0,2)})"$)
	Next
	sb.Append(")")
	Dim geom As JTSGeometry = mjts.FromWKT(sb.ToString)
	Dim style As JTSStyle = MakeStyle(xui.Color_Magenta, 2, 0, False)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_Polygon
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((20 10, 90 35, 75 90, 30 95, 5 50, 20 10))")
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Green, True)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_PolygonWithHoles
	Dim wkt As String = $"POLYGON((20 10, 90 35, 75 90, 30 95, 5 50, 20 10), (30 35, 50 30, 48 55, 32 52, 30 35), (60 55, 78 60, 70 80, 55 72, 60 55))"$
	Dim geom As JTSGeometry = mjts.FromWKT(wkt)
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Yellow, True)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_MultiPolygon
	Dim wkt As String = $"MULTIPOLYGON(((25 8, 32 28, 52 28, 36 40, 42 60, 25 48, 8 60, 14 40, -2 28, 18 28, 25 8)), ((75 55, 92 68, 86 88, 64 88, 58 68, 75 55)))"$
	Dim geom As JTSGeometry = mjts.FromWKT(wkt)
	Dim style As JTSStyle = MakeStyle(xui.Color_Blue, 2, xui.Color_Cyan, True)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_GeometryCollection
	Dim items As List
	items.Initialize
	items.Add(mjts.FromWKT("POINT(20 20)"))
	items.Add(mjts.FromWKT("LINESTRING(30 30, 70 70)"))
	items.Add(mjts.FromWKT("POLYGON((50 10, 90 10, 90 40, 50 40, 50 10))"))

	Dim geom As JTSGeometry = mjts.CreateGeometryCollection(items)
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Magenta, True)
	style.PointRadius = 6
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

'##########################################################################
'# Tests - point shapes
'##########################################################################

Private Sub DrawTest_PointShape(shapeConst As Int, shapeName As String)
	Dim geom As JTSGeometry = mjts.CreatePoint(50, 50).AsGeometry
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Yellow, True)
	style.PointShape = shapeConst
	style.PointRadius = 15
	If bcMode Then DrawOnBC(geom, style, 30) Else DrawOnCanvas(geom, style, 30)
End Sub

Private Sub DrawTest_VaryingRadius
	Dim radii() As Int = Array As Int(2, 4, 6, 8, 10, 12)
	If bcMode Then
		Dim drawerBC As JTSBCDrawer
		drawerBC.Initialize(bc)
		drawerBC.SetViewportRect(0, 0, 100, 100)
		drawerBC.Style.SetStroke(xui.Color_Black, 2)
		drawerBC.Style.SetFill(xui.Color_Yellow)
		drawerBC.BeginBatch
		For i = 0 To radii.Length - 1
			drawerBC.Style.PointRadius = radii(i)
			drawerBC.AddGeometry(mjts.CreatePoint(15 + i * 15, 50).AsGeometry)
		Next
		Wait For (drawerBC.EndBatchAsync) Complete (bmp As B4XBitmap)
		cnv.DrawBitmap(bmp, cnv.TargetRect)
		cnv.Invalidate
	Else
		Dim drawer As JTSDrawer
		drawer.Initialize(cnv)
		drawer.SetViewportRect(0, 0, 100, 100)
		drawer.Style.SetStroke(xui.Color_Black, 2)
		drawer.Style.SetFill(xui.Color_Yellow)
		For i = 0 To radii.Length - 1
			drawer.Style.PointRadius = radii(i)
			drawer.DrawGeometry(mjts.CreatePoint(15 + i * 15, 50).AsGeometry)
		Next
		cnv.Invalidate
	End If
End Sub

'##########################################################################
'# Tests - style variants
'##########################################################################

Private Sub DrawTest_OnlyStroke
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((20 10, 90 35, 75 90, 30 95, 5 50, 20 10))")
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 3, 0, False)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_OnlyFill
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((20 10, 90 35, 75 90, 30 95, 5 50, 20 10))")
	Dim style As JTSStyle
	style.Initialize
	style.NoStroke
	style.SetFill(xui.Color_Yellow)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_StrokeAndFill
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((20 10, 90 35, 75 90, 30 95, 5 50, 20 10))")
	Dim style As JTSStyle = MakeStyle(xui.Color_Blue, 3, xui.Color_Cyan, True)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_ThickStroke
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((20 10, 90 35, 75 90, 30 95, 5 50, 20 10))")
	Dim style As JTSStyle = MakeStyle(xui.Color_Red, 8, xui.Color_Yellow, True)
	If bcMode Then DrawOnBC(geom, style, 10) Else DrawOnCanvas(geom, style, 10)
End Sub

'##########################################################################
'# Tests - viewport
'##########################################################################

Private Sub DrawTest_PreserveAspectDemo (preserve As Boolean)
	Dim col As Int = xui.Color_Black
	Dim fillcol As Int = xui.Color_Green
	Dim wktCircle As String = MakeNgonWKT(50, 50, 35, 24)
	Dim wkt As String = $"GEOMETRYCOLLECTION(POLYGON((10 10, 90 10, 90 90, 10 90, 10 10)), ${wktCircle}, LINESTRING(10 10, 90 90), LINESTRING(10 90, 90 10))"$
	Dim geom As JTSGeometry = mjts.FromWKT(wkt)

	Dim tr As B4XRect
	tr.Initialize(20, 20, 20 + 300, 20 + 100)

	If bcMode Then
		Dim dbc As JTSBCDrawer
		dbc.Initialize(bc)
		dbc.PreserveAspect = preserve
		dbc.SetTargetRect(tr)
		dbc.SetViewportRect(0, 0, 100, 100)
		dbc.Style.SetStroke(col, 2)
		dbc.Style.SetFill(fillcol)
		dbc.BeginBatch
		dbc.AddGeometry(geom)
		Wait For (dbc.EndBatchAsync) Complete (bmp As B4XBitmap)
		cnv.DrawBitmap(bmp, cnv.TargetRect)
		cnv.Invalidate
	Else
		Dim dcv As JTSDrawer
		dcv.Initialize(cnv)
		dcv.PreserveAspect = preserve
		dcv.SetTargetRect(tr)
		dcv.SetViewportRect(0, 0, 100, 100)
		dcv.Style.SetStroke(col, 2)
		dcv.Style.SetFill(fillcol)
		dcv.DrawGeometry(geom)
		cnv.Invalidate
	End If
End Sub

'Builds a closed polygon WKT approximating a circle, centred at (cx,cy)
'with the given radius and number of sides. First and last point coincide.
'cx: centre X in world units.
'cy: centre Y in world units.
'radius: circle radius in world units.
'sides: number of polygon edges (e.g. 24 for a smooth-looking circle).
Private Sub MakeNgonWKT (cx As Double, cy As Double, radius As Double, sides As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("POLYGON((")
	For i = 0 To sides
		Dim ang As Double = i * (360.0 / sides)
		Dim x As Double = cx + radius * CosD(ang)
		Dim y As Double = cy + radius * SinD(ang)
		If i > 0 Then sb.Append(", ")
		sb.Append($"${NumberFormat(x,0,3)} ${NumberFormat(y,0,3)}"$)
	Next
	sb.Append("))")
	Return sb.ToString
End Sub

Private Sub DrawTest_ViewportFromGeometries
	Dim geoms As List
	geoms.Initialize
	' Plassér geometriane i kvar sin kant så det blir tydeleg at viewporten
	' strekkjer seg for å femne ALLE — fjern ein, og ramma kryp saman.
	geoms.Add(mjts.FromWKT("POINT(15 80)"))                  ' oppe til venstre
	geoms.Add(mjts.FromWKT("POINT(85 20)"))                  ' nede til høgre
	geoms.Add(mjts.FromWKT("LINESTRING(20 15, 70 60)"))      ' på skrå nede til venstre
	geoms.Add(mjts.FromWKT("POLYGON((60 75, 90 75, 90 95, 60 95, 60 75))")) ' oppe til høgre

	' Den eksakte kombinerte boksen (utan padding) som geometriane spenner ut.
	Dim env As JTSGeometry = CombinedEnvelope(geoms)

	If bcMode Then
		Dim drawerBC As JTSBCDrawer
		drawerBC.Initialize(bc)
		drawerBC.SetViewportFromGeometries(geoms, 5)
		' Teikn envelope-ramma først: berre grå strek, ingen fyll.
		drawerBC.Style.SetStroke(xui.Color_LightGray, 1)
		drawerBC.Style.NoFill
		drawerBC.BeginBatch
		drawerBC.AddGeometry(env)
		' Så geometriane oppå, med synleg stil.
		drawerBC.Style.SetStroke(xui.Color_Black, 2)
		drawerBC.Style.SetFill(xui.Color_Yellow)
		drawerBC.Style.PointRadius = 8
		For Each g As JTSGeometry In geoms
			drawerBC.AddGeometry(g)
		Next
		Wait For (drawerBC.EndBatchAsync) Complete (bmp As B4XBitmap)
		cnv.DrawBitmap(bmp, cnv.TargetRect)
		cnv.Invalidate
	Else
		Dim drawer As JTSDrawer
		drawer.Initialize(cnv)
		drawer.SetViewportFromGeometries(geoms, 5)
		' Envelope-ramme først.
		drawer.Style.SetStroke(xui.Color_LightGray, 1)
		drawer.Style.NoFill
		drawer.DrawGeometry(env)
		' Geometriane oppå.
		drawer.Style.SetStroke(xui.Color_Black, 2)
		drawer.Style.SetFill(xui.Color_Yellow)
		drawer.Style.PointRadius = 8
		For Each g As JTSGeometry In geoms
			drawer.DrawGeometry(g)
		Next
		cnv.Invalidate
	End If
End Sub

'Computes the combined bounding box of all geometries in the list and returns
'it as a rectangular polygon (no padding) that can be drawn as a frame. This
'mirrors the union logic SetViewportFromGeometries uses internally, so the
'frame marks exactly the extent the auto-viewport was fitted to.
'geoms: a List of JTSGeometry. Empty geometries are skipped.
'Returns: a Polygon geometry outlining the combined envelope.
Private Sub CombinedEnvelope (geoms As List) As JTSGeometry
	Dim combined As JTSEnvelope
	Dim haveOne As Boolean = False
	For Each g As JTSGeometry In geoms
		If g.IsEmpty Then Continue
		If haveOne = False Then
			combined = g.GetEnvelopeInternal
			haveOne = True
		Else
			combined.ExpandToIncludeEnvelope(g.GetEnvelopeInternal)
		End If
	Next
	Dim wkt As String = $"POLYGON((${combined.GetMinX} ${combined.GetMinY}, ${combined.GetMaxX} ${combined.GetMinY}, ${combined.GetMaxX} ${combined.GetMaxY}, ${combined.GetMinX} ${combined.GetMaxY}, ${combined.GetMinX} ${combined.GetMinY}))"$
	Return mjts.FromWKT(wkt)
End Sub

Private Sub DrawTest_SplitView
	' Same polygon drawn side by side; left = yellow, right = cyan.
	' Demonstrates SetTargetRect splitting the canvas into two regions.
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((10 10, 90 10, 90 90, 10 90, 10 10))")
	If bcMode Then
		Dim drawerBC As JTSBCDrawer
		drawerBC.Initialize(bc)
		Dim bcRect1 As B4XRect
		bcRect1.Initialize(0, 0, bc.mWidth / 2, bc.mHeight)
		drawerBC.SetTargetRect(bcRect1)
		drawerBC.SetViewportRect(0, 0, 100, 100)
		drawerBC.Style.SetStroke(xui.Color_Black, 2)
		drawerBC.Style.SetFill(xui.Color_Yellow)
		drawerBC.BeginBatch
		drawerBC.AddGeometry(geom)
		' Bytt target og farge, hald fram i SAME batch.
		Dim bcRect2 As B4XRect
		bcRect2.Initialize(bc.mWidth / 2, 0, bc.mWidth, bc.mHeight)
		drawerBC.SetTargetRect(bcRect2)
		drawerBC.Style.SetFill(xui.Color_Cyan)
		drawerBC.AddGeometry(geom)
		Wait For (drawerBC.EndBatchAsync) Complete (bmp As B4XBitmap)
		cnv.DrawBitmap(bmp, cnv.TargetRect)
		cnv.Invalidate
	Else
		Dim drawer As JTSDrawer
		drawer.Initialize(cnv)
		Dim rect1 As B4XRect
		rect1.Initialize(0, 0, cnv.TargetRect.Width / 2, cnv.TargetRect.Height)
		drawer.SetTargetRect(rect1)
		drawer.SetViewportRect(0, 0, 100, 100)
		drawer.Style.SetStroke(xui.Color_Black, 2)
		drawer.Style.SetFill(xui.Color_Yellow)
		drawer.DrawGeometry(geom)
		Dim rect2 As B4XRect
		rect2.Initialize(cnv.TargetRect.Width / 2, 0, cnv.TargetRect.Width, cnv.TargetRect.Height)
		drawer.SetTargetRect(rect2)
		drawer.Style.SetFill(xui.Color_Cyan)
		drawer.DrawGeometry(geom)
		cnv.Invalidate
	End If
End Sub

'##########################################################################
'# Tests - edge cases
'##########################################################################

Private Sub DrawTest_Empty
	' Drawing empty geometries should be a no-op (no exception, no crash).
	If bcMode Then
		Dim drawerBC As JTSBCDrawer
		drawerBC.Initialize(bc)
		drawerBC.SetViewportRect(0, 0, 100, 100)
		drawerBC.Style.SetStroke(xui.Color_Black, 2)
		drawerBC.BeginBatch
		drawerBC.AddGeometry(mjts.FromWKT("POINT EMPTY"))
		drawerBC.AddGeometry(mjts.FromWKT("POLYGON EMPTY"))
		Wait For (drawerBC.EndBatchAsync) Complete (bmp As B4XBitmap)
		cnv.DrawBitmap(bmp, cnv.TargetRect)
		cnv.Invalidate
	Else
		Dim drawer As JTSDrawer
		drawer.Initialize(cnv)
		drawer.SetViewportRect(0, 0, 100, 100)
		drawer.Style.SetStroke(xui.Color_Black, 2)
		drawer.DrawGeometry(mjts.FromWKT("POINT EMPTY"))
		drawer.DrawGeometry(mjts.FromWKT("POLYGON EMPTY"))
		cnv.Invalidate
	End If
End Sub

Private Sub DrawTest_Negative
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((-80 -90, -10 -65, -25 -10, -70 -5, -95 -50, -80 -90))")
	Dim style As JTSStyle = MakeStyle(xui.Color_Red, 2, xui.Color_Magenta, True)
	If bcMode Then
		Wait For (DrawOnBC(geom, style, 10)) Complete (ok As Boolean)
	Else
		DrawOnCanvas(geom, style, 10)
	End If
	DrawCoordLabel(geom, "Negative coords")
	cnv.Invalidate
End Sub

Private Sub DrawTest_Large
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((1000020 2000010, 1000090 2000035, 1000075 2000090, 1000030 2000095, 1000005 2000050, 1000020 2000010))")
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Yellow, True)
	If bcMode Then
		Wait For (DrawOnBC(geom, style, 10)) Complete (ok As Boolean)
	Else
		DrawOnCanvas(geom, style, 10)
	End If
	DrawCoordLabel(geom, "Large coords")
	cnv.Invalidate
End Sub

Private Sub DrawTest_Tiny
	Dim geom As JTSGeometry = mjts.FromWKT("POLYGON((0.00012 0.00011, 0.00019 0.000135, 0.000175 0.00019, 0.00013 0.000195, 0.000105 0.00015, 0.00012 0.00011))")
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Cyan, True)
	If bcMode Then
		Wait For (DrawOnBC(geom, style, 0.00002)) Complete (ok As Boolean)
	Else
		DrawOnCanvas(geom, style, 0.00002)
	End If
	DrawCoordLabel(geom, "Tiny coords")
	cnv.Invalidate
End Sub

'Draws a screen-fixed text label (top-left) showing the geometry's bounding-box
'coordinate range. Uses NumberFormat2 with 6 decimals so very small values show
'in plain decimal form rather than scientific notation, and trims trailing
'whitespace for large integer-like values.
'geom: the geometry whose envelope is reported.
'title: a heading line shown above the X/Y ranges.
Private Sub DrawCoordLabel (geom As JTSGeometry, title As String)
	Dim env As JTSEnvelope = geom.GetEnvelopeInternal
	Dim minX As String = NumberFormat2(env.GetMinX, 1, 6, 0, False)
	Dim maxX As String = NumberFormat2(env.GetMaxX, 1, 6, 0, False)
	Dim minY As String = NumberFormat2(env.GetMinY, 1, 6, 0, False)
	Dim maxY As String = NumberFormat2(env.GetMaxY, 1, 6, 0, False)
	Dim lines As List
	lines.Initialize
	lines.Add(title)
	lines.Add($"X: ${minX} .. ${maxX}"$)
	lines.Add($"Y: ${minY} .. ${maxY}"$)
	Dim font As B4XFont = xui.CreateDefaultFont(14)
	Dim y As Float = 20dip
	For Each ln As String In lines
		cnv.DrawText(ln, 10dip, y, font, xui.Color_Black, "LEFT")
		y = y + 18dip
	Next
End Sub

Private Sub DrawTest_OverlappingHoles
	Dim wkt As String = "MULTIPOLYGON(" _
		& "((10 10, 70 10, 70 90, 10 90, 10 10))," _
		& "((40 20, 140 20, 140 80, 40 80, 40 20), (60 35, 120 35, 120 65, 60 65, 60 35))" _
		& ")"
	Dim geom As JTSGeometry = mjts.FromWKT(wkt)
	Dim style As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Yellow, True)
	If bcMode Then DrawOnBC(geom, style, 5) Else DrawOnCanvas(geom, style, 5)
End Sub

Private Sub DrawTest_NestedCollection
	Dim inner As List
	inner.Initialize
	inner.Add(mjts.FromWKT("POINT(30 30)"))
	inner.Add(mjts.FromWKT("LINESTRING(40 40, 60 60)"))
	Dim innerGC As JTSGeometry = mjts.CreateGeometryCollection(inner)

	Dim outer As List
	outer.Initialize
	outer.Add(innerGC)
	outer.Add(mjts.FromWKT("POLYGON((70 70, 90 70, 90 90, 70 90, 70 70))"))
	Dim geom As JTSGeometry = mjts.CreateGeometryCollection(outer)

	' Rammer rundt kvart collection-nivå sin envelope, så nøstinga blir synleg.
	Dim outerFrame As JTSGeometry = EnvelopeAsPolygon(geom)
	Dim innerFrame As JTSGeometry = EnvelopeAsPolygon(innerGC)

	Dim frameStyle As JTSStyle = MakeStyle(xui.Color_LightGray, 1, 0, False)
	Dim contentStyle As JTSStyle = MakeStyle(xui.Color_Black, 2, xui.Color_Cyan, True)
	contentStyle.PointRadius = 6

	If bcMode Then
		Dim dbc As JTSBCDrawer
		dbc.Initialize(bc)
		' Eitt felles viewport for ALLE lag = ytre geom + padding.
		dbc.SetViewportFromGeometryPad(geom, 5)
		dbc.BeginBatch
		' Rammer først (bakgrunn), så innhald oppå.
		dbc.Style = frameStyle
		dbc.AddGeometry(outerFrame)
		dbc.AddGeometry(innerFrame)
		dbc.Style = contentStyle
		dbc.AddGeometry(geom)
		Wait For (dbc.EndBatchAsync) Complete (bmp As B4XBitmap)
		cnv.DrawBitmap(bmp, cnv.TargetRect)
		cnv.Invalidate
	Else
		Dim dcv As JTSDrawer
		dcv.Initialize(cnv)
		dcv.SetViewportFromGeometryPad(geom, 5)
		dcv.Style = frameStyle
		dcv.DrawGeometry(outerFrame)
		dcv.DrawGeometry(innerFrame)
		dcv.Style = contentStyle
		dcv.DrawGeometry(geom)
		cnv.Invalidate
	End If
End Sub

'Returns the geometry's bounding box as a rectangular Polygon, usable as a
'visible frame. Mirrors the envelope JTSDrawer fits its viewport to.
'geom: any geometry (including a GeometryCollection).
'Returns: a closed rectangular Polygon outlining geom's envelope.
Private Sub EnvelopeAsPolygon (geom As JTSGeometry) As JTSGeometry
	Dim env As JTSEnvelope = geom.GetEnvelopeInternal
	Dim wkt As String = $"POLYGON((${env.GetMinX} ${env.GetMinY}, ${env.GetMaxX} ${env.GetMinY}, ${env.GetMaxX} ${env.GetMaxY}, ${env.GetMinX} ${env.GetMaxY}, ${env.GetMinX} ${env.GetMinY}))"$
	Return mjts.FromWKT(wkt)
End Sub

Private Sub DrawTest_AllShapes
	' Draws all four point shape constants side by side (CIRCLE, SQUARE, CROSS, TRIANGLE).
	If bcMode Then
		Dim drawerBC As JTSBCDrawer
		drawerBC.Initialize(bc)
		drawerBC.SetViewportRect(0, 0, 200, 50)
		drawerBC.Style.SetStroke(xui.Color_Black, 2)
		drawerBC.Style.SetFill(xui.Color_Yellow)
		drawerBC.Style.PointRadius = 12
		drawerBC.BeginBatch
		drawerBC.Style.PointShape = 0  ' CIRCLE
		drawerBC.AddGeometry(mjts.CreatePoint(25, 25).AsGeometry)
		drawerBC.Style.PointShape = 1  ' SQUARE
		drawerBC.AddGeometry(mjts.CreatePoint(75, 25).AsGeometry)
		drawerBC.Style.PointShape = 2  ' CROSS
		drawerBC.AddGeometry(mjts.CreatePoint(125, 25).AsGeometry)
		drawerBC.Style.PointShape = 3  ' TRIANGLE
		drawerBC.AddGeometry(mjts.CreatePoint(175, 25).AsGeometry)
		Wait For (drawerBC.EndBatchAsync) Complete (bmp As B4XBitmap)
		cnv.DrawBitmap(bmp, cnv.TargetRect)
		cnv.Invalidate
	Else
		Dim drawer As JTSDrawer
		drawer.Initialize(cnv)
		drawer.SetViewportRect(0, 0, 200, 50)
		drawer.Style.SetStroke(xui.Color_Black, 2)
		drawer.Style.SetFill(xui.Color_Yellow)
		drawer.Style.PointRadius = 12
		drawer.Style.PointShape = 0  ' CIRCLE
		drawer.DrawGeometry(mjts.CreatePoint(25, 25).AsGeometry)
		drawer.Style.PointShape = 1  ' SQUARE
		drawer.DrawGeometry(mjts.CreatePoint(75, 25).AsGeometry)
		drawer.Style.PointShape = 2  ' CROSS
		drawer.DrawGeometry(mjts.CreatePoint(125, 25).AsGeometry)
		drawer.Style.PointShape = 3  ' TRIANGLE
		drawer.DrawGeometry(mjts.CreatePoint(175, 25).AsGeometry)
		cnv.Invalidate
	End If
End Sub


