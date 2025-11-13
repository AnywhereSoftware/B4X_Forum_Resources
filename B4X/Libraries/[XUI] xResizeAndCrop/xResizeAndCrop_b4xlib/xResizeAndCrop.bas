B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.78
@EndOfDesignText@
'xResizeAndCrop Custom View class
'This CustomView allows cropping and resizing images
'
'Version 1.9	
'Amenden problem with mMinCroppedWidth and mMinCroppedHeight, wrong scale
'
'Version 1.8	
'Added code, in the B4XMainPage module, to load an image with B4i.

'Version 1.7  2023.03.24
'Set the crop window to the entire image when the width / height ratio is NONE
'
'Version 1.6  2022.06.26
'Added Circle and round corner crop
'Added RoundCorner and CornerRadius properties.
'The library needs the BitmapCreator library.
'
'Version 1.5	2022.02.12
'Added the HandleDotWidth property
'
'Version 1.4	2020.07.15
'Amended error with getCroppedImage without a CroppedImageView
'
'Version 1.3	2020.05.23
'Updated the Tag property according to Erels recommendation:
'https://www.b4x.com/android/forum/threads/b4x-how-to-get-custom-view-here-from-clv-or-any-other-container.117992/#post-738358
'
'Version 1.2	2019.03.08
'Added WidthHeightRatio and WidthHeightRatioValue properties
'defining fixed or custom Width / Height ratios for the cropped image
'Added RotateImage method, original image rotation.
'
'Version 1.1	2019.01.29
'Addes a Square property, limits the resize function to a square.
'
'Version 1.0	2019.01.19
'
'Written by Klaus CHRISTL (klaus)
'
' these Event lines are useful for a library compilation for the IDE autocompletion
#Event: CropFinished
' these RaisesSynchronousEvents lines are useful for a library compilation
#RaisesSynchronousEvents: CropFinished

'custom properties
#DesignerProperty: Key: MinCroppedWidth, DisplayName: MinCroppedWidth, FieldType: Int, DefaultValue: 50, Description: Minimum Width in pixels.
#DesignerProperty: Key: MinCroppedHeight, DisplayName: MinCroppedHeight, FieldType: Int, DefaultValue: 50, Description: Minimum Height in pixels.
#DesignerProperty: Key: HandleColor, DisplayName: HandleColor, FieldType: Color, DefaultValue: #FFFFD700, Description: Color of the selection handles.
#DesignerProperty: Key: WidthHeightRatio, DisplayName: WidthHeightRatio, FieldType: String, DefaultValue: None, List: None|Square|Circle|3/2|2/3|4/3|3/4|16/9|9/16|Custom, Description: Defines a Width / Height ratio.
#DesignerProperty: Key: WidthHeightRatioValue, DisplayName: WidthHeightRatioValue, FieldType: Float, DefaultValue:0.75, Description: Custom Width / Height ratio value.
#DesignerProperty: Key: RoundCorners, DisplayName: RoundCorners, FieldType: Boolean, DefaultValue: False, Description: Rounds the corners with a radius equal to the CornerRadius property.
#DesignerProperty: Key: CornerRadius, DisplayName: CornerRadius, FieldType: Int, DefaultValue: 25, Description: Corner radius in percent of the smallest original image side; default value 25%.
#DesignerProperty: Key: HandleDotWidth, DisplayName: HandleDotWidth, FieldType: Int, DefaultValue:13, Description: Width of the handle dots; default value 13.


Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI
	Public Tag As Object
	
	Private xpnlAction, ximvImage As B4XView
	Private imvImage As ImageView
	
	Private xpnlCropped As B4XView
	Private xcvsAction, xcvsCropped As B4XCanvas
	Private xbmpImage, xbmpCropped As B4XBitmap
	Private rectImage, rectAction, rectCroppedView As B4XRect

	Private mLeft, mTop, mWidth, mHeight As Int
	Private cLeft, cTop, cWidth, cHeight As Int
	Private MaxWidth, MaxHeight, imvLeft, imvTop, imvWidth, imvHeight, imvCroppedWidth, imvCroppedHeight As Int
	Private rLeft, rTop, rRight, rBottom, rWidth As Int
	Private Delta, DeltaX, DeltaY, StartX, StartY As Int
	Private DeltaDot As Int						' half of selection square
	Private HandleDot As Int					' half of marker square
	Private fLeft, fTop, fRight, fBottom, fTopLeft, fTopRight, fBottomLeft, fBottomRight, fCenter As Boolean
	Private mMinCroppedWidth As Int
	Private mMinCroppedHeight As Int
	Private PixelScale As Double
	Private mHandleColor As Int
	Private mWidthHeightRatio As String
	Private mWidthHeightRatioValue, UsedWHCustomRatio As Double
	Private mRoundCorners As Boolean
	Private mCornerRadius As Int
	Private mFullImage  = False As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	mHandleColor = xui.Color_RGB(255, 215, 0)
	DeltaDot = 10dip
	mMinCroppedWidth = 50
	mMinCroppedHeight = 50
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mLeft = mBase.Left
	mTop = mBase.Top
	mWidth = mBase.Width
	mHeight = mBase.Height
	
	mMinCroppedWidth = Props.GetDefault("MinCroppedWidth", 50)
	mMinCroppedHeight = Props.GetDefault("MinCroppedHeight", 50)
	mHandleColor = xui.PaintOrColorToColor(Props.GetDefault("HandleColor", 0xFFFFD700) )
	mWidthHeightRatio = Props.GetDefault("WidthHeightRatio", "None")
	mWidthHeightRatioValue = Props.GetDefault("WidthHeightRatioValue", 1.5)
	mRoundCorners = Props.GetDefault("RoundCorners", False)
	mCornerRadius = Props.GetDefault("CornerRadius", 25)
	HandleDot = Props.GetDefault("HandleDotWidth", 13) / 2 * xui.Scale
	
	UpdateWidthHeightRatio
	
	InitClass
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mWidth = Width
	mHeight = Height
	mBase.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mBase.SetColorAndBorder(mBase.Color, 0, mBase.Color, 0)
	ximvImage.SetLayoutAnimated(0, 0, 0, mWidth, mHeight)
	xpnlAction.SetLayoutAnimated(0, 0, 0, mWidth, mHeight)
	xcvsAction.Resize(mWidth, mHeight)
	rectAction.Initialize(0, 0, xpnlAction.Width, xpnlAction.Height)
	rectImage.Initialize(0, 0, 100dip, 100dip)
	If xbmpImage.IsInitialized Then
		DrawImage		
	End If
