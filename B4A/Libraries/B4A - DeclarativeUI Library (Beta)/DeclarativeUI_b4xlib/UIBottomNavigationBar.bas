B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private xui As XUI
    Private mItems As List
    Private mIconLabels As List
    Private mTextLabels As List
    Private mIndicatorViews As List
    Private mBaseView As B4XView
    Private mParent As B4XView
    Private mSelectedState As UIState
    Private mTarget As Object
    Private mEventName As String
    Private mBackgroundColor As Int
    Private mActiveColor As Int
    Private mInactiveColor As Int
    Private mIndicatorColor As Int
    Private mDividerColor As Int
    Private mBackgroundColorOverridden As Boolean
    Private mActiveColorOverridden As Boolean
    Private mInactiveColorOverridden As Boolean
    Private mIndicatorColorOverridden As Boolean
    Private mDividerColorOverridden As Boolean
    Private mTheme As UITheme
    Private mIconSize As Int
    Private mIconSizeOverridden As Boolean
    Private mTextSize As Int
    Private mTextSizeOverridden As Boolean
    Private mUseFontAwesome As Boolean
    Private mShowInactiveLabels As Boolean
    Private mSelectedIndex As Int
    Private mBuiltItemCount As Int
    Private mBuiltWidth, mBuiltHeight As Int
    Private mBuilt As Boolean
    Private mLeft, mTop, mWidth, mHeight As Int
End Sub

' Creates an empty declarative bottom navigation bar.
Public Sub Initialize As UIBottomNavigationBar
    If mSelectedState <> Null Then
        If mSelectedState.IsInitialized Then mSelectedState.Unsubscribe(Me, "SelectedState_Changed")
    End If
    mItems.Initialize
    mIconLabels.Initialize
    mTextLabels.Initialize
    mIndicatorViews.Initialize
    mBaseView = Null
    mParent = Null
    mSelectedState = Null
    mTarget = Null
    mEventName = ""
    Dim defaultTheme As UITheme
    defaultTheme.Initialize
    mTheme = defaultTheme
    mBackgroundColor = mTheme.Surface
    mActiveColor = mTheme.Accent
    mInactiveColor = mTheme.MutedText
    mIndicatorColor = mTheme.Accent
    mDividerColor = mTheme.Divider
    mBackgroundColorOverridden = False
    mActiveColorOverridden = False
    mInactiveColorOverridden = False
    mIndicatorColorOverridden = False
    mDividerColorOverridden = False
    mIconSize = mTheme.NavigationIconSize
    mIconSizeOverridden = False
    mTextSize = mTheme.NavigationTextSize
    mTextSizeOverridden = False
    mUseFontAwesome = False
    mShowInactiveLabels = False
    mSelectedIndex = 0
    mBuiltItemCount = -1
    mBuiltWidth = -1
    mBuiltHeight = -1
    mBuilt = False
    Return Me
End Sub

' Adds one item. Icon is a displayable Unicode string, for example Chr(59648).
Public Sub AddItem(Id As String, Icon As String, Text As String) As UIBottomNavigationBar
    Dim item As Map
    item.Initialize
    item.Put("Id", Id)
    item.Put("Icon", Icon)
    item.Put("Text", Text)
    mItems.Add(item)
    mBuilt = False
    If mParent <> Null Then
        If mParent.IsInitialized Then Render
    End If
    Return Me
End Sub

Public Sub ClearItems As UIBottomNavigationBar
    mItems.Clear
    mSelectedIndex = 0
    mBuilt = False
    If mParent <> Null Then
        If mParent.IsInitialized Then Render
    End If
    Return Me
End Sub

' Binds the selected item index to a UIState containing a number.
Public Sub BindSelectedIndex(State As UIState) As UIBottomNavigationBar
    If mSelectedState <> Null Then
        If mSelectedState.IsInitialized Then mSelectedState.Unsubscribe(Me, "SelectedState_Changed")
    End If
    mSelectedState = State
    If mSelectedState <> Null Then
        If mSelectedState.IsInitialized Then
            mSelectedIndex = ReadIndex(mSelectedState.GetState)
            mSelectedState.Subscribe(Me, "SelectedState_Changed")
            If mParent <> Null Then
                If mParent.IsInitialized Then Render
            End If
        End If
    End If
    Return Me
