B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Add Designer Property LeadingIcon - An icon which is placed in front of the text and has its own click event
	-Add Designer Property TrailingIcon - An icon which is placed behind the text and has its own click event
	-Add Event LeadingIconClick
	-Add Event TrailingIconClick
	-Add some more properties
V1.02
	-Add Type ASTextFieldAdvanced_Title
	-Add Type ASTextFieldAdvanced_Information
	-Add Type ASTextFieldAdvanced_Counter
	-Add Type ASTextFieldAdvanced_Hint
	-Add Type ASTextFieldAdvanced_LeadingIcon
	-Add Type ASTextFieldAdvanced_TrailingIcon
	-Removed seome properties, they are now in the new types
	-BugFixes
V1.03
	-Add Type ASTextFieldAdvanced_Prefix
	-Add Type ASTextFieldAdvanced_Suffix
	-Add Designer Properties Prefix, PrefixText, Suffix, SuffixText
	-Add get TextFull - Gets the full text, with Prefix and Suffix
	-BugFixes
V1.04
	-BugFixes
V1.05
	-BugFixes
V1.06
	-BugFixes
	-Add Designer Property ReadOnly - Disables the user input
		-Default: False
V1.07
	-BugFixes
	-Add "Multiline" to the designer property "Mode"
	-New Multiline mode
V1.08
	-Multiline BugFixes
V1.09
	-Add Focus - Sets input focus
V1.10
	-BugFixes
	-get Reveale is renamed to isRevealed
V1.11
	-Add Designer Property TextAlignment
		-Default: Left
V1.12
	-Add set Text2 - Sets the text, without TextChanged Event
	-Add set ButtonText2 - Sets the button text, without TextChanged Event
V1.13
	-BugFixes
V1.14
	-Add Event ClearButtonClick
V1.15
	-BugFix
V1.16
	-BugFixes
	-Performance improvements
V1.17
	-BugFixes - Character delimiter (Counter = True)
	-B4J Only - Click on the TextField to focus it
V1.18
	-BugFix - ReadOnly = True - ClearButton and RevealButton are now also read only
V1.19
	-Add FocusedShapeColor
		-Default: White with alpha 0 = Transparent
	-Add set TextColor
	-Add Designer Property TextFieldCornerRadius
		-Default: 5dip
	-B4J BugFix - The EnterPressed Event was not triggered
V1.20
	-BugFixes
	-Add Designer Property StrengthIndicator - Password strength indicator 
		-None|Line|Segmented
		-Default: None
V1.21
	-Add Designer Property RequiredField - if True the field is a required field and is marked with a colored star
		-Default: False
	-Add Designer Property RequiredFieldColor
		-Default: Red
	-Add ShowDisplayMissingField - Call this function to inform the user that not all required fields are filled in
		-Call HideDisplayMissingField to remove it
	-Add HideDisplayMissingField - Removes the user notification from ShowDisplayMissingField
	-Add Designer Property Mask - You can use masks now
		-Default: None
	-Add Designer Property MaskText
		-Example: XXX.XXX.XXX-XX
V1.22
	-Add get and set MaskText
V1.23
	-BugFixes
	-RevealButton and ClearButton TextColor - Can now also be seen in light mode
	-Add Designer Property ClearAndRevealButtonColor - is per default transparent
		-If the alpha value is set to 0, then a color that matches the background color is automatically used
	-Add Designer Property FocusedTitleTextColor
		-Default: White
	-Add Deigner Property NonFocusedTitleTextColor
		-Default: White
		-Would interfere too much with the design of already existing layouts if another white would be used
	-Add Designer Property NonFocusedShapeColor
V1.24
	-Add new Type ASTextFieldAdvanced_TextFieldProperties
		-Properties
			-FocusedShapeColor
			-NonFocusedShapeColor
			-CornerWidth - NEW
			-CornerRadius
V1.25
	-BugFixes
V1.26
	-BugFixes
V1.27
	-BugFixes
V1.28
	-Multiline TextFields supports now the clear button
	-The action button have now a fixed HeightWidth = 24dip
V1.29
	-BugFixes
V1.30
	-Add get and set LeadingWidth
	-Add get and set TrailingWidth
V1.31
	-B4A BugFix
V1.32
	-Add Designer Property CounterTextColor
		-Default: White
	-Add Designer Property InfoTextColor
		-Default: White
V1.33
	-Add Designer Property Underline - A line is visible on the textfield
		-Default: False
		-If true the ShapeColor ist used for this underline
	-Add get UnderlinePanel
V1.34
	-BugFix - If ShowRevealButton = True and PasswordField = False - Then the gap was still present at the end of the textfield
V1.35
	-BugFix - if you set the Counter or CounterMax, then one emoji is now counting as one
V1.36
	-BugFix - The hint text was only renewed if the TextField had no text
	-B4I BugFix - Readonly on Multiline did not work
V1.37
	-B4I BugFix - Readonly on Multiline did not work
V1.38
	-Breaking Change - ButtonText and ButtonText2 have been removed and now work with .Text and .Text2
		-It confuses me every time, especially when I don't know that it's a button
	-A few functions have been made private as they should not be public
	-Button Mode BugFixes
	-Add Mode "ComboBox"
	-Add Event ComboBoxSelectedIndexChanged
	-Add set SetItems
	-Add get and set SelectedIndex
V1.39
	-BugFixes
V1.40
	-Add get and set TopGap -Same as LeftGap
		-Default: 0
V1.41
	-BugFixes
	-Add Designer Property TitleMode
		-Default: Default - Above textfield
		-FloatText - Floating animation like in the B4XFloatTextField
		-BeforeTextField - Show the title before the textfield
	-Add get and set TitleWidth - Works only if the TitleMode is set to BeforeTextField. The Text width of the title
	-Add set TitleWidthAll - Sets the width value for all textfields on the parent
	-Add HorizontalAlignment to the ASTextFieldAdvanced_Title type
		-Default: LEFT
	-Add get and set Underline - Show or hide the underline programmatically
	-Add IndexOf - ComboBox - Returns the index of the item with the given value. Returns -1 if not found.
	-Add get ComboBox - Gets the B4XComboBox
	-Add OpenComboBox
	-Add Event TitleClick
V1.42
	-BugFixes
V1.43
	-BugFix ReadOnly on Multiline
V1.44
	-BugFix
V1.45
	-New get OldText - Returns the text that was there before
V1.46
	-BugFix on Multiline
#End If

#DesignerProperty: Key: Mode, DisplayName: Mode, FieldType: String, DefaultValue: TextField, List: TextField|Button|Multiline|ComboBox
#DesignerProperty: Key: TextAlignment, DisplayName: TextAlignment, FieldType: String, DefaultValue: Left, List: Left|Center|Right
#DesignerProperty: Key: TextFieldCornerRadius, DisplayName: TextFieldCornerRadius, FieldType: Int, DefaultValue: 5, MinRange: 0
#DesignerProperty: Key: ReadOnly, DisplayName: Read Only, FieldType: Boolean, DefaultValue: False

#DesignerProperty: Key: RequiredField, DisplayName: RequiredField, FieldType: Boolean, DefaultValue: False , Description: The field is a required field and is marked with a colored star
#DesignerProperty: Key: RequiredFieldColor, DisplayName: RequiredFieldColor, FieldType: Color, DefaultValue: 0xFFDD5F60

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF3C4043

#DesignerProperty: Key: PasswordField, DisplayName: Password Field, FieldType: Boolean, DefaultValue: False, Description: Example of a boolean property.
#DesignerProperty: Key: ClearAndRevealButtonColor, DisplayName: ClearAndRevealButtonColor, FieldType: Color, DefaultValue: 0x00FFFFFF
#DesignerProperty: Key: ShowClearButton, DisplayName: Show Clear Button, FieldType: Boolean, DefaultValue: True, Description: Example of a boolean property.
#DesignerProperty: Key: ShowRevealButton, DisplayName: Show Reveal Button, FieldType: Boolean, DefaultValue: True, Description: Example of a boolean property.
#DesignerProperty: Key: StrengthIndicator, DisplayName: StrengthIndicator, FieldType: String, DefaultValue: None, List: None|Line|Segmented ,Description: Password strength indicator

#DesignerProperty: Key: Underline, DisplayName: Underline, FieldType: Boolean, DefaultValue: False, Description: If true the ShapeColor ist used for this underline
#DesignerProperty: Key: FocusedShapeColor, DisplayName: FocusedShapeColor, FieldType: Color, DefaultValue: 0x00FFFFFF
#DesignerProperty: Key: NonFocusedShapeColor, DisplayName: NonFocusedShapeColor, FieldType: Color, DefaultValue: 0x00FFFFFF
#DesignerProperty: Key: FocusedHintTextColor, DisplayName: Focused Hint Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: NonFocusedHintTextColor, DisplayName: Non Focused Hint Text Color, FieldType: Color, DefaultValue: 0x64FFFFFF, Description: You can use the built-in color picker to find the color values.

#DesignerProperty: Key: KeyboardType, DisplayName: Keyboard Type, FieldType: String, DefaultValue: Text, List: Text|Numbers|Decimal

#DesignerProperty: Key: Hint, DisplayName: Hint, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: HintText, DisplayName: Hint Text, FieldType: String, DefaultValue: Hint

#DesignerProperty: Key: TitleMode, DisplayName: TitleMode, FieldType: String, DefaultValue: Default, List: Default|FloatText|BeforeTextField
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: Boolean, DefaultValue: True, Description: If True a title is visible on top.
#DesignerProperty: Key: TitleText, DisplayName: Title Text, FieldType: String, DefaultValue: Title
#DesignerProperty: Key: TitleHeight, DisplayName: Title Height, FieldType: Int, DefaultValue: 30, MinRange: 0, Description: Height in DIP
#DesignerProperty: Key: TitleWidth, DisplayName: Title Width, FieldType: Int, DefaultValue: 100, MinRange: 0, Description: Works only if the TitleMode is set to BeforeTextField. The Text width of the title
#DesignerProperty: Key: FocusedTitleTextColor, DisplayName: Title Focused Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: NonFocusedTitleTextColor, DisplayName: Title Non Focused Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: You can use the built-in color picker to find the color values.

#DesignerProperty: Key: BottomHeight, DisplayName: Bottom Height, FieldType: Int, DefaultValue: 25, MinRange: 0, Description: Height in DIP

#DesignerProperty: Key: Counter, DisplayName: Counter, FieldType: Boolean, DefaultValue: False, Description: If True a counter is visible on bottom right
#DesignerProperty: Key: CounterMax, DisplayName: Counter Max, FieldType: Int, DefaultValue: 20, MinRange: 0, Description: 5/10
#DesignerProperty: Key: CounterTextColor, DisplayName: Counter Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: Info, DisplayName: Info, FieldType: Boolean, DefaultValue: False, Description: If True a info text is visible on bottom left
#DesignerProperty: Key: InfoText, DisplayName: Info Text, FieldType: String, DefaultValue: Informations, Description: Display your info text
#DesignerProperty: Key: InfoTextColor, DisplayName: Info Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#If B4J
#DesignerProperty: Key: ToolTipText, DisplayName: Tool Tip Text, FieldType: String, DefaultValue: 
#End If

#DesignerProperty: Key: LeadingIcon, DisplayName: Leading Icon, FieldType: Boolean, DefaultValue: False, Description: An icon which is placed in front of the text and has its own click event
#DesignerProperty: Key: TrailingIcon, DisplayName: Trailing Icon, FieldType: Boolean, DefaultValue: False, Description: An icon which is placed behind the text and has its own click event

#DesignerProperty: Key: Prefix, DisplayName: Prefix, FieldType: Boolean, DefaultValue: False, Description: Prefix
#DesignerProperty: Key: PrefixText, DisplayName: Prefix Text, FieldType: String, DefaultValue: $, Description: $

#DesignerProperty: Key: Suffix, DisplayName: Suffix, FieldType: Boolean, DefaultValue: False, Description: Suffix
#DesignerProperty: Key: SuffixText, DisplayName: Suffix Text, FieldType: String, DefaultValue: @gmail.com, Description: @gmail.com

#DesignerProperty: Key: Mask, DisplayName: Mask, FieldType: String, DefaultValue: None, List: None|Left|Right, Description: Where to start the mask.
#DesignerProperty: Key: MaskText, DisplayName: MaskText, FieldType: String, DefaultValue: XXX.XXX.XXX-XX, Description: Mask format use X or 0 to indicate the characters that will be replaced.

#Event: ButtonClick
#Event: ClearButtonClick
#Event: ComboBoxSelectedIndexChanged(Index As Int)
#Event: EnterPressed
#Event: FocusChanged(HasFocus As Boolean)
#Event: LeadingIconClick
#Event: PasswordRevealChanged(Revealed As Boolean)
#Event: TextChanged(Text As String)
#Event: TitleClick
#Event: TrailingIconClick

