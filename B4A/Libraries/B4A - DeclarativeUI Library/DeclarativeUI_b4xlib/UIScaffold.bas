B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mBridge As UIWidgetBridge
	Private mAppBar As Object
	Private mBody As Object
	Private mFabLeft As Object
	Private mFabRight As Object
	Private mBottomNavigationBar As Object
	Private mBackgroundColor As Int
	Private mBackgroundColorOverridden As Boolean
	Private mTheme As UITheme
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mMounted As Boolean
	Private mLeft, mTop, mWidth, mHeight As Int
	Private mInsetLeft, mInsetTop, mInsetRight, mInsetBottom As Int
End Sub

Public Sub Initialize As UIScaffold
	mBridge.Initialize
	' Initialize optional slots explicitly to avoid invalid object references.
	mAppBar = Null
	mBody = Null
	mFabLeft = Null
	mFabRight = Null
	mBottomNavigationBar = Null
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mBackgroundColor = mTheme.Background
	mBackgroundColorOverridden = False
	mMounted = False
	Return Me
End Sub

Public Sub AppBar(bar As Object) As UIScaffold
	If IsWidgetProtocol(bar) = False Then Return Me
	If mAppBar <> Null Then
		If mAppBar = bar Then Return Me
	End If
	Dim wasMounted As Boolean = PrepareForStructureChange
	mAppBar = bar
	If wasMounted Then Render
	Return Me
End Sub

' Removes the current app bar explicitly and safely.
Public Sub ClearAppBar As UIScaffold
	Dim wasMounted As Boolean = PrepareForStructureChange
	mAppBar = Null
	If wasMounted Then Render
	Return Me
End Sub

Public Sub Body(b As Object) As UIScaffold
	If IsWidgetProtocol(b) = False Then Return Me
	If mBody <> Null Then
		If mBody = b Then Return Me
	End If
	Dim wasMounted As Boolean = PrepareForStructureChange
	mBody = b
	If wasMounted Then Render
	Return Me
End Sub

' Removes the current body explicitly and safely.
Public Sub ClearBody As UIScaffold
	Dim wasMounted As Boolean = PrepareForStructureChange
	mBody = Null
	If wasMounted Then Render
	Return Me
End Sub

Public Sub FloatingActionButtonLeft(fab As Object) As UIScaffold
	If IsWidgetProtocol(fab) = False Then Return Me
	If mFabLeft <> Null Then
		If mFabLeft = fab Then Return Me
	End If
	Dim wasMounted As Boolean = PrepareForStructureChange
	mFabLeft = fab
	If wasMounted Then Render
	Return Me
End Sub

' Removes the left floating action button explicitly and safely.
Public Sub ClearFloatingActionButtonLeft As UIScaffold
	Dim wasMounted As Boolean = PrepareForStructureChange
	mFabLeft = Null
	If wasMounted Then Render
	Return Me
End Sub

Public Sub FloatingActionButtonRight(fab As Object) As UIScaffold
	If IsWidgetProtocol(fab) = False Then Return Me
	If mFabRight <> Null Then
		If mFabRight = fab Then Return Me
	End If
	Dim wasMounted As Boolean = PrepareForStructureChange
	mFabRight = fab
	If wasMounted Then Render
	Return Me
End Sub

' Removes the right floating action button explicitly and safely.
Public Sub ClearFloatingActionButtonRight As UIScaffold
	Dim wasMounted As Boolean = PrepareForStructureChange
	mFabRight = Null
	If wasMounted Then Render
	Return Me
End Sub

' Adds an optional persistent bottom navigation slot.
Public Sub BottomNavigationBar(bar As Object) As UIScaffold
	If IsWidgetProtocol(bar) = False Then Return Me
	If mBottomNavigationBar <> Null Then
		If mBottomNavigationBar = bar Then Return Me
	End If
	Dim wasMounted As Boolean = PrepareForStructureChange
	mBottomNavigationBar = bar
	If wasMounted Then Render
	Return Me
