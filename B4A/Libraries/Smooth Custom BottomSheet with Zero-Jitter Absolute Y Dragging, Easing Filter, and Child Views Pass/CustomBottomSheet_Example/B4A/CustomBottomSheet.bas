B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
'======================================================
' Custom Advanced Multi-Position Bottom Sheet for B4XPages.
' Optimized for Android (B4A native touch lifecycles).
'
' Drag works from anywhere on the sheet (mSheet), not
' only from the handle.
'
' Features:
'   - Zero-Jitter Absolute Y dragging physics.
'   - 40% Easing Filter (Signal Smoothing).
'   - Child Views Input Pass-Through support.
'   - Drag works from anywhere on the sheet (mSheet).
'
' Public API:
'   Initialize(Root As B4XView, Owner As Object, EventName As String)
'   Build(SheetHeight, VisibleFractions())
'   OpenAt(Index)
'   Close
'   CurrentIndex
'	getContentPanel
'	getTop
'	getIsDragging
'	ProcessSharedTouch
'
' Owner callback:
'   Sub <EventName>_StateChanged(Index As Int)
'   Sub <EventName>_HidingKeyboard
'======================================================

Sub Class_Globals
	Private xui As XUI
	Private classIME As IME	'IME Lib
	
	Private mRoot As B4XView
	Private mOwner As Object        'B4XPage instance that will receive the callback
	Private mEventName As String

	Private mSheet As B4XView		'The main panel of the BottomSheet
	Private mHandle As B4XView
	Private mContent As B4XView

	' --- Movement States and Physics ---
	Private mPositionsY() As Int	' Array containing the anchor coordinates (Expanded, Collapsed...)
	Private mCurrentIndex As Int	' Current position index
	Private mInitialIndex As Int	' Save the original index before the drag operation
	Private mLastY As Float			' Store the last AbsoluteY To calculate the delta

	Private mAnimDurationMs As Int

	Private mDownY As Float			' Y-coordinate of the first touch
	Private mIsDragging As Boolean	' Flag indicating whether the user is dragging
	Private HiddenKeyboardNow	As Boolean = False	' Indicates whether the keyboard is currently hidden. Avoid redundant calls To the keyboard
	
	Private Const ACTION_DOWN As Int = 0
	Private Const ACTION_UP As Int = 1
	Private Const ACTION_MOVE As Int = 2
	Private Const ACTION_CANCEL As Int = 3
End Sub


' ------------ PUBLIC METHODS (API) ------------

'Owner: usually "Me" from the B4XPage that creates this class (target of the callback)
Public Sub Initialize(Root As B4XView, Owner As Object, EventName As String)
	mRoot = Root
	mOwner = Owner
	mEventName = EventName
	mAnimDurationMs = 250
	mCurrentIndex = -1
	classIME.Initialize("")
End Sub

Public Sub Build(SheetHeight As Int, VisibleFractions() As Float)
	Dim n As Int = VisibleFractions.Length
	Dim positions(n + 1) As Int
	Dim i As Int
	For i = 0 To n - 1
		positions(i) = mRoot.Height - Round(SheetHeight * VisibleFractions(i))
	Next
	positions(n) = mRoot.Height
	mPositionsY = positions

	mSheet = xui.CreatePanel("mSheet")
	mSheet.Color = xui.Color_White
	mRoot.AddView(mSheet, 0, mPositionsY(mPositionsY.Length - 1), mRoot.Width, SheetHeight)

	' The handle height adjusted for the curve
	Dim HandleHeight As Int = 32dip
	mHandle = xui.CreatePanel("")
	mSheet.AddView(mHandle, 0, 0, mSheet.Width, HandleHeight)

	UIUtils.SetTopCorners(mSheet, 28dip, xui.Color_White)
	UIUtils.SetTopCorners(mHandle, 28dip, xui.Color_RGB(224, 224, 224))

	' The content container starts right below the handle
	mContent = xui.CreatePanel("")
	mSheet.AddView(mContent, 0, HandleHeight, mSheet.Width, SheetHeight - HandleHeight)
