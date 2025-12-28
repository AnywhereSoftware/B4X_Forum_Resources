B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.78
@EndOfDesignText@
#DesignerProperty: Key: HintColor, DisplayName: Focused Hint Color, FieldType: Color, DefaultValue: 0xFF008EFF
#DesignerProperty: Key: NonFocusedHintColor, DisplayName: Non Focused Hint Color, FieldType: Color, DefaultValue: 0xFF393939
#DesignerProperty: Key: Hint, DisplayName: Hint Text, FieldType: String, DefaultValue: Hint
#DesignerProperty: Key: PasswordField, DisplayName: Password Field, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: Multiline, DisplayName: Multiline, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: ShowClear, DisplayName: Show Clear Button, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowAccept, DisplayName: Show Accept Button, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowRevealButton, DisplayName: Show Reveal Button, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: KeyboardType, DisplayName: Keyboard Type, FieldType: String, List: Text|Numbers|Decimal, DefaultValue: Text

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
	Public AnimationDuration As Int = 200
	Public LargeLabelTextSize = 18, SmallLabelTextSize = 14 As Float
	Private LargeLabel As Boolean
	Private MeasuringCanvas As B4XCanvas
	Public HintColor As Int
	Public NonFocusedHintColor As Int
	Private HintImageView As B4XView
	Public HintText As String
	Public HintFont As B4XFont
	Private LargeFocused, LargeNotFocused, SmallFocused, SmallNotFocused As B4XBitmap
	Public Focused As Boolean
	Public lblClear As B4XView
	Public lblV As B4XView
	Private mProps As Map
	Public Tag As Object
	Private KeyboardType As String 'ignore
	Private Multiline As Boolean
	Private mNextTextField As B4XFloatTextField
	#if B4A
	Private IME As IME
	#End If
	#if B4J
	Private ToolTip As String
	#End If
	Public HintLabelLargeOffsetX, HintLabelSmallOffsetY = 2dip, HintLabelSmallOffsetX = 2dip As Int
	Private LastSwitchTextFieldTime As Long
	Private mEnabled As Boolean = True
	Public ShowAcceptButtonWhenEmpty As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	If xui.IsB4A Then
		HintLabelLargeOffsetX = 6dip
	Else
		HintLabelLargeOffsetX = 12dip
	End If
	#if B4A
	IME.Initialize("ime")
	#end if
	#if B4J AND DEBUG
	Dim jo As JavaObject = Me
	jo.RunMethod("RemoveWarning", Null)
	#end if
	ShowAcceptButtonWhenEmpty = xui.IsB4i
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
	HintFont = PassedLabel.Font
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

Private Sub CreateTextFieldAll (PasswordMode As Boolean, Font1 As B4XFont, TextColor As Int)
	mTextField = CreateTextField (PasswordMode)
	mTextField.Font = Font1
	mTextField.TextColor = TextColor
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

Public Sub Base_Resize (Width As Double, Height As Double)
	mTextField.SetLayoutAnimated(0, 0, 0, Width, Height)
	Dim FirstDistance As Int = 2dip
	If Multiline And xui.IsB4J Then FirstDistance = 22dip
	If lblV.IsInitialized Then
		lblV.SetLayoutAnimated(0, Width - lblV.Width - FirstDistance, 0, lblV.Width, Height)
		FirstDistance = FirstDistance + lblV.Width + 2dip
	End If
	If lblClear.IsInitialized Then
		lblClear.SetLayoutAnimated(0, Width - lblClear.Width - FirstDistance, 0, lblClear.Width, Height)
	End If
	UpdateLabel(mTextField.Text, True)
End Sub

Private Sub UpdateLabel (txt As String, force As Boolean)
	For Each lbl As B4XView In Array As B4XView(lblClear, lblV)
		If lbl.IsInitialized Then lbl.Visible = Focused And ((ShowAcceptButtonWhenEmpty And lbl = lblV) Or txt.Length > 0) And mEnabled
	Next
	
	Dim GoingToLarge As Boolean = txt.Length = 0
	If GoingToLarge = LargeLabel And force = False Then Return
	Dim b As B4XBitmap
	If Focused Then
		If GoingToLarge Then b = LargeFocused Else b = SmallFocused
	Else
		If GoingToLarge Then b = LargeNotFocused Else b = SmallNotFocused
	End If
	If b.IsInitialized = False Then Return
	HintImageView.SetBitmap(b)
	If GoingToLarge Then
		HintImageView.SetLayoutAnimated (AnimationDuration, HintLabelLargeOffsetX, mBase.Height / 2 - b.Height / 2, b.Width, b.Height)
		LargeLabel = True
	Else
		HintImageView.SetLayoutAnimated(AnimationDuration, HintLabelSmallOffsetX, HintLabelSmallOffsetY, b.Width, b.Height)
		LargeLabel = False
	End If
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

'Call after changing the hint properties
Public Sub Update
	Dim f As B4XFont =  xui.CreateFont2(HintFont, LargeLabelTextSize)
	Dim r As B4XRect = MeasuringCanvas.MeasureText(HintText, f)
	LargeFocused = CreateBitmap(r, HintColor, f)
	LargeNotFocused = CreateBitmap(r, NonFocusedHintColor, f)
	f = xui.CreateFont2(HintFont, SmallLabelTextSize)
	Dim r As B4XRect = MeasuringCanvas.MeasureText(HintText, f)
	SmallFocused = CreateBitmap(r, HintColor, f)
	SmallNotFocused = CreateBitmap(r, NonFocusedHintColor, f)
	UpdateLabel(mTextField.Text, True)
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
	UpdateLabel(New, False)
	If xui.SubExists(mCallBack, mEventName & "_TextChanged", 2) And mTextField.IsInitialized Then
		CallSub3(mCallBack, mEventName & "_TextChanged", Old, New)
	End If
End Sub

'Gets or sets the next field that will be focused when enter or accept button are pressed.
Public Sub getNextField As B4XFloatTextField
	Return mNextTextField
End Sub

Public Sub setNextField (Field As B4XFloatTextField)
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

'Gets or sets whether the field is enabled.
Public Sub setEnabled (b As Boolean)
	mEnabled = b
	mTextField.Enabled = b
	UpdateLabel(mTextField.Text, False)
End Sub

Public Sub getEnabled As Boolean
	Return mEnabled
End Sub

Private Sub lc_Click
	If mEnabled = False Then Return
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

