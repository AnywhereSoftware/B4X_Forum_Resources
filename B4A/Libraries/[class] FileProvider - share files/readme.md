### [class] FileProvider - share files by Erel
### 08/16/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/97865/)

**Edit: FileProvider is included as an internal library now.**  
After investigating several issues with the current FileProvider code that you can find in the forum, I decided to make some improvements and implement it in a class.  
  
Starting from Android 7 (API 24) you cannot directly share file uris with other applications. You need to use FileProvider.  
  
The FileProvider class should work on all Android versions (4+).  
  
Instructions:  
  
1. Add a reference to FileProvider library.  
  
2. Add to the manifest editor:  

```B4X
AddManifestText(<uses-permission  
   android:name="android.permission.WRITE_EXTERNAL_STORAGE"  
   android:maxSdkVersion="18" />  
)  
  
AddApplicationText(  
  <provider  
  android:name="android.support.v4.content.FileProvider"  
  android:authorities="$PACKAGE$.provider"  
  android:exported="false"  
  android:grantUriPermissions="true">  
  <meta-data  
  android:name="android.support.FILE_PROVIDER_PATHS"  
  android:resource="@xml/provider_paths"/>  
  </provider>  
)  
CreateResource(xml, provider_paths,  
   <files-path name="name" path="shared" />  
)
```

  
files-path = File.DirInternal  
  
![](https://www.b4x.com/basic4android/images/SS-2018-10-03_15.03.31.png)  
  
Current version: 1.00