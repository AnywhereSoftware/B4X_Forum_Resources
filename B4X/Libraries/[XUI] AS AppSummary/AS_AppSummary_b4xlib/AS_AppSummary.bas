B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Add AddItemAdvanced
	-Add get ConfirmButton
	-Title Text BugFix
V2.00
	-BugFixes
	-Breaking Change - Add Parameter "Value" to AddItem
	-Changed the items base to xCustomListView
		-You can now add as many items as you like, it is scrollable
	-Add get and set TitleTop
	-Add get and set TitleGap - Gap between list and title
	-Add set Theme
	-Add get Theme_Dark
	-Add get Theme_Light
	-Add Designer Property ThemeChangeTransition
		-Default: Fade
	-Add GetItemAt
	-Add Event ItemClicked
	-Add Designer Property HapticFeedback
		-Default: True
	-Add Event CustomDrawItem
	-Add Type AS_AppSummary_ItemViews
	-Add GetItemViews - Gets the item views for a value
	-Add GetItemViews2 - Gets the item views for a index
V2.01
	-New Designer Property ItemBackground
		-Default: None
		-Card - The item is displayed as a card with round borders
	-New Type AS_AppSummary_CardProperties
	-BugFix Title is now multiline
	-BugFixes and Improvements
V2.02
	-BugFixes and Improvements
	-Change Default Value to "None" for the ThemeChangeTransition property
	-New AddImageItem
	-New AddDescriptionItem
	-New AddTitleItem
	-New AddPlaceholder
	-New CreateViewPerCode
	-New Type AS_AppSummary_ImageItem
	-New Type AS_AppSummary_TitleItem
	-New Type AS_AppSummary_TitleProperties
	-New Type AS_AppSummary_DescriptionItem
	-New Type AS_AppSummary_DescriptionProperties
#End If

#DesignerProperty: Key: ThemeChangeTransition, DisplayName: ThemeChangeTransition, FieldType: String, DefaultValue: None, List: None|Fade
#DesignerProperty: Key: HapticFeedback, DisplayName: HapticFeedback, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF131416
#DesignerProperty: Key: TitleTextColor, DisplayName: Title Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: TitleColoredTextColor, DisplayName: Title Colored Text Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: ItemBackground, DisplayName: ItemBackground, FieldType: String, DefaultValue: None, List: None|Card
#DesignerProperty: Key: ItemNameTextColor, DisplayName: Item Name Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ItemDescriptionTextColor, DisplayName: Item Description Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ItemIconColor, DisplayName: Item Icon Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ConfirmButtonColor, DisplayName: Confirm Button Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ConfirmButtonTextColor, DisplayName: Confirm Button Text Color, FieldType: Color, DefaultValue: 0xFF000000

#Event: ConfirmButtonClick
#Event: CustomDrawItem(Item As AS_AppSummary_Item,ItemViews As AS_AppSummary_ItemViews)
#Event: ItemClicked(Item As AS_AppSummary_Item)

Sub Class_Globals
	
	Type AS_AppSummary_Item(Name As String, Description As String, Icon As B4XBitmap,Value As Object)
	Type AS_AppSummary_ImageItem(xBitmap As B4XBitmap,Height As Float,Value As Object)
	Type AS_AppSummary_TitleItem(Text As String,Value As Object)
	Type AS_AppSummary_TitleProperties(TextColor As Int,xFont As B4XFont,HorizontalTextAlignment As String)
	Type AS_AppSummary_DescriptionItem(Text As String,Value As Object)
	Type AS_AppSummary_DescriptionProperties(TextColor As Int,xFont As B4XFont,HorizontalTextAlignment As String)
	Type AS_AppSummary_ItemIconProperties(Width As Float,Color As Int,BackgroundColor As Int,CornerRadius As Float,Alignment As String,SideGap As Float)
	Type AS_AppSummary_ItemViews(BackgroundPanel As B4XView,ItemBackgroundPanel As B4XView,NameLabel As B4XView,DescriptionLabel As B4XView,IconImageView As B4XView)
	
	Type AS_AppSummary_CardProperties(CornerRadius As Float,BackgroundColor As Int, TextGap As Float)
	
	Private g_ItemIconProperties As AS_AppSummary_ItemIconProperties
	Private g_CardProperties As AS_AppSummary_CardProperties
	Private g_TitleProperties As AS_AppSummary_TitleProperties
	Private g_DescriptionProperties As AS_AppSummary_DescriptionProperties
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xclv_Main As CustomListView
	
	Private xiv_RefreshImage As B4XView
	
	Private xbblbl_Title As BBCodeView
	Private m_TextEngine As BCTextEngine
	
	Private xlbl_Start As B4XView
	
	Private m_ThemeChangeTransition As String
	Private m_TitleGap As Float = 20dip
	Private m_TitleTop As Float = 100dip
	Private m_GapBetweenItems As Float = 30dip
	Private m_SideGap As Float = 20dip
	Private m_HapticFeedback As Boolean
	Private m_ItemBackground As String
	
	Private m_BackgroundColor As Int
	Private m_TitleTextColor As Int
	Private m_TitleColoredTextColor As Int
	Private m_ItemNameTextColor As Int
	Private m_ItemDescriptionTextColor As Int
	Private m_ConfirmButtonColor As Int
	Private m_ConfirmButtonTextColor As Int
	Private m_Text1 As String
	Private m_ColoredText As String
	Private m_Text2 As String
	
	Type AS_AppSummary_Theme(BackgroundColor As Int,TitleTextColor As Int,TitleColoredTextColor As Int,ItemNameTextColor As Int,ItemDescriptionTextColor As Int,ItemIconColor As Int,ConfirmButtonColor As Int,ConfirmButtonTextColor As Int,CardBackgroundColor As Int)
	
