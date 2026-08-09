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
	Private mBgColor As Int
	Private mTextColor As Int
	Private mBgColorOverridden As Boolean
	Private mTextColorOverridden As Boolean
	Private mTheme As UITheme
	Private mTextSize As Int
	Private mTextSizeOverridden As Boolean
	Private mRadius As Int
	Private mRadiusOverridden As Boolean
	Private mTarget As Object
	Private mEventName As String
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UIFloatingActionButton
	mText = "+"
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mBgColor = mTheme.Accent
	mTextColor = mTheme.AccentText
	mTextSize = mTheme.FabTextSize
	mTextSizeOverridden = False
	mRadius = mTheme.FabRadius
	mRadiusOverridden = False
	mBgColorOverridden = False
	mTextColorOverridden = False
	' Clear the callback target so a new instance starts in a predictable state.
	mTarget = Null
	mEventName = ""
	Return Me
End Sub

Public Sub Text(t As String) As UIFloatingActionButton
	' An explicit text replaces any previous state binding.
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = Null
	mText = t
	Return Me
End Sub

' Binds the floating action button text to an observable UIState.
Public Sub BindText(State As UIState) As UIFloatingActionButton
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
Public Sub UnbindText As UIFloatingActionButton
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

Public Sub BackgroundColor(c As Int) As UIFloatingActionButton
	mBgColor = c
	mBgColorOverridden = True
	Return Me
End Sub

Public Sub TextColor(c As Int) As UIFloatingActionButton
	mTextColor = c
	mTextColorOverridden = True
	Return Me
End Sub

' Applies theme defaults without replacing explicit color overrides.
Public Sub ApplyTheme(Theme As UITheme) As UIFloatingActionButton
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mBgColorOverridden = False Then mBgColor = mTheme.Accent
	If mTextColorOverridden = False Then mTextColor = mTheme.AccentText
	If mTextSizeOverridden = False Then mTextSize = mTheme.FabTextSize
	If mRadiusOverridden = False Then mRadius = mTheme.FabRadius
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

' Sets the floating action button text size explicitly, in scaled pixels.
Public Sub TextSize(Size As Int) As UIFloatingActionButton
	mTextSize = Max(1, Size)
	mTextSizeOverridden = True
	Return Me
End Sub

' Sets the floating action button corner radius explicitly.
Public Sub CornerRadius(Radius As Int) As UIFloatingActionButton
	mRadius = Max(0, Radius)
	mRadiusOverridden = True
	Return Me
End Sub

Public Sub OnClick(Target As Object, EventName As String) As UIFloatingActionButton
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
	If needsCreate Then
		' Keep the native Button directly in mBaseView and use Tag to recover this instance.
		Dim btn As Button
		btn.Initialize("FabBtn")
		mBaseView = btn
		mBaseView.Tag = Me
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    
	Dim btn As Button = mBaseView
	btn.Text = mText
	btn.TextSize = mTextSize
	btn.TextColor = mTextColor
    
	Dim cd As ColorDrawable
	cd.Initialize2(mBgColor, mRadius, 0, 0)
	btn.Background = cd
End Sub

Public Sub Unmount
    If mTextState <> Null Then
        If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
    End If
	mBaseView = Null
	mParent = Null
End Sub

Private Sub FabBtn_Click
	Dim btn As Button = Sender
	Dim instance As UIFloatingActionButton = btn.Tag
	If instance = Null Then Return
	instance.DispatchClick
End Sub

' Dispatches the configured callback only when the target exposes it.
Private Sub DispatchClick
	If mTarget = Null Or mEventName.Trim = "" Then Return
	If SubExists(mTarget, mEventName) Then CallSub(mTarget, mEventName)
End Sub

' Natural measurement used by parent layout containers.
' Use the active theme's floating action button size.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	Dim fabSize As Int = mTheme.FabSize
	
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	result.Add(Min(fabSize, safeMaxWidth))
	result.Add(Min(fabSize, safeMaxHeight))
	Return result
End Sub