End Sub

Public Sub UnbindSelectedIndex As UIBottomNavigationBar
    If mSelectedState <> Null Then
        If mSelectedState.IsInitialized Then mSelectedState.Unsubscribe(Me, "SelectedState_Changed")
    End If
    mSelectedState = Null
    Return Me
End Sub

' Registers Sub EventName(Index As Int, Id As String).
Public Sub OnSelected(Target As Object, EventName As String) As UIBottomNavigationBar
    mTarget = Target
    mEventName = EventName
    Return Me
End Sub

Public Sub BackgroundColor(Color As Int) As UIBottomNavigationBar
    mBackgroundColor = Color
    mBackgroundColorOverridden = True
    RefreshIfMounted
    Return Me
End Sub

Public Sub ActiveColor(Color As Int) As UIBottomNavigationBar
    mActiveColor = Color
    mActiveColorOverridden = True
    RefreshIfMounted
    Return Me
End Sub

Public Sub InactiveColor(Color As Int) As UIBottomNavigationBar
    mInactiveColor = Color
    mInactiveColorOverridden = True
    RefreshIfMounted
    Return Me
End Sub

Public Sub IndicatorColor(Color As Int) As UIBottomNavigationBar
    mIndicatorColor = Color
    mIndicatorColorOverridden = True
    RefreshIfMounted
    Return Me
End Sub

Public Sub DividerColor(Color As Int) As UIBottomNavigationBar
    mDividerColor = Color
    mDividerColorOverridden = True
    mBuilt = False
    RefreshIfMounted
    Return Me
End Sub

' Applies theme defaults without replacing explicit color overrides.
Public Sub ApplyTheme(Theme As UITheme) As UIBottomNavigationBar
    If Theme = Null Then Return Me
    If Theme.IsInitialized = False Then Return Me
    mTheme = Theme
    If mBackgroundColorOverridden = False Then mBackgroundColor = mTheme.Surface
    If mActiveColorOverridden = False Then mActiveColor = mTheme.Accent
    If mInactiveColorOverridden = False Then mInactiveColor = mTheme.MutedText
    If mIndicatorColorOverridden = False Then mIndicatorColor = mTheme.Accent
    If mDividerColorOverridden = False Then mDividerColor = mTheme.Divider
    If mIconSizeOverridden = False Then mIconSize = mTheme.NavigationIconSize
    If mTextSizeOverridden = False Then mTextSize = mTheme.NavigationTextSize
    ' The divider is created during BuildNativeItems, so invalidate the native
    ' item tree to ensure a runtime theme change reaches it as well.
    mBuilt = False
    RefreshIfMounted
    Return Me
End Sub

Public Sub IconSize(Size As Int) As UIBottomNavigationBar
    mIconSize = Max(1, Size)
    mIconSizeOverridden = True
    mBuilt = False
    RefreshIfMounted
    Return Me
End Sub

Public Sub TextSize(Size As Int) As UIBottomNavigationBar
    mTextSize = Max(1, Size)
    mTextSizeOverridden = True
    mBuilt = False
    RefreshIfMounted
    Return Me
End Sub

' Uses the bundled FontAwesome typeface for icon strings such as Chr(61461).
' The default remains the platform typeface for backwards compatibility.
Public Sub UseFontAwesome(Value As Boolean) As UIBottomNavigationBar
    mUseFontAwesome = Value
    mBuilt = False
    RefreshIfMounted
    Return Me
End Sub

Public Sub ShowInactiveLabels(Value As Boolean) As UIBottomNavigationBar
    mShowInactiveLabels = Value
    RefreshIfMounted
    Return Me
End Sub

