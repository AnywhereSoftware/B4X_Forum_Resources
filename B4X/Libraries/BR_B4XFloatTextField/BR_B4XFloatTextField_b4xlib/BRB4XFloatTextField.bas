B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.78
@EndOfDesignText@
#DesignerProperty: Key: HintColor, DisplayName: Focused Hint Color, FieldType: Color, DefaultValue: 0xFF0070E0
#DesignerProperty: Key: NonFocusedHintColor, DisplayName: Non Focused Hint Color, FieldType: Color, DefaultValue: 0xFFC4C4C4
#DesignerProperty: Key: Hint, DisplayName: Hint Text, FieldType: String, DefaultValue: Hint

'ADD--------------------------------------------------------------------------------------

'#DesignerProperty: Key: TypeLeadingIcon, DisplayName: Type Leading Icon, FieldType: String, DefaultValue: No Icon, List: No Icon|MaterialIcons|FontAwesome	
'#DesignerProperty: Key: TextLeadingIcon, DisplayName: Text Leading Icon, FieldType: String, DefaultValue: ,Description: Paste Text Leading Icon
'#DesignerProperty: Key: SizeLeadingIcon, DisplayName: Size Leading Icon, FieldType: int, DefaultValue: 20, Description: Size Leading Icon
'#DesignerProperty: Key: ColorLeadingIcon, DisplayName: Color Leading Icon, FieldType: Color, DefaultValue: 0xFFC4C4C4, Description: Color Leading Icon

#DesignerProperty: Key: BackgroundColorOnFocus, DisplayName: BackgroundColorOnFocus, FieldType: Color, DefaultValue: 0x64FFFFFF, Description: BackGround Color On Focus
#DesignerProperty: Key: BackgroundColorOffFocus, DisplayName: BackgroundColorOffFocus, FieldType: Color, DefaultValue: 0x64FFFFFF, Description: BackGround Color Off Focus

#DesignerProperty: Key: ColorBorderOnFocus, DisplayName: ColorBorderOnFocus, FieldType: Color, DefaultValue: 0xFF0070E0, Description: Color Border On Focus
#DesignerProperty: Key: ColorBorderOffFocus, DisplayName: ColorBorderOffFocus, FieldType: Color, DefaultValue: 0xFFC4C4C4, Description: Color Border Off Focus

#DesignerProperty: Key: SizeBorderOnFocus, DisplayName: SizeBorderOnFocus, FieldType: Int, DefaultValue: 2, Description: Size Border On Focus
#DesignerProperty: Key: SizeBorderOffFocus, DisplayName: SizeBorderOffFocus, FieldType: Int, DefaultValue: 1, Description: Size Border Off Focus

#DesignerProperty: Key: RadiusBorderOnFocus, DisplayName: RadiusBorderOnFocus, FieldType: Int, DefaultValue: 5, Description: Radius Border On Focus
#DesignerProperty: Key: RadiusBorderOffFocus, DisplayName: RadiusBorderOffFocus, FieldType: Int, DefaultValue: 5, Description: Radius Border Off Focus

#DesignerProperty: Key: HintUpper, DisplayName: Hint Upper, FieldType: Boolean, DefaultValue: False, Description: Hint Upper
#DesignerProperty: Key: HintPositionUpper, DisplayName: Hint Position Upper, FieldType: String, DefaultValue: Filled, List: Filled|OutLine|OutLine Left|OutLine Center|OutLine Right|Upper Left|Upper Center|Upper Right, Description: Hint Position Upper

#DesignerProperty: Key: TextAlignmentVertical, DisplayName: Text Alignment Vertical, FieldType: String, DefaultValue: Filled, List: TOP|CENTER|BOTTOM ,DefaultValue: CENTER, Description:
#DesignerProperty: Key: TextAlignmentHorizontal, DisplayName: Text Alignment Horizontal, FieldType: String, DefaultValue: Filled, List: LEFT|CENTER|RIGHT ,DefaultValue: LEFT, Description:




'ADD--------------------------------------------------------------------------------------

#DesignerProperty: Key: PasswordField, DisplayName: Password Field, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: Multiline, DisplayName: Multiline, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: ShowClear, DisplayName: Show Clear Button, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: ShowAccept, DisplayName: Show Accept Button, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: ShowRevealButton, DisplayName: Show Reveal Button, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: KeyboardType, DisplayName: Keyboard Type, FieldType: String, List: Text|Numbers|Decimal, DefaultValue: Text