End Sub

Private Sub InitClass
	imvImage.Initialize("")
	mBase.AddView(imvImage, 0, 0, mWidth, mHeight)
	ximvImage = imvImage
	
	xpnlAction = xui.CreatePanel("xpnlAction")
	mBase.AddView(xpnlAction, 0, 0, mWidth, mHeight)
	xcvsAction.Initialize(xpnlAction)
	rectAction.Initialize(0, 0, xpnlAction.Width, xpnlAction.Height)
	xcvsAction.ClearRect(rectAction)
End Sub

Private Sub DrawImage
	If xbmpImage.IsInitialized = False Then
		Return
	End If
	
	imvTop = HandleDot
	rectAction.Initialize(0, 0, xpnlAction.Width, xpnlAction.Height)
	
	If mHeight > mWidth Then 'container portrait
		MaxWidth = mWidth - 2 * HandleDot
		MaxHeight = xpnlAction.Height - 2 * HandleDot
		If xbmpImage.Width / xbmpImage.Height = 1 Then 'square image
			imvWidth = MaxWidth
			imvHeight = imvWidth / xbmpImage.Width * xbmpImage.Height
			imvTop = imvTop + (MaxHeight -imvHeight) / 2
			imvLeft = HandleDot
			rWidth = imvHeight
			rTop = imvTop
			rBottom = rTop + rWidth
			rLeft = imvLeft
			rRight = rLeft + rWidth
		Else if xbmpImage.Width / xbmpImage.Height > 1 Then	' image landscape
			imvWidth = MaxWidth
			imvHeight = imvWidth / xbmpImage.Width * xbmpImage.Height
			imvTop = imvTop + (MaxHeight -imvHeight) / 2
			imvLeft = HandleDot
			Select mWidthHeightRatio
				Case "None"
					rWidth = imvHeight
					rTop = imvTop
					rBottom = rTop + imvHeight
					rLeft = imvLeft
					rRight = rLeft + imvWidth
					mFullImage = True
				Case "Square"
					rWidth = imvHeight
					rTop = imvTop
					rBottom = rTop + rWidth
					rLeft = imvLeft
					rRight = rLeft + rWidth
				Case Else
					rLeft = imvLeft
					rTop = imvTop
					If UsedWHCustomRatio > xbmpImage.Width / xbmpImage.Height Then
						rWidth = imvWidth
						rBottom = rTop + imvWidth / UsedWHCustomRatio
						rRight = rLeft + rWidth
					Else
						rWidth = imvHeight * UsedWHCustomRatio
						rBottom = rTop + imvHeight
						rRight = rLeft + rWidth
					End If
			End Select
		Else if xbmpImage.Height / xbmpImage.Width >= MaxHeight / MaxWidth Then	' image portrait higher than the screen
			imvHeight = MaxHeight
			imvWidth = imvHeight / xbmpImage.Height * xbmpImage.Width
			imvLeft = (mWidth - imvWidth) / 2
			Select mWidthHeightRatio
				Case "None"'OK
					rWidth = imvWidth
					rTop = HandleDot
					rBottom = rTop + imvHeight
					rLeft = imvLeft
					rRight = rLeft + rWidth
					mFullImage = True
				Case "Square"
					rWidth = imvWidth
					rTop = HandleDot
					rBottom = rTop + rWidth
					rLeft = imvLeft
					rRight = rLeft + rWidth
				Case Else
					rLeft = imvLeft
					rTop = HandleDot
					If UsedWHCustomRatio > xbmpImage.Width / xbmpImage.Height Then
						rWidth = imvWidth
						rBottom = rTop + imvWidth / UsedWHCustomRatio
						rRight = rLeft + rWidth
					Else
						rWidth = imvHeight * UsedWHCustomRatio
						rBottom = rTop + imvHeight
						rRight = rLeft + rWidth
					End If
			End Select
		Else 	' image portrait smaller than the image view
			imvWidth = MaxWidth
			imvHeight = imvWidth / xbmpImage.Width * xbmpImage.Height
			imvTop = imvTop + (MaxHeight -imvHeight) / 2
			imvLeft = HandleDot
			Select mWidthHeightRatio
				Case "None"'OK
					rWidth = imvWidth
					rTop = imvTop
					rBottom = rTop + imvHeight
					rLeft = imvLeft
					rRight = rLeft + rWidth
					mFullImage = True
				Case "Square"
					rWidth = imvWidth
					rTop = imvTop
					rBottom = rTop + rWidth
					rLeft = imvLeft
					rRight = rLeft + rWidth
				Case Else
					rLeft = imvLeft
					rTop = imvTop
					If UsedWHCustomRatio > xbmpImage.Width / xbmpImage.Height Then
						rWidth = imvWidth
						rRight = rLeft + rWidth
						rBottom = rTop + imvWidth / UsedWHCustomRatio
					Else
						rWidth = imvHeight * UsedWHCustomRatio
						rRight = rLeft + rWidth
						rBottom = rTop + imvHeight
					End If
			End Select
		End If
	Else  'landscape image
		MaxHeight = mHeight - 2 * HandleDot
		MaxWidth = xpnlAction.Width - 2 * HandleDot
		If xbmpImage.Width / xbmpImage.Height = 1 Then ' square
			imvHeight = MaxHeight
			imvWidth = imvHeight / xbmpImage.Height * xbmpImage.Width
			imvLeft = (xpnlAction.Width - imvWidth) / 2
			rWidth = imvHeight
			rTop = HandleDot
			rBottom = rTop + rWidth
			rLeft = imvLeft
			rRight = rLeft + rWidth
		Else If xbmpImage.Height / xbmpImage.Width > 1 Then ' image portrait
			imvHeight = MaxHeight
			imvWidth = imvHeight / xbmpImage.Height * xbmpImage.Width
			imvLeft = (xpnlAction.Width - imvWidth) / 2
			Select mWidthHeightRatio
				Case "None"'OK
					rWidth = imvWidth
					rTop = imvTop
					rBottom = rTop + imvHeight
					rLeft = imvLeft
					rRight = rLeft + rWidth
					mFullImage = True
				Case "Square"
					rWidth = imvWidth
					rTop = imvTop
					rBottom = rTop + rWidth
					rLeft = imvLeft
					rRight = rLeft + rWidth
				Case Else
					rLeft = imvLeft
					rTop = imvTop
					If UsedWHCustomRatio > xbmpImage.Width / xbmpImage.Height Then
						rWidth = imvWidth
						rRight = rLeft + rWidth
						rBottom = rTop + imvWidth / UsedWHCustomRatio
					Else
						rWidth = imvHeight * UsedWHCustomRatio
						rRight = rLeft + rWidth
					rBottom = rTop + imvHeight					
				End If
			End Select
		Else If xbmpImage.Width / xbmpImage.Height > MaxWidth / MaxHeight Then ' image landscape wider than the screen
			imvWidth = MaxWidth
			imvHeight = imvWidth / xbmpImage.Width * xbmpImage.Height
			imvTop = imvTop + (MaxHeight -imvHeight) / 2
			imvLeft = HandleDot
			Select mWidthHeightRatio
				Case "None"'OK
					rLeft = imvLeft
					rWidth = imvHeight
					rTop = imvTop
					rBottom = rTop + rWidth
					rRight = rLeft + imvWidth
					mFullImage = True
				Case "Square"
					rLeft = imvLeft
					rWidth = imvHeight
					rTop = imvTop
					rBottom = rTop + rWidth
					rRight = rLeft + rWidth
				Case Else
					rLeft = imvLeft
					rTop = imvTop
					If UsedWHCustomRatio > xbmpImage.Width / xbmpImage.Height Then
						rWidth = imvWidth
						rBottom = rTop + rWidth / UsedWHCustomRatio
						rRight = rLeft + rWidth
					Else
						rWidth = imvHeight * UsedWHCustomRatio
						rBottom = rTop + imvHeight
						rRight = rLeft + rWidth
					End If
			End Select
		Else	' image landscape smaller than the image view
			imvHeight = MaxHeight
			imvWidth = imvHeight / xbmpImage.Height * xbmpImage.Width
			imvLeft = (xpnlAction.Width - imvWidth) / 2
			Select mWidthHeightRatio
				Case "None"
					rWidth = imvHeight
					rTop = imvTop
					rBottom = rTop + imvHeight
					rLeft = imvLeft
					rRight = rLeft + imvWidth
					mFullImage = True
				Case "Square"
					rWidth = imvHeight
					rTop = imvTop
					rBottom = rTop + rWidth
					rLeft = imvLeft
					rRight = rLeft + rWidth
				Case Else
					rLeft = imvLeft
					rTop = imvTop
					If UsedWHCustomRatio > xbmpImage.Width / xbmpImage.Height Then
						rWidth = imvWidth
						rBottom = rTop + rWidth / UsedWHCustomRatio
						rRight = rLeft + rWidth
					Else
						rWidth = imvHeight * UsedWHCustomRatio
						rBottom = rTop + imvHeight
						rRight = rLeft + rWidth
					End If			
			End Select
		End If
	End If
	
	ximvImage.SetLayoutAnimated(0, imvLeft, imvTop, imvWidth, imvHeight)
	
	ximvImage.SetBitmap(xbmpImage)
	#If B4A
		imvImage.Gravity = Gravity.FILL
	#End If

	rectImage.Initialize(rLeft, rTop, rRight, rBottom)	' square of croped bitmap
	xcvsAction.ClearRect(rectAction)
	xcvsAction.DrawRect(rectAction, xui.Color_ARGB(128, 0, 0, 0), True, 1) ' redraws the background
	xcvsAction.ClearRect(rectImage)	' draws the transparent croped rectangle
	
	DrawMarkers
	
	PixelScale = xbmpImage.Width / ximvImage.Width
	
	ExtractCroppedImage
