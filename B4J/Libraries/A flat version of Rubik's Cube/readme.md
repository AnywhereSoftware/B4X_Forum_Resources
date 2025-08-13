### A flat version of Rubik's Cube by Johan Schoeman
### 09/23/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/163246/)

It is based on [**this Github Project**](https://github.com/ljz112/rubiks-cube/blob/main/rubikscube.java) and used it as inline Java code. Have modified the original Java code a bit to allow for scrambling of the cube from within B4J and then to solve it and then to also bring back the results of both to the B4J project via Events that was added to the Java project and the B4J code.  
  
Note the following as far as Scramble commands of a cube is concerned:  

```B4X
    'CW = clockwise  
    'CCW = counter clockwise  
    'F = Front CW, Fp = Front CCW, D = Down/Bottom CW, Dp = Down/Bottom CCW, L = Left CW, Lp = Left CCW  
    'U = Top/Upper CW, Up = Top/Upper CCW, R = Right CW, Rp = Right CCW, B = Back CW, Bp = Back CCW
```

  
  
Type the commands into the TextField - individual commands must be separated by a "**,**" (eg F,B,D,U,Fp,L,R,Up,D,Fp,L……..)  
Click on button Scramble to scramble the cube  
Click on button Solve to solve the cube  
  
Solving method used is the Old Pochmann Method, mainly used for blindfolded solves.  
  
See the B4J logs for the Solving Strategy applied (in the example below - 'Strategy: k d r y j g y M L W K J D R T S Q)  
  
Enjoy! - Expect no support for this as it was purely done for fun. Modify it to your liking.  
  
Starting UI:  
![](https://www.b4x.com/android/forum/attachments/157250)  
  
Type scramble commands into TextField and click on button "Scramble"  
![](https://www.b4x.com/android/forum/attachments/157251)  
  
Scrambled cube  
![](https://www.b4x.com/android/forum/attachments/157252)  
  
Solved cube  
![](https://www.b4x.com/android/forum/attachments/157253)