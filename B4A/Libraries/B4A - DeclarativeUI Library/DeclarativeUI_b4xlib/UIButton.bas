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
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mBaseView.Tag = Me
	' Keep content buttons above remounted siblings so their touch surface remains available.
	mBaseView.BringToFront
    
	SetButtonText(mBaseView, mText)
	mBaseView.TextSize = mTextSize
	If mCornerRadius > 0 Or mBorderWidth > 0 Then
		Dim nativeButton As Button = mBaseView
		SetRoundedRippleBackground(nativeButton)
		mCustomBackgroundApplied = True
	Else
		If mBaseView.Color <> mColor Then mBaseView.Color = mColor
	End If
	If mBaseView.TextColor <> mTextColor Then mBaseView.TextColor = mTextColor
End Sub

' Applies the rounded shape and preserves Android's pressed ripple state.
' API 21+ uses RippleDrawable; older devices keep the rounded fallback.
Private Sub SetRoundedRippleBackground(ButtonView As Button)
	If ButtonView = Null Then Return
	If ButtonView.IsInitialized = False Then Return

	Dim version As JavaObject
	version.InitializeStatic("android.os.Build$VERSION")
	Dim sdkInt As Int = version.GetField("SDK_INT")
	If sdkInt < 21 Then
		Dim fallback As ColorDrawable
		fallback.Initialize2(mColor, mCornerRadius, mBorderWidth, mBorderColor)
		ButtonView.Background = fallback
		Return
	End If

	Dim shape As JavaObject
	shape.InitializeNewInstance("android.graphics.drawable.GradientDrawable", Null)
	shape.RunMethod("setColor", Array(mColor))
	Dim radiusFloat As Float = mCornerRadius
	shape.RunMethod("setCornerRadius", Array(radiusFloat))
	If mBorderWidth > 0 Then shape.RunMethod("setStroke", Array(mBorderWidth, mBorderColor))

	' RippleDrawable owns both objects. Keep the mask independent so the
	' content drawable and its clipping drawable do not share mutable state.
	Dim mask As JavaObject
	mask.InitializeNewInstance("android.graphics.drawable.GradientDrawable", Null)
	mask.RunMethod("setColor", Array(Colors.White))
	mask.RunMethod("setCornerRadius", Array(radiusFloat))

	Dim colorStateList As JavaObject
	colorStateList.InitializeStatic("android.content.res.ColorStateList")
	Dim rippleColor As JavaObject = colorStateList.RunMethodJO("valueOf", Array(mTheme.RippleColor))
	Dim ripple As JavaObject
	ripple.InitializeNewInstance("android.graphics.drawable.RippleDrawable", Array(rippleColor, shape, mask))
	Dim nativeView As JavaObject = ButtonView
	nativeView.RunMethod("setBackground", Array(ripple))
End Sub

' Assigns the button text, rendering any FontAwesome glyphs (private use
' area U+F000..U+F8FF) with the FontAwesome typeface while the surrounding
' label text keeps the default typeface. Icon+text buttons therefore just
' work: UI.Button(Chr(0xF04B) & "  Run") shows a play icon and the label.
Private Sub SetButtonText(ButtonView As B4XView, ButtonText As String)
    If HasFontAwesomeGlyph(ButtonText) = False Then
        ButtonView.Text = ButtonText
        Return
    End If
    Dim csb As CSBuilder
    csb.Initialize
    Dim runStart As Int = 0
    Dim currentFont As String = "text"
    For i = 0 To ButtonText.Length - 1
        Dim runFont As String = IIf(IsFontAwesomeGlyph(ButtonText, i), "icon", "text")
        If runFont <> currentFont Then
            AppendFontRun(csb, ButtonText.SubString2(runStart, i), currentFont)
            runStart = i
            currentFont = runFont
        End If
    Next
    AppendFontRun(csb, ButtonText.SubString2(runStart, ButtonText.Length), currentFont)
    ButtonView.Text = csb
End Sub

' Appends a run of characters with the typeface chosen by FontName.
Private Sub AppendFontRun(csb As CSBuilder, RunText As String, FontName As String)
    If RunText.Length = 0 Then Return
    If FontName = "icon" Then
        csb.Typeface(Typeface.FONTAWESOME).Append(RunText).Pop
    Else
        csb.Append(RunText)
    End If
End Sub

Private Sub IsFontAwesomeGlyph(GlyphText As String, Index As Int) As Boolean
    Dim code As Int = Asc(GlyphText.CharAt(Index))
    Return code >= 0xF000 And code <= 0xF8FF
End Sub

Private Sub HasFontAwesomeGlyph(GlyphText As String) As Boolean
    For i = 0 To GlyphText.Length - 1
        If IsFontAwesomeGlyph(GlyphText, i) Then Return True
    Next
    Return False
End Sub

' Returns the mounted native view, or Null before the first Render
' or after Unmount. Enables opt-in transitions such as UIAnimation.
Public Sub GetView As B4XView
	If mBaseView = Null Then Return Null
	If mBaseView.IsInitialized = False Then Return Null
	Return mBaseView
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

Private Sub NativeBtn_Click
	Dim btn As Button = Sender
	Dim instance As UIButton = btn.Tag
	If instance = Null Then Return
	instance.DispatchClick
End Sub

' Dispatches the configured callback only when the target exposes it.
Private Sub DispatchClick
	If mTarget = Null Or mEventName.Trim = "" Then Return
	If SubExists(mTarget, mEventName) Then
		CallSub(mTarget, mEventName)
	Else
		ReportMissingCallback
	End If
End Sub

' A missing callback is reported through the shared diagnostics instead of
' failing silently - the classic B4A event-name typo becomes visible.
Private Sub ReportMissingCallback
	Dim diag As UIDiagnostics = UI.Diagnostics
	Dim msg As String = "Callback sub '" & mEventName & "' was not found on " & GetType(mTarget) & ". Add Sub " & mEventName & " to the target or fix the event name."
	diag.ReportError("UIButton.OnClick", msg)
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