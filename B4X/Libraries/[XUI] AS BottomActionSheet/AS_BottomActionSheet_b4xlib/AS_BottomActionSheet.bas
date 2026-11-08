B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-Improvements
	-Add get and set DragIndicatorColor
V1.02
	-Add Event CustomDrawItem
	-Add Type AS_BottomActionSheet_ItemViews
	-Add GetItemViews - Gets the item views for a value
	-Add GetItemViews2 - Gets the item views for a index
	-Add Event Close
	-Add get Size - Get the number of items
V1.03
	-Add Type AS_BottomActionSheet_ItemSmallIconProperties
	-Add SmallIcon to Type AS_BottomActionSheet_Item
	-Add ItemSmallIconProperties to Type AS_BottomActionSheet_Item
	-Add AddItem2 with the SmallIcon Parameter
	-Add set Theme
		-Add get Theme_Dark
		-Add get Theme_Light
V1.04
	-Add get and set SheetWidth - Set a value greater than 0 to define a custom width
		-Default: 0
	-Add TextHorizontalAlignment to Type AS_BottomActionSheet_ItemProperties
		-Left, Center, Right
V1.05
	-Add IconHorizontalAlignment to Type AS_BottomActionSheet_ItemProperties
		-Auto, Left, Right
		-Default: Auto
V1.06
	-New AddItemRow - Add items side by side
	-New CreateItem and CreateItem2, does the same as AddItem and AddItem2 but it is not added to the list
		-is needed for AddItemRow
#End If

#Event: ActionButtonClicked
#Event: CustomDrawItem(Item As AS_BottomActionSheet_Item,ItemViews As AS_BottomActionSheet_ItemViews)
#Event: Close
#Event: ItemClicked(Item As AS_BottomActionSheet_Item)


Sub Class_Globals
	
	Type AS_BottomActionSheet_ItemProperties(Height As Float,LeftGap As Float,xFont As B4XFont,TextColor As Int,IconWidthHeight As Float,SeperatorVisible As Boolean,SeperatorColor As Int,TextHorizontalAlignment As String,IconHorizontalAlignment As String)
	Type AS_BottomActionSheet_Item(Text As String,Icon As B4XBitmap,SmallIcon As B4XBitmap,Value As Object,ItemProperties As AS_BottomActionSheet_ItemProperties,ItemSmallIconProperties As AS_BottomActionSheet_ItemSmallIconProperties)
	Type AS_BottomActionSheet_ItemViews(BackgroundPanel As B4XView,TextLabel As B4XView,SeperatorPanel As B4XView,IconImageView As B4XView)
	Type AS_BottomActionSheet_ItemSmallIconProperties(HorizontalAlignment As String,VerticalAlignment As String,WidthHeight As Float,LeftGap As Float)
	
	Private g_ItemProperties As AS_BottomActionSheet_ItemProperties
	Private g_ItemSmallIconProperties As AS_BottomActionSheet_ItemSmallIconProperties
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	Private xpnl_ItemsBackground As B4XView
	
	Private xpnl_Header As B4XView
	Private xpnl_Body As B4XView
	Private xlbl_ActionButton As B4XView
	Private xpnl_DragIndicator As B4XView
	
	Private m_HeaderHeight As Float
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_ActionButtonVisible As Boolean
	Private m_DragIndicatorColor As Int
	Private m_SheetWidth As Float = 0
	
	Private lst_Items As List
	
	Type AS_BottomActionSheet_Theme(BodyColor As Int,TextColor As Int,DragIndicatorColor As Int)
	
End Sub

Public Sub getTheme_Light As AS_BottomActionSheet_Theme
	
	Dim Theme As AS_BottomActionSheet_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_White
	Theme.TextColor = xui.Color_Black
	Theme.DragIndicatorColor = xui.Color_Black

	Return Theme
	
End Sub

Public Sub getTheme_Dark As AS_BottomActionSheet_Theme
	
	Dim Theme As AS_BottomActionSheet_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.TextColor = xui.Color_White
	Theme.DragIndicatorColor = xui.Color_White

	Return Theme
	
