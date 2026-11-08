B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-B4I Better Animations
	-Add getBase
V1.02
	-Add DisabledCheckedBackgroundColor property and designer property
	-Add DisabledUnCheckedBackgroundColor property and designer property
	-Add Enable property - enable or disable the view
	-BugFixes
V1.03
	-Add Designer Property Animation -Select-Animation NONE=without Slide=the normal animation
V1.04
	-BugFix - Enabled = False, now the view is disabled, no touch gestures allowed
V1.05
	-Base_Resize is now public
#End If
#DesignerProperty: Key: Animation, DisplayName: Animation, FieldType: String, DefaultValue: NONE, List: NONE|Slide

#DesignerProperty: Key: CheckedBackgroundColor, DisplayName: Checked Background Color, FieldType: Color, DefaultValue: 0xFF2D8879 
#DesignerProperty: Key: UnCheckedBackgroundColor, DisplayName: Unchecked Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: DisabledCheckedBackgroundColor, DisplayName: Disabled Checked Background Color, FieldType: Color, DefaultValue: 0x98FFFFFF
#DesignerProperty: Key: DisabledUnCheckedBackgroundColor, DisplayName: Disabled Unchecked Background Color, FieldType: Color, DefaultValue: 0x98FFFFFF

#DesignerProperty: Key: BorderWidth, DisplayName: Border Width, FieldType: Int, DefaultValue: 2, MinRange: 1
'#DesignerProperty: Key: CheckedAnimated, DisplayName: Checked Animated, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: True, Description: Whether to make a haptic feedback when the user clicks on the control.

#Event: CheckedChange(Checked As Boolean)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_background As B4XView
	Private xpnl_dot As B4XView
	
	Private g_checked_background_color As Int
	Private g_unchecked_background_color As Int
	
	Private g_disabled_checked_background_color As Int
	Private g_disabled_unchecked_background_color As Int
	
	Private g_enabled As Boolean
	
	Private g_checked As Boolean = False
	Private g_border_width As Int
	Private g_Animation As String
	'Private g_checked_animated As Boolean
	Public g_Haptic As Boolean
	#If B4I
	Private timer1           As Timer
	Type tagAnimationInfo (xPos1, yPos1, radius1, xPos2, yPos2, radius2 As Float, startTime, finishTime As Long,crl As Int)
	Private udtAnimationInfo As tagAnimationInfo
	#End If
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
	ini_props(Props)

	xpnl_background = xui.CreatePanel("xpnl_background")
	xpnl_dot = xui.CreatePanel("")
	mBase.AddView(xpnl_background,0,0,0,0)
	xpnl_background.AddView(xpnl_dot,0,0,0,0)
	
	xpnl_background.Enabled = g_enabled
	
	UpdateStyle
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If

End Sub

Private Sub ini_props(Props As Map)
	g_enabled = mBase.Enabled
	
	g_checked_background_color = xui.PaintOrColorToColor(Props.Get("CheckedBackgroundColor"))
	g_unchecked_background_color = xui.PaintOrColorToColor(Props.Get("UnCheckedBackgroundColor"))
	
	g_disabled_checked_background_color = xui.PaintOrColorToColor(Props.Get("DisabledCheckedBackgroundColor"))
	g_disabled_unchecked_background_color = xui.PaintOrColorToColor(Props.Get("DisabledUnCheckedBackgroundColor"))
	
	g_border_width = Props.Get("BorderWidth")
	g_Animation = Props.GetDefault("Animation","NONE")
	'g_checked_animated = Props.Get("CheckedAnimated")
	g_Haptic = Props.Get("HapticFeedback")
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
  
	xpnl_background.SetLayoutAnimated(0,0,0,Width,Height)
	
	Dim clr_checked_background As Int = g_checked_background_color
	If g_enabled = False Then clr_checked_background = g_disabled_checked_background_color
	
	Dim clr_unchecked_background As Int = g_unchecked_background_color
	If g_enabled = False Then clr_unchecked_background = g_disabled_unchecked_background_color
	
	If g_checked = True Then
		xpnl_background.SetColorAndBorder(xui.Color_Transparent,g_border_width,clr_checked_background,Height/2)
	Else
		xpnl_background.SetColorAndBorder(xui.Color_Transparent,g_border_width,clr_unchecked_background,Height/2)
	End If
End Sub

Public Sub setChecked(b_checked As Boolean)
	g_checked = b_checked
	Check(b_checked)
End Sub

Public Sub getChecked As Boolean
	Return g_checked 
End Sub

Public Sub getBase As B4XView
	Return mBase
End Sub

