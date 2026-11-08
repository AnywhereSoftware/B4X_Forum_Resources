B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private xui As XUI
    Private mBridge As UIWidgetBridge
    Private mChild As Object
    Private mScrollView As ScrollView
    Private mBaseView As B4XView
    Private mParent As B4XView
    Private mMountedChild As Object
    Private mLeft, mTop, mWidth, mHeight As Int
    Private mContentHeight As Int
End Sub

' Creates an empty declarative scroll container.
Public Sub Initialize As UIScrollView
    mBridge.Initialize
    mChild = Null
    mScrollView = Null
    mBaseView = Null
    mParent = Null
    mMountedChild = Null
    mContentHeight = 0
    Return Me
End Sub

' Sets the single child rendered inside the scrollable content panel.
Public Sub Child(Component As Object) As UIScrollView
    If IsWidgetProtocol(Component) Then mChild = Component
    Return Me
End Sub

' Returns the currently assigned child.
Public Sub GetChild As Object
    Return mChild
End Sub

' Propagates the active theme to the scrollable child.
Public Sub ApplyTheme(Theme As UITheme) As UIScrollView
    If Theme = Null Then Return Me
    If Theme.IsInitialized = False Then Return Me
    If mChild <> Null Then
        If SubExists(mChild, "ApplyTheme") Then CallSub2(mChild, "ApplyTheme", Theme)
    End If
    Return Me
End Sub

' Assigns the native parent container used during rendering.
Public Sub SetParent(Parent As B4XView)
    mParent = Parent
End Sub

' Stores the position assigned by the parent layout.
Public Sub SetPosition(Left As Int, Top As Int)
    mLeft = Left
    mTop = Top
End Sub

' Stores the viewport size assigned by the parent layout.
Public Sub SetSize(Width As Int, Height As Int)
    mWidth = Max(0, Width)
    mHeight = Max(0, Height)
End Sub

' Mounts the native ScrollView and lays out its declarative child.
' Re-rendering updates the existing content tree instead of rebuilding it.
Public Sub Render
    If mParent = Null Then Return
    If mParent.IsInitialized = False Then Return

    Dim needsCreate As Boolean = False
    If mBaseView = Null Then
        needsCreate = True
    Else If mBaseView.IsInitialized = False Then
        needsCreate = True
    End If

    If needsCreate Then
        ' B4A ScrollView.Initialize receives the initial content height, not an event name.
        mScrollView.Initialize(0)
        mBaseView = mScrollView
        mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
    End If

    ' Re-attach when the view was temporarily detached (e.g. a navigator
    ' recycled this screen): RemoveViewFromParent keeps IsInitialized True,
    ' so the needsCreate branch alone would never re-add the view.
    If mBaseView.Parent <> mParent Then
        If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
        mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
    End If

    mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    ' Keep the native ScrollView and the same declarative child mounted during
    ' ordinary updates. This preserves scroll position, focus and native state.
    ' A replaced child is structural, so remove only the previous content tree.
    If mMountedChild <> Null Then
		If mMountedChild <> mChild Then
			mBridge.Unmount(mMountedChild)
			mScrollView.Panel.RemoveAllViews
			mMountedChild = Null
		End If
	End If
    mScrollView.Panel.Width = Max(0, mWidth)

    Dim viewportWidth As Int = Max(0, mWidth)
    Dim viewportHeight As Int = Max(0, mHeight)
    Dim contentHeight As Int = viewportHeight

    If mChild <> Null Then
        Dim childSize As List = mBridge.GetContentSize(mChild, viewportWidth, 100000dip)
        If mBridge.LastCallSucceeded = False Then childSize = Null
        If childSize <> Null Then
            If childSize.IsInitialized Then
                If childSize.Size >= 2 Then contentHeight = Max(viewportHeight, childSize.Get(1))
            End If
        End If
        mContentHeight = contentHeight

        mScrollView.Panel.Height = contentHeight
        Dim contentPanel As B4XView = mScrollView.Panel
        mBridge.SetParent(mChild, contentPanel)
        mBridge.SetPosition(mChild, 0, 0)
        mBridge.SetSize(mChild, viewportWidth, contentHeight)
        mBridge.Render(mChild)
        mMountedChild = mChild
    Else
        If mMountedChild <> Null Then
            mBridge.Unmount(mMountedChild)
            mScrollView.Panel.RemoveAllViews
            mMountedChild = Null
        End If
        mContentHeight = viewportHeight
        mScrollView.Panel.Width = viewportWidth
        mScrollView.Panel.Height = viewportHeight
    End If
End Sub

' Scrolls to an absolute vertical content position.
Public Sub ScrollTo(Position As Int)
    If mScrollView = Null Then Return
    If mScrollView.IsInitialized = False Then Return
    mScrollView.ScrollPosition = Max(0, Min(Position, Max(0, mContentHeight - mHeight)))
End Sub

' Returns the current vertical scroll position.
Public Sub GetScrollPosition As Int
    If mScrollView = Null Then Return 0
    If mScrollView.IsInitialized = False Then Return 0
    Return mScrollView.ScrollPosition
End Sub

' Temporarily detaches the viewport while preserving scroll position and child identity.
Public Sub Detach
    If mBaseView <> Null Then
        If mBaseView.IsInitialized Then
            If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
        End If
    End If
    If mChild <> Null Then mBridge.Detach(mChild)
    mParent = Null
End Sub

' Removes the native view and releases child mounting references.
Public Sub Unmount
    If mMountedChild <> Null Then
        mBridge.Unmount(mMountedChild)
    End If
    If mBaseView <> Null Then
        If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
    End If
    mScrollView = Null
    mBaseView = Null
    mParent = Null
    mMountedChild = Null
    mContentHeight = 0
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
    Return mBridge.IsWidgetProtocol(Widget)
End Sub

' Returns the child's natural size when it can be measured.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
    If mChild <> Null Then
        Dim childSize As List = mBridge.GetContentSize(mChild, MaxWidth, MaxHeight)
        If mBridge.LastCallSucceeded = False Then childSize = Null
        If childSize <> Null Then
            If childSize.IsInitialized Then
                If childSize.Size >= 2 Then Return childSize
            End If
        End If
    End If

    Dim flexibleSize As List
    flexibleSize.Initialize
    Return flexibleSize
End Sub