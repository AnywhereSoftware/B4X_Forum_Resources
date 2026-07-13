Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
Sub Class_Globals
	Private mJts As JTSManager
	Private xui As XUI
	Private fontBold  As B4XFont
	Private fontSmall As B4XFont
	Private fontInfo  As B4XFont
End Sub

'JTS wrapper example renderings.
'
'Each public Draw* method is a self-contained example invoked by one
'button in B4XMainPage. It clears the entire canvas, renders into the
'supplied B4XRect region(s), and calls cvs.Invalidate once at the end.
'
'Two-region examples (Union, Affine) take regionA and regionB and render
'the "before" and "after" parts of the same operation side by side (or
'top/bottom, depending on Panel1 proportions).
'STRtree is a single-canvas example and takes one region.
Public Sub Initialize(jts As JTSManager)
	mJts = jts
	fontBold  = xui.CreateDefaultBoldFont(16)
	fontSmall = xui.CreateDefaultFont(14)
	fontInfo  = xui.CreateDefaultFont(12)

End Sub

'##########################################################################
'# Union
'##########################################################################

'Union example: regionA shows polygons A and B with their intersection
'highlighted; regionB shows the union polygon A ∪ B.
'Clears the entire canvas before drawing.
Public Sub DrawUnionExample(cvs As B4XCanvas, regionA As B4XRect, regionB As B4XRect)
	Dim polyA As JTSPolygon = mJts.CreatePolygon(BuildRingCoords(1.0, 1.0, 5.0, 5.0))
	Dim polyB As JTSPolygon = mJts.CreatePolygon(BuildRingCoords(3.0, 3.0, 7.0, 7.0))
	cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)
	RenderOverlappingPolygons(cvs, regionA, polyA, polyB)
	RenderUnion(cvs, regionB, polyA, polyB)
	cvs.Invalidate
End Sub

'Draws polygons A and B with their intersection in the given region.
Private Sub RenderOverlappingPolygons(cvs As B4XCanvas, region As B4XRect, polyA As JTSPolygon, polyB As JTSPolygon)
	Dim geomA   As JTSGeometry = polyA.AsGeometry
	Dim geomB   As JTSGeometry = polyB.AsGeometry
	Dim overlap As JTSGeometry = geomA.Intersection(geomB)

	Dim drawer As JTSDrawer = SetupDrawer(cvs, region)

	' Polygon A - blue
	drawer.Style.SetFill(xui.Color_ARGB(100, 100, 149, 237))
	drawer.Style.SetStroke(xui.Color_ARGB(255,  25,  50, 180), 2.5dip)
	drawer.DrawGeometry(geomA)

	' Polygon B - orange
	drawer.Style.SetFill(xui.Color_ARGB(100, 255, 165,   0))
	drawer.Style.SetStroke(xui.Color_ARGB(255, 180,  80,   0), 2.5dip)
	drawer.DrawGeometry(geomB)

	' Overlap - green
	If overlap.IsEmpty = False Then
		drawer.Style.SetFill(xui.Color_ARGB(160,  50, 180,  50))
		drawer.Style.SetStroke(xui.Color_ARGB(255,   0, 120,   0), 2.5dip)
		drawer.DrawGeometry(overlap)
	End If


	' Place A and B labels in the "A only" and "B only" regions (centroid of
	' the difference), so they don't fall on the green overlap boundary.
	DrawLabel(cvs, drawer, geomA.Difference(geomB).GetCentroid, "A",     fontBold,  xui.Color_ARGB(255,  25,  50, 180))
	DrawLabel(cvs, drawer, geomB.Difference(geomA).GetCentroid, "B",     fontBold,  xui.Color_ARGB(255, 180,  80,   0))
	If overlap.IsEmpty = False Then
		DrawLabel(cvs, drawer, overlap.GetCentroid, "A" & Chr(8745) & "B", fontSmall, xui.Color_ARGB(255,   0, 110,   0))
	End If

	Dim aA As Double = geomA.GetArea
	Dim aB As Double = geomB.GetArea
	Dim aO As Double = overlap.GetArea
	Dim txt As String = "A=" & NumberFormat(aA, 0, 2) & "  B=" & NumberFormat(aB, 0, 2) & _
		"  A" & Chr(8745) & "B=" & NumberFormat(aO, 0, 2)
	cvs.DrawText(txt, region.CenterX, region.Bottom - 6dip, fontInfo, xui.Color_DarkGray, "CENTER")

	Log("--- Union example, region A (intersection) ---")
	Log("Polygon A    : " & NumberFormat(aA, 0, 4))
	Log("Polygon B    : " & NumberFormat(aB, 0, 4))
	Log("Overlap A" & Chr(8745) & "B : " & NumberFormat(aO, 0, 4))
