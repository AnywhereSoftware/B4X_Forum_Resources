B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private mText As String
	Private mTextState As UIState
	Private mChecked As Boolean
	Private mCheckedState As UIState
	Private mTextColor As Int
	Private mBackgroundColor As Int
	Private mTextSize As Int
	Private mTextColorOverridden As Boolean
	Private mBackgroundColorOverridden As Boolean
	Private mTextSizeOverridden As Boolean
	Private mTheme As UITheme
	Private mTarget As Object
	Private mEventName As String
	Private mBaseView As B4XView
	Private mBasePanel As Panel
	Private mLabelView As B4XView
	Private mTrackView As B4XView
	Private mThumbView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
	Private mTrackWidth, mTrackHeight, mThumbSize As Int
End Sub

Public Sub Initialize As UISwitch
	mText = ""
	mTextState = Null
	mChecked = False
	mCheckedState = Null
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mTextColor = mTheme.PrimaryText
	mBackgroundColor = mTheme.SurfaceVariant
	mTextSize = mTheme.BodyLarge
	mTextColorOverridden = False
	mBackgroundColorOverridden = False
	mTextSizeOverridden = False
	mTarget = Null
	mEventName = ""
	mBaseView = Null
	mBasePanel = Null
	mLabelView = Null
	mTrackView = Null
	mThumbView = Null
	mParent = Null
	mTrackWidth = 52dip
	mTrackHeight = 32dip
	mThumbSize = 24dip
	Return Me
End Sub

Public Sub Text(Value As String) As UISwitch
	UnbindText
	mText = Value
	ApplyTextToNative
	Return Me
End Sub

Public Sub BindText(State As UIState) As UISwitch
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

Public Sub UnbindText As UISwitch
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = Null
	Return Me
End Sub

Public Sub Checked(Value As Boolean) As UISwitch
	UnbindChecked
	mChecked = Value
	ApplyVisualState
	Return Me
End Sub

Public Sub IsChecked As Boolean
	Return mChecked
End Sub

Public Sub BindChecked(State As UIState) As UISwitch
	UnbindChecked
	mCheckedState = State
	If mCheckedState <> Null Then
		If mCheckedState.IsInitialized Then
			mChecked = ReadBoolean(mCheckedState.GetState)
			mCheckedState.Subscribe(Me, "CheckedState_Changed")
			ApplyVisualState
		End If
	End If
	Return Me
End Sub

Public Sub UnbindChecked As UISwitch
	If mCheckedState <> Null Then
		If mCheckedState.IsInitialized Then mCheckedState.Unsubscribe(Me, "CheckedState_Changed")
	End If
	mCheckedState = Null
	Return Me
End Sub

' Callback signature: Sub EventName(Checked As Boolean)
Public Sub OnChanged(Target As Object, EventName As String) As UISwitch
	mTarget = Target
	mEventName = EventName
	Return Me
End Sub

Public Sub OnCheckedChanged(Target As Object, EventName As String) As UISwitch
	Return OnChanged(Target, EventName)
End Sub

Public Sub TextColor(Color As Int) As UISwitch
	mTextColor = Color
	mTextColorOverridden = True
	ApplyTextColorToNative
	Return Me
End Sub

Public Sub BackgroundColor(Color As Int) As UISwitch
	mBackgroundColor = Color
	mBackgroundColorOverridden = True
	ApplyVisualState
	Return Me
End Sub

Public Sub TextSize(Size As Int) As UISwitch
	mTextSize = Max(1, Size)
	mTextSizeOverridden = True
	ApplyTextSizeToNative
	Return Me
End Sub

Public Sub ApplyTheme(Theme As UITheme) As UISwitch
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mTextColorOverridden = False Then mTextColor = mTheme.PrimaryText
	If mBackgroundColorOverridden = False Then mBackgroundColor = mTheme.SurfaceVariant
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
	If mCheckedState <> Null Then
		If mCheckedState.IsInitialized Then
			mChecked = ReadBoolean(mCheckedState.GetState)
			mCheckedState.Subscribe(Me, "CheckedState_Changed")
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
		basePanel.Initialize("NativeSwitchTrack")
		mBasePanel = basePanel
		mBaseView = mBasePanel
		mBaseView.Color = Colors.Transparent
		mBaseView.Tag = Me
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)

		Dim label As Label
		label.Initialize("NativeSwitchTrack")
		mLabelView = label
		mBaseView.AddView(mLabelView, 0, 0, 1dip, mHeight)

		Dim track As Panel
		track.Initialize("NativeSwitchTrack")
		mTrackView = track
		mBaseView.AddView(mTrackView, 0, 0, mTrackWidth, mTrackHeight)

		Dim thumb As Panel
		thumb.Initialize("NativeSwitchTrack")
		mThumbView = thumb
		mTrackView.AddView(mThumbView, 0, 0, mThumbSize, mThumbSize)
	End If
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If

	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mBaseView.Tag = Me
	LayoutParts
	ApplyTextToNative
	ApplyTextColorToNative
	ApplyTextSizeToNative
	ApplyVisualState
