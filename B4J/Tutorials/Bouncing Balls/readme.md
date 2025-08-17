### Bouncing Balls by Johan Schoeman
### 01/07/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/158491/)

Enjoy!  
  
![](https://www.b4x.com/android/forum/attachments/149396)  
  
Comment/uncomment the code in class Ball(move) and see gravity, friction, damping changing the behavior of the balls.  
  

```B4X
Public Sub move  
    
'    Dim damp As Double = 0.99      'was 0.99  
'    Dim friction As Double = 0.97   'was 0.97  
'    Dim gravity As Double = 0.01  
'    vx = vx * damp  
'    vy = vy * damp  
'    vy = vy + gravity  
'    If ((rx + vx * friction) + radius > cv.Width) Then vx = -1 * vx  
'    If ((rx + vx * friction) - radius < 0) Then vx = -1 * vx  
'    If ((ry + vy * friction) + radius > cv.Height) Then vy = -1 * vy  
'    If ((ry + vy * friction) - radius < 0) Then vy = -1 * vy  
'    rx = rx + vx * friction  
'    ry = ry + vy * friction  
    
    If ((rx + vx) + radius > cv.Width) Then bounceOffVerticalWall  
    If ((rx + vx) - radius < cv.Left) Then bounceOffVerticalWall  
    If ((ry + vy) + radius > cv.Height) Then bounceOffHorizontalWall  
    If ((ry + vy) - radius < cv.Top) Then bounceOffHorizontalWall  
    rx = rx + vx  
    ry = ry + vy  
End Sub
```

  
  
Change the number of balls( Dim b(100)) to whatever you like:  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
  
    Private cv As Canvas  
    Dim b(100) As Ball  
    
    Dim t As Timer  
    
End Sub
```