B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.5
@EndOfDesignText@
'Custom View class 
#Event: ChangeValue

#DesignerProperty: Key: Min, DisplayName: Min Value, FieldType: int, Value: 0, Description: Min, DefaultValue: 0
#DesignerProperty: Key: Max, DisplayName: Max Value, FieldType: Int, Value: 10, Description: Max, DefaultValue: 10
#DesignerProperty: Key: SpinnerValue, DisplayName: Default Value, FieldType: int, DefaultValue: 0, Description: Get o Set value
#DesignerProperty: Key: StepIncremental, DisplayName: Step incremental or decremental, FieldType: int, DefaultValue: 1,MinRange: 1, Description: Get o Set value
#DesignerProperty: Key: ListPosition,  DisplayName: Position, FieldType: String,  Description: The position of the buttons on the view, List: Split Horizontal|Split Vertical|Left Horizontal|Left Vertical|Right Horizontal|Right Vertical|Top Vertical|Bottom Vertical, DefaultValue: Split Horizontal
#DesignerProperty: Key: BorderType,  DisplayName: Border type, FieldType: String,  Description: Apply a border to all elements or to each element, List: No border|All elements|Each elements, DefaultValue: No border
#DesignerProperty: Key: BorderSize, DisplayName: Border Size, FieldType: int, DefaultValue: 0
#DesignerProperty: Key: BorderColor, DisplayName: Border Color, FieldType: Color, DefaultValue: 0xFF909090
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: int, DefaultValue: 3
#DesignerProperty: Key: TypeFace,  DisplayName: Typeface, FieldType: String,  Description: If you are using FontAwesome or Material Icons, please copy and paste the CHR() code with the icon selector, List: Default|FontAwesome|Material Icons, DefaultValue: Default
#DesignerProperty: Key: MinusColor, DisplayName: Minus Color, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: MinusTextColor, DisplayName: Minus Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: MinusText, DisplayName: Minus Text, FieldType: String, DefaultValue: -
#DesignerProperty: Key: PlusColor, DisplayName: Plus Color, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: PlusTextColor, DisplayName: Plus Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: PlusText, DisplayName: Plus Text, FieldType: String, DefaultValue: +
#DesignerProperty: Key: ValueColor, DisplayName: Value Color, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: ValueTextColor, DisplayName: Value Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Private mBase As B4XView
	Private SpinnerValue As Int
	Private MinValue,MaxValue,StepIncremental As Int
	Private m_Position As String
	Private m_TypeFace As String
	Private m_MinusColor As Int
	Private m_MinusTextColor As Int
	Private m_MinusText As String
	Private m_PlusColor As Int
	Private m_PlusTextColor As Int
	Private m_PlusText As String
	Private m_ValueColor As Int
	Private m_ValueTextColor As Int
	Private m_borderType As String
	Private m_BorderSize As Int
	Private m_BorderColor As Int
	Private m_CornerRadius As Int
	Private IsSplitVertical As Boolean = False
	Private lbl_minus, lbl_value, lbl_plus As Label
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Don't call on code 
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mBase.Color = xui.Color_Transparent
	IniProps(Props)
	CreateAndSetSpinner
End Sub