End Sub

'Draws the union of A and B in the given region.
Private Sub RenderUnion(cvs As B4XCanvas, region As B4XRect, polyA As JTSPolygon, polyB As JTSPolygon)
	Dim polys As List
	polys.Initialize
	polys.Add(polyA)
	polys.Add(polyB)
	Dim col   As JTSGeometry = mJts.CreateMultiPolygon(polys)
	Dim uGeom As JTSGeometry = col.UnionAll

	Dim drawer As JTSDrawer = SetupDrawer(cvs, region)

	' Union - purple
	drawer.Style.SetFill(xui.Color_ARGB(140, 160,  50, 210))
	drawer.Style.SetStroke(xui.Color_ARGB(255, 100,   0, 160), 2.5dip)
	drawer.DrawGeometry(uGeom)


	DrawLabel(cvs, drawer, uGeom.GetCentroid, "A" & Chr(8746) & "B", fontBold, xui.Color_ARGB(255, 80, 0, 140))

	Dim aU As Double = uGeom.GetArea
	cvs.DrawText("Area  A" & Chr(8746) & "B = " & NumberFormat(aU, 0, 4), _
		region.CenterX, region.Bottom - 6dip, fontInfo, xui.Color_DarkGray, "CENTER")

	Log("--- Union example, region B (union) ---")
	Log("Union A" & Chr(8746) & "B  : " & NumberFormat(aU, 0, 4))
	Log("(A + B - overlap = 16 + 16 - 4 = 28)")
End Sub

'##########################################################################
'# STRtree
'##########################################################################

