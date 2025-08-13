### UsbSerial library 2.0 - supports more devices by agraham
### 10/25/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/28176/)

This is an expanded version of the original UsbSerial library. It has added support for Prolific PL2303 USB to serial converters, Android ADK devices and USB permissions. All devices use the same simple interface intended to be used with AsyncStreams and AsyncStreamsText. Note that AsyncStreams prefix mode is not supported. The library is based on the same open source project [Android USB host serial driver library](http://code.google.com/p/usb-serial-for-android/) as the existing UsbSerial library but no longer needs a separate jar file as the project source code is incorporated in the library.  
  
The specific enhancements to the library over the original UsbSerial library are :  
  
UsbPresent, HasPermission and RequestPermission are added to identify any attached device or Accessory available to the library and deal with permission to access it.  
  
SetParameters, which must be used after Open(), and the constants for SetParameters provides acess to all the serial line parameters instead of just baud rate.  
  
DeviceInfo provides a string containing information about a device. This works for slave devices only.  
  
Android Accessories, which are host mode devices, are recognised and can be used in the same way as the other slave mode devices.  
  
Prolific PL2303 support is added.  
  
Silicon Labs CP210x support is added - maybe only the CP2102 as I have no hardware to test.  
  
The FTDI "status byte" bug on reading input that existed in version 1.0 of this library is hopefully fixed.  
  
  
The usb-serial-for-android project and therefore also this library is licensed under the GNU Lesser General Public License v3. <http://www.gnu.org/licenses/lgpl.html|http://www.gnu.org/licenses/lgpl.html>  
Copies of both the General Public License and Lesser General Public License are in the provided archive.  
  
The user has to give your application permission to access the USB device before it can be opened. You can do this in two ways.  
  
As with the original UsbSerial library you can add the following code to the manifest editor  
  

```B4X
AddActivityText(main, <intent-filter>  
        <action android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED" />  
    </intent-filter>  
    <meta-data android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED"  
        android:resource="@xml/device_filter" />)
```

  
Then copy device\_filter.xml from the demo in the attached archive to: <your project>\objects\res\xml and mark it as read-only. Note that this is an expanded version of the original device\_filter.xml file.  
  
Finally install the program and attach the USB device. A dialog will appear asking whether you want to start your program. If you check the “Use by default…” checkbox from now on when the USB device is plugged in your program will be started. If you don’t check the checkbox then you will be asked each time the device is plugged in.  
  
A similar procedure can be used for Accessories as detailed in the “Using an intent filter” section here [USB Accessory | Android Developers](http://developer.android.com/guide/topics/connectivity/usb/accessory.html)  
  
  
Alternatively you can use the new HasPermission and RequestPermission methods without requiring any of the above steps. The demo in the archive incorporates both ways of obtaining permission.  
  
EDIT:- Version 2.1 now posted. See post #4 for details  
  
EDIT:- Version 2.2 now posted. See post #14 for details  
  
EDIT:- Version 2.3 now posted. See post #26 for details  
  
**V2.4 is available here: <http://www.b4x.com/android/forum/threads/usbserial-library-2-0-supports-more-devices.28176/page-11#post-259167>  
This update adds support for devices connected to multiple USB adapters.**  
  
V2.5 is available as an attachment to this post. It is identical to version 2.4 referenced above but adds the required flag for Pending Intents when targeting SDK 31+.  
  
V2.6 is available as an attachment to this post. It is identical to version 2.5 referenced above but adds the required flag for Pending Intents when targeting SDK 34+.