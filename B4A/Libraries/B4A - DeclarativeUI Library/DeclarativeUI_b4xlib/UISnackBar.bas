B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mParent As B4XView
	Private mBaseView As B4XView
	Private mMessageLabel As B4XView
	Private mActionButton As B4XView
	Private mMessage As String
	Private mActionText As String
	Private mActionTarget As Object
	Private mActionEventName As String
	Private mDuration As Int
	Private mAnimationDuration As Int
	Private mBackgroundColor As Int
	Private mTextColor As Int
	Private mActionColor As Int
	Private mBackgroundColorOverridden As Boolean
	Private mTextColorOverridden As Boolean
	Private mActionColorOverridden As Boolean
	Private mTheme As UITheme
	Private mTextSize As Int
	Private mTextSizeOverridden As Boolean
	Private mActionTextSize As Int
	Private mActionTextSizeOverridden As Boolean
	Private mCornerRadius As Int
	Private mCornerRadiusOverridden As Boolean
	Private mMargin As Int
	Private mMarginOverridden As Boolean
	Private mHeight As Int
	Private mHeightOverridden As Boolean
	Private mRunId As Int
	Private mVisible As Boolean
End Sub

' Creates a reusable transient notification.
Public Sub Initialize As UISnackBar
	mMessage = ""
	mActionText = ""
	mActionTarget = Null
	mActionEventName = ""
	mDuration = 3000
	mAnimationDuration = 180
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mBackgroundColor = mTheme.SnackbarBackground
	mTextColor = mTheme.SnackbarText
	mActionColor = mTheme.SnackbarAction
	mTextSize = mTheme.SnackbarTextSize
	mTextSizeOverridden = False
	mActionTextSize = mTheme.SnackbarActionTextSize
	mActionTextSizeOverridden = False
	mBackgroundColorOverridden = False
	mTextColorOverridden = False
	mActionColorOverridden = False
	mCornerRadius = mTheme.SnackbarRadius
	mCornerRadiusOverridden = False
	mMargin = mTheme.SnackbarMargin
	mMarginOverridden = False
	mHeight = mTheme.SnackbarHeight
	mHeightOverridden = False
	mRunId = 0
	mVisible = False
	Return Me
End Sub

' Sets the message shown by the snackbar.
Public Sub Message(Text As String) As UISnackBar
	mMessage = Text
	If mMessageLabel <> Null Then
		If mMessageLabel.IsInitialized Then mMessageLabel.Text = mMessage
	End If
	Return Me
End Sub

' Adds an optional parameterless action callback.
Public Sub Action(Text As String, Target As Object, EventName As String) As UISnackBar
	mActionText = Text
	mActionTarget = Target
	mActionEventName = EventName
	If mVisible Then
		EnsureViews
		LayoutVisible
	End If
	Return Me
End Sub

' Sets the visible duration in milliseconds. Zero keeps the snackbar visible.
Public Sub Duration(Milliseconds As Int) As UISnackBar
	mDuration = Max(0, Milliseconds)
	Return Me
End Sub

' Sets the enter and exit animation duration in milliseconds.
Public Sub AnimationDuration(Milliseconds As Int) As UISnackBar
	mAnimationDuration = Max(0, Milliseconds)
	Return Me
End Sub

Public Sub BackgroundColor(Color As Int) As UISnackBar
	mBackgroundColor = Color
	mBackgroundColorOverridden = True
	ApplyAppearance
	Return Me
End Sub

Public Sub TextColor(Color As Int) As UISnackBar
	mTextColor = Color
	mTextColorOverridden = True
	ApplyAppearance
	Return Me
End Sub

Public Sub ActionColor(Color As Int) As UISnackBar
	mActionColor = Color
	mActionColorOverridden = True
	ApplyAppearance
	Return Me
End Sub

