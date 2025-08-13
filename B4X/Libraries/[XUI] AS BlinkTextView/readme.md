###  [XUI] AS BlinkTextView by Alexander Stolte
### 02/02/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/140951/)

A TextView that blinks, just like the good old HTML <blink> tag.  
  
<https://github.com/frakbot/BlinkTextView>  
<https://www.b4x.com/android/forum/threads/blinktextview.61009/#content>  
  
i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/129920)  
**Examples:**  

```B4X
Dim Blink As AS_BlinkTextView  
Blink.Initialize(Me,"Blink")  
Blink.AddToParent(Root,0,0,50dip,50dip)  
Blink.Text = "Test"  
Blink.Font = xui.CreateDefaultBoldFont(20)  
Blink.TextColor = xui.Color_White  
Blink.AnimationDuration = 250  
Blink.StartBlink
```

  
**ASBlinkTextView  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_BlinkTextView**

- **Events:**

- **Click**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddToParent** (Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float) As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getAnimationDuration** As Long
- **getFont** As B4XFont
- **getLabel** As B4XView
- **getRotation** As Double
- **getText** As String
- **getTextColor** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RemoveView** As String
- **setAnimationDuration** (Duration As Long) As String
- **setDuration** (Duration As Long) As String
- **setFont** (xFont As B4XFont) As String
- **setRotation** (Rotation As Double) As String
- **setText** (Text As String) As String
- **setTextColor** (Color As Int) As String
- **StartBlink** As String
- **StopBlink** As String

- **Properties:**

- **AnimationDuration** As Long
- **Duration**
- **Font** As B4XFont
- **Label** As B4XView [read only]
- **Rotation** As Double
- **Text** As String
- **TextColor** As Int

**Changelog**  

- **1.00**

- Release

**Github:** [github.com/StolteX/AS\_BlinkTextView](https://github.com/StolteX/AS_BlinkTextView)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)