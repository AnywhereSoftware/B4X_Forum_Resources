B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
'xGaugesRect Custom View class
'This is an evolution of the xGauges CustumView with rectangular gauges
'
'Version 1.2 2024.07.03
'Added the Parent property, read only
'Amended problems with AddToParent and ReInitialize
'
'Version 1.1 2022.07.12
'Set the corner radius bigger than the border width when > 0
'
'Version 1.0 2021.08.18
'
'Written by Klaus CHRISTL (klaus)
'
#Event: Click
#Event: LongClick
#RaisesSynchronousEvents: Click
#RaisesSynchronousEvents: LongClick
'
#DesignerProperty: Key: GaugeType, DisplayName: GaugeType, FieldType: String, DefaultValue: Horizontal, List: Horizontal|Vertical, Description: Gauge type.
#DesignerProperty: Key: ValueMax, DisplayName: ValueMax, FieldType: Int, DefaultValue: 10, Description: max value of the scale.
#DesignerProperty: Key: ValueMin, DisplayName: ValueMin, FieldType: Int, DefaultValue: 0, Description: min value of the scale.
#DesignerProperty: Key: GaugeTitle, DisplayName: GaugeTitle, FieldType: String, DefaultValue: Fuel, Description: Title text of the gauge type.
#DesignerProperty: Key: GaugeUnit, DisplayName: GaugeUnit, FieldType: String, DefaultValue: , Description: Gauge unit.
#DesignerProperty: Key: NeedleBitmapFileName, DisplayName: NeedleBitmapFileName, FieldType: String, DefaultValue: no file, Description: File name of the needle bitmap the file must be in Files.DirAssets enter 'no file' without the quotes to use the default needle.
#DesignerProperty: Key: BackgroundColor, DisplayName: BackgroundColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: color of the background.
#DesignerProperty: Key: ScaleColor, DisplayName: ScaleColor, FieldType: Color, DefaultValue: 0xFF000000, Description: color of the scale.
#DesignerProperty: Key: BorderColor, DisplayName: BorderColor, FieldType: Color, DefaultValue: 0xFF808080, Description: border color.
#DesignerProperty: Key: BorderWidth, DisplayName: BorderWidth, FieldType: Int, DefaultValue: 2, Description: border width.
#DesignerProperty: Key: CornerRadius, DisplayName: CornerRadius, FieldType: Int, DefaultValue: 5, Description: corner radius; this value must be bigger than the border width.
#DesignerProperty: Key: NeedleShape, DisplayName: NeedleShape, FieldType: String, DefaultValue: Line, List: Line|Triangle|Arrow, Description: shape of the needle.
#DesignerProperty: Key: NeedleColor, DisplayName: NeedleColor, FieldType: Color, DefaultValue: 0xFFFF0000, Description: color of the needle.
#DesignerProperty: Key: NeedleWidth, DisplayName: NeedleWidth, FieldType: Int, DefaultValue: 2, List: 1|2|3|5, Description: width of the needle.
#DesignerProperty: Key: NeedleON, DisplayName: NeedleON, FieldType: Boolean, DefaultValue: True, Description: displays the neddle or not.
#DesignerProperty: Key: CursorON, DisplayName: CursorON, FieldType: Boolean, DefaultValue: False, Description: displays the first cursor or not.
#DesignerProperty: Key: CursorValue, DisplayName: CursorValue, FieldType: Int, DefaultValue: 5, Description: sets the first cursors value.
#DesignerProperty: Key: CursorColor, DisplayName: CursorColor, FieldType: Color, DefaultValue: 0xFF000000, Description: color of the firstcursor.
#DesignerProperty: Key: Cursor2ON, DisplayName: Cursor2ON, FieldType: Boolean, DefaultValue: False, Description: displays the second cursor or not.
#DesignerProperty: Key: Cursor2Value, DisplayName: Cursor2Value, FieldType: Int, DefaultValue: 5, Description: sets the second cursors value.
#DesignerProperty: Key: Cursor2Color, DisplayName: Cursor2Color, FieldType: Color, DefaultValue: 0xFF000000, Description: color of the second cursor.
#DesignerProperty: Key: MainTickNumber, DisplayName: MainTickNumber, FieldType: Int, DefaultValue: 11, Description: number of main ticks.
#DesignerProperty: Key: HalfTicks, DisplayName: HalfTicks, FieldType: Boolean, DefaultValue: True, Description: set also half ticks.
#DesignerProperty: Key: SmallTicksNumber, DisplayName: SmallTicksNumber, FieldType: Int, DefaultValue: 0, Description: set also x small ticks between two main ticks.
#DesignerProperty: Key: TickText, DisplayName: TickText, FieldType: String, DefaultValue: 0|1|2|3|4|5|6|7|8|9|10, Description: Text for the main ticks.
#DesignerProperty: Key: ScaleLowLimitPerCent, DisplayName: ScaleLowLimitPerCent, FieldType: Int, DefaultValue: 0, Description: per cent of the scale low limit.
#DesignerProperty: Key: ScaleLowLimitColor, DisplayName: ScaleLowLimitColor, FieldType: Color, DefaultValue: 0xFF32CD32, Description: color of the scale low limit.
#DesignerProperty: Key: ScaleHighLimitPerCent, DisplayName: ScaleHighLimitPerCent, FieldType: Int, DefaultValue: 0, Description: per cent of the scale high limit.
#DesignerProperty: Key: ScaleHighLimitColor, DisplayName: ScaleHighLimitColor, FieldType: Color, DefaultValue: 0xFFFF0000, Description: color of the scale high limit.
#DesignerProperty: Key: ScaleMidLimitStartPerCent, DisplayName: ScaleMidLimitStartPerCent, FieldType: Int, DefaultValue: 0, Description: start per cent of the scale mid limit.
#DesignerProperty: Key: ScaleMidLimitSweepPerCent, DisplayName: ScaleMidLimitSweepPerCent, FieldType: Int, DefaultValue: 0, Description: sweep per cent of the scale mid limit.
#DesignerProperty: Key: ScaleMidLimitColor, DisplayName: ScaleMidLimitColor, FieldType: Color, DefaultValue: 0xFFFFA500, Description: color of the scale mid limit.
#DesignerProperty: Key: ScaleMidLimit2StartPerCent, DisplayName: ScaleMidLimit2StartPerCent, FieldType: Int, DefaultValue: 0, Description: start per cent of the second scale mid limit.
#DesignerProperty: Key: ScaleMidLimit2SweepPerCent, DisplayName: ScaleMidLimit2SweepPerCent, FieldType: Int, DefaultValue: 0, Description: sweep per cent of the second scale mid limit.
#DesignerProperty: Key: ScaleMidLimit2Color, DisplayName: ScaleMidLimit2Color, FieldType: Color, DefaultValue: 0xFFFFA500, Description: color of the second scale mid limit.

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI
	Public Tag As Object
	Public mBase As B4XView

	Private pnlAction As B4XView
	Private pnlNeedle As B4XView
	Private cvsGauge, cvsNeedle, cvsAction As B4XCanvas
	Private rectGauge, rectNeedle As B4XRect
	Private cParent As B4XView
	
	Private cLeft, cTop, cWidth, cHeight As Int
	Private cMainTickNumber As Int
	Private cHalfTicks As Boolean
	Private cValue, cValueMin, cValueMax As Double
	Private cScaleLowLimitPerCent, cScaleHighLimitPerCent, cScaleMidLimitStartPerCent, cScaleMidLimitSweepPerCent, cScaleMidLimit2StartPerCent, cScaleMidLimit2SweepPerCent As Double
	Private cBackgroundColor, cScaleColor, cNeedleColor, cScaleLowLimitColors(1), cScaleHighLimitColors(1), cScaleMidLimitColors(1), cScaleMidLimit2Colors(1) As Int
	Private cBorderColor, cBorderWidth, cCornerRadius As Int
	Private cGaugeTitleTextSize, cGaugeUnitTextSize, cScaleTextSize As Float
	Private cGaugeType, cGaugeTitle, cGaugeUnit As String
	Private bmpBackGround As B4XBitmap
	Private cTickText As String
	Private cNeedleWidth, NeedleHeight, ScaleStroke, ScaleHalfStroke, ScaleSmallStroke As Int
	Private cSmallTicksNumber As Int
	Private cNeedleBitmapFileName As String
	Private cNeedleShape As String
	Private pthNeedle As B4XPath
	Private cNeedleON As Boolean
	Private StartTime As Long
	Private RMainTickSpace, RSmallTickSpace As Int
	Private ScaleBegin, ScaleLength, ScaleEnd As Int
	Private TickBegin, TickLengthMain, TickEndMain, TickEndHalf, TickEndSmall As Int
	Private NeedleLeft, NeedleTop, NeedleHalfWidth,NeedleHeight As Int
	Private cCursorOn(2) As Boolean
	Private CursorMove = False As Boolean
	Private cCursorPosition(2), cCursorColor(2) As Int
	Private cCursorValue(2) As Double
	Private cCurrentCursorIndex As Int
	Private pthCursor As B4XPath
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
	cGaugeType = "Horizontal"
	cGaugeTitle = "Speed"
	cGaugeUnit = ""
	cTickText = "0|2|4|6|8|10"
	cMainTickNumber = 11
	cHalfTicks = True
	cSmallTicksNumber = 0
	cBackgroundColor = xui.Color_White
	cBorderColor = xui.Color_Gray	'?????????
	cBorderWidth = 2dip
	cCornerRadius = 5dip
	cScaleColor = xui.Color_Black
	cNeedleShape = "Line"
	cNeedleWidth = 2dip
	cNeedleColor  = xui.Color_Gray
	cNeedleBitmapFileName = "no file"
	cNeedleON = True
	cScaleLowLimitPerCent = 0
	cScaleLowLimitColors(0) = xui.Color_RGB(50, 205, 50)
	cScaleHighLimitPerCent = 0
	cScaleHighLimitColors(0) = xui.Color_Red
	cScaleMidLimitStartPerCent = 0
	cScaleMidLimitSweepPerCent = 0
	cScaleMidLimit2Colors(0) = xui.Color_RGB(255, 165, 0)
	cCursorOn(0) = False
	cCursorOn(1) = False
	cCursorValue(0) = 5
	cCursorValue(1) = 5
	cCursorColor(0) = 0xFF000000
	cCursorColor(1) = 0xFF000000
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	cLeft = mBase.Left
	cTop = mBase.Top
	cWidth = mBase.Width
	cHeight = mBase.Height
	
	cParent = mBase.Parent
	
	cGaugeType = Props.GetDefault("GaugeType", "90° Top")
	cNeedleBitmapFileName = Props.Get("NeedleBitmapFileName")
	cValueMin = Props.Get("ValueMin")
	cValueMax = Props.Get("ValueMax")
	cGaugeTitle = Props.Get("GaugeTitle")
	cGaugeUnit = Props.Get("GaugeUnit")
	cTickText = Props.Get("TickText")
	cMainTickNumber = Props.Get("MainTickNumber")
	cHalfTicks = Props.Get("HalfTicks")
	cSmallTicksNumber = Props.Get("SmallTicksNumber")
	cBackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	cBorderColor = xui.PaintOrColorToColor(Props.Get("BorderColor"))
	cBorderWidth = DipToCurrent(Props.GetDefault("BorderWidth", 2))
	cCornerRadius = DipToCurrent(Props.GetDefault("CornerRadius", 5))
	If cCornerRadius > 0 And cCornerRadius < cBorderWidth + 1 Then
		cCornerRadius = cBorderWidth + 1
	End If
	cScaleColor = xui.PaintOrColorToColor(Props.Get("ScaleColor"))
	cNeedleShape = Props.GetDefault("NeedleShape", "Line")
	cNeedleWidth = DipToCurrent(Props.GetDefault("NeedleWidth", 2dip))
	cNeedleColor = xui.PaintOrColorToColor(Props.Get("NeedleColor"))
	cNeedleON = Props.Get("NeedleON")
	cScaleLowLimitPerCent = Props.Get("ScaleLowLimitPerCent")
	cScaleLowLimitColors(0) =  xui.PaintOrColorToColor(Props.Get("ScaleLowLimitColor"))
	cScaleHighLimitPerCent = Props.Get("ScaleHighLimitPerCent")
	cScaleHighLimitColors(0) =  xui.PaintOrColorToColor(Props.Get("ScaleHighLimitColor"))
	cScaleMidLimitStartPerCent = Props.Get("ScaleMidLimitStartPerCent")
	cScaleMidLimitSweepPerCent = Props.Get("ScaleMidLimitSweepPerCent")
	cScaleMidLimitColors(0) = xui.PaintOrColorToColor(Props.Get("ScaleMidLimitColor"))
	cScaleMidLimit2StartPerCent = Props.GetDefault("ScaleMidLimit2StartPerCent", 0)
	cScaleMidLimit2SweepPerCent = Props.GetDefault("ScaleMidLimit2SweepPerCent", 0)
	cScaleMidLimit2Colors(0) = xui.PaintOrColorToColor(Props.GetDefault("ScaleMidLimit2Color", 0xFFFFA500))
	cCursorOn(0) = Props.GetDefault("CursorON", False)
	cCursorValue(0) = Props.GetDefault("CursorValue", 5)
	cCursorColor(0) = xui.PaintOrColorToColor(Props.GetDefault("CursorColor", 0xFF000000))
	cCursorOn(1) = Props.GetDefault("Cursor2ON", False)
	cCursorValue(1) = Props.GetDefault("Cursor2Value", 5)
	cCursorColor(1) = xui.PaintOrColorToColor(Props.GetDefault("Cursor2Color", 0xFF000000))
	mBase.Height = cHeight
	
