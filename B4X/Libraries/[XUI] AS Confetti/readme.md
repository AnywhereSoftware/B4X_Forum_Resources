###  [XUI] AS Confetti by Alexander Stolte
### 04/10/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164520/)

Blast some confetti all over the screen and celebrate user achievements!  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
[MEDIA=youtube]ZBubmyd8KMM[/MEDIA]  
  
**Effects**  
The respective effects can be [viewed here](https://youtu.be/ZBubmyd8KMM), or in the video above me  

```B4X
AS_Confetti1.DropConfetti
```

  

```B4X
AS_Confetti1.ConfettiExplosion(Root.Width/2,Root.Height/2)
```

  

```B4X
AS_Confetti1.SideBurst(False) 'True for Left and False for Right
```

  

```B4X
AS_Confetti1.PulseBurst(Root.Width/2,Root.Height/2,5,250)
```

  
  
**ParticleCount**  
Number of shapes that are generated and fall down  
  
**Gravity**  
The value determines how fast an object accelerates when falling.  
The Default Value is 0.2  
  
**SemiTransparentShapes**  
The alpha value is determined randomly  
![](https://www.b4x.com/android/forum/attachments/159302)  
**SetColors**  

```B4X
    Dim lst_Colors As List  
    lst_Colors.Initialize  
    lst_Colors.Add(xui.Color_ARGB(255, 49, 208, 89))  
    lst_Colors.Add(xui.Color_ARGB(255, 25, 29, 31))  
    lst_Colors.Add(xui.Color_ARGB(255, 9, 131, 254))  
    lst_Colors.Add(xui.Color_ARGB(255, 255, 159, 10))  
    lst_Colors.Add(xui.Color_ARGB(255, 45, 136, 121))  
    lst_Colors.Add(xui.Color_ARGB(255, 73, 98, 164))  
    lst_Colors.Add(xui.Color_ARGB(255, 221, 95, 96))  
    lst_Colors.Add(xui.Color_ARGB(255, 141, 68, 173))  
    lst_Colors.Add(xui.Color_Magenta)  
    lst_Colors.Add(xui.Color_Cyan)  
    AS_Confetti1.SetColors(lst_Colors)
```

  
**Particles**  
![](https://www.b4x.com/android/forum/attachments/163344)  
**Events**  

```B4X
'Is triggered when all particles are on the ground or the animation has been stopped  
Private Sub AS_Confetti1_Finished  
    Log("Finished")  
End Sub
```

  
  
**AS\_Confetti  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_Confetti**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Base\_Resize** (Width As Double, Height As Double)
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GenerateConfetti**
- **Initialize** (Callback As Object, EventName As String)
- **SetColors** (ColorList As List)
*<code>  
 Dim lst\_Colors As List  
 lst\_Colors.Initialize  
 lst\_Colors.Add(xui.Color\_ARGB(255, 49, 208, 89))  
 lst\_Colors.Add(xui.Color\_ARGB(255, 25, 29, 31))  
 lst\_Colors.Add(xui.Color\_ARGB(255, 9, 131, 254))  
 lst\_Colors.Add(xui.Color\_ARGB(255, 255, 159, 10))  
 lst\_Colors.Add(xui.Color\_ARGB(255, 45, 136, 121))  
 lst\_Colors.Add(xui.Color\_ARGB(255, 73, 98, 164))  
 lst\_Colors.Add(xui.Color\_ARGB(255, 221, 95, 96))  
 lst\_Colors.Add(xui.Color\_ARGB(255, 141, 68, 173))  
 lst\_Colors.Add(xui.Color\_Magenta)  
 lst\_Colors.Add(xui.Color\_Cyan)  
 AS\_Confetti1.SetColors(lst\_Colors)  
 </code>*
- **Properties:**

- **BackgroundColor** As Int
- **CircleParticle** As Boolean
- **Gravity** As Double
*The value determines how fast an object accelerates when falling  
 Default: 0.2*- **HexagonParticle** As Boolean
- **LightningParticle** As Boolean
*A zigzag shape can have a dynamic effect and brings movement into play*- **ParticleCount** As Int
- **RectangleParticle** As Boolean
- **SemiTransparentShapes** As Boolean
*The alpha value is determined randomly*- **StarParticle** As Boolean
- **TriangleParticle** As Boolean

[/SPOILER]  
  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add new particle "HeartParticle"

- Default: True

- Add new particle "SnowflakeParticle"

- Default: False

- **1.02**

- BugFixes and Improvements
- New CreateViewPerCode
- New ConfettiExplosion - Creates a confetti explosion from the point (StartX, StartY) with random direction and speed for each particle
- New SideBurst - Blasts confetti from the left or right side horizontally across the view
- New PulseBurst - Creates a series of mini explosions from the center
- New "TrapezoidParticle"

- Default: False

- New Event "Finished" - Is triggered when all particles are on the ground or the animation has been stopped
- Change GenerateConfetti renamed to DropConfetti

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)