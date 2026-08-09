B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private xui As XUI
    Private mBaseView As B4XView
    Private mContentPanel As B4XView
    Private mScrollView As ScrollView
    Private mParent As B4XView
    Private mLeft, mTop, mWidth, mHeight As Int
    Private mItemCount As Int
    Private mItemHeight As Int
    Private mOverscan As Int
    Private mItems As List
    Private mCreateTarget As Object
    Private mCreateEventName As String
    Private mBindTarget As Object
    Private mBindEventName As String
    Private mVisibleItems As Map
    Private mVisibleContainers As Map
    Private mPool As List
    Private mFirstVisible As Int
    Private mLastVisible As Int
    Private mNeedsRefresh As Boolean
    Private mRefreshing As Boolean
    Private mRefreshPending As Boolean
    Private mBackgroundColor As Int
    Private mBackgroundColorOverridden As Boolean
    Private mTheme As UITheme
End Sub

' Creates an empty fixed-height virtualized vertical list.
' Only visible and overscanned item widgets are mounted.
Public Sub Initialize As UIListView
    mBaseView = Null
    mContentPanel = Null
    mScrollView = Null
    mParent = Null
    mItemCount = 0
    mOverscan = 2
    mItems = Null
    mCreateTarget = Null
    mCreateEventName = ""
    mBindTarget = Null
    mBindEventName = ""
    mVisibleItems.Initialize
    mVisibleContainers.Initialize
    mPool.Initialize
    mFirstVisible = -1
    mLastVisible = -1
    mNeedsRefresh = True
    mRefreshing = False
    mRefreshPending = False
    Dim defaultTheme As UITheme
    defaultTheme.Initialize
    mTheme = defaultTheme
    mItemHeight = mTheme.ControlHeight
    mBackgroundColor = mTheme.Background
    mBackgroundColorOverridden = False
    Return Me
End Sub

' Uses a List as the data source. The list is read through GetItem during binding.
Public Sub Items(Data As List) As UIListView
    If Data = Null Then Return Me
    If Data.IsInitialized = False Then Return Me
    mItems = Data
    mItemCount = Data.Size
    NotifyDataSetChanged
    Return Me
End Sub

' Sets the item count when data is kept elsewhere by the host.
Public Sub ItemCount(Count As Int) As UIListView
    mItems = Null
    mItemCount = Max(0, Count)
    NotifyDataSetChanged
    Return Me
End Sub

' Removes the data source and all list items explicitly.
Public Sub ClearItems As UIListView
    mItems = Null
    mItemCount = 0
    NotifyDataSetChanged
    Return Me
End Sub

' Returns the data item at Index, or Null when the host owns the data source.
Public Sub GetItem(Index As Int) As Object
    If mItems = Null Then Return Null
    If mItems.IsInitialized = False Then Return Null
    If Index < 0 Or Index >= mItems.Size Then Return Null
    Return mItems.Get(Index)
End Sub

' Sets the fixed height used for every virtual item.
' Fixed height keeps offsets predictable and avoids measuring thousands of rows.
Public Sub ItemHeight(Height As Int) As UIListView
    mItemHeight = Max(1dip, Height)
    NotifyDataSetChanged
    Return Me
End Sub

' Adds extra rows above and below the viewport to reduce pop-in during fast scrolling.
Public Sub Overscan(Count As Int) As UIListView
    mOverscan = Max(0, Count)
    NotifyDataSetChanged
    Return Me
End Sub

' Registers Sub EventName(Index As Int) As Object.
' The callback must return an initialized widget implementing the composition protocol.
' BindItem is required for safe widget reuse when rows display changing data.
' Without BindItem, rows are created again instead of being pooled.
Public Sub CreateItem(Target As Object, EventName As String) As UIListView
    If Target = Null Or EventName.Trim = "" Then Return Me
    If SubExists(Target, EventName) = False Then Return Me
    RecycleAllVisible
    mPool.Clear
    mCreateTarget = Target
    mCreateEventName = EventName
    NotifyDataSetChanged
    Return Me
End Sub

' Registers Sub EventName(Index As Int, ItemView As Object).
' The callback updates a recycled widget and may call GetItem(Index).
Public Sub BindItem(Target As Object, EventName As String) As UIListView
    If Target = Null Or EventName.Trim = "" Then Return Me
    If SubExists(Target, EventName) = False Then Return Me
    RecycleAllVisible
    mPool.Clear
    mBindTarget = Target
    mBindEventName = EventName
    NotifyDataSetChanged
    Return Me
