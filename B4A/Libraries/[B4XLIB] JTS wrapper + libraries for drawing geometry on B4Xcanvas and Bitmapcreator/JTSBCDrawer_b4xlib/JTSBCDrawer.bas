Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
'Draws JTS geometries onto a BitmapCreator using its asynchronous batch API.
'
'Workflow:
'  Dim drawer As JTSBCDrawer
'  drawer.Initialize(bc)
'  drawer.SetViewportFromGeometry(g)
'  drawer.Style.SetStroke(xui.Color_Black, 2)
'  drawer.Style.SetFill(xui.Color_Yellow)
'
'  drawer.BeginBatch
'  drawer.AddGeometry(g1)
'  drawer.AddGeometry(g2)
'  Wait For (drawer.EndBatchAsync) Complete (bmp As B4XBitmap)
'  '... assign bmp to ImageView or similar
'
'API mirrors JTSDrawer (which draws on a B4XCanvas), except that drawing is
'always asynchronous and is performed in a batch. Style/viewport setup is the
'same.
'
'Polygons with holes are supported via transparent layer compositing.
Sub Class_Globals
	Private mBC As BitmapCreator
	
	'Style used for all subsequent draws. Replace freely; the drawer reads
	'the current style each time AddGeometry is called.
	Public Style As JTSStyle
	
	'World viewport: the JTS coordinate window that maps to TargetRect.
	Private mMinX, mMinY, mMaxX, mMaxY As Double
	Private mHasViewport As Boolean = False
	
	'Target rectangle on the BC. Defaults to (0, 0, mBC.mWidth, mBC.mHeight).
	Private mTargetRect As B4XRect
	
	'If True (default), aspect ratio is preserved (letterboxed); otherwise the
	'viewport is stretched to fill TargetRect.
	Public PreserveAspect As Boolean = True
	
	'Cached transform.
	Private mScaleX, mScaleY As Double
	Private mOffsetX, mOffsetY As Double
	Private mTransformDirty As Boolean = True
	
	'--- Batch state ---
	'Tasks accumulated between BeginBatch and EndBatchAsync.
	Private mTasks As List
	Private mPolygonsUnderConstruction As Map
	Private mInBatch As Boolean = False
	Private mBatchRunning As Boolean    'true while DrawBitmapCreatorsAsync is executing
	
	'--- Brush cache ---
	'BC requires brushes (not raw colours) for the async API. We maintain a
	'cache keyed by colour so we don't allocate per-call. Two brushes are kept
	'eagerly hot because they're used heavily: the current stroke and fill.
	Private mBrushCache As Map        ' Int colour -> bcbrush
	Private mStrokeBrush As bcbrush
	Private mStrokeBrushColor As Int = 0
	Private mStrokeBrushValid As Boolean = False
	Private mFillBrush As bcbrush
	Private mFillBrushColor As Int = 0
	Private mFillBrushValid As Boolean = False
End Sub

'Initialises the drawer with a target BitmapCreator. The drawer uses the full
'BC as target rectangle until SetTargetRect is called.
'bc: an already-initialised BitmapCreator.
Public Sub Initialize(bc As bitmapcreator)
	mBC = bc
	Style.Initialize
	mTargetRect.Initialize(0, 0, bc.mWidth, bc.mHeight)
	mBrushCache.Initialize
	mPolygonsUnderConstruction.Initialize 
End Sub

'--- Viewport configuration -------------------------------------------------

Public Sub SetViewport(env As JTSEnvelope)
	mMinX = env.GetMinX
	mMaxX = env.GetMaxX
	mMinY = env.GetMinY
	mMaxY = env.GetMaxY
	mHasViewport = True
	mTransformDirty = True
End Sub

Public Sub SetViewportRect(minX As Double, minY As Double, maxX As Double, maxY As Double)
	mMinX = minX : mMaxX = maxX : mMinY = minY : mMaxY = maxY
	mHasViewport = True
	mTransformDirty = True
End Sub

Public Sub SetViewportFromGeometry(geom As JTSGeometry)
	Dim env As JTSEnvelope = geom.GetEnvelopeInternal
	SetViewport(env)
End Sub

