B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private xui As XUI
    Private mTheme As UITheme
    Private mParent As B4XView
    Private mOverlay As B4XView
    Private mCardView As B4XView
    Private mTitleLabel As B4XView
    Private mMessageLabel As B4XView
    Private mPositiveButton As B4XView
    Private mNegativeButton As B4XView
    Private mContent As Object
    Private mTitle As String
    Private mMessage As String
    Private mPositiveText As String
    Private mNegativeText As String
    Private mPositiveTarget As Object
    Private mPositiveEventName As String
    Private mNegativeTarget As Object
    Private mNegativeEventName As String
    Private mDismissOnOutside As Boolean
    Private mVisible As Boolean
    Private mSurfaceColor As Int
    Private mTitleColor As Int
    Private mMessageColor As Int
    Private mButtonColor As Int
    Private mButtonTextColor As Int
    Private mOverlayColor As Int
    Private mRadius As Int
    Private mSurfaceColorOverridden As Boolean
    Private mTitleColorOverridden As Boolean
    Private mMessageColorOverridden As Boolean
    Private mButtonColorOverridden As Boolean
    Private mButtonTextColorOverridden As Boolean
    Private mOverlayColorOverridden As Boolean
    Private mRadiusOverridden As Boolean
End Sub

' Creates a hidden modal dialog with Material-like defaults.
Public Sub Initialize As UIAlertDialog
    Dim defaultTheme As UITheme
    defaultTheme.Initialize
    mTheme = defaultTheme
    mTitle = ""
    mMessage = ""
    mPositiveText = ""
    mNegativeText = ""
    mPositiveTarget = Null
    mPositiveEventName = ""
    mNegativeTarget = Null
    mNegativeEventName = ""
    mContent = Null
    mDismissOnOutside = True
    mVisible = False
    mOverlay = Null
    mCardView = Null
    mTitleLabel = Null
    mMessageLabel = Null
    mPositiveButton = Null
    mNegativeButton = Null
    mSurfaceColor = mTheme.Surface
    mTitleColor = mTheme.PrimaryText
    mMessageColor = mTheme.SecondaryText
    mButtonColor = mTheme.SurfaceVariant
    mButtonTextColor = mTheme.ButtonText
    mOverlayColor = mTheme.DialogOverlay
    mRadius = mTheme.RadiusExtraLarge
    mSurfaceColorOverridden = False
    mTitleColorOverridden = False
    mMessageColorOverridden = False
    mButtonColorOverridden = False
    mButtonTextColorOverridden = False
    mOverlayColorOverridden = False
    mRadiusOverridden = False
    Return Me
End Sub

Public Sub Title(Value As String) As UIAlertDialog
    mTitle = Value
    ApplyText
    Return Me
End Sub

Public Sub Message(Value As String) As UIAlertDialog
    mMessage = Value
    ApplyText
    Return Me
End Sub

' Adds optional declarative content below the message.
Public Sub Content(Widget As Object) As UIAlertDialog
    If IsWidgetProtocol(Widget) = False Then Return Me
    If mContent <> Null Then
        If mContent = Widget Then Return Me
    End If
    If mContent <> Null Then
        If SubExists(mContent, "Unmount") Then CallSub(mContent, "Unmount")
    End If
    mContent = Widget
    If mVisible Then
        EnsureViews
        LayoutDialog
    End If
    Return Me
End Sub

' Configures a parameterless positive action callback.
Public Sub PositiveButton(Text As String, Target As Object, EventName As String) As UIAlertDialog
    mPositiveText = Text
    mPositiveTarget = Target
    mPositiveEventName = EventName
    If mVisible Then
        EnsureViews
        LayoutDialog
    End If
    Return Me
End Sub

' Configures a parameterless negative action callback.
Public Sub NegativeButton(Text As String, Target As Object, EventName As String) As UIAlertDialog
    mNegativeText = Text
    mNegativeTarget = Target
    mNegativeEventName = EventName
    If mVisible Then
        EnsureViews
        LayoutDialog
    End If
    Return Me
