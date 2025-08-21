B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'version 3.20
Sub Class_Globals
	Private mBuffer() As Byte
	Public mWidth, mHeight As Int
	Private ai, ri, gi, bi As Int
	Type PremultipliedColor (a As Int, r As Int, g As Int, b As Int)
	Type ARGBColor (a As Int, r As Int, g As Int, b As Int)
	Private tempARGB As ARGBColor
	Private tempPM, tempPM2 As PremultipliedColor
#if B4A
	Private b4abmp As Bitmap
#else if B4J
	Private WriteableImage As JavaObject
#end if
	Public TargetRect As B4XRect
	Private UnsignedFF As Int
End Sub

'Initializes the object and sets the bitmap dimensions.
'Note that XUI library must be referenced as well.
Public Sub Initialize (Width As Int, Height As Int)
	Dim b As Byte = 0xff
	UnsignedFF = b
	mWidth = Width
	mHeight = Height
	Dim mBuffer(mWidth * mHeight * 4) As Byte
	#if B4A or B4i
	ai = 3
	ri = 0
	gi = 1
	bi = 2
	#else if B4J
	ai = 3
	ri = 2
	gi = 1
	bi = 0
	
	#end if
	TargetRect.Initialize(0, 0, mWidth, mHeight)
End Sub

'Gets the internal buffer.
Public Sub getBuffer() As Byte()
	Return mBuffer
End Sub

'Extracts the pixels from the SourceBitmap and copies them.
'Note that the source bitmap is first resized, if needed, to match the BitmapCreator dimensions.
Public Sub CopyPixelsFromBitmap (SourceBitmap As B4XBitmap)
	If SourceBitmap.Width <> mWidth Or SourceBitmap.Height <> mHeight Then
		SourceBitmap = SourceBitmap.Resize(mWidth, mHeight, False)
	End If
	#if B4A
	Dim jo As JavaObject = SourceBitmap
	Dim format As Object = jo.RunMethod("getConfig", Null)
	If "ARGB_8888" <> format Then
		Log("Unsupported format: " & format)
		Return
	End If
	Dim bf As JavaObject
	bf = bf.InitializeStatic("java.nio.ByteBuffer").RunMethodJO("wrap", Array(mBuffer))
	jo.RunMethod("copyPixelsToBuffer", Array(bf))
	#else if B4J
	Dim jo As JavaObject = SourceBitmap
	Dim reader As JavaObject = jo.RunMethod("getPixelReader", Null)
	Dim PixelFormat As JavaObject
	PixelFormat.InitializeStatic("javafx.scene.image.PixelFormat")
	reader.RunMethod("getPixels", Array(0, 0, mWidth, mHeight, PixelFormat.RunMethod("getByteBgraPreInstance", Null), _
       mBuffer, 0, mWidth * 4))
	 #Else If B4i
	Dim no As NativeObject = Me
	no.RunMethod("UIImageToBuffer::::", Array(SourceBitmap, no.ArrayToNSData(mBuffer), mWidth, mHeight))
	#End If
End Sub

'Sets the color of the given pixel.
Public Sub SetColor(x As Int, y As Int, Clr As Int)
	ColorToARGB(Clr, tempARGB)
	SetARGB(x, y, tempARGB)
End Sub

'Converts color int to ARGBColor object.
'The Result parameter will hold the output.
Public Sub ColorToARGB (Clr As Int, Result As ARGBColor) As ARGBColor
	Result.a = Bit.And(0xff, Bit.ShiftRight(Clr, 24))
	Result.r = Bit.And(0xff, Bit.ShiftRight(Clr, 16))
	Result.g =  Bit.And(0xff, Bit.ShiftRight(Clr, 8))
	Result.b =  Bit.And(0xff, Clr)
	Return Result
End Sub

'Converts an ARGB color to PremultipliedColor.
'The Result parameter will hold the output.
Public Sub ARGBToPremultipliedColor (ARGB As ARGBColor, PM As PremultipliedColor) As PremultipliedColor
	Dim a As Float = ARGB.a / 255
	PM.a = ARGB.a
	PM.r = ARGB.r * a
	PM.g = ARGB.g * a
	PM.b = ARGB.b * a
	Return PM
