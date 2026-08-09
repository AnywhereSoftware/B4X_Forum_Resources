B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private mTitle As String
	Private mTitleState As UIState
	Private mColor As Int
	Private mTitleColor As Int
	Private mTitleSize As Int
	Private mTitleSizeOverridden As Boolean
	Private mColorOverridden As Boolean
	Private mTitleColorOverridden As Boolean
	Private mTheme As UITheme
	Private mBaseView As B4XView
	Private mActionWidget As Object
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
	Private mTitleLabel As Label ' Persistent reference to the title label.
End Sub

Public Sub Initialize As UIAppBar
	mTitle = ""
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mColor = mTheme.DashboardBar
	mTitleColor = mTheme.DashboardBarText
	mTitleSize = mTheme.AppBarTitleSize
	mTitleSizeOverridden = False
	mColorOverridden = False
	mTitleColorOverridden = False
	mActionWidget = Null
	Return Me
End Sub

Public Sub Title(t As String) As UIAppBar
	' An explicit title replaces any previous state binding.
	If mTitleState <> Null Then
		If mTitleState.IsInitialized Then mTitleState.Unsubscribe(Me, "TitleState_Changed")
	End If
	mTitleState = Null
	mTitle = t
	Return Me
End Sub

' Binds the app bar title to an observable UIState.
' The current state value is applied immediately and future changes re-render the title.
Public Sub BindTitle(State As UIState) As UIAppBar
	If mTitleState <> Null Then
		If mTitleState.IsInitialized Then mTitleState.Unsubscribe(Me, "TitleState_Changed")
	End If
	mTitleState = State
	If mTitleState <> Null Then
		If mTitleState.IsInitialized Then
			mTitle = StateText(mTitleState.GetState)
			mTitleState.Subscribe(Me, "TitleState_Changed")
			If mParent <> Null Then
				If mParent.IsInitialized Then Render
			End If
		End If
	End If
	Return Me
End Sub

' Removes the title binding while preserving the current displayed title.
Public Sub UnbindTitle As UIAppBar
	If mTitleState <> Null Then
		If mTitleState.IsInitialized Then mTitleState.Unsubscribe(Me, "TitleState_Changed")
	End If
	mTitleState = Null
	Return Me
End Sub

Private Sub TitleState_Changed(State As UIState)
	If State = Null Then Return
	If State.IsInitialized = False Then Return
	mTitle = StateText(State.GetState)
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

Public Sub BackgroundColor(c As Int) As UIAppBar
	mColor = c
	mColorOverridden = True
	Return Me
End Sub

' Applies theme defaults without replacing explicit component overrides.
Public Sub ApplyTheme(Theme As UITheme) As UIAppBar
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mTitleSizeOverridden = False Then mTitleSize = mTheme.AppBarTitleSize
	If mColorOverridden = False Then mColor = mTheme.DashboardBar
	If mTitleColorOverridden = False Then mTitleColor = mTheme.DashboardBarText
	If mActionWidget <> Null Then
		If SubExists(mActionWidget, "ApplyTheme") Then CallSub2(mActionWidget, "ApplyTheme", Theme)
	End If
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

' Sets the trailing action widget, typically a UIIcon or UIButton.
Public Sub Action(Widget As Object) As UIAppBar
	If IsWidgetProtocol(Widget) = False Then Return Me
	If mActionWidget <> Null Then
		If mActionWidget = Widget Then Return Me
	End If
	mActionWidget = Widget
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

' Removes the trailing action widget.
Public Sub ClearAction As UIAppBar
	If mActionWidget <> Null Then
		If SubExists(mActionWidget, "Unmount") Then CallSub(mActionWidget, "Unmount")
	End If
	mActionWidget = Null
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

' Sets the app bar title color explicitly.
Public Sub TitleColor(c As Int) As UIAppBar
	mTitleColor = c
	mTitleColorOverridden = True
	Return Me
End Sub

' Sets the app bar title size explicitly, in scaled pixels.
Public Sub TitleSize(Size As Int) As UIAppBar
	mTitleSize = Max(1, Size)
	mTitleSizeOverridden = True
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
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return
	If mTitleState <> Null Then
		If mTitleState.IsInitialized Then
			mTitle = StateText(mTitleState.GetState)
			mTitleState.Subscribe(Me, "TitleState_Changed")
		End If
	End If

	Dim needsCreate As Boolean = False
	If mBaseView = Null Then
		needsCreate = True
	Else If mBaseView.IsInitialized = False Then
		needsCreate = True
	End If
	If needsCreate Then
		Dim pnl As Panel
		pnl.Initialize("")
		mBaseView = pnl
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
        
	End If

	Dim titleNeedsCreate As Boolean = needsCreate
	If mTitleLabel = Null Then
		titleNeedsCreate = True
	Else If mTitleLabel.IsInitialized = False Then
		titleNeedsCreate = True
	End If
	If titleNeedsCreate Then
		Dim titleLabel As Label
		titleLabel.Initialize("")
		mTitleLabel = titleLabel
		Dim xLbl As B4XView = mTitleLabel
		xLbl.TextColor = mTitleColor
		xLbl.TextSize = mTitleSize
		mBaseView.AddView(xLbl, mTheme.HorizontalPadding, 0, mWidth - 2 * mTheme.HorizontalPadding, mHeight)
	End If
	
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mBaseView.Color = mColor

	Dim actionWidth As Int = 0
	If mActionWidget <> Null Then actionWidth = 48dip
	Dim titleWidth As Int = Max(0, mWidth - mTheme.HorizontalPadding * 2 - actionWidth)
	mTitleLabel.SetLayoutAnimated(0, mTheme.HorizontalPadding, 0, titleWidth, mHeight)

	If mActionWidget <> Null Then
		CallSub2(mActionWidget, "SetParent", mBaseView)
		CallSub3(mActionWidget, "SetPosition", mWidth - mTheme.HorizontalPadding - actionWidth, 0)
		CallSub3(mActionWidget, "SetSize", actionWidth, mHeight)
		CallSub(mActionWidget, "Render")
	End If
	
	' Keep the title vertically centered across the whole bar.
	mTitleLabel.Gravity = Gravity.CENTER_VERTICAL
	' Refresh themeable title properties on every render.
	mTitleLabel.TextColor = mTitleColor
	mTitleLabel.TextSize = mTitleSize
	mTitleLabel.Text = mTitle
End Sub

Public Sub Unmount
	If mActionWidget <> Null Then
		If SubExists(mActionWidget, "Unmount") Then CallSub(mActionWidget, "Unmount")
	End If
	If mTitleState <> Null Then
		If mTitleState.IsInitialized Then mTitleState.Unsubscribe(Me, "TitleState_Changed")
	End If
	mTitleLabel = Null
	mBaseView = Null
	mParent = Null
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	If Widget = Null Then Return False
	Return SubExists(Widget, "SetParent") And SubExists(Widget, "SetPosition") _
		And SubExists(Widget, "SetSize") And SubExists(Widget, "Render") _
		And SubExists(Widget, "GetContentSize")
End Sub

' Natural measurement used by parent layout containers.
' Use the standard 56dip Material bar height and the full available width.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	result.Add(safeMaxWidth) ' Full available width
	result.Add(Min(mTheme.AppBarHeight, safeMaxHeight)) ' Theme-driven Material bar height
	Return result
End Sub