'STRtree example: spatial index with envelope-vs-geometry filtering.
'6 indexed polygons and a search rectangle are drawn in region.
'Green = geometric hit, orange = envelope hit only (false positive),
'gray = no hit. Clears the entire canvas before drawing.
Public Sub DrawSTRtreeExample(cvs As B4XCanvas, region As B4XRect)

	' --- Build the world: 6 irregular polygons ---
	' Each polygon is defined as a List of JTSCoordinate (ring closed by
	' repeating the first point).
	Dim polys(6) As List

	' P1 - L-shape, lower left
	polys(0) = BuildCoords(Array As Double( _
		0.3, 0.3,  1.8, 0.3,  1.8, 1.2,  1.1, 1.2,  1.1, 2.2,  0.3, 2.2,  0.3, 0.3))

	' P2 - triangle, lower centre
	polys(1) = BuildCoords(Array As Double( _
		2.2, 0.3,  3.8, 0.3,  3.0, 2.0,  2.2, 0.3))

	' P3 - pentagon, positioned so its envelope overlaps the search region
	'       but the polygon geometry itself lies outside it.
	'       Envelope: x=[5.8,7.2], y=[2.0,4.0]
	'       Search region: x=[2.0,6.0], y=[3.0,6.5]
	'       Envelope overlap: x=[5.8,6.0], y=[3.0,4.0]  -> envelope HIT
	'       But all vertices have y <= 3.0 or x >= 6.0   -> geometry MISS
	polys(2) = BuildCoords(Array As Double( _
		5.8, 2.0,  7.2, 2.0,  7.2, 3.0,  6.8, 4.0,  6.2, 3.8,  5.8, 2.0))

	' P4 - arrow-head pointing right, left side mid
	polys(3) = BuildCoords(Array As Double( _
		0.3, 3.5,  1.5, 3.5,  2.2, 4.5,  1.5, 5.5,  0.3, 5.5,  0.3, 3.5))

	' P5 - irregular quad, centre
	polys(4) = BuildCoords(Array As Double( _
		3.0, 3.2,  5.5, 3.5,  5.8, 5.5,  2.8, 5.8,  3.0, 3.2))

	' P6 - trapezoid, upper right
	polys(5) = BuildCoords(Array As Double( _
		5.2, 5.8,  7.5, 5.5,  7.2, 7.5,  5.5, 7.5,  5.2, 5.8))

	Dim labels(6) As String
	labels(0) = "P1" : labels(1) = "P2" : labels(2) = "P3"
	labels(3) = "P4" : labels(4) = "P5" : labels(5) = "P6"

	' --- Index polygons in STRtree ---
	Dim tree As JTSSTRtree
	tree.Initialize(10)

	Dim geoms(6) As JTSGeometry
	Dim i As Int
	For i = 0 To 5
		Dim poly As JTSPolygon = mJts.CreatePolygon(polys(i))
		geoms(i) = poly.AsGeometry
		tree.Insert(geoms(i).GetEnvelopeInternal, labels(i))
	Next
	
	' --- Search region ---
	Dim searchEnv As JTSEnvelope = mJts.CreateEnvelope(2.0, 6.0, 3.0, 6.5)

	
	Dim dragX As String
	Dim dragY As String
	Do While True
		Dim hits As List = tree.Query(searchEnv)

		' --- Build search region geometry for the exact Intersects() test ---
		Dim searchGeom As JTSGeometry = mJts.CreatePolygon( _
			BuildRingCoords(searchEnv.GetMinX, searchEnv.GetMinY, _
			                searchEnv.GetMaxX, searchEnv.GetMaxY)).AsGeometry

		' --- Draw ---
		cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)
		Dim drawer As JTSDrawer = SetupDrawer(cvs, region)


		Dim envHits   As String = ""
		Dim exactHits As String = ""

		For i = 0 To 5
			Dim isEnvHit   As Boolean = hits.IndexOf(labels(i)) >= 0
			Dim isExactHit As Boolean = isEnvHit And geoms(i).Intersects(searchGeom)

			If isExactHit Then
				' Green - confirmed geometric hit
				drawer.Style.SetFill(xui.Color_ARGB(130,  30, 180, 120))
				drawer.Style.SetStroke(xui.Color_ARGB(255,   0, 120,  70), 2dip)
			Else If isEnvHit Then
				' Orange - envelope hit only (false positive)
				drawer.Style.SetFill(xui.Color_ARGB(130, 230, 140,  20))
				drawer.Style.SetStroke(xui.Color_ARGB(255, 180,  90,   0), 2dip)
			Else
				' Gray - no hit
				drawer.Style.SetFill(xui.Color_ARGB(70, 140, 140, 140))
				drawer.Style.SetStroke(xui.Color_ARGB(180,  90,  90,  90), 1.5dip)
			End If
			drawer.DrawGeometry(geoms(i))
			DrawLabel(cvs, drawer, geoms(i).GetCentroid, labels(i), fontBold, xui.Color_Black)

			If isEnvHit Then
				If envHits.Length > 0 Then envHits = envHits & ", "
				envHits = envHits & labels(i)
			End If
			If isExactHit Then
				If exactHits.Length > 0 Then exactHits = exactHits & ", "
				exactHits = exactHits & labels(i)
			End If
		Next

		' --- Draw the search region as a rectangle outline ---
		drawer.Style.SetStroke(xui.Color_ARGB(220, 30, 80, 210),2dip)
		drawer.Style.NoFill
		drawer.DrawGeometry(searchGeom)

		' Label above the search region
		Dim sx1 As Double = drawer.WorldToCanvasX(searchEnv.GetMinX)
		Dim sy1 As Double = drawer.WorldToCanvasY(searchEnv.GetMaxY)
		Dim sx2 As Double = drawer.WorldToCanvasX(searchEnv.GetMaxX)
		cvs.DrawText("interactive draggable search area", (sx1 + sx2) / 2, sy1 - 4dip, fontSmall, _
			xui.Color_ARGB(255, 30, 80, 210), "CENTER")

		' Info text at the bottom of the region
		cvs.DrawText("Envelope candidates: " & envHits & "   |   Geometric hits: " & exactHits, _
			region.CenterX, region.Bottom - 6dip, fontSmall, xui.Color_DarkGray, "CENTER")

		Log("--- STRtree example ---")
		Log("Indexed: P1 P2 P3 P4 P5 P6")
		Log("Search region: " & searchEnv.tostring)
		Log("Envelope candidates: " & envHits)
		Log("Geometric hits (Intersects): " & exactHits)
		Log("Note: P3 is an envelope hit but not a geometric hit (false positive).")

		cvs.Invalidate

		Wait For dragEvent(args As Map)
		If args.GetDefault("quit",False) Then Exit
		Dim x As Float = drawer.CanvasToWorldX( args.GetDefault("x",0))
		Dim y As Float = drawer.CanvasToWorldY( args.GetDefault("y",0))
		Dim minX As Double = searchEnv.GetMinX
		Dim maxX As Double = searchEnv.GetMaxX
		Dim minY As Double = searchEnv.GetMinY
		Dim maxY As Double = searchEnv.GetMaxY
		If args.GetDefault("start",False) Then
			Dim tol As Float = cvs.TargetRect.Width * 0.1   ' tolerans in pixels
			If x <= searchEnv.GetMidX And Abs(drawer.WorldToCanvasX(x)-drawer.WorldToCanvasX(minX)) < tol Then
				dragX = "minX"
				minX = x
			Else if Abs(drawer.WorldToCanvasX(x)-drawer.WorldToCanvasX(maxX)) < tol Then
				dragX = "maxX"
				maxX = x
			End If
			If y <= searchEnv.GetMidY And Abs(drawer.WorldToCanvasY(y)-drawer.WorldToCanvasY(minY)) < tol Then
				dragY = "minY"
				minY = Y
			Else if  Abs(drawer.WorldToCanvasY(y)-drawer.WorldToCanvasY(maxY)) < tol Then
				dragY = "maxY"
				maxY = y
			End If
			searchEnv = mJts.CreateEnvelope(minX, maxX, minY, maxY)
		Else 
			Select Case dragX 	
				Case "minX"
					minX = x 
				Case "maxX"
					maxX = x
			End Select
			Select Case dragY
				Case "minY"
					minY = Y
				Case "maxY"
					maxY = Y
			End Select
			searchEnv = mJts.CreateEnvelope(minX, maxX, minY, maxY)
		End If
		If args.GetDefault("stop",False) Then
			dragX = ""
			dragY = ""
		End If
	Loop