Private Sub CreateAndSetSpinner
	
	Dim X,disp As Int
	If mBase.Width/(3.5) > mBase.Height Then
		X = mBase.Height
	Else
		X = mBase.Width/(3.5)
	End If
	disp=(mBase.Height-x)/2
	
	lbl_minus.Initialize("lbl_Minus")
	lbl_plus.Initialize("lbl_Plus")
	lbl_value.Initialize("lbl_value")
	
	Select m_TypeFace
		Case "FontAwesome"
			#if b4a
			lbl_minus.Typeface = Typeface.FONTAWESOME
			lbl_plus.Typeface = Typeface.FONTAWESOME
			#else if b4j
			Private fx As JFX
			lbl_minus.Font = fx.CreateFontAwesome(12)
			lbl_plus.Font = fx.CreateFontAwesome(12)
			#end if
			lbl_minus.Text = ConvertChr(m_MinusText)
			lbl_plus.Text = ConvertChr(m_PlusText)
		Case "Material Icons"
			#if b4a
			lbl_minus.Typeface = Typeface.MATERIALICONS
			lbl_plus.Typeface = Typeface.MATERIALICONS
			#else if b4j
			Private fx As JFX
			lbl_minus.Font = fx.CreateMaterialIcons(12)
			lbl_plus.Font = fx.CreateMaterialIcons(12)
			#end if
			lbl_minus.Text = ConvertChr(m_MinusText)
			lbl_plus.Text = ConvertChr(m_PlusText)
		Case "Default"
			#if b4a
			lbl_minus.Typeface = Typeface.DEFAULT_BOLD
			lbl_plus.Typeface = Typeface.DEFAULT_BOLD
			#else b4j
			'lbl_minus.Font = fx.CreateFont("Arial", 18, True, False)
			'lbl_plus.Font = fx.CreateFont("Arial", 18, True, False)
			#End If
			lbl_minus.Text = m_MinusText
			lbl_plus.Text = m_PlusText
	End Select

	
	#if b4a
	lbl_minus.Color = m_MinusColor
	lbl_minus.TextColor = m_MinusTextColor
	lbl_minus.Gravity = Gravity.CENTER
	lbl_minus.TextSize = X/4
	#Else If B4J
	Dim lm As B4XView = lbl_minus
	lm.Color = m_MinusColor
	lm.TextColor = m_MinusTextColor
	lm.SetTextAlignment("CENTER","CENTER")
	lbl_minus.TextSize = X*0.6
	#end if
	
	#if b4a
	lbl_value.Text = SpinnerValue
	lbl_value.Color = m_ValueColor
	lbl_value.TextColor = m_ValueTextColor
	lbl_value.Gravity=Gravity.CENTER
	lbl_value.TextSize = X/4
	#Else If B4J
	Dim lv As B4XView = lbl_value
	lbl_value.Text = SpinnerValue
	lv.Color = m_ValueColor
	lv.TextColor = m_ValueTextColor
	lv.SetTextAlignment("CENTER","CENTER")
	lbl_value.TextSize = X*0.6
	#end if
	
	#if b4a
	lbl_plus.Color = m_PlusColor
	lbl_plus.TextColor = m_PlusTextColor
	lbl_plus.Gravity = Gravity.CENTER
	lbl_plus.TextSize = X/4
	#Else If B4J
	Dim lp As B4XView = lbl_plus
	lp.Color = m_PlusColor
	lp.TextColor = m_PlusTextColor
	lp.SetTextAlignment("CENTER","CENTER")
	lbl_plus.TextSize = X*0.6
	#end if
	
	Dim What As String
	What = m_Position
	Select What
		Case "Split Horizontal"
			If m_borderType = "Each elements" Then
				SetElementBorder(lbl_minus, m_MinusColor, m_BorderSize, m_BorderColor, m_CornerRadius, True,False,True,False)
				SetElementBorder(lbl_value, m_ValueColor, m_BorderSize, m_BorderColor, 0, False,False,False,False)
				SetElementBorder(lbl_plus, m_PlusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,True,False,True)
			Else
				SetCornerRadius(lbl_minus,m_CornerRadius,True,False,True,False)
				SetCornerRadius(lbl_value,m_CornerRadius,False,False,False,False)
				SetCornerRadius(lbl_plus,m_CornerRadius,False,True,False,True)
			End If
			SplitHorizontal(X)

		Case "Split Vertical"
			IsSplitVertical = True
			If m_borderType = "Each elements" Then
				SetElementBorder(lbl_minus, m_MinusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,False,True,True)
				SetElementBorder(lbl_value, m_ValueColor, m_BorderSize, m_BorderColor, 0, True,True,True,True)
				SetElementBorder(lbl_plus, m_PlusColor, m_BorderSize, m_BorderColor, m_CornerRadius, True,True,False,False)
			Else
				SetCornerRadius(lbl_minus,m_CornerRadius,False,False,True,True)
				SetCornerRadius(lbl_plus,m_CornerRadius,True,True,False,False)
			End If
			#if b4a
			lbl_value.TextSize = X*0.3
			#else if b4j
			lbl_value.TextSize = x*0.75
			#end if
			SplitVertical(X)
		
		Case "Left Horizontal"
			If m_borderType = "Each elements" Then
				SetElementBorder(lbl_minus, m_MinusColor, m_BorderSize, m_BorderColor, m_CornerRadius, True,False,True,False)
				SetElementBorder(lbl_plus, m_PlusColor, m_BorderSize, m_BorderColor, 0, False,False,False,False)
				SetElementBorder(lbl_value, m_ValueColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,True,False,True)
			Else
				SetCornerRadius(lbl_minus,m_CornerRadius,True,False,True,False)
				SetCornerRadius(lbl_plus,m_CornerRadius,False,False,False,False)
				SetCornerRadius(lbl_value,m_CornerRadius,False,True,False,True)
			End If
			LeftHorizontal(X)
		
		Case "Left Vertical"
			If m_borderType = "Each elements" Then
				SetElementBorder(lbl_minus, m_MinusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,False,True,False)
				SetElementBorder(lbl_plus, m_PlusColor, m_BorderSize, m_BorderColor, m_CornerRadius, True,False,False,False)
				SetElementBorder(lbl_value, m_ValueColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,True,False,True)
			Else
				SetCornerRadius(lbl_minus,m_CornerRadius,False,False,True,False)
				SetCornerRadius(lbl_plus,m_CornerRadius,True,False,False,False)
				SetCornerRadius(lbl_value,m_CornerRadius,False,True,False,True)
			End If
			#if b4a
			lbl_value.TextSize = X/2
			#else if b4j
			lbl_value.TextSize = X
			#end if
			LeftVertical(X, disp)
			
		Case "Right Horizontal"
			If m_borderType = "Each elements" Then
				SetElementBorder(lbl_minus, m_MinusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,False,False,False)
				SetElementBorder(lbl_plus, m_PlusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,True,False,True)
				SetElementBorder(lbl_value, m_ValueColor, m_BorderSize, m_BorderColor, m_CornerRadius, True,False,True,False)
			Else
				SetCornerRadius(lbl_minus,m_CornerRadius,False,False,False,False)
				SetCornerRadius(lbl_plus,m_CornerRadius,False,True,False,True)
				SetCornerRadius(lbl_value,m_CornerRadius,True,False,True,False)
			End If
			RightHorizontal(X)
			
		Case "Right Vertical"
			If m_borderType = "Each elements" Then
				SetElementBorder(lbl_minus, m_MinusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,False,False,True)
				SetElementBorder(lbl_plus, m_PlusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,True,False,False)
				SetElementBorder(lbl_value, m_ValueColor, m_BorderSize, m_BorderColor, m_CornerRadius, True,False,True,False)
			Else
				SetCornerRadius(lbl_plus,m_CornerRadius,False,True,False,False)
				SetCornerRadius(lbl_minus,m_CornerRadius,False,False,False,True)
				SetCornerRadius(lbl_value,m_CornerRadius,True,False,False,True)
			End If
			#if b4a
			lbl_value.TextSize = X/2
			#else if b4j
			lbl_value.TextSize = X
			#end if
			RightVertical(X, disp)
			
		Case "Top Vertical"
			If m_borderType = "Each elements" Then
				SetElementBorder(lbl_minus, m_MinusColor, m_BorderSize, m_BorderColor, m_CornerRadius, True,False,False,False)
				SetElementBorder(lbl_plus, m_PlusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,True,False,False)
				SetElementBorder(lbl_value, m_ValueColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,False,True,True)
			Else
				SetCornerRadius(lbl_plus,m_CornerRadius,True,False,False,False)
				SetCornerRadius(lbl_minus,m_CornerRadius,False,False,False,True)
				SetCornerRadius(lbl_value,m_CornerRadius,False,False,True,True)
			End If
			#if b4a
			lbl_value.TextSize = X/2
			#else if b4j
			lbl_value.TextSize = X
			#end if
			TopVertical(X, disp)
		Case "Bottom Vertical"
			If m_borderType = "Each elements" Then
				SetElementBorder(lbl_minus, m_MinusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,False,True,False)
				SetElementBorder(lbl_plus, m_PlusColor, m_BorderSize, m_BorderColor, m_CornerRadius, False,False,False,True)
				SetElementBorder(lbl_value, m_ValueColor, m_BorderSize, m_BorderColor, m_CornerRadius, True,True,False,False)
			Else
				SetCornerRadius(lbl_plus,m_CornerRadius,False,False,False,True)
				SetCornerRadius(lbl_minus,m_CornerRadius,False,False,True,False)
				SetCornerRadius(lbl_value,m_CornerRadius,True,True,False,False)
			End If
			#if b4a
			lbl_value.TextSize = X/2
			#else if b4j
			lbl_value.TextSize = X
			#end if
			BottomVertical(X, disp)
		
	End Select
	