#If B4A
	InitGauge
#End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cWidth = Width
	cHeight = Height
	ReInitialize
End Sub

'adds the xGauge to the Parent view.
'the parent object can be a B4XView or
'an Activity or a Panel in B4A, a Panel in B4i or a Pane in B4J
'there is no Height property, because the Height = Width 
Public Sub AddToParent(Parent As Object, Left As Int, Top As Int, Width As Int, Height As Int)
	cLeft = Left
	cTop = Top
	cWidth = Width
	cHeight = Height
	
	cParent = Parent
	
	mBase = xui.CreatePanel("")
	cParent.AddView(mBase, cLeft, cTop, cWidth, cHeight)
	mBase.Tag = Me
	
	InitGauge
End Sub

Private Sub InitGauge
	cvsGauge.Initialize(mBase)
	
	pnlAction = xui.CreatePanel("pnlAction")
	mBase.AddView(pnlAction, 0, 0, mBase.Width, mBase.Height)
	
	Select cGaugeType
		Case "Horizontal"
			cGaugeTitleTextSize = 0.25 * cHeight / xui.Scale
			cGaugeUnitTextSize = 0.2 * cHeight / xui.Scale
			cScaleTextSize = 0.22 * cHeight / xui.Scale
		Case "Vertical"
			cGaugeTitleTextSize = 0.22 * cWidth / xui.Scale
			cGaugeUnitTextSize = 0.2 * cWidth / xui.Scale
			cScaleTextSize = 0.18 * cWidth / xui.Scale
	End Select
	
	rectGauge.Initialize(0, 0, cWidth, cHeight)
	
	pnlNeedle = xui.CreatePanel("")
	
	Select cGaugeType
		Case "Horizontal"
			mBase.AddView(pnlNeedle, 0, 0, cWidth, cHeight)
			rectNeedle.Initialize(0, 0, cWidth, cHeight)
		Case "Vertical"
			mBase.AddView(pnlNeedle, 0, 0, cWidth, cHeight)
			rectNeedle.Initialize(0, 0, cWidth, cHeight)
	End Select
	
	cvsNeedle.Initialize(pnlNeedle)
	cvsAction.Initialize(pnlAction)
	ScaleStroke = 2dip
	ScaleHalfStroke = 1dip
	ScaleSmallStroke = 1dip
	pnlAction.BringToFront
	
	DrawGauge
