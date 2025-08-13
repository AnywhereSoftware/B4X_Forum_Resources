###  Magnetic Field Calculator by John Naylor
### 11/27/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164330/)

Helper class to get various magnetic field information from the web services API of the [British Geological Survey](https://geomag.bgs.ac.uk/).  
  
I needed to get declination, and also vertical, horizontal, North and East intensity readings for various dates and locations around the world and the above site has a great API to give me that info.  
  
I have (taken a liberty and) modified the excellent GNSS demo [here](https://www.b4x.com/android/forum/threads/gnss-library-an-updated-gps-library.109110/#content) to display info from the class (plus bearing and distance calculations that I left in from other experiments). It displays your current location and declination plus logs intensity readings. Declination is recalculated every 15 minutes if you have moved more than 5km from the last check.  
  
The class is in the demo code.  
The class itself is cross platform but the demo is B4A only  
The default is to use the free modal (WMM) but the class is built to be able to use other subscription models. See the BGS site for more information.