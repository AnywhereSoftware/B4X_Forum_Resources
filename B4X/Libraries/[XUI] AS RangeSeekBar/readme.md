###  [XUI] AS RangeSeekBar by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/136336/)

I took the original [B4XSeekBar](https://www.b4x.com/android/forum/threads/b4x-xui-views-cross-platform-views-and-dialogs.100836/#content) code from [USER=1]@Erel[/USER] and modified it to create a new view.  
  
I spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/122293)![](https://www.b4x.com/android/forum/attachments/122294)  
**ASRangeSeekBar  
Author: Alexander Stolte  
Version: 1.01**  

- **ASRangeSeekBar**

- **Events:**

- **TouchStateChanged** (Pressed As Boolean)
- **ValueChanged** (Value1 As Int, Value2 As Int)

- **Fields:**

- **Interval** As Int
- **MaxValue** As Int
- **mBase** As B4XView
- **MinValue** As Int
- **Radius1** As Int
- **Radius2** As Int
- **ReachedLineColor** As Int
- **ReachedLineSize** As Int
- **Tag** As Object
- **ThumbColor** As Int
- **UnreachedLineColor** As Int
- **UnreachedLineSize** As Int

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getValue1** As Int
- **getValue2** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setValue1** (v As Int) As String
- **setValue2** (v As Int) As String
- **Update** As String
*Redraws the control*
- **Properties:**

- **Value1** As Int
- **Value2** As Int

**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFix - set Value2 was linked to the wrong variable

- **1.02**

- Base\_Resize is public now

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)