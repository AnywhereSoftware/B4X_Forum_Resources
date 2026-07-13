Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
'Draws JTS geometries onto a B4XCanvas.
'
'Usage:
'  Dim drawer As JTSDrawer
'  drawer.Initialize(cnv)
'  drawer.SetViewportFromGeometry(g)        ' or SetViewport(env)
'  drawer.Style.SetStroke(xui.Color_Black, 2)
'  drawer.Style.SetFill(xui.Color_Yellow)
'  drawer.DrawGeometry(g)
'  cnv.Invalidate
Sub Class_Globals
	Private mCanvas As B4XCanvas
	'Style used for all subsequent draws. Replace freely; e.g. drawer.Style = otherStyle.
	Public Style As JTSStyle
	
	'World viewport: the JTS coordinate window that maps to TargetRect on screen.
	Private mMinX, mMinY, mMaxX, mMaxY As Double
	Private mHasViewport As Boolean = False
	
	'Target rectangle on the canvas. Defaults to the full canvas.
	Private mTargetRect As B4XRect
	
	'If True (default), aspect ratio of the viewport is preserved (letterboxed
	'inside TargetRect). If False, the viewport is stretched to fill TargetRect,
	'which may distort shapes.
	Public PreserveAspect As Boolean = True
	
	'Cached transform values, recomputed by EnsureTransform.
	Private mScaleX, mScaleY As Double
	Private mOffsetX, mOffsetY As Double
	Private mTransformDirty As Boolean = True
	
	#if B4J
	'Lazy-initialised GraphicsContext2D for polygon-with-holes (B4J only).
	Private mGC As JavaObject
	Private mGCReady As Boolean = False
	#end if
End Sub

'Initialises the drawer with a B4XCanvas. The drawer uses the full canvas as
'target rectangle until SetTargetRect is called.
'cnv: an already-initialised B4XCanvas.
Public Sub Initialize(cnv As B4XCanvas)
	mCanvas = cnv
	Style.Initialize
	mTargetRect = cnv.TargetRect
End Sub

'--- Public configuration ----------------------------------------------------

'Sets the world-coordinate viewport (the JTS window that maps to the canvas).
'env: a JTSEnvelope describing the area of the world to display.
Public Sub SetViewport(env As JTSEnvelope)
	mMinX = env.GetMinX
	mMaxX = env.GetMaxX
	mMinY = env.GetMinY
	mMaxY = env.GetMaxY
	mHasViewport = True
	mTransformDirty = True
End Sub

'Sets the viewport directly from coordinate extents (avoids constructing an
'envelope via JTSManager).
Public Sub SetViewportRect(minX As Double, minY As Double, maxX As Double, maxY As Double)
	mMinX = minX
	mMaxX = maxX
	mMinY = minY
	mMaxY = maxY
	mHasViewport = True
	mTransformDirty = True
End Sub

'Convenience: fits the viewport to a geometry's bounding box with optional
'padding (in world units). pad = 0 gives an exact fit.
Public Sub SetViewportFromGeometry(geom As JTSGeometry)
	Dim env As JTSEnvelope = geom.GetEnvelopeInternal
	SetViewportRect(env.GetMinX, env.GetMinY, env.GetMaxX, env.GetMaxY)
End Sub

'Same as SetViewportFromGeometry but expands the envelope by pad world units
'on all four sides.
Public Sub SetViewportFromGeometryPad(geom As JTSGeometry, pad As Double)
	Dim env As JTSEnvelope = geom.GetEnvelopeInternal
	env.ExpandBy(pad)
	SetViewport(env)
End Sub

'Fits the viewport to the combined bounding box of several geometries, with
'optional padding (in world units) on all four sides. Empty geometries are
'skipped. Pass pad = 0 for an exact fit.
'
'geoms: a List of JTSGeometry. Order does not matter.
'pad:   world units added on every side after the union of envelopes.
Public Sub SetViewportFromGeometries(geoms As List, pad As Double)
	If geoms.Size = 0 Then Return
	Dim combined As JTSEnvelope
	Dim haveOne As Boolean = False
	For i = 0 To geoms.Size - 1
		Dim g As JTSGeometry = geoms.Get(i)
		If g.IsEmpty Then Continue
		If haveOne = False Then
			combined = g.GetEnvelopeInternal
			haveOne = True
		Else
			combined.ExpandToIncludeEnvelope(g.GetEnvelopeInternal)
		End If
	Next
	If haveOne = False Then Return    ' all geometries were empty
	If pad <> 0 Then combined.ExpandBy(pad)
	SetViewport(combined)