'ADD----
#DesignerProperty: Key: Mask, DisplayName: Mask, FieldType: String, DefaultValue: None, List: None|Left|Right, Description: Where to start the mask.
#DesignerProperty: Key: MaskText, DisplayName: MaskText, FieldType: String, DefaultValue: XXX.XXX.XXX-XX, Description: Mask format use X or 0 to indicate the characters that will be replaced.
'ADD----

#Event: EnterPressed
#Event: TextChanged (Old As String, New As String)
#Event: FocusChanged (HasFocus As Boolean)
#Event: PasswordRevealChanged (Revealed As Boolean)





Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private mTextField As B4XView
	Private mPaneBackGround As B4XView
	
	#IF B4A
		Private mImageViewBackGround As Panel
	#ELSE
		Private mImageViewBackGround As B4XView
	#END IF
	
	Public AnimationDuration As Int = 200
	Public LargeLabelTextSize = 15, SmallLabelTextSize = 13 As Float'--->update
	Private LargeLabel As Boolean
	Private MeasuringCanvas As B4XCanvas
	Public HintColor As Int
	Public NonFocusedHintColor As Int
	Private HintImageView As B4XView
	Public HintText As String
	'Public HintFont As B4XFont
	Public HintFontFocused As B4XFont'--->update
	Public HintFontNotFocused As B4XFont'--->update
	'ADD----
	
	
	Public TextAlignmentVertical As String
	Public TextAlignmentHorizontal As String
	
	Public BackgroundColorOnFocus As Int
	Public BackgroundColorOffFocus	 As Int
	Public ColorBorderOnFocus As Int
	Public ColorBorderOffFocus As Int
	Public SizeBorderOnFocus As Double
	Public SizeBorderOffFocus As Double
	Public RadiusBorderOnFocus As Double
	Public RadiusBorderOffFocus As Double
	Private HintPositionUpper As String
	Public HintUpper As Boolean
	Public TopOutLine As Double
	Private Mask As String
	Private MaskText As String
	'ADD----
	Private LargeFocused, LargeNotFocused, SmallFocused, SmallNotFocused As B4XBitmap
	Public Focused As Boolean
	Public lblClear As B4XView
	Public lblV As B4XView
	Private mProps As Map
	Public Tag As Object
	Private KeyboardType As String 'ignore
	Private Multiline As Boolean
	Private mNextTextField As BRB4XFloatTextField
	#if B4A
	Private IME As IME
	#End If
	#if B4J
	Private ToolTip As String
	#End If
	'Public HintLabelLargeOffsetX, HintLabelSmallOffsetY = 2dip, HintLabelSmallOffsetX = 2dip As Int
	Public HintLabelLargeOffsetX, HintLabelSmallOffsetY = 8dip, HintLabelSmallOffsetX = 7dip As Int'--->update
	Public TextFieldsetX = 0dip As Int'--->update
	Private LastSwitchTextFieldTime As Long
	
	
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	'If xui.IsB4A Then
	'	HintLabelLargeOffsetX = 6dip
	'Else
		HintLabelLargeOffsetX = 12dip
	'End If
	#if B4A
	IME.Initialize("ime")
	#end if
	#if B4J AND DEBUG
	Dim jo As JavaObject = Me
	jo.RunMethod("RemoveWarning", Null)
	#end if
