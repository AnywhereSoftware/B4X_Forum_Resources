B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private mValue As String
	Private mText As String
	Private mTextState As UIState
	Private mSelected As Boolean
	Private mSelectedState As UIState
	Private mTextColor As Int
	Private mSelectedColor As Int
	Private mUnselectedColor As Int
	Private mTextSize As Int
	Private mTextColorOverridden As Boolean
	Private mSelectedColorOverridden As Boolean
	Private mUnselectedColorOverridden As Boolean
	Private mTextSizeOverridden As Boolean
	Private mTheme As UITheme
	Private mGroup As Object
	Private mTarget As Object
	Private mEventName As String
	Private mBaseView As B4XView
	Private mBasePanel As Panel
	Private mIndicatorView As Panel
	Private mInnerView As Panel
	Private mLabelView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
	Private mIndicatorSize As Int
End Sub

Public Sub Initialize As UIRadioButton
	mValue = ""
	mText = ""
	mTextState = Null
	mSelected = False
	mSelectedState = Null
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mTextColor = mTheme.PrimaryText
	mSelectedColor = mTheme.Accent
	mUnselectedColor = mTheme.MutedText
	mTextSize = mTheme.BodyLarge
	mTextColorOverridden = False
	mSelectedColorOverridden = False
	mUnselectedColorOverridden = False
	mTextSizeOverridden = False
	mGroup = Null
	mTarget = Null
	mEventName = ""
	mBaseView = Null
	mBasePanel = Null
	mIndicatorView = Null
	mInnerView = Null
	mLabelView = Null
	mParent = Null
	mIndicatorSize = 24dip
	Return Me
End Sub

Public Sub Value(Id As String) As UIRadioButton
	mValue = Id
	Return Me
End Sub

Public Sub GetValue As String
	Return mValue
End Sub

Public Sub Text(InputText As String) As UIRadioButton
	UnbindText
	mText = InputText
	ApplyTextToNative
	Return Me
End Sub

Public Sub BindText(State As UIState) As UIRadioButton
	UnbindText
	mTextState = State
	If mTextState <> Null Then
		If mTextState.IsInitialized Then
			mText = StateText(mTextState.GetState)
			mTextState.Subscribe(Me, "TextState_Changed")
			ApplyTextToNative
		End If
	End If
	Return Me
End Sub

Public Sub UnbindText As UIRadioButton
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = Null
	Return Me
End Sub

Public Sub Selected(IsSelectedValue As Boolean) As UIRadioButton
	If mGroup <> Null And IsSelectedValue Then
		CallSub2(mGroup, "RadioButtonSelected", Me)
	Else
		SetSelectedFromGroup(IsSelectedValue)
	End If
	Return Me
End Sub

Public Sub IsSelected As Boolean
	Return mSelected
End Sub

Public Sub BindSelected(State As UIState) As UIRadioButton
	UnbindSelected
	mSelectedState = State
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then
			mSelected = ReadBoolean(mSelectedState.GetState)
			mSelectedState.Subscribe(Me, "SelectedState_Changed")
			ApplyVisualState
		End If
	End If
	Return Me
End Sub

Public Sub UnbindSelected As UIRadioButton
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then mSelectedState.Unsubscribe(Me, "SelectedState_Changed")
	End If
	mSelectedState = Null
	Return Me
End Sub

Public Sub AttachGroup(Group As Object) As UIRadioButton
	mGroup = Group
	Return Me
End Sub

Public Sub SetSelectedFromGroup(IsSelectedValue As Boolean)
	mSelected = IsSelectedValue
	ApplyVisualState
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then mSelectedState.SetState(mSelected)
	End If
End Sub

Public Sub OnChanged(Target As Object, EventName As String) As UIRadioButton
	mTarget = Target
	mEventName = EventName
	Return Me
End Sub

Public Sub TextColor(Color As Int) As UIRadioButton
	mTextColor = Color
	mTextColorOverridden = True
	ApplyTextColorToNative
	Return Me
End Sub

Public Sub SelectedColor(Color As Int) As UIRadioButton
	mSelectedColor = Color
	mSelectedColorOverridden = True
	ApplyVisualState
	Return Me
End Sub

Public Sub UnselectedColor(Color As Int) As UIRadioButton
	mUnselectedColor = Color
	mUnselectedColorOverridden = True
	ApplyVisualState
	Return Me
End Sub

Public Sub TextSize(Size As Int) As UIRadioButton
	mTextSize = Max(1, Size)
	mTextSizeOverridden = True
	ApplyTextSizeToNative
	Return Me
End Sub