End Sub

Public Sub setTheme(Theme As AS_AppSummary_Theme)
	
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)

	m_TitleTextColor = Theme.TitleTextColor
	m_TitleColoredTextColor = Theme.TitleColoredTextColor
	m_ItemNameTextColor = Theme.ItemNameTextColor
	m_ItemDescriptionTextColor = Theme.ItemDescriptionTextColor
	g_ItemIconProperties.Color = Theme.ItemIconColor
	m_ConfirmButtonColor = Theme.ConfirmButtonColor
	m_ConfirmButtonTextColor = Theme.ConfirmButtonTextColor
	g_CardProperties.BackgroundColor = Theme.CardBackgroundColor
	
	g_DescriptionProperties.TextColor = m_ItemDescriptionTextColor
	g_TitleProperties.TextColor = m_TitleTextColor
	
	setBackgroundColor(Theme.BackgroundColor)
	
	Sleep(0)
	
	For i = 0 To xclv_Main.Size -1
		xclv_Main.GetPanel(i).RemoveAllViews
	Next
	xclv_Main.Refresh

	Refresh

	Select m_ThemeChangeTransition
		Case "None"
			xiv_RefreshImage.SetVisibleAnimated(0,False)
		Case "Fade"
			Sleep(250)
			xiv_RefreshImage.SetVisibleAnimated(250,False)
	End Select
	
End Sub

Public Sub getTheme_Dark As AS_AppSummary_Theme
	
	Dim Theme As AS_AppSummary_Theme
	Theme.Initialize
	Theme.BackgroundColor = xui.Color_ARGB(255,19, 20, 22)
	Theme.TitleTextColor = xui.Color_White
	Theme.TitleColoredTextColor = xui.Color_ARGB(255,45, 136, 121)
	Theme.ItemNameTextColor = xui.Color_White
	Theme.ItemDescriptionTextColor = xui.Color_White
	Theme.ItemIconColor = xui.Color_White
	Theme.ConfirmButtonColor = xui.Color_White
	Theme.ConfirmButtonTextColor = xui.Color_Black
	Theme.CardBackgroundColor = xui.Color_ARGB(255,31, 34, 37)
	
	Return Theme
	
End Sub

Public Sub getTheme_Light As AS_AppSummary_Theme
	
	Dim Theme As AS_AppSummary_Theme
	Theme.Initialize
	Theme.BackgroundColor = xui.Color_White
	Theme.TitleTextColor = xui.Color_Black
	Theme.TitleColoredTextColor = xui.Color_ARGB(255,45, 136, 121)
	Theme.ItemNameTextColor = xui.Color_Black
	Theme.ItemDescriptionTextColor = xui.Color_Black
	Theme.ItemIconColor = xui.Color_Black
	Theme.ConfirmButtonColor = xui.Color_Black
	Theme.ConfirmButtonTextColor = xui.Color_White
	Theme.CardBackgroundColor = xui.Color_ARGB(255,233, 233, 233)
	
	Return Theme
	
End Sub

