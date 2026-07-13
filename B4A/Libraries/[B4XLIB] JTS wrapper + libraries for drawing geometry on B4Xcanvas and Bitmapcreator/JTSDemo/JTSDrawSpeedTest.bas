B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mJts As JTSManager

	Private statusLabel As B4XView
	Private mCnv As B4XCanvas
	Private bc As BitmapCreator
	Private IsDrawingBackground As Boolean

	Private mStartTime   As Long = -1
	Private mframeCount  As Int  = 0
	Private mAnimationClockTicks As Int = 0
	Private mLostMoves As Int
	Private mLastElapsedTimes As List
	Private mResettID As Int = 0
	
	Private mIdleFrameTime As Long

	' Measures UI-thread CPU time spent drawing, accumulated across frames.
	' For BC, the time the UI thread is idle (waiting on the background render
	' thread) is excluded automatically, since CPU time only counts active work.
	Private timer As CPUTimer
	Private mTimerCount As Int
	
	Private stopAnimation As Boolean	
	Private changeAnimation As Boolean	
	Private mDrawingMethode As Int
	Public const DRAWING_METHODE_CANVAS As Int = 0
	Public const DRAWING_METHODE_BITMAPCREATOR As Int = 1
	Private mWithHoles As Boolean
	Private mNumberOfGeometrics As Int = 20
	Private mMaxGeomSize As Int = 40
	Private mFill As Boolean = True
	Private mStroke As Boolean = True
	Private resultLog As List   ' List of ResultEntry
	' One row in the result table.
	'   TestName  — human-readable test label, e.g. "Canvas 1000 points"
	'   Value     — primary numeric result (ms, FPS, or speedup ratio)
	'   Unit      — unit string, e.g. "ms", "FPS", "x faster"
	'   Detail    — secondary info, e.g. "23809 points/s" or "BC faster"
	Type ResultEntry(TestName As String, Value As Double, Unit As String, Detail As String)

	' Average display frame duration in microseconds, measured at Initialize.
	' 0 means measurement is still in progress.
	Private mFrameDurationUs As Long
End Sub


'FPS and throughput benchmarks for the JTSDraw library.
Public Sub Initialize(lbl As B4XView, canvas As B4XCanvas, jts As JTSManager)
	timer.Initialize
	mLastElapsedTimes.Initialize
	statusLabel = lbl
	mCnv = canvas
	Dim bcW As Int = canvas.TargetRect.Width
	Dim bcH As Int = canvas.TargetRect.Height
	If bcW <= 0 Then bcW = 800
	If bcH <= 0 Then bcH = 600
	bc.Initialize(bcW, bcH)
	mJts = jts
	resultLog.Initialize
	MeasureFrameDuration
End Sub

' Measures the average display frame duration by sampling 60 consecutive
' Tick events from a local AnimationClock. Runs asynchronously after Initialize;
' result is stored in mFrameDurationUs when done.
' RunAll polls mFrameDurationUs and waits until it is non-zero before proceeding.
Private Sub MeasureFrameDuration As ResumableSub
	Dim clock As AnimationClock
	clock.Initialize("fdClock", Me)
	Dim total As Long = 0
	Dim n As Int = 60
	clock.Start
	For i = 1 To n
		Wait For fdClock_Tick (dt As Long)
		total = total + dt
	Next
	clock.Stop
	mFrameDurationUs = total / n
	Return Null
End Sub

Public Sub Stop
	stopAnimation = True
End Sub

Public Sub GetResults As List
	Return resultLog
End Sub

Public Sub ClearResults
	resultLog.Clear
End Sub

