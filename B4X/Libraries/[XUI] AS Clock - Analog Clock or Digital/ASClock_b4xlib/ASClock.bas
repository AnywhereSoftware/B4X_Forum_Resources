B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Add get and set ScaleColor
	-Add get and set SweepHands
V1.02
	-Add Designer Property ClockMode - 12 and 24
		-Default: 12
		-If 24 then the clock displays 1-24
		-If 12 then the clock displays 1-12
V1.03
	-Add SleepDuration to ClockMode
#End If

#DesignerProperty: Key: InnerColor, DisplayName: Inner Color, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: CornerColor, DisplayName: Corner Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: CornerWidth, DisplayName: Corner Width, FieldType: Int, DefaultValue: 2, MinRange: 0
#DesignerProperty: Key: ShowDialText, DisplayName: Show Dial Text, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowHourMark, DisplayName: Show Hour Mark, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowMinutesMark, DisplayName: Show Minutes Mark, FieldType: Boolean, DefaultValue: True

'Hands
#DesignerProperty: Key: HoursHandColor, DisplayName: Hours Hand Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: MinutesHandColor, DisplayName: Minutes Hand Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: SecondsHandColor, DisplayName: Seconds Hand Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ScaleColor, DisplayName: Scale Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: ShowHoursHand, DisplayName: Show Hours Hand, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowMinutesHand, DisplayName: Show Minutes Hand, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowSecondsHand, DisplayName: Show Seconds Hand, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: SweepHands, DisplayName: Sweep Hands, FieldType: Boolean, DefaultValue: False

