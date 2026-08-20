B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mScreens As Map
	Private mHistory As List
	Private mCurrentScreen As String
	Private mParent As B4XView
	Private mHost As B4XView
	Private mMountedScreen As Object
	Private mIsMounted As Boolean
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

Public Sub Initialize As UINavigator
	mScreens.Initialize
    mHistory.Initialize
    mCurrentScreen = ""
    mMountedScreen = Null
    mIsMounted = False
    Return Me
End Sub

' Applies the active theme to all registered virtual screens.
' Screens that do not expose ApplyTheme are left untouched.
Public Sub ApplyTheme(Theme As UITheme) As UINavigator
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	For Each key As String In mScreens.Keys
		Dim screen As Object = mScreens.Get(key)
		If screen <> Null And SubExists(screen, "ApplyTheme") Then CallSub2(screen, "ApplyTheme", Theme)
	Next
	Return Me
End Sub

Public Sub AddScreen(Name As String, Screen As Object) As UINavigator
	If Name.Trim = "" Or IsWidgetProtocol(Screen) = False Then Return Me
	mScreens.Put(Name, Screen)
	If mCurrentScreen = "" Then
		mCurrentScreen = Name
		mHistory.Add(Name)
	End If
	If mHost <> Null Then
		If mHost.IsInitialized And Name = mCurrentScreen Then Render
	End If
	Return Me
End Sub

Public Sub NavigateTo(Name As String)
	If mScreens.ContainsKey(Name) = False Then
		Return
	End If
	If mHistory.Size = 0 And mCurrentScreen <> "" Then mHistory.Add(mCurrentScreen)
	If mCurrentScreen = Name Then
		If mIsMounted Then Return
		If mHost <> Null Then
			If mHost.IsInitialized Then Render
		End If
		Return
	End If
	mHistory.Add(Name)
	mCurrentScreen = Name
	If mHost <> Null Then
		If mHost.IsInitialized Then Render
	End If
End Sub

' Returns True when a previously visited screen can be restored.
Public Sub CanGoBack As Boolean
	Return mHistory.Size > 1
End Sub

' Pops the current screen and renders the previous one when mounted.
Public Sub GoBack As Boolean
	If CanGoBack = False Then Return False
	mHistory.RemoveAt(mHistory.Size - 1)
	mCurrentScreen = mHistory.Get(mHistory.Size - 1)
	If mHost <> Null Then
		If mHost.IsInitialized Then Render
	End If
	Return True
End Sub

Public Sub SetParent(Parent As B4XView)
	If mHost <> Null Then
		If mHost.IsInitialized Then Unmount
	End If
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

    Dim contentLeft As Int = mLeft
    Dim contentTop As Int = mTop
    Dim contentWidth As Int = mWidth
    Dim contentHeight As Int = mHeight

	Dim needsCreate As Boolean = False
	If mHost = Null Then
		needsCreate = True
	Else If mHost.IsInitialized = False Then
		needsCreate = True
	End If
	If needsCreate Then
		Dim pnl As Panel
		pnl.Initialize("")
		mHost = pnl
		mHost.Color = Colors.Transparent
		mParent.AddView(mHost, contentLeft, contentTop, contentWidth, contentHeight)
	Else
		mHost.SetLayoutAnimated(0, contentLeft, contentTop, contentWidth, contentHeight)
	End If

	Dim Screen As Object = mScreens.Get(mCurrentScreen)
	If mMountedScreen <> Null Then
		If Screen = Null Or Screen <> mMountedScreen Then
			' A route in history may be restored, so detach it instead of destroying it.
			Dim bridge As UIWidgetBridge
			bridge.Initialize
			bridge.Detach(mMountedScreen)
			mHost.RemoveAllViews
			mMountedScreen = Null
		End If
	End If
	' A stable route keeps its existing widget tree. This is the main lifecycle
	' optimization: resize/re-render updates the mounted screen in place instead
	' of unmounting every native descendant first.
	If Screen <> Null And mMountedScreen <> Null Then
		If Screen = mMountedScreen Then
			Dim stableBridge As UIWidgetBridge
			stableBridge.Initialize
			stableBridge.SetParent(Screen, mHost)
			stableBridge.SetPosition(Screen, 0, 0)
			stableBridge.SetSize(Screen, contentWidth, contentHeight)
			stableBridge.Render(Screen)
			mIsMounted = mHost.IsInitialized
			Return
		End If
	End If
	If Screen <> Null Then
		Dim screenBridge As UIWidgetBridge
		screenBridge.Initialize
		screenBridge.SetParent(Screen, mHost)
		screenBridge.SetPosition(Screen, 0, 0)
		screenBridge.SetSize(Screen, contentWidth, contentHeight)
		screenBridge.Render(Screen)
		mMountedScreen = Screen
	End If
	mIsMounted = mHost.IsInitialized
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	If Widget = Null Then Return False
	Return SubExists(Widget, "SetParent") And SubExists(Widget, "SetPosition") _
		And SubExists(Widget, "SetSize") And SubExists(Widget, "Render") _
		And SubExists(Widget, "GetContentSize")
End Sub

' Safe-area protection now lives in UIScaffold. Kept for compatibility:
' a re-render of the current route is harmless and lets callers refresh.
' Safe-area protection now lives in UIScaffold. Kept for compatibility:
' a re-render of the current route is harmless and lets callers refresh.
Public Sub RefreshInsets
	If mIsMounted Then Render
End Sub



Public Sub Unmount
	If mMountedScreen <> Null Then
		Dim terminalBridge As UIWidgetBridge
		terminalBridge.Initialize
		terminalBridge.Unmount(mMountedScreen)
	End If
	If mHost <> Null Then
		If mHost.IsInitialized Then
			mHost.RemoveAllViews
			mHost.RemoveViewFromParent
		End If
	End If
	mHost = Null
	mMountedScreen = Null
	mParent = Null
	mIsMounted = False
End Sub

' Natural measurement used by parent layout containers.
' The navigator fills the available space, just like the scaffold.
Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	' An empty list represents a flexible size.
	Dim flexibleSize As List
	flexibleSize.Initialize
	Return flexibleSize
End Sub
