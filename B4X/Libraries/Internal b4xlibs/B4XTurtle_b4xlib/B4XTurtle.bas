B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#Event: Start
#Event: Done
#Event: Touch (Args As TurtleTouchArgs)
#DesignerProperty: Key: TurtleColor, DisplayName: Turtle Color, FieldType: Color, DefaultValue: 0xFFFF0000
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private Layers As List
	Public TurtleLayer As B4XView
	Private mDPIScale As Float
	Private mTurtleBC As BitmapCreator
	Type TurtleAction (Duration As Int, Param1 As Float, StartTime As Long, RunSub As String, Extra As List)
	Type TurtleState (UserX As Float, UserY As Float, Degree As Float, PenDown As Boolean, _
		PenColor As Int, PenThickness As Float, SpeedFactor As Float, Fnt As B4XFont, Alignment As String, TurtleVisible As Boolean, RabbitMode As Boolean, _
		CanvasLayer As Int, PolygonPoints As List, TrackPolygon As Boolean)
	Type TurtleTouchArgs (X As Float, Y As Float, Up As Boolean, Down As Boolean, Move As Boolean)
	Private Queue As List
	Private MainTimer As Timer
	Private TimerInterval As Int = 16
	Private State As TurtleState
	Public DistancePerSecond As Int = 200
	Private TransparentTurtleLayerBrush As BCBrush
	Private TurtleBCIsDrawing As Boolean
	Private TurtleBrush As BCBrush
	Private Panel1 As B4XView
	Public DegreesPerSecond As Int = 720
	Private mWidth, mHeight As Int
	Private StatesStack As List
	Private Ready As Boolean
	Private bcScale As Float = xui.Scale
	Private DebugLastTouchEvent As Long 'ignore
	Private TurtleColor As Int
	Private ResizeIndex As Int
	Public Tag As Object
	Private RabbitLoopRunning As Boolean
	Private FloodBC As BitmapCreator
	Private const AlphaLevelToTreatAsTransparent As Int = 100
	#if B4J
	Private fx As JFX
	#End If
End Sub


Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Queue.Initialize
	MainTimer.Initialize("MainTimer", TimerInterval)
	State = CreateTurtleState(100, 100, 0, True, xui.Color_Black, 2, 1, xui.CreateDefaultFont(20), "CENTER", True, False, 0)
	StatesStack.Initialize
	Layers.Initialize
	#if B4i
	bcScale = GetDeviceLayoutValues.NonnormalizedScale
	#End If
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	TurtleColor = xui.PaintOrColorToColor(Props.Get("TurtleColor"))
	Dim PanelEventName As String
	If xui.SubExists(mCallBack, mEventName & "_Touch", 1) Then PanelEventName = "Panel1" Else PanelEventName = ""
	Panel1 = xui.CreatePanel(PanelEventName)
	mBase.AddView(Panel1, 0, 0, mBase.Width, mBase.Height)
	CreateCanvasLayer
	TurtleLayer = CreateImageView
	mBase.AddView(TurtleLayer, 0, 0, 2dip, 2dip)
	mDPIScale = xui.Scale
	If (xui.IsB4A) Then Base_Resize(mBase.Width, mBase.Height)
	If xui.IsB4i Then
		Sleep(300)
	Else
		Sleep(20)
	End If
	Ready = True
	Home_Action(Null, 1)
	MainTimer.Enabled = True
	CallSub(mCallBack, mEventName & "_Start")
End Sub

Private Sub CreateCanvasLayer
	Dim cvs As B4XCanvas
	If Layers.Size > 0 Then
		Dim p As B4XView = xui.CreatePanel("")
		mBase.AddView(p, 0, 0, mBase.Width, mBase.Height)
		cvs.Initialize(p)
		TurtleLayer.BringToFront
		#if B4J
		Private jo = p As JavaObject
		jo.RunMethod("setMouseTransparent", Array As Object(True))
		#else if B4i
		Dim v As View = p
		v.UserInteractionEnabled = False
		#End If
	Else
		cvs.Initialize(Panel1)
	End If
	Layers.Add(cvs)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If Width = 0 Or Height = 0 Then Return
	mWidth = Width / mDPIScale
	mHeight = Height / mDPIScale
	Log($"B4XTurtle size: $1.0{mWidth}x$1.0{mHeight}"$)
	For i = 0 To mBase.NumberOfViews - 1
		Dim p As B4XView = mBase.GetView(i)
		p.SetLayoutAnimated(0, 0, 0, Width, Height)
	Next
	ResizeIndex = ResizeIndex + 1
	Dim MyIndex As Int = ResizeIndex
	Do While TurtleBCIsDrawing
		Sleep(50)
	Loop
	If MyIndex <> ResizeIndex Then Return
	For Each layer As B4XCanvas In Layers
		If xui.IsB4i Then
			layer.ClearRect(layer.TargetRect)
			layer.Invalidate
		End If
		layer.Resize(Width, Height)
	Next
	PrepareLayers
	DrawTurtle
