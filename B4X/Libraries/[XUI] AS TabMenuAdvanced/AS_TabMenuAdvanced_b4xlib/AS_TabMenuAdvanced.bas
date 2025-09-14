B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
'AS_TabMenuAdvanced
'Author: Alexander Stolte
'Version: V1.00

#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-xBadge renamed to xBadgeProperties
V1.02
	-Add GetTabs - Gets a list of tab properties of type ASTabMenuAdvanced_TabIntern
	-Add RemoveTabAt - Removes a tab
	-Add Tag Property to Type ASTabMenuAdvanced_Tab
	-Add new Type ASTabMenuAdvanced_TabViews - contains the control elements of a tab
V1.03
	-Add LeftPadding to ASTabMenuAdvanced_BadgeProperties - You can move the badge to left or right with this property
	-Add get BadgeProperties - here you can set the global Badge Properties
V1.04
	-The TabClick Event is now always triggered, even if the tab is already selected
	-The BadgeValue Data Type from Type ASTabMenuAdvanced_Tab is now String
V1.05
	-Add get and set CornerRadius
	-Add new Type ASTabMenuAdvanced_IndicatorProperties
	-Add Designer Property Indicator - If True the Indicator is visible
		-Default: False
	-BugFixes
V1.06
	-Add Designer Property MiddleButton - You can now show a middle button
		-Default: False
		-Limitation: Only an even number of tabs may be present 2,4,6,8,10...
	-Add Event MiddleButtonClick
	-Add Type ASTabMenuAdvanced_MiddleButtonProperties
		-CustomWidth
			-Default: 0
	-Add Designer Property BadgeWithoutText - If True then the badges have no text
		-Default: False
V1.07
	-Add Visible to Type ASTabMenuAdvanced_MiddleButtonProperties - If False then the middle button is not visible, but the space is still kept free
V1.08
	-Add Designer Property ColorIcons - If false then remains the color of the icon
		-Default: True
V1.09
	-Add Event CustomDrawTab - This ensures that whenever a tab is refreshed, your custom code is also applied
V1.10
	-BugFix
V1.11
	-Badge optimizations
V1.12
	-Add Clear - Clears all tabs
V1.13
	-BugFix - the badge was not round when the width was smaller than the height
	-Add BadgeValue - Sets the badge value without having to call refresh
	-set Index no longer needs a "refresh" to be changed
V1.14
	-BugFix
V1.15
	-BugFix on MiddleButtonProperties.CustomWidth
V1.16
	-BugFixes
V1,17
	-Add Designer Property ShapeColor - A thin line on top of the view
		-Default: Transparent
#End If

#DesignerProperty: Key: FirstTabSelected, DisplayName: First Tab Selected, FieldType: Boolean, DefaultValue: True, Description: Set it to False if you dont want a selected tab on start
#DesignerProperty: Key: BadgeWithoutText, DisplayName: Badge Without Text, FieldType: Boolean, DefaultValue: False, Description: If True then the badges have no text
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF202125, Description: Is used for default tab background color
#DesignerProperty: Key: ShapeColor, DisplayName: ShapeColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: A thin line on top of the view

#DesignerProperty: Key: SelectedColor, DisplayName: Selected Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: UnselectedColor, DisplayName: Unselected Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: DisabledColor, DisplayName: Disabled Color, FieldType: Color, DefaultValue: 0xFF3C4043

#DesignerProperty: Key: Indicator, DisplayName: Indicator, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: HaloEffect, DisplayName: Halo Effect, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: HaloColor, DisplayName: Halo Color, FieldType: Color, DefaultValue: 0xFF3C4043

#DesignerProperty: Key: MiddleButton, DisplayName: Middle Button, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: ColorIcons, DisplayName: Color Icons, FieldType: Boolean, DefaultValue: True

#Event: TabClick (Index As Int)
#Event: MiddleButtonClick
#Event: CustomDrawTab(Index As Int, TabItem As ASTabMenuAdvanced_TabIntern)

