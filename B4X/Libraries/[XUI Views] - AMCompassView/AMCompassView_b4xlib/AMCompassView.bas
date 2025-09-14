B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@


'Author: AmirMK82
'Verson: 1.00

#DesignerProperty: Key: BgColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFF5F5F5, Description: Background color of the compass
#DesignerProperty: Key: TickColor, DisplayName: Tick Color, FieldType: Color, DefaultValue: 0xFF3B3B3B, Description: Color of the Ticks

#DesignerProperty: Key: GaugeColor1, DisplayName: Gauge Color1, FieldType: Color, DefaultValue: 0xFFDC143C, Description: First color of the gauge
#DesignerProperty: Key: GaugeColor2, DisplayName: Gauge Color2, FieldType: Color, DefaultValue: 0xFF191970, Description: Second color of the gauge
#DesignerProperty: Key: GaugeStrokeWidth, DisplayName: Gauge StrokeWidth, FieldType: float, DefaultValue: 0, Description: StrokeWidth of the gauge
#DesignerProperty: Key: GaugeFilled, DisplayName: Gauge Filled, FieldType: Boolean, DefaultValue: True, Description: If color of the gauge be filled or not
#DesignerProperty: Key: GaugeWidth, DisplayName: Gauge Width, FieldType: int, DefaultValue: 15, Description: Gauge Width
#DesignerProperty: Key: GaugeHeight, DisplayName: Gauge Height, FieldType: int, DefaultValue: 90, Description: Gauge Height
#DesignerProperty: Key: GaugeAngle, DisplayName: Gauge Angle, FieldType: float, DefaultValue: 0, Description: Angle of the gauge
#DesignerProperty: Key: GaugeAnimation, DisplayName: Gauge Animation, FieldType: int, DefaultValue: 0, Description: Animation duration of the gauge

#DesignerProperty: Key: CircleColor, DisplayName: Circle Color, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: Color of the Circle
#DesignerProperty: Key: CircleStrokeWidth, DisplayName: Circle StrokeWidth, FieldType: float, DefaultValue: 0, Description: StrokeWidth of the Circle
#DesignerProperty: Key: CircleFilled, DisplayName: Circle Filled, FieldType: Boolean, DefaultValue: True, Description: If color of the Circle be filled or not
#DesignerProperty: Key: CircleRadius, DisplayName: Circle Radius, FieldType: int, DefaultValue: 10, Description: Circle Radius


Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	Public mBase As B4XView
	Private mGauge As B4XView
	Private mCircle As B4XView
	
	Private xui As XUI 'ignore
	Public Tag As Object
	
	'Background
	Private bColor As Int
	
	Private bCanvas As B4XCanvas
	
	'Tick
	Private tColor As Int
	
	'Gauge
	Private gColor1 As Int
	Private gColor2 As Int
	Private gStrokeWidth As Float
	Private gFilled As Boolean
	Private gWidth As Int
	Private gHeight As Int
	Private gAngle As Float
	Private gAnimationDuration As Int
	
	Private gCanvas As B4XCanvas
	
	'Circle
	Private cColor As Int
	Private cRadius As Float
	Private cStrokeWidth As Float
	Private cFilled As Boolean
	
	Private cCanvas As B4XCanvas
	
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mGauge = xui.CreatePanel("mGauge")
	mCircle = xui.CreatePanel("mCircle")
	
    Tag = mBase.Tag
    mBase.Tag = Me 
	
	bColor = xui.PaintOrColorToColor(Props.Get("BgColor"))
	tColor = xui.PaintOrColorToColor(Props.Get("TickColor"))

	gColor1 = xui.PaintOrColorToColor(Props.Get("GaugeColor1"))
	gColor2 = xui.PaintOrColorToColor(Props.Get("GaugeColor2"))
	gStrokeWidth = Props.Get("GaugeStrokeWidth")
	gFilled = Props.Get("GaugeFilled")
	gWidth = DipToCurrent(Props.Get("GaugeWidth"))
	gHeight = DipToCurrent(Props.Get("GaugeHeight"))
	gAngle = Props.Get("GaugeAngle")
	gAnimationDuration = Props.Get("GaugeAnimation")
	
	cColor = xui.PaintOrColorToColor(Props.Get("CircleColor"))
	cRadius = DipToCurrent(Props.Get("CircleRadius"))
	cStrokeWidth = Props.Get("CircleStrokeWidth")
	cFilled = Props.Get("CircleFilled")
	
	mGauge.Color = 0x00FF0000
	mCircle.Color = 0x00FF0000
	
	mBase.AddView(mGauge,0,0,mBase.Width,mBase.Height)
	mBase.AddView(mCircle,0,0,mBase.Width,mBase.Height)
	
	bCanvas.Initialize(mBase)
	gCanvas.Initialize(mGauge)
	cCanvas.Initialize(mCircle)
	
	DrawBackground(bColor,tColor)
	DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,gAngle)
	DrawCircle(cColor,cRadius,cStrokeWidth,cFilled)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
 	mGauge.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Height)
	mCircle.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Height)
