B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-AddItem is now returning the AS_FloatingActionMenu_Item
	-Add "Enabled" property to the AS_FloatingActionMenu_Item
		-Deactivates an item
		-The item is darkened so that the user can see that it is deactivated
#End If

#Event: MenuClosed
#Event: ItemClicked(Item As AS_BottomActionSheet_Item)

Sub Class_Globals

	Type AS_FloatingActionMenu_ItemProperties(Height As Float,IconLeftGap As Float,TextLeftGap As Float,xFont As B4XFont,TextColor As Int,IconWidthHeight As Float,SeperatorVisible As Boolean,SeperatorColor As Int)
	Type AS_FloatingActionMenu_Item(Text As String,Icon As B4XBitmap,Value As Object,Enabled As Boolean,ItemProperties As AS_FloatingActionMenu_ItemProperties)
	Type AS_FloatingActionMenu_CustomDrawItem(BackgroundPanel As B4XView,IconImageView As B4XView,TextLabel As B4XView,Item As AS_FloatingActionMenu_Item)

	Private g_ItemProperties As AS_FloatingActionMenu_ItemProperties

	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object

	Private xParent As B4XView
	Private FloatingPanel As AS_FloatingPanel
	Private xpnl_ItemsBackground As B4XView

	Private m_BodyColor As Int
	Private m_OpenOrientation As String
	Private m_Duration As Long = 250
	Private m_CloseOnTap As Boolean = True
	Private m_CornerRadius As Float = 10dip

	Private lst_Items As List

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	lst_Items.Initialize
	
	g_ItemProperties = CreateAS_FloatingActionMenu_ItemProperties(60dip,10dip,10dip,xui.CreateDefaultFont(18),xui.Color_White,30dip,False,xui.Color_White)
	
	m_OpenOrientation = "LeftBottom"
	
End Sub

Public Sub AddItem(Text As String,Icon As B4XBitmap,Value As Object) As AS_FloatingActionMenu_Item
	
	Dim ItemProperties As AS_FloatingActionMenu_ItemProperties
	ItemProperties.Initialize
	ItemProperties.Height = g_ItemProperties.Height
	ItemProperties.IconWidthHeight = g_ItemProperties.IconWidthHeight
	ItemProperties.IconLeftGap = g_ItemProperties.IconLeftGap
	ItemProperties.TextLeftGap = g_ItemProperties.TextLeftGap
	ItemProperties.SeperatorVisible = g_ItemProperties.SeperatorVisible
	ItemProperties.TextColor = g_ItemProperties.TextColor
	ItemProperties.xFont = g_ItemProperties.xFont
	ItemProperties.SeperatorColor = g_ItemProperties.SeperatorColor
	
	Dim Item As AS_FloatingActionMenu_Item = CreateAS_FloatingActionMenu_Item(Text,Icon,Value,True,ItemProperties)
	lst_Items.Add(Item)
	
	Return Item
End Sub

Public Sub ShowPicker(Left As Float,Top As Float,Width As Float,Height As Float)
	
	Dim ListHeight As Float = g_ItemProperties.Height*lst_Items.Size
	
	FloatingPanel.Initialize(Me,"FloatingPanel",xParent)
	FloatingPanel.CloseOnTap = m_CloseOnTap
	FloatingPanel.OpenOrientation = m_OpenOrientation
	FloatingPanel.PreSize(Width,Height)
	FloatingPanel.Duration = m_Duration
	FloatingPanel.CornerRadius = m_CornerRadius
	'FloatingPanel.Panel.LoadLayout("frm_Content")

	xpnl_ItemsBackground = xui.CreatePanel("")
	xpnl_ItemsBackground.Color = m_BodyColor
	FloatingPanel.Panel.AddView(xpnl_ItemsBackground,0,0,FloatingPanel.Panel.Width,ListHeight)
	
	For i = 0 To lst_Items.Size -1
		CreateItemIntern(lst_Items.Get(i))
	Next
	
	Sleep(0)
	
	FloatingPanel.Show(Left,Top,Width,Height)
	
End Sub

Public Sub HidePicker
	FloatingPanel.Close
End Sub