Sub Class_Globals
	
	Type ASTextFieldAdvanced_Title(Visible As Boolean,Text As String,Height As Float,IgnoreProperties As Boolean,xFont As B4XFont,FocusedTextColor As Int,NonFocusedTextColor As Int,HorizontalAlignment As String,View As ASTextFieldAdvanced_ViewTitle)
	Type ASTextFieldAdvanced_Information(Visible As Boolean,Text As String,IgnoreProperties As Boolean,xFont As B4XFont,TextColor As Int,View As ASTextFieldAdvanced_ViewInformation)
	Type ASTextFieldAdvanced_Counter(Visible As Boolean,CounterMax As Int,IgnoreProperties As Boolean,xFont As B4XFont,TextColor As Int,View As ASTextFieldAdvanced_ViewCounter)
	Type ASTextFieldAdvanced_Hint(Visible As Boolean,Text As String,IgnoreProperties As Boolean,FocusedTextColor As Int,NonFocusedTextColor As Int,xFont As B4XFont,View As ASTextFieldAdvanced_ViewHint)
	Type ASTextFieldAdvanced_LeadingIcon(Visible As Boolean,Icon As B4XBitmap,View As ASTextFieldAdvanced_ViewLeadingIcon)
	Type ASTextFieldAdvanced_TrailingIcon(Visible As Boolean,Icon As B4XBitmap,View As ASTextFieldAdvanced_ViewTrailingIcon)
	Type ASTextFieldAdvanced_Prefix(Visible As Boolean,Text As String,IgnoreProperties As Boolean,xFont As B4XFont,TextColor As Int,Gap As Float,View As ASTextFieldAdvanced_ViewPrefixSuffix)
	Type ASTextFieldAdvanced_Suffix(Visible As Boolean,Text As String,IgnoreProperties As Boolean,xFont As B4XFont,TextColor As Int,Gap As Float,View As ASTextFieldAdvanced_ViewPrefixSuffix)
	Type ASTextFieldAdvanced_TextFieldProperties(FocusedShapeColor As Int,NonFocusedShapeColor As Int,BorderWidth As Float,CornerRadius As Float)
	
	Type ASTextFieldAdvanced_ViewHint(xlbl_Hint As B4XView)
	Type ASTextFieldAdvanced_ViewCounter(xlbl_Counter As B4XView)
	Type ASTextFieldAdvanced_ViewTitle(xlbl_Title As B4XView)
	Type ASTextFieldAdvanced_ViewInformation(xlbl_Information As B4XView)
	Type ASTextFieldAdvanced_ViewLeadingIcon(xpnl_Background As B4XView,xiv_Icon As B4XView)
	Type ASTextFieldAdvanced_ViewTrailingIcon(xpnl_Background As B4XView,xiv_Icon As B4XView)
	Type ASTextFieldAdvanced_ViewPrefixSuffix(xlbl_PrefixSuffix As B4XView)
	
	Private g_Title As ASTextFieldAdvanced_Title
	Private g_Information As ASTextFieldAdvanced_Information
	Private g_Counter As ASTextFieldAdvanced_Counter
	Private g_Hint As ASTextFieldAdvanced_Hint
	Private g_LeadingIcon As ASTextFieldAdvanced_LeadingIcon
	Private g_TrailingIcon As ASTextFieldAdvanced_TrailingIcon
	Private g_Prefix As ASTextFieldAdvanced_Prefix
	Private g_Suffix As ASTextFieldAdvanced_Suffix
	Private g_TextFieldProperties As ASTextFieldAdvanced_TextFieldProperties
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_TextFieldBackground As B4XView
	Private xtf_TextField As B4XView
	Private xtf_TextFieldPassword As B4XView
	Private xtf_Multiline As B4XView
	Private xcb_ComboBox As AS_ComboBoxIntern
	Private xlbl_Hint As B4XView
	Private xlbl_FloatingHintTitle As B4XView
	Private xlbl_ClearButton As B4XView
	Private xlbl_RevealButton As B4XView
	Private xpnl_PasswordStrengthBackground As B4XView
	Private xpnl_Underline As B4XView
	
	Private xlbl_InternPreProperties As B4XView
	
	Private xlbl_ButtonText As B4XView
	
	Private xlbl_Title As B4XView
	Private xlbl_TitleReqiredField As B4XView
	
	Private xlbl_Counter As B4XView
	Private xlbl_Info As B4XView
	
	Private xpnl_LeadingIcon As B4XView
	Private xpnl_TrailingIcon As B4XView
	
	Private xiv_LeadingIcon As B4XView
	Private xiv_TrailingIcon As B4XView
	
	Private xlbl_Prefix As B4XView
	Private xlbl_Suffix As B4XView
	
	Private m_CustomLeadingWidth As Float
	Private m_CustomTrailingWidth As Float
	
	Private m_Mode As String
	
	Private m_BackgroundColor As Int
	Private m_KeyboardType As String
	Private m_PasswordField As Boolean
	Private m_ShowRevealButton As Boolean
	Private m_ShowClearButton As Boolean
	Private m_ReadOnly As Boolean = False
	Private m_TextAlignment As String
	Private m_IgnoreTextChangeEvent As Boolean = False
	Private m_TitleWidth As Float
	
	Private m_ClearAndRevealButtonColor As Int
	Private m_TextColor As Int
	Private m_StrengthIndicator As String
	Private m_RequiredField As Boolean
	Private m_RequiredFieldColor As Int
	Private m_Underline As Boolean
	Private m_TitleMode As String
	Private m_OldText As String = ""
	Private m_InternOldText As String

	
	Private m_Mask As String
	Private m_MaskText As String
	
	Private m_BottomHeight As Float
	
	#If B4J
	Private m_ToolTipText As String
	#End If
	
		#if B4A
	Private IME As IME
	#End If
	
	Private m_LeftGap As Float = 10dip
	Private m_TopGap As Float = 0dip
	Private m_HasFocus As Boolean = False
	Private m_isPasswordMode As Boolean = False
	Private m_isInRequiredMode As Boolean = False
	Private m_isViewReady As Boolean = False
	Private bc As ByteConverter
	Private m_LastToHint As Boolean = False
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
		#if B4A
	IME.Initialize("ime")
	#end if
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	xlbl_InternPreProperties = Lbl
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me

	IniProps(Props)

	xpnl_TextFieldBackground = xui.CreatePanel("xpnl_TextFieldBackground")
	mBase.AddView(xpnl_TextFieldBackground,0,0,mBase.Width,mBase.Height)

	If m_PasswordField And m_StrengthIndicator <> "None" Then
		xpnl_PasswordStrengthBackground = xui.CreatePanel("")
		mBase.AddView(xpnl_PasswordStrengthBackground,0,0,mBase.Width,20dip)
		xpnl_PasswordStrengthBackground.Color = xui.Color_Transparent
	End If

	CreateTextFields
	
	xpnl_TextFieldBackground.AddView(xlbl_ButtonText,m_LeftGap,m_TopGap,xpnl_TextFieldBackground.Width - xpnl_TextFieldBackground.Height,xpnl_TextFieldBackground.Height - m_TopGap*2)
	
	xpnl_TextFieldBackground.AddView(xlbl_Hint,m_LeftGap,m_TopGap,xpnl_TextFieldBackground.Width,xpnl_TextFieldBackground.Height - m_TopGap*2)

	xpnl_TextFieldBackground.AddView(xlbl_ClearButton,xpnl_TextFieldBackground.Width - xpnl_TextFieldBackground.Height,0,xpnl_TextFieldBackground.Height,xpnl_TextFieldBackground.Height)

	xpnl_TextFieldBackground.AddView(xlbl_RevealButton,xpnl_TextFieldBackground.Width - xpnl_TextFieldBackground.Height * IIf(m_ShowClearButton,2,1),0,xpnl_TextFieldBackground.Height,xpnl_TextFieldBackground.Height)

	mBase.AddView(xlbl_Title,0,0,mBase.Width,20dip)
	mBase.AddView(xlbl_TitleReqiredField,0,0,mBase.Width,20dip)
	mBase.AddView(xpnl_Underline,0,mBase.Height,mBase.Width,2dip)
	xpnl_Underline.Visible = m_Underline
	
	mBase.AddView(xlbl_Counter,0,0,mBase.Width/2,20dip)

	mBase.AddView(xlbl_Info,0,0,mBase.Width/2,20dip)
	
	UpdateTextFieldShape

	'ButtonText Options
	If m_Mode = "ComboBox" Then
		xlbl_ButtonText.Color = xpnl_TextFieldBackground.Color
	Else
		xlbl_ButtonText.Color = xui.Color_Transparent
	End If
	xlbl_ButtonText.TextColor = Lbl.As(B4XView).TextColor
	xlbl_ButtonText.Font = Lbl.As(B4XView).Font
	xlbl_ButtonText.SetTextAlignment("CENTER",m_TextAlignment)
	'Hint Options
	g_Hint.xFont = Lbl.As(B4XView).Font
	xlbl_Hint.Color = xui.Color_Transparent
	xlbl_Hint.SetTextAlignment("CENTER",m_TextAlignment)
	xlbl_Hint.Visible = g_Hint.Visible

	'ClearButton Options
	xlbl_ClearButton.Visible = False
	xlbl_ClearButton.SetTextAlignment("CENTER","CENTER")
	
	Dim ClearAndRevealButtonColor() As Int = GetARGB(m_ClearAndRevealButtonColor)
	
	xlbl_ClearButton.TextColor = IIf(ClearAndRevealButtonColor(0) > 0,m_ClearAndRevealButtonColor, IIf(isColorDark(m_BackgroundColor),xui.Color_ARGB(152,255,255,255),xui.Color_ARGB(152,0,0,0)))
	xlbl_ClearButton.Font = xui.CreateMaterialIcons(20)
	xlbl_ClearButton.Text = Chr(0xE14C)

	'RevealButton Options
	xlbl_RevealButton.Tag = "reveal"
	xlbl_RevealButton.Visible = False
	xlbl_RevealButton.SetTextAlignment("CENTER","CENTER")
	xlbl_RevealButton.TextColor = xlbl_ClearButton.TextColor
	xlbl_RevealButton.Font = xui.CreateMaterialIcons(18)
	xlbl_RevealButton.Text = Chr(0xE8F4)
	
	'Info Options
	xlbl_Info.SetTextAlignment("CENTER","LEFT")
	
	'LeadingIcon Options
	xpnl_TextFieldBackground.AddView(xpnl_LeadingIcon,0,0,0,0)
	
	xpnl_LeadingIcon.AddView(xiv_LeadingIcon,0,0,0,0)
	
	'TrailingIcon Options
	xpnl_TextFieldBackground.AddView(xpnl_TrailingIcon,0,0,0,0)
	
	
	xpnl_TrailingIcon.AddView(xiv_TrailingIcon,0,0,0,0)
	
	xpnl_TextFieldBackground.AddView(xlbl_Prefix,0,0,0,0)
	xpnl_TextFieldBackground.AddView(xlbl_Suffix,0,0,0,0)
	
	Style
	
	If xlbl_InternPreProperties.Text <> "" Then setText(xlbl_InternPreProperties.Text)
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If

	Sleep(0)
	m_isViewReady = True

End Sub

Private Sub UpdateTextFieldShape
	xpnl_Underline.Visible = m_Underline
	If m_Underline Then
		xpnl_Underline.Color = IIf(m_HasFocus,g_TextFieldProperties.FocusedShapeColor,g_TextFieldProperties.NonFocusedShapeColor)
		xpnl_TextFieldBackground.SetColorAndBorder(m_BackgroundColor,0,0,g_TextFieldProperties.CornerRadius)
	Else
		xpnl_TextFieldBackground.SetColorAndBorder(m_BackgroundColor,g_TextFieldProperties.BorderWidth,IIf(m_HasFocus,g_TextFieldProperties.FocusedShapeColor,g_TextFieldProperties.NonFocusedShapeColor),g_TextFieldProperties.CornerRadius)
	End If
	
	If m_Mode = "ComboBox" Then
		xlbl_ButtonText.Color = xpnl_TextFieldBackground.Color
	End If
	
End Sub