Public Sub ApplyTheme(Theme As UITheme) As UIRadioButton
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mTextColorOverridden = False Then mTextColor = mTheme.PrimaryText
	If mSelectedColorOverridden = False Then mSelectedColor = mTheme.Accent
	If mUnselectedColorOverridden = False Then mUnselectedColor = mTheme.MutedText
	If mTextSizeOverridden = False Then mTextSize = mTheme.BodyLarge
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
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
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then
			mSelected = ReadBoolean(mSelectedState.GetState)
			mSelectedState.Subscribe(Me, "SelectedState_Changed")
		End If
	End If

	Dim needsCreate As Boolean = False
	If mBasePanel = Null Then
		needsCreate = True
	Else If mBasePanel.IsInitialized = False Then
		needsCreate = True
	End If
	If needsCreate Then
		Dim basePanel As Panel
		basePanel.Initialize("NativeRadioButton")
		mBasePanel = basePanel
		mBaseView = mBasePanel
		mBaseView.Color = Colors.Transparent
		mBaseView.Tag = Me
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)

		Dim indicator As Panel
		indicator.Initialize("NativeRadioButton")
		mIndicatorView = indicator
		mBaseView.AddView(mIndicatorView, 0, 0, mIndicatorSize, mIndicatorSize)

		Dim inner As Panel
		inner.Initialize("NativeRadioButton")
		mInnerView = inner
		mIndicatorView.AddView(mInnerView, 0, 0, 0, 0)

		Dim label As Label
		label.Initialize("NativeRadioButton")
		mLabelView = label
		mBaseView.AddView(mLabelView, mIndicatorSize + 12dip, 0, 1dip, mHeight)
	End If
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If

	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	Dim indicatorTop As Int = Max(0, (mHeight - mIndicatorSize) / 2)
	mIndicatorView.SetLayoutAnimated(0, 0, indicatorTop, mIndicatorSize, mIndicatorSize)
	Dim labelLeft As Int = mIndicatorSize + 12dip
	Dim labelWidth As Int = Max(0, mWidth - labelLeft)
	mLabelView.SetLayoutAnimated(0, labelLeft, 0, labelWidth, mHeight)
	Dim nativeLabel As Label = mLabelView
	nativeLabel.Gravity = Gravity.CENTER_VERTICAL
	ApplyTextToNative
	ApplyTextColorToNative
	ApplyTextSizeToNative
	ApplyVisualState
End Sub

Private Sub ApplyTextToNative
	If mLabelView = Null Then Return
	If mLabelView.IsInitialized = False Then Return
	mLabelView.Text = mText
End Sub

Private Sub ApplyTextColorToNative
	If mLabelView = Null Then Return
	If mLabelView.IsInitialized = False Then Return
	mLabelView.TextColor = mTextColor
End Sub

Private Sub ApplyTextSizeToNative
	If mLabelView = Null Then Return
	If mLabelView.IsInitialized = False Then Return
	mLabelView.TextSize = mTextSize
End Sub

Private Sub ApplyVisualState
	If mIndicatorView = Null Or mInnerView = Null Then Return
	If mIndicatorView.IsInitialized = False Or mInnerView.IsInitialized = False Then Return
	Dim outerColor As Int = mUnselectedColor
	If mSelected Then outerColor = mSelectedColor
	Dim outer As ColorDrawable
	outer.Initialize2(outerColor, mIndicatorSize / 2, 2dip, outerColor)
	mIndicatorView.Background = outer
	Dim nativeInner As Panel = mInnerView
	If mSelected Then
		Dim innerSize As Int = Max(0, mIndicatorSize - 12dip)
		Dim innerDrawable As ColorDrawable
		innerDrawable.Initialize2(mSelectedColor, innerSize / 2, 0, 0)
		nativeInner.Background = innerDrawable
		nativeInner.SetLayoutAnimated(0, 6dip, 6dip, innerSize, innerSize)
	Else
		nativeInner.SetLayoutAnimated(0, 0, 0, 0, 0)
	End If
End Sub

Private Sub NativeRadioButton_Touch(Action As Int, X As Float, Y As Float)
	If Action <> 1 Then Return
	If mGroup <> Null Then
		CallSub2(mGroup, "RadioButtonSelected", Me)
	Else
		mSelected = True
		If mSelectedState <> Null Then
			If mSelectedState.IsInitialized Then mSelectedState.SetState(mSelected)
		End If
		ApplyVisualState
		DispatchChanged
	End If
End Sub

Private Sub DispatchChanged
	If mTarget = Null Then Return
	If mEventName.Trim = "" Then Return
	If SubExists(mTarget, mEventName) Then CallSub2(mTarget, mEventName, mSelected)
End Sub

Private Sub TextState_Changed(State As UIState)
	If State = Null Then Return
	If State.IsInitialized = False Then Return
	mText = StateText(State.GetState)
	ApplyTextToNative
End Sub

Private Sub SelectedState_Changed(State As UIState)
	If State = Null Then Return
	If State.IsInitialized = False Then Return
	mSelected = ReadBoolean(State.GetState)
	ApplyVisualState
End Sub

Private Sub ReadBoolean(InputValue As Object) As Boolean
	If InputValue = Null Then Return False
	Dim normalized As String = ("" & InputValue).Trim.ToLowerCase
	If normalized = "true" Then Return True
	If normalized = "false" Or normalized = "" Then Return False
	If IsNumber(normalized) Then
		Dim numberValue As Double = normalized
		Return numberValue <> 0
	End If
	Return False
End Sub

Private Sub StateText(InputValue As Object) As String
	If InputValue = Null Then Return ""
	Return "" & InputValue
End Sub

Public Sub Detach
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then
			If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		End If
	End If
	mParent = Null
End Sub

Public Sub Unmount
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then mSelectedState.Unsubscribe(Me, "SelectedState_Changed")
	End If
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
	End If
	mBasePanel = Null
	mBaseView = Null
	mIndicatorView = Null
	mInnerView = Null
	mLabelView = Null
	mParent = Null
End Sub

Public Sub GetView As B4XView
	If mBaseView = Null Then Return Null
	If mBaseView.IsInitialized = False Then Return Null
	Return mBaseView
End Sub

Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	Dim bmp As Bitmap
	bmp.InitializeMutable(1dip, 1dip)
	Dim cvs As Canvas
	cvs.Initialize2(bmp)
	Dim textWidth As Float = cvs.MeasureStringWidth(mText, Typeface.DEFAULT, mTextSize)
	Dim naturalWidth As Int = textWidth + mIndicatorSize + 12dip
	Dim naturalHeight As Int = Max(mTheme.ControlHeight, mIndicatorSize)
	result.Add(Min(naturalWidth, safeMaxWidth))
	result.Add(Min(naturalHeight, safeMaxHeight))
	Return result
End Sub