End Sub

Private Sub DrawMarkers
	Private r As B4XRect
	
	If mWidthHeightRatio = "None" Then
		'left
		r.Initialize(rectImage.Left - HandleDot, (rectImage.Top + rectImage.Bottom) / 2 - HandleDot, rectImage.Left + HandleDot, (rectImage.Top + rectImage.Bottom) / 2 + HandleDot)
		xcvsAction.DrawRect(r, mHandleColor, True , 1)

		'top
		r.Initialize((rectImage.Left + rectImage.Right) / 2 - HandleDot, rectImage.Top - HandleDot, (rectImage.Left + rectImage.Right) / 2 + HandleDot, rectImage.Top + HandleDot)
		xcvsAction.DrawRect(r, mHandleColor, True , 1)

		'right
		r.Initialize(rectImage.Right - HandleDot, (rectImage.Top + rectImage.Bottom) / 2 - HandleDot, rectImage.Right + HandleDot, (rectImage.Top + rectImage.Bottom) / 2 + HandleDot)
		xcvsAction.DrawRect(r, mHandleColor, True , 1)

		'bottom
		r.Initialize((rectImage.Left + rectImage.Right) / 2 - HandleDot, rectImage.Bottom - HandleDot, (rectImage.Left + rectImage.Right) / 2 + HandleDot, rectImage.Bottom + HandleDot)
		xcvsAction.DrawRect(r, mHandleColor, True , 1)
	End If
	
	'top left
	r.Initialize(rectImage.Left - HandleDot, rectImage.Top - HandleDot, rectImage.Left + HandleDot, rectImage.Top + HandleDot)
	xcvsAction.DrawRect(r, mHandleColor, True , 1)
	
	'top right
	r.Initialize(rectImage.Right - HandleDot, rectImage.Top - HandleDot, rectImage.Right + HandleDot, rectImage.Top + HandleDot)
	xcvsAction.DrawRect(r, mHandleColor, True , 1)
	
	'bottom left
	r.Initialize(rectImage.Left - HandleDot, rectImage.Bottom - HandleDot, rectImage.Left + HandleDot, rectImage.Bottom + HandleDot)
	xcvsAction.DrawRect(r, mHandleColor, True , 1)
	
	'bottom right
	r.Initialize(rectImage.Right - HandleDot, rectImage.Bottom - HandleDot, rectImage.Right + HandleDot, rectImage.Bottom + HandleDot)
	xcvsAction.DrawRect(r, mHandleColor, True , 1)

	xcvsAction.Invalidate