Public Sub SetSelectedIndex(Index As Int)
    SetActiveIndex(Index, True)
End Sub

Public Sub GetSelectedIndex As Int
    Return mSelectedIndex
End Sub

Public Sub GetSelectedId As String
    If mSelectedIndex < 0 Or mSelectedIndex >= mItems.Size Then Return ""
    Dim item As Map = mItems.Get(mSelectedIndex)
    Return item.GetDefault("Id", "")
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
    If mSelectedState <> Null Then
        If mSelectedState.IsInitialized Then
            mSelectedIndex = ReadIndex(mSelectedState.GetState)
            mSelectedState.Subscribe(Me, "SelectedState_Changed")
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
        mBuilt = False
    End If
    mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    mBaseView.Color = mBackgroundColor

    If mItems.Size = 0 Then
        mBaseView.RemoveAllViews
        mBuilt = False
        mBuiltItemCount = 0
        Return
    End If

    If mSelectedIndex < 0 Or mSelectedIndex >= mItems.Size Then mSelectedIndex = 0
    If mBuilt = False Or mBuiltItemCount <> mItems.Size Or mBuiltWidth <> mWidth Or mBuiltHeight <> mHeight Then BuildNativeItems
    ApplySelection
End Sub

Private Sub BuildNativeItems
    mBaseView.RemoveAllViews
    mIconLabels.Initialize
    mTextLabels.Initialize
    mIndicatorViews.Initialize

    Dim divider As Panel
    divider.Initialize("")
    divider.Color = mDividerColor
    mBaseView.AddView(divider, 0, 0, mWidth, mTheme.NavigationDividerHeight)

    Dim itemWidth As Int = mWidth / mItems.Size
    Dim currentLeft As Int = 0
    For i = 0 To mItems.Size - 1
        Dim item As Map = mItems.Get(i)
        Dim currentWidth As Int = itemWidth
        If i = mItems.Size - 1 Then currentWidth = mWidth - currentLeft

        Dim tabPanel As Panel
        tabPanel.Initialize("")
        Dim tabView As B4XView = tabPanel
        tabView.Color = Colors.Transparent
        mBaseView.AddView(tabView, currentLeft, mTheme.NavigationDividerHeight, currentWidth, Max(0, mHeight - mTheme.NavigationDividerHeight))

        Dim icon As Label
        icon.Initialize("")
        icon.Text = item.GetDefault("Icon", "")
        icon.Gravity = Gravity.CENTER
        icon.TextSize = mIconSize
        icon.TextColor = mInactiveColor
        If mUseFontAwesome Then icon.Typeface = Typeface.FONTAWESOME
        Dim navPadding As Int = mTheme.NavigationHorizontalPadding
        tabView.AddView(icon, navPadding, navPadding, Max(0, currentWidth - 2 * navPadding), mTheme.NavigationIconHeight)
        mIconLabels.Add(icon)

        Dim caption As Label
        caption.Initialize("")
        caption.Text = item.GetDefault("Text", "")
        caption.Gravity = Gravity.CENTER
        caption.TextSize = mTextSize
        caption.TextColor = mInactiveColor
        tabView.AddView(caption, navPadding, mTheme.NavigationCaptionTop, Max(0, currentWidth - 2 * navPadding), Max(0, mHeight - mTheme.NavigationCaptionTop - mTheme.NavigationLabelBottomInset))
        mTextLabels.Add(caption)

        Dim indicator As Panel
        indicator.Initialize("")
        indicator.Color = mIndicatorColor
        Dim indicatorView As B4XView = indicator
        Dim indicatorInset As Int = mTheme.NavigationIndicatorInset
        tabView.AddView(indicatorView, indicatorInset, Max(0, mHeight - mTheme.NavigationIndicatorHeight), Max(0, currentWidth - 2 * indicatorInset), mTheme.NavigationIndicatorHeight)
        mIndicatorViews.Add(indicatorView)

        Dim clickSurface As Panel
        clickSurface.Initialize("NativeTab")
        Dim clickView As B4XView = clickSurface
        clickView.Color = Colors.Transparent
        clickView.Tag = i
        tabView.AddView(clickView, 0, 0, currentWidth, Max(0, mHeight - mTheme.NavigationDividerHeight))
        currentLeft = currentLeft + currentWidth
    Next
    mBuiltItemCount = mItems.Size
    mBuiltWidth = mWidth
    mBuiltHeight = mHeight
    mBuilt = True