End Sub

Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	mProps = Props
	
	Dim PassedLabel As B4XView = lbl
	Dim iv As ImageView
	iv.Initialize("HintImageView")
	HintImageView = iv
	KeyboardType = Props.GetDefault("KeyboardType", "Text")
	#if B4J
	ToolTip = lbl.TooltipText
	Dim jo As JavaObject = HintImageView
	jo.RunMethod("setMouseTransparent", Array(True))
	#End If
	HintColor = xui.PaintOrColorToColor(Props.Get("HintColor"))
	NonFocusedHintColor = xui.PaintOrColorToColor(Props.Get("NonFocusedHintColor"))
	
	HintText = Props.Get("Hint")
	'HintFont = PassedLabel.Font
	#If B4A
		HintFontFocused = xui.CreateDefaultBoldFont(lbl.TextSize-2dip)'--->update
		HintFontNotFocused = xui.CreateDefaultFont(lbl.TextSize)'--->update
	#Else
		HintFontFocused = xui.CreateDefaultBoldFont(lbl.Font.Size-2dip)'--->update
		HintFontNotFocused = xui.CreateDefaultFont(lbl.Font.Size)'--->update
	#End If
	
	
	'ADD----
	
	TextAlignmentVertical = Props.Get("TextAlignmentVertical")
	TextAlignmentHorizontal = Props.Get("TextAlignmentHorizontal")
	
	BackgroundColorOnFocus = xui.PaintOrColorToColor(Props.Get("BackgroundColorOnFocus"))
	BackgroundColorOffFocus = xui.PaintOrColorToColor(Props.Get("BackgroundColorOffFocus"))
	ColorBorderOnFocus = xui.PaintOrColorToColor(Props.Get("ColorBorderOnFocus"))
	ColorBorderOffFocus = xui.PaintOrColorToColor(Props.Get("ColorBorderOffFocus"))
	SizeBorderOnFocus = Props.Get("SizeBorderOnFocus")*1dip
	SizeBorderOffFocus = Props.Get("SizeBorderOffFocus")*1dip
	RadiusBorderOnFocus = Props.Get("RadiusBorderOnFocus")*1dip
	RadiusBorderOffFocus = Props.Get("RadiusBorderOffFocus")*1dip
	HintPositionUpper = Props.Get("HintPositionUpper")
	HintUpper = Props.Get("HintUpper")
	
	If HintPositionUpper.Contains("OutLine") Then
		HintLabelSmallOffsetY = 0dip
		HintLabelSmallOffsetX = 15dip
		TopOutLine = 5dip
	End If
	
	If HintPositionUpper.Contains("Upper") Then
		HintLabelSmallOffsetY = 0dip
		HintLabelSmallOffsetX = 7dip
		TopOutLine = 14dip
	End If
	
	Mask = Props.GetDefault("Mask","")
    MaskText = Props.GetDefault("MaskText","")
	'ADD----
	
	Dim PasswordMode As Boolean = Props.GetDefault("PasswordField", False)
	Multiline = Props.GetDefault("Multiline", False)
	If PasswordMode And Multiline Then
		Multiline = False
		Log("Multiline not supported with password mode.")
	End If
	CreateTextFieldAll(PasswordMode, PassedLabel.Font, xui.PaintOrColorToColor(lbl.TextColor))
	
	mBase.AddView(HintImageView, 0, 0, 0, 0)
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	MeasuringCanvas.Initialize(p)
	Update
	If PasswordMode And Props.GetDefault("ShowRevealButton", False) Then
		CreateRevealButton
	Else
		CreateClearButton
	End If
	CreateAcceptButton
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub UpdateTextFieldBackground(Width As Double)'--->update
	
	'Log("UpdateTextFieldBackground:"&text )
	'Log("HintPositionUpper:"&HintPositionUpper )
	'Log("Focused:"&Focused )
	'Log("HintUpper:"&HintUpper )
	'Log("Width:"&HintImageView.Width )
	
	Dim HeightBackground As Double = mImageViewBackGround.Height
	Dim WidthBackground As Double = mImageViewBackGround.Width
	'Dim Width As Double = HintImageView.Width
	
	If HintPositionUpper.Contains("OutLine") Then
		mPaneBackGround.Visible=False
		If Focused Then
			Dim bc As BitmapCreator
			bc.Initialize(WidthBackground,HeightBackground)
			bc.DrawRectRounded(bc.TargetRect,ColorBorderOnFocus,False,SizeBorderOnFocus,RadiusBorderOnFocus)
			Dim r As B4XRect
			'r.Initialize(10dip,0,HintImageView.Width+20dip,SizeBorderOnFocus)
			If HintPositionUpper.Contains("Center") Then
				r.Initialize(   WidthBackground/2 -Width/2 - 5dip ,0,   WidthBackground/2 + Width/2 + 5dip   ,SizeBorderOnFocus)
			Else If HintPositionUpper.Contains("Right") Then
				r.Initialize(WidthBackground-Width-20dip, 0,WidthBackground-10dip,SizeBorderOnFocus)
			Else
				r.Initialize(10dip,0,Width+20dip,SizeBorderOnFocus)
			End If
			
			bc.DrawRect(r,xui.Color_Transparent,True,0)
			Dim bmp As B4XBitmap = bc.Bitmap
			#IF B4A
				mImageViewBackGround.SetBackgroundImage(bmp)
			#ELSE
				mImageViewBackGround.SetBitmap(bmp)
			#END IF
			
		Else
			Dim bc As BitmapCreator
			bc.Initialize(WidthBackground,HeightBackground)
			bc.DrawRectRounded(bc.TargetRect,ColorBorderOffFocus,False,SizeBorderOffFocus,RadiusBorderOffFocus)
			'If HintUpper Or text.Trim.Length>0 Then
			If HintUpper Or mTextField.text.Length>0 Then
				Dim r As B4XRect
				'r.Initialize(10dip,0,HintImageView.Width+20dip,SizeBorderOffFocus)
				If HintPositionUpper.Contains("Center") Then
					r.Initialize(   WidthBackground/2 - Width/2 - 5dip ,0,   WidthBackground/2 + Width/2 + 5dip   ,SizeBorderOffFocus)
				Else If HintPositionUpper.Contains("Right") Then
					r.Initialize(WidthBackground-Width-20dip, 0,WidthBackground-10dip,SizeBorderOffFocus)
				Else
					r.Initialize(10dip,0,Width+20dip,SizeBorderOffFocus)
				End If
				bc.DrawRect(r,xui.Color_Transparent,True,0)
			End If
			Dim bmp As B4XBitmap = bc.Bitmap
			#IF B4A
				mImageViewBackGround.SetBackgroundImage(bmp)
			#ELSE
				mImageViewBackGround.SetBitmap(bmp)
			#END IF
		End If
	Else
		mImageViewBackGround.Visible=False
		
		If Focused Then
			mPaneBackGround.SetColorAndBorder(BackgroundColorOnFocus,SizeBorderOnFocus,ColorBorderOnFocus,RadiusBorderOnFocus)
		Else
			mPaneBackGround.SetColorAndBorder(BackgroundColorOffFocus,SizeBorderOffFocus,ColorBorderOffFocus,RadiusBorderOffFocus)
		End If
	End If