End Sub

#Region Draws

Private Sub DrawBackground (BgColor As Int,TickColor As Int)
	bCanvas.ClearRect(bCanvas.TargetRect)
	
	Dim x As Float = mBase.Width/2 
	Dim y As Float = mBase.Height/2
	
	bCanvas.DrawCircle(x, y, Min(mBase.Width/2, mBase.Height/2) - DipToCurrent(1), BgColor, True, 0)
	bCanvas.Invalidate
	
	DrawTicks(TickColor)
	
End Sub

Private Sub DrawTicks (TickColor As Int)
	
	Dim r1 As Int = Min(mBase.Width/2, mBase.Height/2) - DipToCurrent(2)
	Dim LongTick As Int = r1 - 7dip
	Dim ShortTick As Int = r1 - 5dip
	Dim NumberOfTicks As Int = 20

	For i = 0 To NumberOfTicks
		Dim thickness, r As Int
		Dim angle As Float = i * 360 / NumberOfTicks + 90
		If i Mod 5 = 0 Then
			thickness = 3dip
			r = LongTick
		Else
			thickness = 1dip
			r = ShortTick
		End If
		
		bCanvas.DrawLine(mBase.Width/2 + r * CosD(angle), mBase.Height/2 + r * SinD(angle), mBase.Width/2 + r1 * CosD(angle),mBase.Height/2 + r1 * SinD(angle), TickColor, thickness)
		
	Next
	
	bCanvas.Invalidate
End Sub


Private Sub DrawGauge (Color1 As Int,Color2 As Int,StrokeWidth As Float,Filled As Boolean,Width As Float,Height As Float,Angle As Float)
	
	gCanvas.ClearRect(gCanvas.TargetRect)
	
	Private gPath1 As B4XPath
	gPath1.Initialize((mBase.Width/2)-(Width/2),(mBase.Height/2))
	gPath1.LineTo((mBase.Width/2),(mBase.Height/2)-(Height/2))
	gPath1.LineTo((mBase.Width/2)+(Width/2),(mBase.Height/2))
	gPath1.LineTo((mBase.Width/2)-(Width/2),(mBase.Height/2))
	
	Private gPath2 As B4XPath
	gPath2.Initialize((mBase.Width/2)-(Width/2),(mBase.Height/2))
	gPath2.LineTo((mBase.Width/2)+(Width/2),(mBase.Height/2))
	gPath2.LineTo((mBase.Width/2),(mBase.Height/2)+(Height/2))
	gPath2.LineTo((mBase.Width/2)-(Width/2),(mBase.Height/2))
	
	gCanvas.DrawPathRotated(gPath1,Color1,Filled,StrokeWidth,Angle,mBase.Width/2,mBase.Height/2)
	gCanvas.DrawPathRotated(gPath2,Color2,Filled,StrokeWidth,Angle,mBase.Width/2,mBase.Height/2)
	gCanvas.Invalidate
End Sub

Private Sub DrawCircle (Color As Int, Radius As Float, StrokeWidth As Float, Filled As Boolean)
	
	cCanvas.ClearRect(cCanvas.TargetRect)
	
	cCanvas.DrawCircle(mBase.Width/2,mBase.Height/2,Radius,Color,Filled,StrokeWidth)
	cCanvas.Invalidate
End Sub

#End Region


#Region set-Background

Public Sub setBackgroundColor (Color As Int)
	bColor = Color
	DrawBackground(bColor,tColor)
End Sub

#End Region

#Region set-Tick