Public Sub RunAll As ResumableSub
	resultLog.Clear
	stopAnimation = False

	' Wait for MeasureFrameDuration to finish if still running.
	Do While mFrameDurationUs = 0
		Sleep(500)
	Loop

	Dim clock As AnimationClock
	clock.Initialize("animClock", Me)
	clock.Start

	For i = 0 To 9
		wait for animClock_Tick (ElapsedTime As Long)
	Next
	Dim et(10) As Long
	Dim sumEt As Long
	For i = 0 To et.Length-1
		wait for animClock_Tick (ElapsedTime As Long)
		et(i) = ElapsedTime
		sumEt = sumEt + et(i)
	Next
	mIdleFrameTime = sumEt/et.Length


	Do Until stopAnimation
		Log("New animation")
		changeAnimation = False
		Wait For (AnimateGeneric(mNumberOfGeometrics, xui.Color_Magenta, mWithHoles, False, mMaxGeomSize)) Complete (r As Boolean)
	Loop
	
	clock.Stop
	
	Log("Animation stoped")

	ClearCanvas
	mCnv.Invalidate
	Return True
End Sub

Private Sub AnimateGeneric(numGeoms As Int, fillColor As Int, withHoles As Boolean, absorb As Boolean, MaxGeomSize As Int) As ResumableSub

	stopAnimation = False

	Dim minR As Int = MaxGeomSize * 0.6
	Dim maxR As Int = MaxGeomSize
	
	' Scale velocity from "units per 60 Hz frame" to "units per actual frame".
	Dim velScale As Double = mFrameDurationUs / 16667.0

	Dim geometries As List
	geometries.Initialize
	Dim transforms As List
	transforms.Initialize

	For i = 0 To numGeoms - 1
		Dim px As Double = Rnd(100, 900)
		Dim py As Double = Rnd(100, 900)
		Dim vx As Double = Rnd(-5, 6)
		If vx = 0 Then vx = 1
		Dim vy As Double = Rnd(-5, 6)
		If vy = 0 Then vy = 1
		geometries.Add(BuildRandomPolygonAt(px, py, 5, 10, minR, maxR, withHoles))
		Dim at As JTSAffineTransformation
		at.Initialize
		at.Translate(vx * velScale, vy * velScale)
		transforms.Add(at)
	Next


	resettTestVariables

	Do Until stopAnimation Or changeAnimation
		Wait For animClock_Tick (elapsedTime As Long)
		innerAnimationLoop(elapsedTime,fillColor,geometries,transforms,absorb)
	Loop

	Return True
End Sub

Private Sub innerAnimationLoop(elapsedTime As Long,fillColor As Int, geometries As List , transforms As List, absorb As Boolean)
	Sleep(0) 'Pass programflow back to caller
	mLostMoves = Round(elapsedTime/mIdleFrameTime) + mLostMoves
	If mStartTime = 0 Then
		mStartTime = DateTime.Now
		mframeCount = 0
		mTimerCount = 0
		mAnimationClockTicks = 0
		timer.Reset
		If IsDrawingBackground Then
			Continue
		End If
	Else
		mAnimationClockTicks = mAnimationClockTicks + 1
		If IsDrawingBackground Then
			Continue
		End If
		mframeCount = mframeCount + 1
	End If
	For i = 1 To mLostMoves
		MoveAndBounce(geometries, transforms)
		If absorb Then ProcessCollisionsAffine(geometries, transforms)
	Next
	mLostMoves = 0
	If mDrawingMethode = DRAWING_METHODE_BITMAPCREATOR Then
		'Wait For (DrawFrameBCFromGeometries(fillColor, geometries)) Complete (s As Boolean)
		timer.Start
'			Log("Draw BC")
		DrawFrameBCFromGeometries(fillColor, geometries)
	Else
		timer.Start
		DrawFrameCanvasFromGeometries(fillColor, geometries)
		mTimerCount = mTimerCount + 1
		timer.Stop
	End If
End Sub

Private Sub resettTestVariables
	mResettID = mResettID + 1
	Dim resettID As Int = mResettID
	Dim status As String 
	status = $"Animation speed test ${IIf(mDrawingMethode=DRAWING_METHODE_CANVAS,"canvas drawing","bitmapCreator drawing")} of ${mNumberOfGeometrics} polygons ${IIf(mWithHoles,"with holes","")} maxsize:${mMaxGeomSize}."$
	statusLabel.Text = status
	Log("**********************************************")
	Sleep(1000)
	If resettID <> mResettID Then Return
	mStartTime   = 0	
	
	Sleep(2000)
	Do While (resettID = mResettID) And (stopAnimation = False)
		If mStartTime > 0 Then
			Dim Performance As String = _
