B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@


#DesignerProperty: Key: MinusText, DisplayName: MinusText, FieldType: String, DefaultValue: -
#DesignerProperty: Key: PlusText, DisplayName: PlusText, FieldType: String, DefaultValue: +

#DesignerProperty: Key: Round, DisplayName: Round, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: CornerRadius, DisplayName: CornerRadius, FieldType: Int, DefaultValue: 10, MinRange: 0
#DesignerProperty: Key: BackgroundColor, DisplayName: BackgroundColor, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: MinusColor, DisplayName: MinusColor, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: MinusTextColor, DisplayName: MinusTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: PlusColor, DisplayName: PlusColor, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: PlusTextColor, DisplayName: PlusTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: Divider, DisplayName: Divider, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: DividerColor, DisplayName: DividerColor, FieldType: Color, DefaultValue: 0x50FFFFFF

#DesignerProperty: Key: HaloEffect, DisplayName: HaloEffect, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: HaloColor, DisplayName: HaloColor, FieldType: Color, DefaultValue: 0xFFD2D3D3

#DesignerProperty: Key: HapticFeedback, DisplayName: HapticFeedback, FieldType: Boolean, DefaultValue: True

#Event: MinusClick
#Event: PlusClick

#Event: LeftClick
#Event: RightClick

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xlbl_Minus As B4XView
	Private xlbl_Plus As B4XView
	Private xpnl_Divider As B4XView
	
	Private xpnl_HaloBackground_Minus As B4XView
	Private xpnl_HaloBackground_Plus As B4XView
	
	Private m_HaloAnimationDuration As Int = 750
	
	Private m_Round As Boolean
	Private m_CornerRadius As Int
	Private m_BackgroundColor As Int
	Private m_MinusColor As Int
	Private m_MinusTextColor As Int
	Private m_PlusColor As Int
	Private m_PlusTextColor As Int
	Private m_Divider As Boolean
	Private m_DividerColor As Int
	Private m_DividerWidth As Float = 2dip
	Private m_HaloEffect As Boolean
	Private m_HaloColor As Int
	Private m_HapticFeedback As Boolean
	Private m_MinusText As String
	Private m_PlusText As String
	
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

	xlbl_Minus = CreateLabel("xlbl_Minus")
	xlbl_Plus = CreateLabel("xlbl_Plus")
	xpnl_Divider = xui.CreatePanel("")
	xpnl_HaloBackground_Minus = xui.CreatePanel("")
	xpnl_HaloBackground_Plus = xui.CreatePanel("")

	mBase.AddView(xpnl_HaloBackground_Minus,0,0,mBase.Width/2,mBase.Height)
	mBase.AddView(xpnl_HaloBackground_Plus,mBase.Width/2,0,mBase.Width/2,mBase.Height)

	mBase.AddView(xlbl_Minus,0,0,xpnl_HaloBackground_Minus.Width,xpnl_HaloBackground_Minus.Height)
	mBase.AddView(xlbl_Plus,mBase.Width/2,0,xpnl_HaloBackground_Plus.Width,xpnl_HaloBackground_Plus.Height)

	mBase.AddView(xpnl_Divider,mBase.Width/2-1dip,(mBase.Height/2)/2,m_DividerWidth,mBase.Height/2)

	'#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	'#End If
	
End Sub

Private Sub IniProps(Props As Map)
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	m_MinusColor = xui.PaintOrColorToColor(Props.Get("MinusColor"))
	m_MinusTextColor = xui.PaintOrColorToColor(Props.Get("MinusTextColor"))
	m_PlusColor = xui.PaintOrColorToColor(Props.Get("PlusColor"))
	m_PlusTextColor = xui.PaintOrColorToColor(Props.Get("PlusTextColor"))
	m_DividerColor = xui.PaintOrColorToColor(Props.Get("DividerColor"))
	m_HaloColor = xui.PaintOrColorToColor(Props.Get("HaloColor"))
	
	m_Divider = Props.Get("Divider")
	m_HaloEffect = Props.Get("HaloEffect")
	m_HapticFeedback = Props.Get("HapticFeedback")
	m_CornerRadius = Props.Get("CornerRadius")
	m_Round = Props.Get("Round")
	m_PlusText = Props.Get("PlusText")
	m_MinusText = Props.Get("MinusText")
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	xpnl_HaloBackground_Minus.SetLayoutAnimated(0,0,0,Width/2,Height)
	xpnl_HaloBackground_Plus.SetLayoutAnimated(0,Width/2,0,Width/2,Height)
	
	xlbl_Minus.SetLayoutAnimated(0,0,0,xpnl_HaloBackground_Minus.Width,xpnl_HaloBackground_Minus.Height)
	xlbl_Plus.SetLayoutAnimated(0,Width/2,0,xpnl_HaloBackground_Plus.Width,xpnl_HaloBackground_Plus.Height)
  
	xpnl_Divider.SetLayoutAnimated(0,Width/2-m_DividerWidth/2,(Height/2)/2,m_DividerWidth,Height/2)
  
	Refresh
  
