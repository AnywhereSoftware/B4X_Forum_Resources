B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
#DesignerProperty: Key: Text, DisplayName: Title Text, FieldType: String, DefaultValue: Title
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 14, MinRange: 0
#DesignerProperty: Key: IconColor, DisplayName: Icon Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color for the icons
#DesignerProperty: Key: Background, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF60CFF1, Description: Background color
#DesignerProperty: Key: IsCollapsed, DisplayName: Is Collapsed, FieldType: Boolean, DefaultValue: False, Description: Set the panel to collapsed/expand mode
#DesignerProperty: Key: ShowBurgerIcon, DisplayName: Show Burger Button, FieldType: Boolean, DefaultValue: False, Description: Show the left icon
#DesignerProperty: Key: IconSpacing, DisplayName: Icon Spacing, FieldType: Int, DefaultValue: 24, MinRange: 0
#DesignerProperty: Key: IconPadding, DisplayName: Icon Padding, FieldType: Int, DefaultValue: 16, MinRange: 0
#DesignerProperty: Key: IconSize, DisplayName: Icon Size, FieldType: Int, DefaultValue: 24, MinRange: 0, Description: Width/Height of icon
#DesignerProperty: Key: IconCount, DisplayName: Icon Count, FieldType: Int, DefaultValue: 1, MinRange: 1, Description: How many icons will show
#DesignerProperty: Key: TitleBarHeight, DisplayName: TitleBar Height, FieldType: Int, DefaultValue: 56, MinRange: 0, Description: Height of title bar
#DesignerProperty: Key: PanelHeight, DisplayName: Panel Height, FieldType: Int, DefaultValue: 44, MinRange: 0, Description: Height of collapsible panel
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 0, Description: Corner Radius for main panel
#DesignerProperty: Key: Elevation, DisplayName: Elevation, FieldType: Int, DefaultValue: 0, Description: Elevation/Adds shadow
#DesignerProperty: Key: Animated, DisplayName: Animated, FieldType: Boolean, DefaultValue: False, Description: Enable collapse/expand animation
#DesignerProperty: Key: AniDuration, DisplayName: Anim.Duration, FieldType: Int, DefaultValue: 500, MinRange: 0, Description: Animation Duration time in ms

#Event: BurgerClick
#Event: TitleClick
#Event: PanelClick
#Event: IconClick(index as int)
#Event: Collapse
#Event: Expand

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private iconcnt As Int = 5
	Private iconnum As Int = 0
	Public icons(iconcnt) As B4XView
	Public TitleLabel As B4XView
	Public BurgerIcon As B4XView
	Private xpanel As B4XView
	
	Private aanimation As Boolean
	Private aduration As Int
	Private atextsize As Int = 16
	Private aheight As Int = 56dip
	Private aiconspacing As Int = 24dip
	Private aiconpadding As Int = 16dip
	Private aiconsize As Int = 24dip
	Private ashowburger As Boolean = False
	Private aiconcount As Int = 5
	Private atext As String = "Title"
	Private abackground As Int = xui.Color_Transparent
	Private atextcolor As Int = xui.Color_White
	Private aiscollapsed As Boolean = False
	Private aTitleBarHeight As Int
	Private apanelheight As Int
	Private aradius As Int
	Private aelevation As Int
	Public CollapseChar As Char
	Public ExpandChar As Char
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	CollapseChar = Chr(0xF106)
	ExpandChar = Chr(0xF107)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	aanimation = Props.Getdefault("Animated",False)
	aduration = Props.GetDefault("AniDuration",500)
	atextsize = Props.Get("TextSize")
	aheight= DipToCurrent(Props.GetDefault("Height",56dip))
	aiconspacing = DipToCurrent(Props.GetDefault("IconSpacing",24dip))
	aiconpadding = DipToCurrent(Props.GetDefault("IconPadding",16dip))
	aiconsize = DipToCurrent(Props.GetDefault("IconSize",24dip))
	ashowburger = Props.GetDefault("ShowBurgerIcon",True)
	aiconcount = Props.GetDefault("IconCount",1)
	atext = Props.Get("Text")
	abackground = xui.PaintOrColorToColor(Props.GetDefault("Background",0xff343434))
	atextcolor = xui.PaintOrColorToColor(Props.GetDefault("TextColor",0xffffffff))
	iconnum = Props.Get("IconCount")
	aiscollapsed = Props.GetDefault("IsCollapsed",False)
	aTitleBarHeight = Props.GetDefault("TitleBarHeight",56dip)
	apanelheight = Props.GetDefault("PanelHeight",56dip)
	aradius = Props.GetDefault("CornerRadius",0dip)
	aelevation = Props.GetDefault("Elevation",0dip)
	redraw
