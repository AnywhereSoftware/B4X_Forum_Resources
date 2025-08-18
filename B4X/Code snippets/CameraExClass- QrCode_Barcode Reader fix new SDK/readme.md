###  CameraExClass- QrCode/Barcode Reader fix new SDK by Mike1970
### 06/21/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/141325/)

Hi everyone,  
today I updated all the packages with the SDK Manager.  
After that, the app was crashing on a line about the QrCode reader made using the CameraEx class (there is a tutorial in the forum).   
Reading the logs I found out that now you must have the following line in the manifest to get it working again.  
  

```B4X
AddApplicationText(<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version"/>)
```

  
  
Maybe this can be useful to someone in the future.