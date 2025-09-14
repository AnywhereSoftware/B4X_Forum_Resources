B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#DesignerProperty: Key: Color1, DisplayName: Color 1, FieldType: Color, DefaultValue: 0xFF006AFF
#DesignerProperty: Key: Direction, DisplayName: Direction, FieldType: String, DefaultValue: LtoR, List: LtoR|RtoL|TtoB|BtoT
#DesignerProperty: Key: ThumbColor, DisplayName: Thumb Color, FieldType: Color, DefaultValue: 0x58006AFF
#DesignerProperty: Key: Interval, DisplayName: Interval, FieldType: Int, DefaultValue: 1
#DesignerProperty: Key: ImageFile, DisplayName: Image File, FieldType: String, DefaultValue: 
#DesignerProperty: Key: Min, DisplayName: Minimum, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: Max, DisplayName: Maximum, FieldType: Int, DefaultValue: 100
#DesignerProperty: Key: SeekBarAnimationSpeed, DisplayName: Speed, FieldType: Int, DefaultValue: 400
#DesignerProperty: Key: Locked, DisplayName: Seek bar locked, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: SeekBarVisible, DisplayName: Seek bar visible, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: Value, DisplayName: Value, FieldType: Int, DefaultValue: 50
#DesignerProperty: Key: WidthAdjust, DisplayName: Width adjust, FieldType: Int, DefaultValue: 0
#Event: ValueChanged (Value As Int)
#Event: TouchStateChanged (Pressed As Boolean)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public Color1, ThumbColor As Int
	Public Tag As Object
	Private TxtLabel As Label
	Private mValue As Int
	Public MinValue, MaxValue As Int
	Public Interval As Int = 1
	Public Size1 = 4dip, Size2 = 2dip, Radius1 = 6dip, Radius2 = 10dip As Int
	Private Pressed As Boolean
	Private ClrMap As Map
	Private imageFile As String
	Private WidthAdjust As Int
	Public SeekbarVisible As Boolean
	Private SeekBarAnimationSpeed As Int
	Private Vertical As Boolean
	Private Timer1 As Timer
	Private Direction As String
	
	Private pnlSlider As B4XView
	Private cvsSlider As B4XCanvas
	Private imgIcon As B4XView
	Private overlay As B4XView
	
	Private size As Int
	
	Private iv As ImageView ' Create an ImageView first
	
	Private mLocked As Boolean 
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ClrMap.Initialize
	pnlSlider = xui.CreatePanel ("pnlSlider")
	TxtLabel.Initialize ("TxtLabel")
	iv.Initialize ("imgIcon")
	overlay = xui.CreatePanel ("Overlay")
	overlay.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0) ' Transparent panel
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	Color1 = xui.PaintOrColorToColor(Props.Get("Color1"))
	ThumbColor = xui.PaintOrColorToColor(Props.Get("ThumbColor"))
	Interval = Max(1, Props.GetDefault("Interval", 1))
	MinValue = Props.Get("Min")
	MaxValue = Props.Get("Max")
	mValue = Max(MinValue, Min(MaxValue, Props.Get("Value")))
	WidthAdjust = Props.Get ("WidthAdjust")
	SeekbarVisible = Props.Get ("SeekBarVisible")
	SeekBarAnimationSpeed = Props.Get ("SeekBarAnimationSpeed")
	Timer1.Initialize ("Timer1", SeekBarAnimationSpeed)
	Direction = Props.Get ("Direction")
	mLocked = Props.Get ("Locked")


	imageFile = Props.Get ("ImageFile")
	imgIcon = iv ' Cast to B4XView
	
	Select Direction
		Case "LtoR", "RtoL"
			imgIcon.SetLayoutAnimated (0, 0, 0, mBase.Height, mBase.Height)
			overlay.SetLayoutAnimated (0, 0, 0, mBase.Height, mBase.Height)
			Vertical = False
			
		Case Else
			imgIcon.SetLayoutAnimated (0, 0, 0, mBase.Width, mBase.Width)
			overlay.SetLayoutAnimated (0, 0, 0, mBase.Width, mBase.Width)
			Vertical = True
	End Select
	
	Select Direction
		Case "LtoR"
			mBase.AddView (imgIcon, 0 , 0 , imgIcon.Width, imgIcon.Height)
			mBase.AddView (overlay, 0 , 0 , imgIcon.Width, imgIcon.Height)
			pnlSlider.SetLayoutAnimated(0, mBase.Height, 0, mBase.Width - mBase.Height, mBase.Height)
			mBase.AddView (pnlSlider, imgIcon.Width, 0 , mBase.Width - imgIcon.Width, imgIcon.Height)
			
		Case "RtoL"
			mBase.AddView (imgIcon, mBase.Width - imgIcon.Width , 0 , imgIcon.Width, imgIcon.Height)
			mBase.AddView (overlay, mBase.Width - imgIcon.Width , 0 , imgIcon.Width, imgIcon.Height)
			pnlSlider.SetLayoutAnimated(0, 0, 0, mBase.Width - mBase.Height, mBase.Height)
			mBase.AddView (pnlSlider, 0, 0 , mBase.Width - imgIcon.Width, mBase.Height)

		Case "TtoB"
			mBase.AddView (imgIcon, 0 , 0 , imgIcon.Width, imgIcon.Height)
			mBase.AddView (overlay, 0 , 0 , imgIcon.Width, imgIcon.Height)
			pnlSlider.SetLayoutAnimated(0, 0, mBase.Width, mBase.Width, mBase.Height - mBase.Width)
			mBase.AddView (pnlSlider, 0, imgIcon.Height , imgIcon.Width, mBase.Height - mBase.Width)
			
		Case "BtoT"
			mBase.AddView (imgIcon, 0 , mBase.Height - imgIcon.Height , imgIcon.Width, imgIcon.Height)
			mBase.AddView (overlay, 0 , mBase.Height - imgIcon.Height , imgIcon.Width, imgIcon.Height)
			pnlSlider.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height - mBase.Width)
			mBase.AddView (pnlSlider, 0, 0 , imgIcon.Width, mBase.Height - mBase.Width)
	End Select
	
	If pnlSlider.Width > 0 Then 
		cvsSlider.Initialize (pnlSlider)
	End If
	
	If imageFile.Length > 0 Then
		LoadImage
	End If

	If xui.IsB4A Or xui.IsB4i Then Radius2 = 20dip
	If xui.IsB4A Then Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub LoadImage
	Dim bmp As B4XBitmap
	bmp = xui.LoadBitmapResize(File.DirAssets, imageFile, imgIcon.height, imgIcon.Width, False)
	imgIcon.SetBitmap(bmp)
