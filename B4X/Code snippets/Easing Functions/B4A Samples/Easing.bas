B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11
@EndOfDesignText@
'Code converted to b4x by @Mohsyn
'Modified code as shared by Erel from http://gizma.com/easing

Sub process_globals
	
End Sub


Public Sub linearTween (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Return ChangeInValue  * Time/ Duration + Start
End Sub
		
'// quadratic easing in - accelerating from zero velocity


Public Sub easeInQuad (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Return ChangeInValue  * Time*Time + Start
End Sub
		

'// quadratic easing out - decelerating To zero velocity


Public Sub easeOutQuad (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Return - ChangeInValue * Time*(Time-2) + Start
End Sub

		

'// quadratic easing in/out - acceleration Until halfway, Then deceleration


Public Sub easeInOutQuad (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / (Duration / 2)
	If (Time < 1) Then Return ChangeInValue  /2*Time*Time + Start
	Time = Time - 1
	Return - ChangeInValue/2 * (Time*(Time-2) - 1) + Start
End Sub


'// cubic easing in - accelerating from zero velocity


Public Sub easeInCubic (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Return ChangeInValue  * Time*Time*Time + Start
End Sub

		

'// cubic easing out - decelerating To zero velocity


Public Sub easeOutCubic (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Time = Time -1
	Return ChangeInValue  * (Time*Time*Time + 1) + Start
End Sub

		

'// cubic easing in/out - acceleration Until halfway, Then deceleration


Public Sub easeInOutCubic (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / (Duration / 2)
	If (Time < 1) Then Return ChangeInValue  /2*Time*Time*Time + Start
	Time = Time + 2
	Return ChangeInValue  /2*(Time*Time*Time + 2) + Start
End Sub
	

'// quartic easing in - accelerating from zero velocity


Public Sub easeInQuart (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Return ChangeInValue  * Time*Time*Time*Time + Start
End Sub

		

'// quartic easing out - decelerating To zero velocity


Public Sub easeOutQuart (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Time = Time -1
	Return - ChangeInValue * (Time*Time*Time*Time - 1) + Start
End Sub

		

'// quartic easing in/out - acceleration Until halfway, Then deceleration


Public Sub easeInOutQuart (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time /(Duration / 2)
	If (Time < 1) Then Return ChangeInValue  /2 * Time * Time * Time * Time + Start
	Time = Time -2
	Return - ChangeInValue/2 * (Time*Time*Time*Time - 2) + Start
End Sub


'// quintic easing in - accelerating from zero velocity


Public Sub easeInQuint (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Return ChangeInValue  * Time*Time*Time*Time*Time + Start
End Sub

		

'// quintic easing out - decelerating To zero velocity


Public Sub easeOutQuint (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Time = Time -1
	Return ChangeInValue  * (Time * Time*Time * Time * Time + 1) + Start
End Sub

		

'// quintic easing in/out - acceleration Until halfway, Then deceleration


Public Sub easeInOutQuint (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / (Duration / 2)
	If (Time < 1) Then Return ChangeInValue /2 * Time * Time * Time * Time * Time + Start
	Time = Time -2
	Return ChangeInValue  /2 * (Time * Time * Time * Time * Time + 2) + Start
End Sub
		

'// sinusoidal easing in - accelerating from zero velocity


Public Sub easeInSine (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Return - ChangeInValue * Cos(Time/ Duration * (cPI/2)) + ChangeInValue + Start
End Sub

		

'// sinusoidal easing out - decelerating To zero velocity


Public Sub easeOutSine (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Return ChangeInValue  * Sin(Time/ Duration * (cPI/2)) + Start
End Sub

		

'// sinusoidal easing in/out - accelerating Until halfway, Then decelerating


Public Sub easeInOutSine (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Return - ChangeInValue/2 * (Cos(cPI*Time/ Duration) - 1) + Start
End Sub

		

'// exponential easing in - accelerating from zero velocity


Public Sub easeInExpo (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Return ChangeInValue  * Power( 2, 10 * (Time/ Duration - 1) ) + Start
End Sub

		

'// exponential easing out - decelerating To zero velocity


Public Sub easeOutExpo (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Return ChangeInValue  * ( -Power( 2, -10 * Time/ Duration ) + 1 ) + Start
End Sub

		

'// exponential easing in/out - accelerating Until halfway, Then decelerating


Public Sub easeInOutExpo (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time /(Duration / 2)
	If (Time < 1) Then Return ChangeInValue  /2 * Power( 2, 10 * (Time - 1) ) + Start
	Time = Time -1
	Return ChangeInValue  /2 * ( -Power( 2, -10 * Time) + 2 ) + Start
End Sub
		

'// circular easing in - accelerating from zero velocity


Public Sub easeInCirc (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Return - ChangeInValue * (Sqrt(1 - Time * Time) - 1) + Start
End Sub

		

'// circular easing out - decelerating To zero velocity


Public Sub easeOutCirc (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / Duration
	Time = Time -1
	Return ChangeInValue  * Sqrt(1 - Time * Time) + Start
End Sub

'// circular easing in/out - acceleration Until halfway, Then deceleration

Public Sub easeInOutCirc (Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time =  Time / (Duration / 2)
	If (Time < 1) Then Return - ChangeInValue/2 * (Sqrt(1 - Time * Time) - 1) + Start
	Time = Time -2
	Return ChangeInValue  /2 * (Sqrt(1 - Time * Time) + 1) + Start
End Sub
