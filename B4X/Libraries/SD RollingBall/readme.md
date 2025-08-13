###  SD RollingBall by Star-Dust
### 08/25/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/142549/)

How many times has the need to roll the balls of a billiard table arose. In some gaming applications or anyway with a creative interface it is nice to see moving views that simulate real objects. I started with spinning the dice with the previous library, now I wanted to spin the balls and it seems that he has succeeded. I added the light effect but I turned off the 3D effect  
  
**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author*  
  
for DICE see [**here**](https://www.b4x.com/android/forum/threads/b4x-xui-jsd_dice.126123/)  
  
**SD\_RollingBall  
  
Author:** Star-Dust  
**Version:** 0.01  

- **SD\_RollingBall**

- **Events:**

- **MovementCompleted**
- **ReboundCopmpleted**
- **ResizeCopmpleted**

- **Fields:**

- **BallText** As String
- **Effect3d** As Boolean
- **EffectLight** As Boolean
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **Move** (Duration As Int, DeltaX As Int, DeltaY As Int)
- **MoveTo** (Duration As Int, Left As Int, Top As Int)
- **Rebound** (magnification As Float)
*Animation 600 mills*- **Resize** (Duration As Int, Width As Int, Height As Int)
- **Start**
- **Stop**

  
**\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_**  

```B4X
Sub Process_Globals  
    Private SD_RollingBall2 As SD_RollingBall  
End Sub  
  
Sub Ball  
    Sleep(1000)  
    SD_RollingBall2.Move(800,300,300)  
    Wait For SD_RollingBall2_MovementCompleted  
    SD_RollingBall2.Rebound(2)  
    Wait For SD_RollingBall2_ReboundCopmpleted  
    Sleep(100)  
    SD_RollingBall2.Stop  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/133014)![](https://www.b4x.com/android/forum/attachments/133015)