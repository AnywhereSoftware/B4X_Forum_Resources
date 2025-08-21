### Using CustomBuildAction to deploy to multiple devices at once by Erel
### 04/19/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/41210/)

This tutorial will demonstrate how you can use CustomBuildAction attribute to deploy to multiple connected devices at once.  
  
The "additional" devices should be connected in USB debug mode. This allows us to call the adb tool, which is part of Android SDK, to install the package and run it on each of the devices.  
  
We will limit this feature to release deployments as debug deployments must run with a device that is actively connected to the IDE.  
  
The first step is to find the IDs of the connected device by running adb devices:  
  
![](http://www.b4x.com/basic4android/images/SS-2014-05-20_14.34.00.png)  
  
In this case we have two devices connected through ADB (one of them is the emulator) and another device connected with B4A-Bridge.  
  
We need to add two build actions for each device. One action will install the APK and the second will run it.  
  
The actions will be added before the installation step (step #4).  
  

```B4X
#If RELEASE  
   'emulator  
   #CustomBuildAction: 4, c:\android-sdk-windows7\platform-tools\adb.exe, -s emulator-5554 install -r 1.apk  
   #CustomBuildAction: 4, c:\android-sdk-windows7\platform-tools\adb.exe, -s emulator-5554 shell am start -a android.intent.action.MAIN -n b4a.example/.main -f 0x10000000 -c android.intent.category.LAUNCHER  
  'device  
   #CustomBuildAction: 4, c:\android-sdk-windows7\platform-tools\adb.exe, -s 04cf0a951c8934fc install -r 1.apk  
   #CustomBuildAction: 4, c:\android-sdk-windows7\platform-tools\adb.exe, -s 04cf0a951c8934fc shell am start -a android.intent.action.MAIN -n b4a.example/.main -f 0x10000000 -c android.intent.category.LAUNCHER  
#End If
```

  
There are four values that you need to update in the above code:  
- full path to adb.exe  
- device serial name after -s parameter  
- The apk file name (here it is 1.apk)  
- The package name (here it is b4a.example)  
  
  
In the device selection dialog we will choose the B4A-Bridge connected device:  
  
![](http://www.b4x.com/basic4android/images/SS-2014-05-20_14.42.51.png)  
  
Now we can easily test the same app on multiple connected devices.