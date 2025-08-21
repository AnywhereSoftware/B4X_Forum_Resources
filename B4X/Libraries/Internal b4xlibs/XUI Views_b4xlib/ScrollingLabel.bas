B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Private mText As String
	Private taskIndex As Int
	Private fnt As B4XFont
	Private cvs As B4XCanvas
	Public Tag As Object
	Public WidthPerSecond As Int = 100dip
	Public StartPositionDelay As Int = 1000
	Private mTextColor As Int = xui.Color_Black
End Sub


Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	'In B4J the passed panel doesn't clip its child views. We need to add another one:
	Dim p As B4XView = xui.CreatePanel("")
	mBase.AddView(p, 0, 0, mBase.Width, mBase.Height)
	mText = Lbl.Text
	Dim l As B4XView = Lbl
	fnt = l.Font
	mTextColor = l.TextColor
	If mTextColor = xui.Color_Transparent Then mTextColor = xui.Color_Black
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	cvs.Initialize(p)
	setText(mText)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mBase.GetView(0).SetLayoutAnimated(0, 0, 0, Width, Height)
	setText(mText)
End Sub

Public Sub setText(t As String)
	Dim NeedToCreateNewLabel As Boolean = True
	Dim parent As B4XView = mBase.GetView(0)
	If parent.NumberOfViews > 0 Then
		'If the previous state was static then we can reuse it.
		Dim p As B4XView = parent.GetView(0)
		If p.Tag = "static" Then
			NeedToCreateNewLabel = False
			p.SetLayoutAnimated(0, 0, 0, parent.Width, parent.Height)
			Dim xlbl As B4XView = p.GetView(0)
			xlbl.SetLayoutAnimated(0, 0, 0, parent.Width, parent.Height)
			
		End If
	End If
	Dim originalTextWidth As Float = MeasureTextWidth(t, fnt)
	mText = t
	If NeedToCreateNewLabel Then
		parent.RemoveAllViews
		Dim p As B4XView = xui.CreatePanel("")
		parent.AddView(p, 0, 0, parent.Width, parent.Height)
		Dim lbl As Label
		lbl.Initialize("")
	#if B4A
		lbl.SingleLine = True
		lbl.Padding = Array As Int(0, 0, 0, 0)
	#end if
		Dim xlbl As B4XView = lbl
		xlbl.SetTextAlignment("CENTER", "LEFT")
		xlbl.Font = fnt
		
		p.AddView(xlbl, 0, 0, mBase.Width, mBase.Height)
	End If
	xlbl.TextColor = mTextColor
	If originalTextWidth <= mBase.Width Then
		xlbl.Text = t
		p.Tag = "static"
		StopScrolling
	Else
		p.Tag = ""
		Dim duplicateText As String = t & "   " & t
		Dim Width As Float = MeasureTextWidth(duplicateText, fnt)
		p.Width = Width
		xlbl.Width = Width
		xlbl.Text = duplicateText
		StartScrolling (p, originalTextWidth)
	End If
End Sub

Public Sub getText As String
	Return mText
End Sub

Private Sub StopScrolling
	taskIndex = taskIndex + 1
End Sub

Private Sub StartScrolling (p As B4XView, OriginalWidth As Float)
	taskIndex = taskIndex + 1
	Dim myIndex As Int = taskIndex
	Dim duration As Int = p.Width / WidthPerSecond * 1000
	Sleep(StartPositionDelay)
	If myIndex <> taskIndex Then Return
	Do While True
		p.SetLayoutAnimated(duration, -(p.Width - OriginalWidth), p.Top, p.Width, p.Height)
		Sleep(duration)
		If myIndex <> taskIndex Then Return
		Sleep(StartPositionDelay)
		If myIndex <> taskIndex Then Return
		p.SetLayoutAnimated(0, 0, p.Top, p.Width, p.Height)
	Loop
End Sub

Private Sub MeasureTextWidth(s As String, font1 As B4XFont) As Float
	Return cvs.MeasureText(s, font1).Width
End Sub

Public Sub setTextColor(c As Int)
	mTextColor = c
	setText(mText)
End Sub

Public Sub getTextColor As Int
	Return mTextColor
End Sub