End Sub

Private Sub ExtractCroppedImage
	Private rectDest As B4XRect
	
	
	If mFullImage = True Then
		cLeft = 0
		cTop = 0
		cWidth = xbmpImage.Width
		cHeight = xbmpImage.Height
	Else
	cLeft = Floor((rectImage.Left - ximvImage.Left) * PixelScale)
	cTop = Floor((rectImage.Top - ximvImage.Top) * PixelScale)
	cWidth = Ceil(rectImage.Width * PixelScale)
	cHeight = Ceil(rectImage.Height * PixelScale)
	End If
	
	If Abs(xbmpImage.Width - cWidth) < 5 Then 
		cWidth = xbmpImage.Width
	End If
	If Abs(xbmpImage.Height - cHeight) < 5 Then
		cHeight = xbmpImage.Height
	End If
	
	xbmpCropped = xbmpImage.Crop(cLeft, cTop, cWidth, cHeight)
	If mWidthHeightRatio = "Circle" Then
		DrawRoundCorners(0.5)
	Else
		If mRoundCorners = True Then
			DrawRoundCorners(mCornerRadius / 100)
		End If
	End If
	
	If xpnlCropped.IsInitialized Then
		If rectImage.Width / rectImage.Height > imvCroppedWidth / imvCroppedHeight Then
			xpnlCropped.Width = imvCroppedWidth
			xpnlCropped.Height = imvCroppedWidth / rectImage.Width * rectImage.Height
		Else
			xpnlCropped.Height = imvCroppedHeight
			xpnlCropped.Width = imvCroppedHeight / rectImage.Height * rectImage.Width
		End If
		xcvsCropped.Resize(xpnlCropped.Width, xpnlCropped.Height)
		
		rectDest.Initialize(0, 0, xpnlCropped.Width, xpnlCropped.Height)
		
		xcvsCropped.ClearRect(rectCroppedView)
		xcvsCropped.DrawBitmap(xbmpCropped, rectDest)
		xcvsCropped.Invalidate
	End If
