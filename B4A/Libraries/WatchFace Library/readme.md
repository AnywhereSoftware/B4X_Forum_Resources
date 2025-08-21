### WatchFace Library by corwin42
### 03/05/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/74228/)

With this library you can create WatchFaces for Android Wear devices with B4A.  
  
![](https://www.b4x.com/android/forum/attachments/51047)![](https://www.b4x.com/android/forum/attachments/51427)  
  
The example watchface should work well on round and square displays with or without "flat tire".  
  
To use this library you should be familiar with creating wear apps with B4A. It will also help if you read the complete android developer documentation for watch faces.  
  
Installation:  
Copy all files from the WatchFaceLibX\_X.zip file to your additional libraries folder (.xml, .jar, .aar)  
You need to install the Support Repository and Google Repository from SDK Manager.  
  
The dependencies are removed from the library in the latest version, since they don't work anymore.  
  
Add the following dependencies to your watchface source code:  
  

```B4X
#AdditionalJar: androidx.wear:wear  
#AdditionalJar: wearable-2.5.0.aar  
#AdditionalJar: com.google.android.wearable:wearable, ReferenceOnly  
#AdditionalJar: com.android.support:support-v4, ReferenceOnly  
#AdditionalJar: com.android.support:percent, ReferenceOnly  
#AdditionalJar: com.android.support:support-annotations, ReferenceOnly  
#AdditionalJar: com.android.support:recyclerview-v7, ReferenceOnly
```

  
  
Documentation:  
[SPOILER="Documentation"]  
**WatchFace  
Author:** Markus Stipp  
**Version:** 1  

- **WFEngine**
Fields:

- **AMBIENT\_PEEK\_MODE\_HIDDEN As Int**
- **AMBIENT\_PEEK\_MODE\_VISIBLE As Int**
- **BACKGROUND\_VISIBILITY\_INTERRUPTIVE As Int**
- **BACKGROUND\_VISIBILITY\_PERSISTENT As Int**
- **PEEK\_MODE\_NONE As Int**
- **PEEK\_MODE\_SHORT As Int**
- **PEEK\_MODE\_VARIABLE As Int**
- **PEEK\_OPACITY\_MODE\_OPAQUE As Int**
- **PEEK\_OPACITY\_MODE\_TRANSLUCENT As Int**
- **PROTECT\_HOTWORD\_INDICATOR As Int**
- **PROTECT\_STATUS\_BAR As Int**
- **PROTECT\_WHOLE\_SCREEN As Int**
- **TAPTYPE\_TAP As Int**
- **TAPTYPE\_TOUCH As Int**
- **TAPTYPE\_TOUCH\_CANCEL As Int**

- **Methods:**

- **ChinSize As Int**
*Returns the chin size (flat tire size) of a round watch like the Moto360.*- **SetWatchFaceStyle**
*Updates WatchFace style.  
  
Uses the following properties:  
  
AcceptsTapEvents  
AmbientPeekMode  
BackgroundVisiblility  
CardPeekMode  
HideHotwordIndicator  
HideStatusBar  
StatusBarGravity  
HotworkIndicatorGravity  
ShowSystemUiTime  
PeekOpacityMode  
ShowUnreadCountIndicator  
 ViewProtectionMode*
- **Properties:**

- **AcceptsTapEvents As Boolean**
*Sets whether this watchface accepts tap events. The default is false.  
Setting this to true enables the TapCommand event.  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **AmbientPeekMode As Int**
*Sets how the first, peeking card will be displayed while the watch is in ambient, black and white mode.  
  
Must be either AMBIENT\_PEEK\_MODE\_VISIBLE or AMBIENT\_PEEK\_MODE\_HIDDEN  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **BackgroundVisibility As Int**
*Set how to display background of the first, peeking card.  
  
Must be either BACKGROUND\_VISIBILITY\_INTERRUPTIVE or BACKGROUND\_VISIBILITY\_PERSISTENT  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **BurnInProtection As Boolean** *[read only]*
Returns if the device needs burn in protections. On such devices don't create
big white backgrounds.- **CardPeekMode As Int**
*Sets how far into the screen the first card will peek while the watch face is displayed.  
  
Must be either PEEK\_MODE\_VARIABLE or PEEK\_MODE\_SHORT  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **Height As Int** *[read only]*
Returns the Height of the screen- **HideHotwordIndicator As Boolean**
*Hides the hotword indicator.  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **HideStatusBar As Boolean**
*Hides the status icons (battery state, lack of connection etc.)  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **HotwordIndicatorGravity As Int**
*Sets position of hotword (OK Google) on the screen.  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **IsAmbientMode As Boolean** *[read only]*
Returns if the watchface is in ambient mode.- **IsRound As Boolean** *[read only]*
Returns true if the device has a round display.- **IsVislible As Boolean** *[read only]*
Returns if the watchface is visible.- **LowBitAmbient As Boolean** *[read only]*
Returns if the device has reduced colors in ambient mode. Disable antialias of your
drawings to reduce CPU usage.- **MuteMode As Boolean** *[read only]*
Returns if the device is muted.- **NotificationCount As Int** *[read only]*
Returns the total number of Notification cards.- **OuterBounds As RectWrapper** *[read only]*
Returns a Rect object that has the complete screen size without any insets etc.- **PeekCardBounds As RectWrapper** *[read only]*
Returns a Rect object for the first PeekCard Bounds.- **PeekOpacityMode As Int**
*Sets whether the first, peeking card should be opaque when the watch face is displayed.  
  
Must be either PEEK\_OPACITY\_MODE\_OPAQUE or PEEK\_OPACITY\_MODE\_TRANSLUCENT  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **ShowSystemUiTime As Boolean**
*Sets if the system will draw the system-style time over the watch face.  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **ShowUnreadCountIndicator As Boolean**
*Sets whether to add an indicator of how many unread cards there are in the stream.  
The indicator will be displayed next to status icons (battery state, lack of connection).  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **StatusBarGravity As Int**
*Sets position of status icons (battery state, lack of connection) on the screen.  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **Tag As Object**
*Property to store any information in the engine.*- **UnreadCount As Int** *[read only]*
Returns the number of unread Notification cards.- **ViewProtectionMode As Int**
*Adds background color to UI elements of the home screen, so they are readable on the watch face. This should be used if the watch face color is close to being white.  
  
Must be any combination of PROTECT\_STATUS\_BAR, PROTECT\_HOTWORD\_INDICATOR and PROTECT\_WHOLE\_SCREEN  
  
 This property changes not immediately but only when SetWatchFaceStyle() is called!*- **Width As Int** *[read only]*
Returns the Width of the screen
- **WFManager**
Events:

- **AmbientModeChanged** (Engine as WFEngine As , AmbientMode as Boolean As )
- **Created** (Engine As WFEngine)
- **Draw** (Engine as WFEngine As , Canvas as Canvas As , Bounds as Rect As )
- **EngineDestroyed** (Engine As WFEngine)
- **SizeChanged** (Engine As WFEngine, Width as Int As , Height as Int As )
- **TapCommand** (Engine as WFEngine As , TapType As Int, XPos as Int As , YPos as Int As , EventTime as Long As )
- **VisibilityChanged** (Engine As WFEngine, Visible As Boolean)

- **Methods:**

- **Initialize** (EventName As String, IntervalMs As Int)
*Initialize the WatchFaceManager object.  
  
EventName: The name prefix for the events  
 IntervalMs: Timer interval in milliseconds. This will setup a timer which will call the Draw event so the WatchFace gets updated. This timer will fire only in interactive mode and when the WatchFace is visible.*- **InvalidateEngine**
*Invalidate the Engine. This will cause a redraw of the WatchFace.*- **IsInitialized As Boolean**
*Check if the manager is initialized*
- **Permissions:**

- android.permission.WAKE\_LOCK

- **Properties:**

- **Interval As Int**
*Set or get the timer interval. The timer fires only in interactive mode.  
 In ambient mode a refresh is done every minute.*- **WFEngine As WFEngine** *[read only]*
Returns the WatchFace engine. This may be null if the WatchFace engine is not fully initialized yet.
[/SPOILER]  
  
Examples:  
There is an example provided which implements an analog clock and a digital clock watchface.  
  
The WatchFaceWear app is the watchface implementation for the wear device. If you have a device with USB port you can directly deploy this app on the device with B4A. If not then you have to create a companion app which is provided with the WatchFaceMobile app. To create the WatchFaceMobile app copy the generated WatchFaceWear.apk to the resouce/raw folder and name it "watchfacewear.apk" (all lower case). Then compile and deploy to your mobile phone.  
The WatchFaces should show up in the wear app and directly on the wear device.  
  
The example requires the ABExtDrawing library.  
  
History:  
V0.1  

- initial release

V0.2  

- more complete implementation

V1.0  

- First official release

V2.0  

- Should work with AndroidX

**Since the library is too large now you can download it here:**  
[WatchfaceLib2\_0.zip](https://www.b4x.com/android/files/WatchfaceLib2_0.zip)