End Sub

Private Sub CreatePaneBackGround'--->update

	If Not(mPaneBackGround.IsInitialized) Then
		#IF B4J
		Dim pn As Pane
	#ELSE
		Dim pn As Panel
	#END IF
		pn.Initialize("pn")
		mPaneBackGround = pn
		mBase.AddView(mPaneBackGround, 0, TopOutLine, mBase.Width, mBase.Height-TopOutLine)
	End If
	
	

	If Not(mImageViewBackGround.IsInitialized) Then
		#IF B4A
			Dim iv As Panel
		#ELSE
			Dim iv As ImageView
		#END IF
		
		iv.Initialize("iv")
		mImageViewBackGround = iv
		mBase.AddView(mImageViewBackGround, 0, TopOutLine, mBase.Width, mBase.Height-TopOutLine)
	End If
	
	
	'UpdateTextFieldBackground("")
End Sub

Private Sub CreateTextFieldAll (PasswordMode As Boolean, Font1 As B4XFont, TextColor As Int)
	CreatePaneBackGround'--->update
	mTextField = CreateTextField (PasswordMode)
	mTextField.Font = Font1
	mTextField.TextColor = TextColor
	mTextField.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	
	
	
	
'	#if B4J 
'		Dim TextAlignment As String = TextAlignmentVertical
'		If Not(TextAlignmentVertical=TextAlignmentHorizontal) Then TextAlignment=TextAlignment&"_"&TextAlignmentHorizontal
'		Dim jo1 = mTextField As JavaObject
'	Log("TextAlignment:"&TextAlignment)
'		jo1.RunMethod("setAlignment", Array As Object(TextAlignment))
'	#Else
'		mTextField.SetTextAlignment( TextAlignmentVertical , TextAlignmentHorizontal )
'	#End If
   
   
   
	SetTextAlignment( TextAlignmentVertical , TextAlignmentHorizontal )
  
	
	setNextField(mNextTextField)
	mBase.AddView(mTextField, 0, 0, 0, 0)
End Sub

Private Sub CreateClearButton
	If mProps.GetDefault("ShowClear", True) = False Then Return
	If lblClear.IsInitialized And lblClear.Parent.IsInitialized Then lblClear.RemoveViewFromParent
	lblClear = CreateButton(Chr(0xE14C))
	lblClear.Tag = "clear"
End Sub

Private Sub CreateAcceptButton
	If mProps.GetDefault("ShowAccept", True) = False Then Return
	lblV = CreateButton(Chr(0xE5CA))
	lblV.Tag = "v"
End Sub


Private Sub CreateRevealButton
	lblClear = CreateButton(Chr(0xE8F4))
	lblClear.Tag = "reveal"
End Sub