Private Sub IniProps(Props As Map)
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BackgroundColor", 0xFF131416))
	m_TitleTextColor = xui.PaintOrColorToColor(Props.GetDefault("TitleTextColor", 0xFFFFFFFF))
	m_TitleColoredTextColor = xui.PaintOrColorToColor(Props.GetDefault("TitleColoredTextColor", 0xFF2D8879))
	m_ItemNameTextColor = xui.PaintOrColorToColor(Props.GetDefault("ItemNameTextColor", 0xFFFFFFFF))
	m_ItemDescriptionTextColor = xui.PaintOrColorToColor(Props.GetDefault("ItemDescriptionTextColor", 0xFFFFFFFF))
	m_ConfirmButtonColor = xui.PaintOrColorToColor(Props.GetDefault("ConfirmButtonColor", 0xFFFFFFFF))
	m_ConfirmButtonTextColor = xui.PaintOrColorToColor(Props.GetDefault("ConfirmButtonTextColor", 0xFF000000))
	m_ThemeChangeTransition = Props.GetDefault("ThemeChangeTransition", "None")
	m_HapticFeedback = Props.GetDefault("HapticFeedback", True)
	m_ItemBackground = Props.GetDefault("ItemBackground", "None").As(String).ToUpperCase

	g_CardProperties.Initialize
	g_CardProperties.CornerRadius = 10dip
	g_CardProperties.BackgroundColor = xui.Color_ARGB(255, 31, 34, 37)
	g_CardProperties.TextGap = 5dip

	g_ItemIconProperties = CreateAS_AppSummary_ItemIconProperties(30dip, xui.PaintOrColorToColor(Props.GetDefault("ItemIconColor", 0xFFFFFFFF)), xui.Color_Transparent, 30dip / 2, "Center", 20dip)

	g_TitleProperties.Initialize
	g_TitleProperties.xFont = xui.CreateDefaultBoldFont(30)
	g_TitleProperties.HorizontalTextAlignment = "CENTER"
	g_TitleProperties.TextColor = m_TitleTextColor

	g_DescriptionProperties.Initialize
	g_DescriptionProperties.xFont = xui.CreateDefaultFont(16)
	g_DescriptionProperties.HorizontalTextAlignment = "CENTER"
	g_DescriptionProperties.TextColor = m_ItemDescriptionTextColor

	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub CreateViewPerCode(Parent As B4XView,Left As Float,Top As Float,Width As Float,Height As Float)
	
	Dim xpnl_ViewBase As B4XView = xui.CreatePanel("")
	Parent.AddView(xpnl_ViewBase,Left,Top,Max(1dip,Width),Max(1dip,Height))
	
	DesignerCreateView(xpnl_ViewBase,CreateLabel(""),CreateMap())
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 

	IniProps(Props)

	mBase.Color = m_BackgroundColor

	Dim xpnl_ListBackground As B4XView = xui.CreatePanel("")
	mBase.AddView(xpnl_ListBackground,0,0,mBase.Width,mBase.Height)
	xclv_Main = ini_xclv("xclv_Main",xpnl_ListBackground,xui.IsB4J)

	Dim xpnl_TitleBase As B4XView = xui.CreatePanel("")
	xpnl_TitleBase.SetLayoutAnimated(0,0,0,mBase.Width,2000dip)

	Dim m As Map
	m.Initialize
	
	Lbl.Text = ""
	
	xbblbl_Title.Initialize(Me,"")
	xbblbl_Title.DesignerCreateView(xpnl_TitleBase,Lbl,m)
	xbblbl_Title.Paragraph.Initialize
	m_TextEngine.Initialize(mBase)
	xbblbl_Title.TextEngine = m_TextEngine
		#If B4J
	xbblbl_Title.sv.As(ScrollPane).Style="-fx-background:transparent;-fx-background-color:transparent;"
	#End If

	xlbl_Start = CreateLabel("xlbl_Start")

	mBase.AddView(xbblbl_Title.mBase,0,0,mBase.Width,100dip)
	mBase.AddView(xlbl_Start,0,mBase.Height - 50dip,mBase.Width,50dip)
	
	xlbl_Start.Text = ""
	xlbl_Start.TextColor = xui.Color_Black
	xlbl_Start.Font = xui.CreateDefaultBoldFont(20)
	xlbl_Start.SetTextAlignment("CENTER","CENTER")
	xlbl_Start.SetColorAndBorder(xui.Color_White,0,0,10dip)
	
	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	mBase.AddView(xiv_RefreshImage,0,0,mBase.Width,mBase.Height)
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub


Public Sub SetTitleText(Text1 As String,ColoredText As String,Text2 As String)
	m_Text1 = Text1
	m_Text2 = Text2
	m_ColoredText = ColoredText
	xbblbl_Title.Text = $"[Alignment=Left][color=#${ColorToHex(m_TitleTextColor)}][TextSize=35][b]${Text1}[color=#${ColorToHex(m_TitleColoredTextColor)}]${ColoredText}[/color]${Text2}[/b][/TextSize][/color][/Alignment]"$
	xbblbl_Title.ParseAndDraw
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	mBase.SetLayoutAnimated(0,mBase.Left,mBase.Top,Width,Height)
	xiv_RefreshImage.SetLayoutAnimated(0,0,0,Width,Height)
	
	xlbl_Start.SetLayoutAnimated(0,m_SideGap,Height - 50dip,Width - m_SideGap*2,50dip)
	
	Dim ListTop As Float = 0
	Dim ListHeight As Float = 0
	
	If m_Text1 = "" And m_Text2 = "" And m_ColoredText = "" Then
		ListTop = 0
		ListHeight = xlbl_Start.Top
		xbblbl_Title.mBase.Visible = False
	Else
		xbblbl_Title.mBase.Visible = True
		xbblbl_Title.mBase.Top = m_TitleTop
		ListTop = xbblbl_Title.mBase.Top + xbblbl_Title.mBase.Height + m_TitleGap
		ListHeight = xlbl_Start.Top - ListTop - m_TitleGap
	End If	
	
	xclv_Main.AsView.SetLayoutAnimated(0,0,ListTop,Width,ListHeight)
	xclv_Main.Base_Resize(Width,ListHeight)
	
End Sub

Public Sub AddItem(Name As String,Description As String,Icon As B4XBitmap,Value As Object) As AS_AppSummary_Item
	
	Dim Item As AS_AppSummary_Item
	Item.Initialize
	Item.Name = Name
	Item.Description = Description
	Item.Icon = Icon
	Item.Value = Value
	 
	AddItemIntern(Item)
	Return Item
	
End Sub

Public Sub AddItemAdvanced(Item As AS_AppSummary_Item)
	AddItemIntern(Item)
End Sub