End Sub

Private Sub PrepareLayers
	If xui.IsB4A Then
		mTurtleBC.Initialize(Panel1.Width, Panel1.Height)
	Else
		mTurtleBC.Initialize(Panel1.Width * bcScale, Panel1.Height * bcScale)
	End If
	TransparentTurtleLayerBrush = mTurtleBC.CreateBrushFromColor(xui.Color_Transparent)
	TurtleBrush = mTurtleBC.CreateBrushFromColor(TurtleColor)
End Sub

Private Sub CreateImageView As B4XView
	Dim iv As ImageView
	iv.Initialize("")
	Return iv
End Sub

Private Sub MainTimer_Tick
	ActionsLoop	
End Sub

Private Sub ActionsLoop 
	DrawTurtle
	Dim AccumulatedTime As Int
	Do While Queue.Size > 0 And MainTimer.Enabled And State.RabbitMode = False
		Dim ta As TurtleAction = Queue.Get(0)
		Dim Duration As Int = ta.Duration / State.SpeedFactor
		If Duration > 0 Then
			If ta.StartTime = 0 Then
				ta.StartTime = DateTime.Now - TimerInterval
				RunAction(ta, 0)
			End If
			Dim Stage As Float = Max(0, Min(1, (DateTime.Now - ta.StartTime) / Duration))
			RunAction(ta, Stage)
			If Stage = 1 Then
				Queue.RemoveAt(0)
				AccumulatedTime = AccumulatedTime + Duration
				If AccumulatedTime > 2 * TimerInterval Then Return
			Else
				Return
			End If
		Else
			RunAction(ta, 0)
			RunAction(ta, 1)
			Queue.RemoveAt(0)
		End If
	Loop
	If State.RabbitMode = False Then
		If xui.SubExists(mCallBack, mEventName & "_done", 0) Then
			CallSubDelayed(mCallBack, mEventName & "_done")
		End If
		MainTimer.Enabled = False
	End If
	RefreshTurtleAfterLoop
End Sub

Private Sub RabbitLoop
	If RabbitLoopRunning Then Return
	RabbitLoopRunning = True
	Do While Queue.Size > 0 And State.RabbitMode
		Dim ta As TurtleAction = Queue.Get(0)
		RunAction(ta, 0)
		RunAction(ta, 1)
		Queue.RemoveAt(0)
	Loop
	RabbitLoopRunning = False
End Sub

Private Sub RefreshTurtleAfterLoop
	Do While TurtleBCIsDrawing
		Sleep(10)
	Loop
	DrawTurtle
End Sub

'Pauses the turtle. Call Resume to resume.
Public Sub Pause
	MainTimer.Enabled = False
End Sub

'Resumes the turtle.
Public Sub Resume
	If Ready And Queue.Size > 0 Then MainTimer.Enabled = True
End Sub

Public Sub getIsMoving As Boolean
	Return Queue.Size > 0
End Sub

Private Sub RunAction (TA As TurtleAction, Stage As Float)
	If TA.RunSub = "Forward_Action" Then
		Forward_Action(TA, Stage)
	Else If TA.RunSub = "Right_Action" Then
		Right_Action(TA, Stage)
	Else If TA.RunSub = "MoveTo_Action" Then
		MoveTo_Action(TA, Stage)
	Else
		CallSub3(Me, TA.RunSub, TA, Stage)
	End If
End Sub

Private Sub AddAction(TA As TurtleAction) As B4XTurtle
	Queue.Add(TA)
	If State.RabbitMode Then
		RabbitLoop		
	Else
		If MainTimer.Enabled = False Then
			MainTimer.Enabled = True
		End If
	End If
	Return Me
End Sub

'Clears a rectangle.
Public Sub ClearRect (Left As Float, Top As Float, Width As Float, Height As Float) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "ClearRect_Action")
	Dim r As B4XRect
	r.Initialize(UserToCanvas(Left), UserToCanvas(Top), 0, 0)
	r.Width = UserToCanvas(Width)
	r.Height = UserToCanvas(Height)
	ta.Extra = Array(r)
	Return AddAction(ta)
