B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private mPendingCalls As List
    Private mScheduled As Boolean
End Sub

' Coalesces callback requests until the next UI cycle.
' The latest argument is retained for each target/event pair.
Public Sub Initialize As UIRebuildScheduler
    mPendingCalls.Initialize
    mScheduled = False
    Return Me
End Sub

' Queues Sub EventName(Argument As Object) once per target/event pair.
' A later request updates the argument instead of adding another callback.
Public Sub Schedule(Target As Object, EventName As String, Argument As Object) As UIRebuildScheduler
    If Target = Null Then Return Me
    If EventName.Trim = "" Then Return Me
    If SubExists(Target, EventName) = False Then Return Me
    If mPendingCalls.IsInitialized = False Then mPendingCalls.Initialize

    For Each call As Map In mPendingCalls
        Dim queuedTarget As Object = call.Get("Target")
        Dim queuedEvent As String = call.Get("EventName")
        If queuedEvent = EventName Then
            If queuedTarget = Target Then
                call.Put("Argument", Argument)
                StartIfNeeded
                Return Me
            End If
        End If
    Next

    Dim queued As Map
    queued.Initialize
    queued.Put("Target", Target)
    queued.Put("EventName", EventName)
    queued.Put("Argument", Argument)
    queued.Put("Cancelled", False)
    mPendingCalls.Add(queued)
    StartIfNeeded
    Return Me
End Sub

Private Sub StartIfNeeded
    If mScheduled Then Return
    mScheduled = True
    RunScheduled
End Sub

Private Sub RunScheduled As ResumableSub
    Sleep(0)
    If mPendingCalls.IsInitialized = False Then
        mScheduled = False
        Return Null
    End If

    ' Process the live queue. This lets Unsubscribe/Cancel remove callbacks
    ' before their turn, including callbacks queued after Sleep(0).
    Do While mPendingCalls.Size > 0
        Dim call As Map = mPendingCalls.Get(0)
        mPendingCalls.RemoveAt(0)
        Dim cancelled As Boolean = call.Get("Cancelled")
        Dim target As Object = call.Get("Target")
        Dim eventName As String = call.Get("EventName")
        If cancelled = False And target <> Null Then
            If eventName.Trim <> "" Then
                If SubExists(target, eventName) Then CallSub2(target, eventName, call.Get("Argument"))
            End If
        End If
    Loop
    mScheduled = False
    If mPendingCalls.Size > 0 Then StartIfNeeded
    Return Null
End Sub

' Cancels queued callbacks for one target. An empty EventName cancels all
' callbacks owned by Target.
Public Sub CancelTarget(Target As Object, EventName As String) As UIRebuildScheduler
    If mPendingCalls.IsInitialized = False Then Return Me
    For i = mPendingCalls.Size - 1 To 0 Step -1
        Dim call As Map = mPendingCalls.Get(i)
        Dim queuedTarget As Object = call.Get("Target")
        Dim queuedEvent As String = call.Get("EventName")
        If queuedTarget = Target Then
            If EventName = "" Or queuedEvent = EventName Then
                call.Put("Cancelled", True)
                mPendingCalls.RemoveAt(i)
            End If
        End If
    Next
    Return Me
End Sub

' Drops callbacks that have not reached the next UI cycle.
Public Sub Cancel
    If mPendingCalls.IsInitialized Then
        For Each queued As Map In mPendingCalls
            queued.Put("Cancelled", True)
        Next
        mPendingCalls.Clear
    End If
End Sub