End Sub

Private Sub DrawRoundCorners(Radius As Float)
	Private BC As BitmapCreator
	Private r, a As Double
	Private d, h, x As Int
	
	BC.Initialize(cWidth, cHeight)
	BC.DrawBitmap(xbmpCropped, BC.TargetRect, True)
	r = Radius * Min(cWidth, cHeight)
	For d = 0 To r - 1
		a = ACos((R - d) / r)
		h = R * (1 - Sin(a))
		For x = 0 To h
			BC.SetColor(x, d, xui.Color_Transparent)
			BC.SetColor(cWidth - x, d, xui.Color_Transparent)
			BC.SetColor(x, cHeight - d - 1, xui.Color_Transparent)
			BC.SetColor(cWidth - x - 1, cHeight - d - 1, xui.Color_Transparent)
		Next
	Next
	xbmpCropped = BC.Bitmap
End Sub

'loads the given image file to the xResizeAndCrop Customview
'the same as LoadBitmap
Public Sub LoadImage(Dir As String, FileName As String)
	xbmpImage = xui.LoadBitmap(Dir, FileName)
	DrawImage
End Sub

'loads the given image file to the xResizeAndCrop Customview resized
'the same as LoadBitmapResize
Public Sub LoadImageResize(Dir As String, FileName As String, Width As Int, Height As Int, KeepAspectRatio As Boolean)
	If File.Exists(Dir, FileName) Then
		xbmpImage = xui.LoadBitmapResize(Dir, FileName, Width, Height, KeepAspectRatio)
		DrawImage
	End If
End Sub

Private Sub xpnlAction_Touch (Action As Int, x As Float, y As Float)
	Private x1, y1 As Int
	Private mMinCroppedWidth1, mMinCroppedHeight1 As Double

	mMinCroppedWidth1 = mMinCroppedWidth / PixelScale
	mMinCroppedHeight1 = mMinCroppedHeight / PixelScale
	
	Select Action
		Case xpnlAction.TOUCH_ACTION_DOWN
			fLeft = False
			fTop = False
			fRight = False
			fBottom = False
			fTopLeft = False
			fTopRight = False
			fBottomLeft = False
			fBottomRight = False
			fCenter = False

			If x >= rLeft - DeltaDot And x <= rLeft + DeltaDot Then
				If y >= rTop - DeltaDot And y <= rTop + DeltaDot Then
					fTopLeft = True
				Else If y >= (rTop + rBottom) / 2 - DeltaDot And y <= (rTop + rBottom) / 2 + DeltaDot Then
					fLeft = True
				Else If y >= rBottom - DeltaDot And y <= rBottom + DeltaDot Then
					fBottomLeft = True
				End If
			Else If x >= rRight - DeltaDot And x <= rRight + DeltaDot Then
				If y >= rTop - DeltaDot And y <= rTop + DeltaDot Then
					fTopRight = True
				Else If y >= (rTop + rBottom) / 2 - DeltaDot And y <= (rTop + rBottom) / 2 + DeltaDot Then
					fRight = True
				Else If y >= rBottom - DeltaDot And y <= rBottom + DeltaDot Then
					fBottomRight = True
				End If
			Else If x >= (rLeft + rRight) / 2 - DeltaDot And x <= (rLeft + rRight) / 2 + DeltaDot And y >= rTop - DeltaDot And y <= rTop + DeltaDot Then
				fTop = True
			Else If x >= (rLeft + rRight) / 2  - DeltaDot And x <= (rLeft + rRight) / 2  + DeltaDot And y >= rBottom - DeltaDot And y <= rBottom + DeltaDot Then
				fBottom = True
			Else If x >= rLeft + DeltaDot And x < rRight - DeltaDot And y >= rTop + DeltaDot And y < rBottom - DeltaDot Then
				fCenter = True
			End If
			StartX = x
			StartY = y
		Case xpnlAction.TOUCH_ACTION_MOVE
			mFullImage = False
			Dim Diff, Sign As Int
			DeltaX = x - StartX
			DeltaY = y - StartY
			xcvsAction.ClearRect(rectAction)
			xcvsAction.DrawRect(rectAction, xui.Color_ARGB(128, 0, 0, 0), True , 1)
			If fCenter = True Then
				rectImage.Left = rLeft + DeltaX
				rectImage.Right = rRight + DeltaX
				rectImage.Top = rTop + DeltaY
				rectImage.Bottom = rBottom + DeltaY
				If rectImage.Left < ximvImage.Left Then
					Diff = ximvImage.Left - rectImage.Left
					rectImage.Left = ximvImage.Left
					rectImage.Right = rectImage.Right + Diff
				End If
				If rectImage.Top < ximvImage.Top Then
					Diff = ximvImage.Top - rectImage.Top
					rectImage.Top = ximvImage.Top
					rectImage.Bottom  = rectImage.Bottom + Diff
				End If
				If rectImage.Right >  ximvImage.Left + ximvImage.Width Then
					Diff = rectImage.Right - (ximvImage.Left + ximvImage.Width)
					rectImage.Right = ximvImage.Left + ximvImage.Width
					rectImage.Left  = rectImage.Left - Diff
				End If
				If rectImage.Bottom > ximvImage.Top + ximvImage.Height Then
					Diff = rectImage.Bottom - (ximvImage.Top + ximvImage.Height)
					rectImage.Bottom = ximvImage.Top + ximvImage.Height
					rectImage.Top  = rectImage.Top - Diff
				End If
			Else
				If mWidthHeightRatio = "None" Then
					If fLeft = True Or fTopLeft = True Or fBottomLeft = True Then
						If rLeft + DeltaX > ximvImage.Left Then
							x1 = rLeft + DeltaX
							If rectImage.Right - x1 >= mMinCroppedWidth1 Then
								rectImage.Left = x1
							Else
								rectImage.Left = rectImage.Right - mMinCroppedWidth1
							End If
						End If
					End If
				
					If fTop = True Or fTopLeft = True Or fTopRight = True Then
						If rTop + DeltaY > ximvImage.Top Then
							y1 = rTop + DeltaY
							If rectImage.Bottom - y1 >= mMinCroppedHeight1 Then
								rectImage.Top = y1
							Else
								rectImage.Top = rectImage.Bottom - mMinCroppedHeight1
							End If
						End If
					End If
				
					If fRight = True Or fTopRight = True Or fBottomRight = True Then
						If rRight + DeltaX < ximvImage.Left + ximvImage.Width Then
							x1 = rRight + DeltaX
							If x1 - rectImage.Left >= mMinCroppedWidth1 Then
								rectImage.Right = x1
							Else
								rectImage.Right = rectImage.Left + mMinCroppedWidth1
							End If
						End If
					End If
				
					If fBottom = True Or fBottomLeft = True Or fBottomRight = True Then
						If rBottom + DeltaY < ximvImage.Top + ximvImage.Height Then
							y1 = rBottom + DeltaY
							If y1 - rectImage.Top > mMinCroppedHeight1 Then
								rectImage.Bottom = y1
							Else
								rectImage.Bottom = rectImage.Top + mMinCroppedHeight1
							End If
						End If
					End If
				Else If mWidthHeightRatio = "Square" Or mWidthHeightRatio = "Circle" Then
					If Abs(DeltaX) >= Abs(DeltaY) Then
						Delta = DeltaX
					Else
						Delta = DeltaY
					End If