End Sub

Private Sub ClearRect_Action (ta As TurtleAction, Stage As Float)
	If Stage = 1 Then
		GetLayer.ClearRect(ta.Extra.Get(0))
		RefreshMain
	End If
End Sub

'Move backwards.
Public Sub MoveBackward (Distance As Float) As B4XTurtle
	Return MoveForward(-Distance)
End Sub

'Move the turtle to center, without drawing.
Public Sub Home As B4XTurtle
	Return AddAction(CreateTurtleAction(0, 0, "Home_Action"))
End Sub

'Clears the screen. 
Public Sub ClearScreen As B4XTurtle
	Return AddAction(CreateTurtleAction(0, 0, "Clear_Action"))
End Sub

'Sets the pen color.
Public Sub SetPenColor (Clr As Int) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "PenColor_Action")
	ta.Extra = Array(Clr)
	Return AddAction(ta)
End Sub

'Draws a bitmap.
Public Sub DrawBitmap (Bmp As B4XBitmap) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "DrawBitmap_Action")
	ta.Extra = Array(Bmp)
	Return AddAction(ta)
End Sub

Private Sub DrawBitmap_Action (ta As TurtleAction, Stage As Float)
	If Stage = 1 Then
		Dim cvs As B4XCanvas = GetLayer
		Dim bmp As B4XBitmap = ta.Extra.Get(0)
		Dim dest As B4XRect
		Dim width As Float = bmp.Width
		Dim height As Float = bmp.Height
		dest.Initialize(UserToCanvas(State.UserX - width / 2), UserToCanvas(State.UserY - height / 2), 0, 0)
		dest.Width = UserToCanvas(width)
		dest.Height = UserToCanvas(height)
		cvs.DrawBitmapRotated(bmp, dest, State.Degree)
		RefreshMain
	End If
End Sub

'Gets the pen color. Should be used after the Done event.
Public Sub GetPenColor As Int
	Return State.PenColor
End Sub

