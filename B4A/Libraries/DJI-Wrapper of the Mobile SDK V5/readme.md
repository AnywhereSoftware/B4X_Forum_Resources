### DJI-Wrapper of the Mobile SDK V5 by schimanski
### 01/19/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/165173/)

Some time ago I had contact with Biswajit. He kindly developed a wrapper for DJI SDK version 5. In addition to the DJI Mini 3, this wrapper also supports the enterprise versions of the DJI Mavic 3. Unfortunately, I have not yet had time to create a more extensive example program. For this reason, I provide the wrapper here. Maybe there is one or the other who has the time and the desire to create and post an example. Thanks again to Biswajit for the excellent support.  
  
Here is the documentation of DJI SDK V5:  
  
<https://sdk-forum.dji.net/hc/en-us/categories/5050636444057-Mobile-SDK-v5-8-0>  
  
The small example shows, how the wrapper and the new SDK of DJI works. It is completely different from the previous version.  
On startup, this app will,  
  

1. Request for permission.
2. Once all permission is accepted, it will initialize the DJI SDK
3. Once initialization is done, it will register and connect the app to DJI server (update the DJI API key in the manifest)
4. Once registered it will start listening for,

1. **FlightController Connection:** On event it will fetch the product firmware version
2. **Product Connection:** On event it will print the value
3. **Product Type Change:** On event it will print the value
4. **Area Code Change:** On event it will print the value
5. **Device Status:** On event it will print the value

  
The project has an example of how can listen for some event change, and fetch the value of a specific key. You have to check the documentation to know which key you should to use for which purpose.  
  
Check this link for all available keys: <https://developer.dji.com/api-reference-v5/android-api/Components/IKeyManager/DJIKey.html>