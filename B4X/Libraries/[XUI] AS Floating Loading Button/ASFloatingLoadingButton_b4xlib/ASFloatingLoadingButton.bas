B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.01
@EndOfDesignText@
'Author: Alexander Stolte
'Version: 1.0

'StandardButton
#DesignerProperty: Key: ButtonText, DisplayName: Button Text, FieldType: String, DefaultValue: Upload , Description: Button Text
#DesignerProperty: Key: ButtonColor, DisplayName: Button Color, FieldType: Color, DefaultValue: 0xFF4962A4 , Description: Background Button Color

'LoadingIndicator
#DesignerProperty: Key: IndicatorColor, DisplayName: Indicator Color, FieldType: Color, DefaultValue: 0xFFFFFFFF , Description: Background Indicator Color
#DesignerProperty: Key: IndicatorStyle, DisplayName: Indicator Style, FieldType: String, , Description: Indicator Animation Type ,DefaultValue: Three Circles 1, List: Three Circles 1|Three Circles 2|Single Circle|Five Lines 1|Arc 1|Arc 2
#DesignerProperty: Key: IndicatorDuration, DisplayName: Indicator Duration, FieldType: Int, DefaultValue: 1000 , Description: Duration of the Indicator

#DesignerProperty: Key: EnableComplete, DisplayName: Enable Complete, FieldType: Boolean, DefaultValue: True, Description: if true then a icon will show after complete

'Complete
#DesignerProperty: Key: CompleteAnimation, DisplayName: Complete Animation, FieldType: String, Description: the animation of complete, DefaultValue: Circle, List: Circle|OneCircle|None

#Event: ButtonClick
#Event: AfterStart
#Event: Finished

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private cvs As B4XCanvas
	Private index As Int
	Private xpnl_background4circel As B4XView
	
	Private xlbl_baseview As B4XView
	
	Private isloading As Boolean = False

	'StandardButton
	Private xButtonText As String
	Private xButtonColor As Int

	'Indicator Properties
	Private xIndicatorColor,xIndicatorDuration As Int
	Private xIndicatorStyle As String
	
	Private xEnableComplete As Boolean
	
	'Complete
	Private xCompleteAnimation As String
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	
	ini_props(Props)
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End IF
	
End Sub

Private Sub Base_Resize (width As Double, Height As Double)
  
	If xlbl_baseview.IsInitialized = False Then
		
		ini_views
		
		cvs.Initialize(xpnl_background4circel)
		
	End If
  
	cvs.Resize(Height, Height)
  
	If isloading = False Then
  
		xlbl_baseview.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Height)
		xlbl_baseview.SetColorAndBorder(xButtonColor,0,xui.Color_Transparent,mBase.Height/2)
	Else
		xlbl_baseview.SetLayoutAnimated(0,mBase.Width/2 - mBase.Height/2,0,mBase.Height,mBase.Height)
		xlbl_baseview.SetColorAndBorder(xButtonColor,0,xui.Color_Transparent,mBase.Height/2)
	End If
  
	xpnl_background4circel.SetLayoutAnimated(0,mBase.Width/2 - mBase.Height/2,0,mBase.Height,mBase.Height)
  
End Sub

#Region Ini

Private Sub ini_views
	
	xlbl_baseview = CreateLabel("xlbl_baseview")
	xpnl_background4circel = xui.CreatePanel("")
	
	mBase.AddView(xlbl_baseview,1dip,1dip,1dip,1dip)
	mBase.AddView(xpnl_background4circel,1dip,1dip,1dip,1dip)
	mBase.Color = xui.Color_Transparent
	
	xlbl_baseview.Text = xButtonText
	xlbl_baseview.Font = xui.CreateDefaultBoldFont(15)
	xlbl_baseview.TextColor = xui.Color_White
	xlbl_baseview.SetTextAlignment("CENTER","CENTER")
	
	xpnl_background4circel.Color = xui.Color_Transparent
	xpnl_background4circel.Visible = False
End Sub

Private Sub ini_props(Props As Map)
	
	'StandardButton
	xButtonText = Props.Get("ButtonText")
	xButtonColor = xui.PaintOrColorToColor(Props.Get("ButtonColor"))
	
	'LoadingIndicator
	xIndicatorColor = xui.PaintOrColorToColor(Props.Get("IndicatorColor"))
	xIndicatorStyle = Props.Get("IndicatorStyle")
	xIndicatorDuration = Props.Get("IndicatorDuration")
	
	xIndicatorStyle = "Draw_" & xIndicatorStyle.Replace(" ", "")
	
	xEnableComplete = Props.Get("EnableComplete")
	
	'Complete
	xCompleteAnimation = Props.Get("CompleteAnimation")
	
