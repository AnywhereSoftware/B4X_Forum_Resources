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
#End If

#Event: ActionButtonClicked
#Event: Close
#Event: ItemClicked(Item As AS_BottomColorChooser_Item)
#Event: DisabledItemClicked(Item As AS_BottomColorChooser_Item)

Sub Class_Globals
	
	Type AS_BottomColorChooser_Item(Color As Int,Enabled As Boolean)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	
	Private xpnl_Header As B4XView
	Private xlbl_ActionButton As B4XView
	Private xpnl_DragIndicator As B4XView
	
	Private m_HeaderHeight As Float
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_ActionButtonVisible As Boolean
	Private m_DragIndicatorColor As Int
	Private m_SheetWidth As Float = 0
	Private m_WidthHeight As Float = 60dip
	Private m_CornerRadius As Float = 30dip
	Private m_ActionButtonBackgroundColor As Int
	Private m_ActionButtonTextColor As Int
	Private m_SelectedColor As Int
	
	Private lst_Items As List
	
	Type AS_BottomColorChooser_Theme(BodyColor As Int,DragIndicatorColor As Int,ActionButtonBackgroundColor As Int,ActionButtonTextColor As Int)
	
End Sub

Public Sub getTheme_Light As AS_BottomColorChooser_Theme
	
	Dim Theme As AS_BottomColorChooser_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_White
	Theme.ActionButtonBackgroundColor = xui.Color_Black
	Theme.ActionButtonTextColor = xui.Color_White
	Theme.DragIndicatorColor = xui.Color_Black

	Return Theme
	
End Sub

Public Sub getTheme_Dark As AS_BottomColorChooser_Theme
	
	Dim Theme As AS_BottomColorChooser_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.ActionButtonBackgroundColor = xui.Color_White
	Theme.ActionButtonTextColor = xui.Color_Black
	Theme.DragIndicatorColor = xui.Color_White

	Return Theme
	
End Sub

Public Sub setTheme(Theme As AS_BottomColorChooser_Theme)
	
	m_HeaderColor = Theme.BodyColor
	m_BodyColor = Theme.BodyColor
	m_DragIndicatorColor = Theme.DragIndicatorColor
	m_ActionButtonBackgroundColor = Theme.ActionButtonBackgroundColor
	m_ActionButtonTextColor = Theme.ActionButtonTextColor
	
	setColor(m_BodyColor)
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	lst_Items.Initialize
	
	xpnl_Header = xui.CreatePanel("")
	xlbl_ActionButton = CreateLabel("xlbl_ActionButton")
	xpnl_DragIndicator = xui.CreatePanel("")
	
	m_DragIndicatorColor = xui.Color_ARGB(80,255,255,255)
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	
	m_ActionButtonBackgroundColor = xui.Color_White
	m_ActionButtonTextColor = xui.Color_Black
	
	m_HeaderHeight = 30dip
	m_ActionButtonVisible = False

End Sub

Public Sub AddItem(Color As Int,Enabled As Boolean) As AS_BottomColorChooser_Item
	Return AddItemIntern(Color,Enabled)
End Sub

Public Sub SetItems(ColorList As List)
	
	For Each Item As Object In ColorList
		
		Dim clrItem As AS_BottomColorChooser_Item
		clrItem.Initialize
		If Item Is AS_BottomColorChooser_Item Then
			clrItem = Item
		Else
			clrItem.Color = Item
			clrItem.Enabled = True
		End If
		
		lst_Items.Add(clrItem)
		
	Next
	
End Sub

Private Sub AddItemIntern(Color As Int,Enabled As Boolean) As AS_BottomColorChooser_Item
	Dim Item As AS_BottomColorChooser_Item
	Item.Initialize
	Item.Color = Color
	Item.Enabled = Enabled
	lst_Items.Add(Item)
	Return Item
End Sub