Private Sub CreateItemIntern(Item As AS_FloatingActionMenu_Item)
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("ItemBackground")
	xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ItemsBackground.Width,Item.ItemProperties.Height)
	
	Dim xlbl_Text As B4XView = CreateLabel("")
	xlbl_Text.Text = Item.Text
	xlbl_Text.TextColor = Item.ItemProperties.TextColor
	xlbl_Text.SetTextAlignment("CENTER","LEFT")
	xlbl_Text.Font = Item.ItemProperties.xFont
	xlbl_Text.Tag = "TextLabel"

	xpnl_Background.AddView(xlbl_Text,IIf(Item.Icon.IsInitialized,Item.ItemProperties.IconLeftGap + Item.ItemProperties.TextLeftGap + Item.ItemProperties.IconWidthHeight,Item.ItemProperties.TextLeftGap),0,xpnl_Background.Width - (IIf(Item.Icon.IsInitialized,Item.ItemProperties.IconLeftGap + Item.ItemProperties.TextLeftGap,Item.ItemProperties.TextLeftGap))*2 + Item.ItemProperties.IconWidthHeight,xpnl_Background.Height)
	
	Dim ARGB() As Int = GetARGB(Item.ItemProperties.SeperatorColor)
	
	If Item.ItemProperties.SeperatorVisible And xpnl_ItemsBackground.NumberOfViews < lst_Items.Size -1 Then
	
		Dim xpnl_Seperator As B4XView = xui.CreatePanel("")
		xpnl_Seperator.Color = xui.Color_ARGB(30,ARGB(1),ARGB(2),ARGB(3))
		xpnl_Background.AddView(xpnl_Seperator,0,xpnl_Background.Height - 2dip,xpnl_Background.Width,2dip)
		xpnl_Seperator.Tag = "SeperatorPanel"
	
	End If
	
	If Item.Icon.IsInitialized Then
		Dim xiv_Icon As B4XView = CreateImageView
		xpnl_Background.AddView(xiv_Icon,Item.ItemProperties.IconLeftGap,xpnl_Background.Height/2 - Item.ItemProperties.IconWidthHeight/2,Item.ItemProperties.IconWidthHeight,Item.ItemProperties.IconWidthHeight)
		xiv_Icon.SetBitmap(Item.Icon.Resize(Item.ItemProperties.IconWidthHeight,Item.ItemProperties.IconWidthHeight,True))
		xiv_Icon.Tag = "IconImageView"
	End If
	
	If Item.Enabled = False Then		
		Dim TextColor() As Int = GetARGB(Item.ItemProperties.TextColor)
		xlbl_Text.TextColor = xui.Color_ARGB(120,TextColor(1),TextColor(2),TextColor(3))
		If Item.Icon.IsInitialized Then TintBmp(xiv_Icon,xlbl_Text.TextColor) 
	End If
	
	xpnl_Background.Tag = Item
	xpnl_ItemsBackground.AddView(xpnl_Background,0,xpnl_Background.Height*xpnl_ItemsBackground.NumberOfViews,xpnl_ItemsBackground.Width,Item.ItemProperties.Height)
	
End Sub

Public Sub GetCustomDrawItem(Index As Int) As AS_FloatingActionMenu_CustomDrawItem
	
	Dim CustomDrawItem As AS_FloatingActionMenu_CustomDrawItem
	CustomDrawItem.Initialize
	
	Dim xpnl_Background As B4XView = xpnl_ItemsBackground.GetView(Index)
	CustomDrawItem.Item = xpnl_Background.Tag
	CustomDrawItem.BackgroundPanel = xpnl_Background

	For Each v As B4XView In xpnl_Background.GetAllViewsRecursive
		If v.Tag = "TextLabel" Then
			CustomDrawItem.TextLabel = v
			Exit
		End If
	Next
	
	For Each v As B4XView In xpnl_Background.GetAllViewsRecursive
		If v.Tag = "IconImageView" Then
			CustomDrawItem.IconImageView = v
			Exit
		End If
	Next
	
	Return CustomDrawItem
	
End Sub

#Region Properties

'Default: 10dip
Public Sub getCornerRadius As Float
	Return m_CornerRadius
End Sub

Public Sub setCornerRadius(Radius As Float)
	m_CornerRadius = Radius
End Sub

'Can only be used after ShowPicker is called
Public Sub getFloatingPanel As AS_FloatingPanel
	Return FloatingPanel
End Sub

Public Sub getItemProperties As AS_FloatingActionMenu_ItemProperties
	Return g_ItemProperties
End Sub

Public Sub setTextColor(Color As Int)
	g_ItemProperties.TextColor = Color
End Sub

Public Sub setColor(Color As Int)
	m_BodyColor = Color
	If FloatingPanel.IsInitialized Then FloatingPanel.Panel.Color = m_BodyColor
End Sub

Public Sub getColor As Int
	Return m_BodyColor
End Sub

'Added item count
Public Sub getSize As Int
	Return lst_Items.Size
End Sub

'Default: True
Public Sub getCloseOnTap As Boolean
	Return m_CloseOnTap
End Sub

Public Sub setCloseOnTap(Enabled As Boolean)
	m_CloseOnTap = Enabled
End Sub

Public Sub setOpenOrientation(Orientation As String)
	m_OpenOrientation = Orientation
End Sub
'Default: 150
Public Sub setDuration(Duration As Long)
	m_Duration = Duration
End Sub

#End Region


#Region Enums
'Opens the panel without slide, but with fade
Public Sub getOpenOrientation_None As String
	Return "None"
End Sub
'Opens the panel from left to bottom
Public Sub getOpenOrientation_LeftBottom As String
	Return "LeftBottom"
End Sub
'Opens the panel from right to bottom
Public Sub getOpenOrientation_RightBottom As String
	Return "RightBottom"
End Sub
'Opens the panel from left to top
Public Sub getOpenOrientation_LeftTop As String
	Return "LeftTop"
End Sub
'Opens the panel from right to top
Public Sub getOpenOrientation_RightTop As String
	Return "RightTop"