End Sub

'Sets the color of the specified point.
Public Sub SetHSV(x As Int, y As Int, alpha As Int, h As Int, s As Float, v As Float)
	Dim r, g, b As Float
	Dim hi As Int = Floor(h / 60)
	Dim hbucket As Int =  hi Mod 6
	Dim f As Float = h / 60 - hi
	Dim p As Float = v * (1 - s)
	Dim q As Float = v  * (1 - f * s)
	Dim t As Float = v * (1 - (1 - f) * s)
	Select hbucket
		Case 0
			r = v
			g = t
			b = p
		Case 1
			r = q
			g = v
			b = p
		Case 2
			r = p
			g = v
			b = t
		Case 3
			r = p
			g = q
			b = v
		Case 4
			r = t
			g = p
			b = v
		Case 5
			r = v
			g = p
			b = q
	End Select
	tempARGB.a = alpha
	tempARGB.r = r * 255
	tempARGB.g = g * 255
	tempARGB.b = b * 255
	SetARGB(x, y, tempARGB)
End Sub

'Sets the color of the specified point.
Public Sub SetARGB(x As Int, y As Int, ARGB As ARGBColor)
	SetPremultipliedColor(x, y, ARGBToPremultipliedColor(ARGB, tempPM))
End Sub

'Sets the color of the specified point. 
Private Sub SetPremultipliedColor (x As Int, y As Int, Premultiplied As PremultipliedColor)
	Dim cp As Int = x * 4 + y * mWidth * 4
	#if B4i
	Bit.FastArraySetByte(mBuffer, cp + ri, Premultiplied.r)
	Bit.FastArraySetByte(mBuffer, cp + gi, Premultiplied.g)
	Bit.FastArraySetByte(mBuffer, cp + bi, Premultiplied.b)
	Bit.FastArraySetByte(mBuffer, cp + ai, Premultiplied.a)
	#else
	mBuffer(cp + ri) = Premultiplied.r
	mBuffer(cp + gi) = Premultiplied.g
	mBuffer(cp + bi) = Premultiplied.b
	mBuffer(cp + ai) = Premultiplied.a
	#End If
	
End Sub

'Gets the color of the given point as a premultiplied color. No conversion is required for this format.
'The Result parameter stores the output.
Private Sub GetPremultipliedColor (x As Int, y As Int, Result As PremultipliedColor) As PremultipliedColor
	Dim cp As Int = x * 4 + y * mWidth * 4
	#if B4i
	Result.r = Bit.FastArrayGetByte(mBuffer, cp + ri)
	Result.g = Bit.FastArrayGetByte(mBuffer, cp + gi)
	Result.b = Bit.FastArrayGetByte(mBuffer, cp + bi)
	Result.a = Bit.FastArrayGetByte(mBuffer, cp + ai)
	#else
	Result.r = mBuffer(cp + ri)
	Result.g = mBuffer(cp + gi)
	Result.b = mBuffer(cp + bi)
	Result.a = mBuffer(cp + ai)
	#End If
	Return Result
End Sub

'Gets the color of the given point as an int value.
Public Sub GetColor (x As Int, y As Int) As Int
	GetARGB(x, y, tempARGB)
	Return Bit.ShiftLeft(tempARGB.a, 24) + Bit.ShiftLeft(tempARGB.r, 16) + Bit.ShiftLeft(tempARGB.g, 8) + tempARGB.b
End Sub

'Gets the color of the given point as an ARGB color.
'The Result parameter stores the output.
Public Sub GetARGB (x As Int, y As Int, Result As ARGBColor) As ARGBColor
	Dim cp As Int = x * 4 + y * mWidth * 4
#if B4i
	Result.a = Bit.FastArrayGetByte(mBuffer, cp + ai)
	Dim af As Float = Result.a / 255
	Result.r = Bit.FastArrayGetByte(mBuffer, cp + ri) / af
	Result.g = Bit.FastArrayGetByte(mBuffer, cp + gi) / af
	Result.b = Bit.FastArrayGetByte(mBuffer, cp + bi) / af