Private Sub SwitchFromPasswordToRegular (ToRegular As Boolean)
	Dim text As String = mTextField.Text
	Dim textcolor As Int = mTextField.TextColor
	Dim Font1 As B4XFont = mTextField.Font
	Dim oldfield As B4XView = mTextField
	
	CreateTextFieldAll(Not(ToRegular), Font1, textcolor)
	mTextField.Text = text
	If lblClear.IsInitialized Then
		If ToRegular = False Then
			lblClear.Text = Chr(0xE8F4)
			lblClear.Tag = "reveal"
		Else
			lblClear.Tag = "hide"
			lblClear.Text = Chr(0xE8F5)
		End If
		lblClear.BringToFront
	End If
	If lblV.IsInitialized Then lblV.BringToFront
	HintImageView.BringToFront
	Base_Resize(mBase.Width, mBase.Height)
	#if B4J
	Dim tf As TextField = mTextField
	tf.SetSelection(mTextField.Text.Length, mTextField.Text.Length)
	#else if B4A
	Dim et As EditText = mTextField
	et.SelectionStart = mTextField.Text.Length
	#end if
	LastSwitchTextFieldTime = DateTime.Now
	mTextField.RequestFocus
	oldfield.RemoveViewFromParent
	#if B4A
	LastSwitchTextFieldTime = DateTime.Now + 200
	et.Enabled = False
	Sleep(50)
	et.Enabled = True
	Sleep(50)
	et.RequestFocus
	IME.ShowKeyboard(mTextField)
	#End If
	If xui.SubExists(mCallBack, mEventName & "_PasswordRevealChanged", 1) Then
		CallSubDelayed2(mCallBack, mEventName & "_PasswordRevealChanged", ToRegular)
	End If
End Sub

Private Sub CreateButton (Text As String) As B4XView
	Dim lc As Label
	lc.Initialize("lc")
	Dim x As B4XView = lc
	x = lc
	x.Font = xui.CreateMaterialIcons(20)
	x.Text = Text
	x.TextColor = mTextField.TextColor
	x.Visible = False
	x.SetTextAlignment("CENTER", "CENTER")
	mBase.AddView(x, 0, 0, 30dip, 30dip)
	Return x
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	
	If HintPositionUpper.Contains("Upper") Then 
		mTextField.SetLayoutAnimated(0, TextFieldsetX, 10dip, Width, Height-5dip)
	Else
		mTextField.SetLayoutAnimated(0, TextFieldsetX, 10dip-TopOutLine, Width, Height-5dip+TopOutLine)
	End If
	
	Dim FirstDistance As Int = 2dip
	If Multiline And xui.IsB4J Then FirstDistance = 22dip
	If lblV.IsInitialized Then
		lblV.SetLayoutAnimated(0, Width - lblV.Width - FirstDistance, TopOutLine, lblV.Width, Height-TopOutLine)
		FirstDistance = FirstDistance + lblV.Width + 2dip
	End If
	If lblClear.IsInitialized Then
		lblClear.SetLayoutAnimated(0, Width - lblClear.Width - FirstDistance, TopOutLine, lblClear.Width, Height-TopOutLine)
	End If
	UpdateLabel(mTextField.Text, True)
End Sub

Private Sub UpdateLabel (txt As String, force As Boolean)
	
	For Each lbl As B4XView In Array As B4XView(lblClear, lblV)
		If lbl.IsInitialized Then lbl.Visible = Focused And txt.Length > 0
	Next
	
	Dim GoingToLarge As Boolean = txt.Length = 0
	If GoingToLarge = LargeLabel And force = False Then Return
	Dim b As B4XBitmap
	If Focused Then
		If GoingToLarge And Not(HintUpper) And Not(Focused) Then b = LargeFocused Else b = SmallFocused'--->update
	Else
		If GoingToLarge And Not(HintUpper) And Not(Focused) Then b = LargeNotFocused Else b = SmallNotFocused'--->update
	End If
	If b.IsInitialized = False Then Return
	HintImageView.SetBitmap(b)
	
	If GoingToLarge And Not(HintUpper) And Not(Focused) Then'--->update
		HintImageView.SetLayoutAnimated (AnimationDuration, HintLabelLargeOffsetX+TextFieldsetX, (mBase.Height+TopOutLine) / 2 - b.Height / 2, b.Width, b.Height)
		LargeLabel = True
	Else
		If HintPositionUpper.Contains("Center") Then
			HintImageView.SetLayoutAnimated(AnimationDuration, mBase.Width/2 - b.Width/2 -2dip, HintLabelSmallOffsetY, b.Width, b.Height)
		Else If HintPositionUpper.Contains("Right") Then
			HintImageView.SetLayoutAnimated(AnimationDuration, mBase.Width-HintLabelSmallOffsetX-b.Width, HintLabelSmallOffsetY, b.Width, b.Height)
		Else
			HintImageView.SetLayoutAnimated(AnimationDuration, HintLabelSmallOffsetX, HintLabelSmallOffsetY, b.Width, b.Height)
		End If
		
		LargeLabel = False
	End If
	
	UpdateTextFieldBackground(b.Width)'--->update
	
