###  [XUI] AS Ripple View by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/108897/)

First, i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
Thanks to [USER=1]@Erel[/USER] for his [Simple Halo Animation](https://www.b4x.com/android/forum/threads/b4x-xui-simple-halo-animation.80267/#content).  
  
![](https://www.b4x.com/android/forum/attachments/83345) ![](https://www.b4x.com/android/forum/attachments/83346)  
  
**Features**  

- Add View per code
- Change Color at runtime
- Modify the durations
- start and stop

**Author: Alexander Stolte  
Version: 1.00**  

- **ASRippleView**

- **Functions:**

- **AddView** (base As Object, duration As Int, fade\_duration As Int, ripple\_color As Int) As String
*Adds the View per code to the Parent (base)*- **Apply** As String
*Applys the changes on the View for example: change color*- **Class\_Globals** As String
- **CreateHaloEffectHelper** (Parent As B4XView, x As Int, y As Int, radius As Int)
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getDuration** As Int
- **getFadeDuration** As Int
- **getIsRunning** As Boolean
*Checks the state of the animation*- **getRippleColor** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setDuration** (duration As Int) As String
- **setFadeDuration** (duration As Int) As String
- **setRippleColor** (color As Int) As String
- **Start** As String
*Starts the animation*- **Stop** As String
*Stops the Animation*
- **Properties:**

- **Duration** As Int
- **FadeDuration** As Int
- **IsRunning** As Boolean [read only]
*Checks the state of the animation*- **RippleColor** As Int

**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFixes and Improvements
- Add Designer Property StartOnStartup - Starts the animation as soon as the view has been built

- Default: False

- Add get and set CircleStartGap - A gap where the animation begins

- Useful if the view is behind a view and the animation should only start when the view is finished
- Default: 0

If you **like** my work, then [spend me a coffe or two](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)