End Sub
'Opens the panel from left to right
Public Sub getOpenOrientation_LeftRight As String
	Return "LeftRight"
End Sub
'Opens the panel from right to left
Public Sub getOpenOrientation_RightLeft As String
	Return "RightLeft"
End Sub
'Opens the panel from top to bottom
Public Sub getOpenOrientation_TopBottom As String
	Return "TopBottom"
End Sub
'Opens the panel from bottom to top
Public Sub getOpenOrientation_BottomTop As String
	Return "BottomTop"
End Sub

#End Region

#Region Events

Private Sub FloatingPanel_Close
	If xui.SubExists(mCallBack, mEventName & "_MenuClosed",0) Then
		CallSub(mCallBack, mEventName & "_MenuClosed")
	End If
End Sub

#If B4J
Private Sub ItemBackground_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#Else
Private Sub ItemBackground_Click
#End If
	Dim ItemBackground As B4XView = Sender
	Dim Item As AS_FloatingActionMenu_Item = ItemBackground.Tag
	If Item.Enabled = False Then Return
	ItemClicked(Item)
	If m_CloseOnTap Then FloatingPanel.Close
End Sub

Private Sub ItemClicked(Item As AS_FloatingActionMenu_Item)
	XUIViewsUtils.PerformHapticFeedback(xpnl_ItemsBackground)
	If xui.SubExists(mCallBack, mEventName & "_ItemClicked",1) Then
		CallSub2(mCallBack, mEventName & "_ItemClicked",Item)
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

Private Sub TintBmp(img As ImageView, color As Int)
	#If B4I
		Dim NaObj As NativeObject = Me
	NaObj.RunMethod("BmpColor::",Array(img,NaObj.ColorToUIColor(color)))
	#Else if B4J

		Dim bmp As B4XBitmap = img.GetImage
		Dim bc As BitmapCreator
		bc.Initialize(bmp.Width, bmp.Height)
		bc.CopyPixelsFromBitmap(bmp)
		Dim a1, a2 As ARGBColor
	bc.ColorToARGB(color, a1)
		For y = 0 To bc.mHeight - 1
			For x = 0 To bc.mWidth - 1
				bc.GetARGB(x, y, a2)
				If a2.a >= 120 Then
					a2.a = a1.a
					a2.r = a1.r
					a2.g = a1.g
					a2.b = a1.b
					bc.SetARGB(x, y, a2)
				End If
			Next
		Next
		img.SetImage(bc.Bitmap)
	
	#Else If B4A
'	Dim ARGB() As Int = GetARGB(color)
'		Dim jo As JavaObject=img
'		jo.RunMethod("setImageBitmap",Array(img.Bitmap))
'		'jo.RunMethod("setColorFilter",Array(Colors.Transparent))
'	jo.RunMethod("setColorFilter",Array(Colors.ARGB(ARGB(0),ARGB(1),ARGB(2),ARGB(3))))
	
	Dim bmp As B4XBitmap = img.As(B4XView).GetBitmap
	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width, bmp.Height)
	bc.CopyPixelsFromBitmap(bmp)
	Dim a1, a2 As ARGBColor
	bc.ColorToARGB(color, a1)
	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			bc.GetARGB(x, y, a2)
			If a2.a >= 120 Then
				a2.a = a1.a
				a2.r = a1.r
				a2.g = a1.g
				a2.b = a1.b
				bc.SetARGB(x, y, a2)
			End If
		Next
	Next
	img.As(B4XView).SetBitmap(bc.Bitmap.Resize(img.Width,img.Height,True))
	
	#End If
	
End Sub



#If OBJC
- (void)BmpColor: (UIImageView*) theImageView :(UIColor*) Color{
theImageView.image = [theImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
[theImageView setTintColor:Color];
}
#end if

#End Region

#Region Types



#End Region


Public Sub CreateAS_FloatingActionMenu_ItemProperties (Height As Float, IconLeftGap As Float, TextLeftGap As Float, xFont As B4XFont, TextColor As Int, IconWidthHeight As Float, SeperatorVisible As Boolean, SeperatorColor As Int) As AS_FloatingActionMenu_ItemProperties
	Dim t1 As AS_FloatingActionMenu_ItemProperties
	t1.Initialize
	t1.Height = Height
	t1.IconLeftGap = IconLeftGap
	t1.TextLeftGap = TextLeftGap
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.IconWidthHeight = IconWidthHeight
	t1.SeperatorVisible = SeperatorVisible
	t1.SeperatorColor = SeperatorColor
	Return t1
End Sub

Public Sub CreateAS_FloatingActionMenu_Item (Text As String, Icon As B4XBitmap, Value As Object, Enabled As Boolean, ItemProperties As AS_FloatingActionMenu_ItemProperties) As AS_FloatingActionMenu_Item
	Dim t1 As AS_FloatingActionMenu_Item
	t1.Initialize
	t1.Text = Text
	t1.Icon = Icon
	t1.Value = Value
	t1.Enabled = Enabled
	t1.ItemProperties = ItemProperties
	Return t1
End Sub