End Sub

Public Sub setTheme(Theme As AS_BottomActionSheet_Theme)
	
	m_HeaderColor = Theme.BodyColor
	m_BodyColor = Theme.BodyColor
	g_ItemProperties.TextColor = Theme.TextColor
	m_DragIndicatorColor = Theme.DragIndicatorColor
	
	setColor(m_BodyColor)
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	lst_Items.Initialize
	
	g_ItemProperties = CreateAS_BottomActionSheet_ItemProperties(60dip,20dip,xui.CreateDefaultFont(18),xui.Color_White,30dip,False,xui.Color_White,"LEFT")
	g_ItemSmallIconProperties = CreateAS_BottomActionSheet_ItemSmallIconProperties(getHorizontalAlignment_AfterText,getVerticalAlignment_Top,15dip,5dip)
	
	xpnl_Header = xui.CreatePanel("")
	xpnl_Body = xui.CreatePanel("")
	xlbl_ActionButton = CreateLabel("xlbl_ActionButton")
	xpnl_DragIndicator = xui.CreatePanel("")
	
	m_DragIndicatorColor = xui.Color_ARGB(80,255,255,255)
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	
	m_HeaderHeight = 30dip
	m_ActionButtonVisible = False

End Sub

Public Sub AddItem(Text As String,Icon As B4XBitmap,Value As Object) As AS_BottomActionSheet_Item
	Return AddItemIntern(Text,Icon,Null,Value)
End Sub

'SmallIcon - An icon that can be displayed before or after the text
Public Sub AddItem2(Text As String,Icon As B4XBitmap,SmallIcon As B4XBitmap,Value As Object) As AS_BottomActionSheet_Item
	Return AddItemIntern(Text,Icon,SmallIcon,Value)
End Sub

'Expect: List Of AS_BottomActionSheet_Item (build via CreateItem / CreateItem2)
Public Sub AddItemRow(Items As List)
	If Items.IsInitialized = False Or Items.Size = 0 Then Return
	lst_Items.Add(Items)
End Sub


' Public factories to build items without adding them to the list
Public Sub CreateItem(Text As String, Icon As B4XBitmap, Value As Object) As AS_BottomActionSheet_Item
	Return BuildItem(Text, Icon, Null, Value)
End Sub

Public Sub CreateItem2(Text As String, Icon As B4XBitmap, SmallIcon As B4XBitmap, Value As Object) As AS_BottomActionSheet_Item
	Return BuildItem(Text, Icon, SmallIcon, Value)
End Sub

Private Sub BuildItem(Text As String, Icon As B4XBitmap, SmallIcon As B4XBitmap, Value As Object) As AS_BottomActionSheet_Item
	Dim ItemProperties As AS_BottomActionSheet_ItemProperties
	ItemProperties.Initialize
	ItemProperties.Height = g_ItemProperties.Height
	ItemProperties.IconWidthHeight = g_ItemProperties.IconWidthHeight
	ItemProperties.LeftGap = g_ItemProperties.LeftGap
	ItemProperties.SeperatorVisible = g_ItemProperties.SeperatorVisible
	ItemProperties.TextColor = g_ItemProperties.TextColor
	ItemProperties.xFont = g_ItemProperties.xFont
	ItemProperties.SeperatorColor = g_ItemProperties.SeperatorColor
	ItemProperties.TextHorizontalAlignment = g_ItemProperties.TextHorizontalAlignment
	ItemProperties.IconHorizontalAlignment = g_ItemProperties.IconHorizontalAlignment
    
	Dim ItemSmallIconProperties As AS_BottomActionSheet_ItemSmallIconProperties
	ItemSmallIconProperties.Initialize
	ItemSmallIconProperties.HorizontalAlignment = g_ItemSmallIconProperties.HorizontalAlignment
	ItemSmallIconProperties.VerticalAlignment = g_ItemSmallIconProperties.VerticalAlignment
	ItemSmallIconProperties.LeftGap = g_ItemSmallIconProperties.LeftGap
	ItemSmallIconProperties.WidthHeight = g_ItemSmallIconProperties.WidthHeight
    
	Return CreateAS_BottomActionSheet_Item(Text, Icon, SmallIcon, Value, ItemProperties, ItemSmallIconProperties)