Private Sub PenColor_Action (ta As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.PenColor = ta.Extra.Get(0)
	End If
End Sub

'Lifts the pen. The turtle will not draw.
Public Sub PenUp As B4XTurtle
	Return AddAction(CreateTurtleAction(0, 0, "PenUpDown_Action"))
End Sub
'Puts the pen down. The turtle will draw.
Public Sub PenDown As B4XTurtle
	Return AddAction(CreateTurtleAction(0, 1, "PenUpDown_Action"))
End Sub

Private Sub PenUpDown_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.PenDown = TA.Param1 = 1
	End If
End Sub

'Stores the current state. Call PopState to bring the current state back.
Public Sub PushState As B4XTurtle
	Return AddAction(CreateTurtleAction(0, 0, "PushState_Action"))
End Sub

'Retrieves the previous state. 
Public Sub PopState As B4XTurtle
	Return AddAction(CreateTurtleAction(0, 1, "PushState_Action"))
End Sub

Private Sub PushState_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		Dim push As Boolean = TA.Param1 = 0
		If push Then
			Dim NewState As TurtleState = CreateTurtleState(State.UserX, State.UserY, State.Degree, State.PenDown, _
				State.PenColor, State.PenThickness, State.SpeedFactor, State.Fnt, State.Alignment, State.TurtleVisible, State.RabbitMode, _
				State.CanvasLayer)
			StatesStack.Add(State)
			State = NewState
		Else
			State = StatesStack.Get(StatesStack.Size - 1)
			StatesStack.RemoveAt(StatesStack.Size - 1)
		End If
	End If
End Sub

Private Sub Clear_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		Dim layer As B4XCanvas = GetLayer
		layer.ClearRect(layer.TargetRect)
		RefreshMain
	End If
End Sub

Private Sub Home_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.Degree = 0
		State.UserX = mWidth / 2
		State.UserY = mHeight / 2
	End If
End Sub

'Moves the turtle forward.
Public Sub MoveForward (Distance As Float) As B4XTurtle
	Return AddAction(CreateTurtleAction(Abs(Distance) / DistancePerSecond * 1000, Distance, "Forward_Action"))
End Sub


Private Sub Forward_Action (TA As TurtleAction, Stage As Float)
	If Stage = 0 Then
		TA.Extra = Array(State.UserX, State.UserY)
		Dim DestX As Float = State.UserX + CosD(State.Degree) * TA.Param1
		Dim DestY As Float = State.UserY + SinD(State.Degree) * TA.Param1
		Dim NewActionsAdded As Boolean
		Dim f As Float
		If DestX >= mWidth Then
			f = 1 - (DestX - mWidth) / (DestX - State.UserX)
			SetPosition(0, -1)
			NewActionsAdded = True
		Else if DestX < 0 Then
			f = 1 - (-DestX) / (State.UserX - DestX)
			SetPosition(mWidth, -1)
			NewActionsAdded = True
		End If
		If DestY >= mHeight Then
			Dim f2 As Float = 1 - (DestY - mHeight) / (DestY - State.UserY)
			If NewActionsAdded And f2 < f Then
				f = f2
				Queue.RemoveAt(Queue.Size - 1)
				SetPosition(-1, 0)
				NewActionsAdded = True
			Else If NewActionsAdded = False Then
				f = f2
				SetPosition(-1, 0)
				NewActionsAdded = True
			End If
		Else If DestY < 0 Then
			Dim f2 As Float = 1 - (-DestY) / (State.UserY - DestY)
			If NewActionsAdded And f2 < f Then
				f = f2
				Queue.RemoveAt(Queue.Size - 1)
				SetPosition(-1, mHeight)
				NewActionsAdded = True
			Else If NewActionsAdded = False Then
				f = f2
				SetPosition(-1, mHeight)
				NewActionsAdded = True
			End If
		End If
		If NewActionsAdded Then
			If f = 0 Then f = 0.0001
			TA.Duration = TA.Duration * f
			TA.Param1 = TA.Param1 * f
			MoveForward((1 - f) * TA.Param1 / f)
			For i = 1 To 2
				Dim t As TurtleAction = Queue.Get(Queue.Size - 3 + i)
				Queue.RemoveAt(Queue.Size - 3 + i)
				Queue.InsertAt(i, t)
			Next
		End If
		Return
	End If
	Dim StartX As Float = TA.Extra.Get(0)
	Dim StartY As Float = TA.Extra.Get(1)
	Dim StageFixed As Float = Min(1, Stage + 0.01)
	Dim X As Float = StartX + CosD(State.Degree) * TA.Param1 * StageFixed
	Dim Y As Float = StartY + SinD(State.Degree) * TA.Param1 * StageFixed
	If State.PenDown Then
		GetLayer.DrawLine(UserToCanvas(State.UserX), UserToCanvas(State.UserY), UserToCanvas(X), UserToCanvas(Y), State.PenColor, UserToCanvas(State.PenThickness))
	End If
	If State.TrackPolygon Then
		State.PolygonPoints.Add(Array As Float(UserToCanvas(X), UserToCanvas(Y)))
	End If
	State.UserX = StartX + CosD(State.Degree) * TA.Param1 * Stage
	State.UserY = StartY + SinD(State.Degree) * TA.Param1 * Stage
	DrawTurtle
	RefreshMain
End Sub

Private Sub RefreshMain
	GetLayer.Invalidate
End Sub

'Turns the turtle to the right.
Public Sub TurnRight (Degrees As Float) As B4XTurtle
	Return AddAction(CreateTurtleAction(Abs(Degrees) / DegreesPerSecond * 1000, Degrees, "Right_Action"))
End Sub

'Turns the turtle to the left.
Public Sub TurnLeft (Degrees As Float) As B4XTurtle
	Return TurnRight(-Degrees)
End Sub

Private Sub SetPosition (X As Float, Y As Float) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "SetPosition_Action")
	ta.Extra = Array(X, Y)
	Return AddAction(ta)
End Sub

'Turns the turtle and moves it to the given point.
Public Sub MoveTo(X As Float, Y As Float) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "MoveTo_Action")
	ta.Extra = Array(X, Y)
	Return AddAction(ta)
End Sub

Private Sub MoveTo_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		Dim dx As Float = TA.Extra.Get(0) - State.UserX
		Dim dy As Float = TA.Extra.Get(1) - State.UserY
		Dim NewDegree As Float = ATan2D(dy, dx)
		Dim d2 As Float = State.Degree
		If NewDegree < d2 Then NewDegree = NewDegree + 360
		Dim delta As Float = NewDegree - d2
		If delta >= 180 Then delta = delta - 360
		TurnRight(delta)
		MoveForward(Sqrt(Power(dy, 2) + Power(dx, 2)))
		For i = 1 To 2
			Dim TA As TurtleAction = Queue.Get(Queue.Size - 1)
			Queue.RemoveAt(Queue.Size - 1)
			Queue.InsertAt(1, TA)
		Next
	End If
End Sub

'Gets the current layer index. Should be called after the Done event.
Public Sub GetCurrentLayer As Int
	Return State.CanvasLayer