End Sub

Private Sub SplitHorizontal(x As Int)
	Dim offset As Int = GetCenteredVerticalOffset(x)
	mBase.AddView(lbl_minus, 0, offset, x + 1, x)
	mBase.AddView(lbl_plus, mBase.Width - x - 1, offset, x, x)
	mBase.AddView(lbl_value, x, offset, mBase.Width - (x * 2), x)
	If m_borderType = "All elements" Then HorizontalBorder(x)
End Sub

Private Sub SplitVertical(x As Int)
	Dim offset As Int = GetVerticalOffset(3, x)
	mBase.AddView(lbl_plus, 0, offset, mBase.Width, x)
	mBase.AddView(lbl_value, 0, offset + x, mBase.Width, x)
	mBase.AddView(lbl_minus, 0, offset + 2 * x, mBase.Width, x)
	If m_borderType = "All elements" Then VerticalBorder(x, offset)
End Sub

Private Sub LeftHorizontal(x As Int)
	Dim offset As Int = GetCenteredVerticalOffset(x)
	mBase.AddView(lbl_minus, 0, offset, x + 1, x)
	mBase.AddView(lbl_plus, x, offset, x + 1, x)
	mBase.AddView(lbl_value, x * 2, offset, mBase.Width - (x * 2), x)
	If m_borderType = "All elements" Then HorizontalBorder(x)