End Sub

Private Sub DrawGauge
	InitScale
	DrawScale
	DrawNeedle
	For i = 0 To cCursorOn.Length - 1
		DrawCursors
	Next
End Sub

Private Sub InitScale
	Select cGaugeType
		Case "Horizontal"
			RSmallTickSpace = Floor((cWidth - 0.5 * cHeight) / ((cMainTickNumber - 1) * cSmallTicksNumber))' * ((cMainTickNumber - 1) * cSmallTicksNumber)
			RMainTickSpace = RSmallTickSpace * cSmallTicksNumber
			RMainTickSpace = Floor((cWidth - 0.5 * cHeight) / (cMainTickNumber - 1))
			ScaleLength = RMainTickSpace * (cMainTickNumber - 1)
			ScaleBegin = (cWidth - ScaleLength) / 2
			ScaleEnd = ScaleBegin + ScaleLength
			TickBegin = 0.4 * cHeight
			TickLengthMain = 0.3 * cHeight
			TickEndMain = TickBegin + TickLengthMain
			TickEndHalf = TickBegin + 0.8 * TickLengthMain
			TickEndSmall = TickBegin + 0.5 * TickLengthMain
			rectGauge.Initialize(0, 0, cWidth, cHeight)
			bmpBackGround = GetBackground(80, "LEFT_RIGHT", cBackgroundColor, rectGauge)
		Case "Vertical"
			RSmallTickSpace = Floor((cHeight - 0.5 * cWidth) / ((cMainTickNumber - 1) * cSmallTicksNumber))
			RMainTickSpace = RSmallTickSpace * cSmallTicksNumber
			RMainTickSpace = Floor((cHeight - 0.5 * cWidth) / (cMainTickNumber - 1))
			ScaleLength = RMainTickSpace * (cMainTickNumber - 1)
			ScaleBegin = (cHeight - ScaleLength) / 2
			ScaleEnd = ScaleBegin + ScaleLength
			TickBegin = 0.35 * cWidth
			TickLengthMain = 0.3 * cWidth
			TickEndMain = TickBegin + TickLengthMain
			TickEndHalf = TickBegin + 0.8 * TickLengthMain
			TickEndSmall = TickBegin + 0.5 * TickLengthMain
			bmpBackGround = GetBackground(80, "TOP_BOTTOM", cBackgroundColor, rectGauge)
	End Select
	
	Private pth As B4XPath
	pth.InitializeRoundedRect(rectGauge, cCornerRadius)
	cvsGauge.ClearRect(rectGauge)
	cvsGauge.ClipPath(pth)
	cvsGauge.DrawRect(rectGauge, cBackgroundColor, True, 1)
	cvsGauge.DrawBitmap(bmpBackGround, rectGauge)
	cvsGauge.RemoveClip
	
	Private i As Int
	For i = 0 To cCursorOn.Length - 1
		If cCursorOn(i) Then
			Select cGaugeType
				Case "Horizontal"
			cCursorPosition(i) = ScaleBegin + (cCursorValue(i) - cValueMin) * ScaleLength / (cValueMax - cValueMin)
				Case "Vertical"
					cCursorPosition(i) = ScaleEnd - (cCursorValue(i) - cValueMin) * ScaleLength / (cValueMax - cValueMin)
			End Select
		End If
	Next
End Sub