End Sub

Private Sub LayoutParts
	If mBaseView = Null Then Return
	If mBaseView.IsInitialized = False Then Return
	If mLabelView = Null Or mTrackView = Null Then Return
	If mLabelView.IsInitialized = False Or mTrackView.IsInitialized = False Then Return

	Dim trackWidth As Int = Min(mTrackWidth, mWidth)
	Dim labelLeft As Int = trackWidth + 12dip
	Dim labelWidth As Int = Max(0, mWidth - labelLeft)
	If mText.Trim = "" Then labelWidth = 0
	Dim trackTop As Int = Max(0, (mHeight - mTrackHeight) / 2)
	mTrackView.SetLayoutAnimated(0, 0, trackTop, trackWidth, mTrackHeight)
	mLabelView.SetLayoutAnimated(0, labelLeft, 0, labelWidth, mHeight)
	Dim nativeLabel As Label = mLabelView
	nativeLabel.Gravity = Gravity.CENTER_VERTICAL
	Dim thumbLeft As Int = 4dip
	If mChecked Then thumbLeft = Max(0, trackWidth - mThumbSize - 4dip)
	Dim thumbTop As Int = (mTrackHeight - mThumbSize) / 2
	mThumbView.SetLayoutAnimated(0, thumbLeft, thumbTop, mThumbSize, mThumbSize)
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
	If mTrackView = Null Or mThumbView = Null Then Return
	If mTrackView.IsInitialized = False Or mThumbView.IsInitialized = False Then Return

	Dim trackColor As Int = mBackgroundColor
	If mChecked Then trackColor = mTheme.Accent
	Dim trackDrawable As ColorDrawable
	trackDrawable.Initialize2(trackColor, mTrackHeight / 2, 0, 0)
	Dim nativeTrack As Panel = mTrackView
	nativeTrack.Background = trackDrawable

	Dim thumbColor As Int = Colors.White
	If mChecked = False Then thumbColor = mTheme.MutedText
	Dim thumbDrawable As ColorDrawable
	thumbDrawable.Initialize2(thumbColor, mThumbSize / 2, 0, 0)
	Dim nativeThumb As Panel = mThumbView
	nativeThumb.Background = thumbDrawable
	LayoutParts
End Sub

Private Sub CheckedState_Changed(State As UIState)
	If State = Null Then Return
	If State.IsInitialized = False Then Return
	mChecked = ReadBoolean(State.GetState)
	ApplyVisualState
End Sub

Private Sub NativeSwitchTrack_Touch(Action As Int, X As Float, Y As Float)
	If Action <> 1 Then Return
	mChecked = Not(mChecked)
	If mCheckedState <> Null Then
		If mCheckedState.IsInitialized Then mCheckedState.SetState(mChecked)
	End If
	ApplyVisualState
	If mTarget = Null Then Return
	If mEventName.Trim = "" Then Return
	If SubExists(mTarget, mEventName) Then CallSub2(mTarget, mEventName, mChecked)
End Sub

Private Sub ReadBoolean(Value As Object) As Boolean
	If Value = Null Then Return False
	Dim normalized As String = ("" & Value).Trim.ToLowerCase
	If normalized = "true" Then Return True
	If normalized = "false" Or normalized = "" Then Return False
	If IsNumber(normalized) Then
		Dim numericValue As Double = normalized
		Return numericValue <> 0
	End If
	Return False
End Sub

Private Sub StateText(Value As Object) As String
	If Value = Null Then Return ""
	Return "" & Value
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
	If mCheckedState <> Null Then
		If mCheckedState.IsInitialized Then mCheckedState.Unsubscribe(Me, "CheckedState_Changed")
	End If
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
	End If
	mBasePanel = Null
	mBaseView = Null
	mLabelView = Null
	mTrackView = Null
	mThumbView = Null
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
	Dim naturalWidth As Int = textWidth + 12dip + mTrackWidth
	Dim naturalHeight As Int = Max(mTheme.ControlHeight, mTrackHeight)
	result.Add(Min(naturalWidth, safeMaxWidth))
	result.Add(Min(naturalHeight, safeMaxHeight))
	Return result
End Sub