End Sub

'Gets the current X position. Should be called after the Done event.
Public Sub GetX As Float
	Return State.UserX
End Sub
'Sets the X position.
Public Sub SetX (x As Float) As B4XTurtle
	SetPosition(x, -1)
	Return Me
End Sub

'Gets the current Y position. Should be called after the Done event.
Public Sub GetY As Float
	Return State.UserY
End Sub
'Sets the Y position.
Public Sub SetY(y As Float) As B4XTurtle
	SetPosition(-1, y)
	Return Me
End Sub

'Gets the current angle position. Should be called after the Done event.
Public Sub GetAngle As Float
	Return State.Degree
End Sub

Private Sub SetPosition_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		If TA.Extra.Get(0) >= 0 Then State.UserX = Max(0, Min(mWidth, TA.Extra.Get(0)))
		If TA.Extra.Get(1) >= 0 Then State.UserY = Max(0, Min(mHeight, TA.Extra.Get(1)))
		DrawTurtle
	End If
End Sub

'Sets the number of layers.
Public Sub SetNumberOfLayers (NumberOfLayers As Int) As B4XTurtle
	Return AddAction(CreateTurtleAction(0, NumberOfLayers, "SetNumberOfLayer_Action"))
End Sub

Private Sub SetNumberOfLayer_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		Dim n As Int = Max(1, TA.Param1)
		If n < Layers.Size Then
			For i = n To Layers.Size - 1
				Dim cvs As B4XCanvas = Layers.Get(Layers.Size - 1)
				cvs.TargetView.RemoveViewFromParent
				cvs.Release
				Layers.RemoveAt(Layers.Size - 1)
			Next
		Else if n > Layers.Size Then
			For i = 1 To n - Layers.Size
				CreateCanvasLayer
			Next
		End If
		State.CanvasLayer = Min(State.CanvasLayer, Layers.Size - 1)
	End If
End Sub

'Sets the current layer. The index of the first layer is 0.
Public Sub SetCurrentLayer (LayerIndex As Int) As B4XTurtle
	Return AddAction(CreateTurtleAction(0, LayerIndex, "SetCurrentLayer_Action"))
End Sub

Private Sub SetCurrentLayer_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		Dim index As Int = TA.Param1
		If index > Layers.Size - 1 Or index < 0 Then
			Log("Error: invalid layer index.")
			index = Max(0, Min(index, Layers.Size - 1))
		End If
		State.CanvasLayer = index
	End If
End Sub

'Sets the pen size.
Public Sub SetPenSize(Size As Float) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, Size, "SetPenSize_Action")
	Return AddAction(ta)
End Sub

Private Sub SetPenSize_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.PenThickness = TA.Param1
		DrawTurtle
	End If
End Sub

'Draws text.
Public Sub DrawText (Text As String) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "DrawText_Action")
	ta.Extra = Array(Text)
	Return AddAction(ta)
End Sub

Private Sub DrawText_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		Dim text As String = TA.Extra.Get(0)
		Dim layer As B4XCanvas = GetLayer
		Dim r As B4XRect = layer.MeasureText(text, State.Fnt)
		Dim BaseLine As Int = UserToCanvas(State.UserY) - r.Height / 2 - r.Top
		layer.DrawText(text, UserToCanvas(State.UserX), BaseLine, State.Fnt, State.PenColor, State.Alignment)
		RefreshMain
	End If
End Sub

'Sets the font and alignment that will be used to draw text. Alignment should be one of the following strings: LEFT, CENTER or RIGHT
Public Sub SetFontAndAlignment (Fnt As B4XFont, Alignment As String) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "SetFontAndAlignment_Action")
	ta.Extra = Array(Fnt, Alignment)
	Return AddAction(ta)
End Sub

Private Sub SetFontAndAlignment_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.Fnt = TA.Extra.Get(0)
		State.Alignment = TA.Extra.Get(1)
	End If
End Sub

'Shows or hides the turtle.
Public Sub SetTurtleVisible (Visible As Boolean) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "SetTurtleVisible_Action")
	ta.Extra = Array(Visible)
	Return AddAction(ta)
End Sub

Private Sub SetTurtleVisible_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.TurtleVisible = TA.Extra.Get(0)
		TurtleLayer.Visible = State.TurtleVisible
		DrawTurtle
	End If
End Sub


'Sets the speed factor. Default value is 1.
Public Sub SetSpeedFactor(Factor As Float) As B4XTurtle
	Return AddAction(CreateTurtleAction(0, Factor, "SetSpeedFactor_Action"))