End Sub

' Controls whether tapping the scrim dismisses the dialog.
Public Sub DismissOnOutside(Value As Boolean) As UIAlertDialog
    mDismissOnOutside = Value
    Return Me
End Sub

Public Sub SurfaceColor(Color As Int) As UIAlertDialog
    mSurfaceColor = Color
    mSurfaceColorOverridden = True
    ApplyAppearance
    Return Me
End Sub

Public Sub TitleColor(Color As Int) As UIAlertDialog
    mTitleColor = Color
    mTitleColorOverridden = True
    ApplyAppearance
    Return Me
End Sub

Public Sub MessageColor(Color As Int) As UIAlertDialog
    mMessageColor = Color
    mMessageColorOverridden = True
    ApplyAppearance
    Return Me
End Sub

Public Sub ButtonColor(Color As Int) As UIAlertDialog
    mButtonColor = Color
    mButtonColorOverridden = True
    ApplyAppearance
    Return Me
End Sub

Public Sub ButtonTextColor(Color As Int) As UIAlertDialog
    mButtonTextColor = Color
    mButtonTextColorOverridden = True
    ApplyAppearance
    Return Me
End Sub

Public Sub OverlayColor(Color As Int) As UIAlertDialog
    mOverlayColor = Color
    mOverlayColorOverridden = True
    ApplyAppearance
    Return Me
End Sub

Public Sub CornerRadius(Radius As Int) As UIAlertDialog
    mRadius = Max(0, Radius)
    mRadiusOverridden = True
    ApplyAppearance
    Return Me
End Sub

' Applies theme defaults without replacing explicit customizations.
Public Sub ApplyTheme(Theme As UITheme) As UIAlertDialog
    If Theme = Null Then Return Me
    If Theme.IsInitialized = False Then Return Me
    mTheme = Theme
    If mSurfaceColorOverridden = False Then mSurfaceColor = mTheme.Surface
    If mTitleColorOverridden = False Then mTitleColor = mTheme.PrimaryText
    If mMessageColorOverridden = False Then mMessageColor = mTheme.SecondaryText
    If mButtonColorOverridden = False Then mButtonColor = mTheme.SurfaceVariant
    If mButtonTextColorOverridden = False Then mButtonTextColor = mTheme.ButtonText
    If mOverlayColorOverridden = False Then mOverlayColor = mTheme.DialogOverlay
    If mRadiusOverridden = False Then mRadius = mTheme.RadiusExtraLarge
    ApplyAppearance
    If mContent <> Null Then
        If SubExists(mContent, "ApplyTheme") Then CallSub2(mContent, "ApplyTheme", Theme)
    End If
    Return Me
End Sub

' Shows the dialog over Parent. Parent is normally the Activity or a screen root.
Public Sub Show(Parent As B4XView) As UIAlertDialog
    If Parent = Null Then Return Me
    If Parent.IsInitialized = False Then Return Me
    If mParent <> Null Then
        If mParent.IsInitialized Then
            If mParent <> Parent Then
                If mContent <> Null Then
                    If SubExists(mContent, "Unmount") Then CallSub(mContent, "Unmount")
                End If
                RemoveNativeViews
            End If
        End If
    End If
    mParent = Parent
    mVisible = True
    EnsureViews
    LayoutDialog
    ApplyAppearance
    mOverlay.BringToFront
    mCardView.BringToFront
    Return Me
End Sub

Public Sub Dismiss As UIAlertDialog
    mVisible = False
    If mContent <> Null Then
        If SubExists(mContent, "Unmount") Then CallSub(mContent, "Unmount")
    End If
    RemoveNativeViews
    Return Me
End Sub

Public Sub IsVisible As Boolean
    Return mVisible
End Sub

Public Sub SetParent(Parent As B4XView)
    mParent = Parent
End Sub

' Kept as no-op lifecycle hooks so the dialog can safely be passed through
' the common declarative widget contract. Show(parent) owns its actual bounds.
Public Sub SetPosition(Left As Int, Top As Int)
End Sub