#Else
	Result.a = Bit.And(0xff, mBuffer(cp + ai))
	Dim af As Float = Result.a / 255
	Result.r = Bit.And(0xff, mBuffer(cp + ri)) / af
	Result.g = Bit.And(0xff, mBuffer(cp + gi)) / af
	Result.b = Bit.And(0xff, mBuffer(cp + bi)) / af
#End If
	
	Return Result
End Sub

'Tests whether a given point is completely transparent.
Public Sub IsTransparent(x As Int, y As Int) As Boolean
	Dim cp As Int = x * 4 + y * mWidth * 4
	Return mBuffer(cp + ai) = 0
End Sub

'Converts the bytes buffer to a bitmap.
Public Sub getBitmap As B4XBitmap
	#if B4A
	Dim bf As JavaObject
	bf = bf.InitializeStatic("java.nio.ByteBuffer").RunMethodJO("wrap", Array(mBuffer))
	If b4abmp.IsInitialized = False Then
		b4abmp.InitializeMutable(mWidth, mHeight)
	End If
	Dim jo As JavaObject = b4abmp
	jo.RunMethod("setDensity", Array(160))
	jo.RunMethod("copyPixelsFromBuffer", Array(bf))
	Return b4abmp
	#else if B4J
	If WriteableImage.IsInitialized = False Then
		WriteableImage.InitializeNewInstance("javafx.scene.image.WritableImage", Array(mWidth, mHeight))
	End If
	Dim writer As JavaObject = WriteableImage.RunMethod("getPixelWriter", Null)
	Dim PixelFormat As JavaObject
	PixelFormat.InitializeStatic("javafx.scene.image.PixelFormat")
	writer.RunMethod("setPixels", Array(0, 0, mWidth, mHeight, PixelFormat.RunMethod("getByteBgraPreInstance", Null), _
		mBuffer, 0, mWidth * 4))
	Return WriteableImage
	#Else
	Dim no As NativeObject = Me
	Dim bmp As Bitmap = no.RunMethod("bufferToUIImage:::", Array(no.ArrayToNSData(mBuffer), mWidth, mHeight))
	Return bmp
	#end if
End Sub



#Region ************  Drawing methods ***************
'Fills the given rectangle. Skips blending.
Public Sub FillRect (Color As Int, Rect As B4XRect)
	Dim StartX As Int = Max(0, Rect.Left)
	Dim EndX As Int = Min(mWidth - 1, Rect.Right - 1)
	Dim StartY As Int = Max(0, Rect.Top)
	Dim EndY As Int = Min(mHeight - 1, Rect.Bottom - 1)
	If EndX < StartX Or EndY < StartY Then Return
	SetColor(StartX, StartY, Color)
	Dim cp As Int = StartX * 4 + StartY * mWidth * 4
	Dim b((EndX - StartX + 1) * 4) As Byte
	For x = 0 To b.Length - 4 Step 4
		b(x) = mBuffer(cp)
		b(x + 1) = mBuffer(cp + 1)
		b(x + 2) = mBuffer(cp + 2)
		b(x + 3) = mBuffer(cp + 3)
	Next
	For y = StartY * mWidth * 4 To EndY * mWidth * 4 Step mWidth * 4
		Bit.ArrayCopy(b, 0, mBuffer, y + StartX * 4, b.Length)
	Next
End Sub

'Draws a bitmap to the buffer.
'SkipBlending - Whether non-opaque pixels in the source bitmap should blend with the background.
Public Sub DrawBitmap (Bmp As B4XBitmap, TargetRect1 As B4XRect, SkipBlending As Boolean)
	If Bmp.Width <> TargetRect1.Width Or Bmp.Height <> TargetRect1.Height Then
		Bmp = Bmp.Resize(TargetRect1.Width, TargetRect1.Height, False)
	End If
	Dim Src As BitmapCreator
	Src.Initialize(Bmp.Width, Bmp.Height)
	Src.CopyPixelsFromBitmap(Bmp)
	Dim SrcRect As B4XRect
	SrcRect.Initialize(0, 0, Src.mWidth, Src.mHeight)
	DrawBitmapCreator(Src, SrcRect, TargetRect1.Left, TargetRect1.Top, SkipBlending)