End Sub

Public Sub endSTRtree
	CallSub2(Me,"dragEvent",CreateMap("quit":True))
End Sub


'##########################################################################
'# Affine transformation
'##########################################################################

'Affine transformation example: regionA shows the original letter-F;
'regionB shows F rotated 30 degrees and scaled 1.2x about its centre,
'with a ghost of the original for comparison.
'Demonstrates the chain-style API of JTSAffineTransformation.
'Clears the entire canvas before drawing.
Public Sub DrawAffineExample(cvs As B4XCanvas, regionA As B4XRect, regionB As B4XRect)
	cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)
	RenderAffineOriginal(cvs, regionA)
	RenderAffineTransformed(cvs, regionB)
	cvs.Invalidate
End Sub

'Draws the original letter-F polygon in the given region.
Private Sub RenderAffineOriginal(cvs As B4XCanvas, region As B4XRect)
	Dim shape As JTSPolygon = mJts.CreatePolygon(BuildLetterF)

	Dim drawer As JTSDrawer = SetupDrawer(cvs, region)

	' Original F - blue
	drawer.Style.SetFill(xui.Color_ARGB(120, 100, 149, 237))
	drawer.Style.SetStroke(xui.Color_ARGB(255,  25,  50, 180), 2.5dip)
	drawer.DrawGeometry(shape.AsGeometry)

	DrawLabel(cvs, drawer, shape.AsGeometry.GetCentroid, "F", fontBold, xui.Color_ARGB(255, 25, 50, 180))
	cvs.DrawText("Original", region.CenterX, region.Bottom - 6dip, fontInfo, xui.Color_DarkGray, "CENTER")

	Log("--- Affine original ---")
	Log("Area:     " & NumberFormat(shape.AsGeometry.GetArea, 0, 4))
	Log("Centroid: " & shape.AsGeometry.GetCentroid.GetX & ", " & shape.AsGeometry.GetCentroid.GetY)
End Sub

