### Animation easing functions by klaus
### 03/14/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/159777/)

After having seen the first post of this tread: [My favourite animation trick: exponential smoothing](https://www.b4x.com/android/forum/threads/my-favourite-animation-trick-exponential-smoothing.159744/).  
I decided to make a B4XPages project for the different easing functions and posted it there.  
The source of the equations comes from this site: [Easing Equations](https://gizma.com/easing/#easeInCubic)  
Then, I was suggested to post it here because the other thread is in the Chit chat forum.  
I did not remember that these equations were already converted to B4X by [USER=121302]@epiCode[/USER] in the thread [Easing Functions](https://www.b4x.com/android/forum/threads/b4x-easing-functions.135212/#content).  
  
I have used this kind of animation in the [xRotaryKnob library](https://www.b4x.com/android/forum/threads/b4x-xui-xrotaryknob-class.96045/#content), but inspired by a code from Erel in the [Gauges thread](https://www.b4x.com/android/forum/threads/b4x-xui-gauge-view.87435/#content).  
  
With the CSpline and CBezier easings you can move the green and red handles to modify the curves.  
With the CSpline easing you can do some 'exotic' easings.  
  
To use only one equation you can change it in the AnimateTo routine.  
The commented line is specific for CubicTimeEaseInOut.  
These two lines are also not needed:  
 DrawMovingDot(DateTime.Now - BeginTime, Duration)  
cvsMovement.ClearRect(cvsMovement.TargetRect)  
  

```B4X
    Private CurrentPosition As Int  
    Private BeginTime As Long = DateTime.Now  
     
    CurrentPosition = MoveTo  
    Dim tempValueA As Float  
    Do While DateTime.Now < BeginTime + Duration  
        tempValueA = CallAnimation(DateTime.Now - BeginTime, MoveFrom, MoveTo - MoveFrom, Duration)  
'        tempValueA = CubicTimeEaseInOut(DateTime.Now - BeginTime, MoveFrom, MoveTo - MoveFrom, Duration)  
        DrawCircle(tempValueA)  
        Sleep(5)  
        If MoveTo <> CurrentPosition Then Return 'will happen if another update has started  
     
        DrawMovingDot(DateTime.Now - BeginTime, Duration)  
    Loop  
    DrawCircle(CurrentPosition)  
    cvsMovement.ClearRect(cvsMovement.TargetRect)
```

  
  
![](https://www.b4x.com/android/forum/attachments/151820)