Public Sub SetViewportFromGeometryPad(geom As JTSGeometry, pad As Double)
	Dim env As JTSEnvelope = geom.GetEnvelopeInternal
	env.ExpandBy(pad)
	SetViewport(env)
End Sub

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
	If haveOne = False Then Return
	If pad <> 0 Then combined.ExpandBy(pad)
	SetViewport(combined)
End Sub

Public Sub SetTargetRect(r As B4XRect)
	mTargetRect = r
	mTransformDirty = True
End Sub

Public Sub GetTargetRect As B4XRect
	Return mTargetRect
End Sub

'--- Coordinate transform ----------------------------------------------------

'Converts a world point to BC coordinates. Useful if the caller wants to
'draw something custom on top.
Public Sub WorldToBCX(worldX As Double) As Float
	EnsureTransform
	Return mOffsetX + (worldX - mMinX) * mScaleX
	'Return Floor(mOffsetX + (worldX - mMinX) * mScaleX)
End Sub

'Converts a world point to BC coordinates. Useful if the caller wants to
'draw something custom on top.
Public Sub WorldToBCY(worldY As Double) As Float
	EnsureTransform
	Return mOffsetY + (mMaxY - worldY) * mScaleY
	'Return Floor(mOffsetY + (mMaxY - worldY) * mScaleY)
End Sub

'Converts a BC/canvas point back to world coordinates. Inverse of WorldToBCX.
Public Sub BCToWorldX(bcX As Float) As Double
	EnsureTransform
	Return (bcX - mOffsetX) / mScaleX + mMinX
End Sub

Public Sub BCToWorldY(bcY As Float) As Double
	EnsureTransform
	'Y is flipped: world Y up, BC Y down.
	Return mMaxY - (bcY - mOffsetY) / mScaleY
End Sub

Private Sub EnsureTransform
	If mTransformDirty = False Then Return
	If mHasViewport = False Then
		mScaleX = 1 : mScaleY = 1
		mOffsetX = 0 : mOffsetY = 0
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
		Dim s As Double = Min(sx, sy)
		mScaleX = s : mScaleY = s
		mOffsetX = mTargetRect.Left + (rectW - worldW * s) / 2
		mOffsetY = mTargetRect.Top + (rectH - worldH * s) / 2
	Else
		mScaleX = sx : mScaleY = sy
		mOffsetX = mTargetRect.Left
		mOffsetY = mTargetRect.Top
	End If
	mTransformDirty = False
End Sub

Public Sub InvalidateTransform
	mTransformDirty = True
End Sub

'--- Brush management --------------------------------------------------------

'Returns the cached stroke brush, creating it (or replacing it) if the current
'style colour has changed since last use.
Private Sub GetStrokeBrush As bcbrush
	If mStrokeBrushValid = False Or mStrokeBrushColor <> Style.StrokeColor Then
		mStrokeBrush = GetBrushForColor(Style.StrokeColor)
		mStrokeBrushColor = Style.StrokeColor
		mStrokeBrushValid = True
	End If
	Return mStrokeBrush
End Sub

Private Sub GetFillBrush As bcbrush
	If mFillBrushValid = False Or mFillBrushColor <> Style.FillColor Then
		mFillBrush = GetBrushForColor(Style.FillColor)
		mFillBrushColor = Style.FillColor
		mFillBrushValid = True
	End If
	Return mFillBrush
End Sub

'Returns a brush for an arbitrary colour. Cached, so repeated colours don't
'allocate new bcbrush objects.
Private Sub GetBrushForColor(color As Int) As bcbrush
	If mBrushCache.ContainsKey(color) Then
		Return mBrushCache.Get(color)
	End If
	Dim b As bcbrush = mBC.CreateBrushFromColor(color)
	mBrushCache.Put(color, b)
	Return b
End Sub

'--- Batch management --------------------------------------------------------

'Starts a new batch. All subsequent AddGeometry calls will append xDrawTask
'objects to an internal list. Call EndBatchAsync to execute them.
Public Sub BeginBatch
	If mBatchRunning Then
		Log("JTSBCDrawer.BeginBatch: previous batch still rendering — ignored")
		Return
	else If mInBatch Then
		Log("JTSBCDrawer.BeginBatch: already in a batch; previous tasks discarded")
	End If
	mTasks.Initialize
	mInBatch = True
	mPolygonsUnderConstruction.Clear