End Sub

'Sets the target rectangle on the canvas. Default is the full canvas.
Public Sub SetTargetRect(r As B4XRect)
	mTargetRect = r
	mTransformDirty = True
End Sub

'Returns the current target rectangle.
Public Sub GetTargetRect As B4XRect
	Return mTargetRect
End Sub

'--- Coordinate transform ----------------------------------------------------

'Converts a world point to canvas coordinates. Useful if the caller wants to
'draw something custom on top.
Public Sub WorldToCanvasX(worldX As Double) As Float
	EnsureTransform
	Return mOffsetX + (worldX - mMinX) * mScaleX
End Sub

'Converts a world point to canvas coordinates. Useful if the caller wants to
'draw something custom on top.
Public Sub WorldToCanvasY(worldY As Double) As Float
	EnsureTransform
	'Y is flipped: world Y up, canvas Y down.
	Return mOffsetY + (mMaxY - worldY) * mScaleY
End Sub

'Converts a canvas point back to world coordinates. Inverse of WorldToCanvasX.
Public Sub CanvasToWorldX(canvasX As Float) As Double
	EnsureTransform
	Return (canvasX - mOffsetX) / mScaleX + mMinX
End Sub

'Converts a canvas point back to world coordinates. Inverse of WorldToCanvasX.
Public Sub CanvasToWorldY(canvasY As Float) As Double
	EnsureTransform
	'Y is flipped: world Y up, canvas Y down.
	Return mMaxY - (canvasY - mOffsetY) / mScaleY
End Sub

Private Sub EnsureTransform
	If mTransformDirty = False Then Return
	If mHasViewport = False Then
		'No viewport set: identity (caller's coords are already canvas pixels).
		mScaleX = 1
		mScaleY = 1
		mOffsetX = 0
		mOffsetY = 0
		mTransformDirty = False
		Return
	End If
	
	Dim worldW As Double = mMaxX - mMinX
	Dim worldH As Double = mMaxY - mMinY
	If worldW <= 0 Then worldW = 1
	If worldH <= 0 Then worldH = 1
	
	Dim rectW As Double = mTargetRect.Width
	Dim rectH As Double = mTargetRect.Height
	
	Dim sx As Double = rectW / worldW
	Dim sy As Double = rectH / worldH
	
	If PreserveAspect Then
		'Letterbox: use the smaller scale, centre the result.
		Dim s As Double = Min(sx, sy)
		mScaleX = s
		mScaleY = s
		mOffsetX = mTargetRect.Left + (rectW - worldW * s) / 2
		mOffsetY = mTargetRect.Top + (rectH - worldH * s) / 2
	Else
		'Stretch.
		mScaleX = sx
		mScaleY = sy
		mOffsetX = mTargetRect.Left
		mOffsetY = mTargetRect.Top
	End If
	
	mTransformDirty = False
End Sub

'Marks the transform cache as dirty. Call if you mutate the target rect or
'viewport via aliases that bypass the setters above (rare).
Public Sub InvalidateTransform
	mTransformDirty = True
End Sub

'--- Main drawing entry point -----------------------------------------------

'Draws the geometry according to its type. Handles all eight geometry types
'returned by JTSGeometry.GetGeometryType: Point, MultiPoint, LineString,
'LinearRing, MultiLineString, Polygon, MultiPolygon, GeometryCollection.
Public Sub DrawGeometry(geom As JTSGeometry)
	If geom.IsEmpty Then Return
	EnsureTransform
	
	Dim t As String = geom.GetGeometryType
	Select t
		Case "Point"
			DrawPointGeom(geom.AsPoint)
		Case "MultiPoint"
			Dim n As Int = geom.GetNumGeometries
			For i = 0 To n - 1
				DrawPointGeom(geom.GetGeometryN(i).AsPoint)
			Next
		Case "LineString", "LinearRing"
			DrawLineString(geom.AsLineString, False)
		Case "MultiLineString"
			Dim n As Int = geom.GetNumGeometries
			For i = 0 To n - 1
				DrawLineString(geom.GetGeometryN(i).AsLineString, False)
			Next
		Case "Polygon"
			DrawPolygon(geom.AsPolygon)
		Case "MultiPolygon"
			Dim n As Int = geom.GetNumGeometries
			For i = 0 To n - 1
				DrawPolygon(geom.GetGeometryN(i).AsPolygon)
			Next
		Case "GeometryCollection"
			Dim n As Int = geom.GetNumGeometries
			For i = 0 To n - 1
				DrawGeometry(geom.GetGeometryN(i))   ' recurse
			Next
		Case Else
			Log("JTSDrawer: unknown geometry type: " & t)
	End Select
