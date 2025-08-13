B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.51
@EndOfDesignText@
'xGauge Custom View class
'
'Version 2.0 2024.06.22
'Amended xui.SubExist problem missing parameter for B4i
'Amended problem with Reinitialize
'
'Version 1.9 2022.07.12
'Set the corner radius bigger than the border width when > 0
'
'Version 1.8 2021.08.22
'Added BorderWidth, BorderColor and CorenerRadius properties.
'Added ScaleMidLimit2StartPerCent, ScaleMidLimit2SweepPerCent, ScaleMidLimit2Color properties.
'Added gradient colors for the limit zones.
'Changed setValueMin and setValueMax from Int to Double.
'
'Version 1.7 2020.06.25
'Updated the Tag property according to Erels recommandation:
'https://www.b4x.com/android/forum/threads/b4x-how-to-get-custom-view-here-from-clv-or-any-other-container.117992/#post-738358
'
'Version 1.6 2019.03.13
'Added Click and LongClick events
'Added BringToFront, SendToBack and asView methods
'
'Version 1.5 2019.03.07
'Amended cScaleMidLimitColor initialize value from 526 to 255
'Amended setScaleColor missing reinitialize call routine
'Amended Rotate Needle equation correction
'Improved scale custom angles management
'Added cCustomScaleMinAngle and cCustomScaleMaxAngle variables
'Added NeedleON property shows or hides the needle
'
'Version 1.4 2019.03.06
'Amended NeedleBitmapFileName designation in custom properties
'Amended NeedleBitmapFileName set in the code for a Gaige added in the Designer
'Amended custom angles problems.
'Added RemoveView and ReInitialize methods
'
'Version 1.3 2018.12.20
'improved CustumScaleAngle management
'
'Version 1.2 2018.12.13
'amended display of GaugeTitle and GaugeUnit
'
'Version 1.1 2018.11.04
'improved Custom scale angles gauges
'changed custom scale angle definition positive angles become negative angles
'
'Version 1.0 2018.10.28
'
'Written by Klaus CHRISTL (klaus)
'
#Event: Click
#Event: LongClick
#RaisesSynchronousEvents: Click
#RaisesSynchronousEvents: LongClick
'
#DesignerProperty: Key: GaugeType, DisplayName: GaugeType, FieldType: String, DefaultValue: 90° Top, List: 90° Top|180°|270°|90° Left|Custom scale angles, Description: Gauge type.
#DesignerProperty: Key: ValueMax, DisplayName: ValueMax, FieldType: Int, DefaultValue: 100, Description: Max value of the scale.
#DesignerProperty: Key: ValueMin, DisplayName: ValueMin, FieldType: Int, DefaultValue: 0, Description: Min value of the scale.
#DesignerProperty: Key: GaugeTitle, DisplayName: GaugeTitle, FieldType: String, DefaultValue: Fuel, Description: Title text of the gauge type.
#DesignerProperty: Key: GaugeUnit, DisplayName: GaugeUnit, FieldType: String, DefaultValue: , Description: Gauge unit.
#DesignerProperty: Key: CustomScaleStartAngle, DisplayName: CustomScaleStartAngle, FieldType: Int, DefaultValue: 225, Description: Start angle of custom scale. Trigonometric angles 0 at 3 o'clock. Positive clockwise.
#DesignerProperty: Key: CustomScaleEndAngle, DisplayName: CustomScaleEndAngle, FieldType: Int, DefaultValue: 0, Description: End angle of custom scale. Trigonometric angles 0 at 3 o'clock. Positive clockwise.
#DesignerProperty: Key: NeedleBitmapFileName, DisplayName: NeedleBitmapFileName, FieldType: String, DefaultValue: no file, Description: File name of the needle bitmap the file must be in Files.DirAssets enter 'no file' without the quotes to use the default needle.
#DesignerProperty: Key: BackgroundColor, DisplayName: BackgroundColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the background.
#DesignerProperty: Key: ScaleColor, DisplayName: ScaleColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color of the scale.
#DesignerProperty: Key: BorderColor, DisplayName: BorderColor, FieldType: Color, DefaultValue: 0xFF808080, Description: border color.
#DesignerProperty: Key: BorderWidth, DisplayName: BorderWidth, FieldType: Int, DefaultValue: 0, Description: border width.
#DesignerProperty: Key: CornerRadius, DisplayName: CornerRadius, FieldType: Int, DefaultValue: 0, Description: corner radius; this value must be bigger than the border width.
#DesignerProperty: Key: NeedleColor, DisplayName: NeedleColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color of the needle.
#DesignerProperty: Key: NeedleON, DisplayName: NeedleON, FieldType: Boolean, DefaultValue: True, Description: Displays the needle or not.
#DesignerProperty: Key: MainTickNumber, DisplayName: MainTickNumber, FieldType: Int, DefaultValue: 5, Description: Number of main ticks.
#DesignerProperty: Key: HalfTicks, DisplayName: HalfTicks, FieldType: Boolean, DefaultValue: True, Description: Set also half ticks.
#DesignerProperty: Key: SmallTicksNumber, DisplayName: SmallTicksNumber, FieldType: Int, DefaultValue: 0, Description: Set also x small ticks between two main ticks.
#DesignerProperty: Key: TickText, DisplayName: TickText, FieldType: String, DefaultValue: E|1/2|F, Description: Text for the main ticks.
#DesignerProperty: Key: ScaleLowLimitPerCent, DisplayName: ScaleLowLimitPerCent, FieldType: Int, DefaultValue: 0, Description: Per cent of the scale low limit.
#DesignerProperty: Key: ScaleLowLimitColor, DisplayName: ScaleLowLimitColor, FieldType: Color, DefaultValue: 0xFF32CD32, Description: Color of the scale low limit.
#DesignerProperty: Key: ScaleHighLimitPerCent, DisplayName: ScaleHighLimitPerCent, FieldType: Int, DefaultValue: 0, Description: Per cent of the scale high limit.
#DesignerProperty: Key: ScaleHighLimitColor, DisplayName: ScaleHighLimitColor, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the scale high limit.
#DesignerProperty: Key: ScaleMidLimitStartPerCent, DisplayName: ScaleMidLimitStartPerCent, FieldType: Int, DefaultValue: 0, Description: Start per cent of the scale mid limit.
#DesignerProperty: Key: ScaleMidLimitSweepPerCent, DisplayName: ScaleMidLimitSweepPerCent, FieldType: Int, DefaultValue: 0, Description: Sweep per cent of the scale mid limit.
#DesignerProperty: Key: ScaleMidLimitColor, DisplayName: ScaleMidLimitColor, FieldType: Color, DefaultValue: 0xFFFFA500, Description: Color of the scale mid limit.
#DesignerProperty: Key: ScaleMidLimit2StartPerCent, DisplayName: ScaleMidLimit2StartPerCent, FieldType: Int, DefaultValue: 0, Description: Start per cent of the scale second mid limit.
#DesignerProperty: Key: ScaleMidLimit2SweepPerCent, DisplayName: ScaleMidLimit2SweepPerCent, FieldType: Int, DefaultValue: 0, Description: Sweep per cent of the scale second mid limit.
#DesignerProperty: Key: ScaleMidLimit2Color, DisplayName: ScaleMid2LimitColor, FieldType: Color, DefaultValue: 0xFFFFA500, Description: Color of the second scale mid limit.

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI
	Public Tag As Object
	Public mBase As B4XView

	Private pnlAction As B4XView
	Private pnlNeedle As B4XView
	Private cvsGauge, cvsNeedle As B4XCanvas
	Private rectGauge, rectNeedle As B4XRect
	Private cParent As B4XView
	
	Private cLeft, cTop, cWidth, cInnerWidth, cHeight, cHalfWidth As Int
	Private cMainTickNumber As Int
	Private cHalfTicks As Boolean
	Private cValue, cValueMin, cValueMax, cStartAngle, cEndAngle, cFullScaleAngle, cCustomScaleStartAngle, cCustomScaleEndAngle, cCustomScaleMinAngle, cCustomScaleMaxAngle  As Double
	Private cScaleLowLimitPerCent, cScaleHighLimitPerCent, cScaleMidLimitStartPerCent, cScaleMidLimitSweepPerCent, cScaleMidLimit2StartPerCent, cScaleMidLimit2SweepPerCent As Double
	Private cBackgroundColor, cBorderColor, cBorderWidth, cCornerRadius, cScaleColor, cNeedleColor, cScaleLowLimitColors(1), cScaleHighLimitColors(1), cScaleMidLimitColors(1), cScaleMidLimit2Colors(1) As Int
	Private cBorderColor, cBorderWidth, cCornerRadius As Int
	Private cGaugeTitleTextSize, cGaugeUnitTextSize, cScaleTextSize As Float
	Private cGaugeType, cGaugeTitle, cGaugeUnit As String
	Private cTickText As String
	Private NeedleWidth, NeedleHeight, NeedleCenterX, NeedleCenterY, ScaleStroke, ScaleHalfStroke, ScaleSmallStroke, ScaleTextHeight, DeltaTextBottom As Int
	Private RadiusInner, RadiusHalfTick, RadiusSmallTick, RadiusTick, RadiusScale As Int
	Private GaugeTextX, GaugeTextY, GaugeUnitX, GaugeUnitY As Int
	Private cSmallTicksNumber As Int
	Private cNeedleBitmapFileName As String
	Private cNeedleIndex As Int
	Private cNeedleON As Boolean
	Private StartTime As Long