Public Sub ShowPicker
	
	Dim SheetWidth As Float = IIf(m_SheetWidth=0,xParent.Width,m_SheetWidth)
	
	Dim Counter As Int = 0
	Dim TopLevel As Int = 0
	Dim PaddingBetween As Float = 10dip
	Dim JustOneLine As Boolean = False
		
	Dim ItemsPerRow As Int = 0
	For Each Item As AS_BottomColorChooser_Item In lst_Items
		Dim ThisItemLeft As Float = m_WidthHeight*ItemsPerRow + PaddingBetween*ItemsPerRow
		If ThisItemLeft + m_WidthHeight > SheetWidth Then
			JustOneLine = False
			Exit
		End If
		JustOneLine = True
		ItemsPerRow = ItemsPerRow +1
	Next
	

	Dim xpnl_ColorItemsBackground As B4XView = xui.CreatePanel("")
	xpnl_ColorItemsBackground.SetLayoutAnimated(0,0,0,m_SheetWidth,SheetWidth)
	'xpnl_Background.AddView(xpnl_ColorItemsBackground,10dip,0,xpnl_Background.Width - 10dip*2,xpnl_Background.Height)
	xpnl_ColorItemsBackground.Color = xui.Color_Transparent
	'xpnl_ColorItemsBackground.Color = xui.Color_Red
	
	For Each Item As AS_BottomColorChooser_Item In lst_Items
			
		If Counter = ItemsPerRow Then
			TopLevel = TopLevel +1
			Counter = 0
		Else
					
		End If
			
		Dim Spacing As Float = (SheetWidth - (ItemsPerRow * m_WidthHeight)) / (ItemsPerRow + 1)
		Dim ThisItemLeft As Float = Spacing + (Counter * (m_WidthHeight + Spacing))
			
		If JustOneLine Then
			ThisItemLeft = (m_WidthHeight + PaddingBetween)*Counter
		End If
			
		Dim xlbl_Color As B4XView = CreateLabel("ColorChooser")
		xlbl_Color.SetTextAlignment("CENTER","CENTER")
		If m_SelectedColor <> 0 And m_SelectedColor = Item.Color Then
			xlbl_Color.Font = xui.CreateMaterialIcons(IIf(xui.IsB4A,m_WidthHeight/3.5, m_WidthHeight/1.5))
			xlbl_Color.TextColor = GetContrastColor(Item.Color)
		Else
			xlbl_Color.Font = xui.CreateMaterialIcons(0)
			xlbl_Color.TextColor = xui.Color_Transparent
		End If
		xlbl_Color.Text = Chr(0xE5CA)
		xpnl_ColorItemsBackground.AddView(xlbl_Color,ThisItemLeft,m_WidthHeight*TopLevel + PaddingBetween*TopLevel,m_WidthHeight,m_WidthHeight)
		xlbl_Color.SetColorAndBorder(Item.Color,0,0,m_CornerRadius)
			
		xlbl_Color.Tag = Item
			
		Counter = Counter +1
	Next

	xpnl_ColorItemsBackground.Height = (m_WidthHeight + PaddingBetween)*(TopLevel+1) - PaddingBetween
	
	Dim BodyHeight As Float = xpnl_ColorItemsBackground.Height
	Dim SafeAreaHeight As Float = 0
	
	If m_ActionButtonVisible Then
		BodyHeight = BodyHeight + 60dip
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
	
	xpnl_Header.AddView(xpnl_DragIndicator,SheetWidth/2 - 70dip/2,m_HeaderHeight/2 - 6dip/2,70dip,6dip)
	Dim ARGB() As Int = GetARGB(m_DragIndicatorColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
	
	xlbl_ActionButton.RemoveViewFromParent
	
	If m_ActionButtonVisible Then
	
		xlbl_ActionButton.Text = "Confirm"
		xlbl_ActionButton.TextColor = m_ActionButtonTextColor
		xlbl_ActionButton.SetColorAndBorder(m_ActionButtonBackgroundColor,0,0,10dip)
		xlbl_ActionButton.SetTextAlignment("CENTER","CENTER")
		
		Dim ConfirmationButtoHeight As Float = 40dip
		Dim ConfirmationButtoWidth As Float = 220dip
		If SheetWidth < ConfirmationButtoWidth Then ConfirmationButtoWidth = SheetWidth - 20dip
		
		BottomCard.BodyPanel.AddView(xlbl_ActionButton,SheetWidth/2 - ConfirmationButtoWidth/2,BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,ConfirmationButtoWidth,ConfirmationButtoHeight)
	
	End If
	

	BottomCard.BodyPanel.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,SheetWidth,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_ColorItemsBackground,0,0,SheetWidth,xpnl_ColorItemsBackground.Height)
	BottomCard.CornerRadius_Header = 30dip/2
	
	Sleep(0)
	
	BottomCard.Show(False)
	
End Sub

Public Sub HidePicker
	BottomCard.Hide(False)
End Sub

#Region Properties

