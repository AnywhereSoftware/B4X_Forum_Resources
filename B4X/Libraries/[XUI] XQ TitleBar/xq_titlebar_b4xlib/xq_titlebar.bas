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
#DesignerProperty: Key: Background, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF343434, Description: Background color
#DesignerProperty: Key: ShowBurgerIcon, DisplayName: Show Burger Button, FieldType: Boolean, DefaultValue: True, Description: Show the left icon
#DesignerProperty: Key: IconSpacing, DisplayName: Icon Spacing, FieldType: Int, DefaultValue: 24, MinRange: 0
#DesignerProperty: Key: IconPadding, DisplayName: Icon Padding, FieldType: Int, DefaultValue: 16, MinRange: 0
#DesignerProperty: Key: IconSize, DisplayName: Icon Size, FieldType: Int, DefaultValue: 24, MinRange: 0, Description: Width/Height of icon
#DesignerProperty: Key: IconCount, DisplayName: Icon Count, FieldType: Int, DefaultValue: 1, MinRange: 0, Description: How many icons will show

#Event: BurgerClick
#Event: TitleClick
#Event: IconClick(index as int)

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
	
	Private atextsize As Int = 18
	Private aheight As Int = 56dip
	Private aiconspacing As Int = 24dip
	Private aiconpadding As Int = 16dip
	Private aiconsize As Int = 24dip
	Private ashowburger As Boolean = True
	Private aiconcount As Int = 5
	Private atext As String = "Title"
	Private abackground As Int = xui.Color_Transparent
	Private atextcolor As Int = xui.Color_White
		
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	
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
	redraw
End Sub

Public Sub redraw
	mBase.RemoveAllViews
	mBase.Color = abackground
			
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
			d = mBase.Width - aiconpadding - ((i+1)*aiconsize) - ((i)*aiconspacing)
			mBase.AddView(icons(i),d,aiconpadding,aiconsize,mBase.Height-(2*aiconpadding))
		Next
	End If
	
	If ashowburger Then
		BurgerIcon = CreateLabel("BurgerIcon")
		BurgerIcon.TextColor = xui.PaintOrColorToColor(atextcolor)
		BurgerIcon.Color = xui.Color_Transparent
		BurgerIcon.TextSize = atextsize
		mBase.AddView(BurgerIcon,aiconpadding,aiconpadding,aiconsize,mBase.Height-(2*aiconpadding))
	End If
	
	TitleLabel = CreateLabel("ltitle")
	TitleLabel.TextColor = xui.PaintOrColorToColor(atextcolor)
	TitleLabel.Color = xui.Color_Transparent
	TitleLabel.TextSize = atextsize
	TitleLabel.Text = atext
	TitleLabel.SetTextAlignment("CENTER","LEFT")
	
	If ashowburger Then
		Dim Ww As Int =mBase.Width - (4*aiconpadding) - ((iconnum+1)*aiconsize) - ((iconnum)*aiconspacing) -aiconsize
		mBase.AddView(TitleLabel,(aiconpadding*2)+aiconsize,aiconpadding,(Ww),mBase.Height-(2*aiconpadding))
	Else
		Dim Ww As Int = mBase.Width - ((iconnum+1)*aiconpadding) - ((iconnum+1)*aiconsize) - ((iconnum)*aiconspacing)
		mBase.AddView(TitleLabel,aiconpadding,aiconpadding,(Ww),mBase.Height-(2*aiconpadding))
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

Private Sub Base_Resize (Width As Double, Height As Double)
	Dim d As Int
	mBase.Width=Width
	mBase.Height=Height
End Sub

Public Sub Refresh
	mBase.Color = abackground
	Base_Resize(mBase.Width,mBase.Height)
			
	If iconnum > iconcnt Then iconnum = iconcnt
	If iconnum > 0 Then
		For i = 0 To iconnum - 1
			icons(i).TextColor = xui.PaintOrColorToColor(atextcolor)
			icons(i).Color = xui.Color_Transparent
			icons(i).TextSize = aiconsize
			icons(i).tag = i
			icons(i).SetTextAlignment("CENTER","CENTER")
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

#Region Properties

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
	Refresh
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
	If xui.SubExists(mCallBack,mEventName & "_IconClick",1) Then CallSub2(mCallBack,mEventName & "_IconClick",0)
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

#END Region