End Sub

Private Sub SetSpeedFactor_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.SpeedFactor = TA.Param1
	End If
End Sub
'Sets the turtle angle.
Public Sub SetAngle (Degrees As Float) As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, Degrees, "SetAngle_Action")
	Return AddAction(ta)
End Sub

Private Sub SetAngle_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.Degree = TA.Param1
		DrawTurtle
	End If
End Sub

'Turns on rabbit mode. Everything will happen immediately.
Public Sub RabbitMode As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 1, "Rabbit_Action")
	If Queue.Size = 0 Then
		Rabbit_Action(ta, 1)
		Return Me
	Else
		Return AddAction(ta)
	End If
End Sub

'Turns off rabbit mode
Public Sub TurtleMode As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "Rabbit_Action")
	Return AddAction(ta)
End Sub

Private Sub Rabbit_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		Dim NewMode As Boolean = TA.Param1 = 1
		If NewMode = State.RabbitMode Then Return
		State.RabbitMode = NewMode
		If State.RabbitMode Then
			Sleep(0)
			RabbitLoop
		Else
			Resume
		End If
	End If
End Sub

Private Sub Right_Action (TA As TurtleAction, Stage As Float)
	If Stage = 0 Then
		TA.Extra = Array(State.Degree)
	Else If Stage = 1 Then
		State.Degree = TA.Extra.Get(0) + TA.Param1
		#if B4i
		State.Degree = Bit.FMod(Bit.FMod(State.Degree, 360) + 360, 360)
		#else
		State.Degree = ((State.Degree Mod 360) + 360) Mod 360
		#End If
	Else
		State.Degree = TA.Extra.Get(0) + TA.Param1 * Stage
	End If
	DrawTurtle
End Sub

'Immediately stops the turtle.
Public Sub Stop As B4XTurtle
	Queue.Clear
	Return Me
End Sub

Private Sub DrawTurtle
	If State.TurtleVisible = False Then Return
	If TurtleBCIsDrawing Then
'		Log("Turtle is drawing")
		Return
	End If
	If mTurtleBC.IsInitialized = False Then Return
	TurtleBCIsDrawing = True
	Dim tasks As List
	tasks.Initialize
	tasks.Add(mTurtleBC.AsyncDrawRect(mTurtleBC.TargetRect, TransparentTurtleLayerBrush, True, 0))
	Dim h As Int = 12
	Dim t As Int = 15
	Dim p1x As Float = State.UserX - h * CosD(60 + State.Degree)
	Dim p1y As Float = State.UserY - h * SinD(60 + State.Degree)
	Dim p2x As Float = State.UserX - h * SinD(30 + State.Degree)
	Dim p2y As Float = State.UserY + h * CosD(30 + State.Degree)
	Dim p3x As Float = State.UserX + t * CosD(State.Degree)
	Dim p3y As Float = State.UserY + t * SinD(State.Degree)
	#if B4J
	Dim path As BCPath
	path.Initialize(p2x * bcScale, p2y * bcScale).LineTo(p1x * bcScale, p1y * bcScale).LineTo(p3x * bcScale, p3y * bcScale).LineTo(p2x * bcScale, p2y * bcScale)
	tasks.Add(mTurtleBC.AsyncDrawPath(path, TurtleBrush, False, 2 * bcScale))
	#else
	tasks.Add(mTurtleBC.AsyncDrawLine(p2x * bcScale, p2y * bcScale, p1x * bcScale, p1y * bcScale, TurtleBrush, 2 * bcScale))
	tasks.Add(mTurtleBC.AsyncDrawLine(p2x * bcScale, p2y * bcScale, p3x * bcScale, p3y * bcScale, TurtleBrush, 2 * bcScale))
	tasks.Add(mTurtleBC.AsyncDrawLine(p3x * bcScale, p3y * bcScale, p1x * bcScale, p1y * bcScale, TurtleBrush, 2 * bcScale))
	#End If 
	mTurtleBC.DrawBitmapCreatorsAsync(Me, "TurtleBC", tasks)
	Wait For TurtleBC_BitmapReady (bmp As B4XBitmap)
	If xui.IsB4J Then
		bmp = mTurtleBC.Bitmap
	End If
	mTurtleBC.SetBitmapToImageView(bmp, TurtleLayer)
	TurtleBCIsDrawing = False
End Sub


Private Sub UserToCanvas (X As Float) As Float
	Return X * mDPIScale
End Sub