End Sub

'Initializes a xGauge
'Callback is the calling module
'EventName is the generic event name, not used
Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	'define default values
	cValueMin = 0
	cValueMax = 100
	cGaugeType = "270°"
	cGaugeTitle = "Speed"
	cGaugeUnit = ""
	cTickText = "0|2|4|6|8|10"
	cMainTickNumber = 11
	cHalfTicks = True
	cSmallTicksNumber = 0
	cCustomScaleStartAngle = -225
	cCustomScaleEndAngle = 0
	cCustomScaleMinAngle = 45
	cCustomScaleMaxAngle = 330
	cBackgroundColor = xui.Color_White
	cScaleColor = xui.Color_Black
	cBorderWidth = 0
	cBorderColor = xui.Color_LightGray
	cCornerRadius = 0
	cNeedleColor  = xui.Color_Gray
	cNeedleBitmapFileName = "no file"
	cNeedleON = True
	cScaleLowLimitPerCent = 0
	cScaleLowLimitColors(0) = xui.Color_RGB(50, 205, 50)
	cScaleHighLimitPerCent = 0
	cScaleHighLimitColors(0) = xui.Color_Red
	cScaleMidLimitStartPerCent = 0
	cScaleMidLimitSweepPerCent = 0
	cScaleMidLimitColors(0) = xui.Color_RGB(255, 165, 0)
	cScaleMidLimit2StartPerCent = 0
	cScaleMidLimit2SweepPerCent = 0
	cScaleMidLimit2Colors(0) = xui.Color_RGB(255, 165, 0)
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	cLeft = mBase.Left
	cTop = mBase.Top
	cWidth = mBase.Width
	cHeight = mBase.Height
	
	cHalfWidth = cWidth / 2
	cParent = mBase.Parent
	
	cGaugeType = Props.GetDefault("GaugeType", "90° Top")
	cNeedleBitmapFileName = Props.Get("NeedleBitmapFileName")
	cValueMin = Props.Get("ValueMin")
	cValueMax = Props.Get("ValueMax")
	cGaugeTitle = Props.Get("GaugeTitle")
	cGaugeUnit = Props.Get("GaugeUnit")
	cCustomScaleStartAngle = Props.Get("CustomScaleStartAngle")
	cCustomScaleEndAngle = Props.Get("CustomScaleEndAngle")
	cTickText = Props.Get("TickText")
	cMainTickNumber = Props.Get("MainTickNumber")
	cHalfTicks = Props.Get("HalfTicks")
	cSmallTicksNumber = Props.Get("SmallTicksNumber")
	cBackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	cScaleColor = xui.PaintOrColorToColor(Props.Get("ScaleColor"))
	cBorderWidth = Props.GetDefault("BorderWidth", 0)
	cBorderColor = xui.PaintOrColorToColor(Props.GetDefault("BorderColor", xui.Color_LightGray))
	cCornerRadius = Props.GetDefault("CornerRadius", 0)
	If cCornerRadius > 0 And cCornerRadius < cBorderWidth + 1 Then
		cCornerRadius = cBorderWidth + 1
	End If
	cNeedleColor = xui.PaintOrColorToColor(Props.Get("NeedleColor"))
	cNeedleON = Props.Get("NeedleON")
	cScaleLowLimitPerCent = Props.Get("ScaleLowLimitPerCent")
	Private cScaleLowLimitColors(1) As Int
	cScaleLowLimitColors(0) =  xui.PaintOrColorToColor(Props.Get("ScaleLowLimitColor"))
	cScaleHighLimitPerCent = Props.Get("ScaleHighLimitPerCent")
	Private cScaleHighLimitColors(1) As Int
	cScaleHighLimitColors(0) =  xui.PaintOrColorToColor(Props.Get("ScaleHighLimitColor"))
	cScaleMidLimitStartPerCent = Props.Get("ScaleMidLimitStartPerCent")
	cScaleMidLimitSweepPerCent = Props.Get("ScaleMidLimitSweepPerCent")
	Private cScaleMidLimitColors(1) As Int
	cScaleMidLimitColors(0) = xui.PaintOrColorToColor(Props.Get("ScaleMidLimitColor"))
	cScaleMidLimit2StartPerCent = Props.GetDefault("ScaleMidLimitStartPerCent2", 10)
	cScaleMidLimit2SweepPerCent = Props.GetDefault("ScaleMidLimitSweepPerCent2", 0)
	Private cScaleMidLimit2Colors(1) As Int
	cScaleMidLimit2Colors(0) = xui.PaintOrColorToColor(Props.GetDefault("ScaleMidLimitColor2", 0xFFFFA500))
	
	If cGaugeType.SubString2(0, 4) <> "Rect" Then
		cHeight = cWidth
	End If
	
	Select cGaugeType
		Case "180°"
			cHeight = 0.7 * cWidth
		Case "Custom scale angles"
			cStartAngle = cCustomScaleStartAngle
			cEndAngle = cCustomScaleEndAngle
			If cEndAngle < cStartAngle Then
				#If B4J
				LogError("Error in CustomScaleAngles xChart! End angle " & cEndAngle & " smaller than Start angle " & cStartAngle & " !  Angle zero at 3 o'clock, postive clockwise!")
				#Else
				LogColor("Error in CustomScaleAngles xChart! End angle " & cEndAngle & " smaller than Start angle " & cStartAngle & " !  Angle zero at 3 o'clock, postive clockwise!", Colors.Red)
				#End If
			End If
			If cStartAngle >= -190 And cStartAngle < -90 And cEndAngle > -90 And cEndAngle <= 10 Then
				cHeight = 0.7 * cWidth
			End If
	End Select
	mBase.Height = cHeight

	InitGauge
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	setWidth(Width)
End Sub