End Sub

Private Sub tf_FocusChanged (HasFocus As Boolean)
	Focused = HasFocus
	UpdateLabel(mTextField.Text, True)
	If xui.SubExists(mCallBack, mEventName & "_FocusChanged", 1) Then
		If LastSwitchTextFieldTime + 100 < DateTime.Now Then
			CallSubDelayed2(mCallBack, mEventName & "_FocusChanged", Focused)
		End If
	End If
End Sub


'The possible values are:
'Vertical--> TOP, CENTER, BOTTOM.
'Horizontal--> LEFT, CENTER, RIGHT.
Public Sub SetTextAlignment(vertical As String, horizontal As String)
	
	#if B4J 
		Dim TextAlignment As String = vertical
		If Not(vertical=horizontal) Then TextAlignment=TextAlignment&"_"&horizontal
		Dim jo1 = mTextField As JavaObject
		jo1.RunMethod("setAlignment", Array As Object(TextAlignment))
	#Else
	mTextField.SetTextAlignment( vertical , horizontal )
	#End If
	
End Sub

'Call after changing the hint properties
Public Sub Update
	Dim f As B4XFont = xui.CreateFont2(HintFontNotFocused, LargeLabelTextSize)'--->update

	Dim r As B4XRect = MeasuringCanvas.MeasureText(HintText, f)
	LargeFocused = CreateBitmap(r, HintColor, f)
	LargeNotFocused = CreateBitmap(r, NonFocusedHintColor, f)
	
	f = xui.CreateFont2(HintFontFocused, SmallLabelTextSize)'--->update
	
	Dim r As B4XRect = MeasuringCanvas.MeasureText(HintText, f)
	SmallFocused = CreateBitmap(r, HintColor, f)
	SmallNotFocused = CreateBitmap(r, NonFocusedHintColor, f)
	
	
	UpdateLabel(mTextField.Text, True)
End Sub

Public Sub SetSelection(start As Int,length As Int)
	#IF B4A
		Private t As EditText = mTextField
		t.RequestFocus
		't.SelectionStart = start
		t.SetSelection(start,length)
	#ELSE
		'B4J E B4I
		Private t As TextField = mTextField
		t.RequestFocus
		t.SetSelection(start,start+length)
	#End If
	
	
End Sub

Private Sub CreateBitmap(r As B4XRect, Color As Int, Fnt As B4XFont) As B4XBitmap
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Max(1, r.Width + 2dip), Max(1, r.Height + 2dip))
	Dim c As B4XCanvas
	c.Initialize(p)
	Dim BaseLine As Int = p.Height / 2 - r.Height / 2 - r.Top
	c.DrawText(HintText, p.Width / 2, BaseLine, Fnt, Color, "CENTER")
	Dim bmp As B4XBitmap = c.CreateBitmap
	c.Release
	Return bmp
End Sub

Private Sub tf_BeginEdit
	tf_FocusChanged(True)	
End Sub

Private Sub tf_EndEdit
	tf_FocusChanged(False)
End Sub

Private Sub tf_Action
	If mNextTextField.IsInitialized And mNextTextField <> Me Then
		mNextTextField.TextField.RequestFocus
	End If
	If xui.SubExists(mCallBack, mEventName & "_EnterPressed", 0) Then
		CallSubDelayed(mCallBack, mEventName & "_EnterPressed")
	End If
End Sub


Private Sub tf_TextChanged (Old As String, New As String)
	If Mask<>"None" And (MaskText.Contains("X") Or MaskText.Contains("0"))  Then
        Dim textMasked As String = applyMask(New, MaskText, Mask)
        If New <> textMasked Then 
            mTextField.Text = textMasked
            mTextField.SelectionStart = mTextField.Text.Length
        End If        
    End If


	UpdateLabel(New, False)
	If xui.SubExists(mCallBack, mEventName & "_TextChanged", 2) Then
		CallSub3(mCallBack, mEventName & "_TextChanged", Old, New)
	End If
