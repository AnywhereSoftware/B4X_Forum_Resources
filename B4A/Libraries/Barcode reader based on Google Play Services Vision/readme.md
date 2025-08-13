### Barcode reader based on Google Play Services Vision by Erel
### 07/18/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/89705/)

**Better solution: <https://www.b4x.com/android/forum/threads/160725/#content>**  
  
This is not really a library. It is a modification to CameraEx example that adds barcode detection based on Google Play Services Vision. It uses JavaObject to create the detector and detect barcodes in the Preview event.  
  
You should call CreateDetector with the formats you want to detect. Fewer codes will yield faster detections.  
List of formats is available here: <https://developers.google.com/android/reference/com/google/android/gms/vision/barcode/Barcode#constant-summary>  
The implementation is quite simplistic as it is done on the main thread. It works good on Nexus 5X. I haven't tested it on low end devices.  
  
Note that you should add this code to the manifest editor:  

```B4X
<meta-data  
    android:name="com.google.android.gms.vision.DEPENDENCIES"  
    android:value="barcode" />
```