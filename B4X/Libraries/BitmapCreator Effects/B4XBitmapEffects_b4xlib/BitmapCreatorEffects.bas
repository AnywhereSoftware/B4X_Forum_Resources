B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI 'ignore
	Type BCEPixelGroup (SrcX As Int, SrcY As Int, x As Float, y As Float, dx As Float, dy As Float)
	Type HSVColor (H As Int, S As Float, V As Float, A As Float)
	Private SleepDuration As Int
	Public ScaleDownImages As Boolean = True
End Sub

Public Sub Initialize
	If xui.IsB4i Then
		SleepDuration = 5
	Else
		SleepDuration = 16
	End If
End Sub

'Returns 1 in B4J and B4A.
'Returns the non-normalized scale in B4i when ScaleDownImages is set to False.
Public Sub getImageScale As Float
	#if B4i
	If ScaleDownImages Then Return 1
	Return GetDeviceLayoutValues.NonnormalizedScale
	#else
	Return 1
	#End If
End Sub

Public Sub CreateBC(bmp As B4XBitmap) As BitmapCreator
	Dim bc As BitmapCreator = CreateEmptyBC(bmp)
	bc.CopyPixelsFromBitmap(bmp)
	Return bc
End Sub

'Creates an empty BitmapCreator with the size based on the input bitmap.
Public Sub CreateEmptyBC (bmp As B4XBitmap) As BitmapCreator
	Dim bc As BitmapCreator
	If ScaleDownImages And xui.IsB4A Then
		bc.Initialize(bmp.Width / bmp.Scale, bmp.Height / bmp.Scale)
	Else
		bc.Initialize(bmp.Width, bmp.Height)
	End If
	Return bc
End Sub

Public Sub GreyScale (bmp As B4XBitmap) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(bmp)
	Dim argb As ARGBColor
	For x = 0 To bc.mWidth - 1
		For y = 0 To bc.mHeight - 1
			bc.GetARGB(x, y, argb)
			Dim c As Int = argb.r * 0.21 + argb.g * 0.72 + 0.07 * argb.b
			argb.r = c
			argb.g = c
			argb.b = c
			bc.SetARGB(x, y, argb)
		Next
	Next
	Return bc.Bitmap
End Sub

Public Sub Negate (bmp As B4XBitmap) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(bmp)
	Dim argb As ARGBColor
	For x = 0 To bc.mWidth - 1
		For y = 0 To bc.mHeight - 1
			bc.GetARGB(x, y, argb)
			argb.r = Bit.Xor(argb.r, 0xff)
			argb.g = Bit.Xor(argb.g, 0xff)
			argb.b = Bit.Xor(argb.b, 0xff)
			bc.SetARGB(x, y, argb)
		Next
	Next
	Return bc.Bitmap
End Sub

Public Sub Blur (bmp As B4XBitmap) As B4XBitmap
	Dim bc As BitmapCreator
	Dim ReduceScale As Int = 2
	bc.Initialize(bmp.Width / ReduceScale / bmp.Scale, bmp.Height / ReduceScale / bmp.Scale)
	bc.CopyPixelsFromBitmap(bmp)
	Dim count As Int = 3
	Dim clrs(3) As ARGBColor
	Dim temp As ARGBColor
	Dim m As Int
	For steps = 1 To count
		For y = 0 To bc.mHeight - 1
			For x = 0 To 2
				bc.GetARGB(x, y, clrs(x))
			Next
			SetAvg(bc, 1, y, clrs, temp)
			m = 0
			For x = 2 To bc.mWidth - 2
				bc.GetARGB(x + 1, y, clrs(m))
				m = (m + 1) Mod clrs.Length
				SetAvg(bc, x, y, clrs, temp)
			Next
		Next
		For x = 0 To bc.mWidth - 1
			For y = 0 To 2
				bc.GetARGB(x, y, clrs(y))
			Next
			SetAvg(bc, x, 1, clrs, temp)
			m = 0
			For y = 2 To bc.mHeight - 2
				bc.GetARGB(x, y + 1, clrs(m))
				m = (m + 1) Mod clrs.Length
				SetAvg(bc, x, y, clrs, temp)
			Next
		Next
	Next
	Dim res As B4XBitmap = bc.Bitmap
	If ReduceScale > 1 Then res = res.Resize(ReduceScale * res.Width * xui.Scale, ReduceScale * res.Height * xui.Scale, False)
	Return res
End Sub