'adds the xGauge to the Parent view.
'the parent object can be a B4XView or
'an Activity or a Panel in B4A, a Panel in B4i or a Pane in B4J
'there is no Height property, because the Height = Width 
Public Sub AddToParent(Parent As Object, Left As Int, Top As Int, Width As Int)
	cLeft = Left
	cTop = Top
	cWidth = Width
	cHalfWidth = cWidth / 2
	
	cParent = Parent
	InitHeight
	
	mBase = xui.CreatePanel("")
	cParent.AddView(mBase, cLeft, cTop, cWidth, cHeight)
	mBase.Tag = Me
	
	InitGauge
End Sub

Private Sub InitGauge
	Private rectGaugeTitle, rectScaleText As B4XRect

	cvsGauge.Initialize(mBase)
	
	cInnerWidth = cWidth - 2 * cBorderWidth
	
	pnlAction = xui.CreatePanel("pnlAction")
	mBase.AddView(pnlAction, 0, 0, mBase.Width, mBase.Height)
	
	cGaugeTitleTextSize = 0.08 * cWidth / xui.Scale
	cGaugeUnitTextSize = 0.07 * cWidth / xui.Scale
	cScaleTextSize = 0.06 * cWidth / xui.Scale
	
	rectGaugeTitle = cvsGauge.MeasureText("Ag", xui.CreateDefaultFont(cGaugeTitleTextSize))
	rectScaleText = cvsGauge.MeasureText("Ag", xui.CreateDefaultFont(cScaleTextSize))
	ScaleTextHeight = 0.7 * rectScaleText.Height
	
	rectGauge.Initialize(0, 0, cWidth, cHeight)
	
	Private ScaleStrokeDivider = 70 As Int
	Select cGaugeType
		Case "90° Top"
			cStartAngle = -135
			cEndAngle = -45
	
			ScaleStroke = cInnerWidth / ScaleStrokeDivider
			RadiusInner = 0.52 * cInnerWidth - cBorderWidth
			RadiusHalfTick = 0.56 * cInnerWidth - cBorderWidth
			RadiusSmallTick = 0.545 * cInnerWidth - cBorderWidth
			RadiusTick = 0.59 * cInnerWidth - cBorderWidth
			RadiusScale = 0.62 * cInnerWidth - cBorderWidth
			
			NeedleCenterX = cHalfWidth
			NeedleCenterY = cBorderWidth + 0.75 * cInnerWidth
			NeedleHeight = 2 * RadiusInner
			NeedleWidth = NeedleHeight / 340 * 27
			
			GaugeTextX = cHalfWidth
			GaugeTextY = cBorderWidth + 0.5 * cInnerWidth
			DeltaTextBottom = 0
			cNeedleIndex = 0
		Case "180°"
			cStartAngle = -180
			cEndAngle = 0
	
			ScaleStroke = cInnerWidth / ScaleStrokeDivider
			RadiusInner = 0.41 * cInnerWidth - cBorderWidth
			RadiusHalfTick = 0.45 * cInnerWidth - cBorderWidth
			RadiusSmallTick = 0.435 * cInnerWidth - cBorderWidth
			RadiusTick = 0.48 * cInnerWidth - cBorderWidth	
			RadiusScale = 0.35 * cInnerWidth - cBorderWidth
			
			NeedleCenterX = cHalfWidth
			NeedleCenterY = cBorderWidth + 0.55 * cInnerWidth
			NeedleHeight = 2 * RadiusInner
			NeedleWidth = NeedleHeight / 340 * 27
			
			GaugeTextX = cHalfWidth
			GaugeTextY = cBorderWidth + 0.45 * cInnerWidth
			DeltaTextBottom = 0.6 * ScaleTextHeight
			cNeedleIndex = 0
		Case "270°"
			cStartAngle = -225
			cEndAngle = 45
			
			ScaleStroke = cInnerWidth / ScaleStrokeDivider
			RadiusInner = 0.41 * cInnerWidth - cBorderWidth
			RadiusHalfTick = 0.45 * cInnerWidth - cBorderWidth
			RadiusSmallTick = 0.435 * cInnerWidth - cBorderWidth
			RadiusTick = 0.48 * cInnerWidth - cBorderWidth
			RadiusScale = 0.35 * cInnerWidth - cBorderWidth
		
			NeedleCenterX = cHalfWidth
			NeedleCenterY = cBorderWidth + 0.55 * cInnerWidth
			NeedleHeight = 2 * RadiusInner
			NeedleWidth = NeedleHeight / 340 * 27
			
			GaugeTextX = cHalfWidth
			GaugeTextY = cBorderWidth + 0.7 * cInnerWidth
			DeltaTextBottom = 0.6 * ScaleTextHeight
			cNeedleIndex = 0
		Case "90° Left"
			cStartAngle = -180
			cEndAngle = -90
	
			ScaleStroke = cInnerWidth / ScaleStrokeDivider
			RadiusInner = 0.8 * cInnerWidth - cBorderWidth
			RadiusHalfTick = 0.84 * cInnerWidth - cBorderWidth
			RadiusSmallTick = 0.825 * cInnerWidth - cBorderWidth
			RadiusTick = 0.87 * cInnerWidth - cBorderWidth
			RadiusScale = 0.73 * cInnerWidth - cBorderWidth
			
			NeedleCenterX = 0.9 * cInnerWidth + cBorderWidth
			NeedleCenterY = 0.9 * cInnerWidth + cBorderWidth
			NeedleHeight = 2 * RadiusInner
			NeedleWidth = NeedleHeight / 340 * 20
			
			GaugeTextX = cBorderWidth + 0.7 * cInnerWidth
			GaugeTextY = cBorderWidth + 0.65 * cInnerWidth
			DeltaTextBottom = 0.6 * ScaleTextHeight
			
			cScaleTextSize = 0.07 * cInnerWidth / xui.Scale
			cNeedleIndex = 1
		Case "Custom scale angles"
			cStartAngle = cCustomScaleStartAngle
			cEndAngle = cCustomScaleEndAngle
			If cStartAngle >= -180 And cEndAngle <= -90 Then
				ScaleStroke = cInnerWidth / ScaleStrokeDivider
				RadiusInner = 0.8 * cInnerWidth - cBorderWidth
				RadiusHalfTick = 0.84 * cInnerWidth - cBorderWidth
				RadiusSmallTick = 0.825 * cInnerWidth - cBorderWidth
				RadiusTick = 0.87 * cInnerWidth - cBorderWidth
				RadiusScale = 0.73 * cInnerWidth - cBorderWidth
			
				NeedleCenterX = 0.9 * cInnerWidth - cBorderWidth
				NeedleCenterY = 0.9 * cInnerWidth - cBorderWidth
				NeedleHeight = 2 * RadiusInner
				NeedleWidth = NeedleHeight / 340 * 20
			
				GaugeTextX = 0.7 * cInnerWidth + cBorderWidth
				GaugeTextY = cBorderWidth + 0.65 * cInnerWidth
				DeltaTextBottom = 0.6 * ScaleTextHeight
			
				cScaleTextSize = 0.07 * cInnerWidth - cBorderWidth / xui.Scale
				cNeedleIndex = 1
			Else If cStartAngle >= -90 And cEndAngle <= 0 Then
				ScaleStroke = cInnerWidth / ScaleStrokeDivider
				RadiusInner = 0.8 * cInnerWidth - cBorderWidth
				RadiusHalfTick = 0.84 * cInnerWidth - cBorderWidth
				RadiusSmallTick = 0.825 * cInnerWidth - cBorderWidth
				RadiusTick = 0.87 * cInnerWidth - cBorderWidth
				RadiusScale = 0.73 * cInnerWidth - cBorderWidth
			
				NeedleCenterX = 0.1 * cInnerWidth + cBorderWidth
				NeedleCenterY = 0.9 * cInnerWidth + cBorderWidth
				NeedleHeight = 2 * RadiusInner
				NeedleWidth = NeedleHeight / 340 * 20
			
				GaugeTextX = 0.3 * cInnerWidth + cBorderWidth
				GaugeTextY = cBorderWidth + 0.65 * cInnerWidth
				DeltaTextBottom = 0.6 * ScaleTextHeight
			
				cScaleTextSize = 0.07 * cInnerWidth / xui.Scale
				cNeedleIndex = 1
			Else If cStartAngle >= -190 And cEndAngle <= 10 Then
				ScaleStroke = cInnerWidth / ScaleStrokeDivider
				RadiusInner = 0.41 * cInnerWidth - cBorderWidth
				RadiusHalfTick = 0.45 * cInnerWidth - cBorderWidth
				RadiusSmallTick = 0.435 * cInnerWidth - cBorderWidth
				RadiusTick = 0.48 * cInnerWidth - cBorderWidth
				RadiusScale = 0.35 * cInnerWidth - cBorderWidth
			
				NeedleCenterX = cHalfWidth
				NeedleCenterY = cBorderWidth + 0.55 * cInnerWidth
				NeedleHeight = 2 * RadiusInner
				NeedleWidth = NeedleHeight / 340 * 27
			
				GaugeTextX = cHalfWidth
				GaugeTextY = cBorderWidth + 0.45 * cInnerWidth
				DeltaTextBottom = 0.6 * ScaleTextHeight
				cNeedleIndex = 0
			Else If cStartAngle < -240 Or cEndAngle > 60 Then
				ScaleStroke = cInnerWidth / ScaleStrokeDivider
				RadiusInner = 0.41 * cInnerWidth - cBorderWidth
				RadiusHalfTick = 0.45 * cInnerWidth - cBorderWidth
				RadiusSmallTick = 0.435 * cInnerWidth - cBorderWidth
				RadiusTick = 0.48 * cInnerWidth - cBorderWidth
				RadiusScale = 0.35 * cInnerWidth - cBorderWidth
			
				NeedleCenterX = cHalfWidth
				NeedleCenterY = cHalfWidth
				NeedleHeight = 2 * RadiusInner
				NeedleWidth = NeedleHeight / 340 * 27
			
				GaugeTextX = cHalfWidth
				GaugeTextY = cBorderWidth + 0.7 * cInnerWidth
				DeltaTextBottom = 0.6 * ScaleTextHeight
				cNeedleIndex = 0
			Else
				ScaleStroke = cInnerWidth / ScaleStrokeDivider
				RadiusInner = 0.41 * cInnerWidth - cBorderWidth
				RadiusHalfTick = 0.45 * cInnerWidth - cBorderWidth
				RadiusSmallTick = 0.435 * cInnerWidth - cBorderWidth
				RadiusTick = 0.48 * cInnerWidth - cBorderWidth
				RadiusScale = 0.35 * cInnerWidth - cBorderWidth
				NeedleCenterX = cHalfWidth
				NeedleCenterY = cBorderWidth + 0.55 * cInnerWidth
				NeedleHeight = 2 * RadiusInner
				NeedleWidth = NeedleHeight / 340 * 27
		
				GaugeTextX = cHalfWidth
				GaugeTextY = cBorderWidth + 0.75 * cInnerWidth - cBorderWidth
				DeltaTextBottom = 0.8 * ScaleTextHeight
				cNeedleIndex = 0
			End If
	End Select
	GaugeUnitX = GaugeTextX
	GaugeUnitY = GaugeTextY + 1.1 * rectGaugeTitle.Height
	
	ScaleHalfStroke = ScaleStroke / 1.5
	ScaleSmallStroke = ScaleStroke / 2
	
	cFullScaleAngle = cEndAngle - cStartAngle

	pnlNeedle = xui.CreatePanel("")
	
	mBase.AddView(pnlNeedle, NeedleCenterX - NeedleWidth / 2, NeedleCenterY - NeedleHeight / 2, NeedleWidth, NeedleHeight)
	rectNeedle.Initialize(0, 0, NeedleWidth, NeedleHeight)
	
	cvsNeedle.Initialize(pnlNeedle)
	cvsNeedle.DrawLine(0, 0, cWidth, cHeight, cNeedleColor, 3dip)
	DrawGauge
	
	RotateNeedle(0)
