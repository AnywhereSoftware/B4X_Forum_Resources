B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Version: 1.26
'Made by Ui max_co

#Event: AddSuccess (Count As Int)
#Event: DelSuccess (Count As Int)
#DesignerProperty: Key: MainColor, DisplayName: Main Color, FieldType: Color, DefaultValue: 0xFF673AB7, Description: Main color
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF3E3E3E, Description: Text color
#DesignerProperty: Key: HintTextColor, DisplayName: Hint Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Hint Text color
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 15, MinRange: 0, MaxRange: 100, Description: Text Size
#DesignerProperty: Key: HintTextSize, DisplayName: Hint Text Size, FieldType: Int, DefaultValue: 13, MinRange: 0, MaxRange: 100, Description: Btn Text Size
#DesignerProperty: Key: IconsSize, DisplayName: Icons Text Size, FieldType: Int, DefaultValue: 22, MinRange: 0, MaxRange: 100, Description: Icons Text Size
#DesignerProperty: Key: HintTxt, DisplayName: Hint Txt, FieldType: String, DefaultValue: Ui max_co
#DesignerProperty: Key: Max, DisplayName: Buy max, FieldType: Int, DefaultValue: 6, MinRange: 0, MaxRange: 300, Description: Buy max


Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
''''Xviewes
	Private PnlAddToCart As B4XView
	Private lbltxt As B4XView
	Private BtnAdd As B4XView
	Private BtnRemove As B4XView
	Private LblNumber As B4XView	
	
''''Ajza
	Private MainColor As Int
	Private TextColor As Int
	Private TextSize As Int
	Private HintTextSize As Int
	Private HintTextColor As Int
	Private IconsSize As Int
	Private HintTxt As String
	Private BuyMax As Int
	Private Counting As Int = 0
	Private Fontse As B4XFont
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
	
	Fill_variables(Props)
	Create_Xviews
End Sub

'Fill in the variables
Private Sub Fill_variables(props As Map)
	MainColor = xui.PaintOrColorToColor(props.Get("MainColor"))
	TextColor = xui.PaintOrColorToColor(props.Get("TextColor"))
	TextSize = props.Get("TextSize")
	HintTextSize = props.Get("HintTextSize")
	HintTextColor = xui.PaintOrColorToColor(props.Get("HintTextColor"))
	IconsSize = props.Get("IconsSize")
	HintTxt = props.Get("HintTxt")
	BuyMax = props.Get("Max")
	Fontse = xui.CreateDefaultFont(HintTextSize)
End Sub

Private Sub Create_Xviews
	
	mBase.SetColorAndBorder(xui.Color_Transparent,0,xui.Color_Transparent,0)
	Private ButtonsWidth As Int = mBase.Width/2.8
''''btnadd
	BtnAdd = IconAjza("BtnAdd",xui.Color_White,Chr(0xE145),MainColor,0)
	BtnAdd.Width = ButtonsWidth
	If ButtonsWidth > mBase.Height Then
		mBase.AddView(BtnAdd,mBase.Width-mBase.Height,0,mBase.Height,mBase.Height)
	Else	
		mBase.AddView(BtnAdd,mBase.Width-BtnAdd.Width,(mBase.Height/2)-(BtnAdd.Width/2),BtnAdd.Width,BtnAdd.Width)
	End If
	BtnAdd.Visible = False
	
''''Btn Remove
	BtnRemove = IconAjza("BtnRemove",MainColor,Chr(0xE15B),xui.Color_Transparent,3dip)
	mBase.AddView(BtnRemove,BtnAdd.Left,BtnAdd.Top,BtnAdd.Width,BtnAdd.Height)
	BtnRemove.Visible = False
	
''''Number
	LblNumber = TextAjza("",TextColor,TextSize,0)	
	LblNumber.Font = xui.CreateDefaultBoldFont(TextSize)
	mBase.AddView(LblNumber,BtnAdd.Left,BtnAdd.Top,BtnAdd.Width,BtnAdd.Height)
	LblNumber.Visible = False
	LblNumber.SendToBack
	BtnAdd.BringToFront
	
''''Pnl Add to cart
	PnlAddToCart = xui.CreatePanel("Pnl")
	PnlAddToCart.SetColorAndBorder(MainColor,0,0,BtnAdd.Height)
	mBase.AddView(PnlAddToCart,0,BtnAdd.Top,mBase.Width,BtnAdd.Height)
	