Private Sub CreateTextFields
	
	If m_Mode = "TextField" Then
		xtf_TextField = CreateTextField(False)
		xpnl_TextFieldBackground.AddView(xtf_TextField,m_LeftGap,m_TopGap,xpnl_TextFieldBackground.Width - xpnl_TextFieldBackground.Height,xpnl_TextFieldBackground.Height - m_TopGap*2)
		
		'TextField Options
		xtf_TextField.Color = xui.Color_Transparent
		xtf_TextField.TextColor = xlbl_InternPreProperties.TextColor
		xtf_TextField.Font = xlbl_InternPreProperties.Font
		xtf_TextField.SetTextAlignment("CENTER",m_TextAlignment)
		
		xlbl_ButtonText.Visible = False
	End If
	
	If m_Mode = "TextField" And m_isPasswordMode Then
		xtf_TextFieldPassword = CreateTextField(True)
		xpnl_TextFieldBackground.AddView(xtf_TextFieldPassword,m_LeftGap,m_TopGap,xpnl_TextFieldBackground.Width - xpnl_TextFieldBackground.Height,xpnl_TextFieldBackground.Height - m_TopGap*2)
		
		'TextFieldPassword Options
		xtf_TextFieldPassword.Color = xui.Color_Transparent
		xtf_TextFieldPassword.TextColor = xlbl_InternPreProperties.TextColor
		xtf_TextFieldPassword.Font = xlbl_InternPreProperties.Font
		xtf_TextFieldPassword.SetTextAlignment("CENTER",m_TextAlignment)
		
		If m_PasswordField Then
			xtf_TextField.Visible = False
			xtf_TextFieldPassword.Visible = True
			xtf_TextFieldPassword.BringToFront
		Else
			xtf_TextField.Visible = True
			xtf_TextFieldPassword.Visible = False
			xtf_TextField.BringToFront
		End If
		
	End If
	
	If m_Mode = "Multiline" Then
		xtf_Multiline = IIf(xui.IsB4A,CreateTextField(False),CreateMultineTextField)
		xpnl_TextFieldBackground.AddView(xtf_Multiline,m_LeftGap,m_TopGap,xpnl_TextFieldBackground.Width - xpnl_TextFieldBackground.Height,xpnl_TextFieldBackground.Height - m_TopGap*2)
		
		'MultilineTextField Options
		xtf_Multiline.Color = xui.Color_Transparent
		xtf_Multiline.TextColor = xlbl_InternPreProperties.TextColor
		xtf_Multiline.Font = xlbl_InternPreProperties.Font
	#If B4A or B4I
		xtf_Multiline.SetTextAlignment("TOP",m_TextAlignment)
		#Else
		If m_TextAlignment = "LEFT" Then
			xtf_Multiline.As(JavaObject).RunMethod("setNodeOrientation", Array("LEFT_TO_RIGHT"))
		else If m_TextAlignment = "RIGHT" Then
			xtf_Multiline.As(JavaObject).RunMethod("setNodeOrientation", Array("RIGHT_TO_LEFT"))
		End If	
	#End If
		xtf_Multiline.BringToFront
		
		xlbl_ButtonText.Visible = False
	End If
	
	If m_Mode = "ComboBox" Then
		Dim xpnl_ComboBoxBackground As B4XView = xui.CreatePanel("")
		xpnl_TextFieldBackground.AddView(xpnl_ComboBoxBackground,m_LeftGap,m_TopGap,xpnl_TextFieldBackground.Width - xpnl_TextFieldBackground.Height,xpnl_TextFieldBackground.Height - m_TopGap*2)
		Dim lbl_ComboBox As B4XView = CreateLabel("")	
		xcb_ComboBox.Initialize(Me,"xcb_ComboBox")
		xcb_ComboBox.DesignerCreateView(xpnl_ComboBoxBackground,lbl_ComboBox,CreateMap())		
		xcb_ComboBox.SetItems(Array As String(""))
		#If B4A
		xcb_ComboBox.cmbBox.Visible = False
		#End If
		#If B4I
		SetButtonTextColor(xcb_ComboBox.mBtn,xui.Color_Transparent,0)
		#End If
	End If
	
	xlbl_FloatingHintTitle = CreateLabel("")
	
	If m_TitleMode = "FloatText" Then
		#If B4J
		xlbl_FloatingHintTitle.As(JavaObject).RunMethod("setMouseTransparent", Array(True))
		#End If
		mBase.AddView(xlbl_FloatingHintTitle,m_LeftGap,m_TopGap,xpnl_TextFieldBackground.Width,xpnl_TextFieldBackground.Height - m_TopGap*2)
		RefreshFloatingHint
	End If
	
	If m_ReadOnly Then setReadOnly(m_ReadOnly)
	
End Sub

Private Sub IniProps(Props As Map)
	
	xlbl_Hint = CreateLabel("")
	xlbl_Info = CreateLabel("")
	xlbl_Counter = CreateLabel("")
	xlbl_Title = CreateLabel("xlbl_Title")
	xlbl_TitleReqiredField = CreateLabel("")
	xpnl_LeadingIcon = xui.CreatePanel("xpnl_LeadingIcon")
	xiv_LeadingIcon = CreateImageView("")
	xpnl_TrailingIcon = xui.CreatePanel("xpnl_TrailingIcon")
	xiv_TrailingIcon = CreateImageView("")
	xlbl_Prefix = CreateLabel("")
	xlbl_Suffix = CreateLabel("")
	xlbl_ClearButton = CreateLabel("xlbl_ClearButton")
	xlbl_RevealButton = CreateLabel("xlbl_RevealButton")
	xlbl_ButtonText = CreateLabel("xlbl_ButtonText")
	xpnl_Underline = xui.CreatePanel("")
	
	m_Mode = Props.Get("Mode")
	m_ReadOnly = Props.GetDefault("ReadOnly",False)
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	m_TextAlignment = Props.GetDefault("TextAlignment","Left").As(String).ToUpperCase
	m_KeyboardType = Props.Get("KeyboardType")
	m_PasswordField = IIf(m_Mode = "TextField",Props.Get("PasswordField"),False)
	m_ShowRevealButton = IIf(m_Mode = "TextField",Props.Get("ShowRevealButton"),False)
	m_ShowClearButton = Props.Get("ShowClearButton")
	m_Underline = Props.GetDefault("Underline",False)
	m_TitleMode = Props.GetDefault("TitleMode","Default")
	
	
	m_ClearAndRevealButtonColor = xui.PaintOrColorToColor(Props.GetDefault("ClearAndRevealButtonColor",0x00FFFFFF))
	
	m_StrengthIndicator = Props.GetDefault("StrengthIndicator","None")
	m_RequiredField = Props.GetDefault("RequiredField",False)
	m_RequiredFieldColor = xui.PaintOrColorToColor(Props.GetDefault("RequiredFieldColor",xui.Color_ARGB(255,221, 95, 96)))
	
	m_Mask = Props.GetDefault("Mask","None")
	m_MaskText = Props.GetDefault("MaskText","")
	
	m_BottomHeight = DipToCurrent(Props.Get("BottomHeight"))
	
	m_TextColor = xlbl_InternPreProperties.TextColor
	
	If m_PasswordField Then m_isPasswordMode = True
	
	#If B4J
	m_ToolTipText = Props.Get("ToolTipText")
	#End If
	
	m_TitleWidth = IIf(Props.ContainsKey("TitleWidth"),DipToCurrent(Props.Get("TitleWidth")),100dip)
	
	g_Title = CreateASTextFieldAdvanced_Title(Props.Get("Title"),Props.Get("TitleText"),DipToCurrent(Props.Get("TitleHeight")),False,xui.CreateDefaultBoldFont(15),xui.PaintOrColorToColor(Props.GetDefault("FocusedTitleTextColor",xui.Color_White)),xui.PaintOrColorToColor(Props.GetDefault("NonFocusedTitleTextColor",xui.Color_White)),"LEFT",CreateASTextFieldAdvanced_ViewTitle(xlbl_Title))
	g_Hint = CreateASTextFieldAdvanced_Hint(Props.Get("Hint") And m_Mode <> "ComboBox",Props.Get("HintText"),False,xui.PaintOrColorToColor(Props.Get("FocusedHintTextColor")),xui.PaintOrColorToColor(Props.Get("NonFocusedHintTextColor")),xui.CreateDefaultFont(12),CreateASTextFieldAdvanced_ViewHint(xlbl_Hint))
	g_Information = CreateASTextFieldAdvanced_Information(Props.Get("Info"),Props.Get("InfoText"),False,xui.CreateDefaultFont(13),xui.PaintOrColorToColor(Props.GetDefault("InfoTextColor",xui.Color_White)),CreateASTextFieldAdvanced_ViewInformation(xlbl_Info))
	g_Counter = CreateASTextFieldAdvanced_Counter(Props.Get("Counter"),Props.Get("CounterMax"),False,xui.CreateDefaultFont(13),xui.PaintOrColorToColor(Props.GetDefault("CounterTextColor",xui.Color_White)),CreateASTextFieldAdvanced_ViewCounter(xlbl_Counter))
	g_LeadingIcon = CreateASTextFieldAdvanced_LeadingIcon(Props.GetDefault("LeadingIcon",False),Null,CreateASTextFieldAdvanced_ViewLeadingIcon(xpnl_LeadingIcon,xiv_LeadingIcon))
	g_TrailingIcon = CreateASTextFieldAdvanced_TrailingIcon(Props.GetDefault("TrailingIcon",False),Null,CreateASTextFieldAdvanced_ViewTrailingIcon(xpnl_TrailingIcon,xiv_TrailingIcon))
	g_Prefix = CreateASTextFieldAdvanced_Prefix(Props.GetDefault("Prefix",False),Props.GetDefault("PrefixText","$"),False,xui.CreateDefaultFont(20),xui.Color_ARGB(100,255,255,255),5dip,CreateASTextFieldAdvanced_ViewPrefixSuffix(xlbl_Prefix))
	g_Suffix = CreateASTextFieldAdvanced_Suffix(Props.GetDefault("Suffix",False),Props.GetDefault("SuffixText","@gmail.com"),False,xui.CreateDefaultFont(20),xui.Color_ARGB(100,255,255,255),5dip,CreateASTextFieldAdvanced_ViewPrefixSuffix(xlbl_Suffix))
	g_TextFieldProperties = CreateASTextFieldAdvanced_TextFieldProperties(xui.PaintOrColorToColor(Props.GetDefault("FocusedShapeColor",0xFFFFFFFF)),xui.PaintOrColorToColor(Props.GetDefault("NonFocusedShapeColor",0xFFFFFFFF)),2dip,DipToCurrent(Props.GetDefault("TextFieldCornerRadius",5dip)))

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

	xlbl_Title.Visible = g_Title.Visible
	xlbl_TitleReqiredField.Visible = m_RequiredField
	xlbl_Counter.Visible = g_Counter.Visible
	xlbl_Info.Visible = g_Information.Visible
	xpnl_LeadingIcon.Visible = g_LeadingIcon.Visible
	xpnl_TrailingIcon.Visible = g_TrailingIcon.Visible
	xlbl_Prefix.Visible = g_Prefix.Visible And m_Mode <> "Multiline"
	xlbl_Suffix.Visible = g_Suffix.Visible And m_Mode <> "Multiline"
	
	Dim TextFieldHeight As Float = Height
	If g_Title.Visible And m_TitleMode <> "BeforeTextField" Then
		TextFieldHeight = Height - g_Title.Height
	End If
	
	If g_Counter.Visible Or g_Information.Visible Then
		TextFieldHeight = TextFieldHeight - m_BottomHeight
	End If
  
	If m_PasswordField And m_StrengthIndicator <> "None" Then
		TextFieldHeight = TextFieldHeight - 20dip
	End If
  
	Dim ActionButtonGap As Float = 5dip
  
	Dim TextFieldTop As Float
	Dim TextFieldLeft As Float
	Dim TextFieldWidth As Float
	If m_TitleMode = "BeforeTextField" Then
		TextFieldTop = 0
		TextFieldLeft = m_TitleWidth
		TextFieldWidth = Width - m_TitleWidth
	Else
		TextFieldTop = IIf(g_Title.Visible,g_Title.Height,0)
		TextFieldLeft = 0
		TextFieldWidth = Width
	End If
  
	xpnl_LeadingIcon.SetLayoutAnimated(0,0,m_TopGap,IIf(m_CustomLeadingWidth = 0,TextFieldHeight,m_CustomLeadingWidth),TextFieldHeight - m_TopGap*2)
	xpnl_TrailingIcon.SetLayoutAnimated(0,TextFieldWidth - TextFieldHeight,m_TopGap,IIf(m_CustomTrailingWidth = 0,TextFieldHeight,m_CustomTrailingWidth),TextFieldHeight - m_TopGap*2)
  
	xpnl_TextFieldBackground.SetLayoutAnimated(0,TextFieldLeft,TextFieldTop,TextFieldWidth,TextFieldHeight)
	xlbl_Title.SetLayoutAnimated(0,0,0,IIf(m_TitleMode = "BeforeTextField",m_TitleWidth,Width),IIf(m_TitleMode = "BeforeTextField",TextFieldHeight,g_Title.Height))
	xlbl_TitleReqiredField.SetLayoutAnimated(0,MeasureTextWidth(xlbl_Title.Text,xlbl_Title.Font),0,MeasureTextWidth(xlbl_TitleReqiredField.Text,xlbl_TitleReqiredField.Font),xlbl_Title.Height - xlbl_TitleReqiredField.Font.Size/2)
	xlbl_Counter.SetLayoutAnimated(0,0,Height - m_BottomHeight,Width,m_BottomHeight)
	xlbl_Info.SetLayoutAnimated(0,TextFieldLeft,Height - m_BottomHeight,TextFieldWidth,m_BottomHeight)
	xpnl_Underline.SetLayoutAnimated(0,TextFieldLeft,TextFieldTop + TextFieldHeight - 2dip,TextFieldWidth,2dip)
  
	If m_PasswordField And m_StrengthIndicator <> "None" Then
		xpnl_PasswordStrengthBackground.SetLayoutAnimated(0,TextFieldLeft,Height - 20dip - IIf(xlbl_Info.Visible,xlbl_Info.Height,0),TextFieldWidth,20dip)
		DrawPasswordStrengthIndicator
	End If
  
	Dim ActionButtonsWidth As Float = 24dip'xpnl_TextFieldBackground.Height/2
	
	xlbl_ClearButton.SetLayoutAnimated(0,TextFieldWidth - IIf(g_TrailingIcon.Visible,TextFieldHeight,ActionButtonGap) - ActionButtonsWidth,m_TopGap,ActionButtonsWidth,xpnl_TextFieldBackground.Height - m_TopGap*2)
	xlbl_RevealButton.SetLayoutAnimated(0,TextFieldWidth - IIf(g_TrailingIcon.Visible,TextFieldHeight,ActionButtonGap*IIf(m_ShowClearButton,3,1)) - ActionButtonsWidth*IIf(m_ShowClearButton,2,1),m_TopGap,ActionButtonsWidth,xpnl_TextFieldBackground.Height - m_TopGap*2)
  
	xlbl_Prefix.SetLayoutAnimated(0,0,m_TopGap,MeasureTextWidth(xlbl_Prefix.Text,xlbl_Prefix.Font) + g_Prefix.Gap,xpnl_TextFieldBackground.Height - m_TopGap*2)
  
	'Dim TextField_Left As Float = TextFieldLeft + m_LeftGap + IIf(xlbl_Prefix.Visible,xlbl_Prefix.Width,0)
	Dim TextFieldInputLeft As Float = m_LeftGap + IIf(xlbl_Prefix.Visible,xlbl_Prefix.Width,0)
	Dim TextField_Width As Float = TextFieldWidth - IIf(m_ShowClearButton,ActionButtonsWidth + IIf(g_TrailingIcon.Visible,0, ActionButtonGap),0) - IIf(m_ShowRevealButton And m_PasswordField,ActionButtonsWidth + ActionButtonGap*IIf(m_ShowClearButton,3,1),5dip) - IIf(xlbl_Prefix.Visible,xlbl_Prefix.Width,0) * IIf(m_ShowRevealButton Or m_ShowClearButton,1,2)

	If g_LeadingIcon.Visible Then TextField_Width = TextField_Width - xpnl_LeadingIcon.Width
	If g_TrailingIcon.Visible Then TextField_Width = TextField_Width - xpnl_TrailingIcon.Width - ActionButtonGap
  
	TextField_Width = TextField_Width - TextFieldInputLeft 'V1.44
  
	If g_LeadingIcon.Visible Then TextFieldInputLeft = TextFieldInputLeft + xpnl_LeadingIcon.Width
  
	xlbl_Prefix.Left = TextFieldInputLeft - xlbl_Prefix.Width
  
	Dim IconWidthHeight As Float = xpnl_LeadingIcon.Height/2
  
	xiv_LeadingIcon.SetLayoutAnimated(0,xpnl_LeadingIcon.Width/2 - IconWidthHeight/2,xpnl_LeadingIcon.Height/2 - IconWidthHeight/2,IconWidthHeight,IconWidthHeight)
	xiv_TrailingIcon.SetLayoutAnimated(0,xpnl_TrailingIcon.Width/2 - IconWidthHeight/2,xpnl_TrailingIcon.Height/2 - IconWidthHeight/2,IconWidthHeight,IconWidthHeight)
  
	If g_LeadingIcon.Icon <> Null And g_LeadingIcon.Icon.IsInitialized = True Then setLeadingIcon2(g_LeadingIcon.Icon)
	If g_TrailingIcon.Icon <> Null And g_TrailingIcon.Icon.IsInitialized = True Then setTrailingIcon2(g_TrailingIcon.Icon)
  
  
	If xtf_TextField.IsInitialized Then xtf_TextField.SetLayoutAnimated(0,TextFieldInputLeft,m_TopGap,TextField_Width,xpnl_TextFieldBackground.Height - m_TopGap*2)
	
	xlbl_Suffix.SetLayoutAnimated(0,TextFieldInputLeft + TextField_Width - MeasureTextWidth(xlbl_Suffix.Text,xlbl_Suffix.Font) - g_Suffix.Gap,m_TopGap,MeasureTextWidth(xlbl_Suffix.Text,xlbl_Suffix.Font) + g_Prefix.Gap,xpnl_TextFieldBackground.Height - m_TopGap*2)
	If xlbl_Suffix.Visible Then
		TextField_Width = TextField_Width - xlbl_Suffix.Width
		If xtf_TextField.IsInitialized Then xtf_TextField.Width = TextField_Width
	End If
	
	If xtf_TextFieldPassword.IsInitialized Then xtf_TextFieldPassword.SetLayoutAnimated(0,TextFieldInputLeft,m_TopGap,TextField_Width,xpnl_TextFieldBackground.Height - m_TopGap*2)
	xlbl_ButtonText.SetLayoutAnimated(0,TextFieldInputLeft,m_TopGap,TextField_Width,xpnl_TextFieldBackground.Height - m_TopGap*2)
	If m_Mode <> "Multiline" Then
		xlbl_Hint.SetLayoutAnimated(0,TextFieldInputLeft,m_TopGap,TextField_Width,xpnl_TextFieldBackground.Height - m_TopGap*2)
	Else
		xlbl_Hint.SetLayoutAnimated(0,TextFieldInputLeft + m_LeftGap,5dip + m_TopGap,TextField_Width - TextFieldInputLeft - m_LeftGap*2,TextFieldHeight - 10dip - m_TopGap*2)
		#If B4I
		xlbl_Hint.As(Label).SizeToFit
		#End If	
		
		'xlbl_ClearButton.Visible = False
		xlbl_Prefix.Visible = False
		xlbl_RevealButton.Visible = False
		xlbl_Suffix.Visible = False
		xpnl_LeadingIcon.Visible = False
		xpnl_TrailingIcon.Visible = False
	End If
	MoveFloatingHint(getText.Length = 0,False)
	
	If xtf_Multiline.IsInitialized Then
	#If B4J
		xtf_Multiline.SetLayoutAnimated(0,xlbl_Hint.Left - 13dip,-1dip + m_TopGap,TextField_Width + 4dip,TextFieldHeight - m_TopGap*2)
	#Else if B4I
		xtf_Multiline.SetLayoutAnimated(0,xlbl_Hint.Left,-8dip + 5dip + m_TopGap,TextField_Width - (xlbl_Hint.Left*2),TextFieldHeight - 10dip + 8dip - m_TopGap*2)
		#Else
		xtf_Multiline.SetLayoutAnimated(0,xlbl_Hint.Left,5dip + m_TopGap,TextField_Width - (xlbl_Hint.Left*2),TextFieldHeight - 10dip - m_TopGap*2)
	#End If
	End If
	
	If xcb_ComboBox.IsInitialized Then
		#If B4A
		xlbl_ButtonText.Height = xlbl_ButtonText.Height - 5dip
		xlbl_ButtonText.Top = xlbl_ButtonText.Top + 5dip/2
		#End If
		xcb_ComboBox.mBase.SetLayoutAnimated(0,xlbl_Hint.Left,xlbl_Hint.Top,TextField_Width,xlbl_Hint.Height)
		CallSub3(xcb_ComboBox, "Base_Resize", TextField_Width,xcb_ComboBox.mBase.Height) ' true or false
	End If
	
