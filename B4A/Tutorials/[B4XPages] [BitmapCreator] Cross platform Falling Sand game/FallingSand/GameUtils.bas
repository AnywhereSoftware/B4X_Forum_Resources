B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public gs As GameStep
	Type GameStep (SpritesToDelete As List, GameTime As Int, FirstLoop As Boolean)
	Private Index As Int
	Public mTargetView As B4XView
	Public MainBC As BitmapCreator
	Public DrawingDelay As Int
	
	Type FutureTask (Callback As Object, SubName As String, GameTime As Int, Value As Object)
	Private FutureTasks As List
	Public FPS As Float
	Public IsRunning As Boolean
	Public mGame As Game
	Private Sprites As List
	Public ViewRect As B4XRect
End Sub

Public Sub Initialize (MyGame As Game, Width As Int, Height As Int, TargetView As B4XView)
	gs.Initialize
	gs.SpritesToDelete.Initialize
	mGame = MyGame
	If xui.IsB4J Then
		DrawingDelay = 10
	else if xui.IsB4A Then
		DrawingDelay = 5
	Else
		DrawingDelay = 16
	End If
	mTargetView = TargetView
	MainBC.Initialize(Width, Height)
	Reset
End Sub

Public Sub Reset
	FutureTasks.Initialize
	Sprites.Initialize
	MainBC.FillRect(xui.Color_Transparent, MainBC.TargetRect)
	ViewRect.Initialize (0, 0, MainBC.mWidth, MainBC.mHeight)
End Sub

Public Sub Start
	If IsRunning Then Return
	IsRunning = True
	gs.GameTime = 0
	MainLoop
End Sub

Public Sub Stop
	Index = Index + 1
	IsRunning = False
End Sub

Public Sub MainLoop
	Index = Index + 1
	Dim MyIndex As Int = Index
	Do While MyIndex = Index
		Dim StartLoopTime As Long = DateTime.Now 'ignore
		gs.SpritesToDelete.Clear
		gs.GameTime = gs.GameTime + 1
		mGame.Tick (gs)
		'Log($"Number of sprites: ${Sprites.Size}"$)
		For i = 0 To Sprites.Size - 1
			Dim Sprite1 As Sprite = Sprites.Get(i)
			Sprite1.Index = Sprite1.Index + 1
			Sprite1.Tick(gs)
		Next
		RemoveDeletedSprites
		RunFutureTasks
		Dim tasks As List = CreateDrawTasks
		
		MainBC.DrawBitmapCreatorsAsync(Me, "bc", tasks)
		Sleep(DrawingDelay)
		FPS = (FPS * 20 + 1000/(DateTime.Now - StartLoopTime)) / 21
	Loop
End Sub

Private Sub BC_BitmapReady (bmp As B4XBitmap)
	If xui.IsB4J Then bmp = MainBC.Bitmap
	SetBitmapWithFitOrFill(mTargetView, bmp)
End Sub
'Updates the bitmap and sets the scaling mode to FIT in B4J and B4i and FILL in B4A.
'This is useful when the image ratio is the same as the target view but the size is different.
Public Sub SetBitmapWithFitOrFill (TargetView As B4XView, bmp As B4XBitmap)
	TargetView.SetBitmap(bmp)
	#if B4A
	'B4XView.SetBitmap sets the gravity in B4A to CENTER. This will prevent the bitmap from being scaled as needed so
	'we switch to FILL
	Dim iv As ImageView = TargetView
	iv.Gravity = Gravity.FILL
	#End If
End Sub

Public Sub CreateSprite (Target As Object) As Sprite
	Dim s As Sprite
	s.Initialize(mGame)
	s.Target = Target
	Sprites.Add(s)
	Return s
End Sub

Private Sub RunFutureTasks
	For i = FutureTasks.Size - 1 To 0 Step - 1
		Dim ft As FutureTask = FutureTasks.Get(i)
		If gs.GameTime >= ft.GameTime Then
			CallSub2(ft.Callback, ft.SubName, ft)
			FutureTasks.RemoveAt(i)
		Else
			Exit
		End If
	Next
End Sub