End Sub

Private Sub AddItemIntern(Text As String, Icon As B4XBitmap, SmallIcon As B4XBitmap, Value As Object) As AS_BottomActionSheet_Item
	Dim Item As AS_BottomActionSheet_Item = BuildItem(Text, Icon, SmallIcon, Value)
	lst_Items.Add(Item)
	Return Item
End Sub

Public Sub ShowPicker
	
	Dim SheetWidth As Float = IIf(m_SheetWidth=0,xParent.Width,m_SheetWidth)
	
	Dim ListHeight As Float = g_ItemProperties.Height*lst_Items.Size
	Dim BodyHeight As Float = ListHeight
	Dim SafeAreaHeight As Float = 0
	
	If m_ActionButtonVisible Then
		BodyHeight = BodyHeight + 50dip
	End If
	
	#If B4I
	SafeAreaHeight = B4XPages.GetNativeParent(B4XPages.MainPage).SafeAreaInsets.Bottom
	BodyHeight = BodyHeight + SafeAreaHeight
	#Else
	SafeAreaHeight = 20dip
	BodyHeight = BodyHeight + SafeAreaHeight
	#End If
	
	BottomCard.Initialize(Me,"BottomCard")
	BottomCard.BodyDrag = True
	BottomCard.Create(xParent,BodyHeight,BodyHeight,m_HeaderHeight,SheetWidth,BottomCard.Orientation_MIDDLE)
	
	xpnl_Header.Color = m_HeaderColor
	
	xpnl_Header.AddView(xpnl_DragIndicator,SheetWidth/2 - 70dip/2,m_HeaderHeight - 6dip,70dip,6dip)
	Dim ARGB() As Int = GetARGB(m_DragIndicatorColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
	
	xlbl_ActionButton.RemoveViewFromParent
	
	If m_ActionButtonVisible Then
	
		xlbl_ActionButton.Text = "Confirm"
		xlbl_ActionButton.TextColor = xui.Color_White
		xlbl_ActionButton.SetColorAndBorder(xui.Color_ARGB(255,45, 136, 121),0,0,10dip)
		xlbl_ActionButton.SetTextAlignment("CENTER","CENTER")
		
		Dim ConfirmationButtoHeight As Float = 40dip
		Dim ConfirmationButtoWidth As Float = 220dip
		If SheetWidth < ConfirmationButtoWidth Then ConfirmationButtoWidth = SheetWidth - 20dip
		
		BottomCard.BodyPanel.AddView(xlbl_ActionButton,SheetWidth/2 - ConfirmationButtoWidth/2,BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,ConfirmationButtoWidth,ConfirmationButtoHeight)
	
	End If
	

	BottomCard.BodyPanel.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,SheetWidth,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_Body,0,0,SheetWidth,ListHeight)
	BottomCard.CornerRadius_Header = 30dip/2
	
	xpnl_ItemsBackground = xui.CreatePanel("")
	xpnl_Body.AddView(xpnl_ItemsBackground,0,0,xpnl_Body.Width,ListHeight)

	For i = 0 To lst_Items.Size -1
		CreateItemIntern(lst_Items.Get(i))
	Next
	
	Sleep(0)
	
	BottomCard.Show(False)
	
End Sub

Public Sub HidePicker
	BottomCard.Hide(False)
End Sub