Private Sub DrawScale
	Select cGaugeType
		Case "Horizontal"
			DrawScaleH
		Case "Vertical"
			DrawScaleV
	End Select
End Sub

Private Sub DrawScaleH
	Private x, x0 As Int
	Private txt As String
	
	txt = cGaugeTitle & "  " & cGaugeUnit
	cvsGauge.DrawText(txt, cWidth / 2, 0.28 * cHeight, xui.CreateDefaultBoldFont(cGaugeTitleTextSize), cScaleColor, "CENTER")
	
	If cScaleLowLimitPerCent > 0 Or cScaleMidLimitStartPerCent > 0 Or cScaleMidLimit2StartPerCent > 0 Or cScaleHighLimitPerCent > 0 Then
		Private rct As B4XRect
		Private bmc As BitmapCreator
		
		If cScaleLowLimitPerCent > 0 Then
			rct.Initialize(ScaleBegin, TickBegin, ScaleBegin + cScaleLowLimitPerCent * ScaleLength / 100, TickBegin + 0.5 * TickLengthMain)
			If cScaleLowLimitColors.Length = 1 Then
				cvsGauge.DrawRect(rct, cScaleLowLimitColors(0), True , 1)
			Else
				bmc.Initialize(rct.Width, rct.Height)
				bmc.FillGradient(cScaleLowLimitColors, bmc.TargetRect, "LEFT_RIGHT")
				cvsGauge.DrawBitmap(bmc.Bitmap, rct)
			End If
		End If
	
		If cScaleMidLimitStartPerCent > 0 Then
			x = ScaleBegin + cScaleMidLimitStartPerCent * ScaleLength / 100
			rct.Initialize(x, TickBegin, x + cScaleMidLimitSweepPerCent * ScaleLength / 100, TickBegin + 0.5 * TickLengthMain)
			If cScaleMidLimitColors.Length = 1 Then
				cvsGauge.DrawRect(rct, cScaleMidLimitColors(0), True , 1)
			Else
				bmc.Initialize(rct.Width, rct.Height)
				bmc.FillGradient(cScaleMidLimitColors, bmc.TargetRect, "LEFT_RIGHT")
				cvsGauge.DrawBitmap(bmc.Bitmap, rct)
			End If
		End If
	
		If cScaleMidLimit2StartPerCent > 0 Then
			x = ScaleBegin + cScaleMidLimit2StartPerCent * ScaleLength / 100
			rct.Initialize(x, TickBegin, x + cScaleMidLimit2SweepPerCent * ScaleLength / 100, TickBegin + 0.5 * TickLengthMain)
			If cScaleMidLimit2Colors.Length = 1 Then
				cvsGauge.DrawRect(rct, cScaleMidLimit2Colors(0), True , 1)
			Else
				bmc.Initialize(rct.Width, rct.Height)
				bmc.FillGradient(cScaleMidLimit2Colors, bmc.TargetRect, "LEFT_RIGHT")
				cvsGauge.DrawBitmap(bmc.Bitmap, rct)
			End If
		End If
	
		If cScaleHighLimitPerCent > 0 Then
			rct.Initialize(ScaleBegin + (1 - cScaleHighLimitPerCent / 100) * ScaleLength, TickBegin, ScaleBegin + ScaleLength, TickBegin + 0.5 * TickLengthMain)
			If cScaleHighLimitColors.Length = 1 Then
				cvsGauge.DrawRect(rct, cScaleHighLimitColors(0), True , 1)
			Else
				bmc.Initialize(rct.Width, rct.Height)
				bmc.FillGradient(cScaleHighLimitColors, bmc.TargetRect, "LEFT_RIGHT")
				cvsGauge.DrawBitmap(bmc.Bitmap, rct)
			End If
		End If
	End If
	
	For i = 0 To cMainTickNumber - 1
		x0 = Floor(ScaleBegin + i * RMainTickSpace)
		cvsGauge.DrawLine(x0, TickBegin, x0, TickEndMain, cScaleColor, ScaleStroke)
		If i < cMainTickNumber - 1 Then
			For j = 1 To cSmallTicksNumber - 1
				x = Floor(x0 + j * RMainTickSpace / cSmallTicksNumber)
				cvsGauge.DrawLine(x, TickBegin, x, TickEndSmall, cScaleColor, ScaleSmallStroke)
			Next
		End If
	Next
	
	Private TickTexts() As String
	Private Space As Int
	TickTexts = Regex.Split("\|", cTickText)
	Space = ScaleLength / (TickTexts.Length - 1)
	For i = 0 To TickTexts.Length - 1
		x0 = Floor(ScaleBegin + i * Space)
		cvsGauge.DrawText(TickTexts(i), x0, 0.9 * cHeight, xui.CreateDefaultBoldFont(cScaleTextSize), cScaleColor, "CENTER")
	Next
	
	If cHalfTicks = True Then
		For i = 0 To cMainTickNumber - 2
			x = ScaleBegin + (i + 0.5) * RMainTickSpace
			cvsGauge.DrawLine(x, TickBegin, x, TickEndHalf, cScaleColor, ScaleHalfStroke)
		Next
	End If
End Sub

Private Sub DrawScaleV
	Private y, y0 As Int
	
#If B4i
	Private txt(cGaugeTitle.Length) As String
	For i = 0 To cGaugeTitle.Length - 1
		txt(i) = cGaugeTitle.CharAt(i)
	Next
#Else
	Private txt() As String
	txt = Regex.Split("", cGaugeTitle)
#End If

	Private ty0, tx, ty, th, tdy As Float
	Private tr1, tr2 As B4XRect
	tr1 = cvsGauge.MeasureText("Ag", xui.CreateDefaultBoldFont(cGaugeTitleTextSize))
