###  [XUI] AS RangeRoundSlider by Alexander Stolte
### 02/06/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/137446/)

I took the original [RoundSlider](https://www.b4x.com/android/forum/threads/b4x-xui-roundslider.95465/#content)code from [USER=1]@Erel[/USER] and modified it to create a new view.  
Still, it was a very big challenge, since I've never done anything with circles before.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/123961)![](https://www.b4x.com/android/forum/attachments/124037)  
<https://www.b4x.com/android/forum/threads/b4x-as-rangeslider-as-clock-sleep-schedule-picker.137578/>  
**ASRangeRoundSlider  
Author: Alexander Stolte  
Version: 1.04**  

- **ASRangeRoundSlider**

- **Events:**

- **ValueChanged** (Value1 As Int, Value2 As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Draw** As String
*Draws the view new*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getCurrentOverScrollMultiplier1** As Int
- **getCurrentOverScrollMultiplier2** As Int
- **getInnerCircleColor** As Int
*Gets or sets the Inner Circle Color*- **getMaxValue** As Int
- **getMinValue** As Int
- **getOverScrollMultiplier** As Int
- **getReachedColor** As Int
*Gets or sets the Reached Color*- **getStrokeWidth** As Int
*Gets or sets the Stroke Width*- **getThumb1View** As B4XView
- **getThumb2View** As B4XView
- **getThumbBorderColor** As Int
*Gets or sets the Thumb Border Color*- **getThumbIcon1** As B4XBitmap
*Gets or sets the Thumb Icon 1*- **getThumbIcon2** As B4XBitmap
*Gets or sets the Thumb Icon 2*- **getThumbInnerColor** As Int
*Gets or sets the Thumb Inner Color*- **getUnreachedColor** As Int
*Gets or sets the Unreached Color*- **getValue1** As Int
- **getValue2** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setCurrentOverScrollMultiplier1** (CurrentMultiplier As Int) As String
*Gets or sets the current scroll multiplier  
 This value adjusts internally when the "OverScrollMultiplier" is greater than 1  
 Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier*- **setCurrentOverScrollMultiplier2** (CurrentMultiplier As Int) As String
*Gets or sets the current scroll multiplier  
 This value adjusts internally when the "OverScrollMultiplier" is greater than 1  
 Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier*- **setInnerCircleColor** (Color As Int) As String
- **setMaxValue** (Value As Int) As String
- **setMinValue** (Value As Int) As String
- **setOverScrollMultiplier** (Multiplier As Int) As String
*The value multiplies the max value when you have scrolled over step by step  
 Default: 1 - Minimum: 1*- **setReachedColor** (Color As Int) As String
- **setStrokeWidth** (Width As Int) As String
- **setThumbBorderColor** (Color As Int) As String
- **setThumbIcon1** (Icon As B4XBitmap) As String
- **setThumbIcon2** (Icon As B4XBitmap) As String
- **setThumbInnerColor** (Color As Int) As String
- **setUnreachedColor** (Color As Int) As String
- **setValue1** (v As Int) As String
*Gets or sets the value 1*- **setValue2** (v As Int) As String
*Gets or sets the value 2*
- **Properties:**

- **CurrentOverScrollMultiplier1** As Int
*Gets or sets the current scroll multiplier  
 This value adjusts internally when the "OverScrollMultiplier" is greater than 1  
 Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier*- **CurrentOverScrollMultiplier2** As Int
*Gets or sets the current scroll multiplier  
 This value adjusts internally when the "OverScrollMultiplier" is greater than 1  
 Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier*- **InnerCircleColor** As Int
*Gets or sets the Inner Circle Color*- **MaxValue** As Int
- **MinValue** As Int
- **OverScrollMultiplier** As Int
*The value multiplies the max value when you have scrolled over step by step  
 Default: 1 - Minimum: 1*- **ReachedColor** As Int
*Gets or sets the Reached Color*- **StrokeWidth** As Int
*Gets or sets the Stroke Width*- **Thumb1View** As B4XView [read only]
- **Thumb2View** As B4XView [read only]
- **ThumbBorderColor** As Int
*Gets or sets the Thumb Border Color*- **ThumbIcon1** As B4XBitmap
*Gets or sets the Thumb Icon 1*- **ThumbIcon2** As B4XBitmap
*Gets or sets the Thumb Icon 2*- **ThumbInnerColor** As Int
*Gets or sets the Thumb Inner Color*- **UnreachedColor** As Int
*Gets or sets the Unreached Color*- **Value1** As Int
*Gets or sets the value 1*- **Value2** As Int
*Gets or sets the value 2*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add an icon gap
- The connection between 2 points is now better calculated
- The button that is pressed is moved to the foreground and does not disappear when you hover over the other button
- Removed RollOver Property

- **1.02**

- Add get and set MinValue
- Add get and set MaxValue

- **1.03** [**(read more about this update)**](https://www.b4x.com/android/forum/threads/b4x-xui-as-rangeroundslider.137446/post-870533)

- Add OverScrollMultiplier - The value multiplies the max value when you have scrolled over step by step
- Add get and set CurrentOverScrollMultiplier1 - This value adjusts internally when the "OverScrollMultiplier" is greater than 1

- Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier

- Add get and set CurrentOverScrollMultiplier2 - This value adjusts internally when the "OverScrollMultiplier" is greater than 1

- Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier

- **1.04**

- B4A BugFix

- **1.05**

- BugFix - Value1 and Value2 were connected in the wrong direction
- Add get and set Steps - In how many steps does the slider move

- Default: 1

- Add Designer Property HapticFeedback

- Default: False

- **1.06**

- Add Event TouchDown
- Add Event TouchUp

**Github:** [github.com/StolteX/AS\_RangeRoundSlider](https://github.com/StolteX/AS_RangeRoundSlider)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)