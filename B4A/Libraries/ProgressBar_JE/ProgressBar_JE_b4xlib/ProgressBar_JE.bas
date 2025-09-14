B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.1
@EndOfDesignText@
'Version 1.3
'Author: Jerryk
'
#Event: Alarm1(Value as Float)
#Event: Alarm2(realValue as Float)
#Event: Click(Value as Float)
#RaisesSynchronousEvents: Alarm1
#RaisesSynchronousEvents: Alarm2

#DesignerProperty: Key: dDirection, DisplayName: Direction, FieldType: String, DefaultValue: LeftToRight, List: LeftToRight|RightToLeft|UpToDown|DownToUp, Description: Direction of movement
#DesignerProperty: Key: dBackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Background Color
#DesignerProperty: Key: dBarColor1, DisplayName: Bar Color 1, FieldType: Color, DefaultValue: 0xFFD3D3D3, Description: Bar Color 1
#DesignerProperty: Key: dBarColor2, DisplayName: Bar Color 2, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: Bar Color 2
#DesignerProperty: Key: dShowValue, DisplayName: Show Value, FieldType: String, DefaultValue: %, List: %|value|off, Description: Show Value
#DesignerProperty: Key: dNrOfDecimal, DisplayName: Nunber of decimal, FieldType: Int, DefaultValue: 0 , Description: Nunber of decimal places, MinRange: 0, MaxRange: 3
#DesignerProperty: Key: dPrefix, DisplayName: Prefix, FieldType: String, DefaultValue: , Description: Prefix
#DesignerProperty: Key: dSuffix, DisplayName: Suffix, FieldType: String, DefaultValue: %, Description: Suffix

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private pnlBackground As B4XView
	Private pnlBar As B4XView
	Private mLbl As Label
	Private gd As GradientDrawable
	Private color_orientation As String
	Private currentValue As Float
	Private DurationFromZeroTo100 As Int = 100
	Private alarm1_state, alarm2_state As Boolean
	Private alarm1_once = True, alarm2_once = True As Boolean
	Private alarm1_value, alarm2_value As Float
	Private alarm1_color1, alarm1_color2, alarm2_color1, alarm2_color2 As Int
	Private xValue, xrealValue As Float
	
	'Property
	Private mDirection As String
	Private mBackgroundColor As Int
	Private mBarColor1 As Int
	Private mBarColor2 As Int
	Private mShowValue As String
	Private mNrOfDecimal As Int
	Private mPrefix As String
	Private mSuffix As String
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
	mLbl = Lbl
	
	mDirection = Props.GetDefault("dDirection", "LeftToRight")
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("dBackgroundColor", xui.Color_Black))
	mBarColor1 = xui.PaintOrColorToColor(Props.GetDefault("dBarColor1", xui.Color_RGB(211,211,211)))
	mBarColor2 = xui.PaintOrColorToColor(Props.GetDefault("dBarColor2", xui.Color_RGB(169,169,169)))
	mShowValue = Props.GetDefault("dShowValue", "%")
	mNrOfDecimal = Props.GetDefault("dNrOfDecimal", 0)
	mPrefix = Props.GetDefault("dPrefix", "")
	mSuffix = Props.GetDefault("dSuffix", "%")

'	add background panel
	pnlBackground = xui.CreatePanel("pnlBackground")
	mBase.AddView(pnlBackground, 0, 0, mBase.Width, mBase.Height)
	pnlBackground.Color = mBackgroundColor
	
