B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public Utils As GameUtils
	Private mLblFPS As B4XView
	Public Width, Height As Int
	Private bc As BitmapCreator
	Private Particles() As Byte
	Private CurrentAction, CurrentX, CurrentY As Int
	Private pane1 As B4XView
	Private const SAND = 1, DIRT = 2, BLUESAND = 3, REDSAND = 4, GREENSAND = 5, PINKSAND = 6, ROCK = 7, ERASER = 8, STUB = 100 As Int
	Private ImageView1 As B4XView
	Private B4XComboBox1 As B4XComboBox
	Private ParticleTypes() As String = Array As String("Sand", "Dirt", "Blue Sand", "Red Sand", "Green Sand", "Pink Sand", "Rock", "Eraser")
	Private RowsState() As Byte '0 clean, 1 dirty
	Private RowClearBC As BitmapCreator
	Private btnClear As Button
	Private SandColors() As ARGBColor
	Private GravityDown As Boolean = True
End Sub

Public Sub Initialize (Parent As B4XView)
	If xui.IsB4A Then
		Width = 300
		Height = 300
	Else If xui.IsB4J Then
		Width = 600
		Height = 600
	Else if xui.IsB4i Then
		Width = 300
		Height = 300
	End If
	Parent.LoadLayout("1")
	Utils.Initialize (Me, Width, Height, ImageView1)
	If xui.IsB4A Or xui.IsB4i Then
		Utils.DrawingDelay = 10
	End If
	bc = Utils.MainBC
	Dim SandColors(ParticleTypes.Length) As ARGBColor
	bc.ColorToARGB(0xFFFFBB00, SandColors(0))
	bc.ColorToARGB(0xFFDD6E00, SandColors(1))
	bc.ColorToARGB(0xFF00CEFF, SandColors(2))
	bc.ColorToARGB(0xFFFF0000, SandColors(3))
	bc.ColorToARGB(0xFF37FF00, SandColors(4))
	bc.ColorToARGB(0xFFFF84ED, SandColors(5))
	bc.ColorToARGB(0xFFA99797, SandColors(6))
	
	B4XComboBox1.SetItems(ParticleTypes)
	B4XComboBox1.SelectedIndex = 0
	RowClearBC.Initialize(bc.mWidth, 1)
	RowClearBC.FillRect(xui.Color_Black, RowClearBC.TargetRect)
	Reset
End Sub

Private Sub Reset
	bc.FillRect(xui.Color_Black, bc.TargetRect)
	Dim Particles (Width * Height) As Byte
	'create the borders
	For y = 0 To Height - 1
		Particles((y + 1) * Width - 1) = ROCK
		Particles(y * Width + 1) = ROCK
	Next
	For x = 0 To Width - 1
		Particles ((Height - 1) * Width + x) = ROCK
		Particles (x) = ROCK
	Next
	Dim RowsState(Height) As Byte
End Sub

Private Sub AllDirty
	For i = 0 To RowsState.Length - 1
		RowsState(i) = 1
	Next
End Sub

Private Sub pane1_Touch (Action As Int, X As Float, Y As Float)
	If Action = pane1.TOUCH_ACTION_DOWN Or Action = pane1.TOUCH_ACTION_MOVE Then
		CurrentAction = 1
		Dim ScaleX As Float = ImageView1.Width / Width
		Dim ScaleY As Float = ImageView1.Height / Height
		CurrentX = X / ScaleX
		CurrentY = Y / ScaleY
	Else
		CurrentAction = 0
	End If
End Sub

Public Sub Tick (GameStep As GameStep)
	If GameStep.FirstLoop Then
		Return
	End If
	MoveParticles
	If CurrentAction > 0  Then
		AddParticles(CurrentX, CurrentY, B4XComboBox1.SelectedIndex + 1)
	End If
	
	mLblFPS.Text = $"$1.0{Utils.FPS} FPS"$
