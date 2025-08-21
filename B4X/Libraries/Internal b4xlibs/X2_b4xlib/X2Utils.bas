B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public gs As X2GameStep
	Type X2GameStep (BodiesToDelete As List, GameTimeMs As Int, _
		 ShouldDraw As Boolean, _
		DrawingTasks As List)
	Type X2BodiesFromContact (ThisBody As X2BodyWrapper, OtherBody As X2BodyWrapper, NormalSign As Int, _
		ThisFixture As B2Fixture, OtherFixture As B2Fixture)
	Public ResumableIndex As Int
	Public mTargetView As B4XView 'Foreground ImageView
	Public MainBC As BitmapCreator  'Foreground BC
	'Used to schedule a future task. See X2.AddFutureTask.
	Type X2FutureTask (Callback As Object, SubName As String, GameTimeMs As Int, Value As Object, Disabled As Boolean)
	Private FutureTasks As List
	Private LoopsPerSecond As Float
	Public IsRunning As Boolean
	Public mGame As Game
	Public mWorld As B2World
	Public mBCPixelsPerMeter As Float
	Public GraphicCache As X2SpriteGraphicCache
	Public const BmpSmoothScale As Float = 1 'no longer used
	'Visible window
	Public ScreenAABB As B2AABB
	'A bitmap and its scale.
	Type X2ScaledBitmap (Bmp As B4XBitmap, Scale As Float)
	Private Drawing As Boolean
	#if debug
	Public TargetFPS As Int = 30
	#Else
	Public TargetFPS As Int = 60
	#end if
	Public Transparent As BitmapCreator
	
	'The duration of each time step.
	Public TimeStepMs As Float 
	Public DebugDraw As X2DebugDraw
	Private IsDebugDrawEnabled As Boolean
	Public SoundPool As X2SoundPool
	'True when drawings are throtlled.
	Public IsLowFPS As Boolean
	Public FPS As Float
	Private LastDrawingTime As Long
	'Decreases or increases the game speed. Call UpdateTimeParameters to apply changes.
	Public SlowDownPhysicsScale As Float = 1
	Private SleepTime As Int
	Public VelocityIterations As Int = 8
	Public PositionIterations As Int = 3
	Public LastDrawingTasks As List
	Public ShapeAABB As B2AABB
	#if STATS
	Dim StatsClockForDrawings As Long
	#End If
	Private ShapeTransform As B2Transform
	#if B4J or B4i
	Private const MAX_SIZE As Int = 900
	#else
	Private const MAX_SIZE As Int = 700
	#End If
	Private EmptyList As List
End Sub

Public Sub Initialize (MyGame As Game, TargetView As B4XView, World As B2World)
	ShapeAABB.Initialize
	ShapeTransform.Initialize
	EmptyList.Initialize
	mGame = MyGame
	mWorld = World
	mTargetView = TargetView
	Dim LargeDimension As Int = Max(mTargetView.Width, mTargetView.Height) / xui.Scale
	Dim SizeScale As Float = 1
	If LargeDimension > MAX_SIZE Then
		SizeScale = LargeDimension / MAX_SIZE
		Log($"Size scale: $1.2{SizeScale}"$)
	End If
	MainBC.Initialize(TargetView.Width / xui.Scale / SizeScale, TargetView.Height / xui.Scale / SizeScale)
	Transparent.Initialize(MainBC.mWidth, MainBC.mHeight)
	ScreenAABB.Initialize
	GraphicCache.Initialize (Me)
	SoundPool.Initialize
	LastDrawingTasks.Initialize
	Reset
End Sub

