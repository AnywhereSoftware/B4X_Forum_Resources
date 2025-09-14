B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.45
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-BugFixes
V1.02
	-BugFixes
	-Add get and set Hours
	-Add get and set Minutes
V1.03
	-Add SmoothModeChange - Fade in mode change
V1.04
	-12h Format now has a 12 at the top
V1.05
	-BugFix
V1.06
	-BugFix
V1.07
	-Add get CurrentMode
V1.08
	-BugFixes
	-Visual Improvements
	-The Thumb is now behind the Text, so you can now use thumb colors with full alpha
	-Add get and set FontSize
		-Default: 15
	-Add get and set SecondRowGap
		-Default: 5dip
V1.09
	-BugFix
V1.10
	-BugFix in set Hours
V1.11
	-B4A BugFix
#End If

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF131416
#DesignerProperty: Key: ThumbColor, DisplayName: Thumb Color, FieldType: Color, DefaultValue: 0x642D8879
#DesignerProperty: Key: ThumbLineColor, DisplayName: Thumb Line Color, FieldType: Color, DefaultValue: 0x642D8879
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: AutoSwitch, DisplayName: Auto Switch, FieldType: Boolean, DefaultValue: True, Description: If True then automatically switches to minutes when the user releases the clock during hour selection
#DesignerProperty: Key: MinuteSteps, DisplayName: Minute Steps, FieldType: Int, DefaultValue: 1, MinRange: 1, MaxRange: 60, Description: Indicates in how many steps the selector can be moved
#DesignerProperty: Key: TimeFormat, DisplayName: Time Format, FieldType: String, DefaultValue: 24h, List: 24h|12h

#Event: SelectedHourChanged (Hour As Int)
#Event: SelectedMinuteChanged (Minute As Int)

#Event: SelectedHour (Hour As Int)
#Event: SelectedMinute (Minute as Int)

#Event: SelectionDone (Hour As Int, Minute As Int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_Background As B4XView
	
	Private xpnl_Thumb As B4XView
	Private xiv_ThumbIcon As B4XView
	
	Private xpnl_SmoothPanel As B4XView
	
	Private cv_Clock As B4XCanvas
	Private CircleRect As B4XRect
	
	Private mMin, mMax As Int
	Private mValue As Int = 75
	
	Private mTouchIsRight As Boolean = False
	
	Private ThumbSize As Float
	Private mStrokeWidth As Int
	Private mIcon1 As B4XBitmap = Null
	
	Private isInnerCircle As Boolean = False
	
	Private m_CurrentMode As String = "HourSelection"
	
	'******Props******
	Private m_BackgroundColor As Int
	Private m_ThumbColor As Int
	Private m_ThumbLineColor As Int
	Private m_TextColor As Int
	
	Private m_AutoSwitch As Boolean
	Private m_MinuteSteps As Int
	Private m_TimeFormat As String
	Private m_FontSize As Int
	Private m_SecondRowGap As Float = 5dip
	
	Private m_LastHourValue,m_LastMinuteValue As Int
	
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
	IniProps(Props)
	
	xpnl_Thumb = xui.CreatePanel("")
	mBase.AddView(xpnl_Thumb, 0, 0, 40dip, 40dip)
	
	xpnl_Background = xui.CreatePanel("xpnl_Background")
	mBase.AddView(xpnl_Background,0,0,mBase.Width,mBase.Height)
	
	
	xpnl_SmoothPanel = xui.CreatePanel("")
	xpnl_SmoothPanel.SetColorAndBorder(m_BackgroundColor,0,0,mBase.Height/2)
	xpnl_SmoothPanel.SetVisibleAnimated(0,False)
	mBase.AddView(xpnl_SmoothPanel,0,0,mBase.Width,mBase.Height)
	
	
	cv_Clock.Initialize(xpnl_Background)

	Dim tmp_iv As ImageView : tmp_iv.Initialize("") : xiv_ThumbIcon = tmp_iv
	#If B4I
	tmp_iv.UserInteractionEnabled = False
	xpnl_Thumb.As(Panel).UserInteractionEnabled = False
	#Else If B4J
	Dim jo As JavaObject = xpnl_Thumb
	jo.RunMethod("setMouseTransparent", Array(True))
	#End If

	mStrokeWidth = 30dip'25dip
	
	mMin = 0
	mMax = 720
	mValue = mMin
	ThumbSize = mStrokeWidth/2'12dip
	
	xpnl_Thumb.AddView(xiv_ThumbIcon,mBase.Width/2 - ThumbSize,0 - ThumbSize,mStrokeWidth,mStrokeWidth)
	
	CreateThumb
	CircleRect.Initialize(0,0,mBase.Width,mBase.Height)
	'Sleep(0)
	xpnl_Background_Touch(xpnl_Background.TOUCH_ACTION_DOWN,mBase.Width/2,0)
	'Draw