End Sub

Public Sub Refresh
	
	mBase.SetColorAndBorder(m_BackgroundColor,0,0,IIf(m_Round,mBase.Height/2, m_CornerRadius))
	SetCircleClip(mBase,IIf(m_Round,mBase.Height/2, m_CornerRadius))

	xpnl_HaloBackground_Minus.SetColorAndBorder(m_MinusColor,0,0,m_CornerRadius)
	xlbl_Minus.Color = xui.Color_Transparent
	xlbl_Minus.Font = xui.CreateDefaultBoldFont(25)
	xlbl_Minus.SetTextAlignment("CENTER","CENTER")
	xlbl_Minus.TextColor = m_MinusTextColor
	xlbl_Minus.Text = m_MinusText

	xpnl_HaloBackground_Plus.SetColorAndBorder(m_PlusColor,0,0,m_CornerRadius)
	xlbl_Plus.Color = xui.Color_Transparent
	xlbl_Plus.Font = xui.CreateDefaultBoldFont(25)
	xlbl_Plus.SetTextAlignment("CENTER","CENTER")
	xlbl_Plus.TextColor = m_PlusTextColor
	xlbl_Plus.Text = m_PlusText
	
	xpnl_Divider.SetColorAndBorder(m_DividerColor,0,0,m_DividerWidth/2)
	xpnl_Divider.Visible = m_Divider
	
End Sub

#Region Properties

Public Sub getpnlDivider As B4XView
	Return xpnl_Divider
End Sub

Public Sub getlblMinus As B4XView
	Return xlbl_Minus
End Sub

Public Sub getlblPlus As B4XView
	Return xlbl_Plus
End Sub

Public Sub getHaloAnimationDuration As Int
	Return m_HaloAnimationDuration
End Sub

Public Sub setHaloAnimationDuration(Duration As Int)
	m_HaloAnimationDuration = Duration
End Sub

Public Sub getRound As Boolean
	Return m_Round
End Sub

Public Sub setRound(isRound As Boolean)
	m_Round = isRound
End Sub

Public Sub getCornerRadius As Float
	Return m_CornerRadius
End Sub

Public Sub setCornerRadius(CornerRadius As Float)
	m_CornerRadius = CornerRadius
End Sub

Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

Public Sub setBackgroundColor(Color As Int)
	m_BackgroundColor = Color
End Sub

Public Sub getMinusColor As Int
	Return m_MinusColor
End Sub

Public Sub setMinusColor(Color As Int)
	m_MinusColor = Color
End Sub

Public Sub getMinusTextColor As Int
	Return m_MinusTextColor
End Sub

Public Sub setMinusTextColor(Color As Int)
	m_MinusTextColor = Color
End Sub

Public Sub getPlusColor As Int
	Return m_PlusColor
End Sub

Public Sub setPlusColor(Color As Int)
	m_PlusColor = Color
End Sub

Public Sub getPlusTextColor As Int
	Return m_PlusTextColor
End Sub

Public Sub setPlusTextColor(Color As Int)
	m_PlusTextColor = Color
End Sub

Public Sub getDivider As Boolean
	Return m_Divider
End Sub

Public Sub setDivider(Show As Boolean)
	m_Divider = Show
End Sub

Public Sub getDividerColor As Int
	Return m_DividerColor
End Sub

Public Sub setDividerColor(Color As Int)
	m_DividerColor = Color
End Sub

Public Sub getDividerWidth As Float
	Return m_DividerWidth
End Sub

Public Sub setDividerWidth(Width As Float)
	m_DividerWidth = Width
End Sub

Public Sub getHaloEffect As Boolean
	Return m_HaloEffect
End Sub

Public Sub setHaloEffect(Enable As Boolean)
	m_HaloEffect = Enable
End Sub

Public Sub getHaloColor As Int
	Return m_HaloColor
End Sub

Public Sub setHaloColor(Color As Int)
	m_HaloColor = Color
End Sub

Public Sub getHapticFeedback As Boolean
	Return m_HapticFeedback
End Sub

Public Sub setHapticFeedback(Enable As Boolean)
	m_HapticFeedback = Enable
End Sub

Public Sub getMinusText As String
	Return m_MinusText
