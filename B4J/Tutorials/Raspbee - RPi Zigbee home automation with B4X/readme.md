### Raspbee - RPi Zigbee home automation with B4X by walt61
### 09/11/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/107784/)

**Introduction:**  
The Raspbee (or Conbee, which is the USB version - the information here will only refer to the Raspbee) from Dresden Elektronik (<https://shop.dresden-elektronik.de/raspbee.html>, also available elsewhere, e.g. on Amazon) is a Zigbee (<https://www.zigbee.org/>) radio board for the Raspberry Pi.  
  
Zigbee is a communications protocol that is well-known for its use with home automation. By using the Raspbee module, the Raspberry Pi becomes a node that can be integrated in a Zigbee network - or used as the sole controller for such a network. For instance, Philips Hue and Ikea Tradfri products use the Zigbee standard and can be controlled from the Raspberry Pi with the Raspbee extension.  
  
With the B4X class I developed you'll be able to let your programs interface with the Raspbee.  
  
**Requirements/preparations:**  
When ordering a Raspbee, make sure you select the 'premium' version, which comes with the required firmware loaded.  
  
'deCONZ' is the software that interfaces with the Raspbee and that runs on the Raspberry Pi. It is important to realise that Dresden Elektronik only supports Raspbian; use any other distro and you're on your own if Murphy strikes.  
  
If your Linux knowledge goes beyond the basics (mine doesn't), you'll probably be able to get things working on other distros too.  
  
They have a preinstalled image available (<https://phoscon.de/en/conbee2/sdcard>) for download which works out of the box. I used the 'stable' image, not one of the beta versions, on an RPi2.  
  
Make sure your power supply produces 2.5A or more; anything less might not work properly (or not at all).  
  
After booting the image, do this as well (e.g. from a putty window - <https://www.putty.org/>) to enable headless usage:  
- sudo systemctl enable deconz  
- sudo systemctl start deconz  
  
Last but not least, you may want to use Real VNC viewer (<https://www.realvnc.com/en/connect/download/viewer/> - or another VNC viewer) to connect from a Windows PC to the RPi's graphic desktop, where deCONZ will be running.  
  
**Getting started:**  
1. In the deCONZ UI (which you'll reach via VNC), you'll see your Raspbee and nothing else. Click the 'Plugins' menu, and then 'REST API Plugin'. Then, in the window that pops up, click one of the hyperlinks to be taken to the browser interface.  
2. Click your Raspbee's icon, and enter a name and a password. You'll use the name to obtain an API key (see below).  
3. Use the browser interface to add your light bulbs, plugs, or other devices to your Zigbee network. When adding devices, you'll provide a name for each of them.  
4. Obtain an API key (see method 'GetAPIkey' in the class) as you'll need that to initialise this class, for communication with deCONZ.  
  
Now you're ready to use the class in your B4X programs to interface with your Zigbee network and to control your devices, e.g. switch lights or plugs on and off, and get their current state (as Zigbee provides two-way communication).  
  
The (limited) demo programs will give you an idea about how to use the class, and so should the documentation that was added to all its methods.  
  
Enjoy!  
  
**Updates:**  
  
 2019-08-31  
- added 'link' and 'code' tags to the Subs' descriptions  
  
 2019-12-18  
- added 'websocketnotifyall' and 'websocketport' to Type rbgw\_config and filled them in 'GetConfig'  
  
 2020-08-23  
- GetAllLights and GetLightState now make sure that 'value.state.xy' will always be initialized  
  
 2020-09-10  
- Added parameter 'debugMode' to method Initialize  
- Added methods GetAllSensorsLumiWeather and GetSensorLumiWeather  
- Updated the comments for methods GetAllSensors and GetSensor  
- Added members ctmin and ctmax to Type rbgw\_light  
- Added members onAndReachable, colorloopspeed, and transitiontime to Type rbgw\_light\_state  
- Added private methods IsUnsignedInteger and IsUnsignedDecimal  
- Method SetLightState now takes care of type testing/changing for the values it's given  
- Integer values returned by the 'Get…' methods now default to -1 instead of 0 (e.g. to indicate when 'hue' is not available for white bulbs)