$"${status}
$1.1{mframeCount/(DateTime.Now-mStartTime)*1000}fps of possible $1.0{1000000/mIdleFrameTime}fps
$1.1{mAnimationClockTicks/(DateTime.Now-mStartTime)*1000}ticks of AnimationClock per second
$1.1{mIdleFrameTime/1000}ms display frame time = $1.0{1000000/mIdleFrameTime}fps
$1.1{timer.TotalElapsedNs/mTimerCount/1000000}ms JTSDraw time each drawn frame
$1.1{timer.TotalCpuUsedNs/timer.TotalElapsedNs*100}% of the JTSDraw time is on the UI thread"$
			statusLabel.Text = Performance
			Log(Performance)
		End If
		Sleep(2000)
	Loop
End Sub

Private Sub MoveAndBounce(geometries As List, transforms As List)
	For i = 0 To geometries.Size - 1
		Dim at As JTSAffineTransformation = transforms.Get(i)
		Dim moved As JTSGeometry = BounceOffEdges(at.Transform(geometries.Get(i)), at)
		geometries.Set(i, moved)
	Next
End Sub

Private Sub BounceOffEdges(geom As JTSGeometry, at As JTSAffineTransformation) As JTSGeometry
	Dim env As JTSEnvelope = geom.GetEnvelopeInternal
	Dim minX As Double = env.GetMinX
	Dim maxX As Double = env.GetMaxX
	Dim minY As Double = env.GetMinY
	Dim maxY As Double = env.GetMaxY
	Dim entries() As Double = at.GetMatrixEntries
	Dim vx As Double = entries(2)
	Dim vy As Double = entries(5)
	Dim corrX As Double = 0
	Dim corrY As Double = 0
	Dim velChanged As Boolean = False
	If minX < 0 Then
		vx = -vx : corrX = -minX + 1 : velChanged = True
	Else If maxX > 1000 Then
		vx = -vx : corrX = -(maxX - 1000) - 1 : velChanged = True
	End If
	If minY < 0 Then
		vy = -vy : corrY = -minY + 1 : velChanged = True
	Else If maxY > 1000 Then
		vy = -vy : corrY = -(maxY - 1000) - 1 : velChanged = True
	End If
	If velChanged Then
		at.SetToIdentity.Translate(vx, vy)
		If corrX <> 0 Or corrY <> 0 Then
			Dim corrAT As JTSAffineTransformation
			corrAT.Initialize
			corrAT.Translate(corrX, corrY)
			Return corrAT.Transform(geom)
		End If
	End If
	Return geom
End Sub

Private Sub DrawFrameCanvasFromGeometries(fillColor As Int, geometries As List)
	ClearCanvas
	Dim drawer As JTSDrawer
	drawer.Initialize(mCnv)
	drawer.SetViewportRect(0, 0, 1000, 1000)
	If mStroke Then
		drawer.Style.SetStroke(xui.Color_Black, 1)
	Else
		drawer.Style.Stroke = False
	End If
	If mFill Then
		drawer.Style.SetFill(fillColor)
	Else
		drawer.Style.Fill = False
	End If
	For i = 0 To geometries.Size - 1
		drawer.DrawGeometry(geometries.Get(i))
	Next
	mCnv.Invalidate
End Sub

Private Sub DrawFrameBCFromGeometries(fillColor As Int, geometries As List)
	ClearBC
	Dim drawer As JTSBCDrawer
	drawer.Initialize(bc)
	drawer.SetViewportRect(0, 0, 1000, 1000)
	If mStroke Then
		drawer.Style.SetStroke(xui.Color_Black, 1)
	Else
		drawer.Style.Stroke = False
	End If
	If mFill Then
		drawer.Style.SetFill(fillColor)
	Else
		drawer.Style.Fill = False
	End If
'	Log("Begin batch")
	drawer.BeginBatch
	For i = 0 To geometries.Size - 1
		drawer.AddGeometry(geometries.Get(i))
	Next
	IsDrawingBackground = True
'	Log("Wait for drawer.EndBatchAsync")
	Wait For (drawer.EndBatchAsync) Complete (bmp As B4XBitmap)