'Gets the item views for a value
Public Sub GetItemViews(Value As Object) As AS_BottomActionSheet_ItemViews
	For i = 0 To lst_Items.Size -1
		
		If lst_Items.Get(i) Is AS_BottomActionSheet_Item Then
			
			Dim Item As AS_BottomActionSheet_Item = lst_Items.Get(i)
			If Value = Item.Value Then
				Dim xpnl_Background As B4XView = xpnl_ItemsBackground.GetView(i)
				Return CreateAS_BottomActionSheet_ItemViews(xpnl_Background,xpnl_Background.GetView(0),xpnl_Background.GetView(1),xpnl_Background.GetView(2))
			End If
			
		Else
				
			For Each Item As AS_BottomActionSheet_Item In lst_Items.Get(i).As(List)
				If Value = Item.Value Then
					Dim xpnl_Background As B4XView = xpnl_ItemsBackground.GetView(i)
					Return CreateAS_BottomActionSheet_ItemViews(xpnl_Background,xpnl_Background.GetView(0),xpnl_Background.GetView(1),xpnl_Background.GetView(2))
				End If
			Next
				
		End If
		
	Next
	LogColor("GetItemViews: No item found for value " & Value,xui.Color_Red)
	Return Null
End Sub

'Gets the item views for a index
Public Sub GetItemViews2(Index As Int) As AS_BottomActionSheet_ItemViews
	Dim xpnl_Background As B4XView = xpnl_ItemsBackground.GetView(Index)
	Return CreateAS_BottomActionSheet_ItemViews(xpnl_Background,xpnl_Background.GetView(0),xpnl_Background.GetView(1),xpnl_Background.GetView(2))
End Sub