Private Sub CreateTurtleState (UserX As Float, UserY As Float, Degree As Float, PenDown1 As Boolean, PenColor As Int, _
		PenThickness As Float, SpeedFactor As Float, Fnt As B4XFont, Alignment As String, TurtleVisible As Boolean, RabbitMode1 As Boolean, _
		CanvasLayer As Int) As TurtleState
	Dim t1 As TurtleState
	t1.Initialize
	t1.UserX = UserX
	t1.UserY = UserY
	t1.Degree = Degree
	t1.PenDown = PenDown1
	t1.PenColor = PenColor
	t1.PenThickness = PenThickness
	t1.SpeedFactor = SpeedFactor
	t1.Fnt = Fnt
	t1.Alignment = Alignment
	t1.TurtleVisible = TurtleVisible
	t1.RabbitMode = RabbitMode1
	t1.CanvasLayer = CanvasLayer
	Return t1
End Sub

Private Sub CreateTurtleAction (Duration As Int, Param1 As Float, RunSub As String) As TurtleAction
	Dim t1 As TurtleAction
	t1.Initialize
	t1.Duration = Duration
	t1.Param1 = Param1
	t1.RunSub = RunSub
	Return t1
End Sub

'Gets the canvas width.
Public Sub getWidth As Int
	Return mWidth
End Sub
'Gets the canvas height.
Public Sub getHeight As Int
	Return mHeight
End Sub

Private Sub Panel1_Touch (Action As Int, X As Float, Y As Float)
	#if Debug and (B4A or B4i)
	If Action = Panel1.TOUCH_ACTION_MOVE And DateTime.Now - DebugLastTouchEvent < 100 Then Return
	DebugLastTouchEvent = DateTime.Now
	#End If
	If Action <> Panel1.TOUCH_ACTION_MOVE_NOTOUCH Then
		CallSub2(mCallBack, mEventName & "_Touch", CreateTurtleTouchArgs(X / xui.Scale, y / xui.Scale, Action = Panel1.TOUCH_ACTION_UP, Action = Panel1.TOUCH_ACTION_DOWN, _
			Action = Panel1.TOUCH_ACTION_MOVE))
	End If
End Sub

Private Sub CreateTurtleTouchArgs (X As Float, Y As Float, Up As Boolean, Down As Boolean, Move As Boolean) As TurtleTouchArgs
	Dim t1 As TurtleTouchArgs
	t1.Initialize
	t1.X = X
	t1.Y = Y
	t1.Up = Up
	t1.Down = Down
	t1.Move = Move
	Return t1
End Sub

Private Sub FloodFill (X As Int, Y As Int, ReplacementColor As Int)
	
	If FloodBC.IsInitialized = False Or FloodBC.mWidth <> mWidth Or FloodBC.mHeight <> mHeight Then
		FloodBC.Initialize(mWidth, mHeight)
	End If
	Dim layer As B4XCanvas = GetLayer
	Dim bmp As B4XBitmap = layer.CreateBitmap
	FloodBC.CopyPixelsFromBitmap(bmp)
	Dim xx As List
	xx.Initialize
	Dim yy As List
	yy.Initialize
	Dim tpm, rpm As PremultipliedColor
	Dim argb As ARGBColor
	FloodBC.GetPremultipliedColor(X, Y, tpm)
	FloodBC.ARGBToPremultipliedColor(FloodBC.ColorToARGB(ReplacementColor, argb), rpm)
	Dim r = rpm.r, g = rpm.g, b = rpm.b, a = rpm.a As Byte
	rpm.r = r
	rpm.g = g
	rpm.b = b
	rpm.a = a
	If ColorsEqual(rpm, tpm) Then Return
	SetAndAddToQueue(X, Y, xx, yy, tpm, rpm)
	Do While xx.Size > 0
		Dim nx As Int = xx.Get(0)
		Dim ny As Int = yy.Get(0)
		xx.RemoveAt(0)
		yy.RemoveAt(0)
		SetAndAddToQueue(nx, ny + 1, xx, yy, tpm, rpm)
		SetAndAddToQueue(nx, ny - 1, xx, yy, tpm, rpm)
		SetAndAddToQueue(nx + 1, ny, xx, yy, tpm, rpm)
		SetAndAddToQueue(nx - 1, ny, xx, yy, tpm, rpm)
	Loop
	layer.ClearRect(layer.TargetRect)
	layer.DrawBitmap(FloodBC.Bitmap, layer.TargetRect)
	layer.Invalidate
End Sub

Private Sub GetLayer As B4XCanvas
	Return Layers.Get(State.CanvasLayer)
End Sub