'	tx = 0.15 * cWidth
	tx = (TickBegin - cBorderWidth) / 2
	th = tr1.Height
	ty0 = cHeight / 2 - txt.Length / 2 * th  + (tr1.Height / 2 - tr1.Top)
	If cGaugeUnit <> "" Then
		ty0 = ty0 - 1.5 * th
	End If
	For i = 0 To txt.Length - 1
		ty = ty0 + i * th
		cvsGauge.DrawText(txt(i), tx, ty, xui.CreateDefaultBoldFont(cGaugeTitleTextSize), cScaleColor, "CENTER")
	Next
	ty = ty0 + i * th
	cvsGauge.DrawText(" ", tx, ty, xui.CreateDefaultBoldFont(cGaugeTitleTextSize), cScaleColor, "CENTER")
	ty = ty0 + (i + 1) * th
	
	Private w, tw As Int	'available with
	Private ts As Float	'text size
	tr1 = cvsGauge.MeasureText(cGaugeUnit, xui.CreateDefaultBoldFont(cGaugeUnitTextSize))
	tr2 = cvsGauge.MeasureText(cGaugeUnit, xui.CreateDefaultBoldFont(cGaugeUnitTextSize))
	tw = Max(tr1.Width, tr2.Width)
	w = TickBegin - cBorderWidth - 4dip
	If tw > w Then
		ts = cGaugeUnitTextSize / tw * w
	Else
		ts = cGaugeUnitTextSize
	End If
	cvsGauge.DrawText(cGaugeUnit, tx, ty, xui.CreateDefaultBoldFont(ts), cScaleColor, "CENTER")
	
	If cScaleLowLimitPerCent > 0 Or cScaleMidLimitStartPerCent > 0 Or cScaleMidLimit2StartPerCent > 0 Or cScaleHighLimitPerCent > 0 Then
		Private rct As B4XRect
		Private bmc As BitmapCreator

		If cScaleLowLimitPerCent > 0 Then
			rct.Initialize(TickBegin, ScaleEnd - cScaleLowLimitPerCent * ScaleLength / 100, TickBegin + 0.5 * TickLengthMain, ScaleEnd)
			If cScaleLowLimitColors.Length = 1 Then
				cvsGauge.DrawRect(rct, cScaleLowLimitColors(0), True , 1)
			Else
				bmc.Initialize(rct.Width, rct.Height)
				bmc.FillGradient(cScaleLowLimitColors, bmc.TargetRect, "BOTTOM_TOP")
				cvsGauge.DrawBitmap(bmc.Bitmap, rct)
			End If
		End If
	
		If cScaleMidLimitStartPerCent > 0 Then
			Private y  As Int
			y = ScaleEnd - cScaleMidLimitStartPerCent * ScaleLength / 100
			rct.Initialize(TickBegin, y - cScaleMidLimitSweepPerCent * ScaleLength / 100, TickBegin + 0.5 * TickLengthMain, y)
			If cScaleMidLimitColors.Length = 1 Then
				cvsGauge.DrawRect(rct, cScaleMidLimitColors(0), True , 1)
			Else
				bmc.Initialize(rct.Width, rct.Height)
				bmc.FillGradient(cScaleMidLimitColors, bmc.TargetRect, "BOTTOM_TOP")
				cvsGauge.DrawBitmap(bmc.Bitmap, rct)
			End If
		End If
	
		If cScaleMidLimit2StartPerCent > 0 Then
			Private y  As Int
			y = ScaleEnd - cScaleMidLimit2StartPerCent * ScaleLength / 100
			rct.Initialize(TickBegin, y - cScaleMidLimit2SweepPerCent * ScaleLength / 100, TickBegin + 0.5 * TickLengthMain, y)
			If cScaleMidLimit2Colors.Length = 1 Then
				cvsGauge.DrawRect(rct, cScaleMidLimit2Colors(0), True , 1)
			Else
				bmc.Initialize(rct.Width, rct.Height)
				bmc.FillGradient(cScaleMidLimit2Colors, bmc.TargetRect, "BOTTOM_TOP")
				cvsGauge.DrawBitmap(bmc.Bitmap, rct)
			End If
		End If
	
		If cScaleHighLimitPerCent > 0 Then
			rct.Initialize(TickBegin, ScaleBegin, TickBegin + 0.5 * TickLengthMain, ScaleBegin + cScaleHighLimitPerCent * ScaleLength / 100)
			If cScaleHighLimitColors.Length = 1 Then
				cvsGauge.DrawRect(rct, cScaleHighLimitColors(0), True , 1)
			Else
				bmc.Initialize(rct.Width, rct.Height)
				bmc.FillGradient(cScaleHighLimitColors, bmc.TargetRect, "BOTTOM_TOP")
				cvsGauge.DrawBitmap(bmc.Bitmap, rct)
			End If
		End If
	End If
	
	For i = 0 To cMainTickNumber - 1
		y0 = Floor(ScaleEnd - i * RMainTickSpace)
		cvsGauge.DrawLine(TickBegin, y0, TickEndMain, y0, cScaleColor, ScaleStroke)
		If i < cMainTickNumber - 1 Then
			For j = 1 To cSmallTicksNumber - 1
				y = Floor(y0 - j * RMainTickSpace / cSmallTicksNumber)
				cvsGauge.DrawLine(TickBegin, y, TickEndSmall, y, cScaleColor, ScaleSmallStroke)
			Next
		End If
	Next
	
	tr1 = cvsGauge.MeasureText("Ag", xui.CreateDefaultBoldFont(cScaleTextSize))
	tdy = tr1.Bottom * 1.2
	Private TickTexts() As String
	Private Space As Int
	TickTexts = Regex.Split("\|", cTickText)
	Private w As Int	'available with
	Private ts As Float	'text size
	tr1 = cvsGauge.MeasureText(cGaugeUnit, xui.CreateDefaultBoldFont(cScaleTextSize))
	w = cWidth - cBorderWidth - TickEndMain - 4dip
	If tr1.Width > w Then
		ts = cScaleTextSize / tr1.Width * w
	Else
		ts = cScaleTextSize
	End If
	Space = ScaleLength / (TickTexts.Length - 1)
	For i = 0 To TickTexts.Length - 1
		y0 = Floor(ScaleEnd - i * Space)
		cvsGauge.DrawText(TickTexts(i), TickEndMain + 2dip, y0 + tdy, xui.CreateDefaultBoldFont(ts), cScaleColor, "LEFT")
	Next
	
	If cHalfTicks = True Then
		For i = 0 To cMainTickNumber - 2
			y = ScaleBegin + (i + 0.5) * RMainTickSpace
			cvsGauge.DrawLine(TickBegin, y, TickEndHalf, y, cScaleColor, ScaleHalfStroke)
		Next
	End If
End Sub

Private Sub DrawNeedle
	Select cGaugeType
		Case "Horizontal"
			DrawNeedleH
		Case "Vertical"
			DrawNeedleV
	End Select
End Sub

