B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private mTheme As UITheme
    Private mParent As B4XView
    Private mBaseView As B4XView
    Private mTrackView As B4XView
    Private mProgressView As B4XView
    Private mValueState As UIState
    Private mValue As Int
    Private mIndeterminate As Boolean
    Private mHeight As Int
    Private mHeightOverridden As Boolean
    Private mTrackColor As Int
    Private mProgressColor As Int
    Private mTrackColorOverridden As Boolean
    Private mProgressColorOverridden As Boolean
    Private mCornerRadius As Int
    Private mCornerRadiusOverridden As Boolean
    Private mLeft, mTop, mWidth, mLayoutHeight As Int
    Private mAnimationRunId As Int
    Private mAnimationActive As Boolean
End Sub

' Creates a determinate progress indicator at zero percent.
Public Sub Initialize As UIProgressBar
    Dim defaultTheme As UITheme
    defaultTheme.Initialize
    mTheme = defaultTheme
    mValue = 0
    mIndeterminate = False
    mHeight = mTheme.ProgressBarHeight
    mHeightOverridden = False
    mTrackColor = mTheme.SurfaceVariant
    mProgressColor = mTheme.Accent
    mTrackColorOverridden = False
    mProgressColorOverridden = False
    mCornerRadius = mTheme.ProgressBarRadius
    mCornerRadiusOverridden = False
    mParent = Null
    mBaseView = Null
    mTrackView = Null
    mProgressView = Null
    mValueState = Null
    mAnimationRunId = 0
    mAnimationActive = False
    Return Me
End Sub

' Sets a determinate value between 0 and 100 and disables indeterminate mode.
Public Sub Value(Percent As Int) As UIProgressBar
    UnbindValue
    StopIndeterminate
    mIndeterminate = False
    mValue = ClampPercent(Percent)
    RefreshIfMounted
    Return Me
End Sub

' Sets whether the indicator continuously communicates unknown progress.
Public Sub Indeterminate(Enabled As Boolean) As UIProgressBar
    mIndeterminate = Enabled
    If mIndeterminate Then
        StartIndeterminate
    Else
        StopIndeterminate
        RefreshIfMounted
    End If
    Return Me
End Sub

' Binds the progress value to a UIState containing a number from 0 to 100.
Public Sub BindValue(State As UIState) As UIProgressBar
    UnbindValue
    mValueState = State
    If mValueState <> Null Then
        If mValueState.IsInitialized Then
            mValue = ReadPercent(mValueState.GetState)
            mValueState.Subscribe(Me, "ValueState_Changed")
            RefreshIfMounted
        End If
    End If
    Return Me
End Sub

' Removes the progress state binding while preserving the current value.
Public Sub UnbindValue As UIProgressBar
    If mValueState <> Null Then
        If mValueState.IsInitialized Then mValueState.Unsubscribe(Me, "ValueState_Changed")
    End If
    mValueState = Null
    Return Me
End Sub

Public Sub TrackColor(Color As Int) As UIProgressBar
    mTrackColor = Color
    mTrackColorOverridden = True
    ApplyAppearance
    Return Me
End Sub

Public Sub ProgressColor(Color As Int) As UIProgressBar
    mProgressColor = Color
    mProgressColorOverridden = True
    ApplyAppearance
    Return Me
End Sub

' Sets the visual height in pixels.
Public Sub BarHeight(Height As Int) As UIProgressBar
    mHeight = Max(1, Height)
    mHeightOverridden = True
    RefreshIfMounted
    Return Me
End Sub

Public Sub CornerRadius(Radius As Int) As UIProgressBar
    mCornerRadius = Max(0, Radius)
    mCornerRadiusOverridden = True
    ApplyAppearance
    Return Me
End Sub

' Applies theme defaults without replacing explicit customizations.
Public Sub ApplyTheme(Theme As UITheme) As UIProgressBar
    If Theme = Null Then Return Me
    If Theme.IsInitialized = False Then Return Me
    mTheme = Theme
    If mTrackColorOverridden = False Then mTrackColor = mTheme.SurfaceVariant
    If mProgressColorOverridden = False Then mProgressColor = mTheme.Accent
    If mCornerRadiusOverridden = False Then mCornerRadius = mTheme.ProgressBarRadius
    If mHeightOverridden = False Then mHeight = mTheme.ProgressBarHeight
    ApplyAppearance
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
    mLayoutHeight = Max(0, Height)
End Sub

Public Sub Render
    If mParent = Null Then Return
    If mParent.IsInitialized = False Then Return
    If mValueState <> Null Then
        If mValueState.IsInitialized Then
            mValue = ReadPercent(mValueState.GetState)
            mValueState.Subscribe(Me, "ValueState_Changed")
        End If
    End If

    Dim needsCreate As Boolean = False
    If mBaseView = Null Then
        needsCreate = True
    Else If mBaseView.IsInitialized = False Then
        needsCreate = True
    End If
    If needsCreate Then
        Dim panel As Panel
        panel.Initialize("")
        mBaseView = panel
        mParent.AddView(mBaseView, mLeft, mTop, mWidth, EffectiveHeight)
        mTrackView = Null
        mProgressView = Null
    End If
    mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, EffectiveHeight)
    EnsureBars
    ApplyAppearance
    If mIndeterminate Then StartIndeterminate