Public Sub AddImageItem(xBitmap As B4XBitmap,Height As Float,Value As Object) As AS_AppSummary_ImageItem
	
	Dim ImageItem As AS_AppSummary_ImageItem
	ImageItem.Initialize
	ImageItem.xBitmap = xBitmap
	ImageItem.Height = Height
	ImageItem.Value = Value
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("")
	xpnl_Background.Color = m_BackgroundColor
	xpnl_Background.Height = Height
	
	xclv_Main.Add(xpnl_Background,ImageItem)
	Return ImageItem
	
End Sub

Public Sub AddDescriptionItem(Text As String,Value As Object) As AS_AppSummary_DescriptionItem
	
	Dim DescriptionItem As AS_AppSummary_DescriptionItem
	DescriptionItem.Initialize
	DescriptionItem.Text = Text
	DescriptionItem.Value = Value
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("")
	xpnl_Background.Color = m_BackgroundColor
	xpnl_Background.Height = 40dip
	
	xclv_Main.Add(xpnl_Background,DescriptionItem)
	Return DescriptionItem
	
End Sub

Public Sub AddTitleItem(Text As String,Value As Object) As AS_AppSummary_TitleItem
	
	Dim TitleItem As AS_AppSummary_TitleItem
	TitleItem.Initialize
	TitleItem.Text = Text
	TitleItem.Value = Value
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("")
	xpnl_Background.Color = m_BackgroundColor
	xpnl_Background.Height = 40dip
	
	xclv_Main.Add(xpnl_Background,TitleItem)
	Return TitleItem
	
End Sub

Private Sub AddItemIntern(Item As AS_AppSummary_Item)
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("")
	xpnl_Background.Color = m_BackgroundColor
	xpnl_Background.Height = 50dip
	
	xclv_Main.Add(xpnl_Background,Item)
	
End Sub

Public Sub AddPlaceholder(Height As Float)
	Dim xpnl_Placeholder As B4XView = xui.CreatePanel("")
	xpnl_Placeholder.Color = m_BackgroundColor
	xpnl_Placeholder.Height = Height
	xclv_Main.Add(xpnl_Placeholder,"Placeholder")
End Sub

Private Sub BuildDescriptionItem(xpnl_Background As B4XView,Item As AS_AppSummary_DescriptionItem)
	
	Dim xlbl_Description As B4XView = CreateLabel("")
	xlbl_Description.Text = Item.Text
	xlbl_Description.TextColor = g_DescriptionProperties.TextColor
	xlbl_Description.SetTextAlignment("CENTER",g_DescriptionProperties.HorizontalTextAlignment)
	xlbl_Description.Font = g_DescriptionProperties.xFont
		#If B4I
	xlbl_Description.As(Label).Multiline = True
	#Else If B4A
	xlbl_Description.As(Label).SingleLine = False
	#Else If B4J
	xlbl_Description.As(Label).WrapText = True
	#End If
	
	xlbl_Description.Width = xpnl_Background.Width - m_SideGap*2
	
	xpnl_Background.AddView(xlbl_Description,m_SideGap,0,xpnl_Background.Width - m_SideGap*2,MeasureMultilineTextHeight(xlbl_Description))
	
	xclv_Main.ResizeItem(xclv_Main.GetItemFromView(xpnl_Background),xlbl_Description.Height)
	
End Sub

Private Sub BuildTitleItem(xpnl_Background As B4XView,Item As AS_AppSummary_TitleItem)
	
	Dim xlbl_Title As B4XView = CreateLabel("")
	xlbl_Title.Text = Item.Text
	xlbl_Title.TextColor = g_TitleProperties.TextColor
	xlbl_Title.SetTextAlignment("CENTER",g_TitleProperties.HorizontalTextAlignment)
	xlbl_Title.Font = g_TitleProperties.xFont
		#If B4I
	xlbl_Title.As(Label).Multiline = True
	#Else If B4A
	xlbl_Title.As(Label).SingleLine = False
	#Else If B4J
	xlbl_Title.As(Label).WrapText = True
	#End If
	
	xlbl_Title.Width = xpnl_Background.Width - m_SideGap*2
	
	xpnl_Background.AddView(xlbl_Title,m_SideGap,0,xpnl_Background.Width - m_SideGap*2,MeasureMultilineTextHeight(xlbl_Title))
	
	xclv_Main.ResizeItem(xclv_Main.GetItemFromView(xpnl_Background),xlbl_Title.Height)
	
End Sub

Private Sub BuildImageItem(xpnl_Background As B4XView,Item As AS_AppSummary_ImageItem)

	Dim xpnl_ItemBackground As B4XView = xui.CreatePanel("")
	xpnl_Background.AddView(xpnl_ItemBackground,0,0,mBase.Width,Item.Height)

	Dim xiv As B4XImageView = CreateB4XImageView
	xiv.mBackgroundColor = xui.Color_Transparent
	xpnl_ItemBackground.AddView(xiv.mBase,0,0,xpnl_ItemBackground.Width,Item.Height)
	xiv.Bitmap = Item.xBitmap

	xpnl_Background.Color = m_BackgroundColor

End Sub

Private Sub BuildItem(xpnl_Background As B4XView,Item As AS_AppSummary_Item)

	Dim IconLeft As Float = 5dip
	Dim SideGap4Icon As Float = IIf(Item.Icon.IsInitialized,g_ItemIconProperties.Width + g_ItemIconProperties.SideGap + IconLeft,0)
	
	Dim xpnl_ItemBackground As B4XView = xui.CreatePanel("")
	xpnl_Background.AddView(xpnl_ItemBackground,m_SideGap,0,mBase.Width - m_SideGap*2,10dip)
