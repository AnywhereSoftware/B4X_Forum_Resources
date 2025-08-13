### B4R Change Log (version history) by Erel
### 09/05/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/68742/)

**v4.00** - September 5, 2023: <https://www.b4x.com/android/forum/threads/b4r-v4-00-is-available-for-download.150115/>  

- This update adds support for the latest version of Arduino IDE.
- It is also the first 64 bit version of B4R.

**v3.90** - August 12, 2021: <https://www.b4x.com/android/forum/threads/b4r-v3-90-is-available-for-download.133371/>  
  
This update adds some of the recent features introduced in the other tools.  

- IDE performance improvements.
- IIf (Inline If) and As (inline casting). Note that in B4R it is recommended to explicitly set the the type when using IIf as it is more efficient:

```B4X
Dim x As Int = IIf(y > 10, 17, 7).As(Int)
```

- Bug fixes, including the issue with the latest version of ESP8266 SDK, and other minor improvements.

  
**v3.70** - March 1, 2021: <https://www.b4x.com/android/forum/threads/b4r-v3-70-is-available-for-download.127991>  
  

- This update adds support for the new library index: <https://www.b4x.com/android/forum/threads/b4x-libraries-index.127418/#content>
![](https://www.b4x.com/android/forum/attachments/108641)- It also fixes a few bugs.

  
**v3.50** - November 10, 2020: <https://www.b4x.com/android/forum/threads/b4r-v3-50-is-available-for-download.124143/>  
  

- Support for b4xlibs: <https://www.b4x.com/android/forum/threads/new-feature-b4x-lib-a-new-type-of-library.100383/#content>
The purpose is not to share libraries with other B4X tools (it will not work), it is to allow creating reusable libraries from B4R code.- rHttpUtils and rGlobalStore are included as internal b4xlibs.
- Support for project templates:
As with the other B4X tools, it is simple to create custom templates.- Comment links (<https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/>). For example:

```B4X
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src
```

- New "contribute" button:
- Fix for the copy logs issue.
- Other minor improvements and bug fixes.

  
**v3.31** - March 17, 2020: <https://www.b4x.com/android/forum/threads/b4r-v3-31-is-available-for-download.115062/>  
  
This update includes a modification to rCore that is required to support Arduino IDE v1.8.11+.  
Note that it will not work with older versions of Arduino IDE.  
  
**v3.30** - February 2, 2020: <https://www.b4x.com/android/forum/threads/b4r-v3-30-is-available-for-download.113598/#post-708865>  
  
This update includes the many improvements done recently in B4X IDE.  

- Find all references, quick search and find subs / modules tool windows were rewritten and are now syntax colored, the text is selectable and you can jump directly to the selected position.
- Subs code appears in the quick info windows.
This code is also selectable and clickable.- Show Sub in window.
Allows showing subs in a floating windows. The text is selectable and clickable.- Positions and layouts of all windows are preserved.
- Search results font can be configured from Tools - IDE Options - Font Picker.
- IDE shows available updates.
- Better handling of errors in the IDE.
- Warning and errors do not hide other information.
- Copy warnings from list of warnings.
- Copy events.
- Modules list is saved in lexicographic order to avoid unexpected changes with source control tools.
- Fix for issue with board arguments that include spaces.
- Other minor improvements and bug fixes.

  
  
**v3.00** - October 22, 2019: <https://www.b4x.com/android/forum/threads/b4r-v3-00-is-available-for-download.110718/>  
  
This update adds support for ESP32 SDK v1.03 and also includes improvements to the boards selector, IDE improvements and updated MQTT library.  
  
Note that if you are using ESP32 then you must update to v1.03. This is done with Arduino IDE - Tools - Boards - Boards Manager.  
  
**v2.80** - June 23, 2019: <https://www.b4x.com/android/forum/threads/b4r-v2-80-is-available-for-download.106986/>  
  
This update adds support for the latest versions of ESP8266 (v2.5.2) and ESP32 (v1.0.2) SDKs.  
  
It also includes the IDE improvements added to the other B4X products (auto bookmarks, auto backup improvements and others).  
  
Make sure to update the SDKs from the Arduino IDE (Tools - Boards Manager). Older versions of ESP8266 and ESP32 will not work with this version.  
  
**v2.60** - April 17, 2019: <https://www.b4x.com/android/forum/threads/b4r-v2-60-is-available-for-download.104972/>  

- B4R is now based on the latest version of the IDE. It includes auto backups, bookmarks improvements, warning improvements and bug fixes. The list of boards is now sorted in the boards manager.

  
Note that ESP8266 SDK v2.4.2 is still required when targeting ESP8266 boards.  
  
**v2.51** - June 3, 2018: <https://www.b4x.com/android/forum/threads/b4r-v2-51-is-available-for-download.93666/>  
  
This update includes all the IDE improvements that were added to the other B4X products including the ability to easily share modules between projects.  

- IDE improvements.
- ByteConverter.ObjectSet - Allows setting a global object. Especially useful with arrays of objects.
- Bug fixes.

  
**v2.20** - July 20, 2017: <https://www.b4x.com/android/forum/threads/b4r-v2-20-is-available-for-download.81878/>  
  

- The IDE is localizable.
- SD.Remove / Exist supported by ESP8266.

  
**v2.00 -** June 21, 2017: <https://www.b4x.com/android/forum/threads/b4r-v2-00-is-available-for-download.80895/>  
  
New features and improvements:  

- Support for the latest ESP32 SDK (<https://github.com/espressif/arduino-esp32/blob/master/doc/windows.md>)
- Compilation and deployments logs are printed in the IDE logs.
- #DefineExtra attribute - Allows to add custom define commands to the main defines file.
- AsyncStreams supports prefix mode. AsyncStreams in prefix mode + B4RSerializator is the recommended method for low level communication: <https://www.b4x.com/android/forum/threads/72404/#content>
- ESP8266WiFi.Connect - Timeouts after 15 seconds if there is no connection.
- IDE improvements - Refactoring, replace from quick search and others.

The ESP32 SDK is more mature. Communication works perfectly.  
  
**v1.80** - January 26, 2017: <https://www.b4x.com/android/forum/threads/b4r-v1-80-is-available-for-download.75629/>  
  
New features and improvements:  

- Support for Arduino IDE 1.8.0 (<https://www.arduino.cc/en/Main/Software>).
- Initial support for ESP32: <https://www.b4x.com/android/forum/threads/initial-support-for-esp32.75002/>
- Auto-formatting feature as in the other B4X IDEs.
- WiFiSSLSocket (ESP8266) - Similar to WiFiSocket for SSL connections.
- AsyncStream.MaxBufferSize field. Allows changing the size limit of the internal buffer. Note that #StackBufferSize must be large enough to hold the data. The default value is 100.
- Other minor improvements.

  
Arduino 1.8.0+ is required.  
  
  
**v1.50 -** November 6, 2016: <https://www.b4x.com/android/forum/threads/b4r-v1-50-is-available-for-download.72758/>  
  
This update includes the IDE improvements included in the latest versions of B4A and B4i (<https://www.b4x.com/android/forum/threads/b4a-v6-30-has-been-released.71212/#content>).  
  
It also adds an important new type named B4RSerializator. B4RSerializator makes it simple to send messages with various fields to other platforms.  
  
See this for more information: [https://www.b4x.com/android/forum/t...d-and-receive-objects-instead-of-bytes.72404/](https://www.b4x.com/android/forum/threads/b4x-b4rserializator-send-and-receive-objects-instead-of-bytes.72404/)  
  
**v1.20 -** July 7, 2016: <https://www.b4x.com/android/forum/threads/b4r-v1-20-has-been-released.68741/>  
  
This version adds support for ESP8266 modules. These are great modules for IoT solutions.  
  
Start with this tutorial: <https://www.b4x.com/android/forum/threads/esp8266-getting-started.68740/>  
  
Other improvements and changes:  

- The board selector allows changing all the exposed settings:
![](https://www.b4x.com/basic4android/images/SS-2016-06-23_12.16.05.png)- B4R framework supports boards that require specific memory alignment (as the ESP8266).
- WebSocketClient library has moved to the internal libraries folder.
- Serial.Initialize2 has been removed as it is not supported by many boards. It can be accessed with inline C.

**You can download the new version here: [www.b4x.com/b4r.html](https://www.b4x.com/b4r.html)**