Private Sub DrawNeedleH
	Private x As Int
	
	If cNeedleON = False Then 
		Return
	End If
	
	NeedleTop = 0.05 * cHeight
	NeedleHalfWidth = cNeedleWidth
	NeedleHeight = 0.5 * cHeight
	
	cvsNeedle.ClearRect(rectNeedle)
	
	x = ScaleBegin + (cValue - cValueMin) * ScaleLength / (cValueMax - cValueMin)
	Select cNeedleShape
		Case "Line"
			NeedleHeight = 0.6 * cHeight
			cvsNeedle.DrawLine(x, NeedleTop, x, NeedleTop + NeedleHeight, cNeedleColor, 2dip)
		Case "Triangle"
			pthNeedle.Initialize(x - NeedleHalfWidth, NeedleTop)
			pthNeedle.LineTo(x + NeedleHalfWidth, NeedleTop)
			pthNeedle.LineTo(x, NeedleTop + NeedleHeight)
			pthNeedle.LineTo(x - NeedleHalfWidth, NeedleTop)
			cvsNeedle.DrawPath(pthNeedle, cNeedleColor, True, 1dip)
		Case "Arrow"
			pthNeedle.Initialize(x - NeedleHalfWidth, NeedleTop)
			pthNeedle.LineTo(x + NeedleHalfWidth, NeedleTop)
			pthNeedle.LineTo(x + NeedleHalfWidth, NeedleTop + NeedleHeight - NeedleHalfWidth)
			pthNeedle.LineTo(x, NeedleTop + NeedleHeight)
			pthNeedle.LineTo(x - NeedleHalfWidth, NeedleTop + NeedleHeight - NeedleHalfWidth)
			pthNeedle.LineTo(x - NeedleHalfWidth, NeedleTop)
			cvsNeedle.DrawPath(pthNeedle, cNeedleColor, True, 1dip)
	End Select

	cvsNeedle.Invalidate
End Sub

Private Sub DrawNeedleV
	Private y As Int
	
	If cNeedleON = False Then
		Return
	End If	

	NeedleLeft = 0.05 * cWidth
	NeedleHalfWidth = cNeedleWidth / 2
	NeedleHeight = 0.5 * cWidth
	y = ScaleEnd - (cValue - cValueMin) * ScaleLength / (cValueMax - cValueMin)
	cvsNeedle.ClearRect(rectNeedle)
	
	Select cNeedleShape
		Case "Line"
			NeedleHeight = 0.6 * cHeight
			cvsNeedle.DrawLine(NeedleLeft, y, NeedleLeft + cNeedleWidth, y, cNeedleColor, cNeedleWidth)
		Case "Triangle"
			pthNeedle.Initialize(NeedleLeft, y - NeedleHalfWidth)
			pthNeedle.LineTo(NeedleLeft, y + NeedleHalfWidth)
			pthNeedle.LineTo(NeedleLeft + NeedleHeight, y)
			pthNeedle.LineTo(NeedleLeft, y - NeedleHalfWidth)
			cvsNeedle.DrawPath(pthNeedle, cNeedleColor, True, 1dip)
		Case "Arrow"
			pthNeedle.Initialize(NeedleLeft, y - NeedleHalfWidth)
			pthNeedle.LineTo(NeedleLeft, y + NeedleHalfWidth)
			pthNeedle.LineTo(NeedleLeft + NeedleHeight - NeedleHalfWidth, y + NeedleHalfWidth)
			pthNeedle.LineTo(NeedleLeft + NeedleHeight, y)
			pthNeedle.LineTo(NeedleLeft + NeedleHeight - NeedleHalfWidth,y - NeedleHalfWidth)
			pthNeedle.LineTo(NeedleLeft, y - NeedleHalfWidth)
			cvsNeedle.DrawPath(pthNeedle, cNeedleColor, True, 1dip)
	End Select
	
	cvsNeedle.Invalidate
End Sub

Private Sub DrawCursors
	Select cGaugeType
		Case "Horizontal"
			DrawCursorsH
		Case "Vertical"
			DrawCursorsV
	End Select
End Sub

Private Sub DrawCursorsH
	Private i, x As Int
	Private C2W, CB, CT As Int
	
	cvsAction.ClearRect(cvsAction.TargetRect)
	
	For i = 0 To cCursorOn.Length - 1
	If cCursorOn(i) = True Then
		x = ScaleBegin + (cCursorValue(i) - cValueMin) * ScaleLength / (cValueMax - cValueMin)

		C2W = 6dip
		CT = TickEndSmall - 2dip
		CB = TickEndMain
		pthCursor.Initialize(x, CT)
		pthCursor.LineTo(x + C2W, CB)
		pthCursor.LineTo(x - C2W, CB)
		pthCursor.LineTo(x, CT)
		cvsAction.DrawPath(pthCursor, cCursorColor(i), True, 1)
		End If
	Next
	cvsAction.Invalidate
End Sub

Private Sub DrawCursorsV
	Private i, y As Int
	Private C2W, CB, CT As Int
	
	cvsAction.ClearRect(cvsAction.TargetRect)
	
	For i = 0 To cCursorOn.Length - 1
		If cCursorOn(i) = True Then
			y = ScaleEnd - (cCursorValue(i) - cValueMin) * ScaleLength / (cValueMax - cValueMin)

			C2W = 6dip
			CT = TickEndSmall - 2dip
			CB = TickEndMain
		
			pthCursor.Initialize(CT, y)
			pthCursor.LineTo(CB, y + C2W)
			pthCursor.LineTo(CB, y - C2W)
			pthCursor.LineTo(CT, y)
			cvsAction.DrawPath(pthCursor, cCursorColor(i), True, 1)
		End If
	Next
	cvsAction.Invalidate
End Sub

'sets or gets GaugeType property
'possible values 90° Top, 180°, 270°, 90° Left, Custom scale angles
'for Custom scale angles you can set the start and the end angle
Public Sub setGaugeType(GaugeType As String)
	If GaugeType <> "Horizontal" And GaugeType <> "Vertical" Then
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
	Select cGaugeType
		Case "Horizontal"
			DrawNeedleH
		Case "Vertical"
			DrawNeedleV
	End Select
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
		Select cGaugeType
			Case "Horizontal"
				DrawScaleH
			Case "Vertical"
				DrawScaleV
		End Select
	End If
End Sub

Public Sub getScaleColor As Int
	Return cScaleColor
End Sub

'sets or gets the NeedleColor
'it must be an xui.Color
'Example: xGauge1.NeedleColor = xui.Color_Gray
Public Sub setNeedleColor(NeedleColor As Int)
	cNeedleColor = NeedleColor
	ReInitialize
End Sub

Public Sub getNeedleColor As Int
	Return cNeedleColor
End Sub

'sets or gets GaugeTitle property
Public Sub setGaugeTitle(GaugeTitle As String)
	cGaugeTitle = GaugeTitle
	If mBase.IsInitialized Then
		DrawGauge
	End If
