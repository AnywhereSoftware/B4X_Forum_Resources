B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mText As String
	Private mHint As String
	Private mPasswordMode As Boolean
	Private mTextState As UIState
	Private mTextTarget As Object
	Private mTextEventName As String
	Private mTextColor As Int
	Private mHintColor As Int
	Private mBackgroundColor As Int
	Private mBorderColor As Int
	Private mTextColorOverridden As Boolean
	Private mHintColorOverridden As Boolean
	Private mBackgroundColorOverridden As Boolean
	Private mBorderColorOverridden As Boolean
	Private mTheme As UITheme
	Private mTextSize As Int
	Private mTextSizeOverridden As Boolean
	Private mCornerRadius As Int
	Private mCornerRadiusOverridden As Boolean
	Private mBorderWidth As Int
	Private mCustomBackgroundApplied As Boolean
	Private mEditText As EditText
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
	Private mApplyingState As Boolean
	Private mMounted As Boolean
	Private mProgrammaticText As String
	Private mHasProgrammaticText As Boolean
End Sub

' Creates an empty native text input.
Public Sub Initialize As UIInput
	mText = ""
	mHint = ""
	mPasswordMode = False
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mTextColor = mTheme.PrimaryText
	mHintColor = mTheme.HintText
	mTextSize = mTheme.InputTextSize
	mTextSizeOverridden = False
	mBackgroundColor = mTheme.Surface
	mTextColorOverridden = False
	mHintColorOverridden = False
	mBackgroundColorOverridden = False
	mBorderColorOverridden = False
	mCornerRadius = mTheme.InputRadius
	mCornerRadiusOverridden = False
	mBorderWidth = 0
	mBorderColor = mTheme.Border
	mCustomBackgroundApplied = False
	mTextTarget = Null
	mTextEventName = ""
	mApplyingState = False
	mMounted = False
	mProgrammaticText = ""
	mHasProgrammaticText = False
	Return Me
End Sub

' Sets the text shown when the input is empty.
Public Sub Hint(Value As String) As UIInput
	mHint = Value
	Return Me
End Sub

' Sets a static text value and removes any state binding.
Public Sub PasswordMode(Enabled As Boolean) As UIInput
    mPasswordMode = Enabled
    If mEditText <> Null Then
        If mEditText.IsInitialized Then mEditText.PasswordMode = Enabled
    End If
    Return Me
End Sub

Public Sub Text(Value As String) As UIInput
	UnbindText
	mText = Value
	If mEditText <> Null Then
		If mEditText.IsInitialized Then ApplyTextToNative
	End If
	Return Me
End Sub

' Binds the input text to a UIState.
' The binding is one-way: the host decides whether to update the state from OnTextChanged.
Public Sub BindText(State As UIState) As UIInput
	UnbindText
	mTextState = State
	If mTextState <> Null Then
		If mTextState.IsInitialized Then
			mText = StateText(mTextState.GetState)
			mTextState.Subscribe(Me, "TextState_Changed")
			If mEditText <> Null Then
				If mEditText.IsInitialized Then ApplyTextToNative
			End If
		End If
	End If
	Return Me
End Sub

' Removes the state binding while preserving the current input text.
Public Sub UnbindText As UIInput
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = Null
	Return Me
End Sub

' Registers a normal B4A callback for user edits.
' The callback signature is: Sub EventName(NewText As String)
Public Sub OnTextChanged(Target As Object, EventName As String) As UIInput
	mTextTarget = Target
	mTextEventName = EventName
	Return Me
End Sub

Public Sub TextColor(Color As Int) As UIInput
	mTextColor = Color
	mTextColorOverridden = True
	Return Me
End Sub

Public Sub BackgroundColor(Color As Int) As UIInput
	mBackgroundColor = Color
	mBackgroundColorOverridden = True
	Return Me
End Sub

' Sets the hint color explicitly. The theme value is used by default.
Public Sub HintColor(Color As Int) As UIInput
	mHintColor = Color
	mHintColorOverridden = True
	If mEditText <> Null Then
		If mEditText.IsInitialized Then mEditText.HintColor = mHintColor
	End If
	Return Me
End Sub

' Applies theme defaults without replacing explicit color overrides.
Public Sub ApplyTheme(Theme As UITheme) As UIInput
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mTextColorOverridden = False Then mTextColor = mTheme.PrimaryText
	If mHintColorOverridden = False Then mHintColor = mTheme.HintText
	If mTextSizeOverridden = False Then mTextSize = mTheme.InputTextSize
	If mBackgroundColorOverridden = False Then mBackgroundColor = mTheme.Surface
	If mCornerRadiusOverridden = False Then mCornerRadius = mTheme.InputRadius
	If mBorderColorOverridden = False Then mBorderColor = mTheme.Border
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

' Sets the corner radius in pixels. Zero preserves the native EditText background.
Public Sub CornerRadius(Radius As Int) As UIInput
	mCornerRadius = Max(0, Radius)
	mCornerRadiusOverridden = True
	Return Me
End Sub

' Sets the input text size explicitly, in scaled pixels.
Public Sub TextSize(Size As Int) As UIInput
	mTextSize = Max(1, Size)
	mTextSizeOverridden = True
	Return Me
End Sub

' Sets an optional border for a custom rounded input background.
Public Sub Border(Width As Int, Color As Int) As UIInput
	mBorderWidth = Max(0, Width)
	mBorderColor = Color
	mBorderColorOverridden = True
	Return Me
End Sub

' Returns the currently displayed text.
Public Sub GetText As String
	If mEditText <> Null Then
		If mEditText.IsInitialized Then Return mEditText.Text
	End If
	Return mText