#DesignerProperty: Key: ClockMode, DisplayName: Clock Mode, FieldType: String, DefaultValue: 12, List: 12|24|SleepDuration

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_Background As B4XView
	Private cv_Clock As B4XCanvas
	
	Type ASClock_MiddleTextProperties(TextColor As Int,xFont As B4XFont)
	Private m_MiddleTextProperties As ASClock_MiddleTextProperties
	
	Private mInnerColor As Int
	Private mCornerColor As Int
	Private mCornerWidth As Float
	Private mShowDialText As Boolean
	Private mShowHourMark As Boolean
	Private mShowMinutesMark As Boolean
	
	Private mHoursHandColor As Int
	Private mMinutesHandColor As Int
	Private mSecondsHandColor As Int
	Private mScaleColor As Int
	
	Private mShowHoursHand As Boolean
	Private mShowMinutesHand As Boolean
	Private mShowSecondsHand As Boolean
	Private mSweepHands As Boolean
	Private mClockMode As String
	
	Private mMiddleText As String
	Private mHour,mMin,mSec As Int
	
	Private CircleRect As B4XRect
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	
	xpnl_Background = xui.CreatePanel("")
	mBase.AddView(xpnl_Background,0,0,1dip,1dip)
	cv_Clock.Initialize(xpnl_Background)
	
	mInnerColor = xui.PaintOrColorToColor(Props.Get("InnerColor"))
	mCornerColor = xui.PaintOrColorToColor(Props.Get("CornerColor"))
	
	mHoursHandColor = xui.PaintOrColorToColor(Props.Get("HoursHandColor"))
	mMinutesHandColor = xui.PaintOrColorToColor(Props.Get("MinutesHandColor"))
	mSecondsHandColor = xui.PaintOrColorToColor(Props.Get("SecondsHandColor"))
	mScaleColor = xui.PaintOrColorToColor(Props.GetDefault("ScaleColor",xui.Color_White))
	
	mCornerWidth = DipToCurrent(Props.Get("CornerWidth"))
	mShowDialText = Props.Get("ShowDialText")
	mShowHourMark = Props.Get("ShowHourMark")
	mShowMinutesMark = Props.Get("ShowMinutesMark")
	mSweepHands = Props.GetDefault("SweepHands",False)
	
	mShowHoursHand = Props.Get("ShowHoursHand")
	mShowMinutesHand = Props.Get("ShowMinutesHand")
	mShowSecondsHand = Props.Get("ShowSecondsHand")
	
	mClockMode = Props.GetDefault("ClockMode",12)
	
	m_MiddleTextProperties = CreateASClock_MiddleTextProperties(xui.Color_White,xui.CreateDefaultFont(60))
	
	Base_Resize(mBase.Width,mBase.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xpnl_Background.SetLayoutAnimated(0,0,0,Width,Height)
	cv_Clock.Resize(Width, Height)
	CircleRect.Initialize(mCornerWidth/2,mCornerWidth/2,Width - mCornerWidth/2,Height - mCornerWidth/2)
	Draw
End Sub

Public Sub Draw
	
	cv_Clock.ClearRect(cv_Clock.TargetRect)
	
	mBase.SetColorAndBorder(mInnerColor,mCornerWidth,mCornerColor,mBase.Height/2)
	
	Dim Clock_Radius As Float = CircleRect.Width / 2 - mCornerWidth
	
	Dim ClockMode As Int = IIf(mClockMode <> "SleepDuration",mClockMode,24)
	
	'Draw the 12 dots representing the hours
	Dim midnight = 270 As Int
	Dim Counter As Int = -1
	For angle = midnight To (midnight + 360) Step (360 / ClockMode)
		Counter = Counter +1
		Dim x = (CosD(angle) * Clock_Radius * 0.95) + mBase.Width/2 As Float
		Dim y = (SinD(angle) * Clock_Radius * 0.95) + mBase.Height/2 As Float
		'cv_Clock.DrawCircle(x, y, Clock_Radius * 0.05, xui.Color_Green, True, 0)
		
		Dim x2 = (CosD(angle) * Clock_Radius * 1) + mBase.Width/2 As Float
		Dim y2 = (SinD(angle) * Clock_Radius * 1) + mBase.Height/2 As Float
		
		If mShowHourMark = True Then cv_Clock.DrawLine(x,y,x2,y2,mScaleColor,2dip)
		
		If mShowDialText = True Then
		
			If Counter < (ClockMode+1) And Counter <> 0 Then
				x = (CosD(angle) * Clock_Radius * 0.85) + mBase.Width/2
				y = (SinD(angle) * Clock_Radius * 0.85) + mBase.Height/2
		
				y = y + (MeasureTextHeight(Counter,xui.CreateDefaultBoldFont(12))/4)
					
				If Counter = 24 And mClockMode = "SleepDuration" Then
						cv_Clock.DrawText(0,x,y,xui.CreateDefaultBoldFont(12),mScaleColor,"CENTER")
				else if mClockMode = "SleepDuration" Then
					If Counter Mod 3 = 0 Then
						cv_Clock.DrawText(Counter,x,y,xui.CreateDefaultBoldFont(12),mScaleColor,"CENTER")
					End If
				Else
					cv_Clock.DrawText(Counter,x,y,xui.CreateDefaultBoldFont(12),mScaleColor,"CENTER")
				End If
					
			End If
			
		End If
	Next
	
	If mShowMinutesMark = True Then
		Dim midnight = 270 As Int
		For angle = midnight To (midnight + 360) Step (360 / IIf(ClockMode = 12,60,120))
			Dim x = (CosD(angle) * Clock_Radius * 0.98) + mBase.Width/2 As Float
			Dim y = (SinD(angle) * Clock_Radius * 0.98) + mBase.Height/2 As Float
			'cv_Clock.DrawCircle(x, y, Clock_Radius * 0.05, xui.Color_Green, True, 0)
		
			Dim x2 = (CosD(angle) * Clock_Radius * 1) + mBase.Width/2 As Float
			Dim y2 = (SinD(angle) * Clock_Radius * 1) + mBase.Height/2 As Float
		
			cv_Clock.DrawLine(x,y,x2,y2,mScaleColor,2dip)
		Next
	End If
	
	Dim r As B4XRect = cv_Clock.MeasureText(Counter,m_MiddleTextProperties.xFont)
	Dim BaseLine As Int = mBase.Height/2 - r.Height / 2 - r.Top
	
	cv_Clock.DrawText(mMiddleText,mBase.Width/2 ,BaseLine,m_MiddleTextProperties.xFont,m_MiddleTextProperties.TextColor,"CENTER")
	
	DrawPointer
	
	cv_Clock.Invalidate
	
End Sub

Private Sub DrawPointer
	
	'cv_Pointer.ClearRect(cv_Pointer.TargetRect)
	If mShowHoursHand = False And mShowMinutesHand = False And mShowSecondsHand = False Then Return
	
	Dim Hour_X, Hour_Y, Mins_X, Mins_Y, Secs_X, Secs_Y As Float
	Dim Hour_Angle, Mins_Angle, Secs_Angle As Float
	Dim Clock_Radius As Float = CircleRect.Width / 2 - mCornerWidth
	
	'270 degrees is the position for midnight
	'Hour_Angle = 270 + (mHour * 360 / 12)
	'Mins_Angle = 270 + (mMin * 360 / 60)
	Secs_Angle = 270 + (mSec * 360 / 60)
 
	Dim ClockMode As Int = IIf(mClockMode <> "SleepDuration",mClockMode,12)
 
	If mSweepHands = True Then
		Mins_Angle = 270 + (mMin * 360 / IIf(ClockMode = 12,60,120)) + (Secs_Angle - 270) / 60 'rjg mod
		Hour_Angle = 270 + (mHour * 360 / ClockMode) + (Mins_Angle - 270) / IIf(ClockMode = 12,60,120)   'rjg mod
	Else
		Mins_Angle = 270 + (mMin * 360 / 60)
		Hour_Angle = 270 + (mHour * 360 / ClockMode)
	End If
 
	Dim Clock_X As Float = mBase.Width/2
	Dim Clock_Y As Float = mBase.Height/2
 
	'Keep in mind that we're using degrees instead of radians
	Hour_X = (CosD(Hour_Angle) * Clock_Radius * 0.65) + Clock_X
	Hour_Y = (SinD(Hour_Angle) * Clock_Radius * 0.65) + Clock_Y
     
	Mins_X = (CosD(Mins_Angle) * Clock_Radius * 0.80) + Clock_X
	Mins_Y = (SinD(Mins_Angle) * Clock_Radius * 0.80) + Clock_Y

	Secs_X = (CosD(Secs_Angle) * Clock_Radius * 0.80) + Clock_X
	Secs_Y = (SinD(Secs_Angle) * Clock_Radius * 0.80) + Clock_Y
	
	'Draw the handles on the clock
	If mShowHoursHand = True Then cv_Clock.DrawLine(Clock_X, Clock_Y, Hour_X, Hour_Y, mHoursHandColor,  Clock_Radius * 0.03)
	If mShowMinutesHand = True Then cv_Clock.DrawLine(Clock_X, Clock_Y, Mins_X, Mins_Y, mMinutesHandColor, Clock_Radius * 0.03)
	If mShowSecondsHand = True Then cv_Clock.DrawLine(Clock_X, Clock_Y, Secs_X, Secs_Y, mSecondsHandColor,  Clock_Radius * 0.01)
	
	cv_Clock.Invalidate
	
End Sub

#Region Properties

Public Sub setScaleColor(Color As Int)
	mScaleColor = Color
	Draw
End Sub

Public Sub getScaleColor As Int
	Return mScaleColor
End Sub

Public Sub getSweepHands As Boolean
	Return mSweepHands
End Sub

Public Sub setSweepHands(Sweep As Boolean)
	mSweepHands = Sweep
	Draw
End Sub

Public Sub SetTime(Hour As Int,Mins As Int,Secs As Int)
	mHour = Hour
	mMin = Mins
	mSec = Secs
	Draw
End Sub

Public Sub getMiddleTextProperties As ASClock_MiddleTextProperties
	Return m_MiddleTextProperties
End Sub

Public Sub getMiddleText As String
	Return mMiddleText
End Sub

Public Sub setMiddleText(Text As String)
	mMiddleText = Text
	Draw
End Sub

Public Sub getInnerColor As Int
	Return mInnerColor
End Sub

Public Sub setInnerColor(Color As Int)
	mInnerColor = Color
	Draw
End Sub

Public Sub getCornerColor As Int
	Return mCornerColor
End Sub

Public Sub setCornerColor(Color As Int)
	mCornerColor = Color
	Draw
End Sub

Public Sub getCornerWidth As Float
	Return mCornerWidth
End Sub

Public Sub setCornerWidth(CornerWidth As Float)
	mCornerWidth = CornerWidth
	Draw
End Sub

Public Sub getShowDialText As Boolean
	Return mShowDialText
End Sub

Public Sub setShowDialText(Show As Boolean)
	mShowDialText = Show
	Draw
End Sub

Public Sub getShowHourMark As Boolean
	Return mShowHourMark
End Sub

Public Sub setShowHourMark(Show As Boolean)
	mShowHourMark = Show
	Draw
End Sub

Public Sub getShowMinutesMark As Boolean
	Return mShowMinutesMark
End Sub

Public Sub setShowMinutesMark(Show As Boolean)
	mShowMinutesMark = Show
	Draw
End Sub


#End Region

#Region Functions

Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int
#If B4A    
    Private bmp As Bitmap
    bmp.InitializeMutable(2dip, 2dip)
    Private cvs As Canvas
    cvs.Initialize2(bmp)
    Return cvs.MeasureStringHeight(Text, Font1.ToNativeFont, Font1.Size)
#Else If B4i
    Return Text.MeasureHeight(Font1.ToNativeFont)
#Else If B4J
	Dim jo As JavaObject
	jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
	jo.RunMethod("setFont",Array(Font1.ToNativeFont))
	jo.RunMethod("setLineSpacing",Array(0.0))
	jo.RunMethod("setWrappingWidth",Array(0.0))
	Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
	Return Bounds.RunMethod("getHeight",Null)
#End If
End Sub

#End Region

Public Sub CreateASClock_MiddleTextProperties (TextColor As Int, xFont As B4XFont) As ASClock_MiddleTextProperties
	Dim t1 As ASClock_MiddleTextProperties
	t1.Initialize
	t1.TextColor = TextColor
	t1.xFont = xFont
	Return t1
End Sub