'	Log("Wait for drawer.EndBatchAsync complete")
	IsDrawingBackground = False
	mCnv.DrawBitmap(bmp, mCnv.TargetRect)
	mCnv.Invalidate
	timer.Stop
	mTimerCount = mTimerCount + 1
End Sub

' Detects and processes collisions between geometries using a JTS STRtree spatial index.
' The tree is built once per frame and rebuilt only when a collision occurs (i.e. when
' the geometry list changes due to absorption).
'
' Note: STRtree.Query returns all candidates whose envelope overlaps the query envelope,
' including geometries with a lower index than i. The j > i filter ensures each pair is
' only processed once, but as a consequence some pairs will be tested twice per frame
' (once as i vs j, once as j vs i). This is acceptable for a small number of geometries.
'
' When a collision is detected, ProcessAbsorptionAffine merges the two geometries into
' one (the larger absorbs the smaller and scales up). The tree is then rebuilt to reflect
' the updated geometry list before continuing the search.
Private Sub ProcessCollisionsAffine(geometries As List, transforms As List)
	Dim rebuildTree As Boolean = True
	Dim tree As JTSSTRtree
	Dim i As Int = 0
	Do While i < geometries.Size - 1
		If rebuildTree Then
			tree.Initialize(10)
			For k = 0 To geometries.Size - 1
				Dim g As JTSGeometry = geometries.Get(k)
				tree.Insert(g.GetEnvelopeInternal, k)
			Next
			rebuildTree = False
		End If
		Dim geomI As JTSGeometry = geometries.Get(i)
		Dim candidates As List = tree.Query(geomI.GetEnvelopeInternal)
		Dim absorbed As Boolean = False
		For c = 0 To candidates.Size - 1
			Dim j As Int = candidates.Get(c)
			If j > i And j < geometries.Size Then
				Dim geomJ As JTSGeometry = geometries.Get(j)
				If geomI.Intersects(geomJ) Then
					If ProcessAbsorptionAffine(i, j, geometries, transforms) = i Then i = Max(i - 1,0)
					absorbed = True
					rebuildTree = True
					Exit
				End If
			End If
		Next
		If absorbed = False Then i = i + 1
	Loop
End Sub

Private Sub ProcessAbsorptionAffine(i As Int, j As Int, geometries As List, transforms As List) As Int
	Dim geomI As JTSGeometry = geometries.Get(i)
	Dim geomJ As JTSGeometry = geometries.Get(j)
	Dim areaI As Double = geomI.GetArea
	Dim areaJ As Double = geomJ.GetArea
	Dim combinedArea As Double = areaI + areaJ
	Dim entriesI() As Double = transforms.Get(i).As(JTSAffineTransformation).GetMatrixEntries
	Dim entriesJ() As Double = transforms.Get(j).As(JTSAffineTransformation).GetMatrixEntries
	Dim newVelX As Double = (areaI * entriesI(2) + areaJ * entriesJ(2)) / combinedArea
	Dim newVelY As Double = (areaI * entriesI(5) + areaJ * entriesJ(5)) / combinedArea
	Dim winner As Int
	Dim loser As Int
	Dim winnerGeom As JTSGeometry
	Dim winnerArea As Double
	If areaI >= areaJ Then
		winner = i : loser = j : winnerGeom = geomI : winnerArea = areaI
	Else
		winner = j : loser = i : winnerGeom = geomJ : winnerArea = areaJ
	End If
	Dim env As JTSEnvelope = winnerGeom.GetEnvelopeInternal
	Dim scaleFactor As Double = Sqrt(combinedArea / winnerArea)
	Dim scaleAT As JTSAffineTransformation
	scaleAT.Initialize
	scaleAT.Translate(-env.GetMidX, -env.GetMidY).Scale(scaleFactor, scaleFactor).Translate(env.GetMidX, env.GetMidY)
	geometries.Set(winner, scaleAT.Transform(winnerGeom))
	Dim winnerAT As JTSAffineTransformation = transforms.Get(winner)
	winnerAT.SetToIdentity.Translate(newVelX, newVelY)
	geometries.RemoveAt(loser)
	transforms.RemoveAt(loser)
	Return loser
