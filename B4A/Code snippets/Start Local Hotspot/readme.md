### Start Local Hotspot by Erel
### 05/31/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/98664/)

Starting from Android 8 there is a public API for starting a local hotspot.  
  
Notes:  
- The hotspot doesn't allow internet connection.  
- The password and SSID are chosen randomly and cannot be changed.  
- Debug it with USB debug mode as it will break B4A-Bridge connection.  
  
![](https://www.b4x.com/basic4android/images/SS-2018-10-26_09.36.57.png)  
  
**Updates:**  
  
- Project was updated with changes required to support Android 13 devices with targetSdkVersion >= 33.  
There is a new NEARBY\_WIFI\_DEVICES permission on Android 13+.   
The location permission is required on Android 12-. See how it is declared in the manifest editor. Do note that if your app needs the location permission for other purposes then remove the snippet that limits the max version of that permission.