''''lbltxt
	lbltxt = TextAjza("Pnl",HintTextColor,HintTextSize,HintTxt)
	mBase.AddView(lbltxt,0,0,mBase.Width,mBase.Height)
	lbltxt.BringToFront
	
	#if B4i
	PnlAddToCart.SetColorAndBorder(MainColor,0,0,BtnAdd.Height/2)
	BtnAdd.SetColorAndBorder(MainColor,0,MainColor,BtnAdd.Height/2)
	BtnRemove.SetColorAndBorder(xui.Color_Transparent,2dip,MainColor,BtnAdd.Height/2)
	#End If
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	Sizes(Width,Height)
End Sub

Private Sub Sizes(Width As Double,Height As Double)
	
	Private HCenter As Int = Width/2
	
	Private ButtonsWidth As Double = Width/2.8
	
	BtnAdd.Width = ButtonsWidth
	If ButtonsWidth > Height Then
		BtnAdd.SetLayoutAnimated(0,Width-Height,0,Height,Height)
	Else
		BtnAdd.SetLayoutAnimated(0,Width-BtnAdd.Width,(Height/2)-(BtnAdd.Width/2),BtnAdd.Width,BtnAdd.Width)
	End If
	
	
	
	If PnlAddToCart.Visible = False Then
		LblNumber.SetLayoutAnimated(0,HCenter-(BtnAdd.Width/2),BtnAdd.Top,BtnAdd.Width,BtnAdd.Height)
		BtnRemove.SetLayoutAnimated(0,BtnRemove.Left,BtnAdd.Top,BtnAdd.Width,BtnAdd.Height)
	Else	
		LblNumber.SetLayoutAnimated(0,BtnAdd.Left,BtnAdd.Top,BtnAdd.Width,BtnAdd.Height)
		BtnRemove.SetLayoutAnimated(0,BtnAdd.Left,BtnAdd.Top,BtnAdd.Width,BtnAdd.Height)
	End If
	
	
	If PnlAddToCart.Visible = True Then
		PnlAddToCart.SetLayoutAnimated(0,0,BtnAdd.Top,Width,BtnAdd.Height)
	Else
		PnlAddToCart.SetLayoutAnimated(0,BtnAdd.Left,BtnAdd.Top,BtnAdd.Width,BtnAdd.Height)
	End If
	
	lbltxt.SetLayoutAnimated(0,0,0,Width,Height)
	
End Sub

Private Sub IconAjza(Event As String,textColorr As Int,Text As String,BackgroundColor As Int,BorderWidth As Int) As B4XView
	
	Private Icon As B4XView = CreateLabel(Event)
	Icon.TextColor = textColorr
	Icon.Font = xui.CreateMaterialIcons(IconsSize)
	Icon.Text = Text
	Icon.SetTextAlignment("CENTER","CENTER")
	Icon.SetColorAndBorder(BackgroundColor,BorderWidth,MainColor,100dip)
	
	Return Icon
	
End Sub

Private Sub TextAjza(event As String,TextColorr As Int,TextSizee As Int,Text As String) As B4XView
	
	Private l As B4XView = CreateLabel(event)
	l.Font = Fontse
	l.TextColor = TextColorr
	l.TextSize = TextSizee
	l.Text = Text
	l.SetTextAlignment("CENTER","CENTER")
	
	Return l
	
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

'''''Animations
#If B4J
Private Sub Pnl_MouseClicked (EventData As MouseEvent)
#Else
Private Sub Pnl_Click
#End If
	lbltxt.SetVisibleAnimated(200,False)
	BtnAdd.Visible = True
	Sleep(150)
	PnlAddToCart.SetLayoutAnimated(300,BtnAdd.Left,PnlAddToCart.Top,BtnAdd.Width,PnlAddToCart.Height)
	PnlAddToCart.SetColorAndBorder(MainColor,0,0,BtnAdd.Height/2)
	Sleep(300)
	PnlAddToCart.Visible = False
	Sleep(150)
	BtnRemove.Visible = True
	BtnRemove.SetLayoutAnimated(500,0,BtnRemove.Top,BtnRemove.Width,BtnRemove.Height)
	
	LblNumber.Visible = True
	LblNumber.SetLayoutAnimated(500,(mBase.Width/2)-(LblNumber.Width/2),LblNumber.Top,LblNumber.Width,LblNumber.Height)
	#If B4i 
	RotateViewShortestArc(BtnRemove,500,-180)
	RotateViewShortestArc(LblNumber,500,-180)
	RotateViewShortestArc(LblNumber,500,0) 'Avoid lying face up
	#Else
	BtnRemove.SetRotationAnimated(500,-360)
	LblNumber.SetRotationAnimated(500,-360)
	#End If
	
 	#if B4J
	BtnAdd_MousePressed(Null)
	#else
	BtnAdd_Click
 	#End If
End Sub

#if B4i
Private Sub RotateViewShortestArc (v As B4XView, Duration As Int, Target As Int)
	Dim Rotation As Int = v.Rotation
	Dim dx As Int = (Target - Rotation) Mod 360 
	If dx > 180 Then
		dx = -(360 - dx)
	Else if dx < -180 Then
		dx = 360 + dx
	End If
	v.SetRotationAnimated(Duration, Rotation + dx)
