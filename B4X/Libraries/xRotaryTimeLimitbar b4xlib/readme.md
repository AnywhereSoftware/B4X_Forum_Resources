###  xRotaryTimeLimitbar b4xlib by klaus
### 10/23/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/168897/)

The xRotaryTimeLimitbar is a B4X CustomView, it allows the selection of two time values with two sliders from a rotary slider bar.  
It is b4xlib library running on all three platforms.  
  
The xRotaryTimeLimitbar.zip demo project and the xRotaryTimeLimitbar.b4xlib library files are added.  
You must copy the xRotaryTimeLimitbar.b4xlib file into the AdditionalLibraries\B4X folder.  
The recommended AdditionalLibraries folder structure is explained [HERE](https://www.b4x.com/guides/B4XGettingStarted.html#pfa).  
  
Current version: 1.0  
  
![](https://www.b4x.com/android/forum/attachments/167517)  
  
The three times displayed in the inner circle are the start time on top, the end time at the bottom and the time interval in between.  
The three times displayed on top of the from are displayed by code outsides the library on the same layout as the xRotaryTimeLimitbar CustomView.  
Yes, the upper one looks awful, but shows that all colors can be defined either in the Designer or by code.  
The one is loaded by code in the B4J project.  
All internal sizes are calculated automatically in the library.  
  
**xRotaryTimeLimitbar  
  
Author:** Klaus CHRISTL (klaus)  
**Version:** 1.0  

- **xRotaryTimeLimitbar**

- **Events:**

- **TimeChanged** (Times() As String, TimeInterval As String)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddToParent** (Parent As B4XView, Left As Int, Top As Int, Width As Int)
*Add a xRotaryListbar onto a Panel / Pane  
 Parent = Panel / Pane which gets the xRotaryListbar  
 Left, Top and Width = position and width of xRotaryListbar, there is no Height property  
 The xRotaryListbar costum view is a square, therefor no Height property*- **Convert24ToAMPM** (Time As String) As String
*Convert a time string from 24 hours to AM/PM*- **ConvertAMPMTo24** (Time As String) As String
*Convert a time string from AM/PM to 24 hours*- **ConvertAngleToTime** (Angle As Double) As String
*Converts the internal Angle of the slider into a time given by HH:MM  
 Example: -120° returns "08:00" or "08:08 AM" depending on the Mode24Hours property*- **ConvertMinutesToTime** (Minutes As Int) As String
*Converts the number of minutes into a time string  
 Example: it depends on the Mode24Hours proprty  
 900 returns "15:00" or "03:00 PM" depending on the Mode24Hours proprty*- **ConvertTimeToAngle** (Time As String) As Double
*Converts a time given by HH:MM into the internal Angle of the slider  
 Example: "08:00" or "08:08 AM" returns -120°*- **ConvertTimeToMinutes** (Time As String) As Int
*Converts a time given by HH:MM into the number of minutes  
 Examples:  
 "15:00" returns 900  
 "03:00 PM" returns 900*- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String)
- **SetSliderBitmapFileNames** (SliderBeginBitmapFileName As String, SliderEndBitmapFileName As String)
*You can define bitmaps for the sliders*- **SetStartAndEndTimesToFuture**
*Sets the start slider at now and the end slide to now + MinTimeInterval*
- **Properties:**

- **BackgroundColor** As Int
*Sets or gets the BackgroundColor property*- **EarliestEndTime** As String
*Sets or gets the EarliestEndTime property  
 It is the earliest end time, the slider will stop at this time  
 Example: "9:30" or "9:30 PM"*- **EarliestStartTime** As String
*Sets or gets the EarliestStartTime property  
 It is the earliest start time, the slider will stop at this time  
 Example: "07:30" or "07:30 AM"*- **EndTime** As String
*Sets or gets the EndTime property  
 Example: "15:30"*- **LatestEndTime** As String
*Sets or gets the setLatestEndTime property  
 It is the latest end time, the slider will stop at this time  
 Example: "21:30" or "09:30 PM"*- **LatestStartTime** As String
*Sets or gets the LatestStartTime property  
 It is the latest start time, the slider will stop at this time  
 Example: "18:30" 0t "06:30 PM"*- **Left** As Int
*Sets or gets the Left property*- **MaxTimeInterval** As Int
*Sets or gets the MaxTimeInterval property  
 Maximum time interval between the Start and End times, in minutes  
 The End time cannot be higher than the Start time + MaxTimeInterval*- **MinTimeInterval** As Int
*Sets or gets the MinTimeInterval property  
 Minimum time interval between the Start and End times, in minutes  
 The End time cannot be smaller than the Start time + MinTimeInterval*- **MinuteResolution** As Int
*Sets or gets the MinuteResolution property  
 These are the stpes of the Sliders mouvements  
 Valid values are 2, 5, 10, 15, 20, 30*- **Mode24Hours** As Boolean
*Sets or gets the Mode24Hours property  
 True = 24 hours time display  
 False = AM / PM time display*- **NotUsedTimeColor** As Int
*Sets or gets the NotUsedTimeColor property  
 Color of the ring outsides the sliders when the time between the sliders is less than 12 hours*- **OverTimeColor** As Int
*Sets or gets the OverTimeColor property  
 Color of the ring of the overlapping zone between the two sliders when the time between them is higher than 12 hours*- **ScaleBackgroundColor** As Int
*Sets or gets the ScaleBackgroundColor property  
 Color of the inner circle*- **ScaleColor** As Int
*Sets or gets the ScaleColor property  
 Color of the scale and time in the inner circle*- **SliderBeginColor** As Int
*Sets or gets the SliderBeginColor property  
 Color of the begin time slider*- **SliderEndColor** As Int
*Sets or gets the SliderEndColor property  
 Color of the end time slider*- **StartTime** As String
*Sets or gets the StartTime property  
 Example: "07:30"*- **TimeIntervalColor** As Int
*Sets or gets the TimeIntervalColor property  
 Color of the ring between the two sliders*- **Top** As Int
*Sets or gets the Top property*- **Visible** As Boolean
*Sets or gets the Visible property*- **Width** As Int
*Sets or gets the Width property*