End Sub

' Return the base view
Public Sub getBase As B4XView
	Return mBase
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	If pnlSlider.IsInitialized Then 
		Select Direction
			Case "LtoR"
				pnlSlider.SetLayoutAnimated(0, mBase.Height, 0, mBase.Width - mBase.Height, mBase.Height)
				cvsSlider.resize (mBase.Width - mBase.Height, mBase.Height)
			Case "RtoL"
				pnlSlider.SetLayoutAnimated(0, 0, 0, mBase.Width - mBase.Height, mBase.Height)
				cvsSlider.resize (mBase.Width - mBase.Height, mBase.Height)
			Case "TtoB"
				pnlSlider.SetLayoutAnimated(0, 0, mBase.Width, mBase.Width, mBase.Height - mBase.Width)
				Vertical = True
				cvsSlider.resize (mBase.Width, mBase.Height - mBase.Width)
			Case "BtoT"
				pnlSlider.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height - mBase.Width)
				Vertical = True
				cvsSlider.resize (mBase.Width, mBase.Height - mBase.Width)
		End Select

		size = Max(pnlSlider.Height, pnlSlider.Width) - 2 * Radius2
		If SeekbarVisible Then Update
	End If
End Sub

'Redraws the control
Public Sub Update

	cvsSlider.ClearRect(cvsSlider.TargetRect)
	
	If size > 0 Then
		If Vertical = False Then    ' HORIZONTAL
			Dim s1 As Int = Radius2 + (mValue - MinValue) / (MaxValue - MinValue) * size
			Dim y As Int = pnlSlider.Height / 2
			
			DrawGradientLine(cvsSlider, Size2 + WidthAdjust)
			cvsSlider.DrawLine(Radius2 , y, s1, y, Color1, Size1 + WidthAdjust)
			cvsSlider.DrawCircle(s1, y, Radius1 + WidthAdjust, Color1, True, 0)
			
			If Pressed Then
				cvsSlider.DrawCircle(s1, y, Radius2, ThumbColor, True, 0)
			End If
		Else    ' VERTICAL
			Dim s1 As Int = Radius2 + (MaxValue - mValue) / (MaxValue - MinValue) * size
			Dim x As Int = pnlSlider.Width / 2
			DrawGradientLine(cvsSlider, Size2 + WidthAdjust)
			cvsSlider.DrawLine(x, s1 + Radius1, x, pnlSlider.Height - Radius2, Color1, Size1 + WidthAdjust)
			cvsSlider.DrawCircle(x, s1, Radius1, Color1, True, 0)
			If Pressed Then
				cvsSlider.DrawCircle(x, s1, Radius2 , ThumbColor, True, 0)
			End If
		End If

		cvsSlider.Invalidate
	End If