Private Sub MainLoop
	ResumableIndex = ResumableIndex + 1
	Log($"*** MainLoop starting. ResumableIndex = ${ResumableIndex}"$)
	Dim MyIndex As Int = ResumableIndex
	Dim SkippedFrames As Int
	LastDrawingTime = DateTime.Now
	FPS = TargetFPS
	Dim TransparentTask As DrawTask = MainBC.CreateDrawTask(Transparent, Transparent.TargetRect, 0, 0, True)
	Dim counter As Int
	Do While MyIndex = ResumableIndex
		Dim StartLoopTime As Long = DateTime.Now
	
		Dim tasks As List
		tasks.Initialize
		tasks.Add(TransparentTask)
		gs.DrawingTasks = tasks
		gs.BodiesToDelete.Clear
		
		Dim NonDrawingIteration As Boolean
		If LoopsPerSecond < TargetFPS - 6 Then
			If IsLowFPS = False Then
				LoopsPerSecond = -1000000
				IsLowFPS = True
			End If
			NonDrawingIteration = counter Mod 2 = 0
		Else
			IsLowFPS = False
		End If
		gs.ShouldDraw = Not(NonDrawingIteration Or Drawing = True)
		If mGame.BeforeTimeStep(gs) = True Then
			IsRunning = False
			Exit
		End If
		#if STATS
		Dim StatsClock As Long = DateTime.Now
		#End If
		mWorld.TimeStep(TimeStepMs / 1000, VelocityIterations, PositionIterations)
		#if STATS
		Log("**********************************************")
		Log($"World.TimeStep: ${DateTime.Now - StatsClock} ms"$)
		StatsClock = DateTime.Now
		#End If
		mGame.Tick(gs)
		Dim VisibleBodies As Map = mWorld.QueryAABBToMapOfBodies(ScreenAABB)
		Dim AllBodies As List = mWorld.AllBodies
		For Each body As B2Body In AllBodies
			Dim bw As X2BodyWrapper = body.Tag
			bw.IsVisible = VisibleBodies.ContainsKey(body)
			If bw.IsVisible Then
				bw.Tick(gs)
			Else
				If bw.TickIfInvisible Then
					bw.Tick(gs)
				Else If bw.DestroyIfInvisible Then
					bw.Delete(gs)
				End If
			End If
		Next
		#if STATS
		Log($"Ticks: ${DateTime.Now - StatsClock} ms"$)
		StatsClock = DateTime.Now
		#End If
		RunFutureTasks
		RemoveDeletedBodies
		If gs.ShouldDraw Then
			Drawing = True
			If IsDebugDrawEnabled Then
				DebugDraw.Draw(gs, VisibleBodies)
			End If
			gs.DrawingTasks.AddAll(LastDrawingTasks)
			#if STATS
			StatsClockForDrawings = DateTime.Now
			Log("Drawing tasks: " & gs.DrawingTasks.Size)
			#End If
			MainBC.DrawBitmapCreatorsAsync(Me, "BC", gs.DrawingTasks)
		Else If NonDrawingIteration = False Then
			Log("skipping frame!!!")
			SkippedFrames = SkippedFrames + 1
			LoopsPerSecond = LoopsPerSecond - 1
		End If
		LastDrawingTasks.Clear
		counter = counter + 1
		If mGame.lblStats.IsInitialized And mGame.lblStats.Visible Then
			Dim Stats As String = $"FPS: ${NumberFormat(FPS, 0, 0)}, Time: ${ConvertMillisecondsToString(gs.GameTimeMs)}"$
			Stats = Stats & $", Bodies: ${AllBodies.Size}, ScreenAABB: ($1.1{ScreenAABB.BottomLeft.X},$1.1{ScreenAABB.BottomLeft.Y})-($1.1{ScreenAABB.TopRight.X},$1.1{ScreenAABB.TopRight.Y})"$
			If IsDebugDrawEnabled Then
				Stats = Stats & ", DebugDraw!"
			End If
		#if debug
			Stats = "DEBUG MODE! " & Stats
		#End If
			mGame.lblStats.Text = Stats
		End If
		gs.ShouldDraw = False
		#if STATS
		Log($"Start sleep, duration: ${Max(SleepTime - (DateTime.Now - StartLoopTime), 7)}"$)
		StatsClockForDrawings = DateTime.Now
		#End If
		Sleep(Max(SleepTime - (DateTime.Now - StartLoopTime), 7))
		#if STATS
		Log($"End Sleep: ${DateTime.Now - StatsClock} ms"$)
		#End If
		LoopsPerSecond = (LoopsPerSecond * 20 + 1000/(DateTime.Now - StartLoopTime)) / 21
		gs.GameTimeMs = gs.GameTimeMs + TimeStepMs
	Loop
	Log($"*** Exiting MainLoop. MyIndex = ${MyIndex}"$)