'	xpnl_ItemBackground.Color = xui.Color_ARGB(255,32, 33, 37)
'	xpnl_Background.Color = xui.Color_Red
	
	Dim xlbl_Name As B4XView = CreateLabel("")
	Dim xlbl_Description As B4XView = CreateLabel("")
	Dim xiv_Icon As B4XView = CreateImageView("")
	
	
	xpnl_ItemBackground.AddView(xlbl_Name,0,0,2dip,2dip)
	xpnl_ItemBackground.AddView(xlbl_Description,0,0,2dip,2dip)
	xpnl_ItemBackground.AddView(xiv_Icon,0,0,2dip,2dip)
		
	xlbl_Name.Text = Item.Name
	xlbl_Name.TextColor = m_ItemNameTextColor
	xlbl_Name.Font = xui.CreateDefaultBoldFont(20)
	xlbl_Name.SetTextAlignment("CENTER","LEFT")
		
	#If B4I
	xlbl_Name.As(Label).Multiline = True
	#Else If B4J
	xlbl_Name.As(Label).WrapText = True
	#Else
	xlbl_Name.As(Label).SingleLine = False
	#End If

	xlbl_Description.Text = Item.Description
	xlbl_Description.TextColor = m_ItemDescriptionTextColor
	xlbl_Description.Font = xui.CreateDefaultFont(17)
	xlbl_Description.SetTextAlignment("CENTER","LEFT")
		
	#If B4I
	xlbl_Description.As(Label).Multiline = True
	#Else If B4J
	xlbl_Description.As(Label).WrapText = True
	#Else
	xlbl_Description.As(Label).SingleLine = False
	#End If

	Dim Description2NameGap As Float = 2dip

	If m_ItemBackground = getItemBackground_None Then
		xlbl_Name.Width = xpnl_ItemBackground.Width - SideGap4Icon
		xlbl_Description.Width = xpnl_ItemBackground.Width - SideGap4Icon
		
		xlbl_Name.SetLayoutAnimated(0,SideGap4Icon,0,xlbl_Name.Width,MeasureMultilineTextHeight(xlbl_Name))
		xlbl_Description.SetLayoutAnimated(0,SideGap4Icon,xlbl_Name.Height + Description2NameGap,xlbl_Description.Width,MeasureMultilineTextHeight(xlbl_Description))
		
		xpnl_Background.Height = xlbl_Name.Height + xlbl_Description.Height + IIf(xclv_Main.Size=0, m_GapBetweenItems/2,m_GapBetweenItems) + Description2NameGap
		xpnl_ItemBackground.Height = xpnl_Background.Height - IIf(xclv_Main.Size=0, m_GapBetweenItems/2,m_GapBetweenItems) + Description2NameGap
		
	Else If m_ItemBackground = getItemBackground_Card Then
		xlbl_Name.Width = xpnl_ItemBackground.Width - SideGap4Icon - g_CardProperties.TextGap*2
		xlbl_Description.Width = xpnl_ItemBackground.Width - SideGap4Icon - g_CardProperties.TextGap*2
		
		xpnl_ItemBackground.SetColorAndBorder(g_CardProperties.BackgroundColor,0,0,g_CardProperties.CornerRadius)
		xlbl_Name.SetLayoutAnimated(0,SideGap4Icon + g_CardProperties.TextGap,g_CardProperties.TextGap,xlbl_Name.Width,MeasureMultilineTextHeight(xlbl_Name))
		xlbl_Description.SetLayoutAnimated(0,SideGap4Icon + g_CardProperties.TextGap,xlbl_Name.Height + Description2NameGap + g_CardProperties.TextGap,xlbl_Description.Width,MeasureMultilineTextHeight(xlbl_Description))
	
		xpnl_Background.Height = xlbl_Name.Height + xlbl_Description.Height + IIf(xclv_Main.Size=0, m_GapBetweenItems/2,m_GapBetweenItems) + g_CardProperties.TextGap + Description2NameGap
		xpnl_ItemBackground.Height = xpnl_Background.Height - IIf(xclv_Main.Size=0, m_GapBetweenItems/2,m_GapBetweenItems) + g_CardProperties.TextGap + Description2NameGap
		IconLeft = xlbl_Name.Left/2 - g_ItemIconProperties.Width/2
	End If
	
	xpnl_ItemBackground.Top = IIf(xclv_Main.Size=0,0, xpnl_Background.Height/2 - xpnl_ItemBackground.Height/2)
	
	If Item.Icon.IsInitialized Then
			
		Select g_ItemIconProperties.Alignment
			Case "Top"
				xiv_Icon.SetLayoutAnimated(0,IconLeft,0,g_ItemIconProperties.Width,g_ItemIconProperties.Width)
			Case "Center"
				xiv_Icon.SetLayoutAnimated(0,IconLeft,(xpnl_ItemBackground.Height)/2 - g_ItemIconProperties.Width/2,g_ItemIconProperties.Width,g_ItemIconProperties.Width)
			Case "Bottom"
				xiv_Icon.SetLayoutAnimated(0,IconLeft,(xpnl_ItemBackground.Height) - g_ItemIconProperties.Width,g_ItemIconProperties.Width,g_ItemIconProperties.Width)
		End Select
			
			#If B4A OR B4I
		xiv_Icon.SetBitmap(Item.Icon)
		TintBmp(xiv_Icon,g_ItemIconProperties.Color)
			#Else
			xiv_Icon.SetBitmap(ChangeColorBasedOnAlphaLevel(Item.Icon,g_ItemIconProperties.Color))
			#End If
			
	End If

	xclv_Main.ResizeItem(xclv_Main.GetItemFromView(xpnl_Background),xpnl_Background.Height)

	xpnl_Background.Color = m_BackgroundColor

	CustomDrawItem(Item,CreateAS_AppSummary_ItemViews(xpnl_Background,xpnl_ItemBackground,xlbl_Name,xlbl_Description,xiv_Icon))
	
