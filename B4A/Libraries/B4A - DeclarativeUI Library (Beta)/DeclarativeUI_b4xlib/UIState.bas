B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private mValue As Object
	Private mListeners As List
	Private mIsNotifying As Boolean
	Private mPendingNotification As Boolean
	Private xui As XUI
End Sub

' Creates an observable state holder.
Public Sub Initialize(InitialValue As Object) As UIState
	mValue = NormalizeValue(InitialValue)
	mListeners.Initialize
	mIsNotifying = False
	mPendingNotification = False
	Return Me
End Sub

' Returns the current state value.
Public Sub GetState As Object
	Return mValue
End Sub

' Stores numeric values as Double so consumers always see a consistent type.
' B4X promotes Object arithmetic to Double, which used to leave states holding
' a mix of Int and Double values that rendered as "0" and "1.0".
Private Sub NormalizeValue(Value As Object) As Object
	If Value Is Int Or Value Is Long Or Value Is Float Or Value Is Double Then
		Return Value + 0.0
	End If
	Return Value
End Sub

' Replaces the current value and notifies subscribed listeners.
' A listener receives this UIState instance as its only argument.
Public Sub SetState(NewValue As Object)
	Dim normalized As Object = NormalizeValue(NewValue)
	If mValue = Null Then
		If normalized = Null Then Return
	Else If normalized <> Null Then
		If mValue = normalized Then Return
	End If
	mValue = normalized
	' Defer one additional notification pass when a callback changes this state.
	If mIsNotifying Then
		mPendingNotification = True
		Return
	End If
	NotifyListeners
End Sub

' Subscribes Target.EventName to state changes.
' The callback signature is: Sub EventName(State As UIState)
Public Sub Subscribe(Target As Object, EventName As String) As UIState
	If Target = Null Or EventName.Trim = "" Then Return Me
	If mListeners.IsInitialized = False Then mListeners.Initialize
	If HasListener(Target, EventName) = False Then
		Dim listener As Map
		listener.Initialize
		listener.Put("Target", Target)
		listener.Put("EventName", EventName)
		mListeners.Add(listener)
	End If
	Return Me
End Sub

' Removes one subscription. Safe to call more than once.
Public Sub Unsubscribe(Target As Object, EventName As String) As UIState
	If mListeners.IsInitialized = False Then Return Me
	For i = mListeners.Size - 1 To 0 Step -1
		Dim listener As Map = mListeners.Get(i)
		Dim listenerTarget As Object = listener.Get("Target")
		Dim listenerEventName As String = listener.Get("EventName")
		Dim sameTarget As Boolean = False
		If listenerTarget = Null Then
			sameTarget = (Target = Null)
		Else If Target <> Null Then
			sameTarget = (listenerTarget = Target)
		End If
		If sameTarget And listenerEventName = EventName Then
			mListeners.RemoveAt(i)
		End If
	Next
	Return Me
End Sub

' Removes every subscription owned by Target.
' This is useful for widget bindings that need to be replaced or disposed.
Public Sub UnsubscribeTarget(Target As Object) As UIState
	If Target = Null Or mListeners.IsInitialized = False Then Return Me
	For i = mListeners.Size - 1 To 0 Step -1
		Dim listener As Map = mListeners.Get(i)
		Dim listenerTarget As Object = listener.Get("Target")
		If listenerTarget <> Null Then
			If listenerTarget = Target Then mListeners.RemoveAt(i)
		End If
	Next
	Return Me
End Sub

' Removes all subscriptions. Call this when the owner of a state is destroyed.
Public Sub ClearListeners
	If mListeners.IsInitialized Then mListeners.Clear
End Sub

Private Sub HasListener(Target As Object, EventName As String) As Boolean
	For Each item As Map In mListeners
		Dim listenerTarget As Object = item.Get("Target")
		Dim listenerEventName As String = item.Get("EventName")
		Dim sameTarget As Boolean = False
		If listenerTarget = Null Then
			sameTarget = (Target = Null)
		Else If Target <> Null Then
			sameTarget = (listenerTarget = Target)
		End If
		If sameTarget And listenerEventName = EventName Then Return True
	Next
	Return False
End Sub

Private Sub NotifyListeners
	If mIsNotifying Then Return
	mIsNotifying = True
	' Use a bounded second pass for a state change made from a callback.
	For pass = 1 To 2
		mPendingNotification = False
		' Notify a snapshot so a callback may subscribe or unsubscribe safely.
		Dim snapshot As List
		snapshot.Initialize
		For Each item As Map In mListeners
			snapshot.Add(item)
		Next
		For Each item As Map In snapshot
			If mListeners.IndexOf(item) >= 0 Then
				Dim target As Object = item.Get("Target")
				Dim eventName As String = item.Get("EventName")
				If target <> Null Then
					If eventName.Trim <> "" Then
						If SubExists(target, eventName) Then CallSub2(target, eventName, Me)
					End If
				End If
			End If
		Next
		If mPendingNotification = False Then Exit
	Next
	mIsNotifying = False
	mPendingNotification = False
End Sub