End Sub

'--- Type-specific drawing --------------------------------------------------

Private Sub DrawPointGeom(p As JTSPoint)
	Dim cx As Float = WorldToCanvasX(p.GetX)
	Dim cy As Float = WorldToCanvasY(p.GetY)
	Dim r As Float = Style.PointRadius
	
	Select Style.PointShape
		Case Style.SHAPE_CIRCLE
			If Style.Fill Then mCanvas.DrawCircle(cx, cy, r, Style.FillColor, True, 0)
			If Style.Stroke Then mCanvas.DrawCircle(cx, cy, r, Style.StrokeColor, False, Style.StrokeWidth)
		Case Style.SHAPE_SQUARE
			Dim sq As B4XRect
			sq.Initialize(cx - r, cy - r, cx + r, cy + r)
			If Style.Fill Then mCanvas.DrawRect(sq, Style.FillColor, True, 0)
			If Style.Stroke Then mCanvas.DrawRect(sq, Style.StrokeColor, False, Style.StrokeWidth)
		Case Style.SHAPE_CROSS
			If Style.Stroke Then
				mCanvas.DrawLine(cx - r, cy, cx + r, cy, Style.StrokeColor, Style.StrokeWidth)
				mCanvas.DrawLine(cx, cy - r, cx, cy + r, Style.StrokeColor, Style.StrokeWidth)
			End If
		Case Style.SHAPE_TRIANGLE
			'Upward-pointing equilateral-ish triangle bounded by 2r.
			Dim path As B4XPath
			path.Initialize(cx, cy - r)
			path.LineTo(cx + r, cy + r)
			path.LineTo(cx - r, cy + r)
			path.LineTo(cx, cy - r)
			If Style.Fill Then mCanvas.DrawPath(path, Style.FillColor, True, 0)
			If Style.Stroke Then mCanvas.DrawPath(path, Style.StrokeColor, False, Style.StrokeWidth)
	End Select
End Sub

'Draws a LineString (or LinearRing). If forceClose is True the path is closed
'even if start <> end (used internally when stroking polygon rings).
'
'Platform note:
'  B4A: cnv.DrawLine segment by segment. Android Path/Canvas is fast and
'       cnv.DrawPath with Filled=False does NOT auto-close, but DrawLine is
'       just as fast and avoids any path allocation.
'  B4J: cnv.DrawPath auto-closes back to the first point even with
'       Filled=False, which is wrong for open LineStrings. We bypass
'       B4XCanvas and call GraphicsContext2D directly. This is also much
'       faster than calling cnv.DrawLine per segment because we set
'       stroke/width once and stream the path in a single beginPath/stroke.
Private Sub DrawLineString(ls As JTSLineString, forceClose As Boolean)
	If Style.Stroke = False Then Return
	Dim geom As JTSGeometry = ls.AsGeometry
	Dim n As Int = geom.GetNumPoints
	If n < 2 Then Return
	
	#if B4A
	Dim prev As JTSPoint = ls.GetPointN(0)
	Dim px As Float = WorldToCanvasX(prev.GetX)
	Dim py As Float = WorldToCanvasY(prev.GetY)
	Dim firstX As Float = px
	Dim firstY As Float = py
	For i = 1 To n - 1
		Dim p As JTSPoint = ls.GetPointN(i)
		Dim cx As Float = WorldToCanvasX(p.GetX)
		Dim cy As Float = WorldToCanvasY(p.GetY)
		mCanvas.DrawLine(px, py, cx, cy, Style.StrokeColor, Style.StrokeWidth)
		px = cx
		py = cy
	Next
	If forceClose Then
		mCanvas.DrawLine(px, py, firstX, firstY, Style.StrokeColor, Style.StrokeWidth)
	End If
	#else if B4J
	EnsureGC
	mGC.RunMethod("setStroke", Array(XuiColorToFxColor(Style.StrokeColor)))
	mGC.RunMethod("setLineWidth", Array(Style.StrokeWidth + 0.0))
	mGC.RunMethod("beginPath", Null)
	Dim p0 As JTSPoint = ls.GetPointN(0)
	mGC.RunMethod("moveTo", Array(WorldToCanvasX(p0.GetX) + 0.0, WorldToCanvasY(p0.GetY) + 0.0))
	For i = 1 To n - 1
		Dim p As JTSPoint = ls.GetPointN(i)
		mGC.RunMethod("lineTo", Array(WorldToCanvasX(p.GetX) + 0.0, WorldToCanvasY(p.GetY) + 0.0))
	Next
	If forceClose Then
		mGC.RunMethod("closePath", Null)
	End If
	mGC.RunMethod("stroke", Null)
	#end if
