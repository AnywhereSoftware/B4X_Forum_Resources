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
	-Add HidePicker
V1.02
	-Add Event: EmojiSelected (Emoji As String)
	-Add Event: Opened
	-Add Event: Closed
	-Add Event: Open
	-Add Event: Close
	-Add Event: VisibleBodyHeightChanged (height as double)
#End If

#Event: EmojiSelected (Emoji As String)
#Event: Opened
#Event: Closed
#Event: Open
#Event: Close
#Event: VisibleBodyHeightChanged (height as double)

Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	Private xpnl_ListviewBackground As B4XView
	Private xclv_Main As CustomListView
	
	Private xpnl_Header As B4XView
	Private xpnl_Body As B4XView
	Private xpnl_DragIndicator As B4XView
	
	Private m_HeaderHeight As Float
	Private m_BodyHeight As Float
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_CategoryTextColor As Int
	Private m_CategoryIndicatorColor As Int
	Private m_EmojiSize As Int
	Private m_Rows As Int
	
	Private m_Emojis As Map
	Private xpnl_CategoriesBackground As B4XView
	Private xpnl_CurrentCategoryIndicator As B4XView
	Private CurrentCategory As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	
	m_HeaderHeight = 40dip
	m_BodyHeight = 300dip
	
	xpnl_Header = xui.CreatePanel("")
	xpnl_Body = xui.CreatePanel("")
	xpnl_DragIndicator = xui.CreatePanel("")
	xpnl_ListviewBackground = xui.CreatePanel("")
	xpnl_ListviewBackground.SetLayoutAnimated(0,0,0,Parent.Width,m_BodyHeight)
	
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	m_CategoryTextColor = xui.Color_White
	m_CategoryIndicatorColor = xui.Color_White
	m_EmojiSize = 30
	m_Rows = 5
	
	ini_xclv
	
	m_Emojis.Initialize
	Dim parser As JSONParser
	parser.Initialize(File.ReadString(File.DirAssets,"data-by-group.json"))
	Dim jRoot As List = parser.NextArray
	
	For Each coljRoot As Map In jRoot
		m_Emojis.Put(coljRoot.Get("slug"),coljRoot)
	Next
	
End Sub

Private Sub ini_xclv
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0x00FFFFFF)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x00FFFFFF)
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation","Horizontal")
	tmpmap.Put("ShowScrollBar",False)
	xclv_Main.Initialize(Me,"xclv_main")
	xclv_Main.DesignerCreateView(xpnl_ListviewBackground,tmplbl,tmpmap)
	#IF B4A
	
	xclv_Main.AsView.SetLayoutAnimated(0,xclv_Main.AsView.Left,xclv_Main.AsView.Top,xpnl_ListviewBackground.Width,xpnl_ListviewBackground.Height)
	xclv_Main.Base_Resize(xpnl_ListviewBackground.Width,xpnl_ListviewBackground.Height)
	#End if
	
	#If B4I
	Dim sv As ScrollView = xclv_Main.sv
	sv.Color = xui.Color_Transparent'xui.Color_ARGB(255,32, 33, 37)
	#End If
	
End Sub

Public Sub HidePicker
	BottomCard.Hide(False)
End Sub

Public Sub ShowPicker
	
	Dim DatePickerHeight As Float = m_BodyHeight
	Dim SafeAreaHeight As Float = 0
	
	#If B4I
	SafeAreaHeight = B4XPages.GetNativeParent(B4XPages.MainPage).SafeAreaInsets.Bottom
	m_BodyHeight = m_BodyHeight + SafeAreaHeight
	#Else
	SafeAreaHeight = 20dip
	m_BodyHeight = m_BodyHeight + SafeAreaHeight
	#End If
	
	BottomCard.Initialize(Me,"BottomCard")
	BottomCard.BodyDrag = True
	BottomCard.Create(xParent,m_BodyHeight,m_BodyHeight,m_HeaderHeight,xParent.Width,BottomCard.Orientation_MIDDLE)
	
	xpnl_Header.Color = m_HeaderColor
	
	xpnl_Header.AddView(xpnl_DragIndicator,xParent.Width/2 - 70dip/2,m_HeaderHeight/2 - 6dip/2,70dip,6dip)
	Dim ARGB() As Int = GetARGB(m_CategoryTextColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
	
	BottomCard.BodyPanel.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,xParent.Width,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_Body,0,0,xParent.Width,DatePickerHeight)
	BottomCard.CornerRadius_Header = 30dip/2
	
	xpnl_CategoriesBackground = xui.CreatePanel("")
	xpnl_Body.AddView(xpnl_CategoriesBackground,0,0,xpnl_Body.Width,xParent.Width/9)
	
	xpnl_ListviewBackground.RemoveViewFromParent
	xpnl_Body.AddView(xpnl_ListviewBackground,0,xParent.Width/9,xpnl_Body.Width,m_BodyHeight - xParent.Width/9 - SafeAreaHeight)
	
	'Dim Now As Long = DateTime.Now
	
	'CreateCategories(Array As String("recent"),Chr(0xE192)) 'Recent
	CreateCategories(Array As String("smileys_emotion","people_body"),Chr(0xE24E))
	CreateCategories(Array As String("animals_nature"),Chr(0xE91D))
	CreateCategories(Array As String("food_drink"),Chr(0xE556))
	CreateCategories(Array As String("travel_places"),Chr(0xE0AF))
	CreateCategories(Array As String("activities"),Chr(0xE566))
	CreateCategories(Array As String("objects"),Chr(0xE90F))
	CreateCategories(Array As String("symbols"),Chr(0xE52E))
	CreateCategories(Array As String("flags"),Chr(0xE153))
	
	CurrentCategory = "smileys_emotion"
	