' Applies theme defaults without replacing explicit color overrides.
Public Sub ApplyTheme(Theme As UITheme) As UISnackBar
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mBackgroundColorOverridden = False Then mBackgroundColor = mTheme.SnackbarBackground
	If mTextColorOverridden = False Then mTextColor = mTheme.SnackbarText
	If mActionColorOverridden = False Then mActionColor = mTheme.SnackbarAction
	If mTextSizeOverridden = False Then mTextSize = mTheme.SnackbarTextSize
	If mActionTextSizeOverridden = False Then mActionTextSize = mTheme.SnackbarActionTextSize
	If mCornerRadiusOverridden = False Then mCornerRadius = mTheme.SnackbarRadius
	If mMarginOverridden = False Then mMargin = mTheme.SnackbarMargin
	If mHeightOverridden = False Then mHeight = mTheme.SnackbarHeight
	ApplyAppearance
	If mVisible Then LayoutVisible
	Return Me
End Sub

Public Sub CornerRadius(Radius As Int) As UISnackBar
	mCornerRadius = Max(0, Radius)
	mCornerRadiusOverridden = True
	ApplyAppearance
	Return Me
End Sub

Public Sub TextSize(Size As Int) As UISnackBar
	mTextSize = Max(1, Size)
	mTextSizeOverridden = True
	ApplyAppearance
	Return Me
End Sub

Public Sub ActionTextSize(Size As Int) As UISnackBar
	mActionTextSize = Max(1, Size)
	mActionTextSizeOverridden = True
	ApplyAppearance
	Return Me
End Sub

' Sets the horizontal distance from the parent edges.
Public Sub Margin(Value As Int) As UISnackBar
	mMargin = Max(0, Value)
	mMarginOverridden = True
	If mVisible Then LayoutVisible
	Return Me
End Sub

' Shows the snackbar over Parent. Parent is normally the Activity or a screen root.
Public Sub Show(Parent As B4XView) As UISnackBar
	If Parent = Null Then Return Me
	If Parent.IsInitialized = False Then Return Me
	If mParent <> Null Then
		If mParent.IsInitialized Then
			If mParent <> Parent Then RemoveNativeView
		End If
	End If
	mParent = Parent
	mRunId = mRunId + 1
	Dim currentRun As Int = mRunId
	mVisible = True
	EnsureViews
	Dim visibleTop As Int = Max(0, mParent.Height - mHeight - mMargin)
	LayoutVisible
	mBaseView.BringToFront
	If mAnimationDuration > 0 Then
		mBaseView.SetLayoutAnimated(0, mBaseView.Left, mParent.Height, mBaseView.Width, mBaseView.Height)
		mBaseView.SetLayoutAnimated(mAnimationDuration, mBaseView.Left, visibleTop, mBaseView.Width, mBaseView.Height)
	End If
	If mDuration > 0 Then AutoDismiss(currentRun)
	Return Me
End Sub

' Dismisses the snackbar and removes its native view after the exit animation.
Public Sub Dismiss As UISnackBar
	mRunId = mRunId + 1
	Dim currentRun As Int = mRunId
	If mBaseView = Null Then
		mVisible = False
		Return Me
	End If
	If mBaseView.IsInitialized = False Then
		mBaseView = Null
		mVisible = False
		Return Me
	End If
	mVisible = False
	If mParent <> Null Then
		If mParent.IsInitialized And mAnimationDuration > 0 Then
			mBaseView.SetLayoutAnimated(mAnimationDuration, mBaseView.Left, mParent.Height, mBaseView.Width, mBaseView.Height)
			FinishDismiss(currentRun)
		Else
			RemoveNativeView
		End If
	Else
		RemoveNativeView
	End If
	Return Me
End Sub

Public Sub IsVisible As Boolean
	Return mVisible
End Sub

' Removes the native view and cancels pending show/dismiss work.
Public Sub Unmount
	mRunId = mRunId + 1
	mVisible = False
	RemoveNativeView
	mParent = Null
End Sub