End Sub

Public Sub getGaugeTitle As String
	Return cGaugeTitle
End Sub

'sets or gets GaugeUnit property
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
Public Sub setWidth(Width As Double)
	cWidth = Width
	ReInitialize
End Sub

Public Sub getWidth As Double
	Return cWidth
End Sub

'sets or gets the height of the gauge
Public Sub setHeight(Height As Double)
	If cGaugeType.SubString2(0, 4) = "Rect" Then
		cHeight = Height
		ReInitialize
	End If
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

'sets or gets the ScaleLowLimitColor
'it must be an xui.Color
'Example: xGauge1.NeedleColor = xui.Color_RGB(526, 165, 0)
Public Sub setScaleLowLimitColor(ScaleLowLimitColor As Int)
	Private cScaleLowLimitColors(1) As Int
	cScaleLowLimitColors(0) = ScaleLowLimitColor
	ReInitialize
End Sub

Public Sub getScaleLowLimitColor As Int
	Return cScaleLowLimitColors(0)
End Sub

'sets or gets the ScaleLowLimitColors
'it must be an Array of xui.Colors
'Example: xGauge1.ScaleLowLimitColors = Array As Int(xui.Color_RGB(526, 165, 0), xui.Color_Red)
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

'sets or gets the ScaleHighLimitColor
'it must be an xui.Color
'Example: xGauge1.ScaleHighLimitColor = xui.Color_Red
Public Sub setScaleHighLimitColor(ScaleHighLimitColor As Int)
	Private cScaleHighLimitColors(1) As Int
	cScaleHighLimitColors(0) = ScaleHighLimitColor
	ReInitialize
End Sub

Public Sub getScaleHighLimitColor As Int
	Return cScaleHighLimitColors(0)
End Sub

'sets or gets the ScaleHighLimitColors
'it must be an Array of xui.Colors
'Example: xGauge1.ScaleHighLimitColor = Array As Int(xui.Color_Yellow, xui.Color_Red)
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

'sets or gets the ScaleMidLimitColor
'it must be an xui.Color
'Example: xGauge1.ScaleMidLimitColor = xui.Color_RGB(526, 165, 0)
Public Sub setScaleMidLimitColor(ScaleMidLimitColor As Int)
	Private cScaleMidLimitColors(1) As Int
	cScaleMidLimitColors(0) = ScaleMidLimitColor
	ReInitialize
End Sub

Public Sub getScaleMidLimitColor As Int
	Return cScaleMidLimitColors(0)
End Sub

'sets or gets the ScaleMidLimitColors
'it must be an Array of xui.Colors
'Example: xGauge1.ScaleMidLimitColors = Array As Int(xui.Color_RGB(526, 165, 0), xui.Color_Red)
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

'sets or gets the ScaleMidLimitSweepPerCent property
'it is drawn from the given start percent over the sweep percent
'given in percent of the scale
Public Sub setScaleMidLimit2SweepPerCent(ScaleMidLimit2SweepPerCent2 As Double)
	cScaleMidLimit2SweepPerCent = ScaleMidLimit2SweepPerCent2
	ReInitialize
End Sub

Public Sub getScaleMidLimit2SweepPerCent As Double
	Return cScaleMidLimit2SweepPerCent
End Sub

'sets or gets the ScaleMidLimit2Colors
'it must be an Array of xui.Colors
'Example: xGauge1.ScaleMidLimit2Colors = Array As Int(xui.Color_RGB(526, 165, 0), xui.Color_Red)
Public Sub setScaleMidLimit2Colors(ScaleMidLimit2Colors() As Int)
	cScaleMidLimit2Colors = ScaleMidLimit2Colors
	ReInitialize
End Sub

Public Sub getScaleMidLimit2Colors As Int()
	Return cScaleMidLimit2Colors
End Sub

'sets or gets the ScaleMidLimit2Color
'it must be an xui.Color
'Example: xGauge1.ScaleMidLimit2Color = xui.Color_RGB(526, 165, 0)
Public Sub setScaleMidLimit2Color(ScaleMidLimit2Color As Int)
	Private cScaleMidLimit2Colors(1) As Int
	cScaleMidLimit2Colors(0) = ScaleMidLimit2Color
	ReInitialize
End Sub

Public Sub getScaleMidLimit2Color As Int
	Return cScaleMidLimit2Colors(0)
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

'sets or gets the NeedleShape property
'possible values: Line  Triangle  Arrow
Public Sub setNeedleShape(NeedleShape As String)
	If NeedleShape = "Line" Or NeedleShape = "Triangle" Or NeedleShape = "Arrow" Then
		cNeedleShape = NeedleShape
		ReInitialize
	End If
End Sub

Public Sub getNeedleShape As String
	Return cNeedleShape
End Sub

'sets or gets the BorderColor
'it must be an xui.Color
'Example: xGauge1.ScaleMidLimitColor = xui.Color_Gray
Public Sub setBorderColor(BorderColor As Int)
	cBorderColor = BorderColor
	Select cGaugeType
		Case "Horizontal"
			DrawNeedleH
		Case "Vertical"
			DrawNeedleV
	End Select
End Sub

Public Sub getBorderColor As Int
	Return cBorderColor
End Sub

'sets or gets the BorderWidth property
'if cCornerRadius > 0 And cCornerRadius < cBorderWidth + 1 Then cCornerRadius = cBorderWidth + 1
Public Sub setBorderWidth(BorderWidt As Int)
	cBorderWidth = BorderWidt
	If cCornerRadius > 0 And cCornerRadius < cBorderWidth + 1 Then
		cCornerRadius = cBorderWidth + 1
	End If
	ReInitialize
End Sub

Public Sub getBorderWidth As Int
	Return cBorderWidth
End Sub

'sets or gets the CornerRadius property
'this value must bee bigger than the BorderWidth.
'if cCornerRadius > 0 And cCornerRadius < cBorderWidth + 1 Then cCornerRadius = cBorderWidth + 1
'Example: xGauge1.CornerRadius = 5dip
Public Sub setCornerRadius(CornerRadius As Int)
	cCornerRadius = CornerRadius
	If cCornerRadius > 0 And cCornerRadius < cBorderWidth + 1 Then
		cCornerRadius = cBorderWidth + 1
	End If

	ReInitialize
End Sub

Public Sub getCornerRadius As Int
	Return cCornerRadius
End Sub

Public Sub getCursorON As Boolean
	Return cCursorOn(0)
End Sub

