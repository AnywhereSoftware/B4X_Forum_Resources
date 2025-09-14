B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Version:2.5
'Ui max_co


#Event: TextChanged (Old As String, New As String)
#If B4A
#Event: FocusChanged (HasFocus As Boolean)
#End If
#Event: EnterPressed
#Event: ClickedIcon


#DesignerProperty: Key: ActiveColor, DisplayName: Active Color, FieldType: Color, DefaultValue: 0xff12153D, Description: Active Color
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Background Color
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xff12153D, Description: Text Color
#DesignerProperty: Key: HintColor, DisplayName: Hint Color, FieldType: Color, DefaultValue: 0x3212153D, Description: Hint Color
#DesignerProperty: Key: IconDeleteColor, DisplayName: Icon Delete Color, FieldType: Color, DefaultValue: 0xff12153D, Description: Icon Delete Color
#DesignerProperty: Key: HintText, DisplayName: Hint Text, FieldType: String, DefaultValue: Ui Max_Co, Description: Hint Text
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 18, MinRange: 0, MaxRange: 100, Description: Text Size
#DesignerProperty: Key: IconSize, DisplayName: Icon Size, FieldType: Int, DefaultValue: 22, MinRange: 0, MaxRange: 100, Description: Icon Size
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 15, MinRange: 0, MaxRange: 100, Description: Corner Radius
#DesignerProperty: Key: BorderWidth, DisplayName: BorderWidth, FieldType: Int, DefaultValue: 4, MinRange: 0, MaxRange: 100, Description: BorderWidth
#DesignerProperty: Key: PasswordMode, DisplayName: Password Mode, FieldType: Boolean, DefaultValue: False, Description: Password Mode.

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Type VarColor(ActiveColor As Int,BackGroundColor As Int,txtColor As Int,IconDeleteColor As Int,HintColor As Int)
	Type VarInt(TextSize As Int,IconSize As Int,CornerRadius As Int,BorderWidth As Int)
	''''FontIcon
	Private myfont As B4XFont
	


''''Xviewes	
	Private pnl As B4XView
	Private LblHint As B4XView
	Private Edttxt As B4XView
	Private Icon As B4XView
	Private Border As B4XView
	Private BorderActive As B4XView
	Private IconActive As B4XView
	Private IconDlt As B4XView
	#if B4A Or B4i
	Private IconPass As B4XView
	#End If
	
	
	#if B4A
	Private edt As EditText
	#else
	Private edt As TextField
	#End If
	
''''Moteghaier Designer
	Private MyColor As VarColor
	Private MyInt As VarInt
	
	Private Hint As String
	Private PasswordMode As Boolean
	
''''Moteghayer Code
	Private FontIcon As B4XFont
	Private Fonte As B4XFont
	Private TextIcon As String
	
		
	
	Public isActive As Boolean = False
	
	Private Widthh As Int
	Private Hightt As Int 
	
		
	
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
	
	MyColor.Initialize
	MyInt.Initialize
	
	Fill_Variables(Props)
	Viewes
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	Widthh = Width
	Hightt = Height
	Private bord As Int = MyInt.BorderWidth*2 'اندازه ای که پنل باید از Mbase کوچک تر باشه

	
	Private a As Int = Widthh/4
	
	Private W3 As Int = Widthh/3
	If Hightt >= W3 Then
		pnl.SetLayoutAnimated(0,MyInt.BorderWidth,((mBase.Height/2)-(a/2))+MyInt.BorderWidth,Widthh-bord,a-bord)
	Else
		pnl.SetLayoutAnimated(0,MyInt.BorderWidth,MyInt.BorderWidth,Widthh-bord,Hightt-bord)
	End If
	
	Icon.SetLayoutAnimated(0,0,0,40dip,pnl.Height)
	Edttxt.SetLayoutAnimated(0,Icon.Width,0,pnl.Width-(Icon.Width*2),pnl.Height)
	LblHint.SetLayoutAnimated(0,Edttxt.Left+5dip,Edttxt.Top,Edttxt.Width-10dip,Edttxt.Height)
	Border.SetLayoutAnimated(0,pnl.Left-MyInt.BorderWidth,pnl.Top-MyInt.BorderWidth,pnl.Width+bord,pnl.Height+bord)
	IconActive.SetLayoutAnimated(0,Icon.Left,Icon.Top,Icon.Width,Icon.Height)
	If PasswordMode Then
		#if B4A Or B4i
		IconPass.SetLayoutAnimated(0,pnl.Width-40dip,0,40dip,pnl.Height)
		#End If
	Else	
		IconDlt.SetLayoutAnimated(0,pnl.Width-40dip,0,40dip,pnl.Height)
	End If
	
	
	If BorderActive.Visible Then
		BorderActive.SetLayoutAnimated(0,0,0,Border.Width,Border.Height)
	Else
		BorderActive.SetLayoutAnimated(0,Border.Width/2,0,0,Border.Height)
	End If
	
