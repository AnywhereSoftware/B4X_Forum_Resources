B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private mView As B4XView
	Private mDuration As Int
	Private mTargetLeft, mTargetTop, mTargetWidth, mTargetHeight As Int
	Private mHasPosition As Boolean
	Private mHasSize As Boolean
	Private mCallbackTarget As Object
	Private mCallbackName As String
	Private mRunId As Int
	Private mRunning As Boolean
End Sub

' Creates a reusable, one-shot layout animation descriptor.
Public Sub Initialize As UIAnimation
	Cancel
	mView = Null
	mDuration = 240
	mTargetLeft = 0
	mTargetTop = 0
	mTargetWidth = 0
	mTargetHeight = 0
	mHasPosition = False
	mHasSize = False
	mCallbackTarget = Null
	mCallbackName = ""
	Return Me
End Sub

' Selects the native view whose bounds will be animated.
Public Sub TargetView(View As B4XView) As UIAnimation
	mView = View
	Return Me
End Sub

' Sets the duration in milliseconds. Negative values become zero.
Public Sub Duration(Milliseconds As Int) As UIAnimation
	mDuration = Max(0, Milliseconds)
	Return Me
End Sub

' Sets the destination position while preserving the current size.
Public Sub MoveTo(Left As Int, Top As Int) As UIAnimation
	mTargetLeft = Left
	mTargetTop = Top
	mHasPosition = True
	Return Me
End Sub

' Sets the destination size while preserving the current position.
Public Sub SizeTo(Width As Int, Height As Int) As UIAnimation
	mTargetWidth = Max(0, Width)
	mTargetHeight = Max(0, Height)
	mHasSize = True
	Return Me
End Sub

' Sets both destination position and size.
Public Sub MoveAndResize(Left As Int, Top As Int, Width As Int, Height As Int) As UIAnimation
	MoveTo(Left, Top)
	SizeTo(Width, Height)
	Return Me
End Sub

' Registers Sub EventName with no parameters for successful completion.
Public Sub OnCompleted(Target As Object, EventName As String) As UIAnimation
	mCallbackTarget = Target
	mCallbackName = EventName
	Return Me
End Sub

' Starts or restarts the animation. A new Start invalidates the previous completion callback.
Public Sub Start As UIAnimation
	If mView = Null Then Return Me
	If mView.IsInitialized = False Then Return Me
	If mHasPosition = False And mHasSize = False Then Return Me
	If mHasPosition = False Then
		mTargetLeft = mView.Left
		mTargetTop = mView.Top
	End If
	If mHasSize = False Then
		mTargetWidth = mView.Width
		mTargetHeight = mView.Height
	End If
	mRunId = mRunId + 1
	mRunning = True
	Dim currentRun As Int = mRunId
	mView.SetLayoutAnimated(mDuration, mTargetLeft, mTargetTop, mTargetWidth, mTargetHeight)
	WaitForCompletion(currentRun)
	Return Me
End Sub

' Cancels the native transition at its current bounds and suppresses completion.
Public Sub Cancel As UIAnimation
	mRunId = mRunId + 1
	If mView <> Null Then
		If mView.IsInitialized Then
			mView.SetLayoutAnimated(0, mView.Left, mView.Top, mView.Width, mView.Height)
		End If
	End If
	mRunning = False
	Return Me
End Sub

Public Sub IsRunning As Boolean
	Return mRunning
End Sub

Private Sub WaitForCompletion(RunId As Int)
	' Sleep(0) keeps zero-duration completion on the same asynchronous path.
	Sleep(mDuration)
	If RunId <> mRunId Or mRunning = False Then Return
	mRunning = False
	If mCallbackTarget = Null Then Return
	If mCallbackName.Trim = "" Then Return
	If SubExists(mCallbackTarget, mCallbackName) Then CallSub(mCallbackTarget, mCallbackName)
End Sub