End Sub

Private Sub RotateNeedle(Value As Double)
	Private Angle As Double
	
	cValue = Value
	Angle = cStartAngle + 90 + (cValue - cValueMin) / (cValueMax - cValueMin) * cFullScaleAngle
	If cGaugeType.SubString2(0, 4) <> "Rect" Then
'		pnlNeedle.SetRotationAnimated(100, Angle)
		pnlNeedle.Rotation = Angle
	End If
End Sub

Private Sub DrawGauge
	DrawNeedle
	DrawScale
End Sub

Private Sub DrawScale
	Private Angle As Double
	Private DeltaAngle As Double
	Private StrokeWidth, LimitRadius As Int
	Private x1, y1, x2, y2 As Int
	
	StrokeWidth = RadiusHalfTick - RadiusInner
	LimitRadius = RadiusHalfTick - StrokeWidth / 2 + 1
	LimitRadius = RadiusHalfTick

	Private bmcLimits As BitmapCreator
	bmcLimits.Initialize(cWidth, cHeight)
	
	bmcLimits.DrawRectRounded(rectGauge, cBackgroundColor, True, 1, cCornerRadius)
	
	If cScaleLowLimitPerCent > 0 Or cScaleHighLimitPerCent > 0 Or cScaleMidLimitSweepPerCent > 0 Or cScaleMidLimit2SweepPerCent > 0 Or cBorderWidth > 0 Then
		If cScaleLowLimitPerCent > 0 Then
			Private LowLimitAngle As Double
			LowLimitAngle = cFullScaleAngle * cScaleLowLimitPerCent / 100
			If cScaleLowLimitColors.Length = 1  Then
				bmcLimits.DrawArc(NeedleCenterX, NeedleCenterY, LimitRadius, cScaleLowLimitColors(0), False, StrokeWidth, cStartAngle, LowLimitAngle)
			Else
				bmcLimits.DrawArc2(NeedleCenterX, NeedleCenterY, LimitRadius, GetGradientBrush(bmcLimits, cStartAngle, LowLimitAngle, cScaleLowLimitColors), False, StrokeWidth, cStartAngle, LowLimitAngle)
			End If
		End If

		If cScaleHighLimitPerCent > 0 Then
			Private HighLimitAngle As Double
			HighLimitAngle = cFullScaleAngle * cScaleHighLimitPerCent / 100
			If cScaleHighLimitColors.Length = 1  Then
				bmcLimits.DrawArc(NeedleCenterX, NeedleCenterY, LimitRadius, cScaleHighLimitColors(0), False, StrokeWidth, cEndAngle - HighLimitAngle, HighLimitAngle)
			Else
				bmcLimits.DrawArc2(NeedleCenterX, NeedleCenterY, LimitRadius, GetGradientBrush(bmcLimits, cEndAngle - HighLimitAngle, HighLimitAngle, cScaleHighLimitColors), False, StrokeWidth, cEndAngle - HighLimitAngle, HighLimitAngle)
			End If
		End If
	
		If cScaleMidLimitSweepPerCent > 0 Then
			Private LimitStartAngle, LimitSweepAngle As Double
			LimitStartAngle = cStartAngle + cFullScaleAngle * cScaleMidLimitStartPerCent / 100
			LimitSweepAngle = cFullScaleAngle * cScaleMidLimitSweepPerCent / 100
			If cScaleMidLimitColors.Length = 1  Then
				bmcLimits.DrawArc(NeedleCenterX, NeedleCenterY, LimitRadius, cScaleMidLimitColors(0), False, StrokeWidth, LimitStartAngle, LimitSweepAngle)
			Else
				bmcLimits.DrawArc2(NeedleCenterX, NeedleCenterY, LimitRadius, GetGradientBrush(bmcLimits,LimitStartAngle, LimitSweepAngle, cScaleMidLimitColors), False, StrokeWidth, LimitStartAngle, LimitSweepAngle)
			End If
		End If
		
		If cScaleMidLimit2SweepPerCent > 0 Then
			Private LimitStartAngle, LimitSweepAngle As Double
			LimitStartAngle = cStartAngle + cFullScaleAngle * cScaleMidLimit2StartPerCent / 100
			LimitSweepAngle = cFullScaleAngle * cScaleMidLimit2SweepPerCent / 100
			If cScaleMidLimit2Colors.Length = 1  Then
				bmcLimits.DrawArc(NeedleCenterX, NeedleCenterY, LimitRadius, cScaleMidLimit2Colors(0), False, StrokeWidth, LimitStartAngle, LimitSweepAngle)
			Else
				bmcLimits.DrawArc2(NeedleCenterX, NeedleCenterY, LimitRadius, GetGradientBrush(bmcLimits, LimitStartAngle, LimitSweepAngle, cScaleMidLimit2Colors), False, StrokeWidth, LimitStartAngle, LimitSweepAngle)
			End If
		End If
		
		If cBorderWidth > 0 Then
			If cCornerRadius = 0 Then
				bmcLimits.DrawRect(rectGauge, cBorderColor, False, cBorderWidth)
			Else
				bmcLimits.DrawRectRounded(rectGauge, cBorderColor, False, cBorderWidth, cCornerRadius)
			End If
		End If
	End If
	cvsGauge.DrawBitmap(bmcLimits.Bitmap, rectGauge)
	
	DeltaAngle = cFullScaleAngle / (cMainTickNumber - 1)
	For i = 0 To cMainTickNumber - 1
		Angle = -cStartAngle - i * DeltaAngle
		x1 = NeedleCenterX + CosD(Angle) * RadiusInner
		y1 = NeedleCenterY - SinD(Angle) * RadiusInner
		x2 = NeedleCenterX + CosD(Angle) * RadiusTick
		y2 = NeedleCenterY - SinD(Angle) * RadiusTick
		cvsGauge.DrawLine(x1, y1, x2, y2, cScaleColor, ScaleStroke)
	Next
	
	If cHalfTicks = True Then
		For i = 0 To cMainTickNumber - 2
			Angle = -cStartAngle - DeltaAngle / 2 - i * DeltaAngle
			x1 = NeedleCenterX + CosD(Angle) * RadiusInner
			y1 = NeedleCenterY - SinD(Angle) * RadiusInner
			x2 = NeedleCenterX + CosD(Angle) * RadiusHalfTick
			y2 = NeedleCenterY - SinD(Angle) * RadiusHalfTick
			cvsGauge.DrawLine(x1, y1, x2, y2, cScaleColor, ScaleHalfStroke)
		Next
	End If
	
	If cSmallTicksNumber > 0 Then
		DeltaAngle = cFullScaleAngle / (cMainTickNumber - 1) / cSmallTicksNumber
		For i = 0 To (cMainTickNumber - 1) * cSmallTicksNumber
			Angle = -cStartAngle - i * DeltaAngle
			x1 = NeedleCenterX + CosD(Angle) * RadiusInner
			y1 = NeedleCenterY - SinD(Angle) * RadiusInner
			x2 = NeedleCenterX + CosD(Angle) * RadiusSmallTick
			y2 = NeedleCenterY - SinD(Angle) * RadiusSmallTick
			cvsGauge.DrawLine(x1, y1, x2, y2, cScaleColor, ScaleSmallStroke)
		Next
	End If
	
	Private TickTexts() As String
	TickTexts = Regex.Split("\|", cTickText)
	DeltaAngle = cFullScaleAngle / (TickTexts.Length - 1)
	For i = 0 To TickTexts.Length - 1
		x1 = NeedleCenterX + CosD(-cStartAngle - i * DeltaAngle) * RadiusScale
		y1 = NeedleCenterY - SinD(-cStartAngle - i * DeltaAngle) * RadiusScale + DeltaTextBottom
		cvsGauge.DrawText(TickTexts(i), x1, y1, xui.CreateDefaultBoldFont(cScaleTextSize), cScaleColor, "CENTER")
	Next
	cvsGauge.DrawText(cGaugeTitle, GaugeTextX, GaugeTextY, xui.CreateDefaultBoldFont(cGaugeTitleTextSize), cScaleColor, "CENTER")
	cvsGauge.DrawText(cGaugeUnit, GaugeUnitX, GaugeUnitY, xui.CreateDefaultFont(cGaugeUnitTextSize), cScaleColor, "CENTER")
	
	cvsGauge.Invalidate
