###  [XUI] AS Clock - Analog Clock or Digital by Alexander Stolte
### 01/16/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/137551/)

Thanks to [USER=74323]@wonder[/USER] for his nice "[Analog Clock with Sound](https://www.b4x.com/android/forum/threads/analog-clock-with-sound.52532/#content)", this safes me a lot of time.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/124098)![](https://www.b4x.com/android/forum/attachments/124099)![](https://www.b4x.com/android/forum/attachments/124100)![](https://www.b4x.com/android/forum/attachments/124101)![](https://www.b4x.com/android/forum/attachments/124102)![](https://www.b4x.com/android/forum/attachments/127419)  
<https://www.b4x.com/android/forum/threads/b4x-as-rangeslider-as-clock-sleep-schedule-picker.137578/>  
**ASClock  
Author: Alexander Stolte  
Version: 1.01**  

- **ASClock**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **CreateASClock\_MiddleTextProperties** (TextColor As Int, xFont As B4XFont) As ASClock\_MiddleTextProperties
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Draw** As String
- **getCornerColor** As Int
- **getCornerWidth** As Float
- **getInnerColor** As Int
- **getMiddleText** As String
- **getMiddleTextProperties** As ASClock\_MiddleTextProperties
- **getShowDialText** As Boolean
- **getShowHourMark** As Boolean
- **getShowMinutesMark** As Boolean
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setCornerColor** (Color As Int) As String
- **setCornerWidth** (CornerWidth As Float) As String
- **setInnerColor** (Color As Int) As String
- **setMiddleText** (Text As String) As String
- **setShowDialText** (Show As Boolean) As String
- **setShowHourMark** (Show As Boolean) As String
- **setShowMinutesMark** (Show As Boolean) As String
- **SetTime** (Hour As Int, Mins As Int, Secs As Int) As String

- **Properties:**

- **CornerColor** As Int
- **CornerWidth** As Float
- **InnerColor** As Int
- **MiddleText** As String
- **MiddleTextProperties** As ASClock\_MiddleTextProperties [read only]
- **ShowDialText** As Boolean
- **ShowHourMark** As Boolean
- **ShowMinutesMark** As Boolean

- **ASClock\_MiddleTextProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add get and set ScaleColor
- Add get and set SweepHands

- **1.02**

- Add Designer Property ClockMode - 12 and 24

- Default: 12
- If 24 then the clock displays 1-24
- If 12 then the clock displays 1-12

- **1.03 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-clock-analog-clock-or-digital.137551/post-971852)**)**

- Add SleepDuration to ClockMode

**Github:** [github.com/StolteX/AS\_Clock](https://github.com/StolteX/AS_Clock)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)