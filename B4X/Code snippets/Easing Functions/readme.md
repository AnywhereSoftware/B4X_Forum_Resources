###  Easing Functions by epiCode
### 03/06/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/135212/)

Code module containing 22 Ease In/out functions  
  
Thanks to Erel for mentioning the Source: [gizma](http://gizma.com/easing)  
  
**Functions:**  
  

1. Simple Linear Tweening - No Easing, No Acceleration
2. Quadratic Easing In - Accelerating From Zero Velocity
3. Quadratic Easing Out - Decelerating To Zero Velocity
4. Quadratic Easing In/Out - Acceleration Until Halfway, Then Deceleration
5. Cubic Easing In - Accelerating From Zero Velocity
6. Cubic Easing Out - Decelerating To Zero Velocity
7. Cubic Easing In/Out - Acceleration Until Halfway, Then Deceleration
8. Quartic Easing In - Accelerating From Zero Velocity
9. Quartic Easing Out - Decelerating To Zero Velocity
10. Quartic Easing In/Out - Acceleration Until Halfway, Then Deceleration
11. Quintic Easing In - Accelerating From Zero Velocity
12. Quintic Easing Out - Decelerating To Zero Velocity
13. Quintic Easing In/Out - Acceleration Until Halfway, Then Deceleration
14. Sinusoidal Easing In - Accelerating From Zero Velocity
15. Sinusoidal Easing Out - Decelerating To Zero Velocity
16. Sinusoidal Easing In/Out - Accelerating Until Halfway, Then Decelerating
17. Exponential Easing In - Accelerating From Zero Velocity
18. Exponential Easing Out - Decelerating To Zero Velocity
19. Exponential Easing In/Out - Accelerating Until Halfway, Then Decelerating
20. Circular Easing In - Accelerating From Zero Velocity
21. Circular Easing Out - Decelerating To Zero Velocity
22. Circular Easing In/Out - Acceleration Until Halfway, Then Deceleration

  
**Usage**:  
See attached example (B4A) or check Erel's Example with implementation in [CircularProgressBar here](https://www.b4x.com/android/forum/threads/b4x-xui-custom-view-circularprogressbar.81604)  
  
  

```B4X
'Code converted to b4x by @epicode  
'Modified code as shared by Erel from http://gizma.com/easing  
  
  
  
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
```