End Sub

Private Sub GetGradientBrush(bmc As BitmapCreator, StartAngle As Double, SweepAngle As Double, GradientColors() As Int) As BCBrush
	Private Angle As Double
	Private g, r As BitmapCreator
	g.Initialize(cWidth, cHeight)
	r.Initialize(cWidth, 2)
			
	Dim rect As B4XRect
	rect.Initialize(0, 0, bmc.mWidth, 2) 'ignore
	r.FillGradient(GradientColors, rect, "LEFT_RIGHT")
	
	For y = 0 To bmc.mHeight - 1
		For x = 0 To bmc.mWidth - 1
			Angle = ATan2D(y - NeedleCenterY, x - NeedleCenterX)
			If StartAngle < 180 And Angle > StartAngle + 360 Then
				Angle = Angle - 360
			End If
			If StartAngle + SweepAngle > 180  And Angle < StartAngle + SweepAngle - 360 Then
				Angle = Angle + 360
			End If
			If Angle >= StartAngle And Angle < StartAngle + SweepAngle Then
				g.CopyPixel(r, r.mWidth * (Angle - StartAngle) / SweepAngle, 0, x, y)
			End If
		Next
	Next
	Return  bmc.CreateBrushFromBitmapCreator(g)
End Sub

Private Sub DrawNeedle
	Private pthNeedle As B4XPath
	Private x1, x2, r2 As Int

	If cNeedleBitmapFileName <> "no file" Then
		Private bmpNeedle As B4XBitmap
		bmpNeedle = xui.LoadBitmap(File.DirAssets, cNeedleBitmapFileName)
		NeedleWidth = NeedleHeight / bmpNeedle.Height * bmpNeedle.Width
		pnlNeedle.Left = NeedleCenterX - NeedleWidth / 2
		pnlNeedle.Width = NeedleWidth
		rectNeedle.Width = NeedleWidth
		cvsNeedle.Resize(NeedleWidth, NeedleHeight)
		cvsNeedle.ClearRect(rectNeedle)
		cvsNeedle.DrawBitmap(bmpNeedle, rectNeedle)
		cvsNeedle.Invalidate
	Else
		cvsNeedle.ClearRect(rectNeedle)
		Select cNeedleIndex
			Case 1
				x1 = cWidth / 25
				x2 = ScaleStroke
				r2 = NeedleWidth / 6
				pthNeedle.Initialize((NeedleWidth - x1) / 2, 0.5 * NeedleHeight)
				pthNeedle.LineTo((NeedleWidth - x2) / 2, 0)
				pthNeedle.LineTo((NeedleWidth + x2) / 2, 0)
				pthNeedle.LineTo((NeedleWidth + x1) / 2, 0.5 * NeedleHeight)
				cvsNeedle.DrawPath(pthNeedle, cNeedleColor, True, 1dip)
			Case 0
				x1 = cWidth / 30
				x2 = ScaleStroke
				r2 = NeedleWidth / 5
				pthNeedle.Initialize((NeedleWidth - x1) / 2, 0.65 * NeedleHeight)
				pthNeedle.LineTo((NeedleWidth - x2) / 2, 0)
				pthNeedle.LineTo((NeedleWidth + x2) / 2, 0)
				pthNeedle.LineTo((NeedleWidth + x1) / 2, 0.65 * NeedleHeight)
				cvsNeedle.DrawPath(pthNeedle, cNeedleColor, True, 1dip)
			Case 2
		End Select
		cvsNeedle.DrawCircle(NeedleWidth / 2, NeedleHeight / 2, NeedleWidth / 2, cNeedleColor, True, 1dip)
		cvsNeedle.DrawCircle(NeedleWidth / 2, NeedleHeight / 2, r2, cBackgroundColor, True, 1dip)
		cvsNeedle.Invalidate
	End If
