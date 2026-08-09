B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
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
End Sub

Public Sub Initialize As UIScaffold
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
		mMounted = True
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mBaseView.Color = mBackgroundColor
    
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
		CallSub2(mAppBar, "SetParent", mBaseView)
		CallSub3(mAppBar, "SetPosition", 0, 0)
		CallSub3(mAppBar, "SetSize", mWidth, appBarHeight)
		CallSub(mAppBar, "Render")
		topOffset = appBarHeight ' The body starts below the app bar
	End If
    
	' Reserve bottom space when one or more floating action buttons are present.
	Dim hasFab As Boolean = (mFabLeft <> Null Or mFabRight <> Null)
	If hasFab Then
		bottomOffset = bottomOffset + fabSpace
	End If
    
	' Render the body using the remaining height.
	If mBody <> Null Then
		Dim bodyHeight As Int = mHeight - topOffset - bottomOffset
		If bodyHeight < 0 Then bodyHeight = 0
        
		CallSub2(mBody, "SetParent", mBaseView)
		CallSub3(mBody, "SetPosition", 0, topOffset)
		CallSub3(mBody, "SetSize", mWidth, bodyHeight)
		CallSub(mBody, "Render")
	End If
    
	' Render the floating action buttons above the body layer.
	If mFabRight <> Null Then
		CallSub2(mFabRight, "SetParent", mBaseView)
		CallSub3(mFabRight, "SetPosition", mWidth - fabSize - 16dip, mHeight - fabSize - 16dip - IfBottomBarOffset(mBottomNavigationBar, bottomNavigationHeight))
		CallSub3(mFabRight, "SetSize", fabSize, fabSize)
		CallSub(mFabRight, "Render")
	End If
    
	If mFabLeft <> Null Then
		CallSub2(mFabLeft, "SetParent", mBaseView)
		CallSub3(mFabLeft, "SetPosition", 16dip, mHeight - fabSize - 16dip - IfBottomBarOffset(mBottomNavigationBar, bottomNavigationHeight))
		CallSub3(mFabLeft, "SetSize", fabSize, fabSize)
		CallSub(mFabLeft, "Render")
	End If

	If mBottomNavigationBar <> Null Then
		CallSub2(mBottomNavigationBar, "SetParent", mBaseView)
		CallSub3(mBottomNavigationBar, "SetPosition", 0, mHeight - bottomNavigationHeight)
		CallSub3(mBottomNavigationBar, "SetSize", mWidth, bottomNavigationHeight)
		CallSub(mBottomNavigationBar, "Render")
	End If
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	If Widget = Null Then Return False
	Return SubExists(Widget, "SetParent") And SubExists(Widget, "SetPosition") _
		And SubExists(Widget, "SetSize") And SubExists(Widget, "Render") _
		And SubExists(Widget, "GetContentSize")
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
	If mAppBar <> Null Then
		If SubExists(mAppBar, "Unmount") Then CallSub(mAppBar, "Unmount")
	End If
	If mBody <> Null Then
		If SubExists(mBody, "Unmount") Then CallSub(mBody, "Unmount")
	End If
	If mFabLeft <> Null Then
		If SubExists(mFabLeft, "Unmount") Then CallSub(mFabLeft, "Unmount")
	End If
	If mFabRight <> Null Then
		If SubExists(mFabRight, "Unmount") Then CallSub(mFabRight, "Unmount")
	End If
	If mBottomNavigationBar <> Null Then
		If SubExists(mBottomNavigationBar, "Unmount") Then CallSub(mBottomNavigationBar, "Unmount")
	End If
End Sub

Private Sub IfBottomBarOffset(Bar As Object, Height As Int) As Int
	If Bar <> Null Then Return Height
	Return 0
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