End Sub

Private Sub LeftVertical(x As Int, disp As Int)
	Dim offset As Int = GetVerticalOffset(2, x)', disp)
	mBase.AddView(lbl_plus, 0, offset, mBase.Width - (x * 2) + 1, x)
	mBase.AddView(lbl_minus, 0, offset + x-1, mBase.Width - (x * 2) + 2, x + 1)
	mBase.AddView(lbl_value, mBase.Width - (x * 2), offset, x * 2, x * 2)
	If m_borderType = "All elements" Then VerticalBorder(x, disp)
End Sub

Private Sub RightHorizontal(X As Int)
	Dim offset As Int = GetCenteredVerticalOffset(x)
	mBase.AddView(lbl_minus, mBase.Width - (x * 2) - 1, offset, x + 1, x)
	mBase.AddView(lbl_plus, mBase.Width - x - 1, offset, x + 1, x)
	mBase.AddView(lbl_value, 0, offset, mBase.Width - (x * 2), x)
	If m_borderType = "All elements" Then HorizontalBorder(x)
End Sub

Private Sub RightVertical(X As Int, disp As Int)
	Dim offset As Int = GetVerticalOffset(2, x)', disp)
	mBase.AddView(lbl_plus, x * 2 - 2, offset, mBase.Width - (x * 2), x + 1)
	mBase.AddView(lbl_minus, x * 2 - 2, offset + x-1, mBase.Width - (x * 2), x + 1)
	mBase.AddView(lbl_value, 0, offset, x * 2, x * 2)
	If m_borderType = "All elements" Then VerticalBorder(x, disp)
End Sub

Private Sub TopVertical(X As Int, disp As Int)
	Dim offset As Int = GetCenteredVerticalOffset(x)', disp)
	mBase.AddView(lbl_plus, x * 1.5, offset, x * 1.5, x + 1)
	mBase.AddView(lbl_minus, 0, offset, (x * 1.5) + 1, x + 1)
	mBase.AddView(lbl_value, 0, offset+x, x * 3 , x*1.5)
	If m_borderType = "All elements" Then VerticalBorder(x, disp)
End Sub

Private Sub BottomVertical(X As Int, disp As Int)
	Dim offset As Int = GetCenteredVerticalOffset(x)', disp)
	mBase.AddView(lbl_plus, x * 1.5, offset + (x * 1.5), x * 1.5, x + 1)
	mBase.AddView(lbl_minus, 0, offset + (x * 1.5), (x * 1.5) + 1, x + 1)
	mBase.AddView(lbl_value, 0, offset, x * 3 , (x*1.5)+1)
	If m_borderType = "All elements" Then VerticalBorder(x, disp)
End Sub