End Sub

'sets or gets GaugeType property
'possible values 90° Top, 180°, 270°, 90° Left, Custom scale angles
'for Custom scale angles you can set the start and the end angle
Public Sub setGaugeType(GaugeType As String)
	If GaugeType <> "90° Top" And GaugeType <> "180°" And GaugeType <> "270°" And GaugeType <> "90° Left" And GaugeType <> "Custom scale angles" Then
		Return
	End If
	cGaugeType = GaugeType
	ReInitialize
End Sub

Public Sub getGaugeType As String
	Return cGaugeType
End Sub

'sets the value of the gauge
'the value must be between ValueMin and ValueMax
Public Sub setValue (Value As Double)
	cValue = Min(Value, cValueMax)
	cValue = Max(Value, cValueMin)
	RotateNeedle(cValue)
End Sub

'gets or sets the min value of the gauge
Public Sub getValueMin As Double
	Return cValueMin
End Sub

Public Sub setValueMin(ValueMin As Double)
	cValueMin = ValueMin
	ReInitialize
End Sub

'gets or sets the max value of the gauge
Public Sub getValueMax As Double
	Return cValueMax
End Sub

Public Sub setValueMax(ValueMax As Double)
	cValueMax = ValueMax
	ReInitialize
End Sub

'gets or sets the number of main ticks
'for a scale from 0 to 10 then number must be 11
Public Sub getMainTickNumber As Int
	Return cMainTickNumber
End Sub

Public Sub setMainTickNumber(MainTickNumber As Int)
	cMainTickNumber = MainTickNumber
	ReInitialize
End Sub

'gets or sets if half (intermedaite) tick are required
'one tick between two main ticks
Public Sub getHalfTicks As Boolean
	Return cHalfTicks
End Sub

Public Sub setSmallTicksNumber(SmallTicksNumber As Int)
	cSmallTicksNumber = SmallTicksNumber
	ReInitialize
End Sub

'gets or sets the SmallTickNumber property
'SmallTicksNumber small ticks will drawn between two main ticks
'for a decimal scale SmallTickNumber = 10, eventhough only 9 ticks are seen, the 10th is hidden by the main tick
Public Sub getSmallTicksNumber As Int
	Return cSmallTicksNumber
End Sub

Public Sub setHalfTicks(HalfTicks As Boolean)
	cHalfTicks = HalfTicks
	ReInitialize
End Sub

'gets or sets the texts for the ticks
'the values between two || are displayed equally spaced on the scale
'Example: 0|20|40|60|80|100 or E|1/2|F
Public Sub getTickText As String
	Return cTickText
End Sub

Public Sub setTickText(TickText As String)
	cTickText = TickText
	ReInitialize
End Sub

'sets or gets the BackgroundColor
'it must be an xui.Color
'Example: xGauge1.BackgroundColor = xui.Color_White
Public Sub setBackgroundColor(Color As Int)
	cBackgroundColor = Color
	ReInitialize
End Sub

Public Sub getBackgroundColor As Int
	Return cBackgroundColor
End Sub

'sets or gets the ScaleColor
'it must be an xui.Color
'Example: xGauge1.ScaleColor = xui.Color_Black
Public Sub setScaleColor(ScaleColor As Int)
	cScaleColor = ScaleColor
	If mBase.IsInitialized Then
		DrawScale
	End If