End Sub

Public Sub redraw
	Dim cs As CSBuilder
	Dim p As Panel
	p = mBase
	p.Elevation = aelevation
	
	mBase.RemoveAllViews
	mBase.Color = abackground
	
	xpanel = xui.CreatePanel("XPanel")
	xpanel.Height = mBase.Height - aTitleBarHeight-aradius
	xpanel.Color = abackground
	If aiscollapsed Then
		mBase.Height = aTitleBarHeight
	Else
		mBase.Height = aTitleBarHeight + apanelheight
	End If
	mBase.AddView(xpanel,0dip,(aTitleBarHeight+1dip),mBase.Width,apanelheight-aradius)
			
	If iconnum > iconcnt Then iconnum = iconcnt
	If iconnum > 0 Then
		Dim d As Int
		For i = 0 To iconnum - 1
			icons(i) = CreateLabel("icon" & i)
			icons(i).TextColor = xui.PaintOrColorToColor(atextcolor)
			icons(i).Color = xui.Color_Transparent
			icons(i).TextSize = aiconsize
			icons(i).tag = i
			icons(i).SetTextAlignment("CENTER","CENTER")
			d = (mBase.Width - aiconpadding - ((i+1)*aiconsize) - ((i)*aiconspacing))
			mBase.AddView(icons(i),d,0dip,aiconsize,aTitleBarHeight)
		Next
	End If
	
	If aiscollapsed Then
		icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(atextsize).Append(ExpandChar).PopAll
	Else
		icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(atextsize).Append(CollapseChar).PopAll
	End If
	
	If ashowburger Then
		BurgerIcon = CreateLabel("BurgerIcon")
		BurgerIcon.TextColor = xui.PaintOrColorToColor(atextcolor)
		BurgerIcon.Color = xui.Color_Transparent
		BurgerIcon.TextSize = atextsize
		mBase.AddView(BurgerIcon,aiconpadding,0dip,aiconsize,aTitleBarHeight)
	End If
	
	TitleLabel = CreateLabel("ltitle")
	TitleLabel.TextColor = xui.PaintOrColorToColor(atextcolor)
	TitleLabel.Color = xui.Color_Transparent
	TitleLabel.TextSize = atextsize
	TitleLabel.Text = atext
	TitleLabel.SetTextAlignment("CENTER","LEFT")
	
	If ashowburger Then
		Dim Ww As Int =mBase.Width - (4*aiconpadding) - ((iconnum+1)*aiconsize) - ((iconnum)*aiconspacing) -aiconsize
		mBase.AddView(TitleLabel,(aiconpadding*2)+aiconsize,0dip,(Ww),aTitleBarHeight)
	Else
		Dim Ww As Int = mBase.Width - ((iconnum+1)*aiconpadding) - ((iconnum+1)*aiconsize) - ((iconnum)*aiconspacing)
		mBase.AddView(TitleLabel,aiconpadding,0dip,(Ww),aTitleBarHeight)
	End If

End Sub

Private Sub CreateLabel(event As String) As B4XView
	Dim LH As Label
	LH.Initialize(event)
	LH.Ellipsize = "END"
	LH.SingleLine=True
	Return LH
End Sub

Public Sub GetBase As B4XView
	Return mBase
End Sub

Public Sub GetPanel As B4XView
	Return xpanel
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mBase.Width=Width
	mBase.Height=Height
End Sub