Private Sub BuildItemIntern(xpnl_ItemBackground As B4XView,Item As AS_BottomActionSheet_Item)
	
	Dim xlbl_Text As B4XView = CreateLabel("")
	xlbl_Text.Text = Item.Text
	xlbl_Text.TextColor = Item.ItemProperties.TextColor
	xlbl_Text.SetTextAlignment("CENTER",Item.ItemProperties.TextHorizontalAlignment.ToUpperCase)
	xlbl_Text.Font = Item.ItemProperties.xFont

	'xpnl_ItemBackground.AddView(xlbl_Text,IIf(Item.Icon.IsInitialized,Item.ItemProperties.LeftGap*2 + Item.ItemProperties.IconWidthHeight,Item.ItemProperties.LeftGap),0,xpnl_ItemBackground.Width - (IIf(Item.Icon.IsInitialized,Item.ItemProperties.LeftGap*2,Item.ItemProperties.LeftGap))*2 + Item.ItemProperties.IconWidthHeight,xpnl_ItemBackground.Height)
	
	Dim leftGap As Int = IIf(Item.Icon.IsInitialized, Item.ItemProperties.LeftGap * 2 + Item.ItemProperties.IconWidthHeight, Item.ItemProperties.LeftGap)
	Dim availableWidth As Int = xpnl_ItemBackground.Width - (leftGap * 2)
	Dim leftPosition As Int = leftGap
	Dim textWidth As Int = availableWidth
	xpnl_ItemBackground.AddView(xlbl_Text, leftPosition, 0, textWidth, xpnl_ItemBackground.Height)
	'xlbl_Text.Color = xui.Color_Red
	Dim ARGB() As Int = GetARGB(Item.ItemProperties.SeperatorColor)
	
	Dim xpnl_Seperator As B4XView = xui.CreatePanel("")
	xpnl_ItemBackground.AddView(xpnl_Seperator,0,xpnl_ItemBackground.Height - 2dip,xpnl_ItemBackground.Width,2dip)
	
	If Item.ItemProperties.SeperatorVisible And xpnl_ItemsBackground.NumberOfViews < lst_Items.Size -1 Then
		xpnl_Seperator.Color = xui.Color_ARGB(30,ARGB(1),ARGB(2),ARGB(3))
	Else
		xpnl_Seperator.Color = xui.Color_Transparent
	End If
	
	Dim xiv_Icon As B4XView = CreateImageView
	xpnl_ItemBackground.AddView(xiv_Icon,Item.ItemProperties.LeftGap,xpnl_ItemBackground.Height/2 - Item.ItemProperties.IconWidthHeight/2,Item.ItemProperties.IconWidthHeight,Item.ItemProperties.IconWidthHeight)
	
	Select Item.ItemProperties.TextHorizontalAlignment.ToUpperCase
		Case "LEFT"
			
			Select Item.ItemProperties.IconHorizontalAlignment.ToUpperCase
				Case getIconHorizontalAlignment_Auto, getIconHorizontalAlignment_Left
					xiv_Icon.Left = Item.ItemProperties.LeftGap
					If Item.Icon.IsInitialized Then xlbl_Text.Width = xlbl_Text.Width + xiv_Icon.Width + Item.ItemProperties.LeftGap
				Case getIconHorizontalAlignment_Right
					xiv_Icon.Left = xpnl_Body.Width - Item.ItemProperties.LeftGap - xiv_Icon.Width
					If Item.Icon.IsInitialized Then
						xlbl_Text.Left = Item.ItemProperties.LeftGap
						xlbl_Text.Width = xlbl_Text.Width + Item.ItemProperties.LeftGap + xiv_Icon.Width
					End If
			End Select
			
		Case "CENTER"
			
			Select Item.ItemProperties.IconHorizontalAlignment.ToUpperCase
				Case getIconHorizontalAlignment_Auto
					xlbl_Text.Left = Item.ItemProperties.LeftGap
					xlbl_Text.Width = xpnl_Body.Width - Item.ItemProperties.LeftGap*2
					xiv_Icon.Left = xpnl_Body.Width/2 - MeasureTextWidth(xlbl_Text.Text,xlbl_Text.Font)/2 - xiv_Icon.Width - Item.ItemProperties.LeftGap
				Case getIconHorizontalAlignment_Left
					xiv_Icon.Left = Item.ItemProperties.LeftGap
				Case getIconHorizontalAlignment_Right
					xiv_Icon.Left = xpnl_Body.Width - Item.ItemProperties.LeftGap - xiv_Icon.Width
			End Select
			
		Case "RIGHT"
			
			Select Item.ItemProperties.IconHorizontalAlignment.ToUpperCase
				Case getIconHorizontalAlignment_Auto, getIconHorizontalAlignment_Right
					xiv_Icon.Left = xpnl_Body.Width - Item.ItemProperties.LeftGap - xiv_Icon.Width
					If Item.Icon.IsInitialized Then
						xlbl_Text.Left = Item.ItemProperties.LeftGap
						xlbl_Text.Width = xlbl_Text.Width + Item.ItemProperties.LeftGap + xiv_Icon.Width
					End If
				Case getIconHorizontalAlignment_Left
					xiv_Icon.Left = Item.ItemProperties.LeftGap
					If Item.Icon.IsInitialized Then xlbl_Text.Width = xlbl_Text.Width + xiv_Icon.Width + Item.ItemProperties.LeftGap
			End Select
			
	End Select
	
	If Item.Icon.IsInitialized Then
		xiv_Icon.SetBitmap(Item.Icon.Resize(Item.ItemProperties.IconWidthHeight,Item.ItemProperties.IconWidthHeight,True))