End Sub

Public Sub ClearItems
	xclv_Main.Clear
End Sub

Public Sub Refresh
	
	Base_Resize(mBase.Width,mBase.Height)
	
	mBase.Color = m_BackgroundColor
	xbblbl_Title.mBase.Color = m_BackgroundColor
	SetTitleText(m_Text1,m_ColoredText,m_Text2)
	xlbl_Start.TextColor = m_ConfirmButtonTextColor
	xlbl_Start.SetColorAndBorder(m_ConfirmButtonColor,0,0,10dip)
	
	xbblbl_Title.mBase.SetLayoutAnimated(0,m_SideGap,xbblbl_Title.mBase.Top,mBase.Width - m_SideGap*2,2000dip)
	xbblbl_Title.ParseAndDraw
	Dim ContentHeight As Int = Min(xbblbl_Title.Paragraph.Height / m_TextEngine.mScale + xbblbl_Title.Padding.Top + xbblbl_Title.Padding.Bottom, xbblbl_Title.mBase.Height)
	xbblbl_Title.mBase.SetLayoutAnimated(0,m_SideGap,xbblbl_Title.mBase.Top,mBase.Width - m_SideGap*2,ContentHeight)
	xbblbl_Title.Base_Resize(xbblbl_Title.mBase.Width,xbblbl_Title.mBase.Height + 5dip)
	xbblbl_Title.Padding.Left = 0
	xbblbl_Title.ParseAndDraw
	'xbblbl_Title.mBase.Color = xui.Color_Red
End Sub

Public Sub GetItemAt(Index As Int) As AS_AppSummary_Item
	Return xclv_Main.GetValue(Index)
End Sub

'Gets the item views for a value
Public Sub GetItemViews(Value As Object) As AS_AppSummary_ItemViews
	For i = 0 To xclv_Main.Size -1
		Dim Item As AS_AppSummary_Item = xclv_Main.GetValue(i)
		If Value = Item.Value Then
			Dim xpnl_Background As B4XView = xclv_Main.GetPanel(i)
			Dim xpnl_ItemBackground As B4XView = xpnl_Background.GetView(0)
			Return CreateAS_AppSummary_ItemViews(xpnl_Background,xpnl_ItemBackground,xpnl_ItemBackground.GetView(0),xpnl_ItemBackground.GetView(1),xpnl_ItemBackground.GetView(2))
		End If
	Next
	LogColor("GetItemViews: No item found for value " & Value,xui.Color_Red)
	Return Null
End Sub

'Gets the item views for a index
Public Sub GetItemViews2(Index As Int) As AS_AppSummary_ItemViews
	Dim xpnl_Background As B4XView = xclv_Main.GetPanel(Index)
	Dim xpnl_ItemBackground As B4XView = xpnl_Background.GetView(0)
	Return CreateAS_AppSummary_ItemViews(xpnl_Background,xpnl_ItemBackground,xpnl_ItemBackground.GetView(0),xpnl_ItemBackground.GetView(1),xpnl_ItemBackground.GetView(2))
End Sub

#Region Properties

Public Sub setItemBackground(ItemBackground As String)
	m_ItemBackground = ItemBackground.ToUpperCase
End Sub

Public Sub getItemBackground As String
	Return m_ItemBackground
End Sub

Public Sub setHapticFeedback(HapticFeedback As Boolean)
	m_HapticFeedback = HapticFeedback
End Sub

Public Sub getHapticFeedback As Boolean
	Return m_HapticFeedback
End Sub

'Fade or None
Public Sub setThemeChangeTransition(ThemeChangeTransition As String)
	m_ThemeChangeTransition = ThemeChangeTransition
End Sub

Public Sub getThemeChangeTransition As String
	Return m_ThemeChangeTransition
End Sub

'Gap between list and title
'Default: 20dip
'Call Refresh if you change something
Public Sub setTitleGap(TitleGap As Float)
	m_TitleGap = TitleGap
End Sub

Public Sub getTitleGap As Float
	Return m_TitleGap
End Sub

'Default: 100dip
'Call Refresh if you change something
Public Sub setTitleTop(TitleTop As Float)
	m_TitleTop = TitleTop
End Sub

Public Sub getTitleTop As Float
	Return m_TitleTop
End Sub

Public Sub getCardProperties As AS_AppSummary_CardProperties
	Return g_CardProperties
End Sub

