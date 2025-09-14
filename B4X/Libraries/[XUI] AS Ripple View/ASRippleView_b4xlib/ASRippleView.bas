B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
'Author: Alexander Stolte
'Version: 1.0
'AS Ripple View

#If Documentation
Updates
V1.00
	-Release
V1.01
	-BugFixes and Improvements
	-Add Designer Property StartOnStartup - Starts the animation as soon as the view has been built
		-Default: False
	-Add get and set CircleStartGap - A gap where the animation begins
		-Useful if the view is behind a view and the animation should only start when the view is finished
		-Default: 0
#End If

#DesignerProperty: Key: StartOnStartup, DisplayName: StartOnStartup, FieldType: Boolean, DefaultValue: False, Description: Starts the animation as soon as the view has been built
#DesignerProperty: Key: Duration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 800, Description: The Duration of the Ripple Animation. Default is 800.
#DesignerProperty: Key: FadeDuration, DisplayName: Fade Duration, FieldType: Int, DefaultValue: 3000, Description: The Duration of the Ripple Animation. Default is 3000.
#DesignerProperty: Key: RippleColor, DisplayName: Ripple Color, FieldType: Color, DefaultValue: 0xFF39569A, Description: The Color of the Ripple Effect.

'#Event: AnimationCompleted'comes with the next update

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private running As Boolean = False
	Private ripple_bmp As B4XBitmap
	
	'p = properties
	Private m_duration As Int
	Private m_fadeduration As Int
	Private m_color As Int
	Private m_StartOnStartup As Boolean
	Private m_CircleStartGap As Float
	
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

#If B4A or B4I
	mBase.SetColorAndBorder(xui.Color_Transparent,0,xui.Color_Transparent,mBase.width/2)
#End If

	ini_props(Props)

	CreateHaloEffect
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If

	If m_StartOnStartup Then Start

End Sub

Private Sub ini_props(Props As Map)
	
	m_duration = Props.Get("Duration")
	m_fadeduration = Props.Get("FadeDuration")
	m_color = xui.PaintOrColorToColor(Props.Get("RippleColor"))
	m_StartOnStartup = Props.GetDefault("StartOnStartup",False)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)  
	mBase.SetLayoutAnimated(0,mBase.Left,mBase.Top,Width,Height)
End Sub

#Region Properties

'Adds the View per code to the Parent (base)
Public Sub AddView(base As Object,duration As Int,fade_duration As Int, ripple_color As Int)
	
	Dim tmp_map As Map
	tmp_map.Initialize
	tmp_map.Put("Duration",duration)
	tmp_map.Put("FadeDuration",fade_duration)
	tmp_map.Put("RippleColor",ripple_color)
	
	Dim tmp_lbl As Label
	tmp_lbl.Initialize("")
	
	DesignerCreateView(base,tmp_lbl,tmp_map)
	
End Sub

'A gap where the animation begins
'Useful if the view is behind a view and the animation should only start when the view is finished
Public Sub getCircleStartGap As Float
	Return m_CircleStartGap
End Sub

Public Sub setCircleStartGap(Gap As Float)
	m_CircleStartGap = Gap
End Sub

Public Sub setDuration(duration As Int)
	m_duration = duration
End Sub

Public Sub getDuration As Int
	Return m_duration
End Sub

Public Sub setFadeDuration(duration As Int)
	m_fadeduration = duration
End Sub

Public Sub getFadeDuration As Int
	Return m_fadeduration
End Sub

Public Sub setRippleColor(color As Int)
	m_color = color
End Sub

Public Sub getRippleColor As Int
	Return m_color
End Sub

'Starts the animation
Public Sub Start
	running = True
	Effect
End Sub

'Stops the Animation
Public Sub Stop
	running = False
End Sub

'Checks the state of the animation
Public Sub getIsRunning As Boolean
	Return running
End Sub

'Applys the changes on the View for example: change color
Public Sub Apply
	CreateHaloEffect
End Sub

#End Region

#Region Functions
'https://www.b4x.com/android/forum/threads/b4x-xui-simple-halo-animation.80267/#content
Private Sub CreateHaloEffect
	
	Dim cvs As B4XCanvas
	Dim p As B4XView = xui.CreatePanel("")

	p.SetLayoutAnimated(0, 0, 0, mBase.Width/2 * 2, mBase.Width/2 * 2)
	cvs.Initialize(p)
	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, m_color, True, 0)
	ripple_bmp= cvs.CreateBitmap
	
End Sub

Private Sub Effect
	Do While running = True
		CreateHaloEffectHelper(mBase, mBase.Width/2, mBase.Height/2, mBase.Width/2)
		Sleep(m_duration)
	Loop
End Sub

Sub CreateHaloEffectHelper (Parent As B4XView, x As Int, y As Int, radius As Int)
	Dim iv As ImageView
	iv.Initialize("")
	Dim p As B4XView = iv
	p.SetBitmap(ripple_bmp)
	Parent.AddView(p, x - IIf(m_CircleStartGap>0,m_CircleStartGap/2,0), y - IIf(m_CircleStartGap>0,m_CircleStartGap/2,0), m_CircleStartGap, m_CircleStartGap)
	p.SetLayoutAnimated(m_fadeduration, x - radius, y - radius, 2 * radius, 2 * radius)
	p.SetVisibleAnimated(m_fadeduration, False)
	Sleep(m_fadeduration)
	p.RemoveViewFromParent
End Sub

#End Region