End Sub

'Draws the image stored in the Source BitmapCreator to this BitmapCreator.
'Source - Source BitmapCreator
'SrcRect - Defines the region in the Source BC that will be copied.
'TargetX / TargetY - Top left point in the destination BC.
'SkipBlending - Whether non-opaque pixels in the source bitmap should blend with the background. 
Public Sub DrawBitmapCreator (Source As BitmapCreator, SrcRect As B4XRect, TargetX As Int, TargetY As Int, SkipBlending As Boolean)
	If TargetY >= mHeight Or TargetX >= mWidth Then Return
	TargetX = Max(0, TargetX)
	TargetY = Max(0, TargetY)
	Dim DeltaX As Int = Min(mWidth - 1 - TargetX, Min(SrcRect.Width - 1, Source.mWidth - 1 - SrcRect.Left))
	Dim DeltaY As Int = Min(mHeight - 1 - TargetY, Min(SrcRect.Height - 1, Source.mHeight - 1 - SrcRect.Top))
	Dim SrcTop As Int = SrcRect.Top
	Dim SrcLeft As Int = SrcRect.Left
	If SkipBlending Then
		'Dim cp As Int = x * 4 + y * mWidth * 4
		For y = TargetY To TargetY + DeltaY
			Bit.ArrayCopy(Source.mBuffer, SrcLeft * 4 + (y - TargetY + SrcTop) * 4 * Source.mWidth, mBuffer, _
				TargetX * 4 + y * 4 * mWidth, (DeltaX + 1) * 4)
		Next
	Else
		For x = TargetX To TargetX + DeltaX
			For y = TargetY To TargetY + DeltaY
				#if B4i
				Dim cp1 As Int = (x - TargetX + SrcLeft) * 4 + (y - TargetY + SrcTop) * Source.mWidth * 4
				Dim cp2 As Int = x * 4 + y * mWidth * 4
				Dim a1 As Byte = Bit.FastArrayGetByte(Source.mBuffer, cp1 + ai)
				Dim r1 As Byte = Bit.FastArrayGetByte(Source.mBuffer, cp1 + ri)
				Dim g1 As Byte = Bit.FastArrayGetByte(Source.mBuffer, cp1 + gi)
				Dim b1 As Byte = Bit.FastArrayGetByte(Source.mBuffer, cp1 + bi)
				
				If a1 <> UnsignedFF Then
					If a1 = 0 Then Continue
					Dim a2 As Byte = Bit.FastArrayGetByte(mBuffer, cp2 + ai)
					Dim r2 As Byte = Bit.FastArrayGetByte(mBuffer, cp2 + ri)
					Dim g2 As Byte = Bit.FastArrayGetByte(mBuffer, cp2 + gi)
					Dim b2 As Byte = Bit.FastArrayGetByte(mBuffer, cp2 + bi)
					Dim SrcAF As Float = 1 - (a1 / 255)
					r1 =  r1 + SrcAF *  r2
					g1 =  g1 + SrcAF *  g2
					b1 =  b1 + SrcAF *  b2
					a1 =  a1 + SrcAF *  a2
				End If
				Bit.FastArraySetByte(mBuffer, cp2 + ri, r1)
				Bit.FastArraySetByte(mBuffer, cp2 + gi, g1)
				Bit.FastArraySetByte(mBuffer, cp2 + bi, b1)
				Bit.FastArraySetByte(mBuffer, cp2 + ai, a1)
				#else
				BlendPixel(Source, x - TargetX + SrcRect.Left, y - TargetY + SrcRect.Top, x, y)
				
				#End If
			Next
		Next
	End If
End Sub

'Copies a single pixel from Source to this BC. 
Public Sub CopyPixel (Source As BitmapCreator, SrcX As Int, SrcY As Int, TargetX As Int, TargetY As Int)
	Dim SourceCP As Int = SrcX * 4 + SrcY * Source.mWidth * 4
	Dim TargetCP As Int = TargetX * 4 + TargetY * mWidth * 4
