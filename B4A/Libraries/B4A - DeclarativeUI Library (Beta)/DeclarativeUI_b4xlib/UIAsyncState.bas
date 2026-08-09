B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private mStatus As String
	Private mValue As Object
	Private mErrorMessage As String
	Private mListeners As List
	Private mIsNotifying As Boolean
	Private mPendingNotification As Boolean
	Private xui As XUI
End Sub

' Creates an observable async state in the idle state.
' This class models the operation lifecycle; it does not execute HTTP or other work.
Public Sub Initialize As UIAsyncState
	mStatus = "idle"
	mValue = Null
	mErrorMessage = ""
	mListeners.Initialize
	mIsNotifying = False
	mPendingNotification = False
	Return Me
End Sub

' Moves the operation to idle and clears its value and error.
Public Sub SetIdle As UIAsyncState
	SetSnapshot("idle", Null, "")
	Return Me
End Sub

' Marks the operation as running and clears the previous result.
Public Sub SetLoading As UIAsyncState
	SetSnapshot("loading", Null, "")
	Return Me
End Sub

' Stores a successful result and notifies listeners.
Public Sub SetSuccess(Value As Object) As UIAsyncState
	SetSnapshot("success", Value, "")
	Return Me
End Sub

' Stores a failure message and notifies listeners.
Public Sub SetError(Message As String) As UIAsyncState
	SetSnapshot("error", Null, Message)
	Return Me
End Sub

' Returns the operation to idle. This is an alias for SetIdle for reset flows.
Public Sub Reset As UIAsyncState
	SetIdle
	Return Me
End Sub

' Returns one of: idle, loading, success or error.
Public Sub GetStatus As String
	Return mStatus
End Sub

' Returns the successful result, or Null when no result is available.
Public Sub GetValue As Object
	Return mValue
End Sub

' Returns the current error message, or an empty string when there is no error.
Public Sub GetErrorMessage As String
	Return mErrorMessage
End Sub

Public Sub IsIdle As Boolean
	Return mStatus = "idle"
End Sub

Public Sub IsLoading As Boolean
	Return mStatus = "loading"
End Sub

Public Sub IsSuccess As Boolean
	Return mStatus = "success"
End Sub

Public Sub IsError As Boolean
	Return mStatus = "error"
End Sub

' Subscribes Target.EventName to async state changes.
' The callback signature is: Sub EventName(State As UIAsyncState)
Public Sub Subscribe(Target As Object, EventName As String) As UIAsyncState
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
Public Sub Unsubscribe(Target As Object, EventName As String) As UIAsyncState
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
Public Sub UnsubscribeTarget(Target As Object) As UIAsyncState
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

' Removes all subscriptions.
Public Sub ClearListeners
	If mListeners.IsInitialized Then mListeners.Clear
End Sub

Private Sub SetSnapshot(NewStatus As String, NewValue As Object, NewErrorMessage As String)
	Dim sameValue As Boolean = False
	If mValue = Null Then
		sameValue = (NewValue = Null)
	Else If NewValue <> Null Then
		sameValue = (mValue = NewValue)
	End If
	If mStatus = NewStatus And sameValue And mErrorMessage = NewErrorMessage Then Return
	mStatus = NewStatus
	mValue = NewValue
	mErrorMessage = NewErrorMessage
	If mIsNotifying Then
		mPendingNotification = True
		Return
	End If
	NotifyListeners
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
	' Permit one follow-up transition from a callback, matching UIState behavior.
	For pass = 1 To 2
		mPendingNotification = False
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