End Sub

Public Sub OpenAt(Index As Int)
	If Index < 0 Or Index > mPositionsY.Length - 2 Then Return
	MoveTo(Index)
End Sub

Public Sub Close
	MoveTo(mPositionsY.Length - 1)
End Sub

Public Sub CurrentIndex As Int
	Return mCurrentIndex
End Sub

' Returns the content panel so a layout can be loaded into it
Public Sub getContentPanel As B4XView
	Return mContent
End Sub

' For the calculation of AbsoluteY in the B4XMainPage
Public Sub getTop As Int
	Return mSheet.Top
End Sub

' Returns True If the user Is actively dragging the BottomSheet
Public Sub getIsDragging As Boolean
	Return mIsDragging
End Sub

' Public Input Gateway: Intercepts and synthesizes drag inputs from high-level child views
' The mathematical core: processes the unified touch, applies the attenuation filter,
' and returns True if it was a clean click (Tap)
' It receives a preprocessed absolute screen-space Y coordinate from an external source
Public Sub ProcessSharedTouch (TargetView As B4XView, Action As Int, AbsoluteY As Float) As Boolean
	Dim classCleanClick As Boolean = False

	Select Action
		Case ACTION_DOWN
			mDownY = AbsoluteY
			mLastY = AbsoluteY
			mIsDragging = False ' We aren't dragging yet
			
			' Store the list's initial position
			' Without this, 'SnapToNearest' cannot calculate the destination when the finger is released
			mInitialIndex = mCurrentIndex
			
			HiddenKeyboardNow = False	' We reset the bolt by resting a finger on it
			
		Case ACTION_MOVE
			' Class-level threshold for drag activation
			If mIsDragging = False And Abs(AbsoluteY - mDownY) > 15dip Then
				mIsDragging = True
			End If
			
			If mIsDragging Then
				' Single-Trigger Centralized Input Lock Gate
				If HiddenKeyboardNow = False Then
					HiddenKeyboardNow = True ' Evita que este bloque se ejecute de nuevo
					classIME.HideKeyboard
                
					' We notify B4XMainPage
					If SubExists(mOwner, mEventName & "_HidingKeyboard") Then
						CallSub(mOwner, mEventName & "_HidingKeyboard")
					End If
				End If
				
				ExecuteDragPhysics(AbsoluteY)
			End If
			
		Case ACTION_UP, ACTION_CANCEL
			' We capture the state right before resetting it
			Dim wasDragging As Boolean = mIsDragging
			
			mIsDragging = False
			SnapToNearest
			
			' If we weren't dragging, then it was a valid tap
			classCleanClick = Not(wasDragging)
	End Select
	
	Return classCleanClick
End Sub



' ------------ PRIVATE METHODS (INTERNAL LOGIC) ------------

' Native Internal Listener: Evaluates drag actions directly on the raw background canvas
' Handles touch events for the main panel
' It activates when the user drags the BottomSheet, touching an empty area of ​​the sheet itself (the white background or the top handle)
' Calculates the absolute Y-coordinate in screen space
' Manages the keyboard
Private Sub mSheet_Touch(Action As Int, X As Float, Y As Float)
	' We convert the local Y into an absolute screen coordinate
	Dim AbsoluteY As Float = mSheet.Top + Y

	Select Action
		Case ACTION_DOWN
			' We reset the switch For the new towing attempt
			HiddenKeyboardNow = False
			
			' We save the absolute position And Initialize the frame tracker
			mDownY = AbsoluteY
			mLastY = AbsoluteY
			mIsDragging = True
			mInitialIndex = mCurrentIndex
			
		Case ACTION_MOVE
			' classIME.HideKeyboard does not need to know which EditText is active
			' It abruptly closes ANY keyboard open in the app
			' We only proceed if this is the first movement of this touch
			If HiddenKeyboardNow = False Then
				HiddenKeyboardNow = True ' Lock immediately to prevent repeated execution
        
				' Log("Class: Hiding keyboard (Only once per drag)")
				' Android discards the command if the keyboard is not open
				classIME.HideKeyboard
			
				If SubExists(mOwner, mEventName & "_HidingKeyboard") Then
					' Callback to B4XMainPage
					CallSub(mOwner, mEventName & "_HidingKeyboard")
				End If
			End If
			
			If mIsDragging Then
				ExecuteDragPhysics(AbsoluteY)
			End If
			
		Case ACTION_UP, ACTION_CANCEL
			mIsDragging = False
			SnapToNearest
	End Select