'Call Refresh if you change something
Public Sub getItemIconProperties As AS_AppSummary_ItemIconProperties
	Return g_ItemIconProperties
End Sub

Public Sub getConfirmButton As B4XView
	Return xlbl_Start
End Sub

Public Sub setConfirmButtonText(Text As String)
	xlbl_Start.Text = Text
End Sub

'Call Refresh if you change something
Public Sub setConfirmButtonTextColor(Color As Int)
	m_ConfirmButtonTextColor = Color
End Sub

Public Sub getConfirmButtonTextColor As Int
	Return m_ConfirmButtonTextColor
End Sub

'Call Refresh if you change something
Public Sub setConfirmButtonColor(Color As Int)
	m_ConfirmButtonColor = Color
End Sub

Public Sub getConfirmButtonColor As Int
	Return m_ConfirmButtonColor
End Sub

'Call Refresh if you change something
Public Sub setItemDescriptionTextColor(Color As Int)
	m_ItemDescriptionTextColor = Color
End Sub

Public Sub getItemDescriptionTextColor As Int
	Return m_ItemDescriptionTextColor
End Sub

'Call Refresh if you change something
Public Sub setItemNameTextColor(Color As Int)
	m_ItemNameTextColor = Color
End Sub

Public Sub getItemNameTextColor As Int
	Return m_ItemNameTextColor
End Sub

'Call SetTitleText if you change this property
Public Sub setTitleColoredTextColor(Color As Int)
	m_TitleColoredTextColor = Color
End Sub

Public Sub getTitleColoredTextColor As Int
	Return m_TitleColoredTextColor
End Sub

'Call SetTitleText if you change this property
Public Sub setTitleTextColor(Color As Int)
	m_TitleTextColor = Color
End Sub

Public Sub getTitleTextColor As Int
	Return m_TitleTextColor
End Sub

'Call Refresh if you change something
Public Sub setBackgroundColor(BackgroundColor As Int)
	m_BackgroundColor = BackgroundColor
	mBase.Color = BackgroundColor
	xclv_Main.AsView.Color = BackgroundColor
	xclv_Main.sv.ScrollViewInnerPanel.Color = BackgroundColor
	xclv_Main.GetBase.Color = BackgroundColor
End Sub

Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

#End Region

#Region Enums

Public Sub getItemBackground_None As String
	Return "NONE"
End Sub

Public Sub getItemBackground_Card As String
	Return "CARD"
End Sub

#End Region

#Region ViewEvents

Private Sub xclv_Main_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Dim ExtraSize As Int = 20
	For i = 0 To xclv_Main.Size - 1
		Dim p As B4XView = xclv_Main.GetPanel(i)
		If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				If xclv_Main.GetValue(i) Is AS_AppSummary_Item Then
					BuildItem(p,xclv_Main.GetValue(i))
				Else If xclv_Main.GetValue(i) Is AS_AppSummary_ImageItem Then
					BuildImageItem(p,xclv_Main.GetValue(i))
				Else If xclv_Main.GetValue(i) Is AS_AppSummary_TitleItem Then		
					BuildTitleItem(p,xclv_Main.GetValue(i))
				Else If xclv_Main.GetValue(i) Is AS_AppSummary_DescriptionItem Then
					BuildDescriptionItem(p,xclv_Main.GetValue(i))
				End If

			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews
			End If
		End If
	Next
End Sub

Private Sub xclv_Main_ItemClick (Index As Int, Value As Object)
	If m_HapticFeedback Then XUIViewsUtils.PerformHapticFeedback(xclv_Main.GetPanel(Index))
	Select True
		Case Value Is AS_AppSummary_Item
			ItemClicked(Value)
		Case Value Is AS_AppSummary_ImageItem
			
		Case Value Is AS_AppSummary_DescriptionItem
			
		Case Value Is AS_AppSummary_TitleItem
			
	End Select
	
End Sub

#If B4J
Private Sub xlbl_Start_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Start_Click
#End If
	If m_HapticFeedback Then XUIViewsUtils.PerformHapticFeedback(xlbl_Start)
	ConfirmButtonClick
End Sub

#End Region

#Region Events

Private Sub ConfirmButtonClick
	If xui.SubExists(mCallBack,mEventName & "_ConfirmButtonClick",0) Then
		CallSub(mCallBack,mEventName & "_ConfirmButtonClick")
	End If
End Sub

Private Sub ItemClicked(Item As AS_AppSummary_Item)
	If xui.SubExists(mCallBack, mEventName & "_ItemClicked",1) Then
		CallSub2(mCallBack, mEventName & "_ItemClicked",Item)
	End If
End Sub

Private Sub CustomDrawItem(Item As AS_AppSummary_Item,ItemViews As AS_AppSummary_ItemViews)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawItem",2) Then
		CallSub3(mCallBack, mEventName & "_CustomDrawItem",Item,ItemViews)
	End If
End Sub

#End Region

#Region Functions