End Sub

'Returns the underlying task list. Useful if the caller wants to mix tasks
'from multiple drawers into a single async draw call.
Public Sub GetTasks As List
	Return mTasks
End Sub

'Ends the batch and executes all accumulated tasks asynchronously. Returns a
'ResumableSub that completes with the resulting B4XBitmap. On B4J the bitmap
'argument from the underlying event is unused; we read mBC.Bitmap directly
'after the event fires for consistency across platforms.
Public Sub EndBatchAsync As ResumableSub
	If mInBatch = False Then
		Log("JTSBCDrawer.EndBatchAsync: no active batch")
		Return Null
	else If mBatchRunning Then
		Log("JTSBCDrawer.EndBatchAsync: previous batch still rendering — refusing to start another")
		Return Null
	End If
	mInBatch = False
	mBatchRunning = True
	If mPolygonsUnderConstruction.Size > 0 Then
'		Log("wait for AllPolygonsConstructed")
		wait for AllPolygonsConstructed
'		Log("AllPolygonsConstructed Happened")
	End If
	Dim tasksToRun As List = mTasks
	If tasksToRun.Size = 0 Then
		'Nothing to draw — return current bitmap directly.
		Return mBC.Bitmap
	End If	
	mBC.DrawBitmapCreatorsAsync(Me, "JTSBCBatch", tasksToRun)
'	Log("Wait for BitmapReady")
	Wait For JTSBCBatch_BitmapReady (bmp As B4XBitmap)
'	Log("BitmapReady happened")
	'mBC.Bitmap is reliable on both platforms; use it instead of bmp which is
	'not initialised on B4J.
	mBatchRunning = False
	Return mBC.Bitmap
End Sub

'Cancels the current batch without executing it.
Public Sub CancelBatch
	mInBatch = False
	mPolygonsUnderConstruction.Clear
End Sub

'--- Geometry dispatch -------------------------------------------------------

'Adds the geometry to the current batch. Handles all geometry types returned
'by JTSGeometry.GetGeometryType. Must be called between BeginBatch and
'EndBatchAsync.
Public Sub AddGeometry(geom As JTSGeometry)
	If mInBatch = False Then
		Log("JTSBCDrawer.AddGeometry: not in a batch; call BeginBatch first")
		Return
	End If
	If geom.IsEmpty Then Return
	EnsureTransform
	
	Dim t As String = geom.GetGeometryType
	Select t
		Case "Point"
			AddPoint(geom.AsPoint)
		Case "MultiPoint"
			Dim n As Int = geom.GetNumGeometries
			For i = 0 To n - 1
				AddPoint(geom.GetGeometryN(i).AsPoint)
			Next
		Case "LineString", "LinearRing"
			AddLineString(geom.AsLineString, False)
		Case "MultiLineString"
			Dim n As Int = geom.GetNumGeometries
			For i = 0 To n - 1
				AddLineString(geom.GetGeometryN(i).AsLineString, False)
			Next
		Case "Polygon"
			AddPolygon(geom.AsPolygon)
		Case "MultiPolygon"
			Dim n As Int = geom.GetNumGeometries
			For i = 0 To n - 1
				AddPolygon(geom.GetGeometryN(i).AsPolygon)
			Next
		Case "GeometryCollection"
			Dim n As Int = geom.GetNumGeometries
			For i = 0 To n - 1
				AddGeometry(geom.GetGeometryN(i))
			Next
		Case Else
			Log("JTSBCDrawer: unknown geometry type: " & t)
	End Select
End Sub

'--- Type-specific dispatch -------------------------------------------------