End Sub
Private Sub MoveParticles
	Dim StartY, EndY, StepY As Int
	Dim dy As Int
	Dim NextRowDelta As Int
	If GravityDown Then
		StartY = Height - 1
		EndY = 1
		StepY = -1
		dy = 1
		NextRowDelta = Width
	Else
		StartY = 1
		EndY = Height - 2
		StepY = 1
		dy = -1
		NextRowDelta = -Width
	End If
	For y = StartY To EndY Step StepY
		#if B4i
		If Bit.FastArrayGetByte(RowsState, y) = 0 Then Continue
		#else
		If RowsState(y) = 0 Then Continue
		#End If
		RowsState(y) = 0
		bc.DrawBitmapCreator(RowClearBC, RowClearBC.TargetRect, 0, y, True)
		Dim startx, endx, stepx As Int
		Dim offsetY As Int = y * Width
		If Rnd(0, 2) = 0 Then
			startx = 2
			endx = Width - 2
			stepx = 1
		Else
			startx = Width - 2
			endx = 2
			stepx = -1
		End If
		For x = startx To endx Step stepx
			Dim POffset As Int = offsetY + x
			#if B4i
			Dim b As Int = Bit.FastArrayGetByte(Particles, POffset)
			#else
			Dim b As Int = Particles(POffset)
			#End If
			If b = 0 Then Continue
			If b < ROCK Then
				bc.SetARGB(x, y, SandColors(b - 1))
				If Particles(POffset + NextRowDelta) = 0 Then
					RowsState(y - dy) = 1
					Particles(POffset) = STUB
					RowsState(y) = 1
					If y < Height - 2 And y > 1 And Particles (POffset + NextRowDelta * 2) = 0 Then
						Particles(POffset + NextRowDelta * 2) = b
						RowsState(y + 2 * dy) = 1
					Else
						Particles(POffset + NextRowDelta) = b
						RowsState(y + dy) = 1
					End If
				Else
					If Particles(POffset - 1 + NextRowDelta) = 0 Then
						Particles(POffset) = STUB
						Particles(POffset - 1 + NextRowDelta) = b
						RowsState(y - 1) = 1
						RowsState(y) = 1
						RowsState(y + 1) = 1
					Else If Particles(POffset + 1 + NextRowDelta) = 0 Then
						Particles(POffset) = STUB
						Particles(POffset + 1 + NextRowDelta) = b
						RowsState(y - 1) = 1
						RowsState(y) = 1
						RowsState(y + 1) = 1
					End If
				End If
			Else If b = STUB Then
				Particles(POffset) = 0
				RowsState(y) = 1
			Else If b = ROCK Then
				bc.SetARGB(x, y, SandColors(b - 1))
			End If
			
		Next
	Next
End Sub


Private Sub AddParticles (cx As Int, cy As Int, ParticleType As Int)
	Dim radius As Int
	Dim RndMax As Int
	Select ParticleType
		Case SAND, BLUESAND, REDSAND, GREENSAND, PINKSAND
			radius = 10 / 600 * Width
			RndMax = 3
		Case DIRT
			radius = 20 / 600 * Width
			RndMax = 3
		Case ROCK
			radius = 7 / 600 * Width
			RndMax = 1
		Case ERASER
			radius = 5 / 600 * Width
			RndMax = 1
			ParticleType = 0
			cx = Max(Min(cx, Width - radius - 1), radius + 1)
			cy = Max(Min(cy, Height - radius - 1), radius + 1)
	End Select
	
	For y = Max(0, cy - radius - 2) To Min(Height, cy + radius + 2) - 1
		RowsState(y) = 1
		If y >= cy-radius And y < cy + radius Then
			For x = Max(0, cx - radius) To Min(Width, cx + radius) - 1
				If Rnd(0, RndMax) = 0 Then
					If ParticleType = 0 Or Particles(y * Width + x) = 0 Then
						Particles(y * Width + x) = ParticleType
					End If
				End If
			Next
		End If
	Next
	
End Sub

Sub btnClear_Click
	Reset
End Sub


Sub btnGravity_Click
	Dim btn As B4XView = Sender
	GravityDown = Not(GravityDown)
	If GravityDown Then
		btn.SetRotationAnimated(500, 0)
	Else
		btn.SetRotationAnimated(500, 180)
	End If
	AllDirty
End Sub


Public Sub AfterFirstLoop As ResumableSub
	Return True
End Sub

Public Sub SpriteRemoved (Sprite1 As Sprite)
End Sub


Sub B4XComboBox1_SelectedIndexChanged (Index As Int)
	
End Sub