#if B4i
	Bit.FastArraySetByte(mBuffer, TargetCP, Bit.FastArrayGetByte(Source.mBuffer, SourceCP))
	Bit.FastArraySetByte(mBuffer, TargetCP + 1, Bit.FastArrayGetByte(Source.mBuffer, SourceCP + 1))
	Bit.FastArraySetByte(mBuffer, TargetCP + 2, Bit.FastArrayGetByte(Source.mBuffer, SourceCP + 2))
	Bit.FastArraySetByte(mBuffer, TargetCP + 3, Bit.FastArrayGetByte(Source.mBuffer, SourceCP + 3))
#else
	mBuffer(TargetCP) = Source.mBuffer(SourceCP)
	mBuffer(TargetCP + 1) = Source.mBuffer(SourceCP + 1)
	mBuffer(TargetCP + 2) = Source.mBuffer(SourceCP + 2)
	mBuffer(TargetCP + 3) = Source.mBuffer(SourceCP + 3)
#End If
End Sub

'Copies a single pixel from Source to this BC. If the pixel is non-opaque then it will blend with the current pixel.
Public Sub BlendPixel (Source As BitmapCreator, SrcX As Int, SrcY As Int, TargetX As Int, TargetY As Int)
	Dim SrcPM As PremultipliedColor = Source.GetPremultipliedColor(SrcX, SrcY, tempPM2)
	If SrcPM.a <> UnsignedFF Then
		If SrcPM.a = 0 Then Return
		SrcPM.a = Bit.And(0xff, SrcPM.a)
		GetPremultipliedColor(TargetX, TargetY, tempPM)
		Dim SrcAF As Float = 1 - (SrcPM.a / 255)
		SrcPM.r =  Bit.And(0xff, SrcPM.r) + SrcAF *  Bit.And(0xff, tempPM.r)
		SrcPM.g =  Bit.And(0xff, SrcPM.g) + SrcAF *  Bit.And(0xff, tempPM.g)
		SrcPM.b =  Bit.And(0xff, SrcPM.b) + SrcAF *  Bit.And(0xff, tempPM.b)
		SrcPM.a =  Bit.And(0xff, SrcPM.a) + SrcAF *  Bit.And(0xff, tempPM.a)
	End If
	SetPremultipliedColor(TargetX, TargetY, SrcPM)
End Sub