'sets or gets the CursorON property
Public Sub setCursorON(CursorON As Boolean)
	cCursorOn(0) = CursorON
	DrawCursors
End Sub

Public Sub getCursor2ON As Boolean
	Return cCursorOn(0)
End Sub

'sets or gets the CursorON2 property
Public Sub setCursor2ON(Cursor2ON As Boolean)
	cCursorOn(1) = Cursor2ON
	DrawCursors
End Sub

Public Sub getCursorValue As Int
	Return cCursorValue(0)
End Sub

'sets or gets the CursorValue property
Public Sub setCursorValue(CursorValue As Int)
	cCursorValue(0) = CursorValue
	DrawCursors
End Sub

Public Sub getCursor2Value As Int
	Return cCursorValue(1)
End Sub

'sets or gets the Cursor2Value property
Public Sub setCursor2Value(Cursor2Value As Int)
	cCursorValue(1) = Cursor2Value
	DrawCursors
End Sub

Public Sub getCursorColor As Int
	Return cCursorColor(0)
End Sub

'sets or gets the CursorColor property
Public Sub setCursorColor(CursorColor As Int)
	cCursorColor(0) = CursorColor
	DrawCursors
End Sub

Public Sub getCursor2Color As Int
	Return cCursorColor(1)
End Sub

'sets or gets the Cursor2Color property
Public Sub setCursor2Color(Cursor2Color As Int)
	cCursorColor(1) = Cursor2Color
	DrawCursors
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
		InitGauge
	End If
End Sub

Public Sub BringToFront
	mBase.BringToFront
End Sub

Public Sub SendToBack
	mBase.SendToBack
End Sub

Private Sub pnlAction_Touch (Action As Int, X As Float, Y As Float)
	Private pos As Int
	Private delta = 20dip  As Int
	
	If Action = pnlAction.TOUCH_ACTION_MOVE_NOTOUCH Then
		Return
	End If
	
	For i = 0 To cCursorOn.Length - 1
		If cCursorOn(i) = True Then
			Select cGaugeType
				Case "Horizontal"
					pos = X
				Case "Vertical"
					pos = Y
			End Select
			If pos >= cCursorPosition(i) - delta And pos <= cCursorPosition(i) + delta And CursorMove = False Then
				CursorMove = True
				cCurrentCursorIndex = i
			End If
		End If
	Next
	
	If CursorMove = False Then
		Select Action
			Case pnlAction.TOUCH_ACTION_DOWN
				StartTime = DateTime.Now
			Case pnlAction.TOUCH_ACTION_UP
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
	Else
		Select cGaugeType
			Case "Horizontal"
				cCursorValue(cCurrentCursorIndex) = (cValueMax - cValueMin) / ScaleLength * (pos - ScaleBegin)
				cCursorValue(cCurrentCursorIndex) = Max(cCursorValue(cCurrentCursorIndex), cValueMin)
				cCursorValue(cCurrentCursorIndex) = Min(cCursorValue(cCurrentCursorIndex), cValueMax)
				cCursorPosition(cCurrentCursorIndex) = ScaleBegin + (cCursorValue(cCurrentCursorIndex) - cValueMin) * ScaleLength / (cValueMax - cValueMin)
			Case "Vertical"
				cCursorValue(cCurrentCursorIndex) = (cValueMax - cValueMin) / ScaleLength * (ScaleEnd - pos)
				cCursorValue(cCurrentCursorIndex) = Max(cCursorValue(cCurrentCursorIndex), cValueMin)
				cCursorValue(cCurrentCursorIndex) = Min(cCursorValue(cCurrentCursorIndex), cValueMax)
				cCursorPosition(cCurrentCursorIndex) = ScaleEnd - (cCursorValue(cCurrentCursorIndex) - cValueMin) * ScaleLength / (cValueMax - cValueMin)
		End Select
		Select Action
			Case pnlAction.TOUCH_ACTION_DOWN
				DrawCursors
			Case pnlAction.TOUCH_ACTION_MOVE
				DrawCursors
			Case pnlAction.TOUCH_ACTION_UP
				CursorMove = False
		End Select
	End If
End Sub

'Returns the base panel of the gauge as B4XView
Public Sub AsView As B4XView
	Return mBase
End Sub

Private Sub GetBackground(Opacity As Int, Orientation As String, Color As Int, Rect As B4XRect) As B4XBitmap
	Private k, x, y As Int
	Private col As ARGBColor
	Private x1, y1, fa As Double
	Private bmcResult As BitmapCreator
	Private Alpha(4), Shade As Int
	Private Contrast As Double
	
	Contrast  = 1 - (0.299 * Bit.And(Bit.ShiftRight(Color,16),0xFF) + 0.587 * Bit.And(Bit.ShiftRight(Color,8),0XFF) + 0.114 * Bit.And(Color,0xFF)) / 255
	
	If Contrast <= 0.5 Then
		Alpha(0) = Opacity
		Alpha(1) = 0
		Alpha(2) = 0
		Alpha(3) = Opacity
		Shade = 0
	Else
		Alpha(0) = 0
		Alpha(1) = Opacity
		Alpha(2) = Opacity
		Alpha(3) = 0
		Shade = 255
	End If
	bmcResult.Initialize(Rect.Width, Rect.Height)
	
	Select Orientation
		Case "LEFT_RIGHT"
			x1 = Rect.Width / (Alpha.Length - 1)
			For x = 0 To Rect.Width - 1
				k = Min(Floor(x / x1), Alpha.Length - 2)
				fa = 	(Alpha(k + 1) - Alpha(k)) / x1
				col.a = Alpha(k) + fa * (x - x1 * k)
				col.r = Shade
				col.g = Shade
				col.b = Shade
				For y = 0 To Rect.Height - 1
					bmcResult.SetARGB(x, y, col)
				Next
			Next
		Case "TOP_BOTTOM"
			y1 = Rect.Height / (Alpha.Length - 1)
			For y = 0 To Rect.Height - 1
				k = Min(Floor(y / y1), Alpha.Length - 2)
				fa = 	(Alpha(k + 1) - Alpha(k)) / y1
				col.a = Alpha(k) + fa * (y - y1 * k)
				col.r = Shade
				col.g = Shade
				col.b = Shade
				For x = 0 To Rect.Width - 1
					bmcResult.SetARGB(x, y, col)
				Next
			Next
	End Select
	bmcResult.DrawRectRounded(rectGauge, cBorderColor, False, cBorderWidth, cCornerRadius)
	Return bmcResult.Bitmap
End Sub
