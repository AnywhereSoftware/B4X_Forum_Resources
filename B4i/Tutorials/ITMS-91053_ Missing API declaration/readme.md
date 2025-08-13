### ITMS-91053: Missing API declaration by Erel
### 03/28/2024
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/160147/)

There are certain APIs in iOS that can potentially be used to "fingerprint" the device -> find unique characteristics of the device that can possibly be used as identifiers.  
Starting from May 1, 2024 developers must explain the usage of such APIs. It is not exactly clear how Apple detects and decides which APIs are problematic however when we submit the app to the app store it is being scanned and we might receive an email with the list of categories that need to be explained.  
  
The explanation is done by adding a file named **PrivacyInfo.xcprivacy** to <project>\Files\Special. The file content depends on the categories that should be explained.  
It is a "plist" file with an array of dictionaries (maps), each dictionary explains a single category.  
A dictionary for example:  

```B4X
 <dict>  
   <key>NSPrivacyAccessedAPIType</key>  
   <string>NSPrivacyAccessedAPICategoryFileTimestamp</string>  
   <key>NSPrivacyAccessedAPITypeReasons</key>  
   <array>  
    <string>C617.1</string>  
   </array>  
  </dict>
```

  
The category is *NSPrivacyAccessedAPICategoryFileTimestamp* and the reason code is *C617.1*. The various codes are listed here: <https://developer.apple.com/documentation/bundleresources/privacy_manifest_files/describing_use_of_required_reason_api?language=objc>  
  
Example of a PrivacyInfo.xcprivacy file with explanations for *NSPrivacyAccessedAPICategoryFileTimestamp* and *NSPrivacyAccessedAPICategoryUserDefaults:*  

```B4X
<?xml version="1.0" encoding="UTF-8"?>  
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">  
<plist version="1.0">  
<dict>  
 <key>NSPrivacyAccessedAPITypes</key>  
 <array>  
  <dict>  
   <key>NSPrivacyAccessedAPIType</key>  
   <string>NSPrivacyAccessedAPICategoryFileTimestamp</string>  
   <key>NSPrivacyAccessedAPITypeReasons</key>  
   <array>  
    <string>C617.1</string>  
   </array>  
  </dict>  
  <dict>  
   <key>NSPrivacyAccessedAPIType</key>  
   <string>NSPrivacyAccessedAPICategoryUserDefaults</string>  
   <key>NSPrivacyAccessedAPITypeReasons</key>  
   <array>  
    <string>CA92.1</string>  
   </array>  
  </dict>  
 </array>  
</dict>  
</plist>
```

  
  
The file should then be added to Files\Special and we need to submit a new build.  
  
![](https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Fingerprint_picture.svg/165px-Fingerprint_picture.svg.png)