End Sub

#End Region

#Region Properties

Public Sub getBaseView As B4XView
	
	Return mBase
	
End Sub

Public Sub getButtonView As B4XView
	
	Return xlbl_baseview
	
End Sub

Public Sub setButtonText(text As String)
	
	xButtonText = text
	xlbl_baseview.Text = text
	
End Sub

Public Sub getButtonText As String
	
	Return xButtonText
	
End Sub

Public Sub setButtonColor(color As Int)
	
	xButtonColor = color
	xlbl_baseview.Color = color
	
End Sub

Public Sub getButtonColor As Int
	
	Return xButtonColor
	
End Sub

Public Sub setIndicatorColor(color As Int)
	
	xIndicatorColor = color
	
End Sub

Public Sub getIndicatorColor As Int
	
	Return xIndicatorColor
	
End Sub

Public Sub setIndicatorStyle(style As String)
	
	xIndicatorStyle = style
	
End Sub

Public Sub getIndicatorStyle As String
	
	Return xIndicatorStyle
	
End Sub

Public Sub setIndicatorDuration(duration As Int)
	
	xIndicatorDuration = duration
	
End Sub

Public Sub getIndicatorDuration As Int
	
	Return xIndicatorDuration
	
End Sub

Public Sub setEnableComplete(enable As Boolean)
	
	xEnableComplete = enable
	
End Sub

Public Sub getEnableComplete As Boolean
	
	Return xEnableComplete
	
End Sub

Public Sub setCompleteAnimation(animation As String)
	
	xCompleteAnimation = animation
	
End Sub

Public Sub getCompleteAnimation As String
	
	Return xCompleteAnimation
	
End Sub

#End Region Properties

Public Sub Start
	
	xlbl_baseview.SetLayoutAnimated(250,mBase.Width/2 - mBase.Height/2,0,mBase.Height,mBase.Height)
	xlbl_baseview.SetColorAndBorder(xButtonColor,0,xui.Color_Transparent,mBase.Height/2)
	
	
	#If B4J
	Sleep(250/2)
	xlbl_baseview.Text = ""
	#Else
	xlbl_baseview.Text = ""
	Sleep(250/2)
	#End IF
	
	Sleep(250/2)
	xpnl_background4circel.SetVisibleAnimated(0,True)
	MainLoop
	AfterStartHandler
End Sub


Public Sub Complete
	
	If xEnableComplete = True Then
		
		If xCompleteAnimation = "Circle" Then
			xlbl_baseview.SetRotationAnimated(0,-360)
		Else If xCompleteAnimation = "OneCircle" Then
			xlbl_baseview.SetRotationAnimated(0,0)
		Else
			xlbl_baseview.SetRotationAnimated(0,360)
			
			Sleep(250)
			xlbl_baseview.Font = xui.CreateFontAwesome(45)
			
		End If
	
	
		index = index + 1
		xpnl_background4circel.SetVisibleAnimated(250,False)
	
	
		xlbl_baseview.Font = xui.CreateFontAwesome(0)
		Sleep(250)
		If Not(xCompleteAnimation = "None") = True Then xlbl_baseview.SetTextSizeAnimated(1000,45) Else xlbl_baseview.SetTextSizeAnimated(1000/3,45)
		xlbl_baseview.SetRotationAnimated(500,360)
		
		

		xlbl_baseview.Text = Chr(0xF00C)

		Sleep(1000)

	Else
			
		index = index + 1
		xpnl_background4circel.SetVisibleAnimated(250,False)
	
		Sleep(250)
		xlbl_baseview.Text = ""
		
	End If
	
	xlbl_baseview.Text = ""
	
	Sleep(250/2)
	
	xlbl_baseview.SetLayoutAnimated(250,0,0,mBase.Width,mBase.Height)
	xlbl_baseview.SetColorAndBorder(xButtonColor,0,xui.Color_Transparent,mBase.Height/2)
	
	Sleep(250/2)
	xlbl_baseview.Font = xui.CreateDefaultBoldFont(15)
	xlbl_baseview.Text = xButtonText

	FinishedHandler
	
	
End Sub

#Region Animations

Private Sub MainLoop
	
	index = index + 1
	Dim MyIndex As Int = index
	Dim n As Long = DateTime.Now
	Do While MyIndex = index
		Dim progress As Float = (DateTime.Now - n) / xIndicatorDuration
		progress = progress - Floor(progress)
		cvs.ClearRect(cvs.TargetRect)
		CallSub2(Me, xIndicatorStyle, progress)
		cvs.Invalidate
		Sleep(10)
	Loop
	
End Sub