'					Log(Delta & " / " & DeltaX & " / " & DeltaY)
'					Delta = Max(Abs(DeltaX), Abs(DeltaY))
					If fTopLeft = True Then
						If rLeft + Delta > imvImage.Left And rTop + Delta > ximvImage.Top Then
							x1 = rLeft + Delta
							y1 = rTop + Delta
							If rectImage.Right - x1 >= mMinCroppedWidth1 And rectImage.Bottom - y1 >= mMinCroppedHeight1 Then
								rectImage.Left = x1
								rectImage.Top = y1
							Else
								rectImage.Left = rectImage.Right - mMinCroppedWidth1
								rectImage.Top = rectImage.Bottom - mMinCroppedHeight1
							End If
						End If
					End If
					
					If fTopRight = True And DeltaX <> 0 Then
						Sign = DeltaY / Abs(DeltaY)
						If Abs(DeltaX) >= Abs(DeltaY) Then
							Delta = Abs(DeltaX) * Sign
						Else
							Delta = DeltaY
						End If
						If rTop + Delta > imvImage.Top And rRight - Delta < imvImage.Left + imvImage.Width Then
							x1 = rRight - Delta
							y1 = rTop + Delta
							If rectImage.Bottom - y1 >= mMinCroppedHeight1 And rectImage.Bottom - y1 >= mMinCroppedHeight1 Then
								rectImage.Top = y1
								rectImage.Right = x1
							Else
								rectImage.Top = rectImage.Bottom - mMinCroppedHeight1
								rectImage.Right = rectImage.Left + mMinCroppedWidth1
							End If
						End If
					End If

					If fBottomLeft = True Then
						Sign = DeltaY / Abs(DeltaY)
						If Abs(DeltaX) >= Abs(DeltaY) Then
							Delta = Abs(DeltaX) * Sign
						Else
							Delta = DeltaY
						End If
						If rBottom + Delta < imvImage.Top + imvImage.Height And rLeft - Delta > imvImage.Left Then
							y1 = rBottom + Delta
							x1 = rLeft - Delta
							If y1 - rectImage.Top > mMinCroppedHeight1 And rectImage.Right - x1 >= mMinCroppedWidth1 Then
								rectImage.Bottom = y1
								rectImage.Left = x1
							Else
								rectImage.Bottom = rectImage.Top + mMinCroppedHeight1
								rectImage.Left = rectImage.Right - mMinCroppedWidth1
							End If
						End If
					End If
					
					If fBottomRight = True Then
						If rBottom + Delta < imvImage.Top + imvImage.Height And rRight + Delta < imvImage.Left + imvImage.Width Then
							y1 = rBottom + Delta
							x1 = rRight + Delta
							If y1 - rectImage.Top > mMinCroppedHeight1 And x1 - rectImage.Left >= mMinCroppedWidth1 Then
								rectImage.Bottom = y1
								rectImage.Right = x1
							Else
								rectImage.Bottom = rectImage.Top + mMinCroppedHeight1
								rectImage.Right = rectImage.Left + mMinCroppedWidth1
							End If
						End If
					End If
				Else	'mWidthHeightRatio = "Custom"
					DeltaY = DeltaX / UsedWHCustomRatio
					If fTopRight = True Then
						If rRight + DeltaX < imvImage.Left + imvImage.Width And rTop - DeltaY > imvImage.Top Then
							x1 = rRight + DeltaX
							y1 = rTop - DeltaY
							If rectImage.Bottom - y1 >= mMinCroppedHeight1 And rectImage.Bottom - y1 >= mMinCroppedHeight1 Then
								rectImage.Top = y1
								rectImage.Right = x1
							Else
								rectImage.Bottom = rectImage.Top + mMinCroppedHeight1
								rectImage.Right = rectImage.Left + mMinCroppedWidth1
							End If
						End If
					Else If fBottomRight = True Then
						If rRight + DeltaX < imvImage.Left + imvImage.Width And rBottom + DeltaY < imvImage.Top + imvImage.Height Then
							x1 = rRight + DeltaX
							y1 = rBottom + DeltaY
							If y1 - rectImage.Top > mMinCroppedHeight1 And x1 - rectImage.Left >= mMinCroppedWidth1 Then
								rectImage.Bottom = y1
								rectImage.Right = x1
							Else
								rectImage.Bottom = rectImage.Top + mMinCroppedHeight1
								rectImage.Right = rectImage.Left + mMinCroppedWidth1
							End If
						End If
					Else If fTopLeft = True Then
						If rLeft + DeltaX > imvImage.Left And rTop + DeltaY > imvImage.Top Then
							x1 = rLeft + DeltaX
							y1 = rTop + DeltaY
							If rectImage.Right - x1 >= mMinCroppedWidth1 And rectImage.Bottom - y1 >= mMinCroppedHeight1 Then
								rectImage.Top = y1
								rectImage.Left = x1
							Else
								rectImage.Left = rectImage.Right - mMinCroppedWidth1
								rectImage.Top = rectImage.Bottom - mMinCroppedHeight1
							End If
						End If
					Else If fBottomLeft = True Then
						If rLeft + DeltaX > imvImage.Left And rBottom - DeltaY < imvImage.Top + imvImage.Height Then
							x1 = rLeft + DeltaX
							y1 = rBottom - DeltaY
							If y1 - rectImage.Top >= mMinCroppedHeight1 And rectImage.Right - x1 >= mMinCroppedWidth1 Then
								rectImage.Bottom = y1
								rectImage.Left = x1
							Else
								rectImage.Bottom = rectImage.Top + mMinCroppedHeight1
								rectImage.Left = rectImage.Right - mMinCroppedWidth1
							End If
						End If
					End If
				End If
			End If
		
			xcvsAction.ClearRect(rectImage)
			xcvsAction.Invalidate
			DrawMarkers
			ExtractCroppedImage
		Case xpnlAction.TOUCH_ACTION_UP
			rLeft = rectImage.Left
			rTop = rectImage.Top
			rRight = rectImage.Right
			rBottom = rectImage.Bottom
			If xui.SubExists(mCallBack, mEventName & "_CropFinished", 0) Then
				CallSubDelayed(mCallBack, mEventName & "_CropFinished")
			End If
	End Select