End Sub

' Removes the bottom navigation bar explicitly and safely.
Public Sub ClearBottomNavigationBar As UIScaffold
	Dim wasMounted As Boolean = PrepareForStructureChange
	mBottomNavigationBar = Null
	If wasMounted Then Render
	Return Me
End Sub

' Sets the screen background. This is separate from the Activity root so each
' virtual screen follows the active UITheme when it is remounted.
Public Sub BackgroundColor(Color As Int) As UIScaffold
	mBackgroundColor = Color
	mBackgroundColorOverridden = True
	Return Me
End Sub

' Applies the theme to the scaffold and all theme-aware slots.
Public Sub ApplyTheme(Theme As UITheme) As UIScaffold
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	If mBackgroundColorOverridden = False Then mBackgroundColor = mTheme.Background
	ApplyThemeToChild(mAppBar, Theme)
	ApplyThemeToChild(mBody, Theme)
	ApplyThemeToChild(mFabLeft, Theme)
	ApplyThemeToChild(mFabRight, Theme)
	ApplyThemeToChild(mBottomNavigationBar, Theme)
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

Private Sub ApplyThemeToChild(Child As Object, Theme As UITheme)
	If Child = Null Then Return
	If SubExists(Child, "ApplyTheme") Then CallSub2(Child, "ApplyTheme", Theme)
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
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mMounted = True
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mBaseView.Color = mBackgroundColor
	MeasureInsets
    
	' Calculate offsets for the app bar, body, and floating action buttons.
	Dim topOffset As Int = 0
	Dim bottomOffset As Int = 0
	Dim appBarHeight As Int = mTheme.AppBarHeight
	Dim bottomNavigationHeight As Int = mTheme.BottomNavigationHeight
	Dim fabSize As Int = mTheme.FabSize
	Dim fabSpace As Int = fabSize + 24dip ' Breathing room below the FAB
	If mBottomNavigationBar <> Null Then bottomOffset = bottomNavigationHeight
    
	' Render the app bar first.
	If mAppBar <> Null Then
		mBridge.SetParent(mAppBar, mBaseView)
		mBridge.SetPosition(mAppBar, mInsetLeft, mInsetTop)
		mBridge.SetSize(mAppBar, Max(0, mWidth - mInsetLeft - mInsetRight), appBarHeight)
		mBridge.Render(mAppBar)
		topOffset = appBarHeight + mInsetTop ' The body starts below the app bar + status bar
	End If
    
	' Reserve bottom space when one or more floating action buttons are present.
	Dim hasFab As Boolean = (mFabLeft <> Null Or mFabRight <> Null)
	If hasFab Then
		bottomOffset = bottomOffset + fabSpace
	End If
    
	' Render the body using the remaining height.
	If mBody <> Null Then
		Dim bodyHeight As Int = mHeight - topOffset - bottomOffset - mInsetBottom
		If bodyHeight < 0 Then bodyHeight = 0
        
		mBridge.SetParent(mBody, mBaseView)
		mBridge.SetPosition(mBody, mInsetLeft, topOffset)
		mBridge.SetSize(mBody, Max(0, mWidth - mInsetLeft - mInsetRight), bodyHeight)
		mBridge.Render(mBody)
	End If
    
	' Render the floating action buttons above the body layer.
	If mFabRight <> Null Then
		mBridge.SetParent(mFabRight, mBaseView)
		mBridge.SetPosition(mFabRight, mWidth - fabSize - 16dip - mInsetRight, mHeight - fabSize - 16dip - mInsetBottom - IfBottomBarOffset(mBottomNavigationBar, bottomNavigationHeight))
		mBridge.SetSize(mFabRight, fabSize, fabSize)
		mBridge.Render(mFabRight)
	End If
    
	If mFabLeft <> Null Then
		mBridge.SetParent(mFabLeft, mBaseView)
		mBridge.SetPosition(mFabLeft, mInsetLeft + 16dip, mHeight - fabSize - 16dip - mInsetBottom - IfBottomBarOffset(mBottomNavigationBar, bottomNavigationHeight))
		mBridge.SetSize(mFabLeft, fabSize, fabSize)
		mBridge.Render(mFabLeft)
	End If

	If mBottomNavigationBar <> Null Then
		mBridge.SetParent(mBottomNavigationBar, mBaseView)
		mBridge.SetPosition(mBottomNavigationBar, mInsetLeft, mHeight - mInsetBottom - bottomNavigationHeight)
		mBridge.SetSize(mBottomNavigationBar, Max(0, mWidth - mInsetLeft - mInsetRight), bottomNavigationHeight)
		mBridge.Render(mBottomNavigationBar)
	End If
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	Return mBridge.IsWidgetProtocol(Widget)
End Sub

