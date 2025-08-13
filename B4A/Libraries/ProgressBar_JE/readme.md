### ProgressBar_JE by Jerryk
### 02/20/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/165649/)

New ProgressBar library that displays values (in % or real values). You can choose the direction of the Bar movement. You can set an alarm for a certain value, when the Bar color changes or an event is triggered.  
![](https://www.b4x.com/android/forum/attachments/161774)  
  
**ProgressBar\_JE  
Author: Jerryk  
Version: 1.2  
  
Methods:**  

- **Progress** (Value As Float, realValue As Float)

Displays Bar by value according to Show Value property setting:  
"%" - by Value (1-100),  
"value" - by realValue in real values  

- **SetAlarm1** (state As Boolean, value As Float, color1 As Int, color2 As Int)

Changes color when value is exceeded and triggers event  
state - switch alarm on or off  
value - in %  
color1, color2 - set new gradient color  

- **SetAlarm2** (state As Boolean, realvalue As Float, color1 As Int, color2 As Int)

Changes color when value is exceeded and triggers event  
state - switch alarm on or off  
realvalue - in real value  
color1, color2 - set new gradient color  
  
**Properties:**  

- **Direction** As String

Sets direction of Bar movement: LeftToRight, RightToLeft, UpToDown, DownToUp  

- **BackgroundColor** As Int

Sets Background color  

- **BarColor1, BarColor2** As Int

Sets Bar gradient color  

- **ShowValue** As String

Specifies the type of displayed value:  
"%" - in % (1-100),  
"value" - in real values  
"off" - not display  

- **Prefix** As String

Sets prefix for values  

- **Suffix** As String

Sets suffix for values. Default is "%"  

- **lBase** As Label

For programmatically setting label properties (style, text size, color, gravity, etc.)  
  
**Events:**  

- **Alarm1** (Value as Float)

Triggered when SetAlarm1 is set and value is exceeded.  

- **Alarm2** (realValue as Float)

Triggered when SetAlarm2 is set and value is exceeded.  

- **Click** (Value as Float)

Triggered when is clicked on ProgressBar.  
  
**Changelog:**  

- 1.2 - added Click event