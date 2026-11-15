### RotatingImage - a short sample by GMan
### 11/04/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/172474/)

I like moving things on i.e. the InfoScreen of an App.  
  
So, rotating existing images is a nice & simple way to reach that goal.  
It isn't hard to solve, just some simple lines of Code.  
  
1. Declare a variable for the timer and the rotating angle:  

```B4X
Sub Class_globals  
    Private Timer1 as Timer  
    Private rotawinkel As Int  
End Sub
```

  
  
2. set it to 0 (Zero) - or any othe angle you want  

```B4X
Public Sub Initialize  
    rotawinkel = 0  
End Sub
```

  
  
3. include it in Timer1\_Tick  

```B4X
Private Sub Timer1_Tick  
    rotawinkel = rotawinkel + 1  
    YourImageView.As(B4XView).Rotation = rotawinkel  
    If rotawinkel = 360 Then  
        rotawinkel = 0  
    End If  
End sub
```

  
  
4. Initialize (start) the Timer1:  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Timer1.Initialize("Timer1",1000)  
    …  
    …  
    …  
    Timer1_Tick  
    Timer1.Enabled = True  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/174695)  
YOUR DONE !  
  
Here is a sample Video of it:  
[YT: RotatingImageView](https://www.youtube.com/shorts/UJkK1XiLRk0)  
  
btw: this timer is linked to the clock, so only 1 tick per Second.  
Of course you can create an additional timer and set it to.  

```B4X
    Timer2.Initialize("Timer2",200)
```

  
to speed things up :cool:  
  
Don't forget to create, initalize and start the 2nd timer ;)