Private Sub SetAndAddToQueue (x As Int, y As Int, xx As List, yy As List, tpm As PremultipliedColor, rpm As PremultipliedColor)
	If x < 0 Or x >= FloodBC.mWidth Or y < 0 Or y >= FloodBC.mHeight Then Return
	Dim temp As PremultipliedColor
	If ColorsEqual(FloodBC.GetPremultipliedColor(x, y, temp), tpm) Then
		FloodBC.SetPremultipliedColor(x, y, rpm)
		xx.Add(x)
		yy.Add(y)
	End If
End Sub

Private Sub ColorsEqual(pm1 As PremultipliedColor, pm2 As PremultipliedColor) As Boolean
	Dim a As Int = Bit.And(0xff, pm1.a)
	Return (a > 0 And a < AlphaLevelToTreatAsTransparent) Or (pm1.a = pm2.a And pm1.r = pm2.r And pm1.g = pm2.g And pm1.b = pm2.b)
End Sub

'Starts a fill action in the current position.
Public Sub Fill As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "Fill_Action")
	Return AddAction(ta)
End Sub

Private Sub Fill_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		FloodFill (State.UserX, State.UserY, State.PenColor)
	End If
End Sub

'Starts collecting the points which will later be drawn with FillPolygon.
Public Sub StartPolygon As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "StartPolygon_Action")
	Return AddAction(ta)
End Sub

Private Sub StartPolygon_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.TrackPolygon = True
		If State.PolygonPoints.IsInitialized = False Then State.PolygonPoints.Initialize
		State.PolygonPoints.Clear
		State.PolygonPoints.Add(Array As Float(UserToCanvas(State.UserX), UserToCanvas(State.UserY)))
	End If
End Sub

'Fills the polygon. Should be called after calling StartPolygon.
Public Sub FillPolygon As B4XTurtle
	Dim ta As TurtleAction = CreateTurtleAction(0, 0, "FillPolygon_Action")
	Return AddAction(ta)
End Sub

Private Sub FillPolygon_Action (TA As TurtleAction, Stage As Float)
	If Stage = 1 Then
		State.TrackPolygon = False
		DrawPolygon(GetLayer, State.PolygonPoints, State.PenColor, True, 0)
		RefreshMain
		State.PolygonPoints.Clear
	End If
End Sub


'Returns a random color
Public Sub RandomColor As Int
	Return Rnd(0xff000000, 0xffffffff)
End Sub

'Draws an arc. The arc center will be in front of the turtle.
Public Sub Arc (SweepAngle As Float, Radius As Float) As B4XTurtle
	PushState
	RabbitMode.TurnLeft(SweepAngle / 2).PenUp.MoveForward(Radius).PenDown.TurnRight(90)
	For i = 0 To SweepAngle
		MoveForward(2 * cPI * Radius / 360).TurnRight(1)
	Next
	PopState
	Return Me
End Sub

Private Sub DrawPolygon (cvs1 As B4XCanvas, Points As List, Color As Int, Filled As Boolean, StrokeWidth As Double)
	If Points.Size < 1 Then Return
   #if B4A or B4i
   Dim FirstPoint() As Float = Points.Get(0)
   Dim p As B4XPath
   p.Initialize(FirstPoint(0), FirstPoint(1))
   For i = 1 To Points.Size - 1
       Dim point() As Float = Points.Get(i)
       p.LineTo(point(0), point(1))
   Next
   cvs1.DrawPath(p, Color, Filled, StrokeWidth)
   #Else
	Dim jcvs As JavaObject = cvs1
	jcvs = jcvs.GetFieldJO("cvs").RunMethodJO("getObject", Null).RunMethod("getGraphicsContext2D", Null)
	jcvs.RunMethod("save", Null)
	Dim xpoints(Points.Size), ypoints(Points.Size) As Double
	For i = 0 To Points.Size - 1
		Dim point() As Float = Points.Get(i)
		xpoints(i) = point(0)
		ypoints(i) = point(1)
	Next
	Dim paint As Object = fx.Colors.From32Bit(Color)
	If Filled Then
		jcvs.RunMethod("setFill", Array(paint))
		jcvs.RunMethod("fillPolygon", Array(xpoints, ypoints, Points.Size))
	Else
		jcvs.RunMethod("setStroke", Array(paint))
		jcvs.RunMethod("setLineWidth", Array(StrokeWidth))
		jcvs.RunMethod("strokePolygon", Array(xpoints, ypoints, Points.Size))
	End If
	jcvs.RunMethod("restore", Null)
   #End If
End Sub