'Draws the transformed F (rotated 30 deg, scaled 1.2x) in the given region,
'with a faint ghost of the original drawn underneath for comparison.
Private Sub RenderAffineTransformed(cvs As B4XCanvas, region As B4XRect)
	Dim shape As JTSPolygon = mJts.CreatePolygon(BuildLetterF)

	' Centre of rotation/scale: midpoint of the F's bounding box.
	Dim env As JTSEnvelope = shape.AsGeometry.GetEnvelopeInternal
	Dim cx As Double = (env.GetMinX + env.GetMaxX) / 2.0
	Dim cy As Double = (env.GetMinY + env.GetMaxY) / 2.0

	' Build the transformation: translate to origin, rotate 30 deg, scale 1.2x, translate back.
	' Result: rotation + scaling about (cx, cy), no net displacement.
	Dim at As JTSAffineTransformation
	at.Initialize
	Dim transformed As JTSGeometry = at _
		.Translate(-cx, -cy) _
		.Rotate(cPI / 6) _          ' 30 degrees
		.Scale(1.2, 1.2) _
		.Translate(cx, cy) _
		.Transform(shape.AsGeometry)

	Dim drawer As JTSDrawer = SetupDrawer(cvs, region)

	' Show a ghost of the original in light gray for comparison (outline only).
	drawer.Style.NoFill
	drawer.Style.SetStroke(xui.Color_ARGB(120, 150, 150, 150), 1.5dip)
	drawer.DrawGeometry(shape.AsGeometry)

	' Transformed F - purple
	drawer.Style.SetFill(xui.Color_ARGB(140, 160,  50, 210))
	drawer.Style.SetStroke(xui.Color_ARGB(255, 100,   0, 160), 2.5dip)
	drawer.DrawGeometry(transformed)

	DrawLabel(cvs, drawer, transformed.GetCentroid, "F'", fontBold, xui.Color_ARGB(255, 80, 0, 140))
	cvs.DrawText("Rotated 30" & Chr(176) & ", scaled 1.2" & Chr(215) & "  (ghost = original)", _
		region.CenterX, region.Bottom - 6dip, fontInfo, xui.Color_DarkGray, "CENTER")

	Log("--- Affine transformed ---")
	Log("Transformed area: " & NumberFormat(transformed.GetArea, 0, 4))
	Log("Area ratio (= scale^2): " & NumberFormat(transformed.GetArea / shape.AsGeometry.GetArea, 0, 4))
	Log("Determinant: " & NumberFormat(at.GetDeterminant, 0, 4) & "  (= 1.2^2 ~= 1.44)")
End Sub

'##########################################################################
'# Helpers
'##########################################################################

'Creates a JTSDrawer targeting region with a 30 dip inset on all sides.
'World extent x=[0..8], y=[0..8]; aspect ratio preserved (letterboxed).
Private Sub SetupDrawer(cvs As B4XCanvas, region As B4XRect) As JTSDrawer
	Dim d As JTSDrawer
	d.Initialize(cvs)
	Dim r As B4XRect
	r.Initialize(region.Left + 30dip, region.Top + 30dip, _
	             region.Right - 30dip, region.Bottom - 30dip)
	d.SetTargetRect(r)
	d.SetViewportRect(0, 0, 8, 8)
	Return d
End Sub

'Draws a centred text label at the world coordinates of the given centroid.
Private Sub DrawLabel(cvs As B4XCanvas, d As JTSDrawer, centroid As JTSPoint, txt As String, font As B4XFont, color As Int)
	cvs.DrawText(txt, d.WorldToCanvasX(centroid.GetX), d.WorldToCanvasY(centroid.GetY), font, color, "CENTER")
End Sub

'Builds a closed rectangular ring coordinate list (last point = first point).
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

'Builds a coordinate ring from a flat Double array: x0, y0, x1, y1, ...
'The last point must equal the first (closed ring).
Private Sub BuildCoords(pts() As Double) As List
	Dim result As List
	result.Initialize
	Dim i As Int
	For i = 0 To (pts.Length / 2) - 1
		result.Add(mJts.CreateCoordinate(pts(i * 2), pts(i * 2 + 1)))
	Next
	Return result
End Sub

'Builds a closed-ring coordinate list for the letter F.
'Bounds: (2.5, 1.0) to (5.5, 7.0). Width = 3, height = 6, centred at (4, 4).
'Traced counter-clockwise to ensure the polygon is valid.
Private Sub BuildLetterF As List
	Dim r As List
	r.Initialize
	r.Add(mJts.CreateCoordinate(2.5, 1.0))   ' bottom-left of stem
	r.Add(mJts.CreateCoordinate(3.5, 1.0))   ' bottom-right of stem
	r.Add(mJts.CreateCoordinate(3.5, 3.5))   ' up to middle bar
	r.Add(mJts.CreateCoordinate(5.0, 3.5))   ' right end of middle bar
	r.Add(mJts.CreateCoordinate(5.0, 4.5))   ' top of middle bar
	r.Add(mJts.CreateCoordinate(3.5, 4.5))   ' back to stem
	r.Add(mJts.CreateCoordinate(3.5, 6.0))   ' up to top bar
	r.Add(mJts.CreateCoordinate(5.5, 6.0))   ' right end of top bar
	r.Add(mJts.CreateCoordinate(5.5, 7.0))   ' top of top bar
	r.Add(mJts.CreateCoordinate(2.5, 7.0))   ' top-left
	r.Add(mJts.CreateCoordinate(2.5, 1.0))   ' close ring
	Return r
End Sub

