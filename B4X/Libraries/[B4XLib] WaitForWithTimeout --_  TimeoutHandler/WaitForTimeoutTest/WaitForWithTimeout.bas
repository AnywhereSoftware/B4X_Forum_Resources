B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
' WaitForWithTimeout - class
' Version: 1.0
' Author: LucaMs

Sub Class_Globals
	Private fx As JFX
	Private mComponent As Object
	Private mExpectedEvent As String

	Private tmrTimeout As Timer
	Private tmrSteps As Timer
	Private mStepsInterval As Long
	Private mStepCounter As Long
	Private mTimeFormat As String
	
	Private mValueOnTimeout As Object
	
	Private mCountdownView As B4XView
End Sub

' Parameters:
' Component - the module that will receive the events
' ExpectedEvent - name of the event "Wait For" will... wait for :)
' Timeout - !
Public Sub Initialize(Component As Object, ExpectedEvent As String, Timeout As Long)
	mComponent = Component
	tmrTimeout.Initialize("tmrTimeout", Timeout)
	mExpectedEvent = ExpectedEvent
	
	mStepsInterval = 1000
	tmrSteps.Initialize("tmrSteps", mStepsInterval)
	mTimeFormat = "s"
	
	mValueOnTimeout = Null
End Sub

#Region PROPERTIES 

' Sets/gets the module that will receive the events.
Public Sub setComponent(Comp As Object)
	mComponent = Comp
End Sub
Public Sub getComponent As Long
	Return mComponent
End Sub

' Sets/gets the name of the event "Wait For" will... wait for :)
Public Sub setExpectedEvent(Event As String)
	mExpectedEvent = Event
End Sub
Public Sub getExpectedEvent As String
	Return mExpectedEvent
End Sub

' Sets/gets the value returned on timeout.
Public Sub setValueOnTimeout(Value As Object)
	mValueOnTimeout = Value
End Sub
Public Sub getValueOnTimeout As Object
	Return mValueOnTimeout
End Sub

Public Sub setTimeout(Timeout As Long)
	tmrTimeout.Interval = Timeout
End Sub
Public Sub getTimeout As Long
	Return tmrTimeout.Interval
End Sub

' Sets/gets the interval time ("steps") useful to show the countdown.
Public Sub setInterval(Interval As Long)
	mStepsInterval = Interval
End Sub
Public Sub getInterval As Long
	Return mStepsInterval
End Sub

' Sets/gets the B4XView that will (optionally) display the countdown.
Public Sub setCountdownView(CDView As B4XView)
	mCountdownView = CDView
End Sub
Public Sub getCountdownView As B4XView
	Return mCountdownView
End Sub

' Sets/gets the countdown time format.
Public Sub setTimeFormat(TimeFormat As String)
	mTimeFormat = TimeFormat
End Sub
Public Sub getTimeFormat As String
	Return mTimeFormat
End Sub

#End Region

#Region METHODS 

' Starts the Wait For with timeout. You should write it before the "regular" Wait For statement.
'<code>
' mWaitForWithTimeout.Initialize(Me, "CardPlayed", 3000)
' mWaitForWithTimeout.Wait
' Wait For CardPlayed (CardValue As String)
'</code>
Public Sub Wait
	If mCountdownView.IsInitialized Then
		mStepCounter = tmrTimeout.Interval
		mCountdownView.Text = TimeString(mStepCounter)
	End If

	tmrTimeout.Enabled = True
	
	If mCountdownView.IsInitialized Then
		tmrSteps.Enabled = True
	End If
End Sub

' To raise the event before the timeout.
Public Sub RaiseEvent(SomeValue As String)
	tmrTimeout.Enabled = False
	tmrSteps.Enabled = False
	CallSubDelayed2(mComponent, mExpectedEvent, SomeValue)
End Sub

Private Sub TimeString(T As Long) As String
	Dim Result As String
	Dim CurrTimeFormat As String = DateTime.TimeFormat
	DateTime.TimeFormat = mTimeFormat
	Result = DateTime.Time(t)
	DateTime.TimeFormat = CurrTimeFormat
	Return Result
End Sub

#End Region

#Region EVENTS 

Private Sub tmrSteps_Tick
	mStepCounter = mStepCounter - mStepsInterval
	If mCountdownView.IsInitialized Then
		mCountdownView.Text = TimeString(mStepCounter)
	End If
End Sub

Private Sub tmrTimeout_Tick
	tmrTimeout.Enabled = False
	tmrSteps.Enabled = False
	CallSubDelayed2(Me, "RaiseEvent", mValueOnTimeout)
End Sub

#End Region