Public Sub SetSize(Width As Int, Height As Int)
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
    If Widget = Null Then Return False
    Return SubExists(Widget, "SetParent") And SubExists(Widget, "SetPosition") _
        And SubExists(Widget, "SetSize") And SubExists(Widget, "Render") _
        And SubExists(Widget, "GetContentSize")
End Sub

' Dialogs are normally shown explicitly and do not participate in a parent layout.
Public Sub Render
    If mVisible And mParent <> Null Then Show(mParent)
End Sub

Private Sub EnsureViews
    Dim createOverlay As Boolean = False
    If mOverlay = Null Then
        createOverlay = True
    Else If mOverlay.IsInitialized = False Then
        createOverlay = True
    End If
    If createOverlay Then
        Dim overlayPanel As Panel
        overlayPanel.Initialize("DialogOverlay")
        mOverlay = overlayPanel
        mParent.AddView(mOverlay, 0, 0, mParent.Width, mParent.Height)
    End If
    Dim createCard As Boolean = False
    If mCardView = Null Then
        createCard = True
    Else If mCardView.IsInitialized = False Then
        createCard = True
    End If
    If createCard Then
        Dim cardPanel As Panel
        cardPanel.Initialize("")
        mCardView = cardPanel
        mOverlay.AddView(mCardView, 0, 0, 0, 0)
    End If
    Dim createTitle As Boolean = False
    If mTitleLabel = Null Then
        createTitle = True
    Else If mTitleLabel.IsInitialized = False Then
        createTitle = True
    End If
    If createTitle Then
        Dim titleLabel As Label
        titleLabel.Initialize("")
        mTitleLabel = titleLabel
        mCardView.AddView(mTitleLabel, 0, 0, 0, 0)
    End If
    Dim createMessage As Boolean = False
    If mMessageLabel = Null Then
        createMessage = True
    Else If mMessageLabel.IsInitialized = False Then
        createMessage = True
    End If
    If createMessage Then
        Dim messageLabel As Label
        messageLabel.Initialize("")
        mMessageLabel = messageLabel
        mCardView.AddView(mMessageLabel, 0, 0, 0, 0)
    End If
    If mPositiveText.Trim <> "" Then
        Dim createPositive As Boolean = False
        If mPositiveButton = Null Then
            createPositive = True
        Else If mPositiveButton.IsInitialized = False Then
            createPositive = True
        End If
        If createPositive Then
            Dim positive As Button
            positive.Initialize("DialogPositive")
            mPositiveButton = positive
            mCardView.AddView(mPositiveButton, 0, 0, 0, 0)
        End If
    End If
    If mNegativeText.Trim <> "" Then
        Dim createNegative As Boolean = False
        If mNegativeButton = Null Then
            createNegative = True
        Else If mNegativeButton.IsInitialized = False Then
            createNegative = True
        End If
        If createNegative Then
            Dim negative As Button
            negative.Initialize("DialogNegative")
            mNegativeButton = negative
            mCardView.AddView(mNegativeButton, 0, 0, 0, 0)
        End If
    End If
    If mPositiveText.Trim = "" And mPositiveButton <> Null Then
        If mPositiveButton.IsInitialized Then mPositiveButton.RemoveViewFromParent
        mPositiveButton = Null
    End If
    If mNegativeText.Trim = "" And mNegativeButton <> Null Then
        If mNegativeButton.IsInitialized Then mNegativeButton.RemoveViewFromParent
        mNegativeButton = Null
    End If
    ApplyText
End Sub

Private Sub ApplyText
    If mTitleLabel <> Null Then
        If mTitleLabel.IsInitialized Then
            Dim titleView As Label = mTitleLabel
            titleView.Text = mTitle
            titleView.TextColor = mTitleColor
            titleView.TextSize = mTheme.TitleLarge
            titleView.Gravity = Gravity.CENTER_VERTICAL
        End If
    End If
    If mMessageLabel <> Null Then
        If mMessageLabel.IsInitialized Then
            Dim messageView As Label = mMessageLabel
            messageView.Text = mMessage
            messageView.TextColor = mMessageColor
            messageView.TextSize = mTheme.BodyLarge
            messageView.Gravity = Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL)
        End If
    End If