Sub Class_Globals
	
	Type ASTabMenuAdvanced_TabProperties(TextFont As B4XFont,BackgroundColor As Int,SelectedColor As Int,UnselectedColor As Int,DisabledColor As Int,TextIconPadding As Float)
	Type ASTabMenuAdvanced_Tab(Text As String,IconSelected As B4XBitmap,IconUnselected As B4XBitmap,IconDisabled As B4XBitmap,Enabled As Boolean,BadgeValue As String,Tag As Object)
	Type ASTabMenuAdvanced_BadgeProperties(TextColor As Int,TextFont As B4XFont,Height As Float,TextPadding As Float,LeftPadding As Float,BackgroundColor As Int)
	Type ASTabMenuAdvanced_TabViews(xpnl_TabBackground As B4XView,xlbl_TabText As B4XView,xiv_TabIcon As B4XView,xlbl_Badge As B4XView)
	Type ASTabMenuAdvanced_TabIntern(xTab As ASTabMenuAdvanced_Tab,xTabProperties As ASTabMenuAdvanced_TabProperties,xBadgeProperties As ASTabMenuAdvanced_BadgeProperties,xTabViews As ASTabMenuAdvanced_TabViews)
	Type ASTabMenuAdvanced_IndicatorProperties(Height As Float,Color As Int,CornerRadius As Float,Duration As Long,SafeGap As Float)
	Type ASTabMenuAdvanced_MiddleButtonProperties(CustomWidth As Float,BackgroundColor As Int,xFont As B4XFont,TextColor As Int,Visible As Boolean)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private g_TabProperties As ASTabMenuAdvanced_TabProperties
	Private g_BadgeProperties As ASTabMenuAdvanced_BadgeProperties
	Private g_IndicatorProperties As ASTabMenuAdvanced_IndicatorProperties
	Private g_MiddleButtonProperties As ASTabMenuAdvanced_MiddleButtonProperties
	
	Private xpnl_TabBackground As B4XView
	Private xpnl_BadgeBackground As B4XView
	Private xpnl_Indicator As B4XView
	Private xlbl_MiddleButton As B4XView
	Private xpnl_ShapeLine As B4XView
	
	Private m_Index As Int = -1
	Private m_TabList As List
	Private m_SelectedBackgroundColorAnimationDuration As Int = 750
	
	Private m_BadgeWithoutText As Boolean = False
	Private m_HaloEffect As Boolean = True
	Private m_HaloColor As Int
	Private m_CornerRadius As Float
	Private m_ShapeColor As Int
	
	Private m_MiddleButton As Boolean
	Private m_IndicatorVisible As Boolean = False
	Private m_ColorIcons As Boolean = True
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	m_TabList.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	IniProps(Props)
	
	xpnl_TabBackground = xui.CreatePanel("")
	xpnl_BadgeBackground = xui.CreatePanel("")
	mBase.AddView(xpnl_TabBackground,0,0,mBase.Width,mBase.Height)
	mBase.AddView(xpnl_BadgeBackground,0,0,mBase.Width,mBase.Height)
	xpnl_TabBackground.Color = g_TabProperties.BackgroundColor
	xpnl_BadgeBackground.Color = xui.Color_Transparent
	xpnl_ShapeLine = xui.CreatePanel("")
	mBase.AddView(xpnl_ShapeLine,0,0,mBase.Width,1dip)
	xpnl_ShapeLine.Color = m_ShapeColor
	
	#If B4I
	xpnl_BadgeBackground.As(Panel).UserInteractionEnabled = False
	#Else If B4J
	xpnl_BadgeBackground.As(JavaObject).RunMethod("setMouseTransparent",Array As Object(True))
	#End If
	
	xpnl_Indicator = xui.CreatePanel("")
	mBase.AddView(xpnl_Indicator,0,0,0,0)
	
	xlbl_MiddleButton = CreateLabel("xlbl_MiddleButton")
	mBase.AddView(xlbl_MiddleButton,0,0,0,0)
	
	xlbl_MiddleButton.Color = g_MiddleButtonProperties.BackgroundColor
	xlbl_MiddleButton.TextColor = g_MiddleButtonProperties.TextColor
	xlbl_MiddleButton.SetTextAlignment("CENTER","CENTER")
	xlbl_MiddleButton.Font = g_MiddleButtonProperties.xFont
	xlbl_MiddleButton.Text = Chr(0xE145)
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Private Sub IniProps(Props As Map)
	
	m_BadgeWithoutText= Props.GetDefault("BadgeWithoutText",False)
	m_MiddleButton = Props.GetDefault("MiddleButton",False)
	m_IndicatorVisible = Props.GetDefault("Indicator",False)
	m_HaloEffect = Props.Get("HaloEffect")
	m_ColorIcons = Props.GetDefault("ColorIcons",True)
	m_HaloColor = xui.PaintOrColorToColor(Props.Get("HaloColor"))
	m_ShapeColor = xui.PaintOrColorToColor(Props.GetDefault("ShapeColor",0x00FFFFFF))
	
	If Props.Get("FirstTabSelected").As(Boolean) = True Then
		m_Index = 0
	Else
		m_Index = -1
	End If
	
	g_TabProperties = CreateASTabMenuAdvanced_TabProperties(xui.CreateDefaultFont(15),xui.PaintOrColorToColor(Props.Get("BackgroundColor")),xui.PaintOrColorToColor(Props.Get("SelectedColor")),xui.PaintOrColorToColor(Props.Get("UnselectedColor")),xui.PaintOrColorToColor(Props.Get("DisabledColor")),0)
	g_BadgeProperties = CreateASTabMenuAdvanced_BadgeProperties(xui.Color_White,xui.CreateDefaultBoldFont(11),15dip,11dip,0,xui.Color_ARGB(255,73, 98, 164))
	g_IndicatorProperties = CreateASTabMenuAdvanced_IndicatorProperties(2dip,xui.Color_White,2dip/2,250,4dip)
	g_MiddleButtonProperties = CreateASTabMenuAdvanced_MiddleButtonProperties(0,xui.Color_White,xui.CreateMaterialIcons(IIf(xui.IsB4J,30,25)),xui.Color_Black,True)'xui.Color_ARGB(255,45, 136, 121)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	SetCircleClip(mBase,m_CornerRadius)
	xpnl_TabBackground.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_BadgeBackground.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_ShapeLine.SetLayoutAnimated(0,0,0,Width,1dip)
	
	xpnl_TabBackground.Color = g_TabProperties.BackgroundColor
	
	Dim MiddleButtonGap As Float = IIf(m_MiddleButton = True,IIf(g_MiddleButtonProperties.CustomWidth = 0, Height,g_MiddleButtonProperties.CustomWidth), g_MiddleButtonProperties.CustomWidth)
	xlbl_MiddleButton.Visible = m_MiddleButton And g_MiddleButtonProperties.Visible
	xlbl_MiddleButton.SetLayoutAnimated(0,Width/2 - MiddleButtonGap/2,0,MiddleButtonGap,MiddleButtonGap)
	xlbl_MiddleButton.SetColorAndBorder(xlbl_MiddleButton.Color,0,0,MiddleButtonGap/2)
	
	'Resize Tabs
	For i = 0 To xpnl_TabBackground.NumberOfViews -1
		
		Dim xpnl_Tab As B4XView = xpnl_TabBackground.GetView(i)
		
		Dim xlbl_TabText As B4XView = xpnl_Tab.GetView(1)
		Dim xiv_TabIcon As B4XView = xpnl_Tab.GetView(2)
		Dim xlbl_Badge As B4XView = xpnl_BadgeBackground.GetView(i)
		
		Dim TabIntern As ASTabMenuAdvanced_TabIntern = m_TabList.Get(i)
	
		Dim TabWidth As Float = (Width - MiddleButtonGap)/m_TabList.Size
		
		xpnl_Tab.SetLayoutAnimated(0,TabWidth*i + IIf(i >= (m_TabList.Size/2),MiddleButtonGap,0),0,TabWidth,Height)

		Dim TabHeight As Float = Height - IIf(m_IndicatorVisible = True,g_IndicatorProperties.Height + g_IndicatorProperties.SafeGap,0)
		
		Dim xpnl_HaloBackground As B4XView = xpnl_Tab.GetView(0)
		xpnl_HaloBackground.SetLayoutAnimated(0,0,0,TabWidth,mBase.Height)
		
		Dim xTab As ASTabMenuAdvanced_Tab = TabIntern.xTab
		Dim xTabProperties As ASTabMenuAdvanced_TabProperties = TabIntern.xTabProperties
		Dim xBadgeProperties As ASTabMenuAdvanced_BadgeProperties = TabIntern.xBadgeProperties
		
		Dim HaveIcon As Boolean = True
		If xTab.Text = "" Then
			Dim widthheight As Float = TabHeight*50/100
			xiv_TabIcon.SetLayoutAnimated(0,xpnl_Tab.Width/2 - widthheight/2,TabHeight/2 - widthheight/2,widthheight,widthheight)
		Else If xTab.Text <> "" And (xTab.IconSelected.IsInitialized = True Or  xTab.IconUnselected.IsInitialized = True )Then
			Dim widthheight As Float = TabHeight*40/100
			xiv_TabIcon.SetLayoutAnimated(0,xpnl_Tab.Width/2 - widthheight/2,(TabHeight/2)/2 - (widthheight/2)/2 - xTabProperties.TextIconPadding,widthheight,widthheight)
			xlbl_TabText.SetLayoutAnimated(0,0,TabHeight/2 + (widthheight/2)/2,xpnl_Tab.Width,widthheight)
		Else
			HaveIcon = False
			xlbl_TabText.SetLayoutAnimated(0,0,0,xpnl_Tab.Width,TabHeight)
		End If
		xiv_TabIcon.Tag = HaveIcon
		
		xlbl_Badge.Visible = IIf(xTab.BadgeValue = 0 Or xTab.BadgeValue = "",False,True)
		xlbl_Badge.Font = xBadgeProperties.TextFont
		xlbl_Badge.TextColor = xBadgeProperties.TextColor
		xlbl_Badge.SetTextAlignment("CENTER","CENTER")
		xlbl_Badge.Text = IIf(m_BadgeWithoutText = True,"", xTab.BadgeValue)
		
		SetBadgeSize(xpnl_Tab,xlbl_Badge,xiv_TabIcon,TabIntern)
		
		If xTab.Enabled = True Then
			If i = m_Index Then
				xlbl_TabText.TextColor = xTabProperties.SelectedColor
			Else
				xlbl_TabText.TextColor = xTabProperties.UnselectedColor
			End If
		Else
			xlbl_TabText.TextColor = xTabProperties.DisabledColor
		End If
		
		xpnl_Tab.Color = xTabProperties.BackgroundColor
		xlbl_TabText.SetTextAlignment("CENTER","CENTER")
		xlbl_TabText.Font = xTabProperties.TextFont
		xlbl_TabText.Text = xTab.Text
		
		xpnl_Indicator.Visible = m_IndicatorVisible
		
		If m_IndicatorVisible = True And i = m_Index Then
			xpnl_Indicator.SetLayoutAnimated(0,xpnl_Tab.Left,mBase.Height - g_IndicatorProperties.Height,xpnl_Tab.Width,g_IndicatorProperties.Height)
			xpnl_Indicator.SetColorAndBorder(g_IndicatorProperties.Color,0,0,g_IndicatorProperties.CornerRadius)
		End If
		
		CustomDrawTab(i,m_TabList.Get(i))
		
	Next
  
	xlbl_MiddleButton.Color = g_MiddleButtonProperties.BackgroundColor
	xlbl_MiddleButton.TextColor = g_MiddleButtonProperties.TextColor
	xlbl_MiddleButton.Font = g_MiddleButtonProperties.xFont
  