Private Sub ini_xclv(EventName As String,Parent As B4XView,ShowScrollBar As Boolean) As CustomListView
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim clv As CustomListView
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0x00FFFFFF)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x00FFFFFF)
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation","Vertical")
	tmpmap.Put("ShowScrollBar",False)
	clv.Initialize(Me,EventName)
	clv.DesignerCreateView(Parent,tmplbl,tmpmap)

	#If B4I
	Do While clv.sv.IsInitialized = False
		'Sleep(0)
	Loop
	Dim sv As ScrollView = clv.sv
	sv.Color = xui.Color_Transparent
	clv.sv.As(NativeObject).SetField("contentInsetAdjustmentBehavior", 1) 'Always
	#Else IF B4J
	clv.sv.As(ScrollPane).Style = "-fx-background:transparent;-fx-background-color:transparent;"
	#End If
	
	Return clv
	
End Sub

Private Sub CreateB4XImageView As B4XImageView
	Dim xiv As B4XImageView
	xiv.Initialize(Me,"xiv")

	Dim xpnl_ImageBasePanel As B4XView = xui.CreatePanel("")
	xpnl_ImageBasePanel.SetLayoutAnimated(0,0,0,40dip,40dip)
   
	Dim xlbl_ImageLabel As Label
	xlbl_ImageLabel.Initialize("")
   
	Dim PropertyMap As Map
	PropertyMap.Initialize
	PropertyMap.Put("ResizeMode","FIT")
	PropertyMap.Put("Round",False)
	PropertyMap.Put("CornersRadius",0)
	PropertyMap.Put("BackgroundColor",0xFFAAAAAA)
   
	xiv.DesignerCreateView(xpnl_ImageBasePanel,xlbl_ImageLabel,PropertyMap)
	Return xiv
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub MeasureMultilineTextHeight(xLabel As B4XView) As Double
    #If B4J
	'https://www.b4x.com/android/forum/threads/measure-multiline-text-height.84331/#content
    Dim jo As JavaObject = Me
    Return jo.RunMethod("MeasureMultilineTextHeight", Array(xLabel.Font, xLabel.Text, xLabel.Width))
    #Else if B4A
    Dim su As StringUtils
    Return su.MeasureMultilineTextHeight(xLabel,xLabel.Text)
    #Else if B4I
	Dim tmpLabel As Label
	tmpLabel.Initialize("")
	tmpLabel.Font = xLabel.Font
	tmpLabel.Width = xLabel.Width
	tmpLabel.Text = xLabel.Text
	tmpLabel.Multiline = True
	tmpLabel.SizeToFit
	Return tmpLabel.Height
    #End IF
End Sub

#If B4J
#if Java
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import javafx.scene.text.Font;
import javafx.scene.text.TextBoundsType;
public static double MeasureMultilineTextHeight(Font f, String text, double width) throws Exception {
  Method m = Class.forName("com.sun.javafx.scene.control.skin.Utils").getDeclaredMethod("computeTextHeight",
  Font.class, String.class, double.class, TextBoundsType.class);
  m.setAccessible(true);
  return (Double)m.invoke(null, f, text, width, TextBoundsType.LOGICAL_VERTICAL_CENTER);
  }
#End If
#End If

'int ot argb
Private Sub GetARGB(Color As Int) As Int()'ignore
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#If B4A OR B4I
Private Sub TintBmp(img As ImageView, color As Int)
	'If m_ColorIcons = True Then
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
		'jo.RunMethod("setImageBitmap",Array(img.Bitmap))
	'jo.RunMethod("setColorFilter",Array(Colors.Transparent))
		jo.RunMethod("setColorFilter",Array(Colors.rgb(GetARGB(color)(1),GetARGB(color)(2),GetARGB(color)(3))))
	
	#End If
	'End If
	
End Sub
#End If


#If B4J
Sub ChangeColorBasedOnAlphaLevel(bmp As B4XBitmap, NewColor As Int) As B4XBitmap
	'If m_ColorIcons = True Then
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
'	Else
'		Return bmp
'	End If
End Sub
#end If

#If OBJC
- (void)BmpColor: (UIImageView*) theImageView :(UIColor*) Color{
theImageView.image = [theImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
[theImageView setTintColor:Color];
}
#end if

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

Private Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Dim Hex As String = bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
	If Hex.Length > 6 Then Hex = Hex.SubString(Hex.Length - 6)
	Return Hex
End Sub

#End Region

Private Sub CreateAS_AppSummary_ItemIconProperties (Width As Float, Color As Int, BackgroundColor As Int, CornerRadius As Float, Alignment As String, SideGap As Float) As AS_AppSummary_ItemIconProperties
	Dim t1 As AS_AppSummary_ItemIconProperties
	t1.Initialize
	t1.Width = Width
	t1.Color = Color
	t1.BackgroundColor = BackgroundColor
	t1.CornerRadius = CornerRadius
	t1.Alignment = Alignment
	t1.SideGap = SideGap
	Return t1
End Sub

Private Sub CreateAS_AppSummary_ItemViews (BackgroundPanel As B4XView, ItemBackgroundPanel As B4XView, NameLabel As B4XView, DescriptionLabel As B4XView, IconImageView As B4XView) As AS_AppSummary_ItemViews
	Dim t1 As AS_AppSummary_ItemViews
	t1.Initialize
	t1.BackgroundPanel = BackgroundPanel
	t1.ItemBackgroundPanel = ItemBackgroundPanel
	t1.NameLabel = NameLabel
	t1.DescriptionLabel = DescriptionLabel
	t1.IconImageView = IconImageView
	Return t1
End Sub