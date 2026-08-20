B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private mBaseView As B4XView
	Private mPanel As Panel
	Private mParent As B4XView
	Private mCanvas As Canvas
	Private mLeft, mTop, mWidth, mHeight As Int
	Private mFallbackWidth, mFallbackHeight As Int
	Private mColor, mStrokeWidth As Int
	Private mColorOverridden As Boolean
	Private mTheme As UITheme
End Sub

' Creates a Flutter-like development placeholder: a bordered box crossed by two diagonals.
Public Sub Initialize As UIPlaceholder
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mFallbackWidth = 400dip
	mFallbackHeight = 200dip
	mColor = mTheme.SecondaryText
	mStrokeWidth = 2dip
	mColorOverridden = False
	Return Me
End Sub

' Sets the placeholder stroke color.
Public Sub Color(Value As Int) As UIPlaceholder
	mColor = Value
	mColorOverridden = True
	RedrawIfMounted
	Return Me
End Sub

' Sets the border and diagonal stroke width.
Public Sub StrokeWidth(Value As Int) As UIPlaceholder
	mStrokeWidth = Max(1dip, Value)
	RedrawIfMounted
	Return Me
End Sub

' Sets the natural width used when the parent has unbounded horizontal space.
Public Sub FallbackWidth(Value As Int) As UIPlaceholder
	mFallbackWidth = Max(1dip, Value)
	Return Me
End Sub

' Sets the natural height used when the parent has unbounded vertical space.
Public Sub FallbackHeight(Value As Int) As UIPlaceholder
	mFallbackHeight = Max(1dip, Value)
	Return Me
End Sub

' Sets both fallback dimensions in one declarative call.
Public Sub FallbackSize(Width As Int, Height As Int) As UIPlaceholder
	mFallbackWidth = Max(1dip, Width)
	mFallbackHeight = Max(1dip, Height)
	Return Me
End Sub

' Applies theme defaults without replacing an explicit Color override.
Public Sub ApplyTheme(Theme As UITheme) As UIPlaceholder
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mColorOverridden = False Then mColor = mTheme.SecondaryText
	RedrawIfMounted
	Return Me
End Sub

Public Sub SetParent(Parent As B4XView)
	mParent = Parent
End Sub

Public Sub SetPosition(Left As Int, Top As Int)
	mLeft = Left
	mTop = Top
End Sub

Public Sub SetSize(NewWidth As Int, NewHeight As Int)
	mWidth = Max(0, NewWidth)
	mHeight = Max(0, NewHeight)
End Sub

Public Sub Render
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return
	If mWidth <= 0 Or mHeight <= 0 Then Return

	Dim needsCreate As Boolean = False
	If mBaseView = Null Then
		needsCreate = True
	Else If mBaseView.IsInitialized = False Then
		needsCreate = True
	End If
	If needsCreate Then
		Dim pnl As Panel
		pnl.Initialize("")
		mPanel = pnl
		mBaseView = mPanel
		mBaseView.Color = Colors.Transparent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If

	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	EnsureCanvas
	DrawPlaceholder
End Sub

Private Sub DrawPlaceholder
	If mBaseView = Null Then Return
	If mBaseView.IsInitialized = False Then Return
	If mWidth <= 0 Or mHeight <= 0 Then Return
	EnsureCanvas
	If mCanvas = Null Then Return

	mCanvas.DrawColor(Colors.Transparent)
	Dim safeStroke As Int = Max(1dip, mStrokeWidth)
	Dim inset As Int = Max(1dip, safeStroke / 2)
	Dim right As Int = Max(inset + 1dip, mWidth - inset)
	Dim bottom As Int = Max(inset + 1dip, mHeight - inset)
	Dim border As Rect
	border.Initialize(inset, inset, right, bottom)
	mCanvas.DrawRect(border, mColor, False, safeStroke)
	mCanvas.DrawLine(inset, inset, right, bottom, mColor, safeStroke)
	mCanvas.DrawLine(right, inset, inset, bottom, mColor, safeStroke)
End Sub

Private Sub EnsureCanvas
	If mPanel = Null Then Return
	If mPanel.IsInitialized = False Then Return
	' Canvas is a reusable wrapper. Rebind it after every remount because
	' Unmount may have replaced the backing Panel.
	Dim canvas As Canvas
	canvas.Initialize(mPanel)
	mCanvas = canvas
End Sub

Private Sub RedrawIfMounted
	If mBaseView = Null Then Return
	If mBaseView.IsInitialized = False Then Return
	If mWidth <= 0 Or mHeight <= 0 Then Return
	EnsureCanvas
	If mCanvas = Null Then Return
	DrawPlaceholder
End Sub

Public Sub Unmount
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
	End If
	' Keep the Canvas wrapper alive; Render will rebind it to the next Panel.
	mBaseView = Null
	mParent = Null
End Sub

' Returns the fallback size when the corresponding axis is unbounded.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize

	Dim measuredWidth As Int = MaxWidth
	Dim measuredHeight As Int = MaxHeight
	If measuredWidth <= 0 Or measuredWidth >= 10000 Then measuredWidth = mFallbackWidth
	If measuredHeight <= 0 Or measuredHeight >= 10000 Then measuredHeight = mFallbackHeight

	result.Add(Max(1dip, measuredWidth))
	result.Add(Max(1dip, measuredHeight))
	Return result
End Sub