End Sub

Private Sub Style
	'****************View Properties*******************************
	'Title Options
	If g_Title.IgnoreProperties = False Then
		If m_TitleMode <> "FloatText" Then xlbl_Title.Text = g_Title.Text
		If m_TitleMode = "FloatText" Then xlbl_FloatingHintTitle.Text = g_Title.Text
		If m_HasFocus Then
			xlbl_Title.TextColor = g_Title.FocusedTextColor
			'Log(g_Title.FocusedTextColor)
		Else
			xlbl_Title.TextColor = g_Title.NonFocusedTextColor
			'Log(g_Title.NonFocusedTextColor)
		End If
		xlbl_Title.Font = g_Title.xFont
		xlbl_Title.SetTextAlignment("CENTER",g_Title.HorizontalAlignment)
        
		xlbl_TitleReqiredField.Text = "*"
		xlbl_TitleReqiredField.Textcolor = m_RequiredFieldColor
		xlbl_TitleReqiredField.Font = g_Title.xFont
		xlbl_TitleReqiredField.SetTextAlignment("CENTER",g_Title.HorizontalAlignment)
        
	End If

	'Hint Options
	If g_Hint.IgnoreProperties = False Then
		If m_HasFocus Then
			xlbl_Hint.TextColor = g_Hint.FocusedTextColor
		Else
			xlbl_Hint.TextColor = g_Hint.NonFocusedTextColor
		End If
		xlbl_Hint.Font = g_Hint.xFont
		If m_TitleMode <> "FloatText" Then xlbl_Hint.Text = g_Hint.Text'IIf(g_Hint.Visible,g_Hint.Text,"")
		If m_Mode = "Multiline" Then
			xlbl_Hint.SetTextAlignment("TOP",m_TextAlignment)
		End If
	End If

	'Info Options
	If g_Information.IgnoreProperties = False Then
		xlbl_Info.Text = g_Information.Text
		xlbl_Info.TextColor = g_Information.TextColor
		xlbl_Info.Font = g_Information.xFont
	End If
	
	'Counter Options
	If g_Counter.IgnoreProperties = False Then
		xlbl_Counter.Text = getText.Length & "/" & g_Counter.CounterMax
		xlbl_Counter.TextColor = g_Counter.TextColor
		xlbl_Counter.Font = g_Counter.xFont
		xlbl_Counter.SetTextAlignment("CENTER","RIGHT")
	End If
	
	'Prefix Options
	If g_Prefix.IgnoreProperties = False Then
		xlbl_Prefix.Text = g_Prefix.Text
		xlbl_Prefix.TextColor = g_Prefix.TextColor
		xlbl_Prefix.Font = g_Prefix.xFont
		xlbl_Prefix.SetTextAlignment("CENTER","CENTER")
	End If
	
	'Suffix Options
	If g_Suffix.IgnoreProperties = False Then
		xlbl_Suffix.Text = g_Suffix.Text
		xlbl_Suffix.TextColor = g_Suffix.TextColor
		xlbl_Suffix.Font = g_Suffix.xFont
		xlbl_Suffix.SetTextAlignment("CENTER","CENTER")
	End If
	
	Dim ClearAndRevealButtonColor() As Int = GetARGB(m_ClearAndRevealButtonColor)
	xlbl_ClearButton.TextColor = IIf(ClearAndRevealButtonColor(0) > 0,m_ClearAndRevealButtonColor, IIf(isColorDark(m_BackgroundColor),xui.Color_ARGB(152,255,255,255),xui.Color_ARGB(152,0,0,0)))
	xlbl_RevealButton.TextColor = xlbl_ClearButton.TextColor
	
	UpdateTextFieldShape
End Sub

Private Sub RefreshFloatingHint
	
	If getText.Length = 0 Then
	
		xlbl_FloatingHintTitle.TextColor = xlbl_Hint.TextColor
		xlbl_FloatingHintTitle.Font = xlbl_Hint.Font
		
		xlbl_FloatingHintTitle.Color = xui.Color_Transparent
		xlbl_FloatingHintTitle.SetTextAlignment("CENTER",m_TextAlignment)
		
		If m_Mode = "Multiline" Then
			xlbl_FloatingHintTitle.SetTextAlignment("TOP",m_TextAlignment)
		End If
	
	Else
		
		xlbl_FloatingHintTitle.TextColor = xlbl_Title.TextColor
		xlbl_FloatingHintTitle.Font = xlbl_Title.Font
		
	End If
	
End Sub

Private Sub MoveFloatingHint(ToHint As Boolean,Animated As Boolean)
	
	If m_TitleMode <> "FloatText" Or (m_LastToHint = ToHint And Animated = True) Then Return
	
	m_LastToHint = ToHint
	
	Dim Duration As Int = IIf(Animated,250,0)
	
	If ToHint Then
		xlbl_FloatingHintTitle.SetLayoutAnimated(Duration,xpnl_TextFieldBackground.Left + xlbl_Hint.Left,xpnl_TextFieldBackground.Top + xlbl_Hint.Top,xlbl_Hint.Width,xlbl_Hint.Height)
		xlbl_FloatingHintTitle.SetTextSizeAnimated(Duration,xlbl_Hint.TextSize)
		xlbl_FloatingHintTitle.TextColor = xlbl_Hint.TextColor
		Sleep(Duration)
		xlbl_FloatingHintTitle.Font = xlbl_Hint.Font
	Else
		xlbl_FloatingHintTitle.SetLayoutAnimated(Duration,xlbl_Title.Left,xlbl_Title.Top,xlbl_Title.Width,xlbl_Title.Height)
		xlbl_FloatingHintTitle.SetTextSizeAnimated(Duration,xlbl_Title.Font.Size)
		xlbl_FloatingHintTitle.TextColor = xlbl_Title.TextColor
		Sleep(Duration)
		xlbl_FloatingHintTitle.Font = xlbl_Title.Font
	End If
