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
	-Add GetItem - Gets an item with the country code
	-Add GetItem2 - Gets an item with the dial code
#End If

#Event: ConfirmButtonClicked (Item As AS_BottomPhoneNumberFlagPicker_Item)

Sub Class_Globals
	
	Type AS_BottomPhoneNumberFlagPicker_Item(FlagEmoji As String,CountryCode As String,DialCode As String,Name As String)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	Private xpnl_ListviewBackground As B4XView
	Private xWheel_PhoneNumberFlags As ASWheelPicker
	
	Private xpnl_Header As B4XView
	Private xpnl_Body As B4XView
	Private xlbl_ConfirmationButton As B4XView
	Private xpnl_DragIndicator As B4XView
	
	Private m_HeaderHeight As Float
	Private m_BodyHeight As Float
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_TextColor As Int
	Private m_lstData As List
	
	Private m_Search_DialCode As String
	Private m_Search_CountryCode As String
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	
	m_HeaderHeight = 40dip
	m_BodyHeight = 200dip
	
	xpnl_Header = xui.CreatePanel("")
	xpnl_Body = xui.CreatePanel("")
	xlbl_ConfirmationButton = CreateLabel("xlbl_ConfirmationButton")
	xpnl_DragIndicator = xui.CreatePanel("")
	xpnl_ListviewBackground = xui.CreatePanel("")
	xpnl_ListviewBackground.SetLayoutAnimated(0,0,0,Parent.Width,m_BodyHeight)
	
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	m_TextColor = xui.Color_White
	
	m_lstData.Initialize
	Dim parser As JSONParser
	parser.Initialize(File.ReadString(File.DirAssets,"CountryDialInfo.json"))
	m_lstData = parser.NextArray
	
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
	BottomCard.BodyDrag = False
	BottomCard.Create(xParent,m_BodyHeight,m_BodyHeight,m_HeaderHeight,xParent.Width,BottomCard.Orientation_MIDDLE)
	
	xpnl_Header.Color = m_HeaderColor
	
	xpnl_Header.AddView(xpnl_DragIndicator,xParent.Width/2 - 70dip/2,m_HeaderHeight/2 - 6dip/2,70dip,6dip)
	Dim ARGB() As Int = GetARGB(m_TextColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
	
	'ConfirmationButton
	xlbl_ConfirmationButton.RemoveViewFromParent
	xlbl_ConfirmationButton.Text = "Confirm"
	xlbl_ConfirmationButton.TextColor = xui.Color_White
	xlbl_ConfirmationButton.SetColorAndBorder(xui.Color_ARGB(255,45, 136, 121),0,0,10dip)
	xlbl_ConfirmationButton.SetTextAlignment("CENTER","CENTER")
	Dim ConfirmationButtoHeight As Float = 40dip		
	xpnl_Body.AddView(xlbl_ConfirmationButton,xParent.Width/2 - 220dip/2,m_BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,220dip,ConfirmationButtoHeight)
	
	
	xpnl_Body.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,xParent.Width,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_Body,0,0,xParent.Width,DatePickerHeight + SafeAreaHeight)
	BottomCard.CornerRadius_Header = 30dip/2
	
	
	xpnl_ListviewBackground.RemoveViewFromParent
	xpnl_Body.AddView(xpnl_ListviewBackground,0,0,xpnl_Body.Width,xlbl_ConfirmationButton.top - IIf(xui.IsB4i,25dip,15dip))
	
	xpnl_ListviewBackground.LoadLayout("frm_BottomPhoneNumberFlagPicker_Wheel")
	
	xpnl_ListviewBackground.Color = m_BodyColor
	xWheel_PhoneNumberFlags.BackgroundColor = m_BodyColor
	xWheel_PhoneNumberFlags.FadeColor = m_BodyColor
	xWheel_PhoneNumberFlags.SelectionBarColor = xpnl_DragIndicator.Color
	xWheel_PhoneNumberFlags.RowHeightSelected = 40dip
	xWheel_PhoneNumberFlags.RowHeightUnSelected = 40dip
	
	Dim ItemTextProperties As ASWheelPicker_ItemTextProperties = xWheel_PhoneNumberFlags.ItemTextProperties
	ItemTextProperties.BackgroundColor = m_BodyColor
	ItemTextProperties.TextColor = m_TextColor
	xWheel_PhoneNumberFlags.ItemTextProperties = ItemTextProperties
	
	Dim FlagsAndNames As List : FlagsAndNames.Initialize
	
	For Each FlagMap As Map In m_lstData
		
		Dim Item_FlagsAndNames As ASWheelPicker_Item : Item_FlagsAndNames.Initialize
		Item_FlagsAndNames.Text = FlagMap.Get("name")
		Item_FlagsAndNames.Value = FlagMap
		FlagsAndNames.Add(Item_FlagsAndNames)
		
	Next
	
	xWheel_PhoneNumberFlags.SetItems(0,FlagsAndNames)
	xWheel_PhoneNumberFlags.Refresh
	
	If m_Search_DialCode <> "" Or m_Search_CountryCode <> "" Then
		Sleep(0)
		If m_Search_CountryCode <> "" Then SelectItem(m_Search_CountryCode)
		If m_Search_DialCode <> "" Then SelectItem2(m_Search_DialCode)
	End If
	
	Sleep(0)
	
	BottomCard.Show(False)
	
End Sub