End Sub

Private Sub SetBadgeSize(xpnl_Tab As B4XView,xlbl_Badge As B4XView,xiv_TabIcon As B4XView,TabIntern As ASTabMenuAdvanced_TabIntern)
	
	Dim BadgeWidth As Float = IIf(m_BadgeWithoutText,TabIntern.xBadgeProperties.Height, MeasureTextWidth(xlbl_Badge.Text,xlbl_Badge.Font) + TabIntern.xBadgeProperties.TextPadding)
	Dim BadgeHeight As Float = IIf(m_BadgeWithoutText,BadgeWidth,MeasureTextHeight(xlbl_Badge.Text,xlbl_Badge.Font))
	If BadgeWidth < TabIntern.xBadgeProperties.Height Then
		BadgeWidth = TabIntern.xBadgeProperties.Height
	Else If BadgeWidth < BadgeHeight Then
		BadgeWidth = BadgeHeight
	End If
	
	If xiv_TabIcon.Tag.As(Boolean) = True Then
		xlbl_Badge.SetLayoutAnimated(0,xpnl_Tab.Left + xiv_TabIcon.Left + xiv_TabIcon.Width + 5dip + TabIntern.xBadgeProperties.LeftPadding,xiv_TabIcon.Top - 5dip,BadgeWidth,BadgeHeight)
	Else
		xlbl_Badge.SetLayoutAnimated(0,xpnl_Tab.Left + xpnl_Tab.Width/2 + MeasureTextWidth(TabIntern.xTab.Text,TabIntern.xTabProperties.TextFont)/2 + TabIntern.xBadgeProperties.LeftPadding,xpnl_Tab.Height/2 - BadgeWidth,BadgeWidth,BadgeHeight)
	End If
		
	xlbl_Badge.SetColorAndBorder(TabIntern.xBadgeProperties.BackgroundColor,0,0,BadgeHeight/2)