End Sub

' Applies a theme to the list and to currently pooled or visible widgets.
Public Sub ApplyTheme(Theme As UITheme) As UIListView
    If Theme = Null Then Return Me
    If Theme.IsInitialized = False Then Return Me
    mTheme = Theme
    If mBackgroundColorOverridden = False Then mBackgroundColor = mTheme.Background
    For Each item As Object In mPool
        ApplyThemeToItem(item, Theme)
    Next
    For Each key As Int In mVisibleItems.Keys
        ApplyThemeToItem(mVisibleItems.Get(key), Theme)
    Next
    If mParent <> Null Then
        If mParent.IsInitialized Then Render
    End If
    Return Me
End Sub

Public Sub BackgroundColor(Color As Int) As UIListView
    mBackgroundColor = Color
    mBackgroundColorOverridden = True
    If mBaseView <> Null Then
        If mBaseView.IsInitialized Then mBaseView.Color = Color
    End If
    Return Me
End Sub

' Invalidates the visible window after the data source or item binding changes.
Public Sub NotifyDataSetChanged
    If mItems <> Null Then
        If mItems.IsInitialized Then mItemCount = mItems.Size
    End If
    mNeedsRefresh = True
    If mRefreshing Then
        ' Defer structural work until the current visible-window pass is complete.
        mRefreshPending = True
        Return
    End If
    ' Without BindItem, visible rows cannot be safely updated in place.
    ' Recreate them from CreateItem so a changed data source never leaves stale content.
    If HasBindCallback = False Then RecycleAllVisible
    If mParent <> Null Then
        If mParent.IsInitialized Then Render
    End If
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
    EnsureNativeView
    mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    mBaseView.Color = mBackgroundColor

    Dim totalHeight As Int = Max(mHeight, mItemCount * mItemHeight)
    mContentPanel.Width = mWidth
    mContentPanel.Height = totalHeight

    Dim position As Int = mScrollView.ScrollPosition
    Dim maxPosition As Int = Max(0, totalHeight - mHeight)
    If position > maxPosition Then
        position = maxPosition
        mScrollView.ScrollPosition = position
    End If
    RefreshVisibleWindow(position)
End Sub

Private Sub EnsureNativeView
    Dim createBase As Boolean = False
    If mBaseView = Null Then
        createBase = True
    Else If mBaseView.IsInitialized = False Then
        createBase = True
    End If
    If createBase Then
        ' Initialize2 supplies both the initial content height and the event prefix.
        mScrollView.Initialize2(0, "mScrollView")
        mBaseView = mScrollView
        mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
        mContentPanel = mScrollView.Panel
    End If
    If mContentPanel = Null Then
        mContentPanel = mScrollView.Panel
    Else If mContentPanel.IsInitialized = False Then
        mContentPanel = mScrollView.Panel
    End If
End Sub

Private Sub RefreshVisibleWindow(Position As Int)
    If mRefreshing Then
        mRefreshPending = True
        Return
    End If
    mRefreshing = True

    If mItemCount <= 0 Then
        RecycleAllVisible
        mFirstVisible = -1
        mLastVisible = -1
        mNeedsRefresh = False
        mRefreshing = False
        Return
    End If

    Dim first As Int = Max(0, Floor(Position / mItemHeight) - mOverscan)
    Dim last As Int = Min(mItemCount - 1, Ceil((Position + mHeight) / mItemHeight) + mOverscan)
    If mNeedsRefresh = False And first = mFirstVisible And last = mLastVisible Then
        mRefreshing = False
        Return
    End If

    Dim keysToRecycle As List
    keysToRecycle.Initialize
    For Each key As Int In mVisibleItems.Keys
        If key < first Or key > last Then keysToRecycle.Add(key)
    Next
    For Each key As Int In keysToRecycle
        RecycleItem(key)
    Next

    Dim canBind As Boolean = HasBindCallback
    For index = first To last
        Dim itemView As Object
        If mVisibleItems.ContainsKey(index) Then
            itemView = mVisibleItems.Get(index)
        Else
            itemView = AcquireItem(index, canBind)
            If IsWidgetProtocol(itemView) = False Then Continue
            Dim itemPanel As Panel
            itemPanel.Initialize("")
            Dim itemContainer As B4XView = itemPanel
            itemContainer.Color = Colors.Transparent
            mContentPanel.AddView(itemContainer, 0, index * mItemHeight, mWidth, mItemHeight)
            mVisibleContainers.Put(index, itemContainer)
            mVisibleItems.Put(index, itemView)
        End If

        If canBind Then CallSub3(mBindTarget, mBindEventName, index, itemView)
        ApplyThemeToItem(itemView, mTheme)
        Dim itemContainer As B4XView = mVisibleContainers.Get(index)
        itemContainer.SetLayoutAnimated(0, 0, index * mItemHeight, mWidth, mItemHeight)
        CallSub2(itemView, "SetParent", itemContainer)
        CallSub3(itemView, "SetPosition", 0, 0)
        CallSub3(itemView, "SetSize", mWidth, mItemHeight)
        CallSub(itemView, "Render")
    Next
    mFirstVisible = first
    mLastVisible = last
    mNeedsRefresh = False
    mRefreshing = False

    If mRefreshPending Then
        mRefreshPending = False
        If HasBindCallback = False Then RecycleAllVisible
        If mParent <> Null Then
        If mParent.IsInitialized Then Render
    End If
    End If