'	Else
'		xiv_Icon.Visible = False
	End If
	
	Dim xiv_SmallIcon As B4XView = CreateImageView
	'Dim xiv_SmallIcon As B4XView = xui.CreatePanel("")
	'xiv_SmallIcon.Color = xui.Color_Red
	xpnl_ItemBackground.AddView(xiv_SmallIcon,0,0,Item.ItemSmallIconProperties.WidthHeight,Item.ItemSmallIconProperties.WidthHeight)
	xiv_SmallIcon.Visible = Item.SmallIcon.IsInitialized
	If Item.SmallIcon.IsInitialized Then
		Dim SmallIconLeft As Float
		Dim SmallIconTop As Float
		Select Item.ItemSmallIconProperties.HorizontalAlignment
			Case getHorizontalAlignment_AfterText
				
				Select Item.ItemProperties.TextHorizontalAlignment.ToUpperCase
					Case "LEFT"
						SmallIconLeft = xlbl_Text.Left + MeasureTextWidth(xlbl_Text.Text,xlbl_Text.Font) + Item.ItemSmallIconProperties.LeftGap
					Case "CENTER"
						SmallIconLeft = xlbl_Text.Left + xlbl_Text.Width/2 + (MeasureTextWidth(xlbl_Text.Text,xlbl_Text.Font))/2 + Item.ItemSmallIconProperties.LeftGap
					Case "RIGHT"
						SmallIconLeft = xlbl_Text.Left + xlbl_Text.Width - Item.ItemSmallIconProperties.WidthHeight - MeasureTextWidth(xlbl_Text.Text,xlbl_Text.Font) - Item.ItemSmallIconProperties.LeftGap
				End Select
				
			Case getHorizontalAlignment_BeforeText
				SmallIconLeft = xlbl_Text.Left - Item.ItemSmallIconProperties.WidthHeight - Item.ItemSmallIconProperties.LeftGap
		End Select
		
		Select Item.ItemSmallIconProperties.VerticalAlignment
			Case getVerticalAlignment_Top
				SmallIconTop = xlbl_Text.Top + xlbl_Text.Height/2 - MeasureTextHeight(xlbl_Text.Text,xlbl_Text.Font)/1.5
			Case getVerticalAlignment_Center
				SmallIconTop = xlbl_Text.Top + xlbl_Text.Height/2 - Item.ItemSmallIconProperties.WidthHeight/2
			Case getVerticalAlignment_Bottom
				SmallIconTop = xlbl_Text.Top + xlbl_Text.Height/2 '+ MeasureTextHeight(xlbl_Text.Text,xlbl_Text.Font)/2
		End Select
		
		xiv_SmallIcon.Left = SmallIconLeft
		xiv_SmallIcon.Top = SmallIconTop
		xiv_SmallIcon.SetBitmap(Item.SmallIcon)
		
	End If
	
	xpnl_ItemBackground.Tag = Item
	
	CustomDrawItem(Item,CreateAS_BottomActionSheet_ItemViews(xpnl_ItemBackground,xlbl_Text,xpnl_Seperator,xiv_Icon))
	
End Sub

Private Sub CreateItemIntern(Item As Object)
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("")
	Dim ItemHeight As Float = 0
	
	If Item Is AS_BottomActionSheet_Item Then
		
		Dim ThisItem As AS_BottomActionSheet_Item = Item
		ItemHeight = ThisItem.ItemProperties.Height
		Dim xpnl_ItemBackground As B4XView = xui.CreatePanel("ItemBackground")
		xpnl_Background.AddView(xpnl_ItemBackground,0,0,xpnl_ItemsBackground.Width,ItemHeight)
		BuildItemIntern(xpnl_ItemBackground,ThisItem)
		
	Else If Item Is List Then
			
		For i = 0 To Item.As(List).Size -1
			
			Dim ItemWidth As Float = xpnl_ItemsBackground.Width/Item.As(List).Size
			Dim ThisItem As AS_BottomActionSheet_Item = Item.As(List).Get(i)		
			ItemHeight = ThisItem.ItemProperties.Height
			Dim xpnl_ItemBackground As B4XView = xui.CreatePanel("ItemBackground")
			xpnl_Background.AddView(xpnl_ItemBackground,ItemWidth*i,0,ItemWidth,ItemHeight)
			BuildItemIntern(xpnl_ItemBackground,ThisItem)
			
		Next
			
	End If
	
	xpnl_ItemsBackground.AddView(xpnl_Background,0,xpnl_ItemBackground.Height*xpnl_ItemsBackground.NumberOfViews,xpnl_ItemsBackground.Width,ItemHeight)
	
End Sub

#Region Properties

'Set the value to greater than 0 to set a custom width
'Set the value to 0 to use the full screen width
'Default: 0
Public Sub setSheetWidth(SheetWidth As Float)
	m_SheetWidth = SheetWidth
End Sub

