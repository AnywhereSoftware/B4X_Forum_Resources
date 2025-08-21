B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
Sub Class_Globals
	Public Body As B2Body
	Public mWorld As B2World
	Public Target As Object
	Public mGame As Game
	Public IsDeleted As Boolean
	Public X2 As X2Utils
	Public CurrentFrame As Int
	Public MinFrame As Int
	Public NumberOfFrames As Int
	Private mGraphicName As String
	Public DelegateTo As Object
	Public IsVisible As Boolean
	Public TimeToLiveMs As Float
	Public SwitchFrameIntervalMs As Int
	Public LastSwitchFrameTime As Int
	Public Name As String
	Public DestroyIfInvisible As Boolean = True
	Public DebugDrawColor As Int
	Public StartTime As Int
	Public DrawLast As Boolean
	Public DrawFirst As Boolean
	Public FlipHorizontal As Boolean
	Public FlipVertical As Boolean
	Public Id As Int
	Public TickIfInvisible As Boolean
	Public Tag As Object
	'A reference to the template custom properties.
	'Note that if multiple objects were created from the same template then they will all share the same Map.
	Public TemplateCustomProperties As Map 
End Sub

Public Sub Initialize  (vGame As Game, Delegate As Object, vName As String)
	DelegateTo = Delegate
	mGame = vGame
	X2 = mGame.X2
	mWorld = X2.mWorld
	Name = vName
	StartTime = X2.gs.GameTimeMs
	LastSwitchFrameTime = StartTime
End Sub

Public Sub Tick (GS As X2GameStep)
	If IsDeleted Then Return
	If DelegateTo <> Null Then
		CallSub2(DelegateTo, "Tick", GS)
	Else
		If (TimeToLiveMs > 0 And (GS.GameTimeMs - StartTime) >= TimeToLiveMs) Or _
			(DestroyIfInvisible And IsVisible = False) Then
			Delete(GS)
			Return
		End If
		If mGraphicName <> "" Then UpdateGraphic (GS, True)
	End If
End Sub

'Deletes the body.
Public Sub Delete (GS As X2GameStep)
	If IsDeleted Then Return
	#if Not (X2SkipLogs)
	Log($"Deleting body: ${Name}, ${Id}"$)
	#end if
	IsDeleted = True
	GS.BodiesToDelete.Add(Body)
	If mGraphicName.StartsWith(X2.GraphicCache.TempPrefix) Then
		X2.GraphicCache.RemoveGraphics(mGraphicName)
	End If
End Sub

'Sets the B2Body. Should not be called in most cases.
Public Sub SetBody (vBody As B2Body)
	Body = vBody
	If vBody <> Null Then
		vBody.Tag = Me
	End If
End Sub

'Returns the current time in milliseconds.
Public Sub GetCurrentTime (gs As X2GameStep) As Int
	Return gs.GameTimeMs - StartTime
End Sub

'Updates the current graphic frame.
'IncreaseFrameAutomatically - True to increase the frame automatically based on SwitchFrameIntervalMs.
Public Sub UpdateGraphic (GS As X2GameStep, IncreaseFrameAutomatically As Boolean)
	If IncreaseFrameAutomatically And SwitchFrameIntervalMs > 0 Then SwitchFrameIfNeeded(GS)
	If GS.ShouldDraw And IsVisible Then
		Dim dt As DrawTask = CreateDrawTaskBasedOnCache
		If DrawLast Then
			X2.LastDrawingTasks.Add(dt)
		Else if DrawFirst Then
			GS.DrawingTasks.InsertAt(1, dt) 'after the transparent task
		Else
			GS.DrawingTasks.Add(dt)
		End If
	End If
End Sub

'Switch the frame based on SwitchFrameIntervalMs
Public Sub SwitchFrameIfNeeded (GS As X2GameStep)
	If (GS.GameTimeMs - LastSwitchFrameTime) >= SwitchFrameIntervalMs  Then
		LastSwitchFrameTime = GS.GameTimeMs
		CurrentFrame = CurrentFrame + 1
		If CurrentFrame >= NumberOfFrames Then CurrentFrame = MinFrame
	End If
End Sub

'Gets or sets the graphic name. Note that it also sets NumberOfFrames based on X2.GraphicCache.GetGraphicsCount(mGraphicName).
'Make sure to first add the graphic to the cache.
Public Sub getGraphicName As String
	Return mGraphicName
End Sub

Public Sub setGraphicName (s As String)
	If mGraphicName = s Then Return
	mGraphicName = s
	NumberOfFrames = X2.GraphicCache.GetGraphicsCount(mGraphicName)
	If CurrentFrame >= NumberOfFrames Then CurrentFrame = MinFrame
End Sub

'Creates a DrawTask.
Public Sub CreateDrawTaskBasedOnCache As DrawTask
	Dim position As B2Vec2 = X2.WorldPointToMainBC(Body.Position.X, Body.Position.Y)
	Return X2.GraphicCache.GetDrawTask(mGraphicName, CurrentFrame, X2.B2AngleToDegrees(Body.Angle), FlipHorizontal, FlipVertical, position.X, position.Y)
End Sub