Private Sub AddPoint(p As JTSPoint)
	Dim cx As Float = WorldToBCX(p.GetX)
	Dim cy As Float = WorldToBCY(p.GetY)
	Dim r As Float = Style.PointRadius
	
	Select Style.PointShape
		Case Style.SHAPE_CIRCLE
			If Style.Fill Then
				mTasks.Add(mBC.AsyncDrawCircle(cx, cy, r, GetFillBrush, True, 0))
			End If
			If Style.Stroke Then
				mTasks.Add(mBC.AsyncDrawCircle(cx, cy, r, GetStrokeBrush, False, Style.StrokeWidth))
			End If
		Case Style.SHAPE_SQUARE
			Dim sq As B4XRect
			sq.Initialize(cx - r, cy - r, cx + r, cy + r)
			If Style.Fill Then
				mTasks.Add(mBC.AsyncDrawRect(sq, GetFillBrush, True, 0))
			End If
			If Style.Stroke Then
				mTasks.Add(mBC.AsyncDrawRect(sq, GetStrokeBrush, False, Style.StrokeWidth))
			End If
		Case Style.SHAPE_CROSS
			If Style.Stroke Then
				mTasks.Add(mBC.AsyncDrawLine(cx - r, cy, cx + r, cy, GetStrokeBrush, Style.StrokeWidth))
				mTasks.Add(mBC.AsyncDrawLine(cx, cy - r, cx, cy + r, GetStrokeBrush, Style.StrokeWidth))
			End If
		Case Style.SHAPE_TRIANGLE
			Dim path As bcpath
			path.Initialize(cx, cy - r).LineTo(cx + r, cy + r).LineTo(cx - r, cy + r).LineTo(cx, cy - r)
			If Style.Fill Then
				mTasks.Add(mBC.AsyncDrawPath(path, GetFillBrush, True, 0))
			End If
			If Style.Stroke Then
				mTasks.Add(mBC.AsyncDrawPath(path, GetStrokeBrush, False, Style.StrokeWidth))
			End If
	End Select
End Sub

'Adds a LineString. forceClose closes the ring back to the first point; used
'when stroking polygon rings.
Private Sub AddLineString(ls As JTSLineString, forceClose As Boolean)
	If Style.Stroke = False Then Return
	Dim geom As JTSGeometry = ls.AsGeometry
	Dim n As Int = geom.GetNumPoints
	If n < 2 Then Return
	
	Dim p0 As JTSPoint = ls.GetPointN(0)
	Dim path As bcpath
	path.Initialize(WorldToBCX(p0.GetX), WorldToBCY(p0.GetY))
	For i = 1 To n - 1
		Dim p As JTSPoint = ls.GetPointN(i)
		path.LineTo(WorldToBCX(p.GetX), WorldToBCY(p.GetY))
	Next
	If forceClose Then
		path.LineTo(WorldToBCX(p0.GetX), WorldToBCY(p0.GetY))
	End If
	mTasks.Add(mBC.AsyncDrawPath(path, GetStrokeBrush, False, Style.StrokeWidth))
End Sub

'Adds a polygon. If the polygon has holes, draws them using a temporary
'transparent layer so the holes are subtracted from the fill.
Private Sub AddPolygon(poly As JTSPolygon)
	
	Dim numHoles As Int = poly.GetNumInteriorRing
	
	If numHoles = 0 Then
		AddSimplePolygon(poly)
	Else
		AddPolygonWithHoles(poly)
	End If
End Sub

'Polygon without holes: simple path, drawn directly to main BC.
Private Sub AddSimplePolygon(poly As JTSPolygon)
	Dim shell As JTSLineString = poly.GetExteriorRing
	Dim shellGeom As JTSGeometry = shell.AsGeometry
	Dim n As Int = shellGeom.GetNumPoints
	If n < 2 Then Return
	
	'Build the shell path once. We use it for both fill and stroke (BC's
	'async API requires no in-place modification between tasks; the path is
	'stored as-is in the xDrawTask).
	Dim p0 As JTSPoint = shell.GetPointN(0)
	Dim path As BCPath
	path.Initialize(WorldToBCX(p0.GetX), WorldToBCY(p0.GetY))
	For i = 1 To n - 1
		Dim p As JTSPoint = shell.GetPointN(i)
		path.LineTo(WorldToBCX(p.GetX), WorldToBCY(p.GetY))
	Next
	'Path is closed implicitly by BC when filled. For strokes we close
	'explicitly to ensure the outline returns to the start point.
	
	If Style.Fill Then
		mTasks.Add(mBC.AsyncDrawPath(path, GetFillBrush, True, 0))
	End If
	If Style.Stroke Then
		'Clone before mutating so the fill task is not affected.
		Dim strokePath As BCPath = path.Clone
		strokePath.LineTo(WorldToBCX(p0.GetX), WorldToBCY(p0.GetY))
		mTasks.Add(mBC.AsyncDrawPath(strokePath, GetStrokeBrush, False, Style.StrokeWidth))
	End If