Private Sub SetAvg(bc As BitmapCreator, x As Int, y As Int, clrs() As ARGBColor, temp As ARGBColor)
	temp.Initialize
	For Each c As ARGBColor In clrs
		temp.r = temp.r + c.r
		temp.g = temp.g + c.g
		temp.b = temp.b + c.b
	Next
	temp.a = 255
	temp.r = temp.r / clrs.Length
	temp.g = temp.g / clrs.Length
	temp.b = temp.b / clrs.Length
	bc.SetARGB(x, y, temp)
End Sub

Public Sub Brightness(Bmp As B4XBitmap, Factor As Float) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(Bmp)
	Dim argb As ARGBColor
	For x = 0 To bc.mWidth - 1
		For y = 0 To bc.mHeight - 1
			bc.GetARGB(x, y, argb)
			argb.r = Min(255, argb.r * Factor)
			argb.g = Min(255, argb.g * Factor)
			argb.b = Min(255, argb.b * Factor)
			bc.SetARGB(x, y, argb)
		Next
	Next
	Return bc.Bitmap
End Sub

Public Sub Pixelate (Bmp As B4XBitmap, BoxSize As Int) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(Bmp)
	Dim rect As B4XRect
	rect.Initialize(0, 0, 0, 0)
	For x = 0 To bc.mWidth - 1 Step BoxSize
		rect.Left = x
		rect.Width = BoxSize
		For y = 0 To bc.mHeight - 1 Step BoxSize
			rect.Top = y
			rect.Height = BoxSize
			bc.FillRect(bc.GetColor(Min(bc.mWidth - 1, x + BoxSize / 2), _
				 Min(bc.mHeight - 1, y + BoxSize / 2)), rect)
		Next
	Next
	Return bc.Bitmap
End Sub

Public Sub PixelateAnimated (Duration As Int, Bmp As B4XBitmap, FromBoxSize As Int, ToBoxSize As Int, ImageView As B4XView) As ResumableSub
	Dim steps As Int = Min(10, Abs(ToBoxSize - FromBoxSize))
	Dim SleepLength As Int = Duration / steps
	Dim delta As Int = Round((ToBoxSize - FromBoxSize) / steps)
	For i = FromBoxSize To ToBoxSize Step delta
		SetBitmap(ImageView, Pixelate(Bmp, i))
		Sleep(SleepLength)
	Next
	SetBitmap(ImageView, Pixelate(Bmp, ToBoxSize))
	Return True
End Sub

'assuming that mask is the same size or larger than Bmp.
Public Sub DrawThroughMask (Bmp As B4XBitmap, Mask As B4XBitmap) As B4XBitmap
	Dim source As BitmapCreator = CreateBC(Bmp)
	Dim maskbc As BitmapCreator = CreateBC(Mask)
	Dim transparent As ARGBColor
	transparent.a = 0
	Dim argb1, argb2 As ARGBColor
	For x = 0 To source.mWidth - 1
		For y = 0 To source.mHeight - 1
			If maskbc.IsTransparent(x, y) Then
				source.SetARGB(x, y, transparent)
			Else
				maskbc.GetARGB(x, y, argb1)
				If argb1.a < 255 Then
					source.GetARGB(x, y, argb2)
					argb2.a = (argb2.a * argb1.a) / 255
					source.SetARGB(x, y, argb2)
				End If
			End If
		Next
	Next
	Return source.Bitmap
End Sub

'assuming that mask is the same size or larger than Bmp.
Public Sub DrawOutsideMask (Bmp As B4XBitmap, Mask As B4XBitmap) As B4XBitmap
	Dim source As BitmapCreator = CreateBC(Bmp)
	Dim maskbc As BitmapCreator = CreateBC(Mask)
	Dim transparent As ARGBColor
	transparent.a = 0
	Dim argb1, argb2 As ARGBColor
	For x = 0 To source.mWidth - 1
		For y = 0 To source.mHeight - 1
			If maskbc.IsTransparent(x, y) Then
				
			Else
				maskbc.GetARGB(x, y, argb1)
				If argb1.a = 255 Then
					source.SetARGB(x, y, transparent)
				Else
					source.GetARGB(x, y, argb2)
					argb2.a = (argb2.a * (255 - argb1.a)) / 255
					source.SetARGB(x, y, argb2)
				End If
			End If
		Next
	Next
	Return source.Bitmap
End Sub