End Sub

Public Sub SetParent(Parent As B4XView)
	mParent = Parent
End Sub

Public Sub SetPosition(Left As Int, Top As Int)
	mLeft = Left
	mTop = Top
End Sub

Public Sub SetSize(Width As Int, Height As Int)
	mWidth = Max(0, Width)
	mHeight = Max(0, Height)
End Sub

Public Sub Render
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return
	If mTextState <> Null Then
		If mTextState.IsInitialized Then
			mText = StateText(mTextState.GetState)
			mTextState.Subscribe(Me, "TextState_Changed")
		End If
	End If

	Dim needsCreate As Boolean = False
	If mEditText = Null Then
		needsCreate = True
	Else If mEditText.IsInitialized = False Then
		needsCreate = True
	End If
	If mCustomBackgroundApplied And mCornerRadius = 0 And mBorderWidth = 0 Then
		' Recreate the native control to restore its original drawable, focus state and padding.
		If mBaseView <> Null Then
			If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
		End If
		mEditText = Null
		mBaseView = Null
		mCustomBackgroundApplied = False
		needsCreate = True
	End If
	If needsCreate Then
		Dim nativeInput As EditText
		nativeInput.Initialize("NativeInput")
		mEditText = nativeInput
		mBaseView = mEditText
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	If mBaseView = Null Then Return
	If mBaseView.IsInitialized = False Then Return
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If

	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mEditText.TextColor = mTextColor
	mEditText.HintColor = mHintColor
	mEditText.TextSize = mTextSize
	mEditText.PasswordMode = mPasswordMode
	If mCornerRadius > 0 Or mBorderWidth > 0 Then
		Dim inputBackground As ColorDrawable
		inputBackground.Initialize2(mBackgroundColor, mCornerRadius, mBorderWidth, mBorderColor)
		mEditText.Background = inputBackground
		mCustomBackgroundApplied = True
		' A custom background can replace the native EditText inset.
		mEditText.Padding = Array As Int(mTheme.InputHorizontalPadding, mTheme.InputVerticalPadding, mTheme.InputHorizontalPadding, mTheme.InputVerticalPadding)
	Else
		mEditText.Color = mBackgroundColor
	End If
	mEditText.Hint = mHint
	mEditText.Gravity = Gravity.CENTER_VERTICAL
	ApplyTextToNative
	mMounted = True
End Sub

Private Sub ApplyTextToNative
	If mEditText = Null Then Return
	If mEditText.IsInitialized = False Then Return
	If mEditText.Text = mText Then Return
	' Programmatic updates must not be reported as user edits.
	' Keep a marker as well as the guard because some native EditText events
	' may be delivered after the assignment returns.
	mApplyingState = True
	mProgrammaticText = mText
	mHasProgrammaticText = True
	mEditText.Text = mText
	mApplyingState = False
End Sub

Private Sub TextState_Changed(State As UIState)
	If State = Null Then Return
	If State.IsInitialized = False Then Return
	mText = StateText(State.GetState)
	ApplyTextToNative
End Sub

' Converts any state value to display text without relying on B4A type tests.
' UIState commonly contains Int values, which must not be parsed as Boolean.
Private Sub StateText(Value As Object) As String
	Dim valueText As String = ("" & Value).Trim
	If IsNumber(valueText) Then
		Dim number As Double = valueText
		Dim groupingUsed As Boolean = False
		If number = Floor(number) And Abs(number) < 1000000000000 Then
			Return NumberFormat2(number, 0, 12, 0, groupingUsed)
		End If
	End If
	Return valueText
End Sub

' Native B4A EditText event. The callback is intentionally not a two-way binding.
Private Sub NativeInput_TextChanged(Old As String, New As String)
	Dim source As EditText = Sender
	If mMounted = False Then Return
	If mEditText = Null Or source <> mEditText Then Return
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return
	If mApplyingState Then Return
	If mHasProgrammaticText Then
		If New = mProgrammaticText Then
			mHasProgrammaticText = False
			Return
		End If
		' Any different value from the currently mounted control is a real
		' user edit, including an intentional empty value.
		mHasProgrammaticText = False
	End If
	mText = New
	If mTextTarget = Null Or mTextEventName.Trim = "" Then Return
	If SubExists(mTextTarget, mTextEventName) Then CallSub2(mTextTarget, mTextEventName, New)
End Sub

Public Sub Detach
	mMounted = False
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then
			If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		End If
	End If
	mParent = Null
End Sub

' Returns the mounted native EditText for lifecycle diagnostics or animation.
Public Sub GetView As B4XView
	If mBaseView = Null Then Return Null
	If mBaseView.IsInitialized = False Then Return Null
	Return mBaseView
End Sub

Public Sub Unmount
	mMounted = False
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
	End If
	mEditText = Null
	mBaseView = Null
	mParent = Null
	mHasProgrammaticText = False
End Sub

' Natural measurement used by parent layout containers.
' The input keeps a touch-friendly minimum height and a measured text width.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize

	Dim measureText As String = mText
	If measureText = "" Then measureText = mHint
	Dim bmp As Bitmap
	bmp.InitializeMutable(1dip, 1dip)
	Dim cvs As Canvas
	cvs.Initialize2(bmp)
	Dim textWidth As Float = cvs.MeasureStringWidth(measureText, Typeface.DEFAULT, mTextSize)
	Dim naturalWidth As Int = textWidth + 2 * mTheme.InputHorizontalPadding
	Dim naturalHeight As Int = mTheme.ControlHeight

	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	result.Add(Min(naturalWidth, safeMaxWidth))
	result.Add(Min(naturalHeight, safeMaxHeight))
	Return result
End Sub