End Sub

Private Sub pnlSlider_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnlSlider.TOUCH_ACTION_DOWN Then
		Pressed = True
		RaiseTouchStateEvent
		SetValueBasedOnTouch(X, Y)
	Else If Action = pnlSlider.TOUCH_ACTION_MOVE Then
		SetValueBasedOnTouch(X, Y)
	Else If Action = pnlSlider.TOUCH_ACTION_UP Then
		Pressed = False
		RaiseTouchStateEvent
	End If
	Update
End Sub

Private Sub RaiseTouchStateEvent
	If xui.SubExists(mCallBack, mEventName & "_TouchStateChanged", 1) Then
		CallSubDelayed2(mCallBack, mEventName & "_TouchStateChanged", Pressed)
	End If
End Sub

Private Sub SetValueBasedOnTouch(x As Int, y As Int)
	Dim v As Int
	If Vertical Then
		v = (pnlSlider.Height - Radius2 - y) / size * (MaxValue - MinValue) + MinValue
	Else
		v = (x - Radius2) / size * (MaxValue - MinValue) + MinValue
	End If
	v = Round (v / Interval) * Interval
	Dim NewValue As Int = Max(MinValue, Min(MaxValue, v))
	If NewValue <> mValue Then
		mValue = NewValue
		If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) Then
			CallSubDelayed2(mCallBack, mEventName & "_ValueChanged", mValue)
		End If
	End If
End Sub

Public Sub setValue(v As Int)
	mValue = Max(MinValue, Min(MaxValue, v))
	Update
End Sub

Public Sub getValue As Int
	Return mValue
End Sub

Sub DrawGradientLine(Canvas As B4XCanvas, Width As Int)

	' Set some defaults in case the user hasn't bothered
	If ClrMap.Size = 0 Then
		ClrMap.Put(0, xui.Color_Red)
		ClrMap.Put(50, xui.Color_Green)
		ClrMap.Put(100, xui.Color_Blue)
	End If

	Dim CanvasWidth As Float = Canvas.TargetRect.Width
	Dim CanvasHeight As Float = Canvas.TargetRect.Height

	Dim adjustment As Float = Radius2

	Dim x1, y1, x2, y2 As Float

	' Check if the canvas is wider than it is tall
	If CanvasWidth >= CanvasHeight Then
		x1 = adjustment ' Start after Radius2 from the left
		y1 = CanvasHeight / 2
		x2 = CanvasWidth - adjustment ' End before Radius2 from the right
		y2 = y1
	Else
		x1 = CanvasWidth / 2
		y1 = adjustment ' Start after Radius2 from the top
		x2 = x1
		y2 = CanvasHeight - adjustment ' End before Radius2 from the bottom
	End If

	' Recalculate the TotalSteps to be relative to the new adjusted length
	Dim TotalSteps As Int = 100
	Dim DeltaX As Float = (x2 - x1) / TotalSteps
	Dim DeltaY As Float = (y2 - y1) / TotalSteps

	' Convert the map keys to a list and sort them
	Dim Ratios As List
	Ratios.Initialize
	For Each key As Object In ClrMap.Keys
		Ratios.Add(key)
	Next
	Ratios.Sort(True)

	' Loop through each segment defined by the ratios
	For j = 0 To Ratios.Size - 2
		Dim StartRatio As Int = Ratios.Get(j)
		Dim EndRatio As Int = Ratios.Get(j + 1)
		Dim StartColor As Int = ClrMap.Get(StartRatio)
		Dim EndColor As Int = ClrMap.Get(EndRatio)
        
		Dim SegmentSteps As Int = EndRatio - StartRatio
        
		For i = 0 To SegmentSteps - 1
			Dim ratio As Float = i / SegmentSteps

			Dim r As Int = (1 - ratio) * Bit.UnsignedShiftRight(Bit.And(StartColor, 0xFF0000), 16) + ratio * Bit.UnsignedShiftRight(Bit.And(EndColor, 0xFF0000), 16)
			Dim g As Int = (1 - ratio) * Bit.UnsignedShiftRight(Bit.And(StartColor, 0x00FF00), 8) + ratio * Bit.UnsignedShiftRight(Bit.And(EndColor, 0x00FF00), 8)
			Dim b As Int = (1 - ratio) * Bit.And(StartColor, 0x0000FF) + ratio * Bit.And(EndColor, 0x0000FF)
            
			Dim CurrentColor As Int = xui.Color_ARGB(255, r, g, b)
            
			' Calculate the exact x and y positions, now starting at Radius2 and ending before Radius2
			Dim x As Float = x1 + ((StartRatio + i) * DeltaX)
			Dim y As Float = y1 + ((StartRatio + i) * DeltaY)
			Dim NextX As Float = x1 + ((StartRatio + (i + 1)) * DeltaX)
			Dim NextY As Float = y1 + ((StartRatio + (i + 1)) * DeltaY)
            
			Canvas.DrawLine(x, y, NextX, NextY, CurrentColor, Width)
		Next
	Next