#If B4A
	Base_Resize(mBase.Width,mBase.Height)
#End If

End Sub

Private Sub IniProps(Props As Map)
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	m_ThumbColor = xui.PaintOrColorToColor(Props.Get("ThumbColor"))
	m_ThumbLineColor = xui.PaintOrColorToColor(Props.Get("ThumbLineColor"))
	m_TextColor = xui.PaintOrColorToColor(Props.Get("TextColor"))
	
	m_AutoSwitch = Props.Get("AutoSwitch")
	m_MinuteSteps = Props.Get("MinuteSteps")
	m_TimeFormat = Props.Get("TimeFormat")
	
	m_FontSize = 15
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xpnl_SmoothPanel.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_Background.SetLayoutAnimated(0,0,0,Width,Height)
	cv_Clock.Resize(Width, Height)
	CircleRect.Initialize(0,0,Width,Height)
	Refresh
End Sub

Private Sub CreateThumb

	xpnl_Thumb.SetColorAndBorder(xui.Color_ARGB(100,255,255,255),0,xui.Color_Transparent,xpnl_Thumb.Height/2)
	
	If mIcon1.IsInitialized = True And mIcon1 <> Null Then
		xiv_ThumbIcon.SetBitmap(mIcon1.Resize(xiv_ThumbIcon.Width,xiv_ThumbIcon.Height,True))
	End If
	
End Sub
'<code>AS_TimerPicker1.SmoothModeChange(AS_TimerPicker1.CurrentMode_HourSelection)</code>
Public Sub SmoothModeChange(Mode As String)
	If m_CurrentMode = Mode Then Return
	xpnl_SmoothPanel.BringToFront
	xpnl_SmoothPanel.SetVisibleAnimated(0,True)
	Sleep(0)
	setCurrentMode(Mode)
	Refresh
	Sleep(0)
	xpnl_SmoothPanel.SetVisibleAnimated(500,False)
End Sub

Public Sub setCurrentMode(Mode As String)
	If m_CurrentMode = Mode Then Return
	m_CurrentMode = Mode
	If m_CurrentMode = getCurrentMode_MinuteSelection Then
		mMax = 60
		mValue = m_LastMinuteValue
	Else
		mMax = 720
		mValue = 60*getHours
	End If
	isInnerCircle = False
	If m_CurrentMode = getCurrentMode_HourSelection And mValue > 11*60 Then isInnerCircle = True
End Sub

Public Sub getCurrentMode As String
	Return m_CurrentMode
End Sub

