### Android Honeywell N6602/N6603/N5703 1D, 2D/QR barcode scan engines by Peter Simpson
### 10/29/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/159185/)

**UPDATED:  
Version 1.20 now covers the Honeywell N6602, N6603 and also the N5703 1D/2D barcode scan engines.**  
  
Hello All,  
Here is a library that I wrapped for Android 1D/2D barcode scanners that uses the Honeywell N6602, N6603, and also the N5703 hardware scan engines.  
  
Obviously you don't need a library to use a Android 1D/2D hardware scan engines. To receive barcode data, you can use an Intent via a Receiver Module without the need for a library, but this can cause conflicts. For instance, the camera does not work while the scan engine is open (on/activated). This is because in Android the hardware barcode scan engine itself is classified as a camera and you can't run two cameras at the same time. I use the library to close (deactivate) the hardware barcode scan engine, then I can use the camera to take photos, for example taking a photo of an item of stock. Afterwards I use the library to open (activate) the hardware barcode scan engine again.  
  
**Take note:** This library **does not work** with mobile phone built-in cameras, it only works with Android powered devices that uses the Honeywell scan engines that I've previously mentioned.  
  
I personally only purchase and supply barcode scanners to my clients that use the Honeywell N6603 laser module, it's not their latest and greatest module, but it works exceptionally well. Android powered 1D/2D hardware barcode scanners cost more than a cheap smartphone, but their hardware, scan engines, build quality, rigidness, scanning distance and speed of scanning 1D/2D barcodes are clearly superior to using any smartphone camera.  
  
**B4A library tab  
![](https://www.b4x.com/android/forum/attachments/158072)  
  
Important:** There are 3 files in the attached zipped library file, place all 3 files in your B4A additional libraries folder.  
  

```B4X
        BScannner.SetScanBeep(True)  
        BScannner.SetScanVibrate(True)  
        BScannner.SetIndicatorLightMode(True)  
  
        Log($"Open the scanner: ${BScannner.OpenScanner}"$) 'Laser scanner is turned on and will scan  
        Log($"Is scanner open: ${BScannner.IsScanOpened}"$)  
        Log($"Get beep state: ${BScannner.GetScanBeepState}"$)  
        Log($"Get vibrate state: ${BScannner.GetScanVibrateState}"$)  
        Log($"Get indicator light state: ${BScannner.GetIndicatorLightMode}"$)  
        Log($"Get broadcast mode: ${BScannner.GetOutScanMode}"$)  
        Log($"Get scan mode: ${BScannner.GetScanLaserMode}"$)  
        Log($"Scanned barcode value: ${BScannner.GetScanCodeValue}"$)  
        Log($"Reset the scanner: ${BScannner.ResetScan}"$)
```

  
  

```B4X
** Activity (main) Create (first time) **  
Success: Scanner module found  
Scanner mode: Broadcast mode  
Open the scanner: true  
Is scanner open: true  
Get beep state: true  
Get vibrate state: true  
Get indicator light state: true  
Get broadcast mode: Broadcast mode  
Get scan mode: Single mode  
Scanned barcode value: null  
Reset the scanner: true  
Call B4XPages.GetManager.LogEvents = True to enable logging B4XPages events.
```

  
  
**I've changed some of the original java functions for continuity purposes in B4A.  
  
SS\_HoneywellN660xN5703  
  
Author:** Peter Simpson  
**Version:** 1.2  

- **HoneywellN660xN5703**

- **Functions:**

- **CloseScanner** As Boolean
*Turn off the power for the scanner.   
 Return true if successful, false if failed.*- **GetIndicatorLightMode** As Boolean
*Get the blink indicator lamp mode.  
 Returns true for On or false for Off.*- **GetOutScanMode** As String
*Get the barcode output mode.  
 Return output mode.*- **GetScanBeepState** As Boolean
*Get the beep status.  
 Returns true for On or false for Off.*- **GetScanCodeValue** As String
*Get the scan data at broadcast mode.  
 Return only scan data, can use after scan complete.  
 I personally recommend using the B4A Receiver Module after scanning a barcode.*- **GetScanLaserMode** As String
*Get the laser continuous mode.  
 Returns continuous mode(4) or single mode(8) setting.*- **GetScanVibrateState** As Boolean
*Get the vibrate status.  
 Returns true for On or false for Off.*- **Initialize** (EventName As String)
*Initializes the object.*- **IsInitialized** As Boolean
*Tests whether the object was initialized.*- **IsScanOpened** As Boolean
*Get the scanner status.  
 Return true for open or false for closed.*- **OpenScanner** As Boolean
*Turn on the power for the scanner.  
 Return true if successful, false if failed.*- **ResetScan** As Boolean
*Reset the scanner.  
 Return true if reset successfully.*- **SetIndicatorLightMode** (Mode As Boolean)
*Blink the indicator lamp when the scan is successful.  
 Param mode True(On) indicator lamp, False(Off) no indicator lamp.*- **SetOutScanMode** (Mode As Int) As Boolean
*Set the barcode output mode.  
 Param mode value: 0 Broadcast mode, 1 Editbox Mode, 2 Keyboard Mode.  
 Return true if successful, false if failed.*- **SetScanBeep** (Mode As Boolean) As Boolean
*Beep when the scan is successful.  
 Set true for On or false for Off.  
 Returns true for setting successfully.*- **SetScanLaserMode** (Mode As Boolean)
*Set the laser continuous scan mode.  
 Param mode start continuous scan True(On), stop continuous scan False(Off).*- **SetScanVibrate** (Mode As Boolean) As Boolean
*Vibrate when the scan is successful.  
 Set true for On or false for Off.  
 Returns true for setting successfully.*- **StartScan** As Boolean
*Start decoding.  
 Return true if the trigger is already active.*- **StopScan** As Boolean
*Stop decoding.  
 Return true if stopped successfully.*
  
**Below are some examples of generic Android powered 1D/2D barcode scanners that this library could/might work with (five definitely work), plus much much more,** **No guarantees thought****. When ordering these 1D/2D barcode scanners, you would need to look for scanners that have the option of using the Honeywell N6602, N6603 or N5703 scan engines. Using these particular scan engines can easy add £50-£90 (depending on the supplier) to the price of ordering a barcode scanner, but in my personal opinion it's 100% worth every penny.  
  
This library is for use with Honeywell N6602, N6603 or N5703 1D/2D hardware scan modules.   
  
I've tested this library on five different models of barcode scanners with different hardware scan modules, in my tests they all worked flawlessly.**  
![](https://www.b4x.com/android/forum/attachments/150657)  
  
**Update: V1.1**  

- Changed the library name (**generic** was too broad a name for a hardware)
- Tidied up the java library code

**Update: V1.2**  

- Changed the library name (SS\_HoneywellN660xN5703) to better suite it's purpose
- Updated to a newer .jar file
- Removed a function

  
D = 106+105, 116 + 108  
  
  
**Enjoy…**