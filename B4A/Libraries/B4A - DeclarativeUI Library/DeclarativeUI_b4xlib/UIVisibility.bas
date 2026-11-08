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
	Private mVisible As Boolean
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mVisibilityState As UIState
	Private mVisibilityTarget As Object
	Private mVisibilityEventName As String
	Private mLeft, mTop, mWidth, mHeight As Int
End Sub

' Creates a visible wrapper with no child.
Public Sub Initialize As UIVisibility
	mBridge.Initialize
	' Re-initialization is safe when the same declarative instance is reused
	' by a screen builder after navigation, theme or state updates.
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then Unmount
	End If
	If mVisibilityState <> Null Then
		If mVisibilityState.IsInitialized Then mVisibilityState.Unsubscribe(Me, "VisibilityState_Changed")
	End If
	mChild = Null
	mVisible = True
	mVisibilityState = Null
	mVisibilityTarget = Null
	mVisibilityEventName = ""
	Return Me
End Sub

' Controls whether the child participates in measurement and rendering.
' The parent container must be rendered after changing visibility so it can reflow siblings.
' An explicit value replaces any previous state binding.
Public Sub Visible(Value As Boolean) As UIVisibility
	UnbindVisible
	mVisible = Value
	Return Me
End Sub

' Binds participation in layout to an observable UIState.
' The state value must be Boolean. The host should render the affected parent
' from OnVisibilityChanged so siblings are measured again.
Public Sub BindVisible(State As UIState) As UIVisibility
	UnbindVisible
	mVisibilityState = State
	If mVisibilityState <> Null Then
		If mVisibilityState.IsInitialized Then
			mVisible = ReadBoolean(mVisibilityState.GetState)
			mVisibilityState.Subscribe(Me, "VisibilityState_Changed")
		End If
	End If
	Return Me
End Sub

' Removes the visibility binding while preserving the current value.
Public Sub UnbindVisible As UIVisibility
	If mVisibilityState <> Null Then
		If mVisibilityState.IsInitialized Then mVisibilityState.Unsubscribe(Me, "VisibilityState_Changed")
	End If
	mVisibilityState = Null
	Return Me
End Sub

' Registers a callback invoked after a bound visibility value changes.
' The callback signature is: Sub EventName(Visibility As UIVisibility)
Public Sub OnVisibilityChanged(Target As Object, EventName As String) As UIVisibility
	mVisibilityTarget = Target
	mVisibilityEventName = EventName
	Return Me
End Sub

Private Sub VisibilityState_Changed(State As UIState)
	If State = Null Then Return
	If State.IsInitialized = False Then Return
	mVisible = ReadBoolean(State.GetState)
	' An unmounted screen keeps its declarative binding, but must not ask the
	' host to render an obsolete parent tree.
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return
	If mVisibilityTarget = Null Then Return
	If mVisibilityEventName.Trim = "" Then Return
	If SubExists(mVisibilityTarget, mVisibilityEventName) Then
		CallSub2(mVisibilityTarget, mVisibilityEventName, Me)
	End If
End Sub

' Replaces the single child managed by this wrapper.
Public Sub Child(Widget As Object) As UIVisibility
	If IsWidgetProtocol(Widget) = False Then Return Me
	If mChild <> Null Then
		If mChild = Widget Then Return Me
	End If
	If mChild <> Null Then
		mBridge.Unmount(mChild)
	End If
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveAllViews
	End If
	mChild = Widget
	Return Me
End Sub

' Propagates the active theme to the wrapped child.
Public Sub ApplyTheme(Theme As UITheme) As UIVisibility
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	If mChild <> Null And SubExists(mChild, "ApplyTheme") Then CallSub2(mChild, "ApplyTheme", Theme)
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
	If mVisibilityState <> Null Then
		If mVisibilityState.IsInitialized Then
			mVisible = ReadBoolean(mVisibilityState.GetState)
			mVisibilityState.Subscribe(Me, "VisibilityState_Changed")
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
		mBaseView.Color = Colors.Transparent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	If mBaseView.Parent <> mParent Then
		If mBaseView.Parent <> Null Then mBaseView.RemoveViewFromParent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If

	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	If mVisible = False Then
		If mChild <> Null Then mBridge.Detach(mChild)
		mBaseView.RemoveAllViews
		mBaseView.SetLayoutAnimated(0, mLeft, mTop, 0, 0)
		Return
	End If

	If mChild = Null Then
		mBaseView.RemoveAllViews
		Return
	End If

	mBridge.SetParent(mChild, mBaseView)
	mBridge.SetPosition(mChild, 0, 0)
	mBridge.SetSize(mChild, mWidth, mHeight)
	mBridge.Render(mChild)
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
	If mVisibilityState <> Null Then
		If mVisibilityState.IsInitialized Then mVisibilityState.Unsubscribe(Me, "VisibilityState_Changed")
	End If
	' Unmount is terminal for this wrapper: release the child and its binding.
	If mChild <> Null Then mBridge.Unmount(mChild)
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveAllViews
	End If
	mBaseView = Null
	mParent = Null
End Sub

Private Sub IsWidgetProtocol(Widget As Object) As Boolean
	Return mBridge.IsWidgetProtocol(Widget)
End Sub

' Internal layout hook used by Column and Row to avoid spacing around hidden children.
Public Sub ParticipatesInLayout As Boolean
	Return mVisible
End Sub

' Hidden children occupy no layout space. Visible children delegate natural measurement.
Private Sub ReadBoolean(Value As Object) As Boolean
	If Value = Null Then Return False
	Return ("" & Value).Trim.ToLowerCase = "true"
End Sub

Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	If mVisible = False Or mChild = Null Then
		result.Add(0)
		result.Add(0)
		Return result
	End If
	Dim childSize As List = mBridge.GetContentSize(mChild, MaxWidth, MaxHeight)
	If mBridge.LastCallSucceeded = False Then
		result.Add(0)
		result.Add(0)
		Return result
	End If
	If childSize <> Null Then
		If childSize.IsInitialized Then
			If childSize.Size >= 2 Then Return childSize
		End If
	End If
	result.Add(0)
	result.Add(0)
	Return result
End Sub