Private Sub PrepareForStructureChange As Boolean
	If mBaseView = Null Or mMounted = False Then Return False
	If mBaseView.IsInitialized = False Then
		mBaseView = Null
		mMounted = False
		Return False
	End If
	UnmountChildren
	mBaseView.RemoveViewFromParent
	mBaseView = Null
	mMounted = False
	Return True
End Sub

Private Sub UnmountChildren
	If mAppBar <> Null Then mBridge.Unmount(mAppBar)
	If mBody <> Null Then mBridge.Unmount(mBody)
	If mFabLeft <> Null Then mBridge.Unmount(mFabLeft)
	If mFabRight <> Null Then mBridge.Unmount(mFabRight)
	If mBottomNavigationBar <> Null Then mBridge.Unmount(mBottomNavigationBar)
End Sub

Private Sub IfBottomBarOffset(Bar As Object, Height As Int) As Int
	If Bar <> Null Then Return Height
	Return 0
End Sub

Public Sub Detach
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then
			If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		End If
	End If
	DetachChild(mAppBar)
	DetachChild(mBody)
	DetachChild(mFabLeft)
	DetachChild(mFabRight)
	DetachChild(mBottomNavigationBar)
	mParent = Null
	mMounted = False
End Sub

Private Sub DetachChild(Child As Object)
	If Child <> Null Then mBridge.Detach(Child)
End Sub

Public Sub Unmount
	UnmountChildren
	If mBaseView <> Null And mMounted Then
		If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
	End If
	mBaseView = Null
	mMounted = False
	mParent = Null
End Sub

' Natural measurement used by parent layout containers.
' Scaffold fills all available space as the root layout.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	' An empty list represents a flexible size.
	Dim flexibleSize As List
	flexibleSize.Initialize
	Return flexibleSize
End Sub

' Re-measures the system bars and re-renders only when an inset changed.
' Safe-area protection is automatic: Render already measures, this is for
' explicit re-checks (rotation, IME, multi-window).
Public Sub RefreshInsets
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return
	Dim prevLeft, prevTop, prevRight, prevBottom As Int
	prevLeft = mInsetLeft
	prevTop = mInsetTop
	prevRight = mInsetRight
	prevBottom = mInsetBottom
	MeasureInsets
	If prevLeft <> mInsetLeft Or prevTop <> mInsetTop Or prevRight <> mInsetRight Or prevBottom <> mInsetBottom Then
		Render
	End If
End Sub

Private Sub MeasureInsets
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return
	Dim safe As List = mBridge.GetSafeBounds(mParent, mLeft, mTop, mWidth, mHeight)
	If safe.Size = 4 Then
		mInsetLeft = Max(0, safe.Get(0) - mLeft)
		mInsetTop = Max(0, safe.Get(1) - mTop)
		mInsetRight = Max(0, mLeft + mWidth - (safe.Get(0) + safe.Get(2)))
		mInsetBottom = Max(0, mTop + mHeight - (safe.Get(1) + safe.Get(3)))
	End If
End Sub