'Fills the rectangle with a gradient. Skips blending.
'GradColors - An array of two or more colors that define the gradient.
'Rect - The region that will be filled.
'Orientation - One of the following: TL_BR, TOP_BOTTOM, TR_BL, LEFT_RIGHT, RIGHT_LEFT, BL_TR, BOTTOM_TOP, BR_TL and RECTANGLE.
Public Sub FillGradient (GradColors() As Int, Rect As B4XRect, Orientation As String)
	If Rect.Width <= 1 Or Rect.Height <= 1 Or Rect.Left >= mWidth Or Rect.Top >= mHeight Then Return
	If GradColors.Length = 1 Then
		FillRect(GradColors(0), Rect)
		Return
	End If
	Dim SinL As Float
	Dim StartY As Int = Max(Rect.Top, 0)
	Dim EndY As Int = Min(Rect.Bottom - 1, mHeight - 1)
	Dim ox, deltaox As Float
	Dim AxisLength As Int
	Dim TopBottom As Boolean
	Dim OppositeColors As Boolean
	Dim TR_BL As Boolean
	Dim Rectangle As Boolean
	Dim NumberOfParts As Int = GradColors.Length - 1
	Dim DFix(NumberOfParts + 1) As Float
	Dim DFixDivSinL(NumberOfParts + 1) As Float
	Select Orientation
		Case "TL_BR", "BR_TL", "TR_BL", "BL_TR"
			Dim alpha As Float = ATanD(Rect.Width / Rect.Height)
			SinL = SinD(alpha)
			AxisLength = Sqrt(Power(Rect.Width, 2) + Power(Rect.Height, 2))
			Dim TanL As Float = TanD(alpha)
			deltaox = 1 / TanL
			ox = (StartY - Rect.Top) / TanL
			OppositeColors = Orientation = "BR_TL" Or Orientation = "BL_TR"
			TR_BL = Orientation = "TR_BL" Or Orientation = "BL_TR"
		Case "LEFT_RIGHT", "RIGHT_LEFT"
			AxisLength = Rect.Width
			deltaox = 0
			SinL = 1
			OppositeColors = Orientation = "RIGHT_LEFT"
		Case "TOP_BOTTOM", "BOTTOM_TOP"
			AxisLength = Rect.Height
			SinL = 0
			ox = 0
			TopBottom = True
			OppositeColors = Orientation = "BOTTOM_TOP"
		Case "RECTANGLE"
			AxisLength = Max(Rect.Width, Rect.Height) / 2
			Rectangle = True
		Case Else
			Log("Invalid orientation: " & Orientation)
	End Select
	
	Dim RGBColor(GradColors.Length) As ARGBColor
	For i = 0 To GradColors.Length - 1
		Dim a As Int = i
		If OppositeColors Then a = GradColors.Length - 1 - i
		ColorToARGB(GradColors(a), RGBColor(i))
	Next
	
	For i = 0 To NumberOfParts
		DFix(i) = i / NumberOfParts * AxisLength
		DFixDivSinL(i) = DFix(i) / SinL
	Next
	Dim EndMax As Int = Min(mWidth - 1, Rect.Right - 1)
	Dim StartMin As Int = Max(Rect.Left, 0)
	Dim ClrFrom, ClrTo As ARGBColor
	Dim argb As ARGBColor
	Dim tStartX, tEndX, tStep = 1 As Int
	If Rectangle Then
		Dim cx As Int = Rect.CenterX
		Dim cy As Int = Rect.CenterY
		Dim XFix = Min(1, Rect.Width / Rect.Height), YFix = Min(1, Rect.Height / Rect.Width) As Float
		For part = 0 To NumberOfParts - 1
			ClrFrom = RGBColor(part)
			ClrTo = RGBColor(part + 1)
			For r = part / NumberOfParts * AxisLength To (part + 1) / NumberOfParts * AxisLength
				Dim dd As Float = (r - DFix(part)) / (AxisLength / NumberOfParts)
				For x = -r To r
					argb.a = ClrFrom.a + dd * (ClrTo.a - ClrFrom.a)
					argb.r = ClrFrom.r + dd * (ClrTo.r - ClrFrom.r)
					argb.g = ClrFrom.g + dd * (ClrTo.g - ClrFrom.g)
					argb.b = ClrFrom.b + dd * (ClrTo.b - ClrFrom.b)
					ARGBToPremultipliedColor(argb, tempPM)
					SetPremultipliedColor(cx + x * XFix, cy - r * YFix, tempPM)
					SetPremultipliedColor(cx + x * XFix, cy + r * YFix, tempPM)
					SetPremultipliedColor(cx - r * XFix, cy + x * YFix, tempPM)
					SetPremultipliedColor(cx + r * XFix, cy + x * YFix, tempPM)
				Next
			Next
		Next
	Else
		For y = StartY To EndY
			Dim EndX As Int = Rect.Left - ox - 1
			For part = 0 To NumberOfParts - 1
				ClrFrom = RGBColor(part)
				ClrTo = RGBColor(part + 1)
				If TopBottom Then
					Dim d As Float = y - Rect.Top
					Dim dd As Float = (d - DFix(part)) / (AxisLength / NumberOfParts)
					If dd < 0 Or dd > 1 Then
						Continue
					End If
					Dim tStartX As Int = StartMin
					Dim tEndX As Int = EndMax
				Else
					Dim StartX As Int = Max(StartMin, EndX + 1)
					Dim EndX As Int = Min(Rect.Left + DFixDivSinL(part + 1) - ox, EndMax)
					Dim d As Float = SinL * (StartX - Rect.Left + ox)
					Dim ddDelta As Float = SinL / (AxisLength / NumberOfParts)
					Dim dd As Float = (d - DFix(part)) / (AxisLength / NumberOfParts)
					If TR_BL Then
						tStartX = Rect.Right - 1 - (StartX - Rect.Left)
						tEndX = Rect.Right - 1 - (EndX - Rect.Left)
						tStep = -1
					Else
						tStartX = StartX
						tEndX = EndX
					End If
				End If
				For	x = tStartX To tEndX Step tStep
					argb.a = ClrFrom.a + dd * (ClrTo.a - ClrFrom.a)
					argb.r = ClrFrom.r + dd * (ClrTo.r - ClrFrom.r)
					argb.g = ClrFrom.g + dd * (ClrTo.g - ClrFrom.g)
					argb.b = ClrFrom.b + dd * (ClrTo.b - ClrFrom.b)
					SetARGB(x, y, argb)
					dd = dd + ddDelta
				Next
			Next
			ox = ox + deltaox
		Next
	End If
	