End Sub

Private Sub EffectiveHeight As Int
    If mLayoutHeight > 0 Then Return mLayoutHeight
    Return mHeight
End Sub

Private Sub EnsureBars
    Dim createTrack As Boolean = False
    If mTrackView = Null Then
        createTrack = True
    Else If mTrackView.IsInitialized = False Then
        createTrack = True
    End If
    If createTrack Then
        Dim track As Panel
        track.Initialize("")
        mTrackView = track
        mBaseView.AddView(mTrackView, 0, 0, mWidth, EffectiveHeight)
    End If
    Dim createProgress As Boolean = False
    If mProgressView = Null Then
        createProgress = True
    Else If mProgressView.IsInitialized = False Then
        createProgress = True
    End If
    If createProgress Then
        Dim progress As Panel
        progress.Initialize("")
        mProgressView = progress
        mBaseView.AddView(mProgressView, 0, 0, 0, EffectiveHeight)
    End If
End Sub

Private Sub ApplyAppearance
    If mBaseView = Null Then Return
    If mBaseView.IsInitialized = False Then Return
    EnsureBars
    Dim effectiveBarHeight As Int = EffectiveHeight
    If effectiveBarHeight <= 0 Then effectiveBarHeight = mHeight
    mTrackView.SetLayoutAnimated(0, 0, 0, mWidth, effectiveBarHeight)
    Dim trackPanel As Panel = mTrackView
    Dim trackDrawable As ColorDrawable
    trackDrawable.Initialize2(mTrackColor, Min(mCornerRadius, effectiveBarHeight / 2), 0, Colors.Transparent)
    trackPanel.Background = trackDrawable

    Dim progressWidth As Int = 0
    If mIndeterminate = False Then progressWidth = Round(mWidth * mValue / 100)
    mProgressView.SetLayoutAnimated(0, 0, 0, Max(0, progressWidth), effectiveBarHeight)
    Dim progressPanel As Panel = mProgressView
    Dim progressDrawable As ColorDrawable
    progressDrawable.Initialize2(mProgressColor, Min(mCornerRadius, effectiveBarHeight / 2), 0, Colors.Transparent)
    progressPanel.Background = progressDrawable
    mProgressView.BringToFront
End Sub

Private Sub StartIndeterminate
    If mBaseView = Null Then Return
    If mBaseView.IsInitialized = False Then Return
    If mAnimationActive Then Return
    mAnimationRunId = mAnimationRunId + 1
    mAnimationActive = True
    Dim currentRun As Int = mAnimationRunId
    AnimateIndeterminate(currentRun)
End Sub

Private Sub AnimateIndeterminate(RunId As Int)
    If RunId <> mAnimationRunId Or mIndeterminate = False Then
        mAnimationActive = False
        Return
    End If
    If mBaseView = Null Then
        mAnimationActive = False
        Return
    End If
    If mProgressView = Null Then
        mAnimationActive = False
        Return
    End If
    If mBaseView.IsInitialized = False Then
        mAnimationActive = False
        Return
    End If
    If mProgressView.IsInitialized = False Then
        mAnimationActive = False
        Return
    End If
    Dim segmentWidth As Int = Max(24dip, mWidth / 3)
    mProgressView.SetLayoutAnimated(520, -segmentWidth, 0, segmentWidth, EffectiveHeight)
    Sleep(520)
    If RunId <> mAnimationRunId Or mIndeterminate = False Then
        mAnimationActive = False
        Return
    End If
    mProgressView.SetLayoutAnimated(520, mWidth, 0, segmentWidth, EffectiveHeight)
    Sleep(520)
    AnimateIndeterminate(RunId)
End Sub

Private Sub StopIndeterminate
    mAnimationRunId = mAnimationRunId + 1
    mAnimationActive = False
End Sub

Private Sub ValueState_Changed(State As UIState)
    If State = Null Then Return
    If State.IsInitialized = False Then Return
    mValue = ReadPercent(State.GetState)
    If mIndeterminate = False Then ApplyAppearance
End Sub

Private Sub ReadPercent(StateValue As Object) As Int
    If StateValue = Null Then Return 0
    Dim text As String = ("" & StateValue).Trim
    If IsNumber(text) = False Then Return 0
    Return ClampPercent(text)
End Sub

Private Sub ClampPercent(PercentValue As Int) As Int
    Return Min(100, Max(0, PercentValue))
End Sub

Private Sub RefreshIfMounted
    If mParent <> Null Then
        If mParent.IsInitialized Then Render
    End If
End Sub

Public Sub Unmount
    StopIndeterminate
    If mValueState <> Null Then
        If mValueState.IsInitialized Then mValueState.Unsubscribe(Me, "ValueState_Changed")
    End If
    If mBaseView <> Null Then
        If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
    End If
    mBaseView = Null
    mTrackView = Null
    mProgressView = Null
    mParent = Null
End Sub

' Natural measurement used by parent layout containers.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
    Dim result As List
    result.Initialize
    Dim safeWidth As Int = MaxWidth
    Dim safeHeight As Int = MaxHeight
    If safeWidth <= 0 Then safeWidth = 10000
    If safeHeight <= 0 Then safeHeight = 10000
    result.Add(safeWidth)
    result.Add(Min(mHeight, safeHeight))
    Return result
End Sub