End Sub

Public Sub Refresh
	Style
	Base_Resize(mBase.Width,mBase.Height)
End Sub
'Sets input focus
'Returns True if the focus has shifted
'Always retuns True in B4J
Public Sub Focus As Boolean
	
	Select m_Mode
		Case "Multiline"
					#If B4A
		IME.ShowKeyboard(xtf_Multiline)
			#End If
			Return xtf_Multiline.RequestFocus
		Case "Button","ComboBox"
			Return True
		Case Else
			If xlbl_RevealButton.Tag = "reveal" And m_isPasswordMode Then
			#If B4A
			IME.ShowKeyboard(xtf_TextFieldPassword)
			#End If
				Return xtf_TextFieldPassword.RequestFocus
			Else
			#If B4A
			IME.ShowKeyboard(xtf_TextField)
			#End If
				Return xtf_TextField.RequestFocus
			End If
	End Select
	
End Sub
'Call this function to inform the user that not all required fields are filled in.
'Call HideDisplayMissingField to remove it
'<code>AS_TextFieldAdvanced_1.ShowDisplayMissingField("This field is required")</code>
Public Sub ShowDisplayMissingField(InformationText As String)
	m_isInRequiredMode = True
	Dim Color() As Int = GetARGB(m_RequiredFieldColor)
	xpnl_TextFieldBackground.SetColorAndBorder(xui.Color_ARGB(80,Color(1),Color(2),Color(3)),g_TextFieldProperties.BorderWidth,m_RequiredFieldColor,g_TextFieldProperties.CornerRadius)
	xlbl_Info.Text = InformationText
End Sub

'<code>AS_TextFieldAdvanced_1.HideDisplayMissingField</code>
Public Sub HideDisplayMissingField
	If m_isInRequiredMode Then
		UpdateTextFieldShape
	xlbl_Info.Text = g_Information.Text
	m_isInRequiredMode = False
	End If
End Sub

#Region Properties

Public Sub setTextAlignment(TextAlignment As String)
	m_TextAlignment = TextAlignment
	If xtf_TextField.IsInitialized Then xtf_TextField.SetTextAlignment("CENTER",m_TextAlignment)
	If xtf_TextFieldPassword.IsInitialized Then xtf_TextFieldPassword.SetTextAlignment("CENTER",m_TextAlignment)
	If xlbl_ButtonText.IsInitialized Then xlbl_ButtonText.SetTextAlignment("CENTER",m_TextAlignment)
	If xlbl_Hint.IsInitialized Then xlbl_Hint.SetTextAlignment("CENTER",m_TextAlignment)
	'If xcb_ComboBox.IsInitialized Then xcb_ComboBox.SetTextAlignment("CENTER",m_TextAlignment)
	
	If xtf_Multiline.IsInitialized Then
		#If B4A or B4I
	xtf_Multiline.SetTextAlignment("TOP",m_TextAlignment)
		#Else
		If m_TextAlignment = "LEFT" Then
			xtf_Multiline.As(JavaObject).RunMethod("setNodeOrientation", Array("LEFT_TO_RIGHT"))
		else If m_TextAlignment = "RIGHT" Then
			xtf_Multiline.As(JavaObject).RunMethod("setNodeOrientation", Array("RIGHT_TO_LEFT"))
		End If	
	#End If
	End If
End Sub

Public Sub getTextAlignment As String
	Return m_TextAlignment
End Sub

'If true the ShapeColor ist used for this underline
Public Sub getUnderline As Boolean
	Return m_Underline
End Sub

Public Sub setUnderline(Underline As Boolean)
	m_Underline = Underline
	UpdateTextFieldShape
End Sub

'Works only if the TitleMode is set to BeforeTextField. The Text width of the title
'Sets the width value for all textfields on the parent
Public Sub TitleWidthAll(Parent As B4XView,Width As Float)
	For i = 0 To Parent.NumberOfViews -1
		If Parent.GetView(i).Tag Is AS_TextFieldAdvanced Then
			Parent.GetView(i).Tag.As(AS_TextFieldAdvanced).TitleWidth = Width
			Parent.GetView(i).Tag.As(AS_TextFieldAdvanced).Refresh
		End If
	Next
End Sub

'Works only if the TitleMode is set to BeforeTextField. The Text width of the title
Public Sub getTitleWidth As Float
	Return m_TitleWidth
End Sub

Public Sub setTitleWidth(Width As Float)
	m_TitleWidth = Width
End Sub

'Set the ComboBox Items
Public Sub SetItems(Items As List)
	xcb_ComboBox.SetItems(Items)
	xlbl_ButtonText.Text = xcb_ComboBox.SelectedItem
End Sub

'Gets or sets the ComboBox Index
Public Sub setSelectedIndex(Index As Int)
	xcb_ComboBox.SelectedIndex = Index
	xlbl_ButtonText.Text = xcb_ComboBox.SelectedItem
End Sub

Public Sub getSelectedIndex As Int
	Return xcb_ComboBox.SelectedIndex
End Sub

'ComboBox
'Returns the index of the item with the given value. Returns -1 if not found.
Public Sub IndexOf(Item As String) As Int
	Return xcb_ComboBox.IndexOf(Item)
End Sub

'Gets the AS_ComboBoxIntern
Public Sub getComboBox As AS_ComboBoxIntern
	Return xcb_ComboBox
End Sub

Public Sub OpenComboBox
	If m_Mode = "ComboBox" Then
		OpenComboBoxIntern(xcb_ComboBox)
	Else
		LogColor("Textfield mode is not ComboBox!",xui.Color_Red)
	End If
End Sub

Public Sub getUnderlinePanel As B4XView
	Return xpnl_Underline
End Sub

'Default is the textfield height
Public Sub getTrailingWidth As Float
	Return m_CustomTrailingWidth
End Sub

Public Sub setTrailingWidth(Width As Float)
	m_CustomTrailingWidth = Width
End Sub

'Default is the textfield height
Public Sub getLeadingWidth As Float
	Return m_CustomLeadingWidth
End Sub

Public Sub setLeadingWidth(Width As Float)
	m_CustomLeadingWidth = Width
End Sub

Public Sub setMaskText(Mask As String)
	m_MaskText = Mask
End Sub

Public Sub getMaskText As String
	Return m_MaskText
End Sub

'Call Refresh if you change something
Public Sub setRequiredFieldColor(Color As Int)
	m_RequiredFieldColor = Color
End Sub

Public Sub getRequiredFieldColor As Int
	Return m_RequiredFieldColor
End Sub
'Call Refresh if you change something
Public Sub setRequiredField(Required As Boolean)
	m_RequiredField = Required
End Sub

Public Sub getRequiredField As Boolean
	Return m_RequiredField
End Sub
'Call Refresh if you change something
Public Sub getReadOnly As Boolean
	Return m_ReadOnly
End Sub
Public Sub setReadOnly(ReadOnly As Boolean)
	m_ReadOnly = ReadOnly
	If ReadOnly = True Then
		If xtf_TextField.IsInitialized Then xtf_TextField.Enabled = False
		If xtf_TextFieldPassword.IsInitialized Then xtf_TextFieldPassword.Enabled = False
		If xtf_Multiline.IsInitialized Then
			#If B4I
			xtf_Multiline.As(TextView).Editable = False
			#Else If B4A
			xtf_Multiline.As(EditText).InputType = xtf_Multiline.As(EditText).INPUT_TYPE_NONE
			xtf_Multiline.As(EditText).SingleLine = False
			#Else
			xtf_Multiline.Enabled = False
			#End If
		End If
	Else
		If xtf_TextField.IsInitialized Then xtf_TextField.Enabled = True
		If xtf_TextFieldPassword.IsInitialized Then xtf_TextFieldPassword.Enabled = True
		If xtf_Multiline.IsInitialized Then
			xtf_Multiline.Enabled = True
				#If B4I
			xtf_Multiline.As(TextView).Editable = True
						#Else If B4A
			xtf_Multiline.As(EditText).InputType = xtf_Multiline.As(EditText).INPUT_TYPE_TEXT
			xtf_Multiline.As(EditText).SingleLine = False
			#End If
		End If
	End If
End Sub
'Call Refresh if you change something
Public Sub getTitle As ASTextFieldAdvanced_Title
	Return g_Title
End Sub
'Call Refresh if you change something
Public Sub getInformation As ASTextFieldAdvanced_Information
	Return g_Information
End Sub
'Call Refresh if you change something
Public Sub getCounter As ASTextFieldAdvanced_Counter
	Return g_Counter
End Sub
'Call Refresh if you change something
Public Sub getHint As ASTextFieldAdvanced_Hint
	Return g_Hint
End Sub
'Call Refresh if you change something
Public Sub getLeadingIcon As ASTextFieldAdvanced_LeadingIcon
	Return g_LeadingIcon
End Sub
'Call Refresh if you change something
Public Sub getTrailingIcon As ASTextFieldAdvanced_TrailingIcon
	Return g_TrailingIcon
End Sub
'Call Refresh if you change something
Public Sub getPrefix As ASTextFieldAdvanced_Prefix
	Return g_Prefix
End Sub
'Call Refresh if you change something
Public Sub getSuffix As ASTextFieldAdvanced_Suffix
	Return g_Suffix
End Sub
'Call Refresh if you change something
Public Sub getTextFieldProperties As ASTextFieldAdvanced_TextFieldProperties
	Return g_TextFieldProperties
End Sub

'***************************************Button*********************************

Private Sub setButtonText(Text As String)
	m_OldText = getText
	xlbl_ButtonText.Text = Text
	If Text.Length > 0 Then
		xlbl_Hint.Visible = False
		MoveFloatingHint(False,True)
	Else
		xlbl_Hint.Visible = g_Hint.Visible
		MoveFloatingHint(True,True)
	End If
	TextChanged(Text)
End Sub
'Without TextChanged Event
Private Sub setButtonText2(Text As String)
	m_IgnoreTextChangeEvent = True
	setButtonText(Text)
	Sleep(250)
	m_IgnoreTextChangeEvent = False
End Sub

'***************************************Hint***********************************
#If B4A
'Gets the native TextField view
Public Sub getNativeTextField As EditText
#Else
'Gets the native TextField view
Public Sub getNativeTextField As TextField
#End If
	Return xtf_TextField
End Sub

#If B4A
'Gets the native TextField view
Public Sub getNativeTextFieldPassword As EditText
#Else
'Gets the native TextField view
Public Sub getNativeTextFieldPassword As TextField
#End If
	Return xtf_TextFieldPassword
End Sub

#If B4A
'Gets the native TextField view
Public Sub getNativeTextFieldMultiline As EditText
#Else If B4J
Public Sub getNativeTextFieldMultiline As TextArea
#Else
'Gets the native TextField view
Public Sub getNativeTextFieldMultiline As TextView
#End If
	Return xtf_Multiline
End Sub

Public Sub getTextField As B4XView
	Return xtf_TextField
End Sub

Public Sub getTextFieldPassword As B4XView
	Return xtf_TextFieldPassword
End Sub

Public Sub getTextFieldMultiline As B4XView
	Return xtf_Multiline
End Sub

Public Sub getBackgroundPanel As B4XView
	Return xpnl_TextFieldBackground
End Sub

Public Sub getClearButtonLabel As B4XView
	Return xlbl_ClearButton
End Sub

Public Sub getButtonTextLabel As B4XView
	Return xlbl_ButtonText
End Sub

Public Sub getRevealButtonLabel As B4XView
	Return xlbl_RevealButton
End Sub

Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

Public Sub setBackgroundColor(Color As Int)
	m_BackgroundColor = Color
End Sub

'Call Refresh if you change something
Public Sub getClearAndRevealButtonColor As Int
	Return m_ClearAndRevealButtonColor
End Sub

Public Sub setClearAndRevealButtonColor(Color As Int)
	m_ClearAndRevealButtonColor = Color
End Sub

Public Sub getKeyboardType As String
	Return m_KeyboardType
End Sub

Public Sub getisPasswordMode As Boolean
	Return m_PasswordField
End Sub

Public Sub getisRevealed As Boolean
	Return IIf(xlbl_RevealButton.Tag = "hide",True,False)
End Sub