End Sub

'Fills the rectangle with a radial gradient. Skips blending.
Public Sub FillRadialGradient (GradColors() As Int, Rect As B4XRect)
	Dim RGBColor(GradColors.Length) As ARGBColor
	For i = 0 To GradColors.Length - 1
		ColorToARGB(GradColors(i), RGBColor(i))
	Next
	Dim MaxDistance As Int = Ceil(Sqrt(Power(Rect.Width / 2, 2) + Power(Rect.Height / 2, 2)))
	Dim DistanceToColor(MaxDistance) As ARGBColor
	Dim CurrentColorIndex As Int
	Dim LengthOfEachColor As Int = Ceil(MaxDistance / (GradColors.Length - 1))
	Dim c As Int
	For i = 0 To MaxDistance - 1
		Dim l As Float = CurrentColorIndex / LengthOfEachColor
		DistanceToColor(i).a = RGBColor(c).a + l * (RGBColor(c + 1).a - RGBColor(c).a)
		DistanceToColor(i).r = RGBColor(c).r + l * (RGBColor(c + 1).r - RGBColor(c).r)
		DistanceToColor(i).g = RGBColor(c).g + l * (RGBColor(c + 1).g - RGBColor(c).g)
		DistanceToColor(i).b = RGBColor(c).b + l * (RGBColor(c + 1).b - RGBColor(c).b)
		CurrentColorIndex = CurrentColorIndex + 1
		If CurrentColorIndex = LengthOfEachColor Then
			CurrentColorIndex = 0
			c = c + 1
		End If
	Next
	Dim cx As Int = Rect.CenterX
	Dim cy As Int = Rect.CenterY
	For x = Max(0, Rect.Left) To Min(mWidth - 1, Rect.Right - 1)
		Dim dx As Int = Power(x - cx, 2)
		For y = Max(0, Rect.Top) To Min(mHeight - 1, Rect.Bottom - 1)
			Dim distance As Int = Sqrt(dx + Power(y - cy, 2))
			SetARGB(x, y, DistanceToColor(distance))
		Next
	Next
End Sub


#End Region

#Region *****************  Native code ***********
#if OBJC
- (void)UIImageToBuffer:(UIImage*) bmp :(NSData*)data :(int)width :(int)height{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate([(NSMutableData*)data mutableBytes], 
			width, 
			height, 
			8, 
			4 * width, 
			colorSpace, 
			kCGImageAlphaPremultipliedLast); 
	if(!context) {
		NSLog(@"Failed to create bitmap context");
	}		
	CGColorSpaceRelease(colorSpace);
	CGImageRef imageRef = bmp.CGImage;
	CGRect rect = CGRectMake(0, 0, width, height);
	CGContextDrawImage(context, rect, imageRef);
	CGContextRelease(context);
}
- (UIImage*) bufferToUIImage:(NSData*)data :(int)width :(int)height {
	CGDataProviderRef provider = CGDataProviderCreateWithCFData( (CFDataRef) data );
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	
	CGImageRef iref = CGImageCreate(width, 
				height, 
				8, 
				32, 
				4 * width, 
				colorSpaceRef, 
				bitmapInfo, 
				provider,	
				NULL,	
				YES,
		renderingIntent);
	UIImage* image = [UIImage imageWithCGImage:iref scale:1 orientation:UIImageOrientationUp];
	CGColorSpaceRelease(colorSpaceRef);
	CGImageRelease(iref);
	CGDataProviderRelease(provider);
	return image;
}
#End If

#End Region