End Sub

'sets the Panel / Pane view for the cropped image, write only
'the Panel / Pane view must be added in the main code and transmitted to the custom view as this property.
Public Sub setCroppedView(CroppedView As B4XView)
	xpnlCropped = CroppedView
	xcvsCropped.Initialize(xpnlCropped)
	imvCroppedWidth = xpnlCropped.Width
	imvCroppedHeight = xpnlCropped.Height
	rectCroppedView.Initialize(0, 0, imvCroppedWidth, imvCroppedHeight)
	
	If xbmpImage.IsInitialized Then
		ExtractCroppedImage
	End If
End Sub

Public Sub getImage As B4XBitmap
	Return xbmpImage
End Sub

'sets the image (B4XBitmap) to the Customview, write only
Public Sub setImage(Image As B4XBitmap)
	xbmpImage = Image
	DrawImage
End Sub

'gets the cropped image as a B4XBitmap, read only
Public Sub getCroppedImage As B4XBitmap
	Return xbmpCropped
End Sub

'sets or gets the Left property
Public Sub getLeft As Int
	Return mLeft
End Sub

Public Sub setLeft(Left As Int)
	mLeft = Left
	mBase.Left = mLeft
End Sub

'sets or gets the Top property
Public Sub getTop As Int
	Return mTop
End Sub

Public Sub setTop(Top As Int)
	mTop = Top
	mBase.Top = mTop
End Sub

'sets or gets the Width property
Public Sub getWidth As Int
	Return mWidth
End Sub

Public Sub setWidth(Width As Int)
	mWidth = Width
	Base_Resize (mWidth, mHeight)
End Sub

'sets or gets the Height property
Public Sub getHeight As Int
	Return mHeight
End Sub

Public Sub setHeight(Height As Int)
	mHeight = Height
	Base_Resize (mWidth, mHeight)
End Sub

'sets or gets the Visible property
Public Sub getVisible As Boolean
	Return mBase.Visible
End Sub

Public Sub setVisible(Visible As Boolean)
	mBase.Visible = Visible
End Sub