End Sub

' Unified physics auxiliary subroutine
' Physics Core Engine: Process spatial clamping and ease-filtering transformations
' Applies screen boundaries and the easing filter when dragging
Private Sub ExecuteDragPhysics(AbsoluteY As Float)
	' 1. We calculate the net displacement (delta) between this frame And the previous one
	Dim deltaY As Float = AbsoluteY - mLastY
	mLastY = AbsoluteY
	
	' 2. Calculate the panel's target position
	Dim targetTop As Int = mSheet.Top + deltaY
	
	' 3. Boundaries Clamping System Guard
	' mPositionsY(0)                  	-> Upper Limit (Fully Expanded / Minimum Top)
	' mPositionsY(mPositionsY.Length-2) -> Lower Limit (Last visible state before disappearing)
	If targetTop < mPositionsY(0) Then targetTop = mPositionsY(0)	' Expanded top
	If targetTop > mPositionsY(mPositionsY.Length - 2) Then targetTop = mPositionsY(mPositionsY.Length - 2)	' lowest visible top
	
	' 4. Easing Filter (40%)
	' Drastically reduces jitter by smoothing the physical transition
	Dim smoothedTop As Int = mSheet.Top + 0.40 * (targetTop - mSheet.Top)
	mSheet.Top = smoothedTop
End Sub

' Calculates the position in the mPositionsY array closest to the current top and selects it
Private Sub SnapToNearest
	' A safeguard in case they drag before an index is defined
	If mInitialIndex < 0 Then mInitialIndex = 0
	
	' 1. Calculate the total net movement on the screen (Delta Y)
	' If negative: The user moved the panel UP
	' If positive: The user moved the panel DOWN
	Dim totalDeltaY As Int = mSheet.Top - mPositionsY(mInitialIndex)
	Dim threshold As Int = 12dip  ' Minimum drag distance required To detect user intent
	
	' 2. We first look for the closest position based on pure mathematics (default physics)
	Dim bestIndex As Int = 0
	Dim bestDist As Int = 999999999
	Dim i As Int
	For i = 0 To mPositionsY.Length - 2
		Dim d As Int = Abs(mSheet.Top - mPositionsY(i))
		If d < bestDist Then
			bestDist = d
			bestIndex = i
		End If
	Next
	
	' 3. ' Vector Override System: Converts swift touch velocities into directional index shifts
	' If the calculation would snap the sheet back to the current position...
	If bestIndex = mInitialIndex Then
		' ...but your finger moved forcefully, crossing the threshold of intention:
		If Abs(totalDeltaY) > threshold Then
			If totalDeltaY < 0 Then
				' Slide up the panel -> Move to the previous item (on Android, a lower Y-coordinate means higher up)
				bestIndex = mInitialIndex - 1
			Else
				' Lower the panel -> Move to the next index
				bestIndex = mInitialIndex + 1
			End If
			
			' We safeguard the boundaries to avoid going out of bounds of the position array
			bestIndex = Max(0, Min(mPositionsY.Length - 2, bestIndex))
		End If
	End If
	
	' 4. We move smoothly to the calculated final position
	MoveTo(bestIndex)
End Sub

' Perform the final smooth glide toward the target position
Private Sub MoveTo(Index As Int)
	mCurrentIndex = Index

	mSheet.SetLayoutAnimated(mAnimDurationMs, mSheet.Left, mPositionsY(Index), mSheet.Width, mSheet.Height)
	CallSubDelayed2(mOwner, mEventName & "_StateChanged", Index)
End Sub