End Sub

private Sub HideSeekBar

	Select Direction
		Case "LtoR"
			pnlSlider.SetLayoutAnimated(SeekBarAnimationSpeed, imgIcon.Width , 0, 1dip, imgIcon.Height)
		Case "RtoL"
			pnlSlider.SetLayoutAnimated(SeekBarAnimationSpeed, mBase.Width - imgIcon.Width, 0, 1dip, mBase.Height)
		Case "TtoB"
			pnlSlider.SetLayoutAnimated(SeekBarAnimationSpeed, 0, imgIcon.Height, mBase.Width, 1dip)
		Case "BtoT"
			pnlSlider.SetLayoutAnimated(SeekBarAnimationSpeed, 0, mBase.Height - imgIcon.Height, mBase.Width, 1dip)
	End Select

	SeekbarVisible = False
	Timer1.Enabled = True
End Sub

private Sub ShowSeekBar
	pnlSlider.Visible = False
	
	Select Direction
		Case "LtoR"
			pnlSlider.SetLayoutAnimated(SeekBarAnimationSpeed, imgIcon.Width, 0, mBase.Width - imgIcon.Width, mBase.Height)
		Case "RtoL"
			pnlSlider.SetLayoutAnimated(SeekBarAnimationSpeed, 0, 0, mBase.Width - imgIcon.Width, mBase.Height)
		Case "TtoB"
			pnlSlider.SetLayoutAnimated(SeekBarAnimationSpeed, 0, mBase.Width, mBase.Width, mBase.Height-imgIcon.Height)
		Case "BtoT"
			pnlSlider.SetLayoutAnimated(SeekBarAnimationSpeed, 0, 0, mBase.Width, mBase.Height - imgIcon.Height)
	End Select

	pnlSlider.Visible = True
	SeekbarVisible = True

End Sub

Private Sub Timer1_Tick
	pnlSlider.Visible = False
	Timer1.Enabled = False
End Sub

Public Sub OpenSeekBar
	If SeekbarVisible = False Then ShowSeekBar
End Sub

public Sub CloseSeekBar
	If SeekbarVisible Then HideSeekBar
End Sub

Public Sub SetColorMap (ColorMap As Map)
	ClrMap = ColorMap
	Update
End Sub

#if b4j
Private Sub Overlay_MouseClicked (EventData As MouseEvent)
	If mLocked = False Then
		If SeekbarVisible Then
			HideSeekBar
		Else
			ShowSeekBar
		End If
	End If
End Sub
#Else
private Sub Overlay_Click
	If mLocked = False Then
		If SeekbarVisible Then
			HideSeekBar
		Else
			ShowSeekBar
		End If
	End If
End Sub
#End If

public Sub lockSlider (locked As Boolean) 
	mLocked = locked
End Sub

public Sub isLocked As Boolean
	Return mLocked
End Sub