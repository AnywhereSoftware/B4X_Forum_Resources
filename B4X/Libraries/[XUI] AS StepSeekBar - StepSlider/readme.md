###  [XUI] AS StepSeekBar - StepSlider by Alexander Stolte
### 09/20/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/136270/)

I took the original [B4XSeekBar](https://www.b4x.com/android/forum/threads/b4x-xui-views-cross-platform-views-and-dialogs.100836/#content) code from [USER=1]@Erel[/USER] and modified it to create a new view.  
  
I spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/122178)![](https://www.b4x.com/android/forum/attachments/122179)  

```B4X
For i = 0 To 4 -1  
    ASStepSeekBar1.AddStep(xui.Color_White,"Item " & (i))  
    ASStepSeekBar2.AddStep(xui.Color_White,"Item " & (i))  
Next
```

  
**ASStepSeekBar  
Author: Alexander Stolte  
Version: 1.00**  

- **ASStepSeekBar**

- **Events:**

- **TouchStateChanged** (Pressed As Boolean)
- **ValueChanged** (Index As Int, Value As Object)

- **Fields:**

- **Interval** As Int
- **mBase** As B4XView
- **Radius1** As Int
- **Radius2** As Int
- **ReachedLineColor** As Int
- **ReachedLineSize** As Int
- **Tag** As Object
- **ThumbColor** As Int
- **UnreachedLineColor** As Int
- **UnreachedLineSize** As Int

- **Functions:**

- **AddStep** (Color As Int, Value As Object) As String
- **Class\_Globals** As String
- **CreateASStepSeekBar\_Step** (Value As Object, Color As Int) As ASStepSeekBar\_Step
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getSize** As Int
*Gets the count of steps*- **GetStepValue** (Index As Int) As Object
*Get a value from a step*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setStepIndex** (Index As Int) As String
- **Update** As String
*Redraws the control*
- **Properties:**

- **StepIndex**

- **ASStepSeekBar\_Step**

- **Fields:**

- **Color** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Value** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- minor adjustments
- Base\_Resize is public now

- **1.02**

- Add get StepIndex

- **1.03**

- Add Clear - Clear all steps
- Hitbox improved - you can now simply tap on the line and the item that is closer to it will be selected

- **1.04**

- BugFix

- **1.05**

- BugFixes on the vertical seekbar
- Add AddStep2 with ReachedColor and UnreachedColor parameter

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)