End Sub


Private Sub BC_BitmapReady (bmp As B4XBitmap)
	#if B4J
	'bmp will be Null in B4J.
	bmp = MainBC.Bitmap
	#End If
	#if STATS
'	Log($"BC_BitmapReady from event: ${DateTime.Now - MainBC.ClockForAsync}"$)
	Log($"BC_BitmapReady: ${DateTime.Now - StatsClockForDrawings} ms"$)
	StatsClockForDrawings = DateTime.Now
	#End If
	Drawing = False
	FPS = Min((FPS * 20 + 1000 / (DateTime.Now - LastDrawingTime)) / 21, TargetFPS)
	LastDrawingTime = DateTime.Now
	SetBitmapWithFitOrFill(mTargetView, bmp)
	mGame.DrawingComplete
	#if STATS
	Log($"After DrawingComplete: ${DateTime.Now - StatsClockForDrawings} ms, FPS: $1.0{FPS}"$)
	#End If
End Sub

'Enabled debug drawing.
Public Sub EnableDebugDraw
	If IsDebugDrawEnabled Then Return
	DebugDraw.Initialize(mTargetView.Parent, Me)
	IsDebugDrawEnabled = True
End Sub

'Resets the game state.
Public Sub Reset
	For Each b As B2Body In mWorld.AllBodies
		mWorld.DestroyBody(b)
	Next
	FutureTasks.Initialize
	LastDrawingTasks.Clear
	MainBC.FillRect(xui.Color_Transparent, MainBC.TargetRect)
	gs.Initialize
	gs.GameTimeMs = 0
	gs.BodiesToDelete.Initialize
	UpdateTimeParameters
End Sub

'Call this method after you change TargetFPS or SlowDownPhysicsScale (when the game is running).
Public Sub UpdateTimeParameters
	TimeStepMs = 1000 / TargetFPS
	Dim SleepTime As Int = TimeStepMs
	If xui.IsB4A Then SleepTime = SleepTime - 2
	If xui.IsB4J Then SleepTime = SleepTime - 1
	TimeStepMs = TimeStepMs / SlowDownPhysicsScale
	LoopsPerSecond = TargetFPS
End Sub

'Starts the main loop.
Public Sub Start
	If IsRunning Then Return
	IsRunning = True
	Drawing = False
	MainLoop
End Sub
'Stops the main loop.
Public Sub Stop
	ResumableIndex = ResumableIndex + 1
	IsRunning = False
End Sub

'Creates a B2Body and a X2BodyWrapper.
'Delegate can be Null.
Public Sub CreateBodyAndWrapper (bd As B2BodyDef, Delegate As Object, Name As String) As X2BodyWrapper
	Dim wrapper As X2BodyWrapper
	wrapper.Initialize(mGame, Delegate, Name)
	wrapper.SetBody(mWorld.CreateBody(bd))
	Return wrapper
End Sub

Public Sub DegreesToB2Angle (Degrees As Int) As Float
	Return -cPI / 180 * Degrees
End Sub

Public Sub B2AngleToDegrees (Angle As Float) As Int
	Return Round(-Angle * 180 / cPI)
End Sub

'Loads an image file. Resizes it based on the provided dimensions.
Public Sub LoadBmp (Folder As String, FileName As String, WidthMeters As Float, HeightMeters As Float, KeepAspectRatio As Boolean) As X2ScaledBitmap
	Return LoadBmp2 (Folder, FileName, WidthMeters, HeightMeters, BmpSmoothScale, KeepAspectRatio)