End Sub

Private Sub RenderContent
    If mContent = Null Then Return
    If SubExists(mContent, "SetParent") = False Then Return
    CallSub2(mContent, "SetParent", mCardView)
    CallSub3(mContent, "SetPosition", mTheme.HorizontalPadding, 0)
    CallSub3(mContent, "SetSize", Max(0, mCardView.Width - 2 * mTheme.HorizontalPadding), 0)
    If SubExists(mContent, "Render") Then CallSub(mContent, "Render")
End Sub

Private Sub LayoutDialog
    If mParent = Null Then Return
    If mOverlay = Null Then Return
    If mCardView = Null Then Return
    If mParent.IsInitialized = False Then Return
    If mOverlay.IsInitialized = False Or mCardView.IsInitialized = False Then Return

    Dim parentWidth As Int = mParent.Width
    Dim parentHeight As Int = mParent.Height
    Dim dialogWidth As Int = Min(Max(0, parentWidth - 2 * mTheme.DialogOuterMargin), mTheme.DialogMaxWidth)
    If dialogWidth <= 0 Then dialogWidth = parentWidth
    Dim horizontal As Int = mTheme.HorizontalPadding
    Dim titleHeight As Int = mTheme.DialogTitleHeight
    Dim messageHeight As Int = 0
    If mMessage.Trim <> "" Then messageHeight = mTheme.DialogMessageHeight
    Dim contentHeight As Int = 0
    If mContent <> Null Then
        If SubExists(mContent, "GetContentSize") Then
            Dim contentSize As List = CallSub3(mContent, "GetContentSize", dialogWidth - 2 * horizontal, mTheme.DialogMaxContentHeight)
            If contentSize <> Null Then
                If contentSize.IsInitialized Then
                    If contentSize.Size >= 2 Then
                        contentHeight = Min(mTheme.DialogMaxContentHeight, Max(0, contentSize.Get(1)))
                    End If
                End If
            End If
        End If
    End If
    Dim actionHeight As Int = 0
    If mPositiveButton <> Null Or mNegativeButton <> Null Then actionHeight = mTheme.ControlHeight + 8dip
    Dim dialogHeight As Int = titleHeight + messageHeight + contentHeight + actionHeight + 2 * horizontal
    If dialogHeight > parentHeight - 2 * mTheme.DialogOuterMargin Then dialogHeight = Max(0, parentHeight - 2 * mTheme.DialogOuterMargin)

    mOverlay.SetLayoutAnimated(0, 0, 0, parentWidth, parentHeight)
    mCardView.SetLayoutAnimated(0, (parentWidth - dialogWidth) / 2, (parentHeight - dialogHeight) / 2, dialogWidth, dialogHeight)

    Dim y As Int = horizontal
    mTitleLabel.SetLayoutAnimated(0, horizontal, y, dialogWidth - 2 * horizontal, titleHeight)
    y = y + titleHeight
    If mMessage.Trim <> "" Then
        mMessageLabel.SetLayoutAnimated(0, horizontal, y, dialogWidth - 2 * horizontal, messageHeight)
        y = y + messageHeight
    Else
        mMessageLabel.SetLayoutAnimated(0, 0, 0, 0, 0)
    End If
    If mContent <> Null Then
        RenderContent
        If contentHeight > 0 Then
            CallSub3(mContent, "SetPosition", horizontal, y)
            CallSub3(mContent, "SetSize", dialogWidth - 2 * horizontal, contentHeight)
            If SubExists(mContent, "Render") Then CallSub(mContent, "Render")
            y = y + contentHeight
        End If
    End If
    Dim buttonY As Int = dialogHeight - actionHeight - mTheme.DialogButtonSpacing
    Dim buttonWidth As Int = mTheme.DialogButtonWidth
    Dim right As Int = dialogWidth - horizontal
    If mPositiveButton <> Null Then
        Dim positive As Button = mPositiveButton
        positive.Text = mPositiveText
        positive.TextColor = mButtonTextColor
        positive.TextSize = mTheme.LabelLarge
        positive.Gravity = Gravity.CENTER
        positive.Tag = Me
        mPositiveButton.SetLayoutAnimated(0, right - buttonWidth, buttonY, buttonWidth, mTheme.ControlHeight)
        right = right - buttonWidth - mTheme.DialogButtonSpacing
    End If
    If mNegativeButton <> Null Then
        Dim negative As Button = mNegativeButton
        negative.Text = mNegativeText
        negative.TextColor = mButtonTextColor
        negative.TextSize = mTheme.LabelLarge
        negative.Gravity = Gravity.CENTER
        negative.Tag = Me
        mNegativeButton.SetLayoutAnimated(0, right - buttonWidth, buttonY, buttonWidth, mTheme.ControlHeight)
    End If