End Sub




'ADD--------------------------------------------------------------------------------------
Private Sub lettersAndNumbers(Text1 As String) As String
    Dim enable As String = "abcdefghijklmnopqrstuvwxyzçáãàâäéèêëíìîïóòôõöúùûüçABCDEFGHIJKLMNOPQRSTUVWXYZÁÃÀÂÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÜÇ0123456789"
    
    Dim textClear As StringBuilder
    textClear.Initialize
    For i = 0 To Text1.Length-1
        Dim c As String = Text1.CharAt(i)
        If enable.Contains(c) Then 
            textClear.Append(c)
        End If        
    Next
    Return textClear.ToString
End Sub

Private Sub applyMask(Text1 As String, Mask1 As String, Start As String) As String
    Dim textClear As String = lettersAndNumbers(Text1)
    Dim textMasked As StringBuilder
    textMasked.Initialize
    Log(textClear)
    Try
        
        'check how many zeros are in the mask -> verifica quantos zeros tem na mascara
        Dim zeros As Int = 0
        For i = 0 To (Mask1.Length-1)
            If Mask1.CharAt(i)="0" Then
                zeros = zeros + 1
            End If
        Next
        
        If zeros > 0 Then
            If IsNumber(textClear) Then
                textClear = textClear.As(Long)
            End If
        End If
        
        'if there are more zeros in the mask than characters in the text, add zeros to the text, until you get the number of zeros in the mask -> caso tem mais zeros na mascara do que caracteres no texto, adiciona zeros ao texto, até dar a quantidade de zeros da mascara
        If zeros > textClear.Length Then
            textClear = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & textClear
            textClear = textClear.SubString(textClear.Length-zeros)
        End If
        
        If Start="Left" Then
            For i = 1 To Mask1.Length
                Dim c As Char = Mask1.CharAt(i-1)
                If (c="X" And textClear.Length>0) Or (c="0" And textClear.Length>0) Then
                    Dim t As Char = textClear.CharAt(0)'get the last character -> pega o ultimo caracter
                    textClear = textClear.SubString(1)'remove the last character -> remove o ultimo caracter
                    textMasked.Append(t)
                Else
                    If c="X" Or textClear.Length=0 Then
                        Exit
                    End If
                    textMasked.Append(c)
                End If
            Next
            
        Else If Start="Right" Then
            For i = Mask1.Length To 1 Step -1
                Dim c As Char = Mask1.CharAt(i-1)
                If (c="X" And textClear.Length>0) Or (c="0" And textClear.Length>0) Then
                    Dim t As Char = textClear.CharAt(textClear.Length-1)'get the last character -> pega o ultimo caracter
                    textClear = textClear.SubString2(0,textClear.Length-1)'remove the last character -> remove o ultimo caracter
                    textMasked.Insert(0, t)
                Else
                    If c="X" Or textClear.Length=0 Then
                        Exit
                    End If
                    textMasked.Insert(0, c)
                End If
            Next
        End If
    Catch
        Log(LastException)
    End Try
    Log(textMasked.ToString)
    Return textMasked.ToString
End Sub
'ADD--------------------------------------------------------------------------------------



'Gets or sets the next field that will be focused when enter or accept button are pressed.
Public Sub getNextField As BRB4XFloatTextField
	Return mNextTextField
End Sub

Public Sub setNextField (Field As BRB4XFloatTextField)
	If Field.IsInitialized = False Then Return
	#if B4A
	If Multiline = False Then
		If Field <> Me Then 
			IME.AddHandleActionEvent(mTextField)
		End If
		Dim et As EditText = mTextField
		et.ForceDoneButton = True
	End If
	#End If
	Dim o As Object = Field
	mNextTextField = o
End Sub

Private Sub ime_HandleAction As Boolean
	tf_EnterPressed
	If mNextTextField.IsInitialized Then Return True 'don't hide the keyboard
	Return False
End Sub

Private Sub tf_EnterPressed
	tf_Action
	#if b4i
	Dim f As View = mTextField
	f.ResignFocus
	#End If
End Sub

Private Sub CreateTextField (Password As Boolean) As B4XView
	'Text|Numbers|Decimal