End Sub

'Fill in the variables
Private Sub Fill_Variables(props As Map)
	
	
	MyColor.ActiveColor = xui.PaintOrColorToColor(props.Get("ActiveColor"))
	MyColor.BackGroundColor = xui.PaintOrColorToColor(props.Get("BackgroundColor"))
	MyColor.txtColor = xui.PaintOrColorToColor(props.Get("TextColor"))
	MyColor.HintColor = xui.PaintOrColorToColor(props.Get("HintColor"))
	MyColor.IconDeleteColor = xui.PaintOrColorToColor(props.Get("IconDeleteColor"))
	Hint = props.Get("HintText")
	MyInt.TextSize = props.Get("TextSize")
	MyInt.IconSize = props.Get("IconSize")
	MyInt.CornerRadius = props.GetDefault("CornerRadius",15)
	MyInt.BorderWidth = props.GetDefault("BorderWidth",4)
	PasswordMode = props.GetDefault("PasswordMode",False)
	
'	#If b4a
'	myfont = xui.CreateFont(Typeface.LoadFromAssets("SearchViewIcons.ttf"), MyInt.IconSize)
'    #else if b4i
'	myfont= xui.CreateFont(Font.CreateNew2("SearchViewIcons", MyInt.IconSize), MyInt.IconSize)
'    #end if	
'	#if B4J
'	myfont = xui.CreateFontAwesome(MyInt.IconSize)
'	#End If
	
	myfont = xui.CreateFontAwesome(MyInt.IconSize)
	
End Sub

Private Sub CreateEditText(Event As String) As B4XView
	
	#if B4A
	edt.Initialize(Event)
	edt.SingleLine = True
	If PasswordMode Then
		edt.PasswordMode = True
	End If
	#End If
	#if B4J
	If PasswordMode Then
		edt.InitializePassword(Event)
	Else
		edt.Initialize(Event)	
	End If
	#End If
	#if B4i
	edt.Initialize(Event)
	If PasswordMode Then
		edt.PasswordMode = True
	End If
	
	#End If
	
	Return edt
	
End Sub

Private Sub CreateLabel(Event As String) As B4XView
	Private l As Label
	l.Initialize(Event)
	
	#if B4A
	l.SingleLine = True
	l.Ellipsize = "END"
	#End If
	
	Return l
	
End Sub