'All Animations from the B4XLoadingIndicator from Erel
'https://www.b4x.com/android/forum/threads/b4x-xui-b4xloadingindicator-loading-indicator.92243/#content

Private Sub Draw_ThreeCircles1 (Progress As Float)
	Dim MaxR As Float = (cvs.TargetRect.Width / 2 - 20dip) / 2
	Dim r As Float = 10dip + MaxR + MaxR * Sin(Progress * 2 * cPI)
	For i = 0 To 2
		Dim alpha As Int = i * 120 + Progress * 360
		cvs.DrawCircle(cvs.TargetRect.CenterX + r * SinD(alpha), cvs.TargetRect.CenterY + r * CosD(alpha), 5dip, xIndicatorColor, True, 1dip)
	Next
End Sub


Private Sub Draw_ThreeCircles2 (Progress As Float)
	Dim MinR As Int = 5dip
	Dim MaxR As Int = cvs.TargetRect.Width / 2 / 3 - MinR -2dip
	For i = 0 To 2
		Dim r As Float = MinR + MaxR / 2 + MaxR / 2 * SinD(Progress * 360 - 60 * i)
		cvs.DrawCircle(MaxR + MinR + (MinR + MaxR + 2dip) * 2 * i, cvs.TargetRect.CenterY, r, xIndicatorColor, True, 0)
	Next
End Sub

Private Sub Draw_SingleCircle(Progress As Float)
	For i = 0 To 2
		cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.CenterX * Progress, SetAlpha(xIndicatorColor, 255 - 255 * Progress), True, 0)
	Next
End Sub

Private Sub SetAlpha (c As Int, alpha As Int) As Int
	Return Bit.And(0xffffff, c) + Bit.ShiftLeft(alpha, 24)
End Sub

Private Sub Draw_FiveLines1(Progress As Float)
	Dim MinR As Int = 10dip
	Dim MaxR As Int = cvs.TargetRect.Height / 2
	Dim dx As Int = (cvs.TargetRect.Width - 2dip) / 5
	For i = 0 To 4
		Dim r As Float = MinR + MaxR / 2 + MaxR / 2 * SinD(Progress * 360 - 30 * i)
		cvs.DrawLine(2dip + i * dx, cvs.TargetRect.CenterY - r, 2dip + i * dx, cvs.TargetRect.CenterY + r, xIndicatorColor, 4dip)
	Next
End Sub

Private Sub Draw_Arc1 (Progress As Float)
	Dim p As B4XPath
	Dim r As Float = cvs.TargetRect.CenterX - 5dip
	If Progress < 0.5 Then
		p.InitializeArc(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, r, -90, Progress * 2 * 360)
	Else
		p.InitializeArc(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, r, -90, -(1 - Progress) * 2 * 360)
	End If
	cvs.ClipPath(p)
	cvs.DrawRect(cvs.TargetRect, xIndicatorColor, True, 0)
	cvs.RemoveClip
End Sub

Private Sub Draw_Arc2 (Progress As Float)
	Dim p As B4XPath
	Dim r As Float = cvs.TargetRect.CenterX - 5dip
	If Progress < 0.5 Then
		p.InitializeArc(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, r, -90, Progress * 2 * 360)
	Else
		p.InitializeArc(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, r, -90, 360 - (Progress - 0.5) * 2 * 360)
	End If
	cvs.ClipPath(p)
	cvs.DrawRect(cvs.TargetRect, xIndicatorColor, True, 0)
	cvs.RemoveClip
End Sub

#End Region Animations

#Region Events

#If B4J

Private Sub xlbl_baseview_MouseClicked (EventData As MouseEvent)
	
	ButtonClickHandler
	
End Sub

#Else

Private Sub xlbl_baseview_Click
	
	ButtonClickHandler
	
End Sub

#End if

Private Sub ButtonClickHandler
	
	If xui.SubExists(mCallBack, mEventName & "_ButtonClick", 0) Then
		CallSub(mCallBack, mEventName & "_ButtonClick")
	End If
	
End Sub

Private Sub AfterStartHandler
	
	If xui.SubExists(mCallBack, mEventName & "_AfterStart", 0) Then
		CallSub(mCallBack, mEventName & "_AfterStart")
	End If
	
End Sub

Private Sub FinishedHandler
	
	If xui.SubExists(mCallBack, mEventName & "_Finished", 0) Then
		CallSub(mCallBack, mEventName & "_Finished")
	End If
	
End Sub

#End Region Events

Private Sub CreateLabel(EventName As String) As B4XView
	
	Dim tmp_lbl As Label
	tmp_lbl.Initialize(EventName)
	Return tmp_lbl
	
End Sub