End Sub

Public Sub getScaleColor As Int
	Return cScaleColor
End Sub

'sets or gets the BorderWidth
'Example: xGauge1.BorderWidth = 5
Public Sub setBorderWidth(BorderWidth As Int)
	cBorderWidth = BorderWidth
	If mBase.IsInitialized Then
		DrawScale
	End If
End Sub

Public Sub getBorderWidth As Int
	Return cBorderWidth
End Sub

'sets or gets the BorderColor property
'it must be an xui.Color
'Example: xGauge1.BorderColor = xui.Color_Gray
Public Sub setBorderColor(BorderColor As Int)
	cBorderColor = BorderColor
	If mBase.IsInitialized Then
		DrawScale
	End If
End Sub

Public Sub getBorderColor As Int
	Return cBorderColor
End Sub

'sets or gets the CornerRadius property
'this value must bee bigger than the BorderWidth.
'if cCornerRadius > 0 And cCornerRadius < cBorderWidth + 1 Then cCornerRadius = cBorderWidth + 1
'Example: xGauge1.CornerRadius = 5dip
Public Sub setCornerRadius(CornerRadius As Int)
	cCornerRadius = CornerRadius
	If mBase.IsInitialized Then
		DrawScale
	End If
End Sub

Public Sub getCornerRadius As Int
	Return cCornerRadius
End Sub

'sets or gets the NeedleColor property
'it must be an xui.Color
'Example: xGauge1.NeedleColor = xui.Color_Gray
Public Sub setNeedleColor(NeedleColor As Int)
	cNeedleColor = NeedleColor
	ReInitialize
End Sub

Public Sub getNeedleColor As Int
	Return cNeedleColor
End Sub

'sets or gets the GaugeTitle property
Public Sub setGaugeTitle(GaugeTitle As String)
	cGaugeTitle = GaugeTitle
	If mBase.IsInitialized Then
		DrawGauge
	End If
End Sub

Public Sub getGaugeTitle As String
	Return cGaugeTitle
End Sub

'sets or gets the GaugeUnit property
Public Sub setGaugeUnit(GaugeUnit As String)
	cGaugeUnit = GaugeUnit
	If mBase.IsInitialized Then
		DrawGauge
	End If
End Sub

Public Sub getGaugeUnit As String
	Return cGaugeUnit
End Sub

'sets or gets the width of the gauge
'only the rectangular gauges have a Height property, all the others don't have Height property because the height is equal to the width
Public Sub setWidth(Width As Double)
	cWidth = Width
	cHalfWidth = cWidth / 2
	ReInitialize
End Sub

Public Sub getWidth As Double
	Return cWidth
End Sub

Public Sub getHeight As Double
	Return cHeight
End Sub

'sets or gets the Left property
Public Sub setLeft(Left As Double)
	cLeft = Left
	mBase.Left = cLeft
End Sub

Public Sub getLeft As Double
	Return cLeft
End Sub

'sets or gets the Top property
Public Sub setTop(Top As Double)
	cTop = Top
	mBase.Top = Top
End Sub

Public Sub getTop As Double
	Return cTop
End Sub

'gets the Parent property
'read only
Public Sub getParent As B4XView
	Return cParent
End Sub

'sets or gets the ScaleLowLimitPerCent property
'given in pecent of the scale
'it drawn from the scale start to the given percent
Public Sub setScaleLowLimitPerCent(ScaleLowLimitPerCent As Double)
	cScaleLowLimitPerCent = ScaleLowLimitPerCent
	ReInitialize
End Sub

Public Sub getScaleLowLimitPerCent As Double
	Return cScaleLowLimitPerCent
End Sub

'sets or gets the ScaleLowLimitColor property
'it must be an xui.Color
'Example: xGauge1.NeedleColor = xui.Color_RGB(255, 165, 0)
Public Sub setScaleLowLimitColor(ScaleLowLimitColors As Int)
	Private cScaleLowLimitColors(1) As Int
	cScaleLowLimitColors(0) = ScaleLowLimitColors
	ReInitialize
End Sub

Public Sub getScaleLowLimitColor As Int
	Return cScaleLowLimitColors(0)
End Sub

'sets or gets the ScaleLowLimitColor property
'it must be an Array of xui.Colors
'Example: xGauge1.NeedleColor = Array As Int(xui.Color_RGB(255, 165, 0), xui.Color_Red)
Public Sub setScaleLowLimitColors(ScaleLowLimitColors() As Int)
	cScaleLowLimitColors = ScaleLowLimitColors
	ReInitialize
End Sub

Public Sub getScaleLowLimitColors As Int()
	Return cScaleLowLimitColors
End Sub

'sets or gets the ScaleHighLimitPerCent property
'it is drawn from the given percent to the scale end
'given in pecent of the scale
Public Sub setScaleHighLimitPerCent(ScaleHighLimitPerCent As Double)
	cScaleHighLimitPerCent = ScaleHighLimitPerCent
	ReInitialize
End Sub

Public Sub getScaleHighLimitPerCent As Double
	Return cScaleHighLimitPerCent
End Sub

'sets or gets the ScaleHighLimitColor property
'it must be an xui.Color
'Example: xGauge1.ScaleHighLimitColor = xui.Color_Red
Public Sub setScaleHighLimitColor(ScaleHighLimitColors As Int)
	Private cScaleHighLimitColors(1) As Int
	cScaleHighLimitColors(0) = ScaleHighLimitColors
	ReInitialize
End Sub

Public Sub getScaleHighLimitColor As Int
	Return cScaleHighLimitColors(0)
End Sub

'sets or gets the ScaleHighLimitColor property
'it must be an xui.Color
'Example: xGauge1.ScaleHighLimitColor = xui.Color_Red
Public Sub setScaleHighLimitColors(ScaleHighLimitColors() As Int)
	cScaleHighLimitColors = ScaleHighLimitColors
	ReInitialize
End Sub

Public Sub getScaleHighLimitColors As Int()
	Return cScaleHighLimitColors
End Sub

'sets or gets the ScaleMidLimitStartPerCent property
'it is drawn from the given start percent over the sweep percent
'given in percent of the scale
Public Sub setScaleMidLimitStartPerCent(ScaleMidLimitStartPerCent As Double)
	cScaleMidLimitStartPerCent = ScaleMidLimitStartPerCent
	ReInitialize
End Sub

Public Sub getScaleMidLimitStartPerCent As Double
	Return cScaleMidLimitStartPerCent
End Sub

'sets or gets the ScaleMidLimitSweepPerCent property
'it is drawn from the given start percent over the sweep percent
'given in percent of the scale
Public Sub setScaleMidLimitSweepPerCent(ScaleMidLimitSweepPerCent As Double)
	cScaleMidLimitSweepPerCent = ScaleMidLimitSweepPerCent
	ReInitialize
End Sub

Public Sub getScaleMidLimitSweepPerCent As Double
	Return cScaleMidLimitSweepPerCent
End Sub