Private Sub Viewes
	
	Widthh = mBase.Width
	Hightt = mBase.Height
	
	''''Mbase
	mBase.SetColorAndBorder(xui.Color_Transparent,0,xui.Color_Transparent,0)
	
	
	'''Panel
	Private bord As Int = MyInt.BorderWidth*2 'اندازه ای که پنل باید از Mbase کوچک تر باشه
	pnl = xui.CreatePanel("")
	pnl.SetColorAndBorder(MyColor.BackGroundColor,0,0,MyInt.CornerRadius)
	Private a As Int = Widthh/4
	
	Private W3 As Int = Widthh/3
	If Hightt >= W3 Then
		mBase.AddView(pnl,MyInt.BorderWidth,((mBase.Height/2)-(a/2))+2dip,Widthh-bord,a-bord)
	Else
		mBase.AddView(pnl,MyInt.BorderWidth,MyInt.BorderWidth,Widthh-bord,Hightt-bord)
	End If
	
	''''Icon
	Icon = CreateLabel("")
	Icon.Font = myfont
	Icon.Text = Chr(0xF002)
	Icon.SetTextAlignment("CENTER","CENTER")
	Icon.TextColor = MyColor.HintColor
	pnl.AddView(Icon,0,0,40dip,pnl.Height)
	
	
	''''Edit Text
	
	Edttxt = CreateEditText("Edt")
	Edttxt.TextColor = MyColor.txtColor
	Edttxt.TextSize = MyInt.TextSize
	#if B4A
	Edttxt.SetTextAlignment("CENTER","LEFT")
	#end if
	#if B4i
	Edttxt.SetColorAndBorder(xui.Color_Transparent,1dip,MyColor.BackGroundColor,0)
	#Else
	Edttxt.SetColorAndBorder(xui.Color_Transparent,0,xui.Color_Transparent,0)
	#End If
	pnl.AddView(Edttxt,Icon.Width,0,pnl.Width-(Icon.Width*2),pnl.Height)

	
	''''Label Hint
	LblHint = CreateLabel("")
	LblHint.TextColor = MyColor.HintColor
	LblHint.TextSize = MyInt.TextSize
	LblHint.Text = Hint
	LblHint.SetTextAlignment("CENTER","LEFT")
	pnl.AddView(LblHint,Edttxt.Left+5dip,Edttxt.Top,Edttxt.Width-10dip,Edttxt.Height)
	Edttxt.BringToFront
	
	''''Border
	Border = xui.CreatePanel("")
	Border.SetColorAndBorder(MyColor.HintColor,0,0,MyInt.CornerRadius+MyInt.BorderWidth)
	mBase.AddView(Border,pnl.Left-MyInt.BorderWidth,pnl.Top-MyInt.BorderWidth,pnl.Width+bord,pnl.Height+bord)
	Border.SendToBack
	
	''''ActiveBorder
	BorderActive = xui.CreatePanel("")
	BorderActive.SetColorAndBorder(MyColor.ActiveColor,0,0,MyInt.CornerRadius+MyInt.BorderWidth)
	Border.AddView(BorderActive,(Border.Width/2)-2dip,0,4dip,Border.Height)
	BorderActive.Visible = False
	
	''''Icon Active
	IconActive=CreateLabel("Icon")
	IconActive.Font = myfont
	#if B4A Or B4i
	IconActive.Text = Chr(0xF002)
	#else
	IconActive.Text = Chr(0xF002)
	#End If
	IconActive.SetTextAlignment("CENTER","CENTER")
	IconActive.TextColor = MyColor.ActiveColor
	pnl.AddView(IconActive,Icon.Left,Icon.Top,Icon.Width,Icon.Height)
	IconActive.Visible = False
	
	If PasswordMode Then
		#if B4A Or B4i
		''''IconPass
		IconPass = CreateLabel("IconPass")
		IconPass.Font = myfont
		IconPass.Text = Chr(0xF070)
		IconPass.SetTextAlignment("CENTER","CENTER")
		IconPass.TextColor = MyColor.ActiveColor
		pnl.AddView(IconPass,pnl.Width-40dip,0,40dip,pnl.Height)
		#end if
	Else
''''Icon Delete
		IconDlt=CreateLabel("IconDlt")
		IconDlt.Font = xui.CreateMaterialIcons(MyInt.IconSize)
		IconDlt.Text = Chr(0xE14C)
		IconDlt.SetTextAlignment("CENTER","CENTER")
		IconDlt.TextColor = MyColor.IconDeleteColor
		pnl.AddView(IconDlt,pnl.Width-40dip,0,40dip,pnl.Height)
		IconDlt.Visible = False
	End If

	

	
End Sub