Public Sub ImplodeAnimated (Duration As Int, Bmp As B4XBitmap, ImageView As B4XView, PieceSize As Int) As ResumableSub
	Dim source As BitmapCreator = CreateBC(Bmp)
	
	Dim NumberOfSteps As Int = Duration / 20
	Dim steps As Int = NumberOfSteps
	Dim GroupSize As Int = PieceSize
	Dim w As Int = Bmp.Width / Bmp.Scale / GroupSize
	Dim h As Int = Bmp.Height / Bmp.Scale / GroupSize
	Dim pgs(w, h) As BCEPixelGroup
	Dim target As BitmapCreator
	target.Initialize(w * GroupSize, h * GroupSize)
	For x = 0 To w - 1
		For y = 0 To h - 1
			Dim pg As BCEPixelGroup = pgs(x, y)
			pg.SrcX = x * GroupSize
			pg.Srcy = y * GroupSize
			Select Rnd(0, 4)
				Case 0
					pg.x = 0
					pg.y = Rnd(0, target.mHeight)
				Case 1
					pg.x = target.mWidth - 1
					pg.y = Rnd(0, target.mHeight)
				Case 2
					pg.x = Rnd(0, target.mWidth)
					pg.y = 0
				Case 3
					pg.x = Rnd(0, target.mWidth)
					pg.y = target.mHeight - 1
			End Select
			
			pg.dx = (pg.SrcX - pg.x) / steps
			pg.dy = (pg.SrcY - pg.y) / steps
		Next
	Next
	Dim r As B4XRect
	r.Initialize(0, 0, 0, 0)
	For i = 0 To steps - 1
		target.FillRect(xui.Color_Transparent, target.TargetRect)
		For x = 0 To w - 1
			For y = 0 To h - 1
				Dim pg As BCEPixelGroup = pgs(x, y)
				pg.x = pg.x + pg.dx
				pg.y = pg.y + pg.dy
				r.Left = pg.SrcX
				r.Right = pg.SrcX + GroupSize
				r.Top = pg.SrcY
				r.Bottom = pg.SrcY + GroupSize
				target.DrawBitmapCreator(source, r, pg.x, pg.y, True)
			Next
		Next
		SetBitmap(ImageView, target.Bitmap)
		Sleep(SleepDuration)
	Next
	SetBitmap(ImageView, Bmp)
	Return True
End Sub

'Replaces OldColor with NewColor.
'KeepAlphaLevel - If true then the alpha level of the source color is kept.
Public Sub ReplaceColor (bmp As B4XBitmap, OldColor As Int, NewColor As Int, KeepAlphaLevel As Boolean) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(bmp)
	Dim oldargb, newargb, a As ARGBColor
	bc.ColorToARGB(OldColor, oldargb)
	bc.ColorToARGB(NewColor, newargb)
	For x = 0 To bc.mWidth - 1
		For y = 0 To bc.mHeight - 1
			bc.GetARGB(x, y, a)
			If (KeepAlphaLevel Or a.a = oldargb.a) And a.r = oldargb.r And a.g = oldargb.g And a.b = oldargb.b Then
				newargb.a = a.a
				bc.SetARGB(x, y, newargb)
			End If
		Next
	Next
	Return bc.Bitmap
End Sub

Public Sub FlipHorizontal (bmp As B4XBitmap) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(bmp)
	Dim c As Float = (bc.mWidth - 1) / 2
	Dim argbLeft, argbRight As ARGBColor
	For x = 0 To c - 0.5
		For y = 0 To bc.mHeight - 1
			bc.GetARGB(x, y, argbLeft)
			bc.GetARGB(bc.mWidth -1 - x, y, argbRight)
			bc.SetARGB(x, y,argbRight)
			bc.SetARGB(bc.mWidth -1 - x, y, argbLeft)
		Next
	Next
	Return bc.Bitmap
End Sub

Public Sub FlipVertical (bmp As B4XBitmap) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(bmp)
	Dim c As Float = (bc.mHeight - 1) / 2
	Dim argbTop, argbDown As ARGBColor
	For x = 0 To bc.mWidth - 1
		For y = 0 To c
			bc.GetARGB(x, y, argbTop)
			bc.GetARGB(x, bc.mHeight - 1 - y, argbDown)
			bc.SetARGB(x, y,argbDown)
			bc.SetARGB(x, bc.mHeight - 1 - y, argbTop)
		Next
	Next
	Return bc.Bitmap
End Sub