End Sub

Private Sub ApplyAppearance
    If mOverlay = Null Then Return
    If mCardView = Null Then Return
    If mOverlay.IsInitialized = False Or mCardView.IsInitialized = False Then Return
    Dim overlayPanel As Panel = mOverlay
    overlayPanel.Color = mOverlayColor
    Dim cardPanel As Panel = mCardView
    Dim cardBackground As ColorDrawable
    cardBackground.Initialize2(mSurfaceColor, mRadius, 0, Colors.Transparent)
    cardPanel.Background = cardBackground
    ApplyText
    If mPositiveButton <> Null Then
        mPositiveButton.SetColorAndBorder(mButtonColor, 0, Colors.Transparent, mTheme.ButtonRadius)
        mPositiveButton.TextColor = mButtonTextColor
    End If
    If mNegativeButton <> Null Then
        mNegativeButton.SetColorAndBorder(mButtonColor, 0, Colors.Transparent, mTheme.ButtonRadius)
        mNegativeButton.TextColor = mButtonTextColor
    End If
End Sub

Private Sub DialogOverlay_Click
    If mDismissOnOutside Then Dismiss
End Sub

Private Sub DialogPositive_Click
    Dim button As Button = Sender
    Dim dialog As UIAlertDialog = button.Tag
    If dialog = Null Then Return
    Dim target As Object = dialog.mPositiveTarget
    Dim eventName As String = dialog.mPositiveEventName
    dialog.Dismiss
    If target <> Null And eventName.Trim <> "" Then
        If SubExists(target, eventName) Then CallSub(target, eventName)
    End If
End Sub

Private Sub DialogNegative_Click
    Dim button As Button = Sender
    Dim dialog As UIAlertDialog = button.Tag
    If dialog = Null Then Return
    Dim target As Object = dialog.mNegativeTarget
    Dim eventName As String = dialog.mNegativeEventName
    dialog.Dismiss
    If target <> Null And eventName.Trim <> "" Then
        If SubExists(target, eventName) Then CallSub(target, eventName)
    End If
End Sub

Private Sub RemoveNativeViews
    If mOverlay <> Null Then
        If mOverlay.IsInitialized Then mOverlay.RemoveViewFromParent
    End If
    mOverlay = Null
    mCardView = Null
    mTitleLabel = Null
    mMessageLabel = Null
    mPositiveButton = Null
    mNegativeButton = Null
End Sub

Public Sub Unmount
    mVisible = False
    If mContent <> Null Then
        If SubExists(mContent, "Unmount") Then CallSub(mContent, "Unmount")
    End If
    RemoveNativeViews
    mParent = Null
End Sub

' Natural measurement used by parent layout containers.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
    Dim result As List
    result.Initialize
    Dim safeWidth As Int = MaxWidth
    Dim safeHeight As Int = MaxHeight
    If safeWidth <= 0 Then safeWidth = 320dip
    If safeHeight <= 0 Then safeHeight = 240dip
    result.Add(Min(320dip, safeWidth))
    result.Add(Min(240dip, safeHeight))
    Return result
End Sub