'	add bar panel
	pnlBar = xui.CreatePanel("")
	
	Select mDirection
		Case "LeftToRight"
			pnlBackground.AddView(pnlBar, 0, 0, 0, mBase.Height)
			color_orientation = "LEFT_RIGHT"
			'add label
			pnlBar.AddView(mLbl, 0, 0, 0, pnlBar.Height)
		Case "RightToLeft"
			pnlBackground.AddView(pnlBar, mBase.Width, 0, 0, mBase.Height)
			color_orientation = "RIGHT_LEFT"
			'add label
			pnlBar.AddView(mLbl, 0, 0, 0, pnlBar.Height)
		Case "UpToDown"
			pnlBackground.AddView(pnlBar, 0, 0, mBase.Width, 0)
			color_orientation = "TOP_BOTTOM"
			'add label
			pnlBar.AddView(mLbl, 0, 0, 100dip, 100dip)
			mLbl.As(B4XView).Rotation = -90
			mLbl.Top = mLbl.Top - mLbl.Width + pnlBar.Height
			mLbl.Width = pnlBar.Height
			mLbl.Height = pnlBar.Width
		Case "DownToUp"
			pnlBackground.AddView(pnlBar, 0, 0, mBase.Width, 0)
			color_orientation = "BOTTOM_TOP"
			'add label
			pnlBar.AddView(mLbl, 0, 0, 100dip, 100dip)
			mLbl.As(B4XView).Rotation = -90
			mLbl.Top = mLbl.Top + pnlBar.Height  - mLbl.Width
			mLbl.Width = pnlBar.Height
			mLbl.Height = pnlBar.Width
	End Select
	gd.Initialize(color_orientation, Array As Int(mBarColor1, mBarColor2))
	pnlBar.As(Panel).Background = gd
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
End Sub

Private Sub DrawValue(Value As Float, realValue As Float)
	Select mDirection
		Case "LeftToRight"
			pnlBar.Width = Value / 100 * pnlBackground.Width
			mLbl.Width = pnlBar.Width
		Case "RightToLeft"
			pnlBar.Width = Value / 100 * pnlBackground.Width  + 1dip
			pnlBar.Left = (pnlBackground.Left + pnlBackground.Width) - Value / 100 * pnlBackground.Width
			mLbl.Width = pnlBar.Width
			mLbl.Left = 0
		Case "UpToDown"
			Dim h As Int = pnlBar.Height
			pnlBar.Height = Value / 100 * pnlBackground.Height
			mLbl.Width =  pnlBar.Height
			mLbl.Top = mLbl.Top - h + pnlBar.Height
		Case "DownToUp"
			Dim h As Int = pnlBar.Height
			pnlBar.Top =  (100-Value) / 100 * pnlBackground.Height
			pnlBar.Height = Value / 100 * pnlBackground.Height
			mLbl.Top = mLbl.Top - h + pnlBar.Height
			mLbl.Width =  pnlBar.Height
	End Select
	
	Select mShowValue
		Case "%"
			mLbl.Text = mPrefix & NumberFormat(Value, 0, mNrOfDecimal) & mSuffix
		Case "value"
			mLbl.Text = mPrefix & NumberFormat(realValue, 0, mNrOfDecimal) & mSuffix
		Case "off"
			mLbl.Text = ""
	End Select
	
	If alarm1_state Then
		If Value > alarm1_value Then
			If alarm1_color1 <> mBarColor1 And alarm1_color2 <> mBarColor2 Then
				gd.Initialize(color_orientation, Array As Int(alarm1_color1, alarm1_color2))
				pnlBar.As(Panel).Background = gd
			End If
			If alarm1_once And SubExists(mCallBack, mEventName & "_Alarm1") Then
				CallSub2(mCallBack, mEventName & "_Alarm1", Value)
				alarm1_once = False
			End If
		Else
			alarm1_once = True
			gd.Initialize(color_orientation, Array As Int(mBarColor1, mBarColor2))
			pnlBar.As(Panel).Background = gd
		End If
	End If
	If alarm2_state Then
		If realValue > alarm2_value Then
			If alarm2_color1 <> mBarColor1 And alarm2_color2 <> mBarColor2 Then
				gd.Initialize(color_orientation, Array As Int(alarm2_color1, alarm2_color2))
				pnlBar.As(Panel).Background = gd
			End If
			If alarm2_once And SubExists(mCallBack, mEventName & "_Alarm2") Then
				CallSub2(mCallBack, mEventName & "_Alarm2", realValue)
				alarm2_once = False
			End If
		Else
			alarm2_once = True
			gd.Initialize(color_orientation, Array As Int(mBarColor1, mBarColor2))
			pnlBar.As(Panel).Background = gd
		End If
	End If