Private Sub xpnl_Background_Touch (Action As Int, X As Float, Y As Float)
	If Action = xpnl_Background.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	Dim dx As Int = x - CircleRect.CenterX
	Dim dy As Int = y - CircleRect.CenterY
	Dim dist As Float = Sqrt(Power(dx, 2) + Power(dy, 2))
	'If dist > CircleRect.Width / 2 Then
	Dim OldisInnerCircle As Boolean = isInnerCircle
	If Action = xpnl_Background.TOUCH_ACTION_DOWN Then
		If dist > (CircleRect.Width/4 + mStrokeWidth/2) And dist < (CircleRect.Width/2 + mStrokeWidth/2) Or dist < (mBase.Width/2 - xpnl_Thumb.Height) And dist > (mBase.Width/2 - xpnl_Thumb.Height*2) Then
			mTouchIsRight = True
		End If
	else If Action = xpnl_Background.TOUCH_ACTION_UP Then
		mTouchIsRight = False
		If m_CurrentMode = getCurrentMode_HourSelection Then
			SelectedHour
			If m_AutoSwitch = True Then
				setCurrentMode(getCurrentMode_MinuteSelection)
				Refresh
			End If
		Else
			SelectedMinute
			SelectionDone
		End If
	End If

	If m_TimeFormat = "24h" And dist < (mBase.Width/2 - xpnl_Thumb.Width - m_SecondRowGap) And m_CurrentMode = getCurrentMode_HourSelection Then
		isInnerCircle = True
	Else
		isInnerCircle = False
	End If
	
	If mTouchIsRight = True Then
		
		Dim angle As Int = Round(ATan2D(dy, dx))
		angle = angle + 90
		angle = (angle + 360) Mod 360
		Dim NewValue As Int = mMin + angle / 360 * (mMax - mMin)
		NewValue = Max(mMin, Min(mMax, NewValue))
		Dim OldValue As Int = mValue
		If NewValue <> mValue Then
	
			mValue = NewValue
		
			If m_CurrentMode = getCurrentMode_HourSelection Then
				If mValue Mod 60 >= 0 And mValue Mod 60 <= 30 Then
					mValue = mValue - (mValue Mod 60)
				else If mValue Mod 60 >= 30 And mValue Mod 60 <= 60 Then
					mValue = mValue + (60 - (mValue Mod 60))
				End If
			Else
				If mValue Mod m_MinuteSteps >= 0 And mValue Mod m_MinuteSteps <= m_MinuteSteps/2 Then
					mValue = mValue - (mValue Mod m_MinuteSteps)
				Else
					mValue = mValue + (m_MinuteSteps - mValue Mod m_MinuteSteps)
				End If
				
			End If
			If mValue = mMax Then mValue = 0
			If OldValue <> mValue Or OldisInnerCircle <> isInnerCircle Then 
				ValueChanged
			End If

		End If
	
		
		Refresh
	End If
	
	
End Sub

