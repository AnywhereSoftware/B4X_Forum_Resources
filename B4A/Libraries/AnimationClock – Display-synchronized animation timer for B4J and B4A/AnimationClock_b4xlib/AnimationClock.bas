B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Event: Tick(ElapsedTime As Long)
Sub Class_Globals
	Private mModule As Object
	Private mEventName As String
	Private mLastFrameTime As Long
	Private mRunning As Boolean
	#if b4j
	Private joNative As JavaObject
	#else if b4a
	Private Choreo As JavaObject
	Private FrameCallback As Object
	#End If
End Sub

' AnimationClock - display-synchronized animation timer for B4J and B4A.
' Raises a Tick event once per display frame, providing the elapsed time since
' the previous frame in microseconds (µs).
'
' On B4J it uses JavaFX AnimationTimer; on B4A it uses Android Choreographer.
' Both mechanisms are synchronized to the display refresh rate (typically 60 Hz),
' making this class suitable for smooth animations and game loops.
'
' The Tick event is always raised on the UI thread, so it is safe to update
' Views directly inside the event handler.
'
' Usage example:
'
'   Sub Class_Globals
'       Private Clock As AnimationClock
'   End Sub
'
'   Private Sub B4XPage_Created(Root1 As B4XView)
'       Clock.Initialize("Clock", Me)
'       Clock.Start
'   End Sub
'
'   Sub Clock_Tick(ElapsedTime As Long)
'       ' ElapsedTime is in microseconds (µs).
'       ' At 60 Hz a typical value is around 16667 (= ~16.7 ms).
'       MoveSprite(ElapsedTime)
'   End Sub
'
'   Private Sub StopAnimation
'       If Clock.Running Then Clock.Stop
'   End Sub
Public Sub Initialize(EventName As String, Module As Object)
	mModule = Module
	mEventName = EventName
	#if b4j
	joNative = Me
	joNative.RunMethod("init", Null)
	#else b4a
	Choreo.InitializeStatic("android.view.Choreographer")
	Choreo = Choreo.RunMethodJO("getInstance", Null)
    
	' CreateEventFromUI ensures the callback runs on the UI thread.
	' This makes it safe to update Views directly in the Tick handler.
	FrameCallback = Choreo.CreateEventFromUI( _
        "android.view.Choreographer.FrameCallback", _
        "Frame", _
        Null)
	#End If
End Sub

' Starts the animation clock. The first Tick event is raised on the second frame
' so that ElapsedTime reflects a real inter-frame interval, not zero.
Public Sub Start
	mLastFrameTime = 0
	mRunning = True
	#if b4j
	joNative.RunMethod("startTimer", Null)
	#else if b4a
	Choreo.RunMethod("postFrameCallback", Array(FrameCallback))
	#end if
End Sub

' Stops the animation clock. No further Tick events are raised until Start is called again.
Public Sub Stop
	#if b4j
	joNative.RunMethod("stopTimer", Null)
	#End If
	mRunning = False
End Sub

' Returns True if the clock is currently running.
' Use this to check the clock state before calling Start or Stop.
Public Sub getRunning As Boolean
	Return mRunning
End Sub

#if b4j
' Called from the Java AnimationTimer on every display frame.
' FrameTimeNanos - the current frame timestamp in nanoseconds (from System.nanoTime).
' Raises the user-visible Tick event with ElapsedTime in microseconds (ns / 1000).
private Sub Tick(FrameTimeNanos As Long) 'ignore
	If mLastFrameTime = 0 Then
		mLastFrameTime = FrameTimeNanos
	Else
		Dim dt As Long = (FrameTimeNanos-mLastFrameTime)/1000
		CallSub2(mModule, mEventName & "_Tick",dt )
		mLastFrameTime = FrameTimeNanos
	End If
End Sub
#else if b4a
' Called by Android Choreographer on every display frame (B4A only).
' MethodName - callback method name (unused, required by the interface).
' Args(0) - the current frame timestamp in nanoseconds (from Choreographer).
' Raises the user-visible Tick event with ElapsedTime in microseconds (ns / 1000),
' then re-registers the callback to keep the loop running while mRunning is True.
' Returns: Null (required by the FrameCallback interface).
Private Sub Frame_Event(MethodName As String, Args() As Object) As Object
	Dim FrameTimeNanos As Long = Args(0)
    
	If mLastFrameTime = 0 Then
		mLastFrameTime = FrameTimeNanos
	Else
		Dim dt As Long = (FrameTimeNanos-mLastFrameTime)/1000
		CallSub2(mModule, mEventName & "_Tick",dt )
		mLastFrameTime = FrameTimeNanos
	End If
    
	' Keep the loop running by scheduling the next frame callback.
	If mRunning Then
		Choreo.RunMethod("postFrameCallback", Array(FrameCallback))
	End If
    
	Return Null
End Sub
#end if

#if b4j
#if RELEASE
#If Java 
import javafx.animation.AnimationTimer;

private AnimationTimer timer;

public void init() {
    timer = new AnimationTimer() {
        @Override
        public void handle(long now) {
            try {
                _tick(now);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    };
}

public void startTimer() {
    timer.start();
}

public void stopTimer() {
    if (timer != null) timer.stop();
}
#End If
#end if

#if DEBUG
#if java
import javafx.animation.AnimationTimer;

private AnimationTimer timer;

public void init() {
    final animationclock outer = this;
    timer = new AnimationTimer() {
        @Override
        public void handle(long now) {
            try {
                _tick(outer, now);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    };
}

public void startTimer() {
    timer.start();
}

public void stopTimer() {
    if (timer != null) timer.stop();
}
#End If
#end if
#end if