Public Sub Refresh
	Dim d As Int
	mBase.Color = abackground
	xpanel.Height = apanelheight-aradius
	xpanel.Color = abackground
	mBase.Height = (aTitleBarHeight+apanelheight)
	Base_Resize(mBase.Width,mBase.Height)
	If iconnum > iconcnt Then iconnum = iconcnt
	If iconnum > 0 Then
		For i = 0 To iconnum - 1
			icons(i).TextColor = xui.PaintOrColorToColor(atextcolor)
			icons(i).Color = xui.Color_Transparent
			icons(i).TextSize = aiconsize
			icons(i).tag = i
			icons(i).SetTextAlignment("CENTER","CENTER")
			d = (mBase.Width - aiconpadding - ((i+1)*aiconsize) - ((i)*aiconspacing))
			icons(i).SetLayoutAnimated(0,d,0dip,(aiconsize),(aTitleBarHeight))
		Next
	End If
	
	If ashowburger Then
		BurgerIcon.TextColor = xui.PaintOrColorToColor(atextcolor)
		BurgerIcon.Color = xui.Color_Transparent
		BurgerIcon.TextSize = atextsize
	End If
	
	TitleLabel.TextColor = xui.PaintOrColorToColor(atextcolor)
	TitleLabel.Color = xui.Color_Transparent
	TitleLabel.TextSize = atextsize
	TitleLabel.Text = atext
	TitleLabel.SetTextAlignment("CENTER","LEFT")
	
	If ashowburger Then
		Dim Ww As Int =mBase.Width - (4*aiconpadding) - ((iconnum+1)*aiconsize) - ((iconnum)*aiconspacing) -aiconsize
		TitleLabel.SetLayoutAnimated(0,(aiconpadding*2)+aiconsize,0dip,(Ww),aTitleBarHeight)
	Else
		Dim Ww As Int = mBase.Width - ((iconnum+1)*aiconpadding) - ((iconnum+1)*aiconsize) - ((iconnum)*aiconspacing)
		TitleLabel.SetLayoutAnimated(0,aiconpadding,0dip,(Ww),(aTitleBarHeight))
	End If
	
	Dim cs As CSBuilder
	If aiscollapsed Then
		icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(atextsize).Append(ExpandChar).PopAll
		mBase.Height = (aTitleBarHeight)
	Else
		icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(atextsize).Append(CollapseChar).PopAll
		mBase.Height = (aTitleBarHeight + apanelheight)
	End If
End Sub

Public Sub Clear
	iconnum = 0
	Refresh
End Sub

public Sub AddIcon
	If iconnum = iconcnt - 1 Then Return
	iconnum = iconnum + 1
	
	icons(iconnum-1) = CreateLabel("icon" & (iconnum-1))
	icons(iconnum-1).TextColor = xui.PaintOrColorToColor(atextcolor)
	icons(iconnum-1).Color = xui.Color_Transparent
	icons(iconnum-1).TextSize = aiconsize
	icons(iconnum-1).Text = "I"
	mBase.AddView(icons(iconnum-1),(mBase.Width - aiconpadding) - ((iconnum-1)*aiconsize) - ((iconnum-1)*aiconspacing),aiconpadding,aiconsize,aiconsize)
End Sub

Private Sub SetHeightAnimated(v As B4XView, NewHeight As Int, Duration As Int)
	Dim startTime As Long = DateTime.Now
	Dim startHeight As Int = v.Height
	Dim deltaHeight As Int = NewHeight - startHeight
	Dim t As Long = DateTime.Now
	Do While t < startTime + Duration
		Dim h As Int = startHeight + deltaHeight * (t - startTime) / Duration
		v.Height = h
		Sleep(10)
		t = DateTime.Now
	Loop
	v.Height = NewHeight
End Sub

Public Sub Expand
	aiscollapsed = False
	If aanimation Then
		xpanel.Visible = False
		SetHeightAnimated(mBase,aTitleBarHeight + apanelheight,aduration)
		xpanel.Visible = True
	Else
		xpanel.Visible = False
		mBase.Height = aTitleBarHeight + apanelheight
		mBase.SetLayoutAnimated(0,mBase.Left,mBase.Top,mBase.Width,aTitleBarHeight + apanelheight)
		xpanel.Visible = True
	End If
	Dim cs As CSBuilder
	icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(atextsize).Append(CollapseChar).PopAll
End Sub

Public Sub Collapse
	aiscollapsed = True
	If aanimation Then 
		xpanel.Visible = False
		SetHeightAnimated(mBase,aTitleBarHeight ,aduration)
	Else
		mBase.Height = aTitleBarHeight
		xpanel.Visible = False
	End If
	Dim cs As CSBuilder
	icons(0).Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(atextsize).Append(ExpandChar).PopAll
End Sub

#Region Properties

public Sub setDuration(i As Int)
	aduration = i
End Sub

public Sub getDuration As Int
	Return aduration
End Sub

public Sub setAnimated(b As Boolean)
	aanimation = b
End Sub

public Sub getAnimated As Boolean
	Return aanimation
End Sub

Public Sub setTitleBarHeight(i As Float)
	aTitleBarHeight = DipToCurrent(i)
	Refresh
End Sub

Public Sub getTitleBarHeight As Float
	Return aTitleBarHeight
End Sub

Public Sub setPanelHeight(i As Float)
	apanelheight = DipToCurrent(i)
	Refresh
End Sub

Public Sub getPanelHeight As Float
	Return apanelheight
End Sub

Public Sub IsCollapsed As Boolean
	Return aiscollapsed
End Sub