End Sub

'Public Sub LoadBmpNearestNeighb
'Similar to LoadBmp. Allows setting a different scale. 
Public Sub LoadBmp2 (Folder As String, FileName As String, WidthMeters As Float, HeightMeters As Float, BmpScale As Float, KeepAspectRatio As Boolean) As X2ScaledBitmap
	Dim Scale As Float = mBCPixelsPerMeter * BmpScale
	Dim bmp As B4XBitmap = xui.LoadBitmapResize(Folder, FileName, WidthMeters * Scale, HeightMeters * Scale, KeepAspectRatio)
	Dim sb As X2ScaledBitmap
	sb.Bmp = bmp
	sb.Scale = BmpScale
	Return sb
End Sub

'Splits a sprite sheet bitmap. Returns a list with X2ScaledBitmaps
Public Sub ReadSprites (Bmp As B4XBitmap, Rows As Int, Columns As Int, WidthMeters As Float, HeightMeters As Float) As List
	Dim res As List
	res.Initialize
	Dim scale As Float = mBCPixelsPerMeter * BmpSmoothScale
	Dim RowHeight As Int = Bmp.Height / Rows
	Dim ColumnWidth As Int = Bmp.Width / Columns
	For r = 0 To Rows - 1
		For c = 0 To Columns - 1
			Dim b As B4XBitmap = Bmp.Crop(ColumnWidth * c, RowHeight * r, ColumnWidth, RowHeight).Resize(WidthMeters * scale, HeightMeters * scale, False)
			Dim sb As X2ScaledBitmap
			sb.Bmp = b
			sb.Scale = BmpSmoothScale
			res.Add(sb)
		Next
	Next
	Return res
End Sub

Public Sub ReadSpritesBCs (Source As BitmapCreator, Rows As Int, Columns As Int, WidthMeters As Float, HeightMeters As Float) As List
	Dim res As List
	res.Initialize
	Dim scale As Float = mBCPixelsPerMeter * BmpSmoothScale
	Dim RowHeight As Int = Source.mHeight / Rows
	Dim ColumnWidth As Int = Source.mWidth / Columns
	Dim rect As B4XRect
	rect.Initialize(0, 0, 0, 0)
	For r = 0 To Rows - 1
		For c = 0 To Columns - 1
			rect.Left = ColumnWidth * c
			rect.Top = RowHeight * r
			rect.Width = ColumnWidth
			rect.Height = RowHeight
			res.Add(NearestNeighborResize(Source, rect, WidthMeters * scale, HeightMeters * scale, False))
		Next
	Next
	Return res
End Sub

'Configures the coordinates of the visible window.
Public Sub ConfigureDimensions (CenterPointInMeters As B2Vec2, TargetViewWidthInMeters As Float)
	mBCPixelsPerMeter = MainBC.mWidth / TargetViewWidthInMeters
	UpdateWorldCenter(CenterPointInMeters)
End Sub

'Sets the visible window center.
Public Sub UpdateWorldCenter (CenterPointInMeters As B2Vec2)
	ScreenAABB.BottomLeft.X = CenterPointInMeters.X - MainBC.mWidth / 2 / mBCPixelsPerMeter
	ScreenAABB.BottomLeft.Y = CenterPointInMeters.Y - MainBC.mHeight / 2 / mBCPixelsPerMeter
	ScreenAABB.TopRight.X = CenterPointInMeters.X + MainBC.mWidth / 2 / mBCPixelsPerMeter
	ScreenAABB.TopRight.Y = CenterPointInMeters.Y + MainBC.mHeight / 2 / mBCPixelsPerMeter
End Sub

'Converts meters to "pixels". This is not really pixels as the MainBC can also be scaled.
Public Sub MetersToBCPixels (Meters As Float) As Int
	Return Round(Meters * mBCPixelsPerMeter)
End Sub

'Converts BC "pixels" to meters.
Public Sub BCPixelsToMeters (Pixels As Int) As Float
	Return Pixels / mBCPixelsPerMeter
