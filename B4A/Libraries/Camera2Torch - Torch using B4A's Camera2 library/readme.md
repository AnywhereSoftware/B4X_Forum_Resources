### Camera2Torch - Torch using B4A's Camera2 library by OliverA
### 01/12/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/145413/)

Attached is the class Camera2Torch. It uses B4A's Camera2 library to use Android's CameraManager's setTorchMode method. Please note that this method is only available since API23, whereas CameraManager is available as of API21.  
  
This has been successfully tested (via sideloading, targetSdkVersion="30") on the following:  

- Pixel 7 running Android 13
- Chinese phone running Android 11
- Chinese phone running Android 6

I'm also attaching a bare-bones test application (a B4XPages skeleton app with minimum add-on code to allow turning the rear camera torch on and off).  
  
Note:  
  
With sideloading the app, no additional Manifest entries seem to be required, nor do I need to ask the user for permission to use the camera. I do not know if this changes for apps on Google's Play Store. Various internet posts on the subject of the usage of setTorchMode have the additional Manifest entries  

- AddPermission("android.permission.FLASHLIGHT")
- AddManifestText(<uses-feature android:name="android.hardware.camera.flash" />)

but my testing seems to indicate that they are not necessary (and my test app does not use them).  
  
Android Docs link for setTorchMode:  
<https://developer.android.com/reference/android/hardware/camera2/CameraManager#setTorchMode(java.lang.String,%20boolean)>