End Sub

Private Sub RefreshIcons
	For i = 0 To xpnl_TabBackground.NumberOfViews -1
		
		Dim xpnl_Tab As B4XView = xpnl_TabBackground.GetView(i)
		Dim xiv_TabIcon As B4XView = xpnl_Tab.GetView(2)
		
		
		Dim TabIntern As ASTabMenuAdvanced_TabIntern = m_TabList.Get(i)
		Dim xTab As ASTabMenuAdvanced_Tab = TabIntern.xTab
		Dim xTabProperties As ASTabMenuAdvanced_TabProperties = TabIntern.xTabProperties
		
		
		Dim HaveImage As Boolean = False
		If xTab.Text = "" Then
			HaveImage = True
		Else If xTab.Text <> "" And (xTab.IconSelected.IsInitialized = True Or  xTab.IconUnselected.IsInitialized = True )Then
			HaveImage = True
			End If
		
		Dim scale As Float = 1
			#If B4I
		scale = GetDeviceLayoutValues.NonnormalizedScale
			#End If
		
		If HaveImage = True Then
			If m_Index > -1 And i = m_Index Then
				xiv_TabIcon.SetBitmap(xTab.IconSelected.Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			Else
				xiv_TabIcon.SetBitmap(xTab.IconUnselected.Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			End If
		
			If xTab.Enabled = True Then
				If  i = m_Index Then
			#If B4J 
					If TabIntern.xTab.IconSelected.IsInitialized = True Then xiv_TabIcon.SetBitmap(ChangeColorBasedOnAlphaLevel(TabIntern.xTab.IconSelected,xTabProperties.SelectedColor).Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			#Else
			If TabIntern.xTab.IconSelected.IsInitialized = True Then xiv_TabIcon.SetBitmap(TabIntern.xTab.IconSelected.Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			If xiv_TabIcon.GetBitmap.IsInitialized = True Then TintBmp(xiv_TabIcon,xTabProperties.SelectedColor)
			#End If
				Else
			#If B4J
					If TabIntern.xTab.IconUnselected.IsInitialized = True Then xiv_TabIcon.SetBitmap(ChangeColorBasedOnAlphaLevel(TabIntern.xTab.IconUnselected,xTabProperties.UnselectedColor).Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			#Else
			If TabIntern.xTab.IconUnselected.IsInitialized = True Then xiv_TabIcon.SetBitmap(TabIntern.xTab.IconUnselected.Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			If xiv_TabIcon.GetBitmap.IsInitialized = True Then TintBmp(xiv_TabIcon,xTabProperties.UnselectedColor)
			#End If
				End If
			Else
					#If B4J
				If TabIntern.xTab.IconDisabled.IsInitialized = True Then xiv_TabIcon.SetBitmap(ChangeColorBasedOnAlphaLevel(TabIntern.xTab.IconDisabled,xTabProperties.DisabledColor).Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			#Else
			If TabIntern.xTab.IconDisabled.IsInitialized = True Then xiv_TabIcon.SetBitmap(TabIntern.xTab.IconDisabled.Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			If xiv_TabIcon.GetBitmap.IsInitialized = True Then TintBmp(xiv_TabIcon,xTabProperties.DisabledColor)
			#End If
			End If
			
		End If
		
	Next
End Sub

'Text - Pass "" if you dont want Text
'IconSelected - Pass NULL if you dont want a Icon
'IconUnselected - Pass NULL if you dont want a Icon
'If you want to change TabProperties then call this before you add the tab
'<code>AS_TabMenuAdvanced1.TabProperties.TextColor = xui.Color_White</code>
Public Sub AddTab(Text As String,IconSelected As B4XBitmap,IconUnselected As B4XBitmap)
	Dim xTab As ASTabMenuAdvanced_Tab = CreateASTabMenuAdvanced_Tab(Text,IconSelected,IconUnselected)
	If IconSelected.IsInitialized = True Or IconUnselected.IsInitialized = True Then
		xTab.IconDisabled = IIf(IconUnselected.IsInitialized = True,IconUnselected,IconSelected)
	End If
	
	Dim xTabProperties As ASTabMenuAdvanced_TabProperties = CreateASTabMenuAdvanced_TabProperties(g_TabProperties.TextFont,g_TabProperties.BackgroundColor,g_TabProperties.SelectedColor,g_TabProperties.UnselectedColor,g_TabProperties.DisabledColor,g_TabProperties.TextIconPadding)	
	CreateTab(xTab,xTabProperties)
End Sub
'Example:
'<code>
'Dim xTab As ASTabMenuAdvanced_Tab = AS_TabMenuAdvanced1.CreateASTabMenuAdvanced_Tab("Test Item",Null,Null)
'Dim xTabProperties As ASTabMenuAdvanced_TabProperties = AS_TabMenuAdvanced1.CreateASTabMenuAdvanced_TabProperties(xui.CreateDefaultFont(15),xui.Color_ARGB(255,32, 33, 37),xui.Color_ARGB(255,45, 136, 121),xui.Color_ARGB(255,255,255,255),xui.Color_ARGB(255,60, 64, 67),0)
'AS_TabMenuAdvanced1.AddTabAdvanced(xTab,xTabProperties)</code>
Public Sub AddTabAdvanced(xTab As ASTabMenuAdvanced_Tab,xTabProperties As ASTabMenuAdvanced_TabProperties)
	CreateTab(xTab,xTabProperties)
End Sub
'Removes a tab
'<code>
'AS_TabMenuAdvanced1.RemoveTabAt(2)
'AS_TabMenuAdvanced1.Refresh</code>
Public Sub RemoveTabAt(Index As Int)
	m_TabList.RemoveAt(Index)
	xpnl_TabBackground.GetView(Index).RemoveViewFromParent
	xpnl_BadgeBackground.GetView(Index).RemoveViewFromParent
End Sub

'Clears all tabs
Public Sub Clear
	m_TabList.Clear
	xpnl_TabBackground.RemoveAllViews
	xpnl_BadgeBackground.RemoveAllViews
End Sub

Public Sub Refresh
	Base_Resize(mBase.Width,mBase.Height)
	RefreshIcons
End Sub

'Sets the badge value without having to call refresh
Public Sub BadgeValue(TabIndex As Int,Value As Int)
	Dim TabIntern As ASTabMenuAdvanced_TabIntern = m_TabList.Get(TabIndex)
	TabIntern.xTab.BadgeValue = Value
	
	Dim xpnl_Tab As B4XView = xpnl_TabBackground.GetView(TabIndex)
		
	Dim xiv_TabIcon As B4XView = xpnl_Tab.GetView(2)
	Dim xlbl_Badge As B4XView = xpnl_BadgeBackground.GetView(TabIndex)
	xlbl_Badge.Text = IIf(m_BadgeWithoutText = True,"", Value)
	xlbl_Badge.Visible = IIf(TabIntern.xTab.BadgeValue = 0 Or TabIntern.xTab.BadgeValue = "",False,True)
	
	SetBadgeSize(xpnl_Tab,xlbl_Badge,xiv_TabIcon,TabIntern)
End Sub

Private Sub CreateTab(xTab As ASTabMenuAdvanced_Tab,xTabProperties As ASTabMenuAdvanced_TabProperties)
	
	Dim xBadgeProperties As ASTabMenuAdvanced_BadgeProperties = CreateASTabMenuAdvanced_BadgeProperties(g_BadgeProperties.TextColor,g_BadgeProperties.TextFont,g_BadgeProperties.Height,g_BadgeProperties.TextPadding,g_BadgeProperties.LeftPadding,g_BadgeProperties.BackgroundColor)
	
	Dim xpnl_Tab As B4XView = xui.CreatePanel("xpnl_Tab")
	
	Dim xpnl_HaloBackground As B4XView = xui.CreatePanel("")
	xpnl_Tab.AddView(xpnl_HaloBackground,0,0,0,0)
	
	Dim xlbl_TabText As B4XView = CreateLabel("")
	Dim xiv_TabIcon As B4XView = CreateImageView("")
	Dim xlbl_Badge As B4XView = CreateLabel("")
	
	xpnl_Tab.SetLayoutAnimated(0,0,0,0,0)
	
	xpnl_Tab.AddView(xlbl_TabText,0,0,0,0)
	xpnl_Tab.AddView(xiv_TabIcon,0,0,0,0)
	xpnl_BadgeBackground.AddView(xlbl_Badge,0,0,0,0)
	
	Dim xTabViews As ASTabMenuAdvanced_TabViews = CreateASTabMenuAdvanced_TabViews(xpnl_Tab,xlbl_TabText,xiv_TabIcon,xlbl_Badge)
	
	m_TabList.Add(CreateASTabMenuAdvanced_TabIntern(xTab,xTabProperties,xBadgeProperties,xTabViews))
	
	xpnl_TabBackground.AddView(xpnl_Tab,0,0,0,0)
	
End Sub

#Region Properties

Public Sub setShapeColor(Color As Int)
	m_ShapeColor = Color
	xpnl_ShapeLine.Color = Color
End Sub

Public Sub getShapeColor As Int
	Return m_ShapeColor
End Sub

Public Sub getBadgeWithoutText As Boolean
	Return m_BadgeWithoutText
End Sub

Public Sub setBadgeWithoutText(WithoutText As Boolean)
	m_BadgeWithoutText = WithoutText
End Sub

Public Sub setMiddleButton(Visible As Boolean)
	m_MiddleButton = Visible
End Sub

Public Sub getMiddleButton As Boolean
	Return m_MiddleButton
End Sub

Public Sub getMiddleButtonLabel As B4XView
	Return xlbl_MiddleButton
End Sub

Public Sub setIndicatorVisible(Visible As Boolean)
	m_IndicatorVisible = Visible
End Sub

Public Sub getIndicatorVisible As Boolean
	Return m_IndicatorVisible
End Sub

Public Sub setCornerRadius(CornerRadius As Float)
	m_CornerRadius = CornerRadius
	SetCircleClip(mBase,m_CornerRadius)
End Sub

Public Sub getCornerRadius As Float
	Return m_CornerRadius
End Sub

Public Sub getMiddleButtonProperties As ASTabMenuAdvanced_MiddleButtonProperties
	Return g_MiddleButtonProperties
End Sub

Public Sub getIndicatorProperties As ASTabMenuAdvanced_IndicatorProperties
	Return g_IndicatorProperties
End Sub

Public Sub getBadgeProperties As ASTabMenuAdvanced_BadgeProperties
	Return g_BadgeProperties
End Sub
'Example:
'<code>
'AS_TabMenuAdvanced1.TabProperties.BackgroundColor = xui.Color_Red
'AS_TabMenuAdvanced1.Refresh</code>
Public Sub getTabProperties As ASTabMenuAdvanced_TabProperties
	Return g_TabProperties
End Sub

Public Sub setTabProperties(TabProperties As ASTabMenuAdvanced_TabProperties)
	TabProperties = g_TabProperties
End Sub

'Example:
'<code>
'AS_TabMenuAdvanced1.GetTab(0).xTabProperties.SelectedColor = xui.Color_Magenta
'AS_TabMenuAdvanced1.Refresh</code>
Public Sub GetTab(Index As Int) As ASTabMenuAdvanced_TabIntern
	Return m_TabList.Get(Index)
End Sub
'Example:
'<code>
'For Each TabIntern As ASTabMenuAdvanced_TabIntern In AS_TabMenuAdvanced1.GetTabs
'	Log(TabIntern.xTab.Text)
'Next</code>
Public Sub GetTabs As List
	Return m_TabList
End Sub

'Dont need a "Refresh" anymore
Public Sub getIndex As Int
	Return m_Index
End Sub

Public Sub setIndex(Index As Int)
	m_Index = Index
	TabClick(xpnl_TabBackground.GetView(Index),False)
End Sub

#End Region

#Region Events

Private Sub CustomDrawTab(Index As Int, TabItem As ASTabMenuAdvanced_TabIntern)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawTab",2) Then
		CallSub3(mCallBack, mEventName & "_CustomDrawTab",Index,TabItem)
	End If
End Sub

Private Sub TabClickEvent(index As Int)
	If xui.SubExists(mCallBack, mEventName & "_TabClick",1) Then
		CallSub2(mCallBack, mEventName & "_TabClick",index)
	End If
End Sub

#End Region

#Region ViewEvents
#If B4J
Private Sub xlbl_MiddleButton_MouseClicked (EventData As MouseEvent)
	#Else
Private Sub xlbl_MiddleButton_Click
#End If
	If xui.SubExists(mCallBack, mEventName & "_MiddleButtonClick",0) Then
		CallSub(mCallBack, mEventName & "_MiddleButtonClick")
	End If
End Sub

Private Sub TabClick(xpnl_Tab As B4XView,isUserTap As Boolean)
	'Dim OldIndex As Int = m_Index

	For i = 0 To xpnl_TabBackground.NumberOfViews -1
		Dim xpnl_TabTmp As B4XView = xpnl_TabBackground.GetView(i)
		If xpnl_TabTmp = xpnl_Tab Then
			Dim TabIntern As ASTabMenuAdvanced_TabIntern = m_TabList.Get(i)
			If TabIntern.xTab.Enabled = False Then Return
		End If
	Next

	
	For i = 0 To xpnl_TabBackground.NumberOfViews -1
		
		Dim xpnl_TabTmp As B4XView = xpnl_TabBackground.GetView(i)
		
		Dim xpnl_HaloBackground As B4XView = xpnl_Tab.GetView(0)
		
		Dim xlbl_TabText As B4XView = xpnl_TabTmp.GetView(1)
		Dim xiv_TabIcon As B4XView = xpnl_TabTmp.GetView(2)
		
		Dim TabIntern As ASTabMenuAdvanced_TabIntern = m_TabList.Get(i)
		
		Dim scale As Float = 1
			#If B4I
		scale = GetDeviceLayoutValues.NonnormalizedScale
			#End If
		
		If xpnl_TabTmp = xpnl_Tab Then
			If TabIntern.xTab.Enabled = True Then
				m_Index = i
				xlbl_TabText.TextColor = TabIntern.xTabProperties.SelectedColor
			
			#If B4J
				If TabIntern.xTab.IconSelected.IsInitialized = True Then xiv_TabIcon.SetBitmap(ChangeColorBasedOnAlphaLevel(TabIntern.xTab.IconSelected,TabIntern.xTabProperties.SelectedColor).Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			#Else
				If TabIntern.xTab.IconSelected.IsInitialized = True Then xiv_TabIcon.SetBitmap(TabIntern.xTab.IconSelected.Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
				If xiv_TabIcon.GetBitmap.IsInitialized = True Then TintBmp(xiv_TabIcon,TabIntern.xTabProperties.SelectedColor)
			#End If
			
				xpnl_Indicator.SetLayoutAnimated(g_IndicatorProperties.Duration,xpnl_Tab.Left,mBase.Height - g_IndicatorProperties.Height,xpnl_Tab.Width,g_IndicatorProperties.Height)
			
			End If
		Else
			If TabIntern.xTab.Enabled = True Then
				xlbl_TabText.TextColor = TabIntern.xTabProperties.UnselectedColor
			
			#If B4J 
				If TabIntern.xTab.IconUnselected.IsInitialized = True Then xiv_TabIcon.SetBitmap(ChangeColorBasedOnAlphaLevel(TabIntern.xTab.IconUnselected,TabIntern.xTabProperties.UnselectedColor).Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			#Else
				If TabIntern.xTab.IconUnselected.IsInitialized = True Then xiv_TabIcon.SetBitmap(TabIntern.xTab.IconUnselected.Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
				If xiv_TabIcon.GetBitmap.IsInitialized = True Then TintBmp(xiv_TabIcon,TabIntern.xTabProperties.UnselectedColor)
			#End If
			Else
				xlbl_TabText.TextColor = TabIntern.xTabProperties.DisabledColor
			
			#If B4J
				If TabIntern.xTab.IconDisabled.IsInitialized = True Then xiv_TabIcon.SetBitmap(ChangeColorBasedOnAlphaLevel(TabIntern.xTab.IconDisabled,TabIntern.xTabProperties.DisabledColor).Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
			#Else
				If TabIntern.xTab.IconDisabled.IsInitialized = True Then xiv_TabIcon.SetBitmap(TabIntern.xTab.IconDisabled.Resize(xiv_TabIcon.Width * scale,xiv_TabIcon.Height * scale,True))
				If xiv_TabIcon.GetBitmap.IsInitialized = True Then TintBmp(xiv_TabIcon,TabIntern.xTabProperties.DisabledColor)
			#End If
			End If
		End If
		
	Next
	
	If m_HaloEffect = True And isUserTap Then
		CreateHaloEffect(xpnl_HaloBackground,xpnl_HaloBackground.Width/2,xpnl_HaloBackground.Height/2,m_HaloColor)
	End If
	
	'If OldIndex <> m_Index Then
	If isUserTap Then TabClickEvent(m_Index)
	'End If
End Sub

#If B4J
Private Sub xpnl_Tab_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xpnl_Tab_Click
#End If
	TabClick(Sender,True)
End Sub

#End Region

#Region Functions

Public Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Public Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

#If B4A OR B4I
Private Sub TintBmp(img As ImageView, color As Int)
	If m_ColorIcons = True Then
	#If B4I
	Dim NaObj As NativeObject = Me
	NaObj.RunMethod("BmpColor::",Array(img,NaObj.ColorToUIColor(color)))
	#Else if B4J
	If color = 0 Then
		Dim jiv As JavaObject = img
		jiv.RunMethod("setClip",Array(Null))
		jiv.RunMethod("setEffect", Array(Null))
		Return
	End If
	Dim fx As JFX
	color = fx.Colors.To32Bit(fx.Colors.rgb(GetARGB(color)(1),GetARGB(color)(2),GetARGB(color)(3)))
	Dim monochrome,effect,mode,tint As JavaObject
	monochrome.InitializeNewInstance("javafx.scene.effect.ColorAdjust", Null)
	monochrome.RunMethod("setSaturation", Array(-1.0))
	effect.InitializeNewInstance("javafx.scene.effect.Blend",Array(mode.InitializeStatic("javafx.scene.effect.BlendMode").GetField("SCREEN"),monochrome,tint.InitializeNewInstance("javafx.scene.effect.ColorInput",Array(0.0,0.0,img.PrefWidth,img.PrefHeight,fx.Colors.From32Bit(color)))))
	Dim jiv As JavaObject = img
	Dim imgt As ImageView
	imgt.Initialize("")
	imgt.SetImage(img.GetImage)
	imgt.SetSize(img.PrefWidth,img.PrefHeight)
	jiv.RunMethod("setClip",Array(imgt))
	jiv.RunMethod("setEffect", Array(effect))
	
	#Else If B4A
		Dim jo As JavaObject=img
		jo.RunMethod("setImageBitmap",Array(img.Bitmap))
		'jo.RunMethod("setColorFilter",Array(Colors.Transparent))
		jo.RunMethod("setColorFilter",Array(Colors.rgb(GetARGB(color)(1),GetARGB(color)(2),GetARGB(color)(3))))
	
	#End If
	End If
	
End Sub
#End If

#If B4J
Sub ChangeColorBasedOnAlphaLevel(bmp As B4XBitmap, NewColor As Int) As B4XBitmap
	If m_ColorIcons = True Then
		Dim bc As BitmapCreator
		bc.Initialize(bmp.Width, bmp.Height)
		bc.CopyPixelsFromBitmap(bmp)
		Dim a1, a2 As ARGBColor
		bc.ColorToARGB(NewColor, a1)
		For y = 0 To bc.mHeight - 1
			For x = 0 To bc.mWidth - 1
				bc.GetARGB(x, y, a2)
				If a2.a > 0 Then
					a2.r = a1.r
					a2.g = a1.g
					a2.b = a1.b
					bc.SetARGB(x, y, a2)
				End If
			Next
		Next
		Return bc.Bitmap
	Else
		Return bmp
	End If
End Sub
#end If

#If OBJC
- (void)BmpColor: (UIImageView*) theImageView :(UIColor*) Color{
theImageView.image = [theImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
[theImageView setTintColor:Color];
}
#end if

'int ot argb
Private Sub GetARGB(Color As Int) As Int()'ignore
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

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
	p.SetLayoutAnimated(m_SelectedBackgroundColorAnimationDuration, x - radius, y - radius, 2 * radius, 2 * radius)
	p.SetVisibleAnimated(m_SelectedBackgroundColorAnimationDuration, False)
	Sleep(m_SelectedBackgroundColorAnimationDuration)
	p.RemoveViewFromParent
End Sub

'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
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
	mBase.SetColorAndBorder(mBase.Color,0,0,m_CornerRadius)
	#Else
	mBase.SetColorAndBorder(mBase.Color,0,0,m_CornerRadius)
#end if
End Sub

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
    Private bmp As Bitmap
    bmp.InitializeMutable(2dip, 2dip)
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

Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int
#If B4A    
    Private bmp As Bitmap
    bmp.InitializeMutable(2dip, 2dip)
    Private cvs As Canvas
    cvs.Initialize2(bmp)
    Return cvs.MeasureStringHeight(Text, Font1.ToNativeFont, Font1.Size) +10dip
#Else If B4i
    Return Text.MeasureHeight(Font1.ToNativeFont) + 5dip
#Else If B4J
	Dim jo As JavaObject
	jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
	jo.RunMethod("setFont",Array(Font1.ToNativeFont))
	jo.RunMethod("setLineSpacing",Array(0.0))
	jo.RunMethod("setWrappingWidth",Array(0.0))
	Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
	Return Bounds.RunMethod("getHeight",Null)
#End If
End Sub

#End Region

#Region Types

Public Sub CreateASTabMenuAdvanced_Tab (Text As String, IconSelected As B4XBitmap, IconUnselected As B4XBitmap) As ASTabMenuAdvanced_Tab
	Dim t1 As ASTabMenuAdvanced_Tab
	t1.Initialize
	t1.Text = Text
	t1.IconSelected = IconSelected
	t1.IconUnselected = IconUnselected
	't1.IconDisabled = IconDisabled
	t1.Enabled = True
	t1.BadgeValue = 0
	Return t1
End Sub

Public Sub CreateASTabMenuAdvanced_TabIntern (xTab As ASTabMenuAdvanced_Tab, xTabProperties As ASTabMenuAdvanced_TabProperties, xBadgeProperties As ASTabMenuAdvanced_BadgeProperties, xTabViews As ASTabMenuAdvanced_TabViews) As ASTabMenuAdvanced_TabIntern
	Dim t1 As ASTabMenuAdvanced_TabIntern
	t1.Initialize
	t1.xTab = xTab
	t1.xTabProperties = xTabProperties
	t1.xBadgeProperties = xBadgeProperties
	t1.xTabViews = xTabViews
	Return t1
End Sub

Public Sub CreateASTabMenuAdvanced_TabProperties (TextFont As B4XFont, BackgroundColor As Int, SelectedColor As Int, UnselectedColor As Int, DisabledColor As Int, TextIconPadding As Float) As ASTabMenuAdvanced_TabProperties
	Dim t1 As ASTabMenuAdvanced_TabProperties
	t1.Initialize
	t1.TextFont = TextFont
	t1.BackgroundColor = BackgroundColor
	t1.SelectedColor = SelectedColor
	t1.UnselectedColor = UnselectedColor
	t1.DisabledColor = DisabledColor
	t1.TextIconPadding = TextIconPadding
	Return t1
End Sub

Public Sub CreateASTabMenuAdvanced_BadgeProperties (TextColor As Int, TextFont As B4XFont, Height As Float, TextPadding As Float, LeftPadding As Float, BackgroundColor As Int) As ASTabMenuAdvanced_BadgeProperties
	Dim t1 As ASTabMenuAdvanced_BadgeProperties
	t1.Initialize
	t1.TextColor = TextColor
	t1.TextFont = TextFont
	t1.Height = Height
	t1.TextPadding = TextPadding
	t1.LeftPadding = LeftPadding
	t1.BackgroundColor = BackgroundColor
	Return t1
End Sub

Public Sub CreateASTabMenuAdvanced_TabViews (xpnl_Tab As B4XView, xlbl_TabText As B4XView, xiv_TabIcon As B4XView, xlbl_Badge As B4XView) As ASTabMenuAdvanced_TabViews
	Dim t1 As ASTabMenuAdvanced_TabViews
	t1.Initialize
	t1.xpnl_TabBackground = xpnl_Tab
	t1.xlbl_TabText = xlbl_TabText
	t1.xiv_TabIcon = xiv_TabIcon
	t1.xlbl_Badge = xlbl_Badge
	Return t1
End Sub

Public Sub CreateASTabMenuAdvanced_IndicatorProperties (Height As Float, Color As Int, CornerRadius As Float, Duration As Long, SafeGap As Float) As ASTabMenuAdvanced_IndicatorProperties
	Dim t1 As ASTabMenuAdvanced_IndicatorProperties
	t1.Initialize
	t1.Height = Height
	t1.Color = Color
	t1.CornerRadius = CornerRadius
	t1.Duration = Duration
	t1.SafeGap = SafeGap
	Return t1
End Sub

#End Region

Public Sub CreateASTabMenuAdvanced_MiddleButtonProperties (CustomWidth As Float, BackgroundColor As Int, xFont As B4XFont, TextColor As Int, Visible As Boolean) As ASTabMenuAdvanced_MiddleButtonProperties
	Dim t1 As ASTabMenuAdvanced_MiddleButtonProperties
	t1.Initialize
	t1.CustomWidth = CustomWidth
	t1.BackgroundColor = BackgroundColor
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.Visible = Visible
	Return t1
End Sub