End Sub

'Draws a single polygon, possibly with holes. Fill uses even-odd rule so holes
'are subtracted from the shell. Stroke is drawn ring-by-ring afterwards so the
'outline is independent of the fill path.
Private Sub DrawPolygon(poly As JTSPolygon)
	Dim numHoles As Int = poly.GetNumInteriorRing
	
	If numHoles = 0 Then
		DrawSimplePolygon(poly)
	Else
		DrawPolygonWithHoles(poly)
	End If
End Sub

'Polygon without holes: simple B4XPath, works identically on B4A and B4J.
Private Sub DrawSimplePolygon(poly As JTSPolygon)
	Dim shell As JTSLineString = poly.GetExteriorRing
	Dim shellGeom As JTSGeometry = shell.AsGeometry
	Dim n As Int = shellGeom.GetNumPoints
	If n < 2 Then Return
	
	If Style.Fill Then
		#if B4A
		Dim p0 As JTSPoint = shell.GetPointN(0)
		Dim path As B4XPath
		path.Initialize(WorldToCanvasX(p0.GetX), WorldToCanvasY(p0.GetY))
		For i = 1 To n - 1
			Dim p As JTSPoint = shell.GetPointN(i)
			path.LineTo(WorldToCanvasX(p.GetX), WorldToCanvasY(p.GetY))
		Next
		mCanvas.DrawPath(path, Style.FillColor, True, 0)
		#else if B4J
		EnsureGC	
		'Set even-odd fill rule and fill colour.
		Dim fillRule As JavaObject
		fillRule.InitializeStatic("javafx.scene.shape.FillRule")
		mGC.RunMethod("setFillRule", Array(fillRule.GetField("EVEN_ODD")))
		mGC.RunMethod("setFill", Array(XuiColorToFxColor(Style.FillColor)))
	
		'Build the path.
		mGC.RunMethod("beginPath", Null)
		AddRingToGC(shell)
		mGC.RunMethod("fill", Null)
		#end if
	End If
	
	'Outline via DrawLine segments — see comment on DrawLineString for the
	'reason. forceClose=True ensures the ring is closed even if the source
	'coordinates do not repeat the start point.
	If Style.Stroke Then
		DrawLineString(shell, True)
	End If
End Sub

'Polygon with one or more holes. Platform-specific because:
'  B4A: Android Path is even-odd fill by default; one B4XPath with multiple
'       subpaths (each ring re-opened with moveTo) produces correct fill.
'  B4J: B4XCanvas.DrawPath does not expose multiple subpaths reliably; we go
'       directly to javafx.scene.canvas.GraphicsContext2D with FillRule.EVEN_ODD.
'In both cases we then stroke each ring separately for a clean outline.
Private Sub DrawPolygonWithHoles(poly As JTSPolygon)
	Dim shell As JTSLineString = poly.GetExteriorRing
	Dim numHoles As Int = poly.GetNumInteriorRing
	
	If Style.Fill Then
		#if B4A
		FillPolygonWithHoles_B4A(shell, poly, numHoles)
		#else if B4J
		FillPolygonWithHoles_B4J(shell, poly, numHoles)
		#end if
	End If
	
	'Stroke each ring independently so holes also get an outline.
	If Style.Stroke Then
		DrawLineString(shell, True)
		For h = 0 To numHoles - 1
			DrawLineString(poly.GetInteriorRingN(h), True)
		Next
	End If
End Sub