Private Sub Check(b_checked As Boolean)
	
	Dim clr_checked_background As Int = g_checked_background_color
	If g_enabled = False Then clr_checked_background = g_disabled_checked_background_color
	
	Dim clr_unchecked_background As Int = g_unchecked_background_color
	If g_enabled = False Then clr_unchecked_background = g_disabled_unchecked_background_color
	
	Dim animation_duration As Int = 250
	If g_Animation = "NONE" Then animation_duration = 0
	
	If b_checked Then
		
		For Each xview As B4XView In mBase.Parent.GetAllViewsRecursive
			If xview.Tag Is ASRadioButton And xview.Tag <> Me Then
				Dim xasrb As ASRadioButton = xview.Tag
				If xasrb.Checked = True Then xasrb.Checked = False
			End If
		Next
		g_checked = True
		CheckedChange
		xpnl_background.SetColorAndBorder(xui.Color_Transparent,g_border_width,clr_checked_background,xpnl_background.Height/2)
		xpnl_dot.SetLayoutAnimated(0,xpnl_background.Width/2 - 1dip/2,xpnl_background.Height/2 - 1dip/2,1dip,1dip)
		xpnl_dot.Visible = True
		
		If g_Animation = "Slide" Then
		#If B4A or B4J
		xpnl_dot.SetLayoutAnimated(animation_duration,0,0,xpnl_background.Width,xpnl_background.Height)
		xpnl_dot.SetColorAndBorder(clr_checked_background,0,0,xpnl_background.Height/2)
		#Else
			DrawAnimatedCircle(animation_duration,xpnl_background.Width/2,xpnl_background.Height/2,1,xpnl_background.Width/2,xpnl_background.Height/2,xpnl_background.Height,clr_checked_background)
		#End If
			Sleep(animation_duration)
		End If
		#If B4A or B4J
		#If B4A
		If g_enabled = False Then clr_checked_background = g_disabled_checked_background_color Else clr_checked_background = g_checked_background_color
		xpnl_dot.SetColorAndBorder(clr_checked_background,0,0,(xpnl_background.Height/2)/2)
		#End If
		xpnl_dot.SetLayoutAnimated(animation_duration,(xpnl_background.Width - (xpnl_background.Height/2))/2,(xpnl_background.Height - (xpnl_background.Height/2))/2,xpnl_background.Width/2,xpnl_background.Height/2)
		#If B4J
		Sleep(animation_duration)
		If g_enabled = False Then clr_checked_background = g_disabled_checked_background_color Else clr_checked_background = g_checked_background_color
		xpnl_dot.SetColorAndBorder(clr_checked_background,0,0,(xpnl_background.Height/2)/2)
		#End If
		#Else
		DrawAnimatedCircle(animation_duration,xpnl_background.Width/2,xpnl_background.Height/2,xpnl_background.Width,xpnl_background.Width/2,xpnl_background.Height/2,xpnl_background.Height/4,clr_checked_background)
		#End If
	

	Else
		CheckedChange
		xpnl_background.SetColorAndBorder(xui.Color_Transparent,g_border_width,clr_unchecked_background,mBase.Height/2)
		If g_Animation = "Slide" Then
		#If B4A or B4J
		xpnl_dot.SetColorAndBorder(clr_unchecked_background,0,0,mBase.Height/2)
		xpnl_dot.SetLayoutAnimated(animation_duration,0,0,mBase.Width,mBase.Height)
		#Else
			DrawAnimatedCircle(animation_duration,xpnl_background.Width/2,xpnl_background.Height/2,mBase.Height/4,xpnl_background.Width/2,xpnl_background.Height/2,mBase.Height,clr_unchecked_background)
		#End If
			Sleep(animation_duration)
		End If
		If g_enabled = False Then clr_unchecked_background = g_disabled_unchecked_background_color Else clr_unchecked_background = g_unchecked_background_color
		
		#If B4A or B4J
		xpnl_dot.SetLayoutAnimated(animation_duration,mBase.Width/2 - 1dip/2,mBase.Height/2 - 1dip/2,1dip,1dip)
		#Else
		DrawAnimatedCircle(animation_duration,xpnl_background.Width/2,xpnl_background.Height/2,xpnl_dot.Width,xpnl_background.Width/2,xpnl_background.Height/2,0,clr_unchecked_background)
		#End If
		Sleep(animation_duration)
		xpnl_dot.Visible = False
		
	End If
	
End Sub