Public Sub setTickColor (Color As Int)
	tColor = Color
	DrawBackground(bColor,tColor)
End Sub

#End Region

#Region set-Gauge

Public Sub setGaugeColor1 (Color As Int)
	gColor1 = Color
	
	DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,gAngle)
End Sub

Public Sub setGaugeColor2 (Color As Int)
	gColor2 = Color
	
	DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,gAngle)
End Sub

Public Sub setGaugeStrokeWidth (width As Float)
	gStrokeWidth = width
	
	DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,gAngle)
End Sub

Public Sub setGaugeFilled (Filled As Boolean)
	gFilled = Filled
	
	DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,gAngle)
End Sub

Public Sub setGaugeWidth (Width As Int)
	gWidth = Width
	
	DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,gAngle)
End Sub

Public Sub setGaugeHeight (Height As Int)
	gHeight = Height
	
	DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,gAngle)
End Sub

Public Sub setAngle (Angle As Float)
	'gAngle = Angle
	AnimateValueTo(Angle)
	'gAngle = Angle
End Sub

Public Sub setAnimationDuration (Duration As Int)
	gAnimationDuration = Duration
End Sub

#End Region

#Region set-Circle

Public Sub setCircleColor (Color As Int)
	cColor = Color
	
	DrawCircle(cColor,cRadius,cStrokeWidth,cFilled)
End Sub

Public Sub setCircleRadius (Radius As Float)
	cRadius = Radius
	
	DrawCircle(cColor,cRadius,cStrokeWidth,cFilled)
End Sub

Public Sub setCircleStrokeWidth (Width As Float)
	cStrokeWidth = Width
	
	DrawCircle(cColor,cRadius,cStrokeWidth,cFilled)
End Sub

Public Sub setCircleFilled (Filled As Boolean)
	cFilled = Filled
	
	DrawCircle(cColor,cRadius,cStrokeWidth,cFilled)
End Sub

#End Region


#Region get-Background

Public Sub getBackgroundColor As Int
	Return bColor
End Sub

#End Region

#Region get-Tick

Public Sub getTickColor As Int
	Return tColor
End Sub

#End Region


#Region get-Gauge

Public Sub getGaugeColor1 As Int
	Return gColor1
End Sub

Public Sub getGaugeColor2 As Int
	Return gColor2
End Sub

Public Sub getGaugeStrokeWidth As Float
	Return gStrokeWidth
End Sub

Public Sub getGaugeFilled As Boolean
	Return gFilled
End Sub

Public Sub getGaugeWidth As Int
	Return gWidth
End Sub

Public Sub getGaugeHeight As Int
	Return gHeight
End Sub

Public Sub getAngle As Float
	Return gAngle
End Sub

Public Sub getAnimationDuration As Int
	Return gAnimationDuration
End Sub

#End Region

#Region get-Circle

Public Sub getCircleColor As Int
	Return cColor
End Sub

Public Sub getCircleRadius As Float
	Return cRadius
End Sub

Public Sub getCircleStrokeWidth As Float
	Return cStrokeWidth
End Sub

Public Sub getCircleFilled As Boolean
	Return cFilled
End Sub

#End Region


#Region Others

Private Sub AnimateValueTo(NewValue As Float)
	Dim n As Long = DateTime.Now
	Dim duration As Int = Abs(gAngle - NewValue) / 100 * gAnimationDuration + 1000
	Dim start As Float = gAngle
	gAngle = NewValue
	Dim tempValue As Float
	Do While DateTime.Now < n + duration
		tempValue = ValueFromTimeEaseInOut(DateTime.Now - n, start, NewValue - start, duration)
		DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,tempValue)

		Sleep(10)
		If NewValue <> gAngle Then Return 'will happen if another update has started
	Loop
	DrawGauge(gColor1,gColor2,gStrokeWidth,gFilled,gWidth,gHeight,gAngle)

End Sub

'quartic easing in/out from http://gizma.com/easing/
Private Sub ValueFromTimeEaseInOut(Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time = Time / (Duration / 2)
	If Time < 1 Then
		Return ChangeInValue / 2 * Time * Time * Time * Time + Start
	Else
		Time = Time - 2
		Return -ChangeInValue / 2 * (Time * Time * Time * Time - 2) + Start
	End If
End Sub

#End Region