Public Sub getSheetWidth As Float
	Return m_SheetWidth
End Sub

Public Sub setDragIndicatorColor(Color As Int)
	m_DragIndicatorColor = Color
End Sub

Public Sub getDragIndicatorColor As Int
	Return m_DragIndicatorColor
End Sub

'TextHorizontalAlignment - Left, Center, Right
Public Sub getItemProperties As AS_BottomActionSheet_ItemProperties
	Return g_ItemProperties
End Sub

'VerticalAlignment - Top, Center, Bottom
'HorizontalAlignment - BeforeText, AfterText
'WidthHeight - Default: 15dip
'LeftGap - Default: 0dip
Public Sub getItemSmallIconProperties As AS_BottomActionSheet_ItemSmallIconProperties
	Return g_ItemSmallIconProperties
End Sub

Public Sub setTextColor(Color As Int)
	g_ItemProperties.TextColor = Color
	xpnl_DragIndicator.Color = xui.Color_ARGB(80,GetARGB(Color)(1),GetARGB(Color)(2),GetARGB(Color)(3))
End Sub

Public Sub setColor(Color As Int)
	m_BodyColor = Color
	If BottomCard.IsInitialized Then BottomCard.BodyPanel.Color = m_BodyColor
	m_HeaderColor = Color
	xpnl_Body.Color = Color
	xpnl_Header.Color = Color
End Sub

Public Sub getColor As Int
	Return m_BodyColor
End Sub

Public Sub getActionButton As B4XView
	Return xlbl_ActionButton
End Sub

Public Sub getActionButtonVisible As Boolean
	Return m_ActionButtonVisible
End Sub

Public Sub setActionButtonVisible(Visible As Boolean)
	m_ActionButtonVisible = Visible
End Sub

'Get the number of items
Public Sub getSize As Int
	Return lst_Items.Size
End Sub

#End Region

#Region Events

Private Sub BottomCard_Close
	If xui.SubExists(mCallBack, mEventName & "_Close",0) Then
		CallSub(mCallBack, mEventName & "_Close")
	End If
End Sub

#If B4J
Private Sub ItemBackground_MouseClicked (EventData As MouseEvent)
#Else
Private Sub ItemBackground_Click
#End If
	Dim ItemBackground As B4XView = Sender
	ItemClicked(ItemBackground.Tag)
End Sub

#If B4J
Private Sub xlbl_ActionButton_MouseClicked (EventData As MouseEvent)
	ActionButtonClicked
End Sub
#Else
Private Sub xlbl_ActionButton_Click
	ActionButtonClicked
End Sub
#End If

Private Sub ActionButtonClicked
	XUIViewsUtils.PerformHapticFeedback(xpnl_ItemsBackground)
	If xui.SubExists(mCallBack, mEventName & "_ActionButtonClicked",0) Then
		CallSub(mCallBack, mEventName & "_ActionButtonClicked")
	End If
End Sub

Private Sub ItemClicked(Item As AS_BottomActionSheet_Item)
	XUIViewsUtils.PerformHapticFeedback(xpnl_ItemsBackground)
	If xui.SubExists(mCallBack, mEventName & "_ItemClicked",1) Then
		CallSub2(mCallBack, mEventName & "_ItemClicked",Item)
	End If
End Sub

Private Sub CustomDrawItem(Item As AS_BottomActionSheet_Item,ItemViews As AS_BottomActionSheet_ItemViews)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawItem",2) Then
		CallSub3(mCallBack, mEventName & "_CustomDrawItem",Item,ItemViews)
	End If
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub CreateImageView As B4XView
	Dim iv As ImageView
	iv.Initialize("")
	Return iv
End Sub

Private Sub GetARGB(Color As Int) As Int()
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
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

'https://www.b4x.com/android/forum/threads/b4x-xui-add-measuretextwidth-and-measuretextheight-to-b4xcanvas.91865/post-580637
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
    Return cvs.MeasureStringHeight(Text, Font1.ToNativeFont, Font1.Size)