Private Sub HorizontalBorder(x As Int)
	Dim bPanelTop As Int = (mBase.Height - x)/2
	Dim bPanelWidth As Int = (x*2)+mBase.Width-(x*2)
	Dim bPanelHeight As Int = x
	Dim bPanel As B4XView = xui.CreatePanel("")
	bPanel.SetLayoutAnimated(0, 0, bPanelTop, bPanelWidth, bPanelHeight)
	bPanel.SetColorAndBorder(xui.Color_Transparent,m_BorderSize,m_BorderColor,m_CornerRadius)
	bPanel.Enabled = False
	mBase.AddView(bPanel,0, bPanelTop, bPanelWidth, bPanelHeight)
End Sub

Private Sub VerticalBorder(x As Int, disp As Int)
	If IsSplitVertical Then
		Dim bPanelTop As Int = (mBase.Height-(x*3))/2
		Dim bPanelWidth As Int = (x*2)+mBase.Width-(x*2)
		Dim bPanelHeight As Int = x*3
	Else
		Dim bPanelTop As Int = disp-(x/2)
		Dim bPanelWidth As Int = (x*2)+mBase.Width-(x*2)
		Dim bPanelHeight As Int = x*2
	End If
	
	Dim bPanel As B4XView = xui.CreatePanel("")
	bPanel.SetLayoutAnimated(0, 0, bPanelTop, bPanelWidth, bPanelHeight)
	bPanel.SetColorAndBorder(xui.Color_Transparent,m_BorderSize,m_BorderColor,m_CornerRadius)
	bPanel.Enabled = False
	mBase.AddView(bPanel,0, bPanelTop, bPanelWidth, bPanelHeight)
End Sub

Public Sub GetBase As B4XView
	Return mBase
End Sub

Public Sub setValue(NewValue As Int)
	SpinnerValue = NewValue
	lbl_value.Text = SpinnerValue
End Sub

Sub getValue As Int
	Return SpinnerValue
End Sub

Private Sub GetVerticalOffset(elementCount As Int, elementHeight As Int) As Int
	Return ((mBase.Height - (elementCount * elementHeight)) / 2)
End Sub

Private Sub GetCenteredVerticalOffset(elementHeight As Int) As Int
	Return (mBase.Height - elementHeight) / 2
End Sub

Private Sub IniProps(Props As Map)
	m_Position = Props.Get("ListPosition")
	m_TypeFace = Props.Get("TypeFace")
	m_MinusColor = xui.PaintOrColorToColor(Props.Get("MinusColor"))
	m_MinusTextColor = xui.PaintOrColorToColor(Props.Get("MinusTextColor"))
	m_MinusText = Props.Get("MinusText")
	m_PlusColor = xui.PaintOrColorToColor(Props.Get("PlusColor"))
	m_PlusTextColor = xui.PaintOrColorToColor(Props.Get("PlusTextColor"))
	m_PlusText = Props.Get("PlusText")
	m_ValueColor = xui.PaintOrColorToColor(Props.Get("ValueColor"))
	m_ValueTextColor = xui.PaintOrColorToColor(Props.Get("ValueTextColor"))
	m_borderType = Props.Get("BorderType")
	m_BorderSize = Props.Get("BorderSize")
	m_BorderColor = xui.PaintOrColorToColor(Props.Get("BorderColor"))
	m_CornerRadius = Props.Get("CornerRadius")
	MinValue = Props.Get("Min")
	MaxValue = Props.Get("Max")
	SpinnerValue = Props.Get("SpinnerValue")
	StepIncremental = Props.Get("StepIncremental")
End Sub

