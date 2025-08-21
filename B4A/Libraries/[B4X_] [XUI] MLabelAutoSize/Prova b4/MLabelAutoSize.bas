B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.801
@EndOfDesignText@
#Event: Click

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private mFont As B4XFont
	Private cvs As B4XCanvas
	Private mText As String
	Private mColor As Int = xui.Color_Black
	Private mPadding() As Int = Array As Int(0,0,0,0) 'left, top, right, bottom
	Private mBackgroundColor As Int = xui.Color_Transparent
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	mFont = xui.CreateDefaultFont(72)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	RedrawView(Width,Height)
End Sub

Private Sub RedrawView(Width As Double, Height As Double)
	cvs.Initialize(mBase)
	Dim cl As B4XRect
	cl.Initialize(0,0,mBase.Width, mBase.Height)
	cvs.drawRect(cl, mBackgroundColor, True, 0)
	Dim r As B4XRect
	r = cvs.MeasureText(mText, mFont)
	Dim newFont As B4XFont
	If (r.Height > r.Width) Then
		newFont = xui.CreateFont2(mFont, Floor((Height - mPadding(1) - mPadding(3))  * mFont.Size / r.Height))
	Else
		newFont = xui.CreateFont2(mFont, Floor((Width - mPadding(0) - mPadding(2))  * mFont.Size / r.Width))
	End If
	r = cvs.MeasureText(mText, newFont) 'Measure newfont
	Dim BaseLine As Int = Height/2 - r.Height / 2 - r.Top - (mPadding(3) - mPadding(1))
	cvs.DrawText(mText, Width / 2 - (mPadding(2) - mPadding(0)), BaseLine, newFont, mColor, "CENTER")
	cvs.Release
	
End Sub

public Sub getFont As B4XFont
	Return mFont
End Sub

public Sub setFont(font As B4XFont)
	mFont = font
	RedrawView(mBase.Width,mBase.Height)
End Sub

Public Sub setTextColor(color As Int)
	mColor = color
	RedrawView(mBase.Width,mBase.Height)
End Sub

public Sub getTextColor As Int
	Return mColor
End Sub

Public Sub setText(txt As String)
	mText = txt
	RedrawView(mBase.Width,mBase.Height)
End Sub

public Sub getText As String
	Return mText
End Sub

Public Sub getBase As B4XView
	Return mBase
End Sub

Public Sub setBaseHeight(height As Int)
	mBase.Height = height
	RedrawView(mBase.Width, mBase.Height)
End Sub

Public Sub setBaseWidth(width As Int)
	mBase.Width = width
	RedrawView(mBase.Width, mBase.Height)
End Sub

Public Sub getBaseWidth As Int
	Return mBase.Width
End Sub

Public Sub getBaseHeight As Int
	Return mBase.Height
End Sub
