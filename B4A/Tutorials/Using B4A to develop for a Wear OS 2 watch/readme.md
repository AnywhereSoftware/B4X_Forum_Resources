### Using B4A to develop for a Wear OS 2 watch by agraham
### 11/09/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/124348/)

I just got a Skagen Falster 2 watch and logged my first experiences of trying to use B4A to develop aps for it. Here's what I did!  
  
First of all setup the watch with the Wear OS app on a phone. Setup carries over the WiFi settings from phone so don’t need to enter a password, the phone watch should connect itself automatically after setup is complete. To develop with B4A you need to become a developer on the watch.  
 Settings -> System -> About Tap Build Number up to 10 times  
  
Then setup debugging  
 Settings -> Developer Options  
  
 Enable Stay awake while charging and leave on charge while developing to speed up installing apps.  
 Enable Adb debugging.  
 Enable Debug over Wifi – might say unavailable – just wait and come back to it, once set it shows the IP address.  
 Enable Automatically enable WiFi when charging  
  
You can also see the IP address in Setting -> Connectivity -> WiFi and tap on the WiFi access point name which should be showing ‘connected’.  
  
On the PC open a command prompt in SDK platform tools and execute  
 adb connect <watchIPaddress>  
  
You might get an authentication failure message on the computer and there should be a message on the watch to accept the connection, if you scroll down there should be an ‘always from this computer’ option. Tap it and it should be connected though there won’t be a confirmation on the computer. You need to check that the device is connected whenever you use B4A. Check the connection by executing.  
 adb devices  
  
If you now start B4A you can work as normal. You don’t need any special manifest entries, a simple program should just work. Most libraries should work, for example I’ve used the GPS library for a simple GPS location finder, and my ScaleImageView library in conjunction with InputListAsync to make a simple image selector and viewer. ScaleImageView works very well on a watch. Instead of pinch zooming employing double tap and drag up or down zooming is more convenient.  
  
You can usually debug a watch app on a phone which is a lot more convenient than on a watch.  
  
In the Designer  
 Make a layout 390 x 390 scale 2 which is what my watch reports with GetLayoutDeviceValues  
 Set a suitable Activity title, this will only be seen on the desktop  
 Check Full Screen and Uncheck Show Title  
 Comment out AutoscaleAll in the general script  
  
Add the controls but only use Left and Top anchors otherwise on the phone they will stretch across the Activity.  
  
In Main  
 Add #BridgeLogger: True to attributes  
  
As it is a round watch I draw a circle in Activity\_Create after LoadLayout to see how the layout fits.  
195 being 390/2, 2 being the Scale on the watch  
 Dim cv As Canvas   
 Dim r As Int = 195 \* GetDeviceLayoutValues.Scale /2  
 cv.Initialize(Activity)  
 cv.DrawCircle(r, r, r, Colors.Black, False, 3)  
  
Installation to the device will be slow and if not on the charger with ‘stay awake’ set in developer options it may help to keep the watch awake by circling your fingers on the dial until installation is complete and the downloaded app automatically starts.  
  
Remember that you can send apps from the Play Store on the desktop to the watch as long as the watch is connected to the Internet and you are logged into your account on the Play Store on the desktop. This is easier than typing on the watch.  
  
  
My watch is displaying a couple of quirks, yours may or may not. Firstly the launcher seems to occasionally forget my sideloaded apps, though Settings -> App Info knows they are there. Reinstalling seems to be the only way to get it back(EDIT: probably my fault for inadvertently reusing pacakge names). Secondly overnight the watch switches WiFi off automatically to save battery, you can tell by the barred cloud icon on the watch face if it has. I haven’t found a way to persuade it reconnect to my router. It should restart when needed but opening the Play Store app doesn’t seem to. A restart may make it reconnect otherwise it needs a factory reset and setup again. (EDIT: It looks like you can manually reconnect by going to Settings -> Connectivity -> WiFi and tap on the network name under the Wi-Fi slider. I'm thought that I had tried this before several times without success but it seems to work now.)