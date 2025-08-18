B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
'v1.01
Sub Class_Globals
	Public Index As Int
	Public TickInterval As Int = 1
	Public Target As Object
	Type GamePosition (x As Float, y As Float)
	Type GameVelocity (vx As Float, vy As Float)
	Public Position As GamePosition
	Public Velocity As GameVelocity
	Public mGame As Game
	Public Deleted As Boolean
	Public SkipBlending As Boolean
	Public Visible As Boolean
	Public Frame As BitmapCreator
	Public AddFirst As Boolean
	Public SrcRect As B4XRect
	Public ScreenCoordinates As Boolean
	Public TimeToLive As Int
	Public CurrentFrame As Int
	Public mFrames As List
	Public Scale As Float = 1
	Public Degrees As Int = 0
	'Whether to draw with transformations.
	'It is recommended to set SkipBlending to True with transformations enabled.
	Public Transformed As Boolean
	Public Utils As GameUtils
	
End Sub

Public Sub Initialize (gm As Game)
	mGame = gm
	SrcRect.Initialize(0, 0, 0, 0)
	Visible = True
	Utils = mGame.Utils
End Sub

'Updates the position based on the velocity.
Public Sub UpdatePosition
	Position.x = Position.x + Velocity.vx
	Position.y = Position.y + Velocity.vy
End Sub
'Checks whether the velocity is not 0.
Public Sub getMoving As Boolean
	Return Velocity.vx <> 0 Or Velocity.vy <> 0
End Sub
'Checks whether the sprite is visible and inside the view rect.
Public Sub getShouldDraw As Boolean
	If Deleted Or Visible = False Then Return False
	Return  getInsideViewRect
End Sub
'Checks whether the sprite is inside the view rect.
Public Sub getInsideViewRect As Boolean
	Dim w2 As Int = Frame.mWidth / 2
	Dim h2 As Int = Frame.mHeight / 2
	If ScreenCoordinates Then
		Return Not(0 > Position.x + w2 Or Utils.ViewRect.Width < Position.x - w2 Or _
			0 > Position.y + h2 Or Utils.ViewRect.Height < Position.y - h2)
	Else
		Return Not(Utils.ViewRect.Left > Position.x + w2 Or Utils.ViewRect.Right < Position.x - w2 Or _
			Utils.ViewRect.Top > Position.y + h2 Or Utils.ViewRect.Bottom < Position.y - h2)
	End If
End Sub
'Returns a DrawTask from the sprite.
Public Sub ToDrawTask As DrawTask
	Dim dt As DrawTask
	dt.Source = Frame
	dt.SkipBlending = SkipBlending
	dt.SrcRect = SrcRect
	dt.Transform = Transformed
	If Transformed Then
		dt.TargetX = Position.x - Utils.ViewRect.Left
		dt.TargetY = Position.y - Utils.ViewRect.Top
		dt.Degrees = Degrees
		dt.SrcScaleX = Scale
		dt.SrcScaleY = Scale
	Else
		dt.TargetX = Position.x - Utils.ViewRect.Left - SrcRect.Width / 2
		dt.TargetY = Position.y - Utils.ViewRect.Top - SrcRect.Height / 2
	End If
	
	If ScreenCoordinates Then
		dt.TargetX = dt.TargetX + Utils.ViewRect.Left
		dt.TargetY = dt.TargetY + Utils.ViewRect.Top
	End If
	Return dt
End Sub
'Returns the screen position (relative to the target view) from the game position.
Public Sub ToScreenPosition As GamePosition
	Dim gp As GamePosition
	gp.x = Position.x - Utils.ViewRect.Left
	gp.y = Position.y - Utils.ViewRect.Top
	Return gp
End Sub
'Calculates the velocity required to reach a position in the specified number of ticks.
Public Sub VelocityRequiredToReachPosition(TargetPosition As GamePosition, NumberOfTicks As Int) As GameVelocity
	Dim dx As Float = TargetPosition.x - Position.x, dy = TargetPosition.y - Position.y As Float
	Dim a As Float = ATan2D(dy, dx)
	Dim distance As Float = Sqrt(Power(dx, 2) + Power(dy, 2))
	Dim v As Float = distance / NumberOfTicks
	Dim vel As GameVelocity
	vel.vx = v * CosD(a)
	vel.vy = v * SinD(a)
	Return vel
End Sub

'Tests whether the current sprite collides with the other sprite.
Public Sub CollidesWith (Other As Sprite) As Boolean
	Dim MyWidth As Int = SrcRect.Width / 2
	Dim MyHeight As Int = SrcRect.Height / 2
	Dim OtherWidth As Int = Other.SrcRect.Width / 2
	Dim OtherHeight As Int = Other.SrcRect.Height / 2
	If Abs(Position.x - Other.Position.x) < MyWidth + OtherWidth And _
		Abs(Position.y - Other.Position.y) < MyHeight + OtherHeight Then
		Return True
	End If
	Return False
End Sub

Public Sub Tick (gs As GameStep)
	CallSub2(Target, "Tick", gs)
End Sub

Public Sub getViewRect As B4XRect
	Return Utils.ViewRect
End Sub


'Deletes the sprite.
Public Sub Delete (gs As GameStep)
	Deleted = True
	gs.SpritesToDelete.Add(Me)
End Sub