Private Sub SetCornerRadius(View As B4XView, CornerRadius As Float,TopLeft As Boolean,TopRight As Boolean,BottomLeft As Boolean,BottomRight As Boolean)
	
	'Thread starter Alexander Stolte
	'https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/
	
	#If B4I
	'https://www.b4x.com/android/forum/threads/individually-change-corner-radius-of-a-view.127751/post-800352
	View.SetColorAndBorder(View.Color,0,0,CornerRadius)
	Dim CornerSum As Int = IIf(TopLeft,1,0) + IIf(TopRight,2,0) + IIf(BottomLeft,4,0) + IIf(BottomRight,8,0)
	View.As(NativeObject).GetField ("layer").SetField ("maskedCorners", CornerSum)
	#Else If B4A
	'https://www.b4x.com/android/forum/threads/gradientdrawable-with-different-corner-radius.51475/post-322392
	Dim cdw As ColorDrawable
	cdw.Initialize(View.Color, 0)
	View.As(View).Background = cdw
	Dim jo As JavaObject = View.As(View).Background
	If View.As(View).Background Is ColorDrawable Or View.As(View).Background Is GradientDrawable Then
		jo.RunMethod("setCornerRadii", Array As Object(Array As Float(IIf(TopLeft,CornerRadius,0), IIf(TopLeft,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomLeft,CornerRadius,0), IIf(BottomLeft,CornerRadius,0))))
	End If
	#Else If B4J
	'https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/post-1008965
	Dim Corners As String = ""
	Corners = Corners & IIf(TopLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(TopRight, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomRight, CornerRadius, 0) & " "'BottomRight
	Corners = Corners & IIf(BottomLeft, CornerRadius, 0)
	CSSUtils.SetStyleProperty(View, "-fx-background-radius", Corners)
	#End If
End Sub

Private Sub SetElementBorder(mView As B4XView, Background As Int, BorderSize As Int, BorderColor As Int , CornerRadius  As Int, TopLeft As Boolean, TopRight As Boolean, BottomRight As Boolean, BottomLeft As Boolean) 'Ignore
	#if B4A
	Dim jo As JavaObject = mView
	Dim drawable As JavaObject
	drawable.InitializeNewInstance("android.graphics.drawable.GradientDrawable", Null)
	' Set Background color
	drawable.RunMethod("setColor", Array As Object(Background))
	' Set Border size
	drawable.RunMethod("setStroke", Array As Object(BorderSize, BorderColor))
	' Rounded corners: 8 values ​​for the 4 corners (TopLeft, TopRight, BottomRight, BottomLeft)
	Dim radii() As Float = Array As Float(IIf(TopLeft,CornerRadius,0), IIf(TopLeft,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(BottomLeft,CornerRadius,0), IIf(BottomLeft,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0))
	drawable.RunMethod("setCornerRadii", Array As Object(radii))
	
	jo.RunMethod("setBackground", Array(drawable))
	#Else If B4J
	Dim n_Color As String = ColorToHex(m_BorderColor)
	n_Color = "#"&n_Color.SubString(2)
	Dim Corners As String = ""
	Corners = Corners & IIf(TopLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(TopRight, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomRight, CornerRadius, 0)
	CSSUtils.SetStyleProperty(mView, "-fx-border-radius", Corners)
	CSSUtils.SetStyleProperty(mView, "-fx-border-width", m_BorderSize)
	CSSUtils.SetStyleProperty(mView, "-fx-border-color", n_Color)'m_BorderColor)
	CSSUtils.SetStyleProperty(mView, "-fx-background-radius", Corners)
	#End If
End Sub

Private Sub ConvertChr(hexString As String) As String
	Dim intValue As Int = Bit.ParseInt(hexString.SubString(2), 16)
	Dim spChar As String = $"${Chr(intValue)}"$
	Return spChar
End Sub

Private Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Return bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
End Sub

Private Sub lbl_Plus_Click
	HandlePlus
End Sub

Private Sub lbl_Minus_Click
	HandleMinus
End Sub
#if b4j
Private Sub lbl_Plus_MouseClicked (EventData As MouseEvent)
	HandlePlus
End Sub

Private Sub lbl_Minus_MouseClicked (EventData As MouseEvent)
	HandleMinus
End Sub
#end if
Private Sub HandleMinus
	If SpinnerValue - StepIncremental >= MinValue Then
		SpinnerValue = SpinnerValue - StepIncremental
		lbl_value.Text = SpinnerValue
		If SubExists(mCallBack,mEventName & "_ChangeValue") Then CallSub2(mCallBack,mEventName & "_ChangeValue", SpinnerValue)
	End If
End Sub

Private Sub HandlePlus
	If SpinnerValue + StepIncremental <= MaxValue Then
		SpinnerValue = SpinnerValue + StepIncremental
		lbl_value.Text = SpinnerValue
		If SubExists(mCallBack,mEventName & "_ChangeValue") Then CallSub2(mCallBack,mEventName & "_ChangeValue", SpinnerValue)
	End If
End Sub