Private Sub EnsureViews
	Dim createBase As Boolean = False
	If mBaseView = Null Then
		createBase = True
	Else If mBaseView.IsInitialized = False Then
		createBase = True
	End If
	If createBase Then
		Dim panel As Panel
		panel.Initialize("")
		mBaseView = panel
		mParent.AddView(mBaseView, 0, mParent.Height, mParent.Width, mHeight)
	End If
	Dim createMessage As Boolean = False
	If mMessageLabel = Null Then
		createMessage = True
	Else If mMessageLabel.IsInitialized = False Then
		createMessage = True
	End If
	If createMessage Then
		Dim label As Label
		label.Initialize("")
		mMessageLabel = label
		mBaseView.AddView(mMessageLabel, 0, 0, mBaseView.Width, mBaseView.Height)
	End If
	If mActionText.Trim <> "" Then
		Dim createAction As Boolean = False
		If mActionButton = Null Then
			createAction = True
		Else If mActionButton.IsInitialized = False Then
			createAction = True
		End If
		If createAction Then
			Dim button As Button
			button.Initialize("SnackAction")
			mActionButton = button
			mBaseView.AddView(mActionButton, 0, 0, 0, mBaseView.Height)
		End If
	Else If mActionButton <> Null Then
		If mActionButton.IsInitialized Then mActionButton.RemoveViewFromParent
		mActionButton = Null
	End If
	ApplyAppearance
End Sub

Private Sub ApplyAppearance
	If mBaseView = Null Then Return
	If mBaseView.IsInitialized = False Then Return
	Dim panel As Panel = mBaseView
	Dim background As ColorDrawable
	background.Initialize2(mBackgroundColor, mCornerRadius, 0, Colors.Transparent)
	panel.Background = background
	If mMessageLabel <> Null Then
		If mMessageLabel.IsInitialized Then
			Dim nativeLabel As Label = mMessageLabel
			nativeLabel.Text = mMessage
			nativeLabel.TextColor = mTextColor
			nativeLabel.TextSize = mTextSize
			nativeLabel.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
		End If
	End If
	If mActionButton <> Null Then
		If mActionButton.IsInitialized Then
			Dim nativeButton As Button = mActionButton
			nativeButton.Text = mActionText
			nativeButton.TextColor = mActionColor
			nativeButton.TextSize = mActionTextSize
			nativeButton.Gravity = Gravity.CENTER
			nativeButton.Color = Colors.Transparent
			nativeButton.Tag = Me
		End If
	End If
End Sub

Private Sub LayoutVisible
	If mParent = Null Then Return
	If mBaseView = Null Then Return
	If mParent.IsInitialized = False Then Return
	If mBaseView.IsInitialized = False Then Return
	Dim width As Int = Max(0, mParent.Width - 2 * mMargin)
	Dim left As Int = mMargin
	Dim top As Int = Max(0, mParent.Height - mHeight - mMargin)
	mBaseView.SetLayoutAnimated(0, left, top, width, mHeight)
	Dim actionWidth As Int = 0
	If mActionButton <> Null Then
		If mActionButton.IsInitialized Then actionWidth = mTheme.SnackbarActionWidth
	End If
	Dim messageWidth As Int = Max(0, width - 2 * mTheme.SnackbarContentPadding - actionWidth)
	If mMessageLabel <> Null Then
		If mMessageLabel.IsInitialized Then mMessageLabel.SetLayoutAnimated(0, mTheme.SnackbarContentPadding, 0, messageWidth, mHeight)
	End If
	If mActionButton <> Null Then
		If mActionButton.IsInitialized Then mActionButton.SetLayoutAnimated(0, width - actionWidth - mTheme.SnackbarActionSpacing, 0, actionWidth, mHeight)
	End If
End Sub

Private Sub AutoDismiss(RunId As Int)
	Sleep(mDuration)
	If RunId <> mRunId Or mVisible = False Then Return
	Dismiss
End Sub

Private Sub FinishDismiss(RunId As Int)
	Sleep(mAnimationDuration)
	If RunId <> mRunId Then Return
	If mBaseView = Null Then Return
	If mBaseView.IsInitialized = False Then Return
	RemoveNativeView
End Sub

Private Sub RemoveNativeView
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
	End If
	mBaseView = Null
	mMessageLabel = Null
	mActionButton = Null
End Sub

Private Sub SnackAction_Click
	Dim button As Button = Sender
	Dim snack As UISnackBar = button.Tag
	If snack = Null Then Return
	Dim actionTarget As Object = snack.mActionTarget
	Dim actionEventName As String = snack.mActionEventName
	snack.Dismiss
	If actionTarget <> Null And actionEventName.Trim <> "" Then
		If SubExists(actionTarget, actionEventName) Then CallSub(actionTarget, actionEventName)
	End If
End Sub