Public Sub setReveale(Revealed As Boolean)
	If Revealed Then
		xlbl_RevealButton.Tag = "reveal"
		Else
		xlbl_RevealButton.Tag = "hide"
	End If
	RevealButton_Click
End Sub
'Call Refresh if you change something
Public Sub getShowRevealButton As Boolean
	Return m_ShowRevealButton
End Sub

Public Sub setShowRevealButton(Show As Boolean)
	m_ShowRevealButton = Show
End Sub
'Call Refresh if you change something
Public Sub getShowClearButton As Boolean
	Return m_ShowClearButton
End Sub

Public Sub setShowClearButton(Show As Boolean)
	m_ShowClearButton = Show
End Sub

'Call Refresh if you change something
Public Sub getBottomHeight As Float
	Return m_BottomHeight
End Sub

Public Sub setBottomHeight(Height As Float)
	m_BottomHeight = Height
End Sub

'Default: 10dip
'Call Refresh if you change something
Public Sub getLeftGap As Float
	Return m_LeftGap
End Sub

Public Sub setLeftGap(Gap As Float)
	m_LeftGap = Gap
End Sub

'Default: 0dip
'Call Refresh if you change something
Public Sub getTopGap As Float
	Return m_TopGap
End Sub

Public Sub setTopGap(Gap As Float)
	m_TopGap = Gap
End Sub

Public Sub setTextColor(Color As Int)
	m_TextColor = Color
	If xtf_TextField.IsInitialized Then xtf_TextField.TextColor = m_TextColor
	If xtf_TextFieldPassword.IsInitialized Then xtf_TextFieldPassword.TextColor = m_TextColor
	If xtf_Multiline.IsInitialized Then xtf_Multiline.TextColor = m_TextColor
	If xlbl_ButtonText.IsInitialized Then xlbl_ButtonText.TextColor = m_TextColor
End Sub

'Returns the text that was there before
Public Sub getOldText As String
	Return m_OldText
End Sub

Public Sub getText As String
	If m_Mode = "TextField" Then
		If getisPasswordMode And getisRevealed = False Then
			Return xtf_TextFieldPassword.Text
		Else
			Return xtf_TextField.Text
		End If
	
	Else If m_Mode = "Multiline" Then
		Return xtf_Multiline.Text
	Else
		Return xlbl_ButtonText.Text
	End If
End Sub
'Without TextChanged Event
Public Sub setText2(Text As String)
	m_OldText = getText
	If m_Mode = "Button" Then
		setButtonText2(Text)
	Else
		m_IgnoreTextChangeEvent = True
		setText(Text)
		Sleep(250)
		m_IgnoreTextChangeEvent = False
	End If
End Sub

Public Sub setText(Text As String)
	m_OldText = getText
	If m_Mode = "Button" Then
		setButtonText(Text)
	Else
		If xtf_TextField.IsInitialized Then xtf_TextField.Text = Text
		If xtf_TextFieldPassword.IsInitialized Then xtf_TextFieldPassword.Text = Text
		If xtf_Multiline.IsInitialized Then xtf_Multiline.Text = Text
		If Text.Length > 0 Then
			xlbl_Hint.Visible = False
		Else
			xlbl_Hint.Visible = g_Hint.Visible
			MoveFloatingHint(True,False)
		End If
		TextChanged(Text)
	End If
End Sub
'Gets the full text, with Prefix and Suffix
Public Sub getTextFull As String
	If m_Mode = "Multiline" Then
		Return xtf_Multiline.Text
	Else
		Dim Text As String = ""
		If xlbl_Prefix.Visible Then
			Text = Text & xlbl_Prefix.Text
		End If
	
		Text = Text & xtf_TextField.Text
	
		If xlbl_Suffix.Visible Then
			Text = Text & xlbl_Suffix.Text
		End If
		Return Text
	End If
End Sub

Private Sub setLeadingIcon2(Icon As B4XBitmap)
	g_LeadingIcon.Icon = Icon
	Dim scale As Float = 1
	#If B4I
	scale = GetDeviceLayoutValues.NonnormalizedScale
	#End If
	xiv_LeadingIcon.SetBitmap(Icon.Resize(xiv_LeadingIcon.Width* scale,xiv_LeadingIcon.Height* scale,True))
End Sub

Private Sub setTrailingIcon2(Icon As B4XBitmap)
	g_TrailingIcon.Icon = Icon
	Dim scale As Float = 1
	#If B4I
	scale = GetDeviceLayoutValues.NonnormalizedScale
	#End If
	xiv_TrailingIcon.SetBitmap(Icon.Resize(xiv_TrailingIcon.Width* scale,xiv_TrailingIcon.Height* scale,True))
End Sub

#End Region

#Region ViewEvents
#If B4J
Private Sub xpnl_LeadingIcon_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xpnl_LeadingIcon_Click
#End If
	LeadingIconClick
End Sub
#If B4J
Private Sub xpnl_TrailingIcon_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xpnl_TrailingIcon_Click
#End If
	TrailingIconClick
End Sub

#If B4I

Private Sub xtf_TextField_TextChanged (OldText As String, NewText As String)
m_OldText = OldText
	TextChanged(NewText)
	Sleep(0)
End Sub
#Else If B4A
Private Sub xtf_TextField_TextChanged (Old As String, New As String)
m_OldText = Old
	TextChanged(New)
End Sub
#Else If B4J
Private Sub xtf_TextField_TextChanged (Old As String, New As String)
	m_OldText = Old
	TextChanged(New)
End Sub
#End If

Private Sub GetRealTextLength(Text As String) As Int
	Dim Result() As Int = bc.IntsFromBytes(Text.GetBytes("UTF-32BE"))
	Return Result.Length
End Sub

Private Sub TextChanged(Text As String)
	If m_isViewReady = False Then Return
	If m_Mask<>"None" And (m_MaskText.Contains("X") Or m_MaskText.Contains("0"))  Then
		Dim textMasked As String = applyMask(Text, m_MaskText, m_Mask)
		If Text <> textMasked Then
			xtf_TextField.Text = textMasked
			xtf_TextField.SelectionStart = xtf_TextField.Text.Length
		End If
	End If

	If g_Counter.Visible Then
		If GetRealTextLength(Text) > g_Counter.CounterMax Then
			
			If xtf_TextField .IsInitialized Then
				Dim SelectionStart As Int = xtf_TextField.SelectionStart
				xtf_TextField.Text = m_InternOldText'Text.SubString2(0,g_Counter.CounterMax)
				xtf_TextField.SelectionStart = Min(SelectionStart,xtf_TextField.Text.Length)
			End If
			If xtf_TextFieldPassword .IsInitialized Then
				Dim SelectionStart As Int = xtf_TextFieldPassword.SelectionStart
				xtf_TextFieldPassword.Text = m_InternOldText'Text.SubString2(0,g_Counter.CounterMax)
				xtf_TextFieldPassword.SelectionStart = Min(SelectionStart,xtf_TextFieldPassword.Text.Length)
			End If
			If xtf_Multiline.IsInitialized Then
				Dim SelectionStart As Int = xtf_Multiline.SelectionStart
				xtf_Multiline.Text = m_InternOldText'Text.SubString2(0,g_Counter.CounterMax)
				xtf_Multiline.SelectionStart = Min(SelectionStart,xtf_Multiline.Text.Length)
			End If
			Text = m_InternOldText'Text.SubString2(0,g_Counter.CounterMax)
		End If
	End If
	
	If Text.Length = 0 Then
		xlbl_ClearButton.Visible = False
		xlbl_RevealButton.Visible = False
		xlbl_Hint.Visible = g_Hint.Visible
		MoveFloatingHint(True,True)
	Else
		xlbl_ClearButton.Visible = m_ShowClearButton
		xlbl_RevealButton.Visible = m_PasswordField And m_ShowRevealButton
		xlbl_Hint.Visible = False
		MoveFloatingHint(False,True)
	End If
	
	xlbl_Counter.Text = GetRealTextLength(Text) & "/" & g_Counter.CounterMax
	TextChanged_Event(Text)
	m_InternOldText = Text
End Sub

#If B4J
Private Sub xtf_TextField_Action
	#Else
	Private Sub xtf_TextField_EnterPressed
#End If
	EnterPressed
	#If B4I
	If xtf_TextField.IsInitialized Then xtf_TextField.As(View).ResignFocus
	If xtf_TextFieldPassword.IsInitialized Then xtf_TextFieldPassword.As(View).ResignFocus
	#End If
End Sub



#IF B4I
Private Sub xtf_TextField_BeginEdit
	xlbl_Hint.TextColor = g_Hint.FocusedTextColor
	xlbl_Title.TextColor = g_Title.FocusedTextColor
	FocusChanged(True)
End Sub

Private Sub xtf_TextField_EndEdit
	xlbl_Hint.TextColor = g_Hint.NonFocusedTextColor
	xlbl_Title.TextColor = g_Title.NonFocusedTextColor
	FocusChanged(False)
End Sub
#Else If B4A
Private Sub xtf_TextField_FocusChanged (HasFocus As Boolean)
	If HasFocus Then
		xlbl_Hint.TextColor = g_Hint.FocusedTextColor
		xlbl_Title.TextColor = g_Title.FocusedTextColor
	Else
		xlbl_Hint.TextColor = g_Hint.NonFocusedTextColor
		xlbl_Title.TextColor = g_Title.NonFocusedTextColor
	End If
	FocusChanged(HasFocus)
End Sub
#Else If B4J

Private Sub xtf_TextField_FocusChanged (HasFocus As Boolean)
	If HasFocus Then
		xlbl_Hint.TextColor = g_Hint.FocusedTextColor
		xlbl_Title.TextColor = g_Title.FocusedTextColor
	Else
		xlbl_Hint.TextColor = g_Hint.NonFocusedTextColor
		xlbl_Title.TextColor = g_Title.NonFocusedTextColor
	End If
	
	If getText.Length = 0 Then
		xlbl_FloatingHintTitle.TextColor = xlbl_Hint.TextColor
	Else
		xlbl_FloatingHintTitle.TextColor = xlbl_Title.TextColor
	End If
	
	FocusChanged(HasFocus)
End Sub
#End If
#If B4J
Private Sub xlbl_ClearButton_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_ClearButton_Click
#End If
	ClearButton_Click
End Sub

Private Sub xcb_ComboBox_SelectedIndexChanged (Index As Int)
	xlbl_ButtonText.Text = xcb_ComboBox.SelectedItem
	ComboBoxSelectedIndexChanged(Index)
End Sub

Private Sub ClearButton_Click
	If m_ReadOnly Then Return
	m_OldText = getText
	If xtf_TextField.IsInitialized Then xtf_TextField.Text = ""
	If xtf_TextFieldPassword.IsInitialized Then xtf_TextFieldPassword.Text = ""
	If xtf_Multiline.IsInitialized Then xtf_Multiline.Text = ""
	xlbl_ButtonText.Text = ""
	TextChanged("")
	ClearButtonClick
End Sub

Private Sub RevealButton_Click
	If m_ReadOnly Then Return
	If xlbl_RevealButton.Tag = "reveal" Then
		xlbl_RevealButton.Text = Chr(0xE8F5)
		xlbl_RevealButton.Tag = "hide"
		
		xtf_TextField.Text = xtf_TextFieldPassword.Text
		
		xtf_TextField.Visible = True
		xtf_TextFieldPassword.Visible = False

		xtf_TextField.RequestFocus
		#If B4I
		xtf_TextField.As(TextField).SelectionStart = xtf_TextField.Text.Length
		#Else If B4A
		xtf_TextField.As(EditText).SelectionStart = xtf_TextField.Text.Length
				#Else If B4J
		xtf_TextField.As(TextField).SetSelection(xtf_TextField.Text.Length,xtf_TextField.Text.Length)
		#End If
		PasswordRevealChanged(True)
	Else
		xlbl_RevealButton.Text = Chr(0xE8F4)
		xlbl_RevealButton.Tag = "reveal"
		
		xtf_TextFieldPassword.Text = xtf_TextField.Text
		
		xtf_TextField.Visible = False
		xtf_TextFieldPassword.Visible = True

		xtf_TextFieldPassword.RequestFocus
			#If B4I
		xtf_TextFieldPassword.As(TextField).SelectionStart = xtf_TextFieldPassword.Text.Length
		#Else If B4A
		xtf_TextFieldPassword.As(EditText).SelectionStart = xtf_TextFieldPassword.Text.Length
		#Else If B4J
		xtf_TextFieldPassword.As(TextField).SetSelection(xtf_TextFieldPassword.Text.Length,xtf_TextFieldPassword.Text.Length)
		#End If
		PasswordRevealChanged(False)
	End If
End Sub
#If B4J
Private Sub xlbl_RevealButton_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_RevealButton_Click
#End If
	RevealButton_Click
End Sub
#If B4J
Private Sub xlbl_ButtonText_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_ButtonText_Click
#End If
	If m_ReadOnly = False Then ButtonClick
End Sub

