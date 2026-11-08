B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'v.0.30 Pin object: line + two connection points

Private Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public Name As String = "Pin_" & DateTime.Now	'default auto-generated name
	Private mScale As Double = 1.0
		
	Public mLine, mPoint1, mPoint2 As B4XView, mRoot As B4XView
	Public LineColor As Int = xui.Color_Blue
	Private mTextLinesGap As Int = 15dip
	Private mLineThinknessPx As Int = 2dip
	Private mLineLenghtPx As Int = 10dip
	Private mPointSizePx As Int = mLineThinknessPx * 5
	Private mTextSize As Float = 7
	Public TextLinesGap, LineThinknessPx, LineLenghtPx, PointSizePx As Int, TextSize As Float
	
	Public mName As B4XView
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String) As b4xVectEdit_pin
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
	TextLinesGap = Max(10dip, Calc(mTextLinesGap))
	LineThinknessPx = Calc(mLineThinknessPx)
	LineLenghtPx = Calc(mLineLenghtPx)
	PointSizePx = Calc(mPointSizePx)
	TextSize = Max(mTextSize, Calc(mTextSize))	'TextSize = mTextSize	'Max(mTextSize, Calc(mTextSize))
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	
	mRoot = xui.CreatePanel("mRoot")
	mBase.AddView(mRoot, 0, 0, mBase.Width, mBase.Height)
	mRoot.SetColorAndBorder(xui.Color_Transparent, 1dip, xui.Color_Transparent, 0)	'transparent container xui.Color_ARGB(50, 0, 199, 0)
	
	Dim Lbl As Label
	Lbl.Initialize("mName")
	Lbl.Text = Name
	Lbl.TextSize = TextSize
	mName = Lbl
	Dim LabelWidth As Int = (MeasureTextWidth(Name, xui.CreateDefaultFont(mName.TextSize + 2)))
	LineLenghtPx = LabelWidth + LineThinknessPx
	mRoot.AddView(mName, PointSizePx + LineThinknessPx, 0, LabelWidth, TextLinesGap)

	mPoint1 = xui.CreatePanel("mPoint1")
	mRoot.AddView(mPoint1, 0, TextLinesGap, PointSizePx, PointSizePx)
	
	mLine = xui.CreatePanel("")
	mRoot.AddView(mLine, PointSizePx, (PointSizePx - LineThinknessPx) / 2 + TextLinesGap, LineLenghtPx, LineThinknessPx)

	mPoint2 = xui.CreatePanel("mPoint2")
	mRoot.AddView(mPoint2, PointSizePx + LineLenghtPx, TextLinesGap, PointSizePx, PointSizePx)
		
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Sub getLength As Float
	Return (PointSizePx * 2 + LineLenghtPx)
End Sub

Sub Base_Resize (Width As Double, Height As Double)
	Dim LabelWidth As Int = (MeasureTextWidth(Name, xui.CreateDefaultFont(mName.TextSize + 2)))
	LineLenghtPx = LabelWidth + LineThinknessPx
	mName.SetLayoutAnimated(0, PointSizePx + LineThinknessPx, 0, LabelWidth, TextLinesGap)
	
	mPoint1.SetLayoutAnimated(0, 0, TextLinesGap, PointSizePx, PointSizePx)
	mPoint1.SetColorAndBorder(xui.Color_Transparent, LineThinknessPx, LineColor, PointSizePx)	'Connection point1 as square
	mPoint1.BringToFront
	
	mLine.SetLayoutAnimated(0, PointSizePx, (PointSizePx - LineThinknessPx) / 2 + TextLinesGap, LineLenghtPx, LineThinknessPx)
	mLine.SetColorAndBorder(LineColor, 0, LineColor, 0)    'line as rectangle between Points
	
	mPoint2.SetLayoutAnimated(0, PointSizePx + LineLenghtPx, TextLinesGap, PointSizePx, PointSizePx)
	mPoint2.SetColorAndBorder(xui.Color_Transparent, LineThinknessPx, LineColor, PointSizePx)	'Connection point1 as square
	mPoint2.BringToFront
	
	mRoot.Width = mPoint2.Left + mPoint2.Width 
	mRoot.Height = mPoint2.Top + mPoint2.Height 
	Sleep(0)
End Sub


Private Sub mRoot_MouseClicked (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed Then
		Log("Pin click: " & Name)
		If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
			CallSub(mCallBack, mEventName & "_Click")
		End If
	Else if EventData.SecondaryButtonPressed Then
		Log("Pin longclick: " & Name)
		If xui.SubExists(mCallBack, mEventName & "_LongClick", 0) Then
			CallSub(mCallBack, mEventName & "_LongClick")
		End If
	End If
	EventData.Consume
End Sub

Private Sub mPoint1_MouseClicked (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed Then
		'Log("mPoint1 click: " & Name)
		If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
			CallSub(mCallBack, mEventName & "_Click")
		End If
	Else if EventData.SecondaryButtonPressed Then
		'Log("mPoint1 longclick: " & Name)
		If xui.SubExists(mCallBack, mEventName & "_LongClick", 0) Then
			CallSub(mCallBack, mEventName & "_LongClick")
		End If
	End If
	EventData.Consume
End Sub

Private Sub mPoint2_MouseClicked (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed Then
		'Log("mPoint2 click: " & Name)
		If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
			CallSub(mCallBack, mEventName & "_Click")
		End If
	Else if EventData.SecondaryButtonPressed Then
		'Log("mPoint2 longclick: " & Name)
		If xui.SubExists(mCallBack, mEventName & "_LongClick", 0) Then
			CallSub(mCallBack, mEventName & "_LongClick")
		End If
	End If
	EventData.Consume
End Sub


'https://www.b4x.com/android/forum/threads/b4x-xui-add-measuretextwidth-and-measuretextheight-to-b4xcanvas.91865/#content
Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
	Private bmp As Bitmap
	bmp.InitializeMutable(1, 1)'ignore
	Private cvs As Canvas
	cvs.Initialize2(bmp)
	Return cvs.MeasureStringWidth(Text, Font1.ToNativeFont, Font1.Size)
#Else If B4i
    Return Text.MeasureWidth(Font1.ToNativeFont)
#Else If B4J
	Dim jo As JavaObject
	jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
	jo.RunMethod("setFont",Array(Font1.ToNativeFont))
	jo.RunMethod("setLineSpacing",Array(0.0))
	jo.RunMethod("setWrappingWidth",Array(0.0))
	Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
	Return Bounds.RunMethod("getWidth",Null)
#End If
End Sub