End Sub


Private Sub BuildRandomPolygonAt(cx As Double, cy As Double, minVerts As Int, maxVerts As Int, minRadius As Int, maxRadius As Int, withHole As Boolean) As JTSGeometry
	Dim resultGeom As JTSGeometry
	Dim geomReady As Boolean = False
	Do While Not(geomReady)
		Dim numVerts As Int = Rnd(minVerts, maxVerts + 1)
		Dim radius As Int = Rnd(minRadius, maxRadius + 1)
		Dim shellCoords As List
		shellCoords.Initialize
		For v = 0 To numVerts - 1
			Dim angle As Double = (v / numVerts) * 2 * cPI
			Dim r As Double = radius * Rnd(50, 111) / 100.0
			shellCoords.Add(mJts.CreateCoordinate(cx + Cos(angle) * r, cy + Sin(angle) * r))
		Next
		Dim firstShell As JTSCoordinate = shellCoords.Get(0)
		shellCoords.Add(mJts.CreateCoordinate(firstShell.GetX, firstShell.GetY))
		If Not(withHole) Then
			resultGeom = mJts.CreatePolygon(shellCoords).AsGeometry
			geomReady = True
		Else
			Dim shellGeom As JTSGeometry = mJts.CreatePolygon(shellCoords).AsGeometry
			Dim holeRadius As Int = radius / 2
			Dim holeNumVerts As Int = Rnd(minVerts, maxVerts + 1)
			Dim attempt As Int = 1
			Dim holeFound As Boolean = False
			Do While attempt <= 3 And Not(holeFound)
				Dim holeCoords As List
				holeCoords.Initialize
				For v = 0 To holeNumVerts - 1
					Dim angle As Double = (v / holeNumVerts) * 2 * cPI
					Dim r As Double = holeRadius * Rnd(50, 111) / 100.0
					holeCoords.Add(mJts.CreateCoordinate(cx + Cos(angle) * r, cy + Sin(angle) * r))
				Next
				Dim firstHole As JTSCoordinate = holeCoords.Get(0)
				holeCoords.Add(mJts.CreateCoordinate(firstHole.GetX, firstHole.GetY))
				Dim holeGeom As JTSGeometry = mJts.CreatePolygon(holeCoords).AsGeometry
				If shellGeom.Contains(holeGeom) Then
					Dim holes As List
					holes.Initialize
					holes.Add(holeCoords)
					resultGeom = mJts.CreatePolygonWithHoles(shellCoords, holes).AsGeometry
					holeFound = True
					geomReady = True
				End If
				attempt = attempt + 1
			Loop
		End If
	Loop
	Return resultGeom
End Sub

Private Sub ClearCanvas
	mCnv.DrawRect(mCnv.TargetRect, xui.Color_White, True, 0)
End Sub

Private Sub ClearBC
	Dim full As B4XRect
	full.Initialize(0, 0, bc.mWidth, bc.mHeight)
	bc.DrawRect(full,xui.Color_White,True,0)
End Sub



'Sets the drawing mode 
'Must be set to one of the DRAWING_METHODE constants
Public Sub setDrawingMethode(methode As Int)
	mDrawingMethode = methode
	resettTestVariables
End Sub

Public Sub setWithHoles(value As Boolean)
	changeAnimation = True
	mWithHoles = value	
End Sub

Public Sub setNumberOfGeometrics(value As Int)
	changeAnimation = True
	mNumberOfGeometrics = value
End Sub

Public Sub getNumberOfGeometrics As Int
	Return mNumberOfGeometrics
End Sub

Public Sub setMaxGeomSize(value As Int)
	changeAnimation = True
	mMaxGeomSize =value
End Sub

Public Sub getMaxGeomSize As Int
	Return mMaxGeomSize
End Sub

Public Sub setStroke(value As Boolean)
	changeAnimation = True
	mStroke = value	
End Sub

Public Sub setFill(value As Boolean)
	changeAnimation = True
	mFill = value
End Sub

Public Sub getStroke As Boolean
	Return mStroke	
End Sub

Public Sub getFill As Boolean
	Return mFill
End Sub