End Sub

'Value - 1-100, realValue - used instead Value when ShowValue = "value"
Public Sub Progress(Value As Float, realValue As Float)
	xValue = Value
	xrealValue = realValue
	AnimateValueTo(Value, realValue)
End Sub

'state - on or off, alarm on value(in %), new gradient Colors
Public Sub SetAlarm1(state As Boolean, value As Float, color1 As Int, color2 As Int)
	alarm1_state = state
	alarm1_value = value
	alarm1_color1 = color1
	alarm1_color2 = color2
End Sub

'state - on or off, alarm on value(in realValue), new gradient Colors
Public Sub SetAlarm2(state As Boolean, realvalue As Float, color1 As Int, color2 As Int)
	alarm2_state = state
	alarm2_value = realvalue
	alarm2_color1 = color1
	alarm2_color2 = color2
End Sub

Public Sub lBase As Label
	Return mLbl
End Sub

Private  Sub pnlBackground_Click
	If SubExists(mCallBack, mEventName & "_Click") Then
		If mShowValue = "%" Or mShowValue = "off"  Then
			CallSub2(mCallBack, mEventName & "_Click", xValue)
		Else
			CallSub2(mCallBack, mEventName & "_Click", xrealValue)
		End If
	End If
End Sub

Public Sub getPercentage As Float
	Return xValue
End Sub
Public Sub setPercentage(v As Float)
	xValue = v
	xrealValue = 0
	AnimateValueTo(v, 0)
End Sub

'values: LeftToRight, RightToLeft, UpToDown, DownToUp
Public Sub setDirection(dir As String)
	mDirection = dir
End Sub
Public Sub getDirection As String
	Return mDirection
End Sub

Public Sub setBackgroundColor(c As Int)
	mBackgroundColor = c
End Sub
Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

Public Sub setBarColor1(c As Int)
	mBarColor1 = c
End Sub
Public Sub getBarColor1 As Int
	Return mBarColor1
End Sub

Public Sub setBarColor2(c As Int)
	mBarColor2 = c
End Sub
Public Sub getBarColor2 As Int
	Return mBarColor2
End Sub

'values: %, value, off
Public Sub setShowValue(v As String)
	mShowValue = v
End Sub
Public Sub getShowValue As String
	Return mShowValue
End Sub

Public Sub setNrOfDecimal(d As Int)
	mNrOfDecimal = d
End Sub
Public Sub getNrOfDecimal As Int
	Return mNrOfDecimal
End Sub

Public Sub setPrefix(s As String)
	mPrefix = s
End Sub
Public Sub getPrefix As String
	Return mPrefix
End Sub

Public Sub setSuffix(s As String)
	mSuffix = s
End Sub
Public Sub getSuffix As String
	Return mSuffix
End Sub

Private Sub AnimateValueTo(NewValue As Float, realValue As Float)
	Dim n As Long = DateTime.Now
	Dim duration As Int = Abs(currentValue - NewValue) / 100 * DurationFromZeroTo100 + 1000
	Dim start As Float = currentValue
	currentValue = NewValue
	Dim tempValue As Float
	Do While DateTime.Now < n + duration
		tempValue = ValueFromTimeEaseInOut(DateTime.Now - n, start, NewValue - start, duration)
		DrawValue(tempValue, realValue)
		Sleep(10)
		If NewValue <> currentValue Then Return 'will happen if another update has started
	Loop
	DrawValue(currentValue, realValue)
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