End Sub

Private Sub RemoveDeletedBodies
	For Each body As B2Body In gs.BodiesToDelete
		If body.Tag Is X2BodyWrapper Then
			Dim bw As X2BodyWrapper = body.Tag
			bw.Body.Tag = Null
			bw.Body = Null
		End If
		mWorld.DestroyBody(body)
	Next
End Sub

'Converts a world point to a BC pixel.
Public Sub WorldPointToMainBC (x As Float, y As Float) As B2Vec2
	Dim position As B2Vec2
	position.X = Round((x  - ScreenAABB.BottomLeft.X) * mBCPixelsPerMeter)
	position.Y = Round(MainBC.mHeight - 1 - (y - ScreenAABB.BottomLeft.Y) * mBCPixelsPerMeter)
	Return position
End Sub
'Converts a screen point to world point. This is useful to convert touch points to the world points.
Public Sub ScreenPointToWorld (x As Int, y As Int) As B2Vec2
	Dim scale As Float = mTargetView.Width / MainBC.mWidth * mBCPixelsPerMeter
	Dim position As B2Vec2
	position.X = x / scale + ScreenAABB.BottomLeft.X
	position.Y = (mTargetView.Height - 1 - y) / scale + ScreenAABB.BottomLeft.Y
	Return position
End Sub

'Updates the bitmap and sets the scaling mode to FIT in B4J and B4i and FILL in B4A.
'This is useful when the image ratio is the same as the target view but the size is different.
Public Sub SetBitmapWithFitOrFill (vTargetView As B4XView, bmp As B4XBitmap)
	vTargetView.SetBitmap(bmp)
	#if B4A
	'B4XView.SetBitmap sets the gravity in B4A to CENTER. This will prevent the bitmap from being scaled as needed so
	'we switch to FILL
	Dim iv As ImageView = vTargetView
	iv.Gravity = Gravity.FILL
	#End If
End Sub

'Call when the target view is resized. There is assumption that the ImageView ratio is constant.
Public Sub ImageViewResized
	If IsDebugDrawEnabled Then
		DebugDraw.Resize
	End If
End Sub

Private Sub RunFutureTasks
	For i = FutureTasks.Size - 1 To 0 Step - 1
		Dim ft As X2FutureTask = FutureTasks.Get(i)
		If gs.GameTimeMs >= ft.GameTimeMs Then
			FutureTasks.RemoveAt(i)
			If ft.Disabled = False Then CallSub2(ft.Callback, ft.SubName, ft)
		Else
			Exit
		End If
	Next
End Sub

'Note that future tasks with the same callback, time and sub name will be disabled.
'SubName - Should include an underscore if app is compiled with obfuscation.
'TimeToFire - Don't add gs.GameTime as it will be added automatically.
'Example:<code>
'bw.X2.AddFutureTask(Me, "Add_Score",TimeToLive, score)
'...
'Private Sub Add_Score (ft As X2FutureTask)
'	bw.mGame.mScore.IncreaseScore(ft.Value)
'End Sub</code>
Public Sub AddFutureTask (Callback As Object, SubName As String, TimeToFireMs As Int, Value As Object)
	AddFutureTask2(Callback, SubName, TimeToFireMs, Value, False)
End Sub

'Similar to AddFutureTask. AllowsDuplicates determines whether FutureTasks with the same callback, SubName and TimeToFire will be removed or not.
Public Sub AddFutureTask2 (Callback As Object, SubName As String, TimeToFireMs As Int, Value As Object, AllowDuplicates As Boolean)
	Dim ft As X2FutureTask
	ft.Callback = Callback
	ft.SubName = SubName
	ft.GameTimeMs = TimeToFireMs + gs.GameTimeMs
	ft.Value = Value
	For i = FutureTasks.Size - 1 To 0 Step -1
		Dim old As X2FutureTask = FutureTasks.Get(i)
		If AllowDuplicates = False And old.Disabled = False And old.GameTimeMs = ft.GameTimeMs And old.Callback = ft.Callback And ft.SubName = old.SubName Then
			old.Disabled = True
		End If
		If old.GameTimeMS > ft.GameTimeMs Then
			If i = FutureTasks.Size - 1 Then
				FutureTasks.Add(ft)
			Else
				FutureTasks.InsertAt(i + 1, ft)
			End If
			Return
		End If
	Next
	FutureTasks.InsertAt(0, ft)
