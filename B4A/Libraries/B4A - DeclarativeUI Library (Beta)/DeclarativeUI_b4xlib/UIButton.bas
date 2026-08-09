B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mText As String
	Private mTextState As UIState
	Private mColor As Int
	Private mTextColor As Int
	Private mBorderColor As Int
	Private mColorOverridden As Boolean
	Private mTextColorOverridden As Boolean
	Private mBorderColorOverridden As Boolean
	Private mTheme As UITheme
	Private mTextSize As Int
	Private mTextSizeOverridden As Boolean
	Private mCornerRadius As Int
	Private mCornerRadiusOverridden As Boolean
	Private mBorderWidth As Int
	Private mCustomBackgroundApplied As Boolean
	Private mTarget As Object
	Private mEventName As String
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UIButton
	mText = ""
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mColor = mTheme.SurfaceVariant
	mTextColor = mTheme.ButtonText
	mTextSize = mTheme.ButtonTextSize
	mTextSizeOverridden = False
	mColorOverridden = False
	mTextColorOverridden = False
	mBorderColorOverridden = False
	mCornerRadius = mTheme.ButtonRadius
	mCornerRadiusOverridden = False
	mBorderWidth = 0
	mBorderColor = mTheme.Border
	mCustomBackgroundApplied = False
	' Clear the callback target so a new instance starts in a predictable state.
	mTarget = Null
	mEventName = ""
	Return Me
End Sub

Public Sub Text(t As String) As UIButton
	' An explicit text replaces any previous state binding.
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = Null
	mText = t
	Return Me
End Sub

' Binds the button text to an observable UIState.
Public Sub BindText(State As UIState) As UIButton
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = State
	If mTextState <> Null Then
		If mTextState.IsInitialized Then
			mText = StateText(mTextState.GetState)
			mTextState.Subscribe(Me, "TextState_Changed")
			If mParent <> Null Then
				If mParent.IsInitialized Then Render
			End If
		End If
	End If
	Return Me
End Sub

' Removes the text binding while preserving the current displayed text.
Public Sub UnbindText As UIButton
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = Null
	Return Me
End Sub

Private Sub TextState_Changed(State As UIState)
	If State = Null Then Return
	If State.IsInitialized = False Then Return
	mText = StateText(State.GetState)
	Render
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

Public Sub BackgroundColor(c As Int) As UIButton
	mColor = c
	mColorOverridden = True
	Return Me
End Sub

Public Sub TextColor(c As Int) As UIButton
	mTextColor = c
	mTextColorOverridden = True
	Return Me
End Sub

' Applies theme defaults without replacing explicit color overrides.
Public Sub ApplyTheme(Theme As UITheme) As UIButton
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mColorOverridden = False Then mColor = mTheme.SurfaceVariant
	If mTextColorOverridden = False Then mTextColor = mTheme.ButtonText
	If mTextSizeOverridden = False Then mTextSize = mTheme.ButtonTextSize
	If mCornerRadiusOverridden = False Then mCornerRadius = mTheme.ButtonRadius
	If mBorderColorOverridden = False Then mBorderColor = mTheme.Border
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

' Sets the corner radius in pixels. Zero preserves the native button background.
Public Sub CornerRadius(Radius As Int) As UIButton
	mCornerRadius = Max(0, Radius)
	mCornerRadiusOverridden = True
	Return Me
End Sub

' Sets the button text size explicitly, in scaled pixels.
Public Sub TextSize(Size As Int) As UIButton
	mTextSize = Max(1, Size)
	mTextSizeOverridden = True
	Return Me
End Sub

' Sets an optional border for a custom rounded button background.
Public Sub Border(Width As Int, Color As Int) As UIButton
	mBorderWidth = Max(0, Width)
	mBorderColor = Color
	mBorderColorOverridden = True
	Return Me
End Sub

Public Sub OnClick(Target As Object, EventName As String) As UIButton
	mTarget = Target
	mEventName = EventName
	Return Me
End Sub

Public Sub SetParent(Parent As B4XView)
	mParent = Parent
End Sub

Public Sub SetPosition(Left As Int, Top As Int)
	mLeft = Left
	mTop = Top
End Sub

Public Sub SetSize(Width As Int, Height As Int)
	mWidth = Width
	mHeight = Height
End Sub

Public Sub Render
	If mParent = Null Then
		Return
	End If
	If mParent.IsInitialized = False Then
		Return
	End If
	If mTextState <> Null Then
		If mTextState.IsInitialized Then
			mText = StateText(mTextState.GetState)
			mTextState.Subscribe(Me, "TextState_Changed")
		End If
	End If

	Dim needsCreate As Boolean = False
	If mBaseView = Null Then
		needsCreate = True
	Else If mBaseView.IsInitialized = False Then
		needsCreate = True
	End If
	If mCustomBackgroundApplied And mCornerRadius = 0 And mBorderWidth = 0 Then
		' Recreate the native control to restore its original drawable and states.
		If mBaseView <> Null Then
			If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
		End If
		mBaseView = Null
		mCustomBackgroundApplied = False
		needsCreate = True
	End If
	If needsCreate Then
		Dim btn As Button
		btn.Initialize("NativeBtn")
		mBaseView = btn
		mBaseView.Tag = Me
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mBaseView.Tag = Me
	' Keep content buttons above remounted siblings so their touch surface remains available.
	mBaseView.BringToFront
    
	If mBaseView.Text <> mText Then mBaseView.Text = mText
	mBaseView.TextSize = mTextSize
	If mCornerRadius > 0 Or mBorderWidth > 0 Then
		Dim buttonBackground As ColorDrawable
		buttonBackground.Initialize2(mColor, mCornerRadius, mBorderWidth, mBorderColor)
		Dim nativeButton As Button = mBaseView
		nativeButton.Background = buttonBackground
		mCustomBackgroundApplied = True
	Else
		If mBaseView.Color <> mColor Then mBaseView.Color = mColor
	End If
	If mBaseView.TextColor <> mTextColor Then mBaseView.TextColor = mTextColor
End Sub

Public Sub Unmount
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mBaseView = Null
	mParent = Null
End Sub

Private Sub NativeBtn_Click
	Dim btn As Button = Sender
	Dim instance As UIButton = btn.Tag
	If instance = Null Then Return
	instance.DispatchClick
End Sub

' Dispatches the configured callback only when the target exposes it.
Private Sub DispatchClick
	If mTarget = Null Or mEventName.Trim = "" Then Return
	If SubExists(mTarget, mEventName) Then CallSub(mTarget, mEventName)
End Sub

Public Sub TriggerClick
	DispatchClick
End Sub

' Natural measurement used by parent layout containers.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	' Measure the button label with the standard B4A Canvas API.
	Dim bmp As Bitmap
	bmp.InitializeMutable(1dip, 1dip)
	Dim cvs As Canvas
	cvs.Initialize2(bmp)
	Dim textWidth As Float = cvs.MeasureStringWidth(mText, Typeface.DEFAULT, mTextSize)
	
	' Use the theme's touch target and horizontal padding tokens.
	Dim btnPadding As Int = mTheme.ButtonHorizontalPadding
	Dim naturalWidth As Int = textWidth + btnPadding
	Dim naturalHeight As Int = mTheme.ControlHeight
	
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	result.Add(Min(naturalWidth, safeMaxWidth))
	result.Add(Min(naturalHeight, safeMaxHeight))
	Return result
End Sub