End Sub

Private Sub AcquireItem(Index As Int, CanReuse As Boolean) As Object
    Dim itemView As Object
    If CanReuse And mPool.Size > 0 Then
        itemView = mPool.Get(mPool.Size - 1)
        mPool.RemoveAt(mPool.Size - 1)
        Return itemView
    End If
    If mCreateTarget = Null Or mCreateEventName.Trim = "" Then Return Null
    If SubExists(mCreateTarget, mCreateEventName) = False Then Return Null
    Return CallSub2(mCreateTarget, mCreateEventName, Index)
End Sub

Private Sub HasBindCallback As Boolean
    If mBindTarget = Null Or mBindEventName.Trim = "" Then Return False
    Return SubExists(mBindTarget, mBindEventName)
End Sub

Private Sub RecycleItem(Index As Int)
    If mVisibleItems.ContainsKey(Index) = False Then Return
    Dim itemView As Object = mVisibleItems.Get(Index)
    If itemView <> Null Then
        If SubExists(itemView, "Unmount") Then CallSub(itemView, "Unmount")
        If HasBindCallback Then mPool.Add(itemView)
    End If
    If mVisibleContainers.ContainsKey(Index) Then
        Dim itemContainer As B4XView = mVisibleContainers.Get(Index)
        If itemContainer <> Null Then
            If itemContainer.IsInitialized Then itemContainer.RemoveViewFromParent
        End If
        mVisibleContainers.Remove(Index)
    End If
    mVisibleItems.Remove(Index)
End Sub

Private Sub RecycleAllVisible
    Dim keysToRecycle As List
    keysToRecycle.Initialize
    For Each key As Int In mVisibleItems.Keys
        keysToRecycle.Add(key)
    Next
    For Each key As Int In keysToRecycle
        RecycleItem(key)
    Next
End Sub

Private Sub ApplyThemeToItem(Item As Object, Theme As UITheme)
    If Item <> Null And SubExists(Item, "ApplyTheme") Then CallSub2(Item, "ApplyTheme", Theme)
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
    If Widget = Null Then Return False
    Return SubExists(Widget, "SetParent") And SubExists(Widget, "SetPosition") _
        And SubExists(Widget, "SetSize") And SubExists(Widget, "Render") _
        And SubExists(Widget, "GetContentSize")
End Sub

Private Sub mScrollView_ScrollChanged(Position As Int)
    RefreshVisibleWindow(Position)
End Sub

' The list needs a viewport; place it directly in a scaffold or inside UIExpanded.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
    Dim flexibleSize As List
    flexibleSize.Initialize
    Return flexibleSize
End Sub

Public Sub GetView As B4XView
    If mBaseView = Null Then Return Null
    If mBaseView.IsInitialized = False Then Return Null
    Return mBaseView
End Sub

Public Sub Unmount
    RecycleAllVisible
    mPool.Clear
    mFirstVisible = -1
    mLastVisible = -1
    mNeedsRefresh = True
    mRefreshing = False
    mRefreshPending = False
    If mBaseView <> Null Then
        If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
    End If
    mScrollView = Null
    mContentPanel = Null
    mBaseView = Null
    mParent = Null
End Sub