#if B4J
	If Multiline = False Then
		Dim tf As TextField
		If Password Then tf.InitializePassword("tf") Else tf.Initialize("tf")
		If ToolTip <> "" Then tf.TooltipText = ToolTip
		Return tf
	Else
		Dim ta As TextArea
		ta.Initialize("tf")
		ta.WrapText = True
		If ToolTip <> "" Then ta.TooltipText = ToolTip
		Return ta
	End If
#else if B4A
	Dim tf As EditText
	tf.Initialize("tf")
	tf.SingleLine = Not(Multiline)
	tf.PasswordMode = Password
	If Password Then
		If KeyboardType <> "Text" Then
			tf.InputType = Bit.Or(tf.INPUT_TYPE_NUMBERS, 16) 'TYPE_NUMBER_VARIATION_PASSWORD
		Else
			tf.InputType = Bit.Or(0x00000080, 0x00080000) 'TYPE_TEXT_FLAG_NO_SUGGESTIONS | TYPE_TEXT_VARIATION_PASSWORD
		End If
	Else
		Select KeyboardType
			Case "Numbers"
				tf.InputType = tf.INPUT_TYPE_NUMBERS
			Case "Decimal"
				tf.InputType = tf.INPUT_TYPE_DECIMAL_NUMBERS
		End Select
	End If
	Return tf

#else if B4i
	If Multiline Then
		Dim ta As TextView
		ta.Initialize("tf")
		Dim no As NativeObject = ta
		no.RunMethod("setContentInset:", Array(no.MakeEdgeInsets(0, 8, 0, 0)))
		Return ta
	Else
		Dim tf As TextField
		tf.Initialize("tf")
		tf.PasswordMode = Password
		tf.ShowClearButton = False
		tf.Autocorrect = tf.AUTOCORRECT_NO
		Select KeyboardType
			Case "Numbers"
				tf.KeyboardType = tf.TYPE_NUMBER_PAD
			Case "Decimal"
				tf.KeyboardType = tf.TYPE_NUMBERS_AND_PUNCTUATIONS
		End Select
		Return tf
	End If
#end if
End Sub

Public Sub getText As String
	Return mTextField.Text
End Sub

Public Sub setText(s As String)
	Dim old As String = mTextField.Text 'ignore
	mTextField.Text = s
	#if B4A
	If IsPaused(Me) Then tf_TextChanged(old, s)
	#Else if B4i
	tf_TextChanged (old, s)
	#end if
End Sub


Private Sub lc_Click
	Dim btn As B4XView = Sender
	Select btn.Tag
		Case "clear"
			setText("")
		Case "reveal"
			SwitchFromPasswordToRegular (True)
		Case "hide"
			SwitchFromPasswordToRegular(False)
		Case "v"
			tf_EnterPressed
			If mNextTextField.IsInitialized = False Or mNextTextField = Me Then
			#if B4A
				IME.HideKeyboard
			#else if B4J
				mTextField.Parent.RequestFocus
			#End If
			End If
	End Select
End Sub

#if B4i
Private Sub HintImageView_Click
	mTextField.RequestFocus
End Sub
#End If

#if B4J
Private Sub lc_MousePressed (EventData As MouseEvent)
	EventData.Consume
End Sub

Private Sub lc_MouseClicked(EventData As MouseEvent)
	EventData.Consume
	lc_Click
End Sub

Private Sub lc_MouseReleased(EventData As MouseEvent)
	EventData.Consume
End Sub
#End If
'Gets the native text field. It will be an EditText in B4A, a TextField or TextArea in B4J and a TextField or TextView in B4i.
Public Sub getTextField As B4XView
	Return mTextField
End Sub

'Requests focus and shows the keyboard (the keyboard feature is only relevant to B4A).
Public Sub RequestFocusAndShowKeyboard
	mTextField.RequestFocus
	#if B4A
	IME.ShowKeyboard(mTextField)
	#End If
End Sub

Public Sub RequestFocusNotShowKeyboard
	mTextField.RequestFocus
End Sub

#if DEBUG
#if JAVA
public void RemoveWarning() throws Exception{
	anywheresoftware.b4a.shell.Shell s = anywheresoftware.b4a.shell.Shell.INSTANCE;
	java.lang.reflect.Field f = s.getClass().getDeclaredField("errorMessagesForSyncEvents");
	f.setAccessible(true);
	java.util.HashSet<String> h = (java.util.HashSet<String>)f.get(s);
	if (h == null) {
		h = new java.util.HashSet<String>();
		f.set(s, h);
	}
	h.add("tf_focuschanged");
}
#End If
#End If