End Sub

'Removes future tasks based on the callback and subname.
Public Sub RemoveFutureTasks (Callback As Object, SubName As String)
	Dim i As Int = 0
	Do While i < FutureTasks.Size
		Dim ft As X2FutureTask = FutureTasks.Get(i)
		If ft.Callback = Callback And ft.SubName = SubName Then
			FutureTasks.RemoveAt(i)
			Continue
		End If
		i = i + 1
	Loop
End Sub


'Converts a bitmap to a BC.
'Scale = bitmap scale.
Public Sub BitmapToBC(bmp As B4XBitmap, Scale As Float) As BitmapCreator
	Dim b2 As BitmapCreator
	b2.Initialize(bmp.Width / Scale, bmp.Height / Scale)
	b2.CopyPixelsFromBitmap(bmp)
	Return b2
End Sub

'Converts a bitmap to a CompressedBC. 
Public Sub BitmapToCompressedBC (bmp As B4XBitmap, Scale As Float) As CompressedBC
	Dim bc As BitmapCreator = BitmapToBC(bmp, Scale)
	Return bc.ExtractCompressedBC(bc.TargetRect, GraphicCache.CBCCache)
End Sub

Public Sub GetBodiesFromContact (Contact As B2Contact, FirstName As String) As X2BodiesFromContact
	Dim bw As X2BodyWrapper = Contact.FixtureA.Body.Tag
	If bw = Null Or Contact.FixtureB.Body.Tag = Null Then Return Null 'this can happen if the body was just deleted.
	If bw.Name = FirstName Then
		Dim bc As X2BodiesFromContact
		bc.ThisBody = bw
		bc.OtherBody = Contact.FixtureB.Body.Tag
		bc.ThisFixture = Contact.FixtureA
		bc.OtherFixture = Contact.FixtureB
		bc.NormalSign = 1
		Return bc
	Else
		bw = Contact.FixtureB.Body.Tag
		If bw.Name = FirstName Then
			Dim bc As X2BodiesFromContact
			bc.ThisBody = bw
			bc.OtherBody = Contact.FixtureA.Body.Tag
			bc.ThisFixture = Contact.FixtureB
			bc.OtherFixture = Contact.FixtureA
			bc.NormalSign = -1
			Return bc
		End If
	End If
	Return Null
End Sub



'Helper method. Randomly returns a float number.
Public Sub RndFloat (FromValue As Float, ToValue As Float) As Float
	Return Rnd(FromValue * 100000, ToValue * 100000) / 100000
End Sub

'Mod operation on two floats (in B4i the standard MOD operator only works with Ints).
Public Sub ModFloat (Dividend As Float, Divisor As Float) As Float
	#if B4i
	Return Bit.FMod(Dividend, Divisor)
	#else
	Return Dividend Mod Divisor
	#End If
End Sub

'Helper method to create vectors.
Public Sub CreateVec2 (x As Float, y As Float) As B2Vec2
	Return mWorld.CreateVec2 (x, y)
End Sub

'Creates a DrawTask from a CompressedBC.
Public Sub CreateDrawTaskFromCompressedBC (CBC As CompressedBC, BCPosition As B2Vec2, SrcRect As B4XRect) As DrawTask
	Dim dt As DrawTask = MainBC.CreateDrawTask(CBC, SrcRect, BCPosition.X - SrcRect.Width / 2, _
		BCPosition.Y - SrcRect.Height / 2, False)
	dt.IsCompressedSource = True
	Return dt
End Sub