#if B4A
Private Sub FillPolygonWithHoles_B4A(shell As JTSLineString, poly As JTSPolygon, numHoles As Int)
	Dim shellGeom As JTSGeometry = shell.AsGeometry
	Dim n As Int = shellGeom.GetNumPoints
	If n < 2 Then Return
	
	Dim p0 As JTSPoint = shell.GetPointN(0)
	Dim path As B4XPath
	path.Initialize(WorldToCanvasX(p0.GetX), WorldToCanvasY(p0.GetY))
	For i = 1 To n - 1
		Dim p As JTSPoint = shell.GetPointN(i)
		path.LineTo(WorldToCanvasX(p.GetX), WorldToCanvasY(p.GetY))
	Next
	'Close shell explicitly so subsequent moveTo starts a fresh subpath cleanly.
	path.LineTo(WorldToCanvasX(p0.GetX), WorldToCanvasY(p0.GetY))
	
	'Each hole: re-open with moveTo to create a new subpath.
	'B4XPath has no moveTo, so reach through JavaObject.
	Dim pjo As JavaObject = path
	For h = 0 To numHoles - 1
		Dim ring As JTSLineString = poly.GetInteriorRingN(h)
		Dim rGeom As JTSGeometry = ring.AsGeometry
		Dim rn As Int = rGeom.GetNumPoints
		If rn < 2 Then Continue
		Dim rp0 As JTSPoint = ring.GetPointN(0)
		Dim rx0 As Float = WorldToCanvasX(rp0.GetX)
		Dim ry0 As Float = WorldToCanvasY(rp0.GetY)
		pjo.RunMethod("moveTo", Array(rx0, ry0))
		For i = 1 To rn - 1
			Dim rp As JTSPoint = ring.GetPointN(i)
			path.LineTo(WorldToCanvasX(rp.GetX), WorldToCanvasY(rp.GetY))
		Next
		path.LineTo(rx0, ry0)
	Next
	
	'Android Path defaults to WINDING; we need EVEN_ODD so holes are subtracted.
	Dim ftCls As JavaObject
	ftCls.InitializeStatic("android.graphics.Path$FillType")
	pjo.RunMethod("setFillType", Array(ftCls.GetField("EVEN_ODD")))
	
	mCanvas.DrawPath(path, Style.FillColor, True, 0)
End Sub
#end if

#if B4J
Private Sub EnsureGC
	If mGCReady Then Return
	mGC = mCanvas.As(JavaObject).GetFieldJO("cvs").RunMethodJO("getObject", Null).RunMethod("getGraphicsContext2D", Null)
	mGCReady = True
End Sub

Private Sub FillPolygonWithHoles_B4J(shell As JTSLineString, poly As JTSPolygon, numHoles As Int)
	EnsureGC
	
	'Set even-odd fill rule and fill colour.
	Dim fillRule As JavaObject
	fillRule.InitializeStatic("javafx.scene.shape.FillRule")
	mGC.RunMethod("setFillRule", Array(fillRule.GetField("EVEN_ODD")))
	mGC.RunMethod("setFill", Array(XuiColorToFxColor(Style.FillColor)))
	
	'Build the path.
	mGC.RunMethod("beginPath", Null)
	AddRingToGC(shell)
	For h = 0 To numHoles - 1
		AddRingToGC(poly.GetInteriorRingN(h))
	Next
	mGC.RunMethod("fill", Null)
End Sub

Private Sub AddRingToGC(ring As JTSLineString)
	Dim ringGeom As JTSGeometry = ring.AsGeometry
	Dim n As Int = ringGeom.GetNumPoints
	If n < 2 Then Return
	Dim p0 As JTSPoint = ring.GetPointN(0)
	Dim x0 As Double = WorldToCanvasX(p0.GetX)
	Dim y0 As Double = WorldToCanvasY(p0.GetY)
	mGC.RunMethod("moveTo", Array(x0, y0))
	For i = 1 To n - 1
		Dim p As JTSPoint = ring.GetPointN(i)
		mGC.RunMethod("lineTo", Array(WorldToCanvasX(p.GetX) + 0.0, WorldToCanvasY(p.GetY) + 0.0))
	Next
	mGC.RunMethod("closePath", Null)
End Sub

Private Sub XuiColorToFxColor(xuiColor As Int) As JavaObject
	Dim a As Int = Bit.And(Bit.ShiftRight(xuiColor, 24), 0xFF)
	Dim r As Int = Bit.And(Bit.ShiftRight(xuiColor, 16), 0xFF)
	Dim g As Int = Bit.And(Bit.ShiftRight(xuiColor, 8),  0xFF)
	Dim b As Int = Bit.And(xuiColor, 0xFF)
	Dim colorCls As JavaObject
	colorCls.InitializeStatic("javafx.scene.paint.Color")
	Return colorCls.RunMethod("rgb", Array(r, g, b, a / 255.0))
End Sub
#end if