Private Sub CreateDrawTasks As List
	Dim res As List
	res.Initialize
	For Each Sprite As Sprite In Sprites
		If Sprite.ShouldDraw Then
			Dim dt As DrawTask = Sprite.ToDrawTask
			If Sprite.AddFirst Then
				res.InsertAt(0, dt)
			Else
				res.Add(dt)
			End If
		End If
	Next
	Return res
End Sub

Private Sub RemoveDeletedSprites
	For Each Sprite As Sprite In gs.SpritesToDelete
		Dim i As Int = Sprites.IndexOf(Sprite)
		If i > -1 Then
			Sprites.RemoveAt(i)
			
		Else
			Log(Sprite)
			Log(Sprite.Target)
			Log("Error: RemoveDeletedSprites")
		End If
		mGame.SpriteRemoved(Sprite)
		Sprite.Target = Null 'this is required to avoid reference cycle in B4i.
	Next
End Sub

'TimeToFire - Don't add gs.GameTime as it will be added automatically.
Public Sub AddFutureTask (Callback As Object, SubName As String, TimeToFire As Int, Value As Object)
	Dim ft As FutureTask
	ft.Callback = Callback
	ft.SubName = SubName
	ft.GameTime = TimeToFire + gs.GameTime
	ft.Value = Value
	For i = FutureTasks.Size - 1 To 0 Step -1
		Dim old As FutureTask = FutureTasks.Get(i)
		If old.GameTime > ft.GameTime Then
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

'Splits a sprite sheet bitmap.
Public Sub ReadSprites (Bmp As B4XBitmap, Rows As Int, Columns As Int, IgnoreSemiTransparent As Boolean) As List
	Dim res As List
	res.Initialize
	Dim RowHeight As Int = Bmp.Height / Rows
	Dim ColumnWidth As Int = Bmp.Width / Columns
	For r = 0 To Rows - 1
		For c = 0 To Columns - 1
			Dim b As B4XBitmap = Bmp.Crop(ColumnWidth * c, RowHeight * r, ColumnWidth, RowHeight)
			res.Add(BitmapToBitmapCreator(b, IgnoreSemiTransparent))
		Next
	Next
	Return res
End Sub

'Make sure NOT to use dip units when loading or resizing the bitmap.
Public Sub BitmapToBitmapCreator (bmp As B4XBitmap, SkipSemiTransparent As Boolean) As BitmapCreator
	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width, bmp.Height)
	bc.CopyPixelsFromBitmap(bmp)
	Return bc
End Sub

'Moves a B4XRect without changing its width or height.
Public Sub PushRect(Rect As B4XRect, OffsetX As Int, OffsetY As Int)
	Rect.Left = Rect.Left + OffsetX
	Rect.Right = Rect.Right + OffsetX
	Rect.Top = Rect.Top + OffsetY
	Rect.Bottom = Rect.Bottom + OffsetY
End Sub

'Returns the distance between two points.
Public Sub DistanceBetween(p1 As GamePosition, p2 As GamePosition) As Float
	Return Sqrt(Power(p1.x - p2.x, 2) + Power(p1.y - p2.y, 2))
End Sub

'Creates a canvas object that you can use for drawings.
Public Sub CreateCanvas (Width As Int, Height As Int) As B4XCanvas
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Width, Height)
	Dim cvs As B4XCanvas
	cvs.Initialize(p)
	Return cvs
End Sub

Private Sub CopyBC(bc As BitmapCreator) As BitmapCreator
	Dim b2 As BitmapCreator
	b2.Initialize(bc.mWidth, bc.mHeight)
	b2.DrawBitmapCreator(bc, bc.TargetRect, 0, 0, True)
	Return b2
End Sub



Public Sub GreyscaleToColor (src As BitmapCreator, TargetColor As Int) As BitmapCreator
	Dim bc As BitmapCreator = CopyBC(src)
	Dim a As ARGBColor
	Dim clr As ARGBColor 
	src.ColorToARGB(TargetColor, clr)
	For y = 0 To src.mHeight - 1
		For x = 0 To src.mWidth - 1
			src.GetARGB(x, y, a)
			Dim f As Float = a.r / 255
			a.r = clr.r * f
			a.g = clr.g * f
			a.b = clr.b * f
			bc.SetARGB(x, y, a)
		Next
	Next
	Return bc
End Sub

