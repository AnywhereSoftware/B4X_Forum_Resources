### ExternalStorage - Access SD cards and USB sticks by Erel
### 11/11/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/90238/)

![](https://www.b4x.com/basic4android/images/SS-2018-03-05_11.16.42.png)  
  
Before we start:  

1. External storage means a real sd card or a connected mass storage USB device.
2. This class can also be used to access the secondary storage (File.DirRootExternal). This becomes relevant with newer versions of Android that restrict direct access.
3. It has nothing to do with runtime permissions.
4. You can use RuntimePermissions.GetAllSafeDirsExternal to directly access a specific folder on the SD card.
5. You can use RuntimePermissions.GetSafeDirDefaultExternal to directly access a specific folder on the secondary storage.
6. The minimum version for this class is Android 5.

  
Starting from Android 4.4 it is no longer possible to directly access external storages.  
The only way to access these storages is through the Storage Access Framework (SAF), which is a quite complex and under-documented framework.  
  
The ExternalStorage class makes it simpler to work with SAF.  
  
Usage:  
  
1. Call ExternalStorage.SelectDir. This will open a dialog that will allow the user to select the root folder. Once selected the uri of the root folder is stored and can be later used without requiring the user to select the folder again. Even after the device is booted.  
  
2. Wait For the ExternalFolderAvailable event.  
Now you can access the files under Storage.Root, including inside subfolders.  
  
3. Files are represented as a custom type named ExternalFile.  
  
4. The following operations are supported: ListFiles, Delete, CreateNewFile, FindFile, OpenInputStream and OpenOutputStream.  
  
See the attached example.  
  
Depends on: ContentResolver and JavaObject libraries.  
Add:  

```B4X
#AdditionalJar: com.android.support:support-core-utils
```

  
  
**Updates**  
  
- V1.04: Packed as a b4xlib. New PreviousUriFileName field that can be used if you need multiple instances of ExternalStorages. This field defines the file where the URI will be written to for future uses.  
- V1.03: New CreateDir and FindOrCreateDir subs. Thank you [USER=12309]@ac9ts[/USER] and [USER=42649]@DonManfred[/USER].  
- V1.02: Fix for issue related to the conversion of URIs to strings.  
- V1.01: Fixes an issue with Storage.ListFiles. Credit goes to [USER=448]@agraham[/USER] !