#Else If B4i
    Return Text.MeasureHeight(Font1.ToNativeFont)
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

#Region Enums

Public Sub getHorizontalAlignment_BeforeText As String
	Return "BeforeText"
End Sub

Public Sub getHorizontalAlignment_AfterText As String
	Return "AfterText"
End Sub


Public Sub getVerticalAlignment_Top As String
	Return "Top"
End Sub

Public Sub getVerticalAlignment_Center As String
	Return "Center"
End Sub

Public Sub getVerticalAlignment_Bottom As String
	Return "Bottom"
End Sub

'<code>BottomActionSheet.ItemProperties.IconHorizontalAlignment = BottomActionSheet.IconHorizontalAlignment_Auto</code>
Public Sub getIconHorizontalAlignment_Auto As String
	Return "Auto".ToUpperCase
End Sub

'<code>BottomActionSheet.ItemProperties.IconHorizontalAlignment = BottomActionSheet.IconHorizontalAlignment_Left</code>
Public Sub getIconHorizontalAlignment_Left As String
	Return "Left".ToUpperCase
End Sub

'<code>BottomActionSheet.ItemProperties.IconHorizontalAlignment = BottomActionSheet.IconHorizontalAlignment_Right</code>
Public Sub getIconHorizontalAlignment_Right As String
	Return "Right".ToUpperCase
End Sub

#End Region

#Region Types

Private Sub CreateAS_BottomActionSheet_Item (Text As String, Icon As B4XBitmap, SmallIcon As B4XBitmap, Value As Object, ItemProperties As AS_BottomActionSheet_ItemProperties, ItemSmallIconProperties As AS_BottomActionSheet_ItemSmallIconProperties) As AS_BottomActionSheet_Item
	Dim t1 As AS_BottomActionSheet_Item
	t1.Initialize
	t1.Text = Text
	t1.Icon = Icon
	t1.SmallIcon = SmallIcon
	t1.Value = Value
	t1.ItemProperties = ItemProperties
	t1.ItemSmallIconProperties = ItemSmallIconProperties
	Return t1
End Sub

Private Sub CreateAS_BottomActionSheet_ItemViews (BackgroundPanel As B4XView, TextLabel As B4XView, SeperatorPanel As B4XView, IconImageView As B4XView) As AS_BottomActionSheet_ItemViews
	Dim t1 As AS_BottomActionSheet_ItemViews
	t1.Initialize
	t1.BackgroundPanel = BackgroundPanel
	t1.TextLabel = TextLabel
	t1.SeperatorPanel = SeperatorPanel
	t1.IconImageView = IconImageView
	Return t1
End Sub

Private Sub CreateAS_BottomActionSheet_ItemSmallIconProperties (HorizontalAlignment As String, VerticalAlignment As String, WidthHeight As Float, LeftGap As Float) As AS_BottomActionSheet_ItemSmallIconProperties
	Dim t1 As AS_BottomActionSheet_ItemSmallIconProperties
	t1.Initialize
	t1.HorizontalAlignment = HorizontalAlignment
	t1.VerticalAlignment = VerticalAlignment
	t1.WidthHeight = WidthHeight
	t1.LeftGap = LeftGap
	Return t1
End Sub

Private Sub CreateAS_BottomActionSheet_ItemProperties (Height As Float, LeftGap As Float, xFont As B4XFont, TextColor As Int, IconWidthHeight As Float, SeperatorVisible As Boolean, SeperatorColor As Int, TextHorizontalAlignment As String) As AS_BottomActionSheet_ItemProperties
	Dim t1 As AS_BottomActionSheet_ItemProperties
	t1.Initialize
	t1.Height = Height
	t1.LeftGap = LeftGap
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.IconWidthHeight = IconWidthHeight
	t1.SeperatorVisible = SeperatorVisible
	t1.SeperatorColor = SeperatorColor
	t1.TextHorizontalAlignment = TextHorizontalAlignment
	Return t1
End Sub

#End Region
