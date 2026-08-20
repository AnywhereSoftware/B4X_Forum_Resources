B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private mText As String
	Private mTextState As UIState
	Public mSize As Int
	Private mSizeOverridden As Boolean
	Private mTextColor As Int
	Private mTextColorOverridden As Boolean
	Private mTheme As UITheme
	Private mGravityValue As Int
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UILabel
	mText = ""
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mSize = mTheme.BodyMedium
	mSizeOverridden = False
	mTextColor = mTheme.PrimaryText
	mTextColorOverridden = False
	mGravityValue = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)
	Return Me
End Sub

Public Sub Text(t As String) As UILabel
	mText = t
	Return Me
End Sub

' Binds the label text to an observable UIState.
' The current state value is applied immediately and future changes render this label.
Public Sub BindText(State As UIState) As UILabel
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = State
	If mTextState <> Null Then
		If mTextState.IsInitialized Then
			mText = StateText(mTextState.GetState)
			mTextState.Subscribe(Me, "TextState_Changed")
			If mParent <> Null Then
				If mParent.IsInitialized Then
					Render
					UI.Invalidate(Me)
				End If
			End If
		End If
	End If
	Return Me
End Sub

' Removes the text binding while preserving the current displayed text.
Public Sub UnbindText As UILabel
	If mTextState <> Null Then
		If mTextState.IsInitialized Then mTextState.Unsubscribe(Me, "TextState_Changed")
	End If
	mTextState = Null
	Return Me
End Sub

Private Sub TextState_Changed(State As UIState)
	If State = Null Then Return
	mText = StateText(State.GetState)
	Render
	UI.Invalidate(Me)
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

Public Sub Size(s As Int) As UILabel
	mSize = Max(1, s)
	mSizeOverridden = True
	Return Me
End Sub

Public Sub Color(c As Int) As UILabel
	mTextColor = c
	mTextColorOverridden = True
	Return Me
End Sub

' Applies theme defaults without replacing an explicit Color override.
Public Sub ApplyTheme(Theme As UITheme) As UILabel
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mSizeOverridden = False Then mSize = mTheme.BodyMedium
	If mTextColorOverridden = False Then mTextColor = mTheme.PrimaryText
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
	mWidth = Width
	mHeight = Height
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
	If mBaseView = Null Then
		needsCreate = True
	Else If mBaseView.IsInitialized = False Then
		needsCreate = True
	End If
	If needsCreate Then
		Dim lbl As Label
		lbl.Initialize("")
		mBaseView = lbl
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    
	Dim NativeLabel As Label = mBaseView
	NativeLabel.Text = mText
	NativeLabel.TextSize = mSize
	NativeLabel.TextColor = mTextColor
	NativeLabel.Gravity = mGravityValue
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
	mBaseView = Null
	mParent = Null
End Sub

' Natural measurement used by parent layout containers.
' Return the natural text size so Column, Row, and Center can calculate precise layouts.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	
	' Clamp the available bounds before measuring.
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	
	' Measure text width through the standard B4A Canvas API.
	Dim bmp As Bitmap
	bmp.InitializeMutable(1dip, 1dip)
	Dim cvs As Canvas
	cvs.Initialize2(bmp)
	Dim textWidth As Float = cvs.MeasureStringWidth(mText, Typeface.DEFAULT, mSize)
	
	' Estimate how many lines Android will wrap the text into at the available
	' width. Reserving only one line clips wrapped content (long descriptions).
	Dim lines As Int = 1
	If textWidth > safeMaxWidth Then
		lines = Ceil(textWidth / Max(1, safeMaxWidth))
		If lines < 1 Then lines = 1
	End If
	
	' Per-line box: font size plus descender and TextView padding headroom.
	' The minimum height prevents the lower part of labels from being clipped.
	Dim lineHeight As Int = Max(mSize * 1.5 + 6dip, 22dip)
	Dim textHeight As Int = Max(lines * lineHeight + 4dip, 28dip)
	
	result.Add(Min(textWidth, safeMaxWidth))
	result.Add(Min(textHeight, safeMaxHeight))
	Return result
End Sub