Public Sub Refresh
	
	mBase.Color = m_BackgroundColor
	xpnl_Thumb.SetColorAndBorder(m_ThumbColor,0,xui.Color_Transparent,xpnl_Thumb.Height/2)
	
	cv_Clock.ClearRect(cv_Clock.TargetRect)
	
	If isInnerCircle = True Then
		Dim r As Float = mBase.Width/2 - xpnl_Thumb.Height - xpnl_Thumb.Height/2 - m_SecondRowGap
	Else
		Dim r As Float = mBase.Width/2 - mStrokeWidth/2
	End If
	
	Dim angle As Float = (mValue - mMin) / (mMax - mMin) * 360
	Dim cx As Float = CircleRect.CenterX + r * CosD(angle-90)
	Dim cy As Float = CircleRect.CenterY + r * SinD(angle-90)
					
	xpnl_Thumb.SetLayoutAnimated(0,cx - ThumbSize,cy - ThumbSize,mStrokeWidth,mStrokeWidth)
	
	
	cv_Clock.DrawLine(mBase.Width/2,mBase.Height/2,xpnl_Thumb.Left + xpnl_Thumb.Width/2,xpnl_Thumb.Top + xpnl_Thumb.Height/2,m_ThumbLineColor,2dip)
	'************Draw Clock*************************
	
	Dim r As Float = mBase.Width/2 - mStrokeWidth/2
	
	'Outer circle
	'Draw the 12 dots representing the hours
	Dim midnight = 270 As Int
	Dim Counter As Int = -1
	For angle = midnight To (midnight + 360) Step (360 / 12)
		Counter = Counter +1
	
		If Counter < (12+1) And Counter <> 0 Then
			
			Dim cx As Float = CircleRect.CenterX + r * CosD(angle)
			Dim cy As Float = CircleRect.CenterY + r * SinD(angle)
			
			Dim Text As String = IIf(m_CurrentMode = getCurrentMode_HourSelection,IIf(Counter = 12,IIf(m_TimeFormat = "24h",0,Counter),Counter),IIf((5*Counter)=60,0,5*Counter))
			Text = NumberFormat(Text,2,0)
			
			'https://www.b4x.com/android/forum/threads/b4x-xui-accurate-text-measurement-and-drawing.92810/
			Dim r2 As B4XRect = cv_Clock.MeasureText(Text,xui.CreateDefaultBoldFont(m_FontSize))
			Dim BaseLine As Float = cy - r2.Height / 2 - r2.Top
			cv_Clock.DrawText(Text, cx, BaseLine, xui.CreateDefaultBoldFont(m_FontSize),m_TextColor,"CENTER")

		End If

	Next

	
	If m_TimeFormat = "24h" And m_CurrentMode = getCurrentMode_HourSelection Then
		Dim r As Float = mBase.Width/2 - xpnl_Thumb.Height - xpnl_Thumb.Height/2 - m_SecondRowGap
		'Inner circle
		'Draw the 12 dots representing the hours
		Dim midnight = 270 As Int
		Dim Counter As Int = -1
		For angle = midnight To (midnight + 360) Step (360 / 12)
			Counter = Counter +1
	
			If Counter < (12+1) And Counter <> 0 Then

				Dim cx As Float = CircleRect.CenterX + r * CosD(angle)
				Dim cy As Float = CircleRect.CenterY + r * SinD(angle)
			
				Dim Text As String = IIf((12 + Counter) = 24,12,12+Counter)
				Text = NumberFormat(Text,2,0)
			
				'https://www.b4x.com/android/forum/threads/b4x-xui-accurate-text-measurement-and-drawing.92810/
				Dim r2 As B4XRect = cv_Clock.MeasureText(Text,xui.CreateDefaultBoldFont(m_FontSize))
				Dim BaseLine As Float = cy - r2.Height / 2 - r2.Top
				cv_Clock.DrawText(Text, cx, BaseLine, xui.CreateDefaultBoldFont(m_FontSize),m_TextColor,"CENTER")

			End If

		Next
	End If
	
	cv_Clock.DrawCircle(mBase.Width/2,mBase.Height/2,4dip,m_ThumbLineColor,True,0)
	
	cv_Clock.Invalidate
	
End Sub

#Region Properties
'The Gap between the outer row and the inner row in 24h mode
'Default: 5dip
Public Sub getSecondRowGap As Float
	Return m_SecondRowGap
End Sub

Public Sub setSecondRowGap(Gap As Float)
	m_SecondRowGap = Gap
End Sub

'Default: 15
Public Sub getFontSize As Int
	Return m_FontSize
End Sub

Public Sub setFontSize(Size As Int)
	m_FontSize = Size
End Sub

Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

Public Sub setBackgroundColor(Color As Int)
	m_BackgroundColor = Color
	xpnl_SmoothPanel.SetColorAndBorder(m_BackgroundColor,0,0,mBase.Height/2)
End Sub

Public Sub getThumbColor As Int
	Return m_ThumbColor
End Sub

Public Sub setThumbColor(Color As Int)
	m_ThumbColor = Color
End Sub

Public Sub getThumbLineColor As Int
	Return m_ThumbLineColor
End Sub

Public Sub setThumbLineColor(Color As Int)
	m_ThumbLineColor = Color
End Sub

Public Sub getTextColor As Int
	Return m_TextColor
End Sub

Public Sub setTextColor(Color As Int)
	m_TextColor = Color
End Sub

Public Sub getAutoSwitch As Boolean
	Return m_AutoSwitch
End Sub

Public Sub setAutoSwitch(Auto As Boolean)
	m_AutoSwitch = Auto
End Sub

Public Sub getMinuteSteps As Int
	Return m_MinuteSteps
End Sub

Public Sub setMinuteSteps(Steps As Int)
	m_MinuteSteps = Steps