End Sub

Public Sub setMinusText(Text As String)
	m_MinusText = Text
End Sub

Public Sub getPlusText As String
	Return m_PlusText
End Sub

Public Sub setPlusText(Text As String)
	m_PlusText = Text
End Sub

#End Region

#Region Events

Private Sub LeftClick
	If xui.SubExists(mCallBack, mEventName & "_MinusClick", 0) Then
		CallSub(mCallBack, mEventName & "_MinusClick")
	End If
	If xui.SubExists(mCallBack, mEventName & "_LeftClick", 0) Then
		CallSub(mCallBack, mEventName & "_LeftClick")
	End If
End Sub

Private Sub RightClick
	If xui.SubExists(mCallBack, mEventName & "_PlusClick", 0) Then
		CallSub(mCallBack, mEventName & "_PlusClick")
	End If
	If xui.SubExists(mCallBack, mEventName & "_RightClick", 0) Then
		CallSub(mCallBack, mEventName & "_RightClick")
	End If
End Sub

#If B4J
Private Sub xlbl_Minus_MouseClicked (EventData As MouseEvent)
	#Else
Private Sub xlbl_Minus_Click
#End If
	LeftClick
	If m_HapticFeedback Then XUIViewsUtils.PerformHapticFeedback(xlbl_Minus)
	If m_HaloEffect Then CreateHaloEffect(xpnl_HaloBackground_Minus,xlbl_Minus.Width/2,xlbl_Minus.Height/2,m_HaloColor)
End Sub

#If B4J
Private Sub xlbl_Plus_MouseClicked (EventData As MouseEvent)
	#Else
Private Sub xlbl_Plus_Click
#End If
	RightClick
	If m_HapticFeedback Then XUIViewsUtils.PerformHapticFeedback(xlbl_Plus)
	If m_HaloEffect Then CreateHaloEffect(xpnl_HaloBackground_Plus,xlbl_Plus.Width/2,xlbl_Plus.Height/2,m_HaloColor)
End Sub

#End Region

#Region Functions

Private Sub CreateHaloEffect (Parent As B4XView,x As Int, y As Int, clr As Int)
	Dim cvs As B4XCanvas
	Dim p As B4XView = xui.CreatePanel("")
	Dim radius As Int = 150dip
	p.SetLayoutAnimated(0, 0, 0, radius * 2, radius * 2)
	cvs.Initialize(p)
	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, clr, True, 0)
	Dim bmp As B4XBitmap = cvs.CreateBitmap
	CreateHaloEffectHelper(Parent,bmp, x, y, radius)
	Sleep(800)
End Sub

Private Sub CreateHaloEffectHelper (Parent As B4XView,bmp As B4XBitmap, x As Int, y As Int, radius As Int)
	Dim iv As ImageView
	iv.Initialize("")
	Dim p As B4XView = iv
	p.SetBitmap(bmp)

	Parent.AddView(p, x, y, 0, 0)
	'p.SendToBack
	p.SetLayoutAnimated(m_HaloAnimationDuration, x - radius, y - radius, 2 * radius, 2 * radius)
	p.SetVisibleAnimated(m_HaloAnimationDuration, False)
	Sleep(m_HaloAnimationDuration)
	p.RemoveViewFromParent
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub SetCircleClip (pnl As B4XView,radius As Int)'ignore
#if B4J
Dim jo As JavaObject = pnl
Dim shape As JavaObject
Dim cx As Double = pnl.Width
Dim cy As Double = pnl.Height
shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx, cy))
If radius > 0 Then
	Dim d As Double = radius
	shape.RunMethod("setArcHeight", Array(d))
	shape.RunMethod("setArcWidth", Array(d))
End If
jo.RunMethod("setClip", Array(shape))
#else if B4A
	Dim jo As JavaObject = pnl
	jo.RunMethod("setClipToOutline", Array(True))
	pnl.SetColorAndBorder(pnl.Color,0,0,radius)
	#Else If B4I
	Dim NaObj As NativeObject = pnl
	Dim BorderWidth As Float = NaObj.GetField("layer").GetField("borderWidth").AsNumber
	' *** Get border color ***
	Dim noMe As NativeObject = Me
	Dim BorderUIColor As Int = noMe.UIColorToColor (noMe.RunMethod ("borderColor:", Array (pnl)))
	pnl.SetColorAndBorder(pnl.Color,BorderWidth,BorderUIColor,radius)
#end if
End Sub

#If OBJC
- (UIColor *) borderColor: (UIView *) view { return [[UIColor alloc] initWithCGColor: view.layer.borderColor]; }
#End If

#End Region