Public Sub getShowBurgerIcon As Boolean
	Return ashowburger
End Sub

Public Sub getTextSize As Int
	Return atextsize
End Sub

Public Sub getHeight As Int
	Return aheight
End Sub

Public Sub getIconSpacing As Int
	Return aiconspacing
End Sub

Public Sub getIconPadding As Int
	Return aiconpadding
End Sub

Public Sub getIconSize As Int
	Return aiconsize
End Sub

Public Sub getBackground As Int
	Return abackground
End Sub

Public Sub getTextColor As Int
	Return atextcolor
End Sub

Public Sub getText As Int
	Return atext
End Sub

Public Sub getIconCount As Int
	Return aiconcount
End Sub

Public Sub getRadius As Int
	Return aradius
End Sub

Public Sub setRadius(i As Int)
	aradius = i
End Sub

Public Sub getElevation As Int
	Return aelevation
End Sub

Public Sub setElevation(i As Int)
	aelevation = i
End Sub

Public Sub setTextSize(ts As Float)
	atextsize = ts
	TitleLabel.TextSize = atextsize
	If iconnum > 0 Then
		For i = 0 To iconnum - 1
			icons(i).TextSize = atextsize
		Next
	End If
End Sub

Public Sub setHeight(hgt As Float)
	aheight = DipToCurrent(hgt)
	mBase.Height = aheight
	Refresh
End Sub

Public Sub setIconSpacing(sp As Float)
	aiconspacing = DipToCurrent(sp)
	Refresh
End Sub

Public Sub setIconPadding(pd As Float)
	aiconpadding = DipToCurrent(pd)
	Refresh
End Sub

Public Sub setIconSize(icnsz As Float)
	aiconsize = DipToCurrent(icnsz)
	Refresh
End Sub

Public Sub setBackground(clr As Int)
	abackground = clr
	mBase.Color = abackground
End Sub

Public Sub setTextColor(tc As Int)
	atextcolor = tc
	TitleLabel.TextColor = atextcolor
	If iconnum > 0 Then
		For i = 0 To iconnum - 1
			icons(i).TextColor = atextcolor
		Next
	End If
	If BurgerIcon.IsInitialized Then
		BurgerIcon.TextColor = atextcolor
	End If
End Sub

Public Sub setText(txt As String)
	atext = txt
	TitleLabel.Text = atext
End Sub

Public Sub setIconCount(ic As Int)
	iconnum = ic
	redraw
End Sub

Public Sub setShowBurgerIcon(b As Boolean)
	ashowburger = b
	BurgerIcon.Visible = b
	If ashowburger Then
		BurgerIcon.SetLayoutAnimated(0,(aiconpadding*2)+aiconsize,aiconpadding,100dip,mBase.Height-(2*aiconpadding))
	End If
End Sub

#END Region

#Region Event
Private Sub BurgerIcon_Click
	If xui.SubExists(mCallBack,mEventName & "_BurgerClick",0) Then CallSub(mCallBack,mEventName & "_BurgerClick")
End Sub

Private Sub ltitle_Click
	If xui.SubExists(mCallBack,mEventName & "_TitleClick",0) Then CallSub(mCallBack,mEventName & "_TitleClick")
End Sub

Private Sub icon0_Click
	If aiscollapsed Then
		Expand
		If xui.SubExists(mCallBack,mEventName & "_Expand",0) Then CallSub(mCallBack,mEventName & "_Expand")
	Else
		Collapse
		If xui.SubExists(mCallBack,mEventName & "_Collapse",0) Then CallSub(mCallBack,mEventName & "_Collapse")
	End If
End Sub

Private Sub icon1_Click
	If xui.SubExists(mCallBack,mEventName & "_IconClick",1) Then CallSub2(mCallBack,mEventName & "_IconClick",1)
End Sub

Private Sub icon2_Click
	If xui.SubExists(mCallBack,mEventName & "_IconClick",1) Then CallSub2(mCallBack,mEventName & "_IconClick",2)
End Sub

Private Sub icon3_Click
	If xui.SubExists(mCallBack,mEventName & "_IconClick",1) Then CallSub2(mCallBack,mEventName & "_IconClick",3)
End Sub

Private Sub icon4_Click
	If xui.SubExists(mCallBack,mEventName & "_IconClick",1) Then CallSub2(mCallBack,mEventName & "_IconClick",4)
End Sub

Private Sub XPanel_Click
	If xui.SubExists(mCallBack,mEventName & "_PanelClick",0) Then CallSub(mCallBack,mEventName & "_PanelClick")
End Sub

#END Region