'sets or gets the ScaleMidLimitColor property
'it must be an xui.Color
'Example: xGauge1.ScaleMidLimitColor = xui.Color_RGB(255, 165, 0)
Public Sub setScaleMidLimitColor(ScaleMidLimitColor As Int)
	Private cScaleMidLimitColors(1) As Int
	cScaleMidLimitColors(0) = ScaleMidLimitColor
	ReInitialize
End Sub

Public Sub getScaleMidLimitColor As Int
	Return cScaleMidLimitColors(0)
End Sub

'sets or gets the ScaleMidLimitColors property
'it must be an Array of xui.Colors
'Example: xGauge1.ScaleMidLimitColors = Array As Int (xui.Color_RGB(255, 165, 0), xui.Color_Red)
Public Sub setScaleMidLimitColors(ScaleMidLimitColors() As Int)
	cScaleMidLimitColors = ScaleMidLimitColors
	ReInitialize
End Sub

Public Sub getScaleMidLimitColors As Int()
	Return cScaleMidLimitColors
End Sub

'sets or gets the ScaleMidLimit2StartPerCent property
'it is drawn from the given start percent over the sweep percent
'given in percent of the scale
Public Sub setScaleMidLimit2StartPerCent(ScaleMidLimit2StartPerCent As Double)
	cScaleMidLimit2StartPerCent = ScaleMidLimit2StartPerCent
	ReInitialize
End Sub

Public Sub getScaleMidLimit2StartPerCent As Double
	Return cScaleMidLimit2StartPerCent
End Sub

'sets or gets the ScaleMidLimit2SweepPerCent2 property
'it is drawn from the given start percent over the sweep percent
'given in percent of the scale
Public Sub setScaleMidLimitSweep2PerCent(ScaleMidLimit2SweepPerCent As Double)
	cScaleMidLimit2SweepPerCent = ScaleMidLimit2SweepPerCent
	ReInitialize
End Sub

Public Sub getScaleMidLimit2SweepPerCent As Double
	Return cScaleMidLimit2SweepPerCent
End Sub

'sets or gets the ScaleMidLimit2Color property
'it must be an xui.Color
'Example: xGauge1.ScaleMidLimit2Color = xui.Color_RGB(255, 165, 0)
Public Sub setScaleMidLimit2Color(ScaleMidLimit2Color As Int)
	Private cScaleMidLimit2Colors(1) As Int
	cScaleMidLimit2Colors(0) = ScaleMidLimit2Color
	ReInitialize
End Sub

Public Sub getScaleMidLimit2Color As Int
	Return cScaleMidLimit2Colors(0)
End Sub

'sets or gets the ScaleMidLimit2Colors
'it must be an Array of xui.Colors
'Example: xGauge1.ScaleMidLimit2Color = Array As Int (xui.Color_RGB(255, 165, 0), xui.Color_Red)
Public Sub setScaleMidLimit2Colors(ScaleMidLimit2Colors() As Int)
	cScaleMidLimit2Colors = ScaleMidLimit2Colors
	ReInitialize
End Sub

Public Sub getScaleMidLimit2Colors As Int()
	Return cScaleMidLimit2Colors
End Sub

'sets or gets the NeedleBitmapFileName property
'enter 'no file' without the quotes to use the default needle
Public Sub setNeedleBitmapFileName(NeedleBitmapFileName As String)
	cNeedleBitmapFileName = NeedleBitmapFileName
	ReInitialize
End Sub

Public Sub getNeedleBitmapFileName As String
	Return cNeedleBitmapFileName
End Sub

'sets or gets the NeedleON property
'shows or hides the needle
'default value True
Public Sub setNeedleON(NeedleON As Boolean)
	cNeedleON = NeedleON
	pnlNeedle.Visible = cNeedleON
End Sub

Public Sub getNeedleON As Boolean
	Return cNeedleON
End Sub

'sets or gets the CustomScaleStartAngle
'Start angle for Custom scale angle gauge type.
'trigonometric angles 0 at 3 o'clock
'positive clockwise
Public Sub setCustomScaleStartAngle(CustomScaleStartAngle As Int)
	cCustomScaleStartAngle = CustomScaleStartAngle
	If cCustomScaleEndAngle - cCustomScaleStartAngle > cCustomScaleMaxAngle Then
		cCustomScaleEndAngle = cCustomScaleStartAngle + cCustomScaleMaxAngle
	Else If cCustomScaleEndAngle - cCustomScaleStartAngle < cCustomScaleMinAngle Then
		cCustomScaleEndAngle = cCustomScaleStartAngle + cCustomScaleMinAngle
	End If
	ReInitialize
End Sub

Public Sub getCustomScaleStartAngle As Int
	Return cCustomScaleStartAngle
End Sub

'sets or gets the CustomScaleEndAngle
'Start angle for Custom scale angle gauge type.
'trigonometric angles 0 at 3 o'clock
'positive clockwise
Public Sub setCustomScaleEndAngle(CustomScaleEndAngle As Int)
	cCustomScaleEndAngle = CustomScaleEndAngle
	If cCustomScaleEndAngle - cCustomScaleStartAngle > cCustomScaleMaxAngle Then
		cCustomScaleStartAngle = cCustomScaleEndAngle - cCustomScaleMaxAngle
	Else If cCustomScaleEndAngle - cCustomScaleStartAngle < cCustomScaleMinAngle Then
		cCustomScaleStartAngle = cCustomScaleEndAngle - cCustomScaleMinAngle
	End If
	ReInitialize
End Sub

Public Sub getCustomScaleEndAngle As Int
	Return cCustomScaleEndAngle
End Sub

'removes the xGauge from its parent view
Public Sub RemoveView
	mBase.RemoveViewFromParent
End Sub

'reinitializes the gauge
Public Sub ReInitialize
	If mBase.IsInitialized Then
		If pnlAction.IsInitialized Then
			mBase.RemoveAllViews
		End If
		InitHeight
		InitGauge
	End If
End Sub

Private Sub InitHeight
	cHeight = cWidth
	Select cGaugeType
		Case "180°"
			cHeight = 0.7 * cWidth
		Case "Custom scale angles"
			cStartAngle = cCustomScaleStartAngle
			cEndAngle = cCustomScaleEndAngle
			If cStartAngle >= -190 And cStartAngle < -90 And cEndAngle > -90 And cEndAngle <= 10 Then
				cHeight = 0.7 * cWidth
			End If
	End Select
End Sub

Public Sub BringToFront
	mBase.BringToFront
End Sub

Public Sub SendToBack
	mBase.SendToBack
End Sub

Private Sub pnlAction_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case pnlNeedle.TOUCH_ACTION_DOWN
			StartTime = DateTime.Now
		Case pnlNeedle.TOUCH_ACTION_UP
			If DateTime.Now - StartTime < 1000 Then
				If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
					CallSub(mCallBack, mEventName & "_Click")
				End If
			Else
				If xui.SubExists(mCallBack, mEventName & "_LongClick", 0) Then
					CallSub(mCallBack, mEventName & "_LongClick")
				End If
			End If
	End Select
End Sub

'Returns the base panel of the gauge as B4XView
Public Sub AsView As B4XView
	Return mBase
End Sub