'<code>BottomColorChooser.SelectedColor = xui.Color_ARGB(255, 9, 131, 254)</code>
Public Sub setSelectedColor(SelectedColor As Int)
	m_SelectedColor = SelectedColor
End Sub

Public Sub getSelectedColor As Int
	Return m_SelectedColor
End Sub

'The CornerRadius of a color item
Public Sub setCornerRadius(CornerRadius As Float)
	m_CornerRadius = CornerRadius
End Sub

Public Sub getCornerRadius As Float
	Return m_CornerRadius
End Sub

'Default: 60dip
'If you want a circle, then dont forget to set the CornerRadius property
Public Sub setWidthHeight(WidthHeight As Float)
	m_WidthHeight = WidthHeight
End Sub

Public Sub getWidthHeight As Float
	Return m_WidthHeight
End Sub

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

Public Sub setColor(Color As Int)
	m_BodyColor = Color
	If BottomCard.IsInitialized Then BottomCard.BodyPanel.Color = m_BodyColor
	m_HeaderColor = Color
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

#Region ViewEvents

#If B4J
Private Sub xlbl_ActionButton_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_ActionButton_Click
#End If
	XUIViewsUtils.PerformHapticFeedback(Sender)
	ActionButtonClicked
End Sub

#If B4J
Private Sub ColorChooser_MouseClicked (EventData As MouseEvent)
#Else
Private Sub ColorChooser_Click
#End If

	Dim xlbl_Color As B4XView = Sender
	Dim clrItem As AS_BottomColorChooser_Item = xlbl_Color.Tag
	
	If clrItem.Enabled Then
		m_SelectedColor = clrItem.Color
		Dim xpnl_ColorItemsBackground As B4XView = xlbl_Color.Parent

		xlbl_Color.TextColor = GetContrastColor(xlbl_Color.Color)

		For i = 0 To xpnl_ColorItemsBackground.NumberOfViews -1
			If xpnl_ColorItemsBackground.GetView(i) = xlbl_Color Then
				xlbl_Color.Font = xui.CreateMaterialIcons(1)
				xlbl_Color.SetTextSizeAnimated(250,IIf(xui.IsB4A,xlbl_Color.Height/3.5, xlbl_Color.Height/1.5))
			Else
				xpnl_ColorItemsBackground.GetView(i).SetTextSizeAnimated(250,0)
			End If
		Next
	
		XUIViewsUtils.PerformHapticFeedback(xlbl_Color)
	
		If xui.SubExists(mCallBack, mEventName & "_ItemClicked",1) Then
			CallSubDelayed2(mCallBack,mEventName & "_ItemClicked",clrItem)
		End If

	Else

		If xui.SubExists(mCallBack, mEventName & "_DisabledItemClicked",1) Then
			CallSubDelayed2(mCallBack,mEventName & "_DisabledItemClicked",clrItem)
		End If
		
	End If

End Sub

#End Region

#Region Events

Private Sub ActionButtonClicked
	If xui.SubExists(mCallBack, mEventName & "_ActionButtonClicked",0) Then
		CallSub(mCallBack, mEventName & "_ActionButtonClicked")
	End If
End Sub

Private Sub BottomCard_Close
	If xui.SubExists(mCallBack, mEventName & "_Close",0) Then
		CallSub(mCallBack, mEventName & "_Close")
	End If
End Sub

'Private Sub CustomDrawItem(Item As AS_BottomColorChooser_Item,ItemViews As AS_BottomColorChooser_ItemViews)
'	If xui.SubExists(mCallBack, mEventName & "_CustomDrawItem",2) Then
'		CallSub3(mCallBack, mEventName & "_CustomDrawItem",Item,ItemViews)
'	End If
'End Sub

#End Region

#Region Functions

'returns white for a dark color or returns black for a light color for a good contrast between background and text colors
Private Sub GetContrastColor(Color As Int) As Int
	Private a, r, g, b, yiq As Int    'ignore
    
	a = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	b = Bit.And(Color, 0xff)
    
	yiq = r * 0.299 + g * 0.587 + b * 0.114
    
	If yiq > 128 Then
		Return xui.Color_Black
	Else
		Return xui.Color_White
	End If
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
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

#End Region

#Region Enums


#End Region

#Region Types

Public Sub CreateColorItem (Color As Int, Enabled As Boolean) As AS_BottomColorChooser_Item
	Dim t1 As AS_BottomColorChooser_Item
	t1.Initialize
	t1.Color = Color
	t1.Enabled = Enabled
	Return t1
End Sub

#End Region