Private Sub FadePixel(bc As BitmapCreator, argb As ARGBColor, x As Int, y As Int, f As Float)
	bc.GetARGB(x, y, argb)
	argb.a = argb.a * f
	bc.SetARGB(x, y, argb)
End Sub

Public Sub FadeBorders (bmp As B4XBitmap, Width As Int) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(bmp)
	Dim argb As ARGBColor
	For y = 0 To bc.mHeight - 1
		For x = 0 To Width - 1
			Dim f As Float = (x + 1) / Width
			FadePixel(bc, argb, x, y, f)
			FadePixel(bc, argb, bc.mWidth - 1 - x, y, f)
		Next
	Next
	For x = 0 To bc.mWidth - 1
		For y = 0 To Width - 1
			Dim f As Float = (y + 1) / Width
			FadePixel(bc, argb, x, y, f)
			FadePixel(bc, argb, x, bc.mHeight - 1 - y, f)
		Next
	Next
	Return bc.Bitmap
End Sub

Public Sub TransitionAnimated (Duration As Int, FromBmp As B4XBitmap, ToBmp As B4XBitmap, ImageView As B4XView) As ResumableSub
	Dim frombc As BitmapCreator = CreateBC(FromBmp)
	Dim tobc As BitmapCreator = CreateBC(ToBmp)
	Dim target As BitmapCreator
	target.Initialize(frombc.mWidth, frombc.mHeight)
	Dim StartTime As Long = DateTime.Now
	Dim EndTime As Long = StartTime + Duration
	Dim fromclr, toclr As ARGBColor
	Do While DateTime.Now < EndTime
		Dim progress As Float = (DateTime.Now - StartTime) / Duration
		For x = 0 To frombc.mWidth - 1
			For y = 0 To frombc.mHeight - 1
				frombc.GetARGB(x, y, fromclr)
				tobc.GetARGB(x, y, toclr)
				toclr.a = fromclr.a + progress * (toclr.a - fromclr.a)
				toclr.r = fromclr.r + progress * (toclr.r - fromclr.r)
				toclr.g = fromclr.g + progress * (toclr.g - fromclr.g)
				toclr.b = fromclr.b + progress * (toclr.b - fromclr.b)
				target.SetARGB(x, y, toclr)
			Next
		Next
		SetBitmap(ImageView, target.Bitmap)
		Sleep(SleepDuration)
	Loop
	SetBitmap(ImageView, target.Bitmap)
	Return True
End Sub

Private Sub SetBitmap(iv As B4XView, bmp As B4XBitmap)
	If iv.Tag Is B4XImageView Then
		Dim v As B4XImageView = iv.Tag
		v.Bitmap = bmp
	Else
		iv.SetBitmap(bmp)
	End If
End Sub

Public Sub AdjustColors(Bmp As B4XBitmap, HueOffset As Int, SaturationFactor As Float) As B4XBitmap
	Dim bc As BitmapCreator = CreateBC(Bmp)
	Dim hsv As HSVColor
	Dim argb As ARGBColor
	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			bc.GetARGB(x, y, argb)
			ARGBToHSV(argb, hsv)
			hsv.S = hsv.S * SaturationFactor
			hsv.H = (hsv.H + HueOffset) Mod 360
			bc.SetHSV(x, y, hsv.A, hsv.H, hsv.S, hsv.V)
		Next
	Next
	Return bc.Bitmap
End Sub

Private Sub ARGBToHSV(argb As ARGBColor, HSV As HSVColor)
	Dim a As Int = argb.a
	Dim r As Int = argb.r
	Dim g As Int = argb.g
	Dim b As Int = argb.b
	Dim h, s, v As Float
	Dim cmax As Int = Max(Max(r, g), b)
	Dim cmin As Int = Min(Min(r, g), b)
	v = cmax / 255
	If cmax <> 0 Then
		s = (cmax - cmin) / cmax
	End If
	If s = 0 Then
		h = 0
	Else
		Dim rc As Float = (cmax - r) / (cmax - cmin)
		Dim gc As Float = (cmax - g) / (cmax - cmin)
		Dim bc As Float = (cmax - b) / (cmax - cmin)
		If r = cmax Then
			h = bc - gc
		Else If g = cmax Then
			h = 2 + rc - bc
		Else
			h = 4 + gc - rc
		End If
		h = h / 6
		If h < 0 Then h = h + 1
	End If
	HSV.H = h * 360
	HSV.S = s
	HSV.V = v
	HSV.A = a
End Sub

