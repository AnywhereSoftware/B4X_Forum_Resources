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
    Private mApplyingChecked As Boolean
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
    Private mCheckBox As CheckBox
    Private mParent As B4XView
    Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UICheckbox
    mText = ""
    mChecked = False
    mTextState = Null
    mCheckedState = Null
    mApplyingChecked = False
    Dim defaultTheme As UITheme
    defaultTheme.Initialize
    mTheme = defaultTheme
    mTextColor = mTheme.PrimaryText
    mBackgroundColor = Colors.Transparent
    mTextSize = mTheme.BodyLarge
    mTextColorOverridden = False
    mBackgroundColorOverridden = False
    mTextSizeOverridden = False
    mTarget = Null
    mEventName = ""
    mBaseView = Null
    mCheckBox = Null
    mParent = Null
    Return Me
End Sub

Public Sub Text(Value As String) As UICheckbox
    UnbindText
    mText = Value
    If mCheckBox <> Null Then
        If mCheckBox.IsInitialized Then mCheckBox.Text = mText
    End If
    Return Me
End Sub

Public Sub BindText(State As UIState) As UICheckbox
    UnbindText
    mTextState = State
    If mTextState <> Null Then
        If mTextState.IsInitialized Then
            mText = StateText(mTextState.GetState)
            mTextState.Subscribe(Me, "TextState_Changed")
            If mCheckBox <> Null Then
                If mCheckBox.IsInitialized Then mCheckBox.Text = mText
            End If
        End If
    End If
    Return Me
End Sub

Public Sub UnbindText As UICheckbox
    If mTextState <> Null Then
        If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
    End If
    mTextState = Null
    Return Me
End Sub

Public Sub Checked(Value As Boolean) As UICheckbox
    UnbindChecked
    mChecked = Value
    ApplyCheckedToNative
    Return Me
End Sub

Public Sub IsChecked As Boolean
    Return mChecked
End Sub

Public Sub BindChecked(State As UIState) As UICheckbox
    UnbindChecked
    mCheckedState = State
    If mCheckedState <> Null Then
        If mCheckedState.IsInitialized Then
            mChecked = ReadBoolean(mCheckedState.GetState)
            mCheckedState.Subscribe(Me, "CheckedState_Changed")
            ApplyCheckedToNative
        End If
    End If
    Return Me
End Sub

Public Sub UnbindChecked As UICheckbox
    If mCheckedState <> Null Then
        If mCheckedState.IsInitialized Then mCheckedState.Unsubscribe(Me, "CheckedState_Changed")
    End If
    mCheckedState = Null
    Return Me
End Sub

' Callback signature: Sub EventName(Checked As Boolean)
Public Sub OnChanged(Target As Object, EventName As String) As UICheckbox
    mTarget = Target
    mEventName = EventName
    Return Me
End Sub

Public Sub OnCheckedChanged(Target As Object, EventName As String) As UICheckbox
    Return OnChanged(Target, EventName)
End Sub

Public Sub TextColor(Color As Int) As UICheckbox
    mTextColor = Color
    mTextColorOverridden = True
    If mCheckBox <> Null Then
        If mCheckBox.IsInitialized Then mCheckBox.TextColor = mTextColor
    End If
    Return Me
End Sub

Public Sub BackgroundColor(Color As Int) As UICheckbox
    mBackgroundColor = Color
    mBackgroundColorOverridden = True
    If mCheckBox <> Null Then
        If mCheckBox.IsInitialized Then mCheckBox.Color = mBackgroundColor
    End If
    Return Me
End Sub

Public Sub TextSize(Size As Int) As UICheckbox
    mTextSize = Max(1, Size)
    mTextSizeOverridden = True
    If mCheckBox <> Null Then
        If mCheckBox.IsInitialized Then mCheckBox.TextSize = mTextSize
    End If
    Return Me
End Sub

Public Sub ApplyTheme(Theme As UITheme) As UICheckbox
    If Theme = Null Then Return Me
    If Theme.IsInitialized = False Then Return Me
    mTheme = Theme
    If mTextColorOverridden = False Then mTextColor = mTheme.PrimaryText
    If mBackgroundColorOverridden = False Then mBackgroundColor = Colors.Transparent
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
    If mCheckBox = Null Then
        needsCreate = True
    Else If mCheckBox.IsInitialized = False Then
        needsCreate = True
    End If
    If needsCreate Then
        Dim nativeCheckBox As CheckBox
        nativeCheckBox.Initialize("NativeCheckBox")
        mCheckBox = nativeCheckBox
        mBaseView = mCheckBox
        mBaseView.Tag = Me
        mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
    End If

    mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    mBaseView.Tag = Me
    mCheckBox.Text = mText
    mCheckBox.TextColor = mTextColor
    mCheckBox.TextSize = mTextSize
    mCheckBox.Color = mBackgroundColor
    mCheckBox.Gravity = Gravity.CENTER_VERTICAL
    ApplyCheckedToNative
End Sub

Private Sub ApplyCheckedToNative
    If mCheckBox = Null Then Return
    If mCheckBox.IsInitialized = False Then Return
    If mCheckBox.Checked = mChecked Then Return
    mApplyingChecked = True
    mCheckBox.Checked = mChecked
    mApplyingChecked = False
End Sub

Private Sub TextState_Changed(State As UIState)
    If State = Null Then Return
    If State.IsInitialized = False Then Return
    mText = StateText(State.GetState)
    If mCheckBox <> Null Then
        If mCheckBox.IsInitialized Then mCheckBox.Text = mText
    End If
End Sub

Private Sub CheckedState_Changed(State As UIState)
    If State = Null Then Return
    If State.IsInitialized = False Then Return
    mChecked = ReadBoolean(State.GetState)
    ApplyCheckedToNative
End Sub

Private Sub NativeCheckBox_CheckedChange(Value As Boolean)
    mChecked = Value
    If mApplyingChecked Then Return
    If mCheckedState <> Null Then
        If mCheckedState.IsInitialized Then mCheckedState.SetState(mChecked)
    End If
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
    mCheckBox = Null
    mBaseView = Null
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
    Dim naturalWidth As Int = textWidth + 52dip
    Dim naturalHeight As Int = Max(mTheme.ControlHeight, mTextSize * 1.6 + 10dip)
    result.Add(Min(naturalWidth, safeMaxWidth))
    result.Add(Min(naturalHeight, safeMaxHeight))
    Return result
End Sub