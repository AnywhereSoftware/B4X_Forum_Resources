### [PyBridge] Accessing MTP devices by Erel
### 05/29/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167211/)

![](https://www.b4x.com/android/forum/attachments/164430)  
  
MTP - Media Transfer Protocol, is an important protocol that wasn't accessible from B4J (<https://www.b4x.com/android/forum/threads/copy-file-from-phone-usb-cable-to-desktop-using-b4j-code.164058/post-1006196>).   
It is an important protocol as this is the default USB connection method for Android devices, and the alternative methods to transfer files to a PC are not great.  
This solution is based on: <https://github.com/Heribert17/mtp/tree/main>  
  
Installation instructions:  
1. Unzip mtp.zip.  
2. Create a local Python runtime and click on the "open local Python shell".  
3. Run:  

```B4X
pip install C:\Users\H\Downloads\mtp-main 'change path!
```

  
And:  

```B4X
python -m mtp.create_new_comtype_modules_from_wpd_dlls
```

  
  
Connect an Android device to the PC, with the default file transfer mode. Run the attached example.  
The Python API documentation is included in the zip file.  
  
The main steps:  
1. Find the portable devices:  

```B4X
Dim RemoteDevices As PyWrapper = WinAccess.Run("get_portable_devices")  
Dim DevicesNames As PyWrapper = Py.Map_(Py.Lambda("dev: (dev.name, dev.serialnumber)"), RemoteDevices).ToList  
Wait For (DevicesNames.Fetch) Complete (DevicesNames As PyWrapper)  
Dim devices As List = DevicesNames.Value 'each item is an array of objects (name, serial).
```

  
2. Call get\_content on a remote device to get its "storages".  
3. Call get\_children on a storage or a folder to get the children items.  
  
The example implements a very simple file manager.  
If you know the paths, you can directly access them by calling get\_child or get\_path.