End Sub

Private Sub ApplySelection
    For i = 0 To mItems.Size - 1
        Dim icon As Label = mIconLabels.Get(i)
        Dim caption As Label = mTextLabels.Get(i)
        Dim indicator As B4XView = mIndicatorViews.Get(i)
        If i = mSelectedIndex Then
            icon.TextColor = mActiveColor
            caption.TextColor = mActiveColor
            caption.Visible = True
            If mUseFontAwesome Then
                icon.Typeface = Typeface.FONTAWESOME
            Else
                icon.Typeface = Typeface.DEFAULT_BOLD
            End If
            caption.Typeface = Typeface.DEFAULT_BOLD
            indicator.Color = mIndicatorColor
            indicator.Visible = True
        Else
            icon.TextColor = mInactiveColor
            caption.TextColor = mInactiveColor
            caption.Visible = mShowInactiveLabels
            If mUseFontAwesome Then
                icon.Typeface = Typeface.FONTAWESOME
            Else
                icon.Typeface = Typeface.DEFAULT
            End If
            caption.Typeface = Typeface.DEFAULT
            indicator.Visible = False
        End If
    Next
End Sub

Private Sub NativeTab_Click
    Dim clickSurface As Panel = Sender
    Dim index As Int = clickSurface.Tag
    SetActiveIndex(index, True)
End Sub

Private Sub SetActiveIndex(Index As Int, Notify As Boolean)
    If Index < 0 Or Index >= mItems.Size Then Return
    If mSelectedIndex = Index And Notify = False Then Return
    mSelectedIndex = Index
    If mSelectedState <> Null Then
        If mSelectedState.IsInitialized Then mSelectedState.SetState(Index)
    End If
    If mParent <> Null Then
        If mParent.IsInitialized Then Render
    Else If mBaseView <> Null Then
        If mBaseView.IsInitialized Then ApplySelection
    End If
    If Notify Then DispatchSelection
End Sub

Private Sub DispatchSelection
    If mTarget = Null Or mEventName.Trim = "" Then Return
    If SubExists(mTarget, mEventName) = False Then Return
    CallSub3(mTarget, mEventName, mSelectedIndex, GetSelectedId)
End Sub

Private Sub SelectedState_Changed(State As UIState)
    If State = Null Then Return
    If State.IsInitialized = False Then Return
    SetActiveIndex(ReadIndex(State.GetState), False)
End Sub

Private Sub ReadIndex(Value As Object) As Int
    If Value = Null Then Return 0
    Dim text As String = "" & Value
    If IsNumber(text) Then
        Dim index As Int = text
        Return Max(0, index)
    End If
    Return 0
End Sub

Private Sub RefreshIfMounted
    If mParent <> Null Then
        If mParent.IsInitialized Then Render
    End If
End Sub

Public Sub Unmount
    If mSelectedState <> Null Then
        If mSelectedState.IsInitialized Then mSelectedState.Unsubscribe(Me, "SelectedState_Changed")
    End If
    mBaseView = Null
    mParent = Null
    mBuilt = False
End Sub

' Reports a standard 64dip bottom-navigation height.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
    Dim result As List
    result.Initialize
    Dim safeMaxWidth As Int = MaxWidth
    Dim safeMaxHeight As Int = MaxHeight
    If safeMaxWidth <= 0 Then safeMaxWidth = 10000
    If safeMaxHeight <= 0 Then safeMaxHeight = 10000
    result.Add(safeMaxWidth)
    result.Add(Min(mTheme.BottomNavigationHeight, safeMaxHeight))
    Return result
End Sub