'	#IF Debug
'	Log((DateTime.Now - Now) & "ms")
'	#Else
'	xui.MsgboxAsync((DateTime.Now - Now) & "ms","Test")
'	#End If
	
	xpnl_CurrentCategoryIndicator = xui.CreatePanel("")
	xpnl_CategoriesBackground.AddView(xpnl_CurrentCategoryIndicator,0,xParent.Width/9 - 2dip,xParent.Width/9,2dip)
	xpnl_CurrentCategoryIndicator.Color = m_CategoryIndicatorColor
	
	
	Sleep(0)
	
	BottomCard.Show(False)
	
End Sub

Private Sub CreateCategories(CategoryNames() As String,Icon As String)
	
	Dim Width As Float = xParent.Width/8
	
	xpnl_CategoriesBackground.AddView(CreateCategoryItem(Icon,xui.CreateMaterialIcons(25),CategoryNames(0)),Width*xpnl_CategoriesBackground.NumberOfViews,0,Width,Width)
	
	For Each Category As String In CategoryNames
		
		If m_Emojis.ContainsKey(Category) = False Then
			
			
			
		Else
			
			Dim Counter As Int = 0
			Dim xpnl_EmojiBackground As B4XView
			Dim emojis As List = m_Emojis.Get(Category).As(Map).Get("emojis")
			For Each colemojis As Map In emojis
	
				Dim HeightWidth As Float = xpnl_ListviewBackground.Height/m_Rows
				If Counter Mod m_Rows = 0 Then
					xpnl_EmojiBackground = xui.CreatePanel("")
					xpnl_EmojiBackground.SetLayoutAnimated(0,0,0,HeightWidth,HeightWidth)
					Dim tmp_lst As List
					tmp_lst.Initialize
					xpnl_EmojiBackground.Tag = tmp_lst
					xclv_Main.Add(xpnl_EmojiBackground,m_Emojis.Get(Category).As(Map).Get("slug"))
				End If
				
				xpnl_EmojiBackground.Tag.As(List).Add(colemojis.Get("emoji"))
				
	
				Counter = Counter +1
			Next
				
		End If
		
	Next
	
End Sub

Private Sub xclv_main_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	
	If xclv_Main.GetValue(FirstIndex) <> CurrentCategory Then
		
		For i = 0 To xpnl_CategoriesBackground.NumberOfViews -1
		
			If xclv_Main.GetValue(FirstIndex) = xpnl_CategoriesBackground.GetView(i).tag Then
		
				'xui.MsgboxAsync(xpnl_CategoriesBackground.GetView(i).Tag,"test")
				Dim xlbl_Category As B4XView = xpnl_CategoriesBackground.GetView(i)
				xpnl_CurrentCategoryIndicator.SetLayoutAnimated(250,xlbl_Category.Left,xpnl_CurrentCategoryIndicator.Top,xpnl_CurrentCategoryIndicator.Width,xpnl_CurrentCategoryIndicator.Height)
				CurrentCategory = xclv_Main.GetValue(FirstIndex)
			End If
		Next
	End If
	
	Dim ExtraSize As Int = 10
	For i = 0 To xclv_Main.Size - 1
		Dim p As B4XView = xclv_Main.GetPanel(i)
		If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				
				Dim tmp_List As List =  p.Tag
				For z = 0 To tmp_List.Size -1
					
					Dim xlbl_Emoji As B4XView = CreateLabel("xlbl_Emoji")
					xlbl_Emoji.Font = xui.CreateDefaultFont(m_EmojiSize)
					xlbl_Emoji.Text = tmp_List.Get(z)
					xlbl_Emoji.TextColor = xui.Color_White
					xlbl_Emoji.SetTextAlignment("CENTER","CENTER")
				
					p.AddView(xlbl_Emoji,0,p.Width*z,p.Width,p.Width)
					
				Next
				
			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews
			End If
		End If
	Next
