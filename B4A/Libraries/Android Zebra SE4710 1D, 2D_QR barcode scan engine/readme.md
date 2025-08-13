### Android Zebra SE4710 1D, 2D/QR barcode scan engine by Peter Simpson
### 12/25/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/163822/)

Hello All,  
This is a simple library I wrapped for Android 1D/2D barcode scanners that uses the Zebra SE4710 hardware scan engine. A new client had previously purchased some SE4710 based barcode scanners (not pictured below). After their in-house developer left a few months ago, they reached out to me for assistance. My first step was to locate and wrap this library for the B4A project.  
  
Obviously you don't need a library to use a Android 1D/2D hardware scan engine. To receive barcode data, you can use an Intent via a Receiver Module without the need for a library, but this can cause conflicts. For instance, the camera does not work while the scan engine is open (on/activated). This is because in Android the hardware barcode scan engine itself is classified as a camera and you can't run two cameras at the same time. I use the library to close (off/deactivate) the hardware barcode scan engine, then I can use the built-in rear camera to take a photograph, for example taking a photograph of an item of stock. Afterwards I use the library to open (on/activate) the hardware barcode scan engine again.  
  
**Take note:** This library **does not work** with mobile phone built-in cameras, it only works with Android powered devices that use the Zebra scan engine that is mentioned in the main title above.  
  
**B4A library tab**  
![](https://www.b4x.com/android/forum/attachments/158070)  
  
**Important:** There are 3 files in the attached zipped library file, place all 3 files in your B4A additional libraries folder.  
  
**I've changed some of the original java functions for continuity purposes in B4A.  
  
SS\_ZebraSE4710  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **ZebraSE4710**

- **Functions:**

- **CloseScanner** As Boolean
*Turn off the power for the scanner.*- **Initialize** (EventName As String)
*Initializes the object.*- **IsInitialized** As Boolean
*Tests whether the object was initialized.*- **OpenScanner** As Boolean
*Turn on the power for the scanner.*- **SetScanLaserMode** (Mode As Boolean) As Boolean
*Set the laser continuous scan mode.  
 Param mode start continuous scan True(On), stop continuous scan False(Off).*- **StartScan** As Boolean
*Start decoding.*- **StopScan** As Boolean
*Stop decoding.*
**Note:** I personally manually control the opening and closing of the barcode scanner (on a per B4XPage basis) thus I use the B4XPage\_KeyPress event for this library. I've included the B4XPage\_KeyPress event in the attached example source code, but it's not really necessary and you do not need B4XPage\_KeyPress if you are letting the scanner manage the scan buttons for you.  
  
**Below are two examples of Android powered 1D/2D barcode scanners, the right hand scanner scanner is using the SE4710 scan engine. This library should work with hardware scanners that use the Zebra SE4710 scan engine, No guarantees thought. To use this library, when ordering your 1D/2D barcode scanners, you will need to look for scanners that have the option of using the Zebra SE4710 scan engine. You may need to double check your scanner broadcast details and update the manifest and receiver module to receive the scanned data.**  
![](https://www.b4x.com/android/forum/attachments/158082)  
  
  
**Enjoy…**