End Sub

'Polygon with holes: builds a small temporary layer sized to the polygon's
'envelope, containing fill (with holes cut out) AND stroke. Then composites
'asynchronously onto the main BC via AsyncDrawRect with a BC-based brush.
'
'Why this approach?
' - bcLag is sized to the envelope only -> cheap allocation, tight bounds
' - The BC-brush is positioned so that the envelope-rect on mBC matches
'   bcLag's (0,0) origin. With SrcOffsetX/Y = 0 the copy is 1:1.
' - AsyncDrawRect blends by default -> transparent pixels in bcLag (outside
'   the shell, and inside the holes) leave the main BC unchanged.
Private Sub AddPolygonWithHoles(poly As JTSPolygon)
	Dim lTasks As List
	lTasks.Initialize
	Dim myID() As String
	mPolygonsUnderConstruction.Put(myID,mTasks.Size)
'	Log($"added myid.....mPolygonsUnderConstruction.ContainsKey(myID):${mPolygonsUnderConstruction.ContainsKey(myID)}  ...size:${mPolygonsUnderConstruction.Size}"$)
	mTasks.Add(lTasks)	'Use lTasks as a placeholder for the final drawOperation
	Dim shell As JTSLineString = poly.GetExteriorRing
	Dim numHoles As Int = poly.GetNumInteriorRing
	
	'Compute envelope of the shell in mBC space and round outwards.
	'Add a small margin so stroke pixels are not clipped at the edge.
	Dim margin As Int = Max(1, Style.StrokeWidth)
	Dim env As B4XRect = ComputeRingEnvelopeMBC(shell, margin)
	Dim envW As Int = env.Width
	Dim envH As Int = env.Height
	If envW <= 0 Or envH <= 0 Then Return
	
	'Build the temporary layer.
	Dim bcLag As BitmapCreatorResumable
	bcLag.Initialize(envW, envH)
	'bcLag starts fully transparent (alpha=0). No need to FillRect.
	
	'All paths drawn on bcLag use coordinates offset by (-env.Left, -env.Top)
	'so that the envelope's top-left maps to bcLag's (0,0).
	Dim dx As Float = -env.Left
	Dim dy As Float = -env.Top
	
	'1. Fill the shell.
	If Style.Fill Then
		Dim shellPathFill As BCPath = BuildRingPathOffset(shell, dx, dy)
'		bcLag.DrawPath2(shellPathFill, GetFillBrush, True, 0)
		lTasks.Add(bcLag.BC.AsyncDrawPath(shellPathFill,GetFillBrush,True,0))
		
		'2. Cut out each hole with a transparent BlendAll brush.
		Dim transparentBrush As BCBrush = bcLag.bc.CreateBrushFromColor(0x00000000)
		transparentBrush.BlendAll = True
		For h = 0 To numHoles - 1
			Dim holePathFill As BCPath = BuildRingPathOffset(poly.GetInteriorRingN(h), dx, dy)
			lTasks.Add(bcLag.BC.asyncDrawPath(holePathFill, transparentBrush, True, 0))
		Next
	End If
	
	'3. Stroke shell and every hole on bcLag (also synchronous, on the layer).
	If Style.Stroke Then
		Dim shellPathStroke As BCPath = BuildRingPathOffset(shell, dx, dy)
		'Explicitly close the stroke path.
		Dim p0 As JTSPoint = shell.GetPointN(0)
		shellPathStroke.LineTo(WorldToBCX(p0.GetX) + dx, WorldToBCY(p0.GetY) + dy)
		lTasks.Add(bcLag.bc.AsyncDrawPath(shellPathStroke, GetStrokeBrush, False, Style.StrokeWidth))
		
		For h = 0 To numHoles - 1
			Dim hole As JTSLineString = poly.GetInteriorRingN(h)
			Dim holePathStroke As BCPath = BuildRingPathOffset(hole, dx, dy)
			Dim hp0 As JTSPoint = hole.GetPointN(0)
			holePathStroke.LineTo(WorldToBCX(hp0.GetX) + dx, WorldToBCY(hp0.GetY) + dy)
			lTasks.Add(bcLag.BC.AsyncDrawPath(holePathStroke, GetStrokeBrush, False, Style.StrokeWidth))
		Next
	End If

	wait for (bcLag.DrawBitmapCreatorsAsync(lTasks)) complete (result As BitmapCreator)
	
	
	'4. Composite the layer onto mBC at the envelope's position.
	'   A BC-based brush tiles from mBC's (0, 0) by default. Setting
	'   SrcOffsetX/Y to (env.Left, env.Top) shifts the tiling so that
	'   brush pixel (0, 0) lines up with mBC pixel (env.Left, env.Top) —
	'   i.e. the envelope's top-left. Inside the env rect the layer is
	'   then a 1:1 copy; outside doesn't matter (rect bounds the draw).

	Dim layerBrush As BCBrush = mBC.CreateBrushFromBitmapCreator(bcLag.BC)
	layerBrush.SrcOffsetX = env.Left
	layerBrush.SrcOffsetY = env.Top
	layerBrush.BlendAll = True