'In B4A B4XCanvas.CreateBitmap returns the same internal mutable bitmap every time. This can be problematic if you reuse the Canvas as it will modify the bitmap.
Public Sub CreateImmutableBitmap (CVS As B4XCanvas) As B4XBitmap
	Dim bmp As B4XBitmap = CVS.CreateBitmap
	#if B4A
	Dim b As Bitmap
	b.Initialize3(bmp)
	bmp = b
	#End If
	Return bmp
End Sub

Private Sub ConvertMillisecondsToString(t As Long) As String
   Dim minutes As Int = t / DateTime.TicksPerMinute
   Dim seconds As Int = (t Mod DateTime.TicksPerMinute) / DateTime.TicksPerSecond
   Return $"$1.0{minutes}:$2.0{seconds}"$
End Sub

Public Sub GetShapeWidthAndHeight(Shape As B2Shape) As B2Vec2
	Shape.ComputeAABB(ShapeAABB, ShapeTransform)
	Return CreateVec2(ShapeAABB.Width, ShapeAABB.Height)
End Sub

'Returns the first BodyWrapper found with the given Id. Returns Null if no one was found.
Public Sub GetBodyWrapperById (Id As Int) As X2BodyWrapper
	Dim bodies As List = mWorld.AllBodies
	For Each body As B2Body In bodies
		Dim bw As X2BodyWrapper = body.Tag
		If bw.Id = Id Then Return bw
	Next
	Return Null
End Sub

'Returns the first BodyWrapper found with the given Id. Returns Null if no one was found.
Public Sub GetBodyWrapperByName (Name As String) As X2BodyWrapper
	Dim bodies As List = mWorld.AllBodies
	For Each body As B2Body In bodies
		Dim bw As X2BodyWrapper = body.Tag
		If bw.Name = Name Then Return bw
	Next
	Return Null
End Sub

'Returns a list with all the bodies with id listed in ListOfIds.
Public Sub GetBodiesWrappersByIds(ListOfIds As List) As List
	Dim res As List
	res.Initialize
	Dim bodies As List = mWorld.AllBodies
	For Each body As B2Body In bodies
		Dim bw As X2BodyWrapper = body.Tag
		If ListOfIds.IndexOf(bw.Id) > -1 Then
			res.Add(bw)
		End If
	Next
	Return res
End Sub

'Returns a List with the bodies (X2BodyWrappers) that intersect with the given point.
Public Sub GetBodiesIntersectingWithWorldPoint (Point As B2Vec2) As List
	ShapeAABB.BottomLeft.Set(Point.X, Point.Y)
	ShapeAABB.TopRight.Set(Point.X, Point.Y)
	Dim bodies As Map = mWorld.QueryAABBToMapOfBodies(ShapeAABB)
	If bodies.Size = 0 Then Return EmptyList
	Dim res As List
	res.Initialize
	For Each body As B2Body In bodies.Keys
		Dim f As B2Fixture = body.FirstFixture
		Do While f <> Null
			If f.Shape.TestPoint(body.Transform, Point) Then
				res.Add(body.Tag)
				Exit
			End If
			f = f.NextFixture
		Loop
	Next
	Return res
End Sub

Public Sub NearestNeighborResize (Source As BitmapCreator, SrcRect As B4XRect, Width As Float, Height As Float, KeepAspectRatio As Boolean) As BitmapCreator
	Dim bc As BitmapCreator
	If KeepAspectRatio Then
		Dim RatioW As Float = SrcRect.Width / Width
		Dim RatioH As Float = SrcRect.Height / Height
		Dim ratio As Float = Max(RatioH, RatioW)
		Width = SrcRect.Width / ratio
		Height = SrcRect.Height / ratio
	End If
	Width = Round(Width)
	Height = Round(Height)
	bc.Initialize(Width, Height)
	GraphicCache.DrawBitmapCreatorFlipped(bc, Source, Width / SrcRect.Width, Height / SrcRect.Height, SrcRect, False, False, False)
	Return bc
End Sub