End Sub

Private Sub CreateCategoryItem(Text As String,xFont As B4XFont,Value As Object) As B4XView
	Dim xlbl As B4XView = CreateLabel("xlbl_Category")
	xlbl.Font = xFont
	xlbl.Text = Text
	xlbl.TextColor = m_CategoryTextColor
	xlbl.SetTextAlignment("CENTER","CENTER")
	xlbl.Tag = Value
	Return xlbl
End Sub

Private Sub xlbl_Emoji_Click
	Dim xlbl_Emoji As B4XView = Sender
	EmojiSelected(xlbl_Emoji.Text)
End Sub

Private Sub xlbl_Category_Click
	Dim xlbl_Category As B4XView = Sender
	xpnl_CurrentCategoryIndicator.SetLayoutAnimated(250,xlbl_Category.Left,xpnl_CurrentCategoryIndicator.Top,xpnl_CurrentCategoryIndicator.Width,xpnl_CurrentCategoryIndicator.Height)
	CurrentCategory = xlbl_Category.Tag
	If xlbl_Category.Tag = "recent" Then
		xclv_Main.ScrollToItem(0)
	Else
		For i = 0 To xclv_Main.Size -1
		
			If xlbl_Category.Tag = xclv_Main.GetValue(i) Then
				xclv_Main.ScrollToItem(i)
				Exit
			End If
		
		Next
	End If
	
End Sub

Private Sub BottomCard_Close
	If xui.SubExists(mCallBack,mEventName & "_Close",0) Then
		CallSub(mCallBack,mEventName & "_Close")
	End If
End Sub

Private Sub BottomCard_Closed
	If xui.SubExists(mCallBack,mEventName & "_Closed",0) Then
		CallSub(mCallBack,mEventName & "_Closed")
	End If
End Sub

Private Sub BottomCard_Open
	If xui.SubExists(mCallBack,mEventName & "_Open",0) Then
		CallSub(mCallBack,mEventName & "_Open")
	End If
End Sub

Private Sub BottomCard_Opened
	If xui.SubExists(mCallBack,mEventName & "_Opened",0) Then
		CallSub(mCallBack,mEventName & "_Opened")
	End If
End Sub

Private Sub BottomCard_VisibleBodyHeightChanged (height As Double)
	If xui.SubExists(mCallBack,mEventName & "_VisibleBodyHeightChanged",1) Then
		CallSub2(mCallBack,mEventName & "_VisibleBodyHeightChanged",height)
	End If
End Sub

#Region Properties

'Number of emojis per row vertical
'Default: 5
Public Sub getRows As Int
	Return m_Rows
End Sub

Public Sub setRows(Rows As Int)
	m_Rows = Rows
End Sub


'Default: 300dip
Public Sub getBodyHeight As Float
	Return m_BodyHeight
End Sub

Public Sub setBodyHeight(Height As Float)
	m_BodyHeight = Height
End Sub

'Default: 30
Public Sub setEmojiSize(Size As Int)
	m_EmojiSize= Size
End Sub

Public Sub getEmojiSize As Int
	Return m_EmojiSize
End Sub

Public Sub setCategoryIndicatorColor(Color As Int)
	m_CategoryIndicatorColor = Color
End Sub

Public Sub getCategoryIndicatorColor As Int
	Return m_CategoryIndicatorColor
End Sub

Public Sub setCategoryTextColor(Color As Int)
	m_CategoryTextColor = Color
	Dim ARGB() As Int = GetARGB(m_CategoryTextColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
End Sub

Public Sub getCategoryTextColor As Int
	Return m_CategoryTextColor
End Sub

Public Sub setBackgroundColor(Color As Int)
	m_BodyColor = Color
	If BottomCard.IsInitialized Then BottomCard.BodyPanel.Color = m_BodyColor
	m_HeaderColor = Color
	xpnl_Body.Color = Color
	xpnl_Header.Color = Color
End Sub

Public Sub getBackgroundColor As Int
	Return m_BodyColor
End Sub

#End Region

#Region Events

Private Sub EmojiSelected(Text As String)
	If xui.SubExists(mCallBack, mEventName & "_EmojiSelected",1) Then
		CallSub2(mCallBack, mEventName & "_EmojiSelected",Text)
	End If
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

''https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
'Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
'	Dim xui As XUI
'	Dim p As B4XView = xui.CreatePanel("")
'	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
'	Dim cvs1 As B4XCanvas
'	cvs1.Initialize(p)
'	Dim fnt As B4XFont
'	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
'	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
'	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
'	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
'	Dim b As B4XBitmap = cvs1.CreateBitmap
'	cvs1.Release
'	Return b
'End Sub

Private Sub GetARGB(Color As Int) As Int()'ignore
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#End Region