#If B4A Or B4i
Private Sub IconPass_Click


	If IconPass.Text = Chr(0xF070) Then
		IconPass.Text = Chr(0xF06E)
		IconPass.TextSize = MyInt.IconSize
		Edttxt = pass(False)
		
	Else
		IconPass.Text = Chr(0xF070)
		IconPass.TextSize = MyInt.IconSize
		
		Edttxt = pass(True)
	End If

End Sub


Private Sub pass(password As Boolean) As B4XView
	
	edt.PasswordMode = password

	Return edt
	
End Sub
#End If

#If B4J
Private Sub Edt_Action
#Else If B4i
Private Sub Edt_BeginEdit '<---------------Here----------
#Else If B4A
Private Sub Edt_EnterPressed
#End If

	If xui.SubExists(mCallBack,mEventName&"_EnterPressed",0) Then
		CallSub(mCallBack,mEventName&"_EnterPressed")
	End If
	
End Sub

#If B4A Or B4J
Private Sub Edt_FocusChanged (HasFocus As Boolean)
	
	If xui.SubExists(mCallBack,mEventName&"_FocusChanged",1) Then
		CallSub2(mCallBack,mEventName&"_FocusChanged",HasFocus)
	End If
	
	If HasFocus Then AnimRaft Else AnimBargasht
	
End Sub

#Else

'Enable or disable the search view
Public Sub Activate(Active As Boolean)
	If Active Then AnimRaft Else AnimBargasht
End Sub

#End if

Private Sub Edt_TextChanged (Old As String, New As String)
	
	If PasswordMode = False And IconDlt.IsInitialized Then
		If New.Length > 0 And IconDlt.Visible = False Then
			IconDlt.SetVisibleAnimated(400,True)
		Else if New.Length = 0 Then
			 IconDlt.SetVisibleAnimated(400,False)
		End If
	End If
	
	If xui.SubExists(mCallBack,mEventName&"_TextChanged",2) Then
		CallSub3(mCallBack,mEventName&"_TextChanged",Old,New)
	End If
	
End Sub

