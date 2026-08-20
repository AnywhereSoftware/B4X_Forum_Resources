B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private mGlyph As String
    Private mTypeface As Typeface
    Private mSize As Int
    Private mSizeOverridden As Boolean
    Private mColor As Int
    Private mColorOverridden As Boolean
    Private mTheme As UITheme
    Private mTarget As Object
    Private mEventName As String
    Private mGravityValue As Int
    Private mBaseView As B4XView
    Private mParent As B4XView
    Private mLeft, mTop, mWidth, mHeight As Int
End Sub

' Creates an icon widget using Material Icons by default.
Public Sub Initialize As UIIcon
    mGlyph = ""
    mTypeface = Typeface.MATERIALICONS
    Dim defaultTheme As UITheme
    defaultTheme.Initialize
    mTheme = defaultTheme
    mSize = mTheme.NavigationIconSize
    mSizeOverridden = False
    mColor = mTheme.PrimaryText
    mColorOverridden = False
    mTarget = Null
    mEventName = ""
    mGravityValue = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)
    Return Me
End Sub

' Selects a Material Icons glyph. Pass the glyph itself, for example Chr(59530).
Public Sub Material(Glyph As String) As UIIcon
    mGlyph = Glyph
    mTypeface = Typeface.MATERIALICONS
    Return Me
End Sub

' Selects a FontAwesome glyph. Pass the glyph itself, for example Chr(61664).
Public Sub FontAwesome(Glyph As String) As UIIcon
    mGlyph = Glyph
    mTypeface = Typeface.FONTAWESOME
    Return Me
End Sub

' Selects a regular Unicode glyph, including symbols outside the Material font.
' This is useful for platform-supported symbols such as U+1F318 (🌘).
Public Sub Unicode(Glyph As String) As UIIcon
    mGlyph = Glyph
    mTypeface = Typeface.DEFAULT
    Return Me
End Sub

' Selects a Material Icons code point without requiring Chr at the call site.
Public Sub MaterialCode(CodePoint As Int) As UIIcon
    Return Material(Chr(CodePoint))
End Sub

' Selects a FontAwesome code point without requiring Chr at the call site.
Public Sub FontAwesomeCode(CodePoint As Int) As UIIcon
    Return FontAwesome(Chr(CodePoint))
End Sub

Public Sub Size(Value As Int) As UIIcon
    mSize = Max(1, Value)
    mSizeOverridden = True
    RedrawIfMounted
    Return Me
End Sub

Public Sub Color(Value As Int) As UIIcon
    mColor = Value
    mColorOverridden = True
    RedrawIfMounted
    Return Me
End Sub

' Sets the native label alignment. Gravity.CENTER is the usual default.
Public Sub OnClick(Target As Object, EventName As String) As UIIcon
    mTarget = Target
    mEventName = EventName
    Return Me
End Sub

Public Sub Alignment(Value As Int) As UIIcon
    mGravityValue = Value
    RedrawIfMounted
    Return Me
End Sub

' Applies theme defaults without replacing explicit Size or Color overrides.
Public Sub ApplyTheme(Theme As UITheme) As UIIcon
    If Theme = Null Then Return Me
    If Theme.IsInitialized = False Then Return Me
    mTheme = Theme
    If mSizeOverridden = False Then mSize = mTheme.NavigationIconSize
    If mColorOverridden = False Then mColor = mTheme.PrimaryText
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

Public Sub SetSize(Width As Int, Height As Int)
    mWidth = Max(0, Width)
    mHeight = Max(0, Height)
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
        Dim lbl As Label
        lbl.Initialize("IconView")
        mBaseView = lbl
        mBaseView.Tag = Me
        mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
    End If

    mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    Dim nativeIcon As Label = mBaseView
    nativeIcon.Text = mGlyph
    nativeIcon.TextSize = mSize
    nativeIcon.TextColor = mColor
    nativeIcon.Gravity = mGravityValue
    nativeIcon.Typeface = mTypeface
End Sub

Private Sub RedrawIfMounted
    If mParent = Null Then Return
    If mParent.IsInitialized = False Then Return
    Render
End Sub

Private Sub IconView_Click
    Dim label As Label = Sender
    Dim instance As UIIcon = label.Tag
    If instance = Null Then Return
    instance.DispatchClick
End Sub

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
    diag.ReportError("UIIcon.OnClick", msg)
End Sub

Public Sub Unmount
    mBaseView = Null
    mParent = Null
End Sub

' Natural measurement used by Column, Row, Center and Card.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
    Dim result As List
    result.Initialize

    Dim bmp As Bitmap
    bmp.InitializeMutable(1dip, 1dip)
    Dim cvs As Canvas
    cvs.Initialize2(bmp)
    Dim textWidth As Float = cvs.MeasureStringWidth(mGlyph, mTypeface, mSize)
    Dim naturalWidth As Int = Max(32dip, textWidth + 8dip)
    Dim naturalHeight As Int = Max(32dip, mSize + 12dip)

    Dim safeMaxWidth As Int = MaxWidth
    Dim safeMaxHeight As Int = MaxHeight
    If safeMaxWidth <= 0 Then safeMaxWidth = 10000
    If safeMaxHeight <= 0 Then safeMaxHeight = 10000

    result.Add(Min(naturalWidth, safeMaxWidth))
    result.Add(Min(naturalHeight, safeMaxHeight))
    Return result
End Sub