End Sub
#end if

#If B4J
Private Sub BtnAdd_MousePressed (EventData As MouseEvent)
#Else	
Private Sub BtnAdd_Click
#end if
	
	If Counting = BuyMax Then
		Log("Buy MAX")
		Return
	End If
	
	Counting = Counting+1
	LblNumber.Text = Counting
	
	If xui.SubExists(mCallBack,mEventName&"_AddSuccess",1) Then
	CallSub2(mCallBack,mEventName&"_AddSuccess",Counting)
	End If
End Sub

#If B4J
Private Sub BtnRemove_MousePressed (EventData As MouseEvent)
#Else	
Private Sub BtnRemove_Click
#END If
	
	If Counting = 1 Then
		AnimBargasht
	End If
	
	Counting = Counting-1
	LblNumber.Text = Counting
	
	If xui.SubExists(mCallBack,mEventName&"_DelSuccess",1) Then
		CallSub2(mCallBack,mEventName&"_DelSuccess",Counting)
	End If
End Sub

Private Sub AnimBargasht As ResumableSub
	BtnRemove.SetLayoutAnimated(400,BtnAdd.Left,BtnAdd.Top,BtnAdd.Width,BtnAdd.Height)
	
	LblNumber.SetLayoutAnimated(400,BtnAdd.Left,LblNumber.Top,LblNumber.Width,LblNumber.Height)
	
	#if B4i
	RotateViewShortestArc(BtnRemove,400,0)
	RotateViewShortestArc(LblNumber,400,0)
	#else
	BtnRemove.SetRotationAnimated(400,0)
	LblNumber.SetRotationAnimated(400,0)
	#End If

	Sleep(650)
	
	PnlAddToCart.Visible = True
	PnlAddToCart.SetLayoutAnimated(400,0,PnlAddToCart.Top,mBase.Width,PnlAddToCart.Height)
	
	Sleep(450)
	
	lbltxt.SetVisibleAnimated(300,True)
	
	BtnAdd.Visible = False
	BtnRemove.Visible = False
	LblNumber.Visible = False
	Return ""
End Sub


'''''SETTER
#Region Setter

'Specify the number of purchases
Public Sub SetNumber(Number As Int)
	If Number > BuyMax Then
		Log("Please increase the variable (SetBuyMAX)")
		Return
	End If

	Counting = Number
	If PnlAddToCart.Visible = True Then
		Counting = Counting - 1
		#If B4J
		Pnl_MouseClicked(Null)
		#Else
		Pnl_Click
		#End If
		
	Else
		LblNumber.Text = Counting	
		If xui.SubExists(mCallBack,mEventName&"_AddSuccess",1) Then
			CallSub2(mCallBack,mEventName&"_AddSuccess",Counting)
		End If
	End If
End Sub

Public Sub SetNumberColor(NumberColor As Int)
	TextColor = NumberColor
	LblNumber.TextColor = TextColor
End Sub

Public Sub SetNumberSize(NumberSize As Int)
	TextSize = NumberSize
	LblNumber.TextSize = TextSize
End Sub

Public Sub SetIconsSize(IconSize As Int)
	IconsSize = IconSize
	BtnAdd.TextSize = IconsSize
	BtnRemove.TextSize = IconsSize
End Sub

'Determine the user's maximum purchase
Public Sub SetBuyMAX(Buy_Max As Int)
	BuyMax = Buy_Max
End Sub

Public Sub SetHintText(HintText As String)
	HintTxt = HintText
	lbltxt.Text = HintTxt
End Sub

Public Sub SetHintSize(HintSize As Int)
	
	HintTextSize = HintSize
	lbltxt.TextSize = HintTextSize
	
End Sub

Public Sub SetHintColor(HintColor As Int)
	HintTextColor = HintColor
	lbltxt.TextColor = HintTextColor
End Sub

Public Sub SetMainColor(Color As Int)
	MainColor = Color
	
	BtnAdd.Color = MainColor
	BtnRemove.SetColorAndBorder(xui.Color_Transparent,3dip,MainColor,100dip)
	BtnRemove.TextColor = MainColor
	PnlAddToCart.Color = MainColor
End Sub

Public Sub SetFont(MyFont As B4XFont)
	Fontse = MyFont
	lbltxt.Font = Fontse
	lbltxt.TextSize = HintTextSize
End Sub

#End Region


''''GETTER
#Region Getter

Public Sub GetNumber As Int
	Return Counting
End Sub

Public Sub GetHintText As String
	Return HintTxt
End Sub

#if B4A Or B4I
Public Sub GetNativePanel As Panel
	Return PnlAddToCart
End Sub
#End If

#if B4J
Public Sub GetNativePane As Pane
	Return PnlAddToCart
End Sub
#End If


#End Region