'sets or gets the MinWidth property
'value in pixels, no dip value
'if WHRatio <> "None", the min cropped height is set acording to the width / height ratio
Public Sub getMinCroppedWidth As Int
	Return mMinCroppedWidth
End Sub

Public Sub setMinCroppedWidth(MinCroppedWidth As Int)
	mMinCroppedWidth = MinCroppedWidth
	If mWidthHeightRatio <> "None" Then
		mMinCroppedHeight = mMinCroppedWidth / UsedWHCustomRatio
	End If
End Sub

'sets or gets the MinHeight property
'value in pixels, no dip value
'valid only if WidthHeightRatio is different from "None"
'if WidthHeightRatio = "None" the min cropped height is set acording to the width / height ratio
Public Sub getMinCroppedHeight As Int
	Return mMinCroppedHeight
End Sub

Public Sub setMinCroppedHeight(MinCroppedHeight As Int)
	If mWidthHeightRatio = "None" Then
		mMinCroppedHeight = MinCroppedHeight
	End If
End Sub

'sets or gets the HandleColor property
'value must a xui color
'Example code: <code>xResizeAndCrop1.HandleColor = xui.Color_RGB(255, 215, 0)</code>
Public Sub getHandleColor As Int
	Return mHandleColor
End Sub

Public Sub setHandleColor(HandleColor As Int)
	mHandleColor = HandleColor
	DrawImage
End Sub

'sets or gets the WidthHeightRatio property
'possible values: None  Square  1.5  4/3  16/9  Custom
'None = any width and height
'Square means that the resized image is always square
'Circle means that the resized image is always circle
'3/2 = ratio 1.5
'2/3 = ratio 0.66667
'4/3 = ratio 4/3
'3/4 = ration 3/4
'16/9 = ratio 16/9
'9/16 = ratio 9/16
'Custom = user defined ratio set in the WidthHeightRatioValue property
Public Sub getWidthHeightRatio As String
	Return mWidthHeightRatio
End Sub

Public Sub setWidthHeightRatio(WidthHeightRatio As String)
	Select WidthHeightRatio
		Case "None", "Square", "Circle", "3/2", "2/3", "4/3", "3/4", "16/9", "9/16", "Custom"
			mWidthHeightRatio = WidthHeightRatio
			UpdateWidthHeightRatio
			DrawImage
		Case Else
			Log("Wrong etry: " & WidthHeightRatio)
	End Select
End Sub

'sets or gets the WidthHeightRatioValue property
'only active if the WidthHeightRatio property is set to "None"
Public Sub getWidthHeightRatioValue As Double
	Return mWidthHeightRatioValue
End Sub

Public Sub setWidthHeightRatioValue(WidthHeightRatioValue As Double)
	mWidthHeightRatioValue = WidthHeightRatioValue
	UsedWHCustomRatio = mWidthHeightRatioValue
	If xbmpImage.IsInitialized Then
		DrawImage
	End If
End Sub

'sets or gets the RoundCorners property
'rounds the corners with a radius equal to the CornerRadius property
Public Sub getRoundCorners As Boolean
	Return mRoundCorners
End Sub

Public Sub setRoundCorners(RoundCorners As Boolean)
	mRoundCorners = RoundCorners
	If xbmpImage.IsInitialized Then
		DrawImage
	End If
End Sub

'sets or gets the CornerRadius property
'the radius is expressed in % of the smalles side, max value = 50, min value = 0
Public Sub getCornerRadius As Int
	Return mCornerRadius
End Sub

Public Sub setCornerRadius(CornerRadius As Int)
	mCornerRadius = Max(Min(CornerRadius, 50), 0)
	If xbmpImage.IsInitialized Then
		DrawImage
	End If
End Sub

'sets or gets the HandleDotWidth property
'it must be a dip value, default value 13dip
Public Sub getHandleDotWidth As Int
	Return HandleDot * 2 + 1
End Sub

Public Sub setHandleDotWidth(HandleDotWidth As Int)
	HandleDot = HandleDotWidth / 2
	If xbmpImage.IsInitialized Then
		DrawImage
	End If
End Sub

Private Sub UpdateWidthHeightRatio
	Select mWidthHeightRatio
		Case "Square", "Circle"
			UsedWHCustomRatio = 1
		Case "3/2"
			UsedWHCustomRatio = 3 / 2
		Case "2/3"
			UsedWHCustomRatio = 2 / 3
		Case "4/3"
			UsedWHCustomRatio = 4 / 3
		Case "3/4"
			UsedWHCustomRatio = 3 / 4
		Case "16/9"
			UsedWHCustomRatio = 16 / 9
		Case "9/16"
			UsedWHCustomRatio = 9 / 16
		Case "Custom"
			UsedWHCustomRatio = mWidthHeightRatioValue
	End Select
	If mWidthHeightRatio <> "None" Then
		mMinCroppedHeight = mMinCroppedWidth / UsedWHCustomRatio
	End If
End Sub

'rotates the original image
'only multiples of 90 are allowed 
Public Sub RotateImage(Degrees As Int)
	Private rest As Double
	rest = Degrees Mod 90
	If rest = 0 Then
		xbmpImage = xbmpImage.Rotate(Degrees)
		DrawImage
	Else
		Log("Wrong Degrees value")
	End If
End Sub

