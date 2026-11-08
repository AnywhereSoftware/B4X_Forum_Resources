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
	-BugFixes
V1.02
	-Add get and set MyCountryCode
#End If

#DesignerProperty: Key: HeaderColor, DisplayName: Header Color, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: HeaderTextColor, DisplayName: Header Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: TextFieldColor, DisplayName: TextField Color, FieldType: Color, DefaultValue: 0xFF3C4043
#DesignerProperty: Key: SeperatorColor, DisplayName: Seperator Color, FieldType: Color, DefaultValue: 0x32FFFFFF
#DesignerProperty: Key: ItemColor, DisplayName: Item Color, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: ItemTextColor, DisplayName: Item Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ItemClickColor, DisplayName: Item Click Color, FieldType: Color, DefaultValue: 0xFF30C877
#DesignerProperty: Key: OwnCountryColor, DisplayName: Own Country Color, FieldType: Color, DefaultValue: 0xFF30C877
#DesignerProperty: Key: OwnCountryTextColor, DisplayName: Own Country Text Color, FieldType: Color, DefaultValue: 0xFF000000

#Event: ItemClick (Item As AS_CountryPicker_Item)

Sub Class_Globals
	
	Type AS_CountryPicker_Item(FlagEmoji As String,CountryCode As String,DialCode As String,Name As String)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private xlbl_CountryPicker_Header As B4XView
	Private xtf_CountryPicker_Search As AS_TextFieldAdvanced
	Private xclv_CountryPicker_List As CustomListView
	Private xpnl_CountryPicker_Seperator As B4XView
	
	Private m_lstData As List
	Private m_SearchString As String
	Private m_MyCountry As String
	
	Private m_HeaderColor As Int
	Private m_HeaderTextColor As Int
	Private m_TextFieldColor As Int
	Private m_SeperatorColor As Int
	Private m_ItemTextColor As Int
	Private m_ItemColor As Int
	Private m_OwnCountryColor As Int
	Private m_OwnCountryTextColor As Int
	Private m_ItemClickColor As Int
	
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

	#If B4A
	Sleep(0)
	#End If
	mBase.LoadLayout("frm_CountryPicker")
	
	#If B4J
	xclv_CountryPicker_List.sv.As(ScrollPane).Style="-fx-background:transparent;-fx-background-color:transparent;"
	#End If
	
	xclv_CountryPicker_List.AsView.Color = m_ItemColor
	
	mBase.Color = m_HeaderColor
	xlbl_CountryPicker_Header.TextColor = m_HeaderTextColor
	xpnl_CountryPicker_Seperator.Color = m_SeperatorColor

	xtf_CountryPicker_Search.LeftGap = 0
	xtf_CountryPicker_Search.TextField.Font = xui.CreateDefaultFont(20)
	xtf_CountryPicker_Search.Hint.xFont = xui.CreateDefaultFont(20)
	xtf_CountryPicker_Search.TextFieldProperties.CornerRadius = 10dip
	xtf_CountryPicker_Search.TextColor = m_HeaderTextColor
	xtf_CountryPicker_Search.BackgroundColor = m_TextFieldColor
	Dim ARGB() As Int = GetARGB(m_HeaderTextColor)
	xtf_CountryPicker_Search.Hint.FocusedTextColor = xui.Color_ARGB(100,ARGB(1),ARGB(2),ARGB(3))
	xtf_CountryPicker_Search.Hint.NonFocusedTextColor = xui.Color_ARGB(100,ARGB(1),ARGB(2),ARGB(3))
	xtf_CountryPicker_Search.LeadingIcon.Icon = xtf_CountryPicker_Search.FontToBitmap(Chr(0xE8B6),True,40,xui.Color_ARGB(100,ARGB(1),ARGB(2),ARGB(3)))
	xtf_CountryPicker_Search.Refresh

	m_MyCountry = GetCountry

	xclv_CountryPicker_List.PressedColor = m_ItemClickColor

	m_lstData.Initialize
	Dim parser As JSONParser
	parser.Initialize(File.ReadString(File.DirAssets,"CountryDialInfo.json"))
	m_lstData = parser.NextArray

	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If

	FillList

End Sub

