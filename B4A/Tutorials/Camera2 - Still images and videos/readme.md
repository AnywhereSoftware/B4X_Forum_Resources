### Camera2 - Still images and videos by Erel
### 12/29/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/83920/)

[Camera2 library](https://www.b4x.com/android/forum/threads/camera2-new-camera-library.83855/) is based on the Camera2 API introduced in Android 5 (API 21).  
It is designed to work together with CamEx2 class.  
It is supported by B4A v7.3+. The library will be included as an internal library in the next update.  
  
Both image capturing and video recording are supported.  
CamEx2 class is built to be extended. Camera2 native API is huge.  
  
![](https://www.b4x.com/basic4android/images/SS-2017-09-14_17.27.38.png)  
  
The configuration steps:  
  
1. Open the camera when the activity is resumed.  
2. Prepare the surface and start preview. The preview size and capture size are set at this point.  
3. Stop the camera when the activity is paused.  
  
Take pictures with FocusAndTakePicture or TakePictureNow.  
  
Video capturing is done by calling StartVideoRecording and StopVideoRecording.  
The surface needs to be recreated after the video is recorded.  
  
**TaskIndex**  
  
When you open the camera you receive a number called TaskIndex:  

```B4X
Wait For (cam.OpenCamera(front)) Complete (TaskIndex As Int)  
If TaskIndex > 0 Then  
   MyTaskIndex = TaskIndex 'hold this index. It will be required in later calls.  
   Wait For(PrepareSurface) Complete (Success As Boolean)  
End If
```

  
If the value of TaskIndex is 0 then the camera failed to open. Otherwise you need to store it in a global variable and pass it to other camera methods.  
  
The camera can be stopped or reopened while other asynchronous tasks are running. The task index is used to cancel running tasks in such cases.  
  
**Notes & tips**  
  
- The RECORD\_AUDIO is not added automatically as it is only required when recording video. In such case you need to add it with the manifest editor:  

```B4X
AddPermission(android.permission.RECORD_AUDIO)
```

  
  
CamEx2 class is is included in the attached example.  
It depends on Camera2 v1.10+.  
  
**Change log**  
  
- V1.32 - Fixes an issue with inconsistent return value from TakePictureNow.  
- V1.31 - Changes the behavior of PreviewCropRegion to affect the captured image as well (previously it was inconsistent).  
- V1.30 - Fixes an issue with video orientation.  
- V1.20  

- Example updated and targetSdkVersion is set to 26. Permissions are handled at runtime.
- Digital zoom feature. Note that it only affects the preview.
- Fixed typo in getSupportedVideoSizes method.

  
**New example:**  

- Based on B4XPages (there are instructions inside if you want to use it in an Activity module).
- Preview image is not stretched.
- Captured image is shown with the correct orientation.