''''Animation
Private Sub AnimRaft As ResumableSub
	
	isActive=True
	
	IconActive.SetVisibleAnimated(500,True)
	If LblHint.Visible Then
		LblHint.SetVisibleAnimated(500,False)
		LblHint.SetTextSizeAnimated(500,MyInt.TextSize/4)
	End If
	
	BorderActive.SetLayoutAnimated(500,0,BorderActive.Top,Border.Width,BorderActive.Height)
	BorderActive.SetVisibleAnimated(500,True)
	
	If PasswordMode = False Then
		If Not(Edttxt.Text="") Then
			IconDlt.SetVisibleAnimated(400,True)
		End If
	End If
	
	Return ""
	
End Sub

Private Sub AnimBargasht As ResumableSub
	
	isActive=False
	
	IconActive.SetVisibleAnimated(400,False)
	BorderActive.SetVisibleAnimated(500,False)
	BorderActive.SetLayoutAnimated(500,(Border.Width/2)-2dip,BorderActive.Top,4dip,BorderActive.Height)
	
	If Edttxt.Text = "" Then
		LblHint.SetVisibleAnimated(500,True)
		LblHint.SetTextSizeAnimated(500,MyInt.TextSize)
	End If
	
	If PasswordMode = False Then
		If IconDlt.Visible Then IconDlt.Visible = False
	End If
	
	Return ""
End Sub

#Region Icons Click

#if B4J
Private Sub Icon_MouseClicked (EventData As MouseEvent)
#Else
Private Sub Icon_Click
#End If

	If xui.SubExists(mCallBack,mEventName&"_ClickedIcon",0) Then
		CallSub(mCallBack,mEventName&"_ClickedIcon")
	End If

End Sub

#if B4J
Private Sub IconDlt_MouseClicked (EventData As MouseEvent)
#Else
Private Sub IconDlt_Click
#End If
	
	Edttxt.Text=""
	
End Sub

#End Region

'SETTER
#Region Setter

Public Sub SetActiveColor(Color As Int)
	MyColor.ActiveColor = Color
	IconActive.TextColor = MyColor.ActiveColor
	BorderActive.Color = MyColor.ActiveColor
	#if b4A Or B4i
	IconPass.TextColor = MyColor.ActiveColor
	#End If
End Sub

Public Sub SetBackgroundColor(Color As Int)
	MyColor.BackGroundColor =Color
	pnl.Color = MyColor.BackGroundColor
	
	#if B4i
	Edttxt.SetColorAndBorder(xui.Color_Transparent,1dip,MyColor.BackGroundColor,0)
	#End If
End Sub

Public Sub SetTextColor(TextColor As Int)
	MyColor.txtColor=TextColor
	Edttxt.TextColor = MyColor.txtColor
End Sub

Public Sub SetTextSize(txtsize As Int)
	MyInt.TextSize = txtsize
	Edttxt.TextSize = MyInt.TextSize
	If LblHint.Visible Then
		LblHint.TextSize = MyInt.TextSize
	End If
End Sub

Public Sub SetHintColor(color As Int)
	MyColor.HintColor=color
	LblHint.TextColor = MyColor.HintColor
	Border.Color = MyColor.HintColor
	If BorderActive.Visible = False Then
		Icon.TextColor = MyColor.HintColor
	End If
End Sub

Public Sub SetHint(Hinttxt As String)
	Hint = Hinttxt
	LblHint.Text = Hint
End Sub

Public Sub SetIconSize(size As Int)
	MyInt.IconSize = size
	Icon.TextSize = MyInt.IconSize
	IconActive.TextSize = MyInt.IconSize
End Sub

Public Sub SetIconDeleteColor(IconeColor As Int)
	MyColor.IconDeleteColor = IconeColor
	If PasswordMode=False Then
		IconDlt.TextColor = MyColor.IconDeleteColor
	End If
End Sub

Public Sub SetCornerRadius(CornerRadii As Int)
	MyInt.CornerRadius = CornerRadii
	pnl.SetColorAndBorder(MyColor.BackGroundColor,0,0,MyInt.CornerRadius)
	Border.SetColorAndBorder(MyColor.HintColor,0,0,MyInt.CornerRadius+MyInt.BorderWidth)
	BorderActive.SetColorAndBorder(MyColor.ActiveColor,0,0,MyInt.CornerRadius+MyInt.BorderWidth)
End Sub

Public Sub SetFont(Fonts As B4XFont)
	Fonte = Fonts
	LblHint.Font = Fonte
	Edttxt.Font = Fonte
	
	LblHint.TextSize = MyInt.TextSize
	Edttxt.TextSize = MyInt.TextSize
End Sub

Public Sub SetIconFont(Fonts As B4XFont)
	FontIcon = Fonts
	Icon.Font = FontIcon
	IconActive.Font = FontIcon
	
	Icon.TextSize = MyInt.IconSize
	IconActive.TextSize = MyInt.IconSize
End Sub

Public Sub SetIcon(Icons As String)
	TextIcon = Icons
	Icon.Text = TextIcon
	IconActive.Text = TextIcon
End Sub

#End Region

'	Private IconSize As Int
'GETTER
#Region GETTER

#if b4A
Public Sub GetNativeEditText As EditText
	Return Edttxt
End Sub
#Else
Public Sub GetNativeTextField As TextField
	Return Edttxt
End Sub
#End If

Public Sub GetText As String
	Return Edttxt.Text
End Sub

Public Sub GetActiveColor As Int
	Return MyColor.ActiveColor
End Sub

Public Sub GetBackgroundColor As Int
	Return MyColor.BackGroundColor
End Sub

Public Sub GetTextColor As Int
	Return MyColor.txtColor
End Sub

Public Sub GetTextSize As Int
	Return MyInt.TextSize
End Sub

Public Sub GetHintColor As Int
	Return MyColor.HintColor
End Sub

Public Sub GetIconSize As Int
	Return MyInt.IconSize
End Sub

#End Region