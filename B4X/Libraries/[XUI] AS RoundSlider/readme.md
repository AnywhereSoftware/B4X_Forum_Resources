###  [XUI] AS RoundSlider by Alexander Stolte
### 02/08/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/137445/)

I took the original [RoundSlider](https://www.b4x.com/android/forum/threads/b4x-xui-roundslider.95465/#content)code from [USER=1]@Erel[/USER] and modified it to create a new view.  
Still, it was a very big challenge, since I've never done anything with circles before.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/123958)![](https://www.b4x.com/android/forum/attachments/123959)![](https://www.b4x.com/android/forum/attachments/123960)  
  
**ASRoundSlider  
Author: Alexander Stolte  
Version: 1.00**  

- **ASRoundSlider**

- **Events:**

- **ValueChanged** (Value As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Draw** As String
*Draws the view new*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getInnerCircleColor** As Int
*Gets or sets the Inner Circle Color*- **getReachedColor** As Int
*Gets or sets the Reached Color*- **getStrokeWidth** As Int
*Gets or sets the Stroke Width*- **getThumbBorderColor** As Int
*Gets or sets the Thumb Border Color*- **getThumbIcon** As B4XBitmap
*Gets or sets the Thumb Icon*- **getThumbInnerColor** As Int
*Gets or sets the Thumb Inner Color*- **getThumbView** As B4XView
- **getUnreachedColor** As Int
*Gets or sets the Unreached Color*- **getValue** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setInnerCircleColor** (Color As Int) As String
- **setReachedColor** (Color As Int) As String
- **setStrokeWidth** (Width As Int) As String
- **setThumbBorderColor** (Color As Int) As String
- **setThumbIcon** (Icon As B4XBitmap) As String
- **setThumbInnerColor** (Color As Int) As String
- **setUnreachedColor** (Color As Int) As String
- **setValue** (v As Int) As String
*Gets or sets the value*
- **Properties:**

- **InnerCircleColor** As Int
*Gets or sets the Inner Circle Color*- **ReachedColor** As Int
*Gets or sets the Reached Color*- **StrokeWidth** As Int
*Gets or sets the Stroke Width*- **ThumbBorderColor** As Int
*Gets or sets the Thumb Border Color*- **ThumbIcon** As B4XBitmap
*Gets or sets the Thumb Icon*- **ThumbInnerColor** As Int
*Gets or sets the Thumb Inner Color*- **ThumbView** As B4XView [read only]
- **UnreachedColor** As Int
*Gets or sets the Unreached Color*- **Value** As Int
*Gets or sets the value*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add get and set MinValue
- Add get and set MaxValue
- Add Icon Gap

**Github:** [github.com/StolteX/AS\_RoundSlider](https://github.com/StolteX/AS_RoundSlider)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)