'Selects an item with the country code
'Example: "de" to select Germany
Public Sub SelectItem(CountryCode As String)
	CountryCode = CountryCode.ToUpperCase
	
	If xWheel_PhoneNumberFlags.IsInitialized Then
	
	For i = 0 To xWheel_PhoneNumberFlags.Size(0) -1
		
		If xWheel_PhoneNumberFlags.GetItem(0,i).Value.As(Map).Get("code") = CountryCode Then
			xWheel_PhoneNumberFlags.SelectRow(0,i,False)
			Exit
		End If
		
	Next
	
	Else
		m_Search_CountryCode = CountryCode
	End If
	
End Sub

'Selects an item with the dial code
'Example: "+49" to select Germany
Public Sub SelectItem2(DialCode As String)
	
	If xWheel_PhoneNumberFlags.IsInitialized Then
	
		For i = 0 To xWheel_PhoneNumberFlags.Size(0) -1
		
			If xWheel_PhoneNumberFlags.GetItem(0,i).Value.As(Map).Get("dial_code") = DialCode Then
				xWheel_PhoneNumberFlags.SelectRow(0,i,False)
				Exit
			End If
		
		Next
	
	Else
		m_Search_DialCode = DialCode
	End If
	
End Sub

'Gets an item with the country code
'Example: "de" to select Germany
Public Sub GetItem(CountryCode As String) As AS_BottomPhoneNumberFlagPicker_Item
	CountryCode = CountryCode.ToUpperCase
	
	For Each m As Map In m_lstData
		
		If CountryCode = m.Get("code") Then			
			Return CreateAS_BottomPhoneNumberFlagPicker(m.Get("flag"),m.Get("code"),m.Get("dial_code"),m.Get("name"))
		End If
		
	Next
	
	Return Null
	
End Sub

'Gets an item with the dial code
'Example: "+49" to select Germany
Public Sub GetItem2(DialCode As String) As AS_BottomPhoneNumberFlagPicker_Item
	For Each m As Map In m_lstData
		
		If DialCode = m.Get("dial_code") Then
			Return CreateAS_BottomPhoneNumberFlagPicker(m.Get("flag"),m.Get("code"),m.Get("dial_code"),m.Get("name"))
		End If
		
	Next
	
	Return Null
End Sub

#Region Properties

Public Sub setTextColor(Color As Int)
	m_TextColor = Color
	Dim ARGB() As Int = GetARGB(m_TextColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
End Sub

Public Sub getTextColor As Int
	Return m_TextColor
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

#End Region

#Region Events

Private Sub xWheel_PhoneNumberFlags_CustomDrawItem(Item As ASWheelPicker_CustomDraw)
	
	Dim Data As Map = Item.Item.Value
	
	Dim xlbl_Flag As B4XView = Item.Views.TextLabel
	xlbl_Flag.Width = 40dip
	xlbl_Flag.Left = 15dip
	xlbl_Flag.TextColor = m_TextColor
	xlbl_Flag.SetTextAlignment("CENTER","LEFT")
	xlbl_Flag.Text = Data.Get("flag")
	xlbl_Flag.TextSize = 25
	
	Dim xlbl_CountryName As B4XView = CreateLabel("")
	xlbl_CountryName.Font = xlbl_Flag.Font
	xlbl_CountryName.TextColor = m_TextColor
	xlbl_CountryName.SetTextAlignment("CENTER","LEFT")
	xlbl_CountryName.Text = Data.Get("name")
	xlbl_CountryName.TextSize = 15
	Item.Views.BackgroundPanel.AddView(xlbl_CountryName,xlbl_Flag.Left + xlbl_Flag.Width,0,Item.Views.BackgroundPanel.Width - xlbl_Flag.Width - 75dip,Item.Views.BackgroundPanel.Height)
	
	Dim xlbl_Prefix As B4XView = CreateLabel("")
	xlbl_Prefix.Font = xlbl_Flag.Font
	xlbl_Prefix.TextColor = m_TextColor
	xlbl_Prefix.SetTextAlignment("CENTER","RIGHT")
	xlbl_Prefix.Text = Data.Get("dial_code")
	xlbl_Prefix.Font = xui.CreateDefaultBoldFont(18)
	Item.Views.BackgroundPanel.AddView(xlbl_Prefix,Item.Views.BackgroundPanel.Width - 75dip,0,60dip,Item.Views.BackgroundPanel.Height)
	
End Sub

#If B4J
Private Sub xlbl_ConfirmationButton_MouseClicked (EventData As MouseEvent)
	ConfirmButtonClicked
End Sub
#Else
Private Sub xlbl_ConfirmationButton_Click
	ConfirmButtonClicked
End Sub
#End If


Private Sub ConfirmButtonClicked
	
	Dim m As Map = xWheel_PhoneNumberFlags.GetItem(0,xWheel_PhoneNumberFlags.GetIndex(0)).Value
	Dim Item As AS_BottomPhoneNumberFlagPicker_Item = CreateAS_BottomPhoneNumberFlagPicker(m.Get("flag"),m.Get("code"),m.Get("dial_code"),m.Get("name"))
	
	BottomCard.Hide(False)
	If xui.SubExists(mCallBack, mEventName & "_ConfirmButtonClicked",1) Then
		CallSub2(mCallBack, mEventName & "_ConfirmButtonClicked",Item)
	End If
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub GetARGB(Color As Int) As Int()'ignore
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#End Region


Public Sub CreateAS_BottomPhoneNumberFlagPicker (FlagEmoji As String, CountryCode As String, DialCode As String, Name As String) As AS_BottomPhoneNumberFlagPicker_Item
	Dim t1 As AS_BottomPhoneNumberFlagPicker_Item
	t1.Initialize
	t1.FlagEmoji = FlagEmoji
	t1.CountryCode = CountryCode
	t1.DialCode = DialCode
	t1.Name = Name
	Return t1
End Sub