#If B4I
Private Sub DrawAnimatedCircle (duration As Int, xPos1 As Float, yPos1 As Float, radius1 As Float, xPos2 As Float, yPos2 As Float, radius2 As Float,crl As Int)
	
	udtAnimationInfo.xPos1     = xPos1
	udtAnimationInfo.yPos1     = yPos1
	udtAnimationInfo.radius1   = radius1
	udtAnimationInfo.xPos2     = xPos2
	udtAnimationInfo.yPos2     = yPos2
	udtAnimationInfo.radius2   = radius2
	udtAnimationInfo.startTime = DateTime.Now
	udtAnimationInfo.finishTime = DateTime.Now + duration
	udtAnimationInfo.crl = crl
	timer1.Initialize ("timer1", 1)
	timer1.Enabled = True
	timer1_tick
	
End Sub

Private Sub timer1_tick
	Dim currentTime As Long = DateTime.Now
	Dim Coef As Double = Min ((currentTime - udtAnimationInfo.startTime) / (udtAnimationInfo.finishTime - udtAnimationInfo.startTime), 1.0)
	Dim radius As Float = udtAnimationInfo.radius1 + Coef * (udtAnimationInfo.radius2 - udtAnimationInfo.radius1)
	Dim xPos As Float = udtAnimationInfo.xPos1 + Coef * (udtAnimationInfo.xPos2 - udtAnimationInfo.xPos1)
	Dim yPos As Float = udtAnimationInfo.yPos1 + Coef * (udtAnimationInfo.yPos2 - udtAnimationInfo.yPos1)
	xpnl_dot.Visible = True
	xpnl_dot.SetColorAndBorder(udtAnimationInfo.crl,0, udtAnimationInfo.crl, radius)
	xpnl_dot.SetLayoutAnimated (0, xPos - radius, yPos - radius, 2 * radius, 2 * radius)
	If currentTime >= udtAnimationInfo.finishTime Then timer1.Enabled = False
End Sub
#End If

#If B4J
Private Sub xpnl_background_MouseClicked (EventData As MouseEvent)
If g_enabled = False Then Return
If g_checked = False Then
		setChecked(True)
'	Else
'		setChecked(False)
	End If
End Sub
#Else
Private Sub xpnl_background_Click
	If g_enabled = False Then Return
	If g_Haptic Then XUIViewsUtils.PerformHapticFeedback(mBase)
	If g_checked = False Then
		setChecked(True)
'	Else
'		setChecked(False)
	End If
End Sub
#End If

Private Sub UpdateStyle
	Dim clr_checked_background As Int = g_checked_background_color
	If g_enabled = False Then clr_checked_background = g_disabled_checked_background_color
	
	Dim clr_unchecked_background As Int = g_unchecked_background_color
	If g_enabled = False Then clr_unchecked_background = g_disabled_unchecked_background_color
	
	If g_checked = True Then
		xpnl_background.SetColorAndBorder(xui.Color_Transparent,g_border_width,clr_checked_background,xpnl_background.Height/2)
		xpnl_dot.SetColorAndBorder(clr_checked_background,0,0,xpnl_dot.Height/2)
	Else
		xpnl_background.SetColorAndBorder(xui.Color_Transparent,g_border_width,clr_unchecked_background,xpnl_background.Height/2)
		xpnl_dot.SetColorAndBorder(clr_unchecked_background,0,0,xpnl_dot.Height/2)
	End If
End Sub


Public Sub setBorderWidth(width As Int)
	g_border_width = width
	UpdateStyle
End Sub

Public Sub setCheckedBackgroundColor(crl As Int)
	g_checked_background_color = crl
	UpdateStyle
End Sub

Public Sub setUncheckedBackgroundColor(crl As Int)
	g_unchecked_background_color = crl
	UpdateStyle
End Sub

Public Sub setEnabled(enable As Boolean)
	g_enabled = enable
	mBase.Enabled = enable
	xpnl_background.Enabled = enable
	UpdateStyle
End Sub

Public Sub getEnabled As Boolean
	Return g_enabled
End Sub

Public Sub getDisabledCheckedBackgroundColor As Int
	Return  g_disabled_checked_background_color
End Sub

Public Sub setDisabledCheckedBackgroundColor(crl As Int)
	g_disabled_checked_background_color = crl
	UpdateStyle
End Sub

Public Sub getDisabledUncheckedBackgroundColor As Int
	Return  g_disabled_unchecked_background_color
End Sub

Public Sub setDisabledUncheckedBackgroundColor(crl As Int)
	g_disabled_unchecked_background_color = crl
	UpdateStyle
End Sub

'Public Sub setCheckedAnimated(animated As Boolean)
'	g_checked_animated = animated
'End Sub

#Region Events

Private Sub CheckedChange
	If xui.SubExists(mCallBack,mEventName & "_CheckedChange",1) Then
		CallSub2(mCallBack,mEventName & "_CheckedChange",g_checked)
	End If
End Sub

#End Region