#If B4J
Private Sub xlbl_Title_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Title_Click
#End If
	TitleClick
End Sub

#End Region

#Region Events

Private Sub ClearButtonClick
	If xui.SubExists(mCallBack, mEventName & "_ClearButtonClick",0) Then
		CallSub(mCallBack, mEventName & "_ClearButtonClick")
	End If
End Sub

Private Sub TextChanged_Event(Text As String)
	If m_IgnoreTextChangeEvent = False And xui.SubExists(mCallBack, mEventName & "_TextChanged",1) Then
		CallSub2(mCallBack, mEventName & "_TextChanged",Text)
	End If
	#If B4I
	#If Debug
	Sleep(0)
	#Else
		Sleep(250)
	#End If
	
	#End If

	DrawPasswordStrengthIndicator
End Sub

Private Sub DrawPasswordStrengthIndicator
	If m_PasswordField And m_StrengthIndicator <> "None" Then
	
		If xpnl_PasswordStrengthBackground.NumberOfViews = 0 Then
			
			Dim xpnl_Background As B4XView = xui.CreatePanel("")
			xpnl_PasswordStrengthBackground.AddView(xpnl_Background,0,xpnl_PasswordStrengthBackground.Height/2 - (xpnl_PasswordStrengthBackground.Height/2)/2,xpnl_PasswordStrengthBackground.Width,xpnl_PasswordStrengthBackground.Height/2)
			
			If m_StrengthIndicator = "Line" Then
				Dim xpnl_StrengthLine As B4XView = xui.CreatePanel("")
				xpnl_Background.AddView(xpnl_StrengthLine,0,0,0,xpnl_Background.Height)
				xpnl_Background.SetColorAndBorder(m_BackgroundColor,0,0,2dip)
			Else If m_StrengthIndicator = "Segmented" Then
				xpnl_Background.SetColorAndBorder(xui.Color_Transparent,0,0,2dip)
				Dim xpnl_Segment1 As B4XView = xui.CreatePanel("")
				Dim xpnl_Segment2 As B4XView = xui.CreatePanel("")
				Dim xpnl_Segment3 As B4XView = xui.CreatePanel("")
				
				Dim GapBetween As Float = 5dip
				Dim Width As Float = (xpnl_Background.Width/3) - GapBetween
				
				xpnl_Background.AddView(xpnl_Segment1,0,0,Width,xpnl_Background.Height)
				xpnl_Background.AddView(xpnl_Segment2,xpnl_Background.Width/2-Width/2,0,Width,xpnl_Background.Height)
				xpnl_Background.AddView(xpnl_Segment3,xpnl_Background.Width - Width,0,Width,xpnl_Background.Height)
				
			End If
			
		End If
		
		If m_StrengthIndicator = "Line" Then
			Dim xpnl_StrengthLine As B4XView = xpnl_PasswordStrengthBackground.GetView(0).GetView(0)
		
			Dim PasswordText As String = getText
			Dim PasswordScore2 As Int = PasswordStrengthScore(PasswordText,8,1,1,1,1)
		
			xpnl_StrengthLine.Parent.Width = xpnl_PasswordStrengthBackground.Width
		
			If PasswordText.Length = 0 Then
				xpnl_StrengthLine.SetLayoutAnimated(250,0,0,2dip,xpnl_StrengthLine.Parent.Height)
			else If PasswordScore2 = 1 Then
				xpnl_StrengthLine.SetColorAndBorder(xui.Color_ARGB(255,211, 47, 47),0,0,2dip)
				xpnl_StrengthLine.SetLayoutAnimated(250,0,0,xpnl_StrengthLine.Parent.Width/3,xpnl_StrengthLine.Parent.Height)
			else If PasswordScore2 = 2 Then
				xpnl_StrengthLine.SetColorAndBorder(xui.Color_ARGB(255,239, 108, 0),0,0,2dip)
				xpnl_StrengthLine.SetLayoutAnimated(250,0,0,(xpnl_StrengthLine.Parent.Width/3)*2,xpnl_StrengthLine.Parent.Height)
			else If PasswordScore2 = 3 Then
				xpnl_StrengthLine.SetColorAndBorder(xui.Color_ARGB(255,67, 160, 71),0,0,2dip)
				xpnl_StrengthLine.SetLayoutAnimated(250,0,0,xpnl_StrengthLine.Parent.Width,xpnl_StrengthLine.Parent.Height)
			End If
			
		Else If m_StrengthIndicator = "Segmented" Then
			
			Dim xpnl_Segment1 As B4XView = xpnl_PasswordStrengthBackground.GetView(0).GetView(0)
			Dim xpnl_Segment2 As B4XView = xpnl_PasswordStrengthBackground.GetView(0).GetView(1)
			Dim xpnl_Segment3 As B4XView = xpnl_PasswordStrengthBackground.GetView(0).GetView(2)
			
			xpnl_Segment1.Parent.Width = xpnl_PasswordStrengthBackground.Width
			
			Dim GapBetween As Float = 5dip
			Dim Width As Float = (xpnl_Segment1.Parent.Width/3) - GapBetween
			
			xpnl_Segment1.SetLayoutAnimated(0,0,0,Width,xpnl_Segment1.Parent.Height)
			xpnl_Segment2.SetLayoutAnimated(0,xpnl_Segment1.Parent.Width/2-Width/2,0,Width,xpnl_Segment1.Parent.Height)
			xpnl_Segment3.SetLayoutAnimated(0,xpnl_Segment1.Parent.Width - Width,0,Width,xpnl_Segment1.Parent.Height)
			
			Dim PasswordText As String = getText
			Dim PasswordScore2 As Int = PasswordStrengthScore(PasswordText,8,1,1,1,1)
			
			If PasswordText.Length = 0 Then
				xpnl_Segment1.SetColorAndBorder(m_BackgroundColor,0,0,2dip)
				xpnl_Segment2.SetColorAndBorder(m_BackgroundColor,0,0,2dip)
				xpnl_Segment3.SetColorAndBorder(m_BackgroundColor,0,0,2dip)
			else If PasswordScore2 = 1 Then
				xpnl_Segment1.SetColorAndBorder(xui.Color_ARGB(255,211, 47, 47),0,0,2dip)
				xpnl_Segment2.SetColorAndBorder(m_BackgroundColor,0,0,2dip)
				xpnl_Segment3.SetColorAndBorder(m_BackgroundColor,0,0,2dip)
			else If PasswordScore2 = 2 Then
				xpnl_Segment1.SetColorAndBorder(xui.Color_ARGB(255,211, 47, 47),0,0,2dip)
				xpnl_Segment2.SetColorAndBorder(xui.Color_ARGB(255,239, 108, 0),0,0,2dip)
				xpnl_Segment3.SetColorAndBorder(m_BackgroundColor,0,0,2dip)
			else If PasswordScore2 = 3 Then
				xpnl_Segment1.SetColorAndBorder(xui.Color_ARGB(255,211, 47, 47),0,0,2dip)
				xpnl_Segment2.SetColorAndBorder(xui.Color_ARGB(255,239, 108, 0),0,0,2dip)
				xpnl_Segment3.SetColorAndBorder(xui.Color_ARGB(255,67, 160, 71),0,0,2dip)
			End If
			
		End If
	
	End If
End Sub

Private Sub PasswordStrengthScore(pwd As String,minLength As Int,numUpper As Int,numLower As Int,numNumbers As Int,numSpecial As Int) As Int
	
	'Das Maximum ist 5
	Dim Score As Int
	If pwd.Length >= minLength Then Score = Score +1
	If CountMatches(pwd,"[A-Z]") >= numUpper Then Score = Score +1
	If CountMatches(pwd,"[a-z]") >= numLower Then Score = Score +1
	If CountMatches(pwd,"[a-z]") >= numLower Then Score = Score +1
	If CountMatches(pwd,"[0-9]") >= numNumbers Then Score = Score +1
	If CountMatches(pwd,"[^a-zA-Z0-9]") >= numSpecial Then Score = Score +1
	If pwd.Length <= minLength/2 And pwd.Length > 0 Then Score = 2
	
	If Score <= 2 Then
		Return 1 'Weak
	Else If Score = 3 Or Score = 4 Then
		Return 2 'Medium
	Else If Score = 5 Or Score = 6 Then
		Return 3 'Strong
	Else
		Return 1
	End If
	
End Sub
'1 = Weak
'2 = Medium
'3 = Strong
Public Sub PasswordScore As Int
	Return PasswordStrengthScore(getText,8,1,1,1,1)
End Sub

Private Sub ValidatePassword(pwd As String,minLength As Int,numUpper As Int,numLower As Int,numNumbers As Int,numSpecial As Int) As Boolean 'Ignore
	If pwd.Length < minLength Then Return False
	If CountMatches(pwd,"[A-Z]") < numUpper Then Return False
	If CountMatches(pwd,"[a-z]") < numLower Then Return False
	If CountMatches(pwd,"[0-9]") < numNumbers Then Return False
	If CountMatches(pwd,"[^a-zA-Z0-9]") < numSpecial Then Return False
	' Passed all checks.
	Return True
End Sub

Private Sub CountMatches(text As String,pattern As String) As Int
	Dim tmp_count As Int = 0
	Dim Matcher1 As Matcher
	Matcher1 = Regex.Matcher(pattern, text)
	Do While Matcher1.Find
		tmp_count = tmp_count +1
	Loop
	Return tmp_count
End Sub

Private Sub ComboBoxSelectedIndexChanged(Index As Int)
	If xui.SubExists(mCallBack, mEventName & "_ComboBoxSelectedIndexChanged",1) Then
		CallSub2(mCallBack, mEventName & "_ComboBoxSelectedIndexChanged",Index)
	End If
End Sub

Private Sub OpenComboBoxIntern(x As AS_ComboBoxIntern)
    #if B4A
    x.cmbBox.As(JavaObject).RunMethod("performClick", Null)
    #else if B4J
    x.cmbBox.As(JavaObject).RunMethod("show", Null)
    #else if B4i
	CallSub(x, "btn_click")
    #end if
End Sub

Private Sub TitleClick
	If xui.SubExists(mCallBack, mEventName & "_TitleClick",0) Then
		CallSub(mCallBack, mEventName & "_TitleClick")
	End If
End Sub

Private Sub ButtonClick
	
	If m_Mode = "ComboBox" Then
		OpenComboBoxIntern(xcb_ComboBox)
	End If
	
	If xui.SubExists(mCallBack, mEventName & "_ButtonClick",0) Then
		CallSub(mCallBack, mEventName & "_ButtonClick")
	End If
End Sub

Private Sub FocusChanged(HasFocus As Boolean)
	m_HasFocus = HasFocus
	If m_isInRequiredMode = False Then 
		UpdateTextFieldShape
	End If
	If xui.SubExists(mCallBack, mEventName & "_FocusChanged",1) Then
		CallSub2(mCallBack, mEventName & "_FocusChanged",HasFocus)
	End If
End Sub

Private Sub EnterPressed
	If xui.SubExists(mCallBack, mEventName & "_EnterPressed",0) Then
		CallSub(mCallBack, mEventName & "_EnterPressed")
	End If
End Sub

Private Sub PasswordRevealChanged(Revealed As Boolean)
	If xui.SubExists(mCallBack, mEventName & "_PasswordRevealChanged",1) Then
		CallSub2(mCallBack, mEventName & "_PasswordRevealChanged",Revealed)
	End If
End Sub

Private Sub LeadingIconClick
	If xui.SubExists(mCallBack, mEventName & "_LeadingIconClick",0) Then
		CallSub(mCallBack, mEventName & "_LeadingIconClick")
	End If
End Sub

Private Sub TrailingIconClick
	If xui.SubExists(mCallBack, mEventName & "_TrailingIconClick",0) Then
		CallSub(mCallBack, mEventName & "_TrailingIconClick")
	End If
End Sub

#If B4J
Private Sub xpnl_TextFieldBackground_MouseClicked (EventData As MouseEvent)
	 Focus
End Sub
#End If

#End Region

#Region Functions

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

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

'Private Sub CreateTextField(EventName As String) As B4XView
'	Dim tf As TextField
'	tf.Initialize(EventName)
'	tf.BorderStyle = tf.STYLE_NONE
'	Return tf
'End Sub

Private Sub CreateImageView(EventName As String) As B4XView 'Ignore
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