End Sub
'<code>AS_TimerPicker1.TimeFormat = AS_TimerPicker1.TimeFormat_24h</code>
Public Sub getTimeFormat As String
	Return m_TimeFormat
End Sub

Public Sub setTimeFormat(Format As String)
	m_TimeFormat = Format
End Sub

Public Sub setMinutes(Minute As Int)
	m_LastMinuteValue = Minute
	If m_CurrentMode = getCurrentMode_MinuteSelection Then 
		mValue = Minute
		SelectedMinuteChanged
	End If
	Refresh
End Sub

Public Sub getMinutes As Int
	Return m_LastMinuteValue
End Sub

Public Sub setHours(Hour As Int)
	If m_TimeFormat = getTimeFormat_24h Then
		m_LastHourValue = Hour
	Else
		m_LastHourValue = (IIf(Hour > 12,Hour - 12,Hour))
	End If

	If m_CurrentMode = getCurrentMode_HourSelection Then
		mValue = 60*(IIf(Hour > 12,Hour - 12,Hour))
		Dim tmp_Value As Int = 60*Hour
		If tmp_Value > 60*11 And m_TimeFormat = getTimeFormat_24h Then isInnerCircle = True Else isInnerCircle = False
		SelectedHourChanged
	End If
	Refresh
End Sub

Public Sub getHours As Int
	Return IIf(m_LastHourValue = 24,0,m_LastHourValue)
End Sub

#End Region

#Region Enums

Public Sub getCurrentMode_HourSelection As String
	Return "HourSelection"
End Sub

Public Sub getCurrentMode_MinuteSelection As String
	Return "MinuteSelection"
End Sub

Public Sub getTimeFormat_12h As String
	Return "12h"
End Sub

Public Sub getTimeFormat_24h As String
	Return "24h"
End Sub

#End Region

#Region Events

Private Sub ValueChanged
	'Log(mValue/60)
	
	'Log(IIf(isInnerCircle = False,mValue/60,12 + (mValue/60)).As(Int))
	
	If m_CurrentMode = getCurrentMode_HourSelection Then
		SelectedHourChanged
		Else
		SelectedMinuteChanged
	End If
	
	
	
End Sub

Private Sub SelectedHourChanged
	If xui.SubExists(mCallBack, mEventName & "_SelectedHourChanged",1) Then		
		Dim Hour As Int = IIf(isInnerCircle = False,mValue/60,12 + (mValue/60)).As(Int)
		If m_TimeFormat = getTimeFormat_12h And Hour = 0 Then Hour = 12
		CallSub2(mCallBack, mEventName & "_SelectedHourChanged",Hour)
	End If
End Sub

Private Sub SelectedMinuteChanged
	If xui.SubExists(mCallBack, mEventName & "_SelectedMinuteChanged",1) Then
		CallSub2(mCallBack, mEventName & "_SelectedMinuteChanged",mValue)
	End If
End Sub

Private Sub SelectedHour
	Dim Hour As Int = IIf(isInnerCircle = False,mValue/60,12 + (IIf(xui.IsB4A and mValue/60 = 12,0, mValue/60))).As(Int)
	If m_TimeFormat = getTimeFormat_12h And Hour = 0 Then Hour = 12
	m_LastHourValue = Hour
	If xui.SubExists(mCallBack, mEventName & "_SelectedHour",1) Then
		CallSub2(mCallBack, mEventName & "_SelectedHour",Hour)
	End If
End Sub

Private Sub SelectedMinute
	m_LastMinuteValue = mValue
	If xui.SubExists(mCallBack, mEventName & "_SelectedMinute",1) Then
		CallSub2(mCallBack, mEventName & "_SelectedMinute",mValue)
	End If
End Sub

Private Sub SelectionDone
	If xui.SubExists(mCallBack, mEventName & "_SelectionDone",2) Then
		CallSub3(mCallBack, mEventName & "_SelectionDone",getHours,m_LastMinuteValue)
	End If
End Sub

#End Region

#Region Functions



#End Region