'	Log($"removeing myid.....mPolygonsUnderConstruction.ContainsKey(myID):${mPolygonsUnderConstruction.ContainsKey(myID)}   ...size:${mPolygonsUnderConstruction.size}"$)
	If mPolygonsUnderConstruction.ContainsKey(myID) Then
		mTasks.Set(mPolygonsUnderConstruction.remove(myID),mBC.AsyncDrawRect(env, layerBrush, True, 0))
'		Log("CallSubDelayed AllPolygonsConstructed")
		If mPolygonsUnderConstruction.Size = 0 Then CallSubDelayed(Me,"AllPolygonsConstructed")
	End If
End Sub

'Helper: builds a closed BCPath for a ring, translated by (offsetX, offsetY).
'Used to shift world-space mBC coords into bcLag-local coords.
Private Sub BuildRingPathOffset(ring As JTSLineString, offsetX As Float, offsetY As Float) As BCPath
	Dim geom As JTSGeometry = ring.AsGeometry
	Dim n As Int = geom.GetNumPoints
	Dim p0 As JTSPoint = ring.GetPointN(0)
	Dim path As BCPath
	path.Initialize(WorldToBCX(p0.GetX) + offsetX, WorldToBCY(p0.GetY) + offsetY)
	For i = 1 To n - 1
		Dim p As JTSPoint = ring.GetPointN(i)
		path.LineTo(WorldToBCX(p.GetX) + offsetX, WorldToBCY(p.GetY) + offsetY)
	Next
	Return path
End Sub

'Helper: computes the envelope of a ring in mBC pixel space, with optional
'margin (in pixels). Uses JTS's GetEnvelopeInternal which already knows the
'geometry's bounds, then transforms to mBC space.
'NB: JTS Y axis points up (math convention); WorldToBCY flips it. So MinY in
'world becomes the larger BC-Y (bottom) and MaxY becomes the smaller (top).
Private Sub ComputeRingEnvelopeMBC(ring As JTSLineString, margin As Int) As B4XRect
	Dim env As JTSEnvelope = ring.AsGeometry.GetEnvelopeInternal
	Dim x0 As Float = WorldToBCX(env.GetMinX)
	Dim x1 As Float = WorldToBCX(env.GetMaxX)
	Dim y0 As Float = WorldToBCY(env.GetMinY)  'larger BC-Y (Y axis flipped)
	Dim y1 As Float = WorldToBCY(env.GetMaxY)  'smaller BC-Y
	Dim left As Int = Max(0, Floor(Min(x0, x1)) - margin)
	Dim right As Int = Min(mBC.mWidth, Ceil(Max(x0, x1)) + margin)
	Dim top As Int = Max(0, Floor(Min(y0, y1)) - margin)
	Dim bottom As Int = Min(mBC.mHeight, Ceil(Max(y0, y1)) + margin)
	Dim r As B4XRect
	r.Initialize(left, top, right, bottom)
	Return r
End Sub