Private Sub CreateMultineTextField As B4XView 'Ignore
	
	#If B4I
	
	Dim tf As TextView
	tf.Initialize("xtf_TextField")
	tf.Autocorrect = tf.AUTOCORRECT_NO
	
	Dim no As NativeObject = tf
	no.RunMethod("textContainer",Null).SetField("lineFragmentPadding",0)
	'no.SetField("textContainerInset",0)'Top Padding
	
	Select m_KeyboardType
		Case "Numbers"
			tf.KeyboardType = tf.TYPE_NUMBER_PAD
		Case "Decimal"
			tf.KeyboardType = tf.TYPE_NUMBERS_AND_PUNCTUATIONS
	End Select
	Return tf
	#Else If B4J
	
	Dim tf As TextArea
	tf.Initialize("xtf_TextField")
	tf.WrapText = True
	
	CSSUtils.SetStyleProperty(tf,"-fx-control-inner-background","transparent")
	CSSUtils.SetStyleProperty(tf,"-fx-background","transparent")
	CSSUtils.SetStyleProperty(tf,"-fx-faint-focus-color","transparent")
	CSSUtils.SetStyleProperty(tf,"-fx-background-color","transparent")
	

	
'	CSSUtils.SetStyleProperty(tf,"-fx-border-width","0")
'	CSSUtils.SetStyleProperty(tf,"-fx-border-insets","0,0,0,0")
'	CSSUtils.SetStyleProperty(tf,"-fx-background-insets","0,0,0,0")


	
	If m_ToolTipText <> "" Then tf.TooltipText = m_ToolTipText
	Return tf
	#End If

End Sub

Private Sub CreateTextField (Password As Boolean) As B4XView
	'Text|Numbers|Decimal
#if B4J
	Dim tf As TextField
	If Password Then tf.InitializePassword("xtf_TextField") Else tf.Initialize("xtf_TextField")
	CSSUtils.SetStyleProperty(tf, "-fx-padding", "0 0 0 0")
	tf.As(JavaObject).RunMethod("setFocusTraversable", Array As Object(True))
	If m_ToolTipText <> "" Then tf.TooltipText = m_ToolTipText
	Return tf
#else if B4A
	Dim tf As EditText
	tf.Initialize("xtf_TextField")
	tf.SingleLine = IIf(m_Mode = "Multiline",False,True)
	tf.Padding = Array As Int (0, 0, 0, 0)
	tf.PasswordMode = Password
	If Password Then
		If m_KeyboardType <> "Text" Then
			tf.InputType = Bit.Or(tf.INPUT_TYPE_NUMBERS, 16) 'TYPE_NUMBER_VARIATION_PASSWORD
		Else
	'tf.InputType = Bit.Or(tf.PasswordMode = True, 0x00080000)'Bit.Or(0x00000080, 0x00080000) 'TYPE_TEXT_FLAG_NO_SUGGESTIONS | TYPE_TEXT_VARIATION_PASSWORD
			tf.PasswordMode = True
		End If
	Else
		Select m_KeyboardType
			Case "Numbers"
				tf.InputType = tf.INPUT_TYPE_NUMBERS
			Case "Decimal"
				tf.InputType = tf.INPUT_TYPE_DECIMAL_NUMBERS
		End Select
	End If
	Return tf

#else if B4i
		Dim tf As TextField
		tf.Initialize("xtf_TextField")
		tf.BorderStyle = tf.STYLE_NONE
		tf.PasswordMode = Password
		tf.ShowClearButton = False
		tf.Autocorrect = tf.AUTOCORRECT_NO
		Select m_KeyboardType
			Case "Numbers"
				tf.KeyboardType = tf.TYPE_NUMBER_PAD
			Case "Decimal"
				tf.KeyboardType = tf.TYPE_NUMBERS_AND_PUNCTUATIONS
		End Select
	Return tf
#end if
End Sub

'int ot argb
Private Sub GetARGB(Color As Int) As Int()'ignore
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
    Private bmp As Bitmap
    bmp.InitializeMutable(2dip, 2dip)
    Private cvs As Canvas
    cvs.Initialize2(bmp)
    Return cvs.MeasureStringWidth(Text, Font1.ToNativeFont, Font1.Size) + 4dip
#Else If B4i
	Return Text.MeasureWidth(Font1.ToNativeFont) + 4dip
#Else If B4J
    Dim jo As JavaObject
    jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
    jo.RunMethod("setFont",Array(Font1.ToNativeFont))
    jo.RunMethod("setLineSpacing",Array(0.0))
    jo.RunMethod("setWrappingWidth",Array(0.0))
	Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
	Return Bounds.RunMethod("getWidth",Null) + 4dip
#End If
End Sub

Private Sub lettersAndNumbers(Text As String) As String
	Dim enable As String = "abcdefghijklmnopqrstuvwxyzçáãàâäéèêëíìîïóòôõöúùûüçABCDEFGHIJKLMNOPQRSTUVWXYZÁÃÀÂÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÜÇ0123456789"
    
	Dim textClear As StringBuilder
	textClear.Initialize
	For i = 0 To Text.Length-1
		Dim c As String = Text.CharAt(i)
		If enable.Contains(c) Then
			textClear.Append(c)
		End If
	Next
	Return textClear.ToString
End Sub

Private Sub applyMask(Text As String, Mask As String, Start As String) As String
	Dim textClear As String = lettersAndNumbers(Text)
	Dim textMasked As StringBuilder
	textMasked.Initialize
	' Log(textClear)
	Try
        
		'check how many zeros are in the mask -> verifica quantos zeros tem na mascara
		Dim zeros As Int = 0
		For i = 0 To (Mask.Length-1)
			If Mask.CharAt(i)="0" Then
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
			For i = 1 To Mask.Length
				Dim c As Char = Mask.CharAt(i-1)
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
			For i = Mask.Length To 1 Step -1
				Dim c As Char = Mask.CharAt(i-1)
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
	'Log(textMasked.ToString)
	Return textMasked.ToString
End Sub

Private Sub isColorDark(color As Int) As Boolean
    
	Dim darkness As Double = 1 - (0.299 * GetARGB(color)(1) + 0.587 * GetARGB(color)(2) + 0.114 * GetARGB(color)(3))/255
    
	If darkness <= 0.5 Then
		Return    False 'It's a light color
	Else
		Return    True 'It's a dark color
	End If
    
End Sub

#If B4I
'state: 0 = normal, 1 = pressed, 2 = disabled
Private Sub SetButtonTextColor(btn As Button, clr As Int, state As Int)
	Dim no As NativeObject = btn
	no.RunMethod("setTitleColor:forState:", Array(no.ColorToUIColor(clr), state))
End Sub

#End If

#End Region

Private Sub CreateASTextFieldAdvanced_ViewLeadingIcon (xpnl_Background As B4XView, xiv_Icon As B4XView) As ASTextFieldAdvanced_ViewLeadingIcon
	Dim t1 As ASTextFieldAdvanced_ViewLeadingIcon
	t1.Initialize
	t1.xpnl_Background = xpnl_Background
	t1.xiv_Icon = xiv_Icon
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_ViewTrailingIcon (xpnl_Background As B4XView, xiv_Icon As B4XView) As ASTextFieldAdvanced_ViewTrailingIcon
	Dim t1 As ASTextFieldAdvanced_ViewTrailingIcon
	t1.Initialize
	t1.xpnl_Background = xpnl_Background
	t1.xiv_Icon = xiv_Icon
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_LeadingIcon (Visible As Boolean, Icon As B4XBitmap, View As ASTextFieldAdvanced_ViewLeadingIcon) As ASTextFieldAdvanced_LeadingIcon
	Dim t1 As ASTextFieldAdvanced_LeadingIcon
	t1.Initialize
	t1.Visible = Visible
	t1.Icon = Icon
	t1.View = View
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_TrailingIcon (Visible As Boolean, Icon As B4XBitmap, View As ASTextFieldAdvanced_ViewTrailingIcon) As ASTextFieldAdvanced_TrailingIcon
	Dim t1 As ASTextFieldAdvanced_TrailingIcon
	t1.Initialize
	t1.Visible = Visible
	t1.Icon = Icon
	t1.View = View
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_ViewTitle (xlbl_Title2 As B4XView) As ASTextFieldAdvanced_ViewTitle
	Dim t1 As ASTextFieldAdvanced_ViewTitle
	t1.Initialize
	t1.xlbl_Title = xlbl_Title2
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_ViewInformation (xlbl_Information As B4XView) As ASTextFieldAdvanced_ViewInformation
	Dim t1 As ASTextFieldAdvanced_ViewInformation
	t1.Initialize
	t1.xlbl_Information = xlbl_Information
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_Information (Visible As Boolean, Text As String, IgnoreProperties As Boolean, xFont As B4XFont, TextColor As Int, View As ASTextFieldAdvanced_ViewInformation) As ASTextFieldAdvanced_Information
	Dim t1 As ASTextFieldAdvanced_Information
	t1.Initialize
	t1.Visible = Visible
	t1.Text = Text
	t1.IgnoreProperties = IgnoreProperties
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.View = View
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_ViewCounter (xlbl_Counter2 As B4XView) As ASTextFieldAdvanced_ViewCounter
	Dim t1 As ASTextFieldAdvanced_ViewCounter
	t1.Initialize
	t1.xlbl_Counter = xlbl_Counter2
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_Counter (Visible As Boolean, CounterMax As Int, IgnoreProperties As Boolean, xFont As B4XFont, TextColor As Int, View As ASTextFieldAdvanced_ViewCounter) As ASTextFieldAdvanced_Counter
	Dim t1 As ASTextFieldAdvanced_Counter
	t1.Initialize
	t1.Visible = Visible
	t1.CounterMax = CounterMax
	t1.IgnoreProperties = IgnoreProperties
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.View = View
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_ViewHint (xlbl_Hint2 As B4XView) As ASTextFieldAdvanced_ViewHint
	Dim t1 As ASTextFieldAdvanced_ViewHint
	t1.Initialize
	t1.xlbl_Hint = xlbl_Hint2
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_Hint (Visible As Boolean, Text As String, IgnoreProperties As Boolean, FocusedTextColor As Int, NonFocusedTextColor As Int, xFont As B4XFont, View As ASTextFieldAdvanced_ViewHint) As ASTextFieldAdvanced_Hint
	Dim t1 As ASTextFieldAdvanced_Hint
	t1.Initialize
	t1.Visible = Visible
	t1.Text = Text
	t1.IgnoreProperties = IgnoreProperties
	t1.FocusedTextColor = FocusedTextColor
	t1.NonFocusedTextColor = NonFocusedTextColor
	t1.xFont = xFont
	t1.View = View
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_ViewPrefixSuffix (xlbl_PrefixSuffix As B4XView) As ASTextFieldAdvanced_ViewPrefixSuffix
	Dim t1 As ASTextFieldAdvanced_ViewPrefixSuffix
	t1.Initialize
	t1.xlbl_PrefixSuffix = xlbl_PrefixSuffix
	Return t1
End Sub


Private Sub CreateASTextFieldAdvanced_Suffix (Visible As Boolean, Text As String, IgnoreProperties As Boolean, xFont As B4XFont, TextColor As Int, Gap As Float, View As ASTextFieldAdvanced_ViewPrefixSuffix) As ASTextFieldAdvanced_Suffix
	Dim t1 As ASTextFieldAdvanced_Suffix
	t1.Initialize
	t1.Visible = Visible
	t1.Text = Text
	t1.IgnoreProperties = IgnoreProperties
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.Gap = Gap
	t1.View = View
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_Prefix (Visible As Boolean, Text As String, IgnoreProperties As Boolean, xFont As B4XFont, TextColor As Int, Gap As Float, View As ASTextFieldAdvanced_ViewPrefixSuffix) As ASTextFieldAdvanced_Prefix
	Dim t1 As ASTextFieldAdvanced_Prefix
	t1.Initialize
	t1.Visible = Visible
	t1.Text = Text
	t1.IgnoreProperties = IgnoreProperties
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.Gap = Gap
	t1.View = View
	Return t1
End Sub

Private Sub CreateASTextFieldAdvanced_TextFieldProperties (FocusedShapeColor As Int, NonFocusedShapeColor As Int, BorderWidth As Float, CornerRadius As Float) As ASTextFieldAdvanced_TextFieldProperties
	Dim t1 As ASTextFieldAdvanced_TextFieldProperties
	t1.Initialize
	t1.FocusedShapeColor = FocusedShapeColor
	t1.NonFocusedShapeColor = NonFocusedShapeColor
	t1.BorderWidth = BorderWidth
	t1.CornerRadius = CornerRadius
	Return t1
End Sub

Public Sub CreateASTextFieldAdvanced_Title (Visible As Boolean, Text As String, Height As Float, IgnoreProperties As Boolean, xFont As B4XFont, FocusedTextColor As Int, NonFocusedTextColor As Int, HorizontalAlignment As String, View As ASTextFieldAdvanced_ViewTitle) As ASTextFieldAdvanced_Title
	Dim t1 As ASTextFieldAdvanced_Title
	t1.Initialize
	t1.Visible = Visible
	t1.Text = Text
	t1.Height = Height
	t1.IgnoreProperties = IgnoreProperties
	t1.xFont = xFont
	t1.FocusedTextColor = FocusedTextColor
	t1.NonFocusedTextColor = NonFocusedTextColor
	t1.HorizontalAlignment = HorizontalAlignment
	t1.View = View
	Return t1
End Sub