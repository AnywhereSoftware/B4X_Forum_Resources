B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'v.0.30 Rectangle object

Private Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private mScale As Double = 1.0
	
	Public mRect As B4XView
	Public BorderColor As Int = xui.Color_Black
	Private mBorderThicknessPx As Int = 2dip
	Private mSideGap As Int = 40dip
	Public BorderThicknessPx, SideGap As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String) As b4xVectEdit_rect
	mEventName = EventName
	mCallBack = Callback
	setScale(mScale)
	Return Me
End Sub

Private Sub Calc(v As Double) As Double
	Return v * mScale
End Sub

Public Sub setScale(newScale As Float)
	mScale = newScale
	BorderThicknessPx = Max(1dip, Calc(mBorderThicknessPx))
	SideGap = Max(1dip, Calc(mSideGap))
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mBase.SetColorAndBorder(xui.Color_Transparent,  1dip, xui.Color_Transparent, 0)	'transparent container xui.Color_ARGB(50, 199, 0, 0)
    Tag = mBase.Tag
    mBase.Tag = Me
	
	mRect = xui.CreatePanel("")
	mBase.AddView(mRect,  SideGap,  SideGap,  mBase.Width - 2 * SideGap,  mBase.Height - 2 * SideGap)
	
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Sub Base_Resize (Width As Double, Height As Double)
	mRect.SetLayoutAnimated(0, SideGap, SideGap,  Width - 2 * SideGap, Height - 2 * SideGap)
	mRect.SetColorAndBorder(xui.Color_Transparent, BorderThicknessPx, BorderColor, 0)	'rectangle
	Sleep(0)
End Sub