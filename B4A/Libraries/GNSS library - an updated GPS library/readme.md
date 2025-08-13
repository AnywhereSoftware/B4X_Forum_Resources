### GNSS library - an updated GPS library by agraham
### 09/15/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/109110/)

The GNSSS library is an updated GPS library that allows you to get information about visible satellites from the phone's GNSSS device using an enhancement introduced in Android API version 24.  
  
The GNSS receivers in devices will vary in which constellations that they will recognize depending on when they were designed. Devices from 2019 and later will probably recognise all four of the GPS, GALILEO, GLONASS and BEIDOU constellations. Android devices, if capable, will report location information using all available constellations. However only limited satellite information is available in the original GpsStatus event.  
  
To access additional data on the satellites a new GnssStatus event is available in Android API 24 and later. This library exposes that event. The library can be used without problem on earlier devices but on these the GnssStatus event will never be raised. The GnssStatus event passes a single GnssStatus object as its only parameter which contains information for the visible satellites of all the constellations available.  
  
This library is a strict superset of the original GPS library and can be used as a drop-in replacement for the GPS library merely by deselecting the GPS library, selecting the GNSS library and changing the GPS type to GNSS in the code.  
  
In fact, as I found when I was playing with this library on my latest device, which can see four GNSS constellations, the new GnssStatus data is not really necessary to identify the constellation to which a satellite belongs (which was the original reason for me to implement the GnssStatus event) and so is only useful if you need the other additional information it provides.  
  
It seems that the GPSSatellite list returned by the GpsStatus event in the existing GPS library contains every satellite visible to the device with the Prn adjusted to avoid duplication by adding a constant value depending upon which constellation the satellite belongs to. I found this by inspection and have not seen this documented anywhere.  
  
The base values for each constellation are as returned by GnssStatus.Svid(). GPS PRNs are unadjusted and are in the range 1 to 32. Glonass FCNs/OSNs have 64 added and are in the range 65 to 88 or possibly 157 to 172. Beidou PRNs have 200 added and are in the range 201 to 237. Galileo PRNs have 300 added and are in the range 301 to 326. The included demo illustrates this.  
  
**If your app targets SDK 31 or later and has a GpsStatus event Sub in your code you may get an 'UnsupportedOperationException: GpsStatus APIs not supported, please use GnssStatus APIs instead' error when running your app. The GpsStatus class was deprecated in API level 24 and Google is now enforcing the deprecation. This applies to the original GPS library and to this one. You will need to use this library and its GnssStatus event instead. All the same information, and more, is available from the GnssStatus event as was available in the GpsStatus event.**