Private Sub IniProps(Props As Map)
	
	m_HeaderColor = xui.PaintOrColorToColor(Props.Get("HeaderColor"))
	m_HeaderTextColor = xui.PaintOrColorToColor(Props.Get("HeaderTextColor"))
	m_TextFieldColor = xui.PaintOrColorToColor(Props.Get("TextFieldColor"))
	m_SeperatorColor = xui.PaintOrColorToColor(Props.Get("SeperatorColor"))
	m_ItemTextColor = xui.PaintOrColorToColor(Props.Get("ItemTextColor"))
	m_ItemColor = xui.PaintOrColorToColor(Props.Get("ItemColor"))
	m_OwnCountryColor = xui.PaintOrColorToColor(Props.Get("OwnCountryColor"))
	m_OwnCountryTextColor = xui.PaintOrColorToColor(Props.Get("OwnCountryTextColor"))
	m_ItemClickColor = xui.PaintOrColorToColor(Props.Get("ItemClickColor"))
	
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
  
	xlbl_CountryPicker_Header.Width = Width - xlbl_CountryPicker_Header.Left*2
	xtf_CountryPicker_Search.mBase.Width = Width - xtf_CountryPicker_Search.mBase.Left*2
	xtf_CountryPicker_Search.Refresh
  
	Dim WidthChanged As Boolean = xclv_CountryPicker_List.AsView.Width <> Width
  
	xclv_CountryPicker_List.AsView.Height = Height - xclv_CountryPicker_List.AsView.Top
	xclv_CountryPicker_List.AsView.Width = Width
	xclv_CountryPicker_List.Base_Resize(Width,xclv_CountryPicker_List.AsView.Height)
  
	If WidthChanged Then
		
		For i = 0 To xclv_CountryPicker_List.Size -1
			xclv_CountryPicker_List.GetPanel(i).Width = Width
			xclv_CountryPicker_List.GetPanel(i).RemoveAllViews
		Next
		xclv_CountryPicker_List.Refresh
	End If
  	
End Sub

Public Sub FillList
	
	xclv_CountryPicker_List.Clear
	
	If m_SearchString = "" Then
		
		For Each FlagMap As Map In m_lstData
			If FlagMap.Get("code") = m_MyCountry Then
				Dim xpnl_Background As B4XView = xui.CreatePanel("")
				xpnl_Background.SetLayoutAnimated(0,0,0,xclv_CountryPicker_List.AsView.Width,60dip)
				xpnl_Background.Color = m_ItemColor
				xclv_CountryPicker_List.Add(xpnl_Background,FlagMap)
				Exit
			End If
		Next
		
	End If
	
	For Each FlagMap As Map In m_lstData
		
		If m_SearchString <> "" Then
			
			If FlagMap.Get("name").As(String).ToLowerCase.Contains(m_SearchString.ToLowerCase) = False And FlagMap.Get("dial_code").As(String).ToLowerCase.Contains(m_SearchString.ToLowerCase) = False Then
				Continue
			End If
			
		End If
		
		Dim xpnl_Background As B4XView = xui.CreatePanel("")
		xpnl_Background.SetLayoutAnimated(0,0,0,xclv_CountryPicker_List.AsView.Width,60dip)
		xpnl_Background.Color = m_ItemColor
		xclv_CountryPicker_List.Add(xpnl_Background,FlagMap)
		
	Next
	
End Sub

Private Sub CreateItem(xpnl_Background As B4XView,Data As Map)
	
	Dim xlbl_Flag As B4XView = CreateLabel("")
	xlbl_Flag.TextColor = m_ItemTextColor
	xlbl_Flag.SetTextAlignment("CENTER","LEFT")
	xlbl_Flag.Text = Data.Get("flag")
	xlbl_Flag.TextSize = 25
	xpnl_Background.AddView(xlbl_Flag,15dip,0,40dip,xpnl_Background.Height)
	
	Dim xlbl_CountryName As B4XView = CreateLabel("")
	xlbl_CountryName.Font = xlbl_Flag.Font
	xlbl_CountryName.TextColor = m_ItemTextColor
	xlbl_CountryName.SetTextAlignment("CENTER","LEFT")
	xlbl_CountryName.Text = Data.Get("name")
	xlbl_CountryName.TextSize = 18
	#If B4I
	xlbl_CountryName.As(Label).Multiline = True
	#End If
	xpnl_Background.AddView(xlbl_CountryName,xlbl_Flag.Left + xlbl_Flag.Width,0,xpnl_Background.Width - xlbl_Flag.Width - 75dip,xpnl_Background.Height)
	
	Dim xlbl_Prefix As B4XView = CreateLabel("")
	xlbl_Prefix.Font = xlbl_Flag.Font
	xlbl_Prefix.TextColor = m_ItemTextColor
	xlbl_Prefix.SetTextAlignment("CENTER","RIGHT")
	xlbl_Prefix.Text = Data.Get("dial_code")
	xlbl_Prefix.Font = xui.CreateDefaultBoldFont(18)
	xpnl_Background.AddView(xlbl_Prefix,xpnl_Background.Width - 75dip,0,60dip,xpnl_Background.Height)
	
	Dim xpnl_Seperator As B4XView = xui.CreatePanel("")
	xpnl_Seperator.Color = m_SeperatorColor
	xpnl_Background.AddView(xpnl_Seperator,xlbl_Flag.Left + 2dip,xpnl_Background.Height - 1dip,xpnl_Background.Width - xlbl_Flag.Left - 2dip,1dip)
	
	If Data.Get("code") = m_MyCountry Then
		xlbl_Prefix.Width = MeasureTextWidth(xlbl_Prefix.Text,xlbl_Prefix.Font) + 15dip
		xlbl_Prefix.Height = MeasureTextHeight(xlbl_Prefix.Text,xlbl_Prefix.Font) + 10dip
		xlbl_Prefix.Top = xpnl_Background.Height/2 - xlbl_Prefix.Height/2
		xlbl_Prefix.Left = xpnl_Background.Width - xlbl_Prefix.Width - 15dip
		xlbl_Prefix.SetTextAlignment("CENTER","CENTER")
		xlbl_Prefix.TextColor = m_OwnCountryTextColor
		xlbl_Prefix.SetColorAndBorder(m_OwnCountryColor,0,0,5dip)
	End If
	
End Sub

'Gets an item with the country code
'Example: "de" to select Germany
Public Sub GetItem(CountryCode As String) As AS_CountryPicker_Item
	CountryCode = CountryCode.ToUpperCase

	For Each m As Map In m_lstData
		
		If CountryCode = m.Get("code") Then
			Return CreateAS_CountryPicker_Item(m.Get("flag"),m.Get("code"),m.Get("dial_code"),m.Get("name"))
		End If
		
	Next
	
	Return Null
	
End Sub

'Gets an item with the dial code
'Example: "+49" to select Germany
Public Sub GetItem2(DialCode As String) As AS_CountryPicker_Item
	For Each m As Map In m_lstData
		
		If DialCode = m.Get("dial_code") Then
			Return CreateAS_CountryPicker_Item(m.Get("flag"),m.Get("code"),m.Get("dial_code"),m.Get("name"))
		End If
		
	Next
	
	Return Null
End Sub

#Region Properties

Public Sub setMyCountryCode(CountryCode As String)
	m_MyCountry = CountryCode.ToUpperCase
	FillList
End Sub

Public Sub getMyCountryCode As String
	Return m_MyCountry
End Sub

Public Sub getHeaderLabel As B4XView
	Return xlbl_CountryPicker_Header
End Sub

Public Sub getSearchTextField As AS_TextFieldAdvanced
	Return xtf_CountryPicker_Search
End Sub

Public Sub getHeaderSeperator As B4XView
	Return xpnl_CountryPicker_Seperator
End Sub

Public Sub getCustomListView As CustomListView
	Return xclv_CountryPicker_List
End Sub

Public Sub getHeaderColor As Int
	Return m_HeaderColor
End Sub

Public Sub setHeaderColor(Color As Int)
	m_HeaderColor = Color
	mBase.Color = Color
End Sub

Public Sub getHeaderTextColor As Int
	Return m_HeaderTextColor
End Sub

Public Sub setHeaderTextColor(Color As Int)
	m_HeaderTextColor = Color
	xtf_CountryPicker_Search.TextColor = m_HeaderTextColor
	Dim ARGB() As Int = GetARGB(m_HeaderTextColor)
	xtf_CountryPicker_Search.Hint.FocusedTextColor = xui.Color_ARGB(100,ARGB(1),ARGB(2),ARGB(3))
	xtf_CountryPicker_Search.Hint.NonFocusedTextColor = xui.Color_ARGB(100,ARGB(1),ARGB(2),ARGB(3))
	xtf_CountryPicker_Search.LeadingIcon.Icon = xtf_CountryPicker_Search.FontToBitmap(Chr(0xE8B6),True,40,xui.Color_ARGB(100,ARGB(1),ARGB(2),ARGB(3)))
	xtf_CountryPicker_Search.Refresh
	xlbl_CountryPicker_Header.TextColor = Color
End Sub

Public Sub getTextFieldColor As Int
	Return m_TextFieldColor
End Sub

Public Sub setTextFieldColor(Color As Int)
	m_TextFieldColor = Color
	xtf_CountryPicker_Search.BackgroundColor = m_TextFieldColor
	xtf_CountryPicker_Search.Refresh
End Sub

'Call FillList if you want to change the seperator in the list too
Public Sub getSeperatorColor As Int
	Return m_SeperatorColor
End Sub

Public Sub setSeperatorColor(Color As Int)
	m_SeperatorColor = Color
	xpnl_CountryPicker_Seperator.Color = Color
End Sub

'Call FillList if you change something
Public Sub getItemColor As Int
	Return m_ItemColor
End Sub

Public Sub setItemColor(Color As Int)
	m_ItemColor = Color
	xclv_CountryPicker_List.AsView.Color = m_ItemColor
End Sub

Public Sub getItemTextColor As Int
	Return m_ItemTextColor
End Sub

'Call FillList if you change something
Public Sub setItemTextColor(Color As Int)
	m_ItemTextColor = Color
End Sub

Public Sub getItemClickColor As Int
	Return m_ItemClickColor
End Sub

Public Sub setItemClickColor(Color As Int)
	m_ItemClickColor = Color
	xclv_CountryPicker_List.PressedColor = Color
End Sub

'Call FillList if you change something
Public Sub getOwnCountryColor As Int
	Return m_OwnCountryColor
End Sub

Public Sub setOwnCountryColor(Color As Int)
	m_OwnCountryColor = Color
End Sub

'Call FillList if you change something
Public Sub getOwnCountryTextColor As Int
	Return m_OwnCountryTextColor
End Sub

Public Sub setOwnCountryTextColor(Color As Int)
	m_OwnCountryTextColor = Color
End Sub

#End Region

#Region ViewEvents

Private Sub xclv_CountryPicker_List_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Dim ExtraSize As Int = 20
	For i = 0 To xclv_CountryPicker_List.Size - 1
		Dim p As B4XView = xclv_CountryPicker_List.GetPanel(i)
		If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				CreateItem(p,xclv_CountryPicker_List.GetValue(i))
			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews
			End If
		End If
	Next
End Sub

Private Sub xtf_CountryPicker_Search_TextChanged(Text As String)
	m_SearchString = Text
	Sleep(0)
	FillList
End Sub

Private Sub xclv_CountryPicker_List_ItemClick (Index As Int, Value As Object)
	ItemClick(Index)
End Sub

#End Region

#Region Events

Private Sub ItemClick(Index As Int)
	
	Dim m As Map = xclv_CountryPicker_List.GetValue(Index)
	Dim Item As AS_CountryPicker_Item = CreateAS_CountryPicker_Item(m.Get("flag"),m.Get("code"),m.Get("dial_code"),m.Get("name"))
	
	If xui.SubExists(mCallBack, mEventName & "_ItemClick",1) Then
		CallSub2(mCallBack, mEventName & "_ItemClick",Item)
	End If
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

#If B4I
Public Sub GetCountry As String
	Dim no As NativeObject
	Dim s As String  = no.Initialize("NSLocale") _
        .RunMethod("currentLocale", Null).RunMethod("objectForKey:", Array("kCFLocaleCountryCodeKey")).AsString
	Return s
End Sub
#Else If B4A
Public Sub GetCountry As String
	Dim r As Reflector
	r.Target = r.RunStaticMethod("java.util.Locale", "getDefault", Null, Null)
	Return r.RunMethod("getCountry")
End Sub
#Else If B4J
Public Sub GetCountry As String
	Dim jo As JavaObject
	Dim s As String = jo.InitializeStatic("java.util.Locale").RunMethod("getDefault", Null)
	Return Regex.Split("_",s)(1)
End Sub
#End If

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

Private Sub GetARGB(Color As Int) As Int()'ignore
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#End Region

#Region Types

Public Sub CreateAS_CountryPicker_Item (FlagEmoji As String, CountryCode As String, DialCode As String, Name As String) As AS_CountryPicker_Item
	Dim t1 As AS_CountryPicker_Item
	t1.Initialize
	t1.FlagEmoji = FlagEmoji
	t1.CountryCode = CountryCode
	t1.DialCode = DialCode
	t1.Name = Name
	Return t1
End Sub

#End Region
