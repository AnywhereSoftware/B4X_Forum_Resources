### Honeywell Mobility device barcode scanner library - Data Collection V1.97.00.0084 by Peter Simpson
### 08/30/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/168447/)

Hello everyone,  
Here is a library that I wrapped for using with Android powered Honeywell Mobility 1D/2D(QR) barcode scanners. This library uses the official Honeywell Data Collection Java API V1.97.00.0084.  
  
Obviously you don't need a library to use an Android 1D/2D(QR) hardware scan engines. To receive scanned barcode data, you can use an intent via a B4A Receiver Module without the need for a library, but this can cause conflicts if you want to use the device built-in rear camera.  
  
**Take note:** This library **does not work** with normal mobile phones built-in cameras, it only works with Honeywell Mobility Android powered hardware devices that uses are compatible with Data Collector V1.97.00.0084. Check out the supported mobile computers list further down this post.  
  
**B4A library tab**  
![](https://www.b4x.com/android/forum/attachments/166406)  
  
**Important:** There are 3 separate files in the attached zipped library file, place all 3 files in your B4A additional libraries folder.  
  
**Test app screenshot: B4A test app should be easy to understand.**  
![](https://www.b4x.com/android/forum/attachments/166408)  
  
![](https://www.b4x.com/android/forum/attachments/166409)  
**SS\_HoneywellMobilityEnhanced  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **HoneywellMobilityEnhanced**
*B4A SDK Wrapper for Honeywell Barcode Scanner (Aidc SDK)  
 Based on Android Data Collection Java API V1.97.00.0084*

- **Events:**

- **BarcodeScanned** (Data As String)
- **OnFailureEvent** (Message As String)
- **OnGuidanceFeedback** (Message As String)
- **OnImageCaptured** (Image() As Byte)
- **OnImageCaptureFailed** (Message As String)
- **ScannerConnectionChanged** (IsConnected As Boolean)
- **ScannerStatusChanged** (Status As String)
- **ScannerUnavailable** (Message As String)
- **TriggerChanged** (Pressed As Boolean)

- **Functions:**

- **CaptureLastScannedImage**
*Captures and returns the last scanned bitmap image.  
 This method raises the OnImageCaptured event with the captured image  
 or OnImageCaptureFailed if the capture is unsuccessful.*- **ClaimScanner**
*Claims control of the barcode reader, allowing the application to use it.  
 This is automatically handled internally but can be called manually if needed.*- **EnableLogging** (enabled As Boolean)
*Enables or disables logging for debugging purposes.  
 Enabled true to enable logging, false to disable.*- **GetAllProperties** As Map
*Retrieves a Map of all properties currently set on the BarcodeReader.  
 You must have a BarcodeReader instance that is claimed and available.  
 Return A Map containing all properties, or an empty Map on error.*- **GetBarcodeReaderInfo** As Map
*This method retrieves information about the last connected barcode reader and returns it as a B4A Map.  
 Create and initialize a new B4A Map object to store the scanner's properties.*- **GetBarcodeReaderInfo2** As com.honeywell.aidc.BarcodeReaderInfo
- **GetConnectedScannerName** As String
*Gets the friendly name of the currently connected barcode scanner.  
 Returns the scanner's name as a string, or an empty string if none is connected.*- **GetConnectionStatus** As String
*Retrieves a formatted connection status of the barcode scanner as an integer,  
 Mapping the raw SDK values to a standard convention.  
 Return Connected if the scanner is connected, Disconnected if disconnected, or Unknown if the status is unknown.*- **GetDecoderTimeout** As Int
*Retrieves the current decoder timeout from the scanner.  
 Return the decoder timeout value in milliseconds, or 0 if not  
 available or an error occurs.*- **GetProperty** (propertyName As String) As Object
*Retrieves the value of a single scanner property.  
 e.g. "PROPERTY\_EAN\_13\_ENABLED", "PROPERTY\_DECODER\_TIMEOUT", "PROPERTY\_ILLUMINATION\_MODE".  
 CHECK THE SCANNER MANUAL FOR THE FULL LIST OF PROPERTIES  
 propertyName: The name of the property to retrieve.  
 Return the value of the property as an Object, or null if the property  
 is not found or an error occurs.*- **GetScanHistory** As String()
*Retrieves the history of scanned barcodes.  
 An array of strings containing the last 50  
 history of scanned barcodes.*- **GetScannerFirmwareVersion** As String
*Retrieves the scanner's firmware version.  
 The firmware version as a string, or null if not available.*- **GetScannerId** As String
*Retrieves the scanner ID as a string, or null if not available.*- **GetScannerSerialNumber** As String
*Retrieves the serial number as a string, or null if not available.*- **GetSymbologyStates** As List
*Retrieves the state (enabled/disabled) of a list of common symbologies.  
 This function gets all current properties from the scanner and checks  
 the state of a predefined list of common symbologies.  
 A List of strings where each element is a symbology name followed by its state,  
 e.g. "Code 128: Enabled". Returns an empty list if the scanner is not ready.*- **Initialize** (EventName As String)
*Initializes the library and connects to a Honeywell barcode scanner.  
 This should be called once when the activity is created.*- **IsClaimed** As Boolean
*Checks if the barcode reader is currently claimed by this application.  
 Returns true if the scanner is claimes, false otherwise.*- **IsInitialized** As Boolean
*Tests whether the library was initialized.  
 Returns true if initialized, false otherwise.*- **IsScannerReady** As Boolean
*Checks if the barcode scanner is currently initialized and ready to use.  
 Returns true if the scanner is ready, false otherwise.*- **ListAvailableScanners** As List
*Return a list of friendly names for all available barcode scanners.*- **ListScanners** As List
*Lists all connected barcode scanners and returns a list of their names.  
 These are the technical names used by the SDK and are required for the  
 `createBarcodeReaderConnection` method. For user interface purposes,  
 use the `ListAvailableScanners` method instead.  
 The `BarcodeReaderInfo.getName()` is used to get the technical name  
 which is a unique identifier for a scanner.  
 The `BarcodeReaderInfo.getFriendlyName()` is used to get the user-friendly name,  
 like "Internal Imager" or "RS31 Ring Scanner".  
 Returns a list of strings containing the technical names of connected scanners.*- **Notify** (NotificationType As String)
*Triggers a pre-configured notification for the user.  
 You must have a BarcodeReader instance that is claimed and available.  
 NotificationType The type of notification to trigger.  
 Accepted values are: "GOOD\_READ\_NOTIFICATION" or "BAD\_READ\_NOTIFICATION".*- **OnPause**
*Releases the scanner claim when the application is paused.*- **OnResume**
*Reclaims the scanner when the application resumes from the background.*- **ReleaseScanner**
*Releases the barcode reader, allowing other applications to claim it.*- **ResetScannerToDefaults**
*Resets the barcode scanner's properties to their default values.*- **SelectScannerByFriendlyName** (FriendlyName As String)
*Selects a specific barcode scanner to use by its friendly name.  
 The friendly name of the scanner to select.*- **SetAimerEnabled** (Enabled As Boolean)
*Enables or disables the scanner aimer.  
 This function uses the ACTION\_CONTROL\_SCANNER intent.  
 True to turn on the aimer, False to turn it off.*- **SetBadReadNotification** (Enabled As Boolean)
*Enables or disables the bad read notification sound/vibration.  
 True to enable, False to disable.*- **SetDecoderTimeout** (timeout As Int)
*Sets the maximum time (in milliseconds) the scanner will attempt to decode a barcode.  
 The timeout value in milliseconds.*- **SetEventPrefix** (Prefix As String)
*Sets a custom event prefix for the library's events.  
 Change the prefix initialize event name string to a new prefix event name string.*- **SetGoodReadNotification** (Enabled As Boolean)
*Enables or disables the good read notification sound/vibration.  
 True to enable, False to disable.*- **SetIlluminationEnabled** (Enabled As Boolean)
*Enables or disables the scanner illumination.  
 True to turn on the illumination, False to turn it off.*- **SetProperty** (propertyName As String, propertyValue As Object)
*Gets the value of a single scanner property,   
 e.g. "PROPERTY\_EAN\_13\_ENABLED", "PROPERTY\_DECODER\_TIMEOUT", "PROPERTY\_ILLUMINATION\_MODE".  
 CHECK THE SCANNER MANUAL FOR THE FULL LIST OF PROPERTIES  
   
 propertyName: The name of the property to retrieve.  
 Return the value of the property, or null if the property  
 is not found or an error occurs.*- **SetSoftwareTriggerState** (state As Boolean)
*Programmatically triggers the scanner.  
 True to start a scan, False to stop it.*- **SetTriggerScanMode** (Mode As String)
*Sets the scan mode of the trigger.  
 This allows you to configure whether the scanner performs a one-shot scan or  
 scans continuously while the trigger is held down.  
 The desired scan mode as a string.  
 Accepted values are: "continuous", "oneShot", "readOnRelease".*- **StartScan**
*Initiates a software trigger to start a scan.*- **StopScan**
*Stops the software trigger, ending an active scan.*
  
[SPOILER="My scanner properties"]  
A generated list of my barcode scanner properties, generated using B4A.  
  
DEC\_MAXICODE\_MAX\_LENGTH: 150  
DEC\_OCR\_MODE: off  
DEC\_COMPOSITE\_MIN\_LENGTH: 1  
DEC\_RSS\_EXPANDED\_MIN\_LENGTH: 1  
DEC\_MSI\_MIN\_LENGTH: 4  
DEC\_VIDEO\_REVERSE\_ENABLED: normal  
DEC\_M25\_MIN\_LENGTH: 4  
IMG\_UPLOAD\_BAD\_READ\_IMAGE: false  
DEC\_RSS\_EXPANDED\_ENABLED: false  
IMG\_TARGET\_PERCENTILE: 97  
TRIG\_SCAN\_SAME\_SYMBOL\_TIMEOUT\_ENABLED: false  
DPR\_LAUNCH\_BROWSER: false  
DEC\_DOTCODE\_MAX\_LENGTH: 2400  
DEC\_GS1\_128\_MAX\_LENGTH: 80  
DEC\_UPCA\_CHECK\_DIGIT\_TRANSMIT: false  
DEC\_CODE11\_ENABLED: false  
IMG\_EXPOSURE: 4800  
DEC\_EAN8\_ADDENDA\_SEPARATOR: false  
DEC\_WINDOW\_BOTTOM: 50  
DEC\_MAXICODE\_ENABLED: false  
TRIG\_SCAN\_DELAY: 0  
DEC\_RSS\_EXPANDED\_MAX\_LENGTH: 74  
DEC\_POSTNET\_CHECK\_DIGIT\_TRANSMIT: false  
DEC\_DIGIMARC\_CONVERSION: convertToEquivalent  
DEC\_KOREA\_POST\_MIN\_LENGTH: 4  
DPR\_DATA\_INTENT: false  
DEC\_UPCA\_ADDENDA\_SEPARATOR: false  
DEC\_CODE39\_START\_STOP\_TRANSMIT: false  
DEC\_UPCE0\_ENABLED: true  
DEC\_CODE39\_MIN\_LENGTH: 0  
DEC\_DATAMATRIX\_ENABLED: true  
DEC\_RSS\_LIMITED\_ENABLED: false  
DEC\_IATA25\_MIN\_LENGTH: 4  
DEC\_TELEPEN\_MIN\_LENGTH: 1  
DEC\_EAN8\_ENABLED: true  
DEC\_IATA25\_ENABLED: false  
DEC\_MICROPDF\_ENABLED: false  
DEC\_HANXIN\_MAX\_LENGTH: 7833  
IMG\_GAIN: 1024  
IMG\_UPLOAD\_QUOTA\_SIZE: 300  
IMG\_UPLOAD\_FOLDER\_MAX\_SIZE: 90  
DEC\_AZTEC\_ENABLED: false  
DEC\_CODE11\_CHECK\_DIGIT\_MODE: doubleDigitCheckAndStrip  
DEC\_OCR\_ACTIVE\_TEMPLATES: 1  
DPR\_DATA\_INTENT\_ACTION:  
DEC\_EAN8\_5CHAR\_ADDENDA\_ENABLED: false  
DEC\_S25\_MIN\_LENGTH: 4  
DEC\_COMPOSITE\_WITH\_UPC\_ENABLED: false  
DEC\_ID\_PROP\_USE\_ROI: Disable  
DEC\_UPCE\_NUMBER\_SYSTEM\_TRANSMIT: true  
DEC\_CODE39\_MAX\_LENGTH: 10  
DEC\_COMBINE\_COMPOSITES: false  
DEC\_ADD\_SEARCH\_TIME\_UPC\_COMPOSITE: 300  
DEC\_GS1\_128\_ENABLED: true  
DEC\_PDF417\_MIN\_LENGTH: 1  
DEC\_UPCA\_NUMBER\_SYSTEM\_TRANSMIT: true  
DEC\_M25\_MAX\_LENGTH: 80  
DEC\_C128\_SHORT\_MARGIN: partial  
DEC\_I25\_MAX\_LENGTH: 80  
DEC\_UPCA\_TRANSLATE\_TO\_EAN13: false  
DEC\_TRIOPTIC\_ENABLED: false  
DEC\_DATAMATRIX\_MAX\_LENGTH: 3116  
TRIG\_ENABLE: true  
DEC\_CODABLOCK\_A\_ENABLED: false  
DEC\_CODE93\_HIGH\_DENSITY: false  
DEC\_HANXIN\_ENABLED: false  
DEC\_COUPON\_CODE\_MODE: false  
DEC\_GRIDMATRIX\_ENABLED: false  
DEC\_COMPOSITE\_MAX\_LENGTH: 2435  
DEC\_CODE93\_MIN\_LENGTH: 0  
DEC\_OCR\_TEMPLATE: 1,3,7,7,7,7,7,7,7,7,0  
DEC\_UPCE\_EXPAND: false  
DEC\_CODE39\_UNCONV\_INTER\_CHAR: false  
DEC\_DPM\_ENABLED: none  
DEC\_EAN13\_ENABLED: false  
DEC\_DIGIMARC\_ENABLED: false  
DEC\_GRIDMATRIX\_MAX\_LENGTH: 2751  
DEC\_MAXICODE\_MIN\_LENGTH: 1  
NTF\_GOOD\_READ\_ENABLED: true  
DEC\_DOTCODE\_ENABLED: false  
DEC\_PDF417\_ENABLED: false  
DEC\_MSI\_MAX\_LENGTH: 48  
DEC\_DECODE\_SET:  
DEC\_CODE128\_MIN\_LENGTH: 0  
DEC\_MSI\_CHECK\_DIGIT\_MODE: noCheck  
DEC\_C128\_ISBT\_ENABLED: false  
NTF\_BAD\_READ\_ENABLED: true  
DEC\_CODABLOCK\_A\_MAX\_LENGTH: 2048  
DEC\_COMPOSITE\_ENABLED: false  
DEC\_GRIDMATRIX\_MIN\_LENGTH: 1  
DEC\_EAN13\_CHECK\_DIGIT\_TRANSMIT: false  
DEC\_QR\_MIN\_LENGTH: 1  
DEC\_UPCE\_5CHAR\_ADDENDA\_ENABLED: false  
DEC\_CODABLOCK\_F\_MAX\_LENGTH: 2048  
DEC\_DOTCODE\_MIN\_LENGTH: 1  
DEC\_WINDOW\_MODE: true  
DEC\_CODABAR\_START\_STOP\_TRANSMIT: false  
TRIG\_SCAN\_SAME\_SYMBOL\_TIMEOUT: 1000  
DEC\_EAN13\_2CHAR\_ADDENDA\_ENABLED: false  
DEC\_S25\_ENABLED: false  
IMG\_TARGET\_ACCEPTABLE\_OFFSET: 40  
DEC\_UPCE\_ADDENDA\_REQUIRED: false  
DEC\_EAN8\_CHECK\_DIGIT\_TRANSMIT: false  
DPR\_CHARSET: ISO-8859-1  
IMG\_TARGET\_VALUE: 100  
DEC\_CODABAR\_MAX\_LENGTH: 60  
IMG\_EXPOSURE\_MODE: contextSensitive  
DEC\_MICROPDF\_MIN\_LENGTH: 1  
IMG\_OVERRIDE\_RECOMMENDED\_VALUES: false  
DPR\_WEDGE\_KEY\_CHARS: 9,10,13  
DEC\_CODABLOCK\_F\_ENABLED: false  
DEC\_UPCA\_5CHAR\_ADDENDA\_ENABLED: false  
DEC\_QR\_ENABLED: true  
DEC\_PROP\_MSIP\_OUT\_OF\_SPEC\_SYMBOL: false  
DPR\_WEDGE: false  
DEC\_EAN13\_ADDENDA\_REQUIRED: false  
DEC\_UPCE1\_ENABLED: false  
DEC\_CODABAR\_CONCAT\_ENABLED: false  
DEC\_UPCE\_CHECK\_DIGIT\_TRANSMIT: false  
DEC\_TELEPEN\_OLD\_STYLE: false  
DEC\_CODE39\_ENABLED: true  
DEC\_UPCE\_2CHAR\_ADDENDA\_ENABLED: false  
NTF\_VIBRATE\_ENABLED: false  
DPR\_PREFIX:  
DEC\_I25\_CHECK\_DIGIT\_MODE: noCheck  
IMG\_SAMPLE\_METHOD: centerWeighted  
DEC\_KOREA\_POST\_ENABLED: false  
DEC\_HK25\_MAX\_LENGTH: 80  
DEC\_CODABAR\_CHECK\_DIGIT\_MODE: noCheck  
DEC\_COMBINE\_COUPON\_CODES: false  
DEC\_EAN13\_ADDENDA\_SEPARATOR: false  
IMG\_ILLUM\_INTENSITY: 100  
DEC\_AZTEC\_MIN\_LENGTH: 1  
DEC\_DIGIMARC\_SHAPE\_DETECTION: false  
DPR\_EDIT\_DATA\_SETTINGS:  
DEC\_DIGIMARC\_SCALE\_BLOCKS: useBothScale1AndScale3Blocks  
DEC\_CODE93\_ENABLED: false  
DEC\_CODE39\_BASE32\_ENABLED: false  
DEC\_MICROPDF\_MAX\_LENGTH: 366  
DEC\_CODABAR\_MIN\_LENGTH: 2  
DEC\_MSIP\_SHORT\_MARGIN: false  
DEC\_IATA25\_MAX\_LENGTH: 64  
DEC\_DECODE\_FILTER\_DEBUG: 0  
DEC\_RSS\_14\_ENABLED: false  
DEC\_CODE39\_CHECK\_DIGIT\_MODE: noCheck  
IMG\_AUTO\_CALIBRATION: true  
DEC\_I25\_ENABLED: false  
DEC\_GS1\_128\_MIN\_LENGTH: 0  
DPR\_DATA\_INTENT\_PACKAGE\_NAME:  
DEC\_PLANETCODE\_CHECK\_DIGIT\_TRANSMIT: false  
DEC\_CODE93\_MAX\_LENGTH: 80  
DPR\_SCAN\_TO\_INTENT: true  
DEC\_EAN13\_5CHAR\_ADDENDA\_ENABLED: false  
DEC\_S25\_MAX\_LENGTH: 48  
DEC\_M25\_ENABLED: false  
DEC\_PDF417\_MAX\_LENGTH: 2750  
DEC\_HK25\_MIN\_LENGTH: 4  
DEC\_I25\_MIN\_LENGTH: 2  
DEC\_UPCE\_ADDENDA\_SEPARATOR: false  
DEC\_KOREA\_POST\_MAX\_LENGTH: 48  
DEC\_SECURITY\_LEVEL: 2  
DPR\_WEDGE\_METHOD: standard  
DEC\_POSTAL\_ENABLED: none  
DEC\_CODE39\_FULL\_ASCII\_ENABLED: false  
IMG\_MAX\_EXPOSURE: 60000  
DEC\_WINDOW\_LEFT: 50  
DEC\_UPCA\_ADDENDA\_REQUIRED: false  
DEC\_CODE11\_MIN\_LENGTH: 1  
DEC\_DATAMATRIX\_MIN\_LENGTH: 1  
DEC\_CODE128\_ENABLED: true  
DEC\_CODABLOCK\_A\_MIN\_LENGTH: 1  
DPR\_DATA\_INTENT\_CLASS\_NAME:  
DPR\_EDIT\_DATA\_PLUGIN:  
DEC\_UPCA\_2CHAR\_ADDENDA\_ENABLED: false  
DEC\_WINDOW\_TOP: 50  
DPR\_SYMBOLOGY\_PREFIX: none  
DEC\_CODE128\_MAX\_LENGTH: 80  
DEC\_CODABLOCK\_F\_MIN\_LENGTH: 1  
DEC\_CODABAR\_ENABLED: false  
DEC\_EAN8\_2CHAR\_ADDENDA\_ENABLED: false  
DEC\_HANXIN\_MIN\_LENGTH: 1  
DEC\_TLC39\_ENABLED: false  
DEC\_LINEAR\_DAMAGE\_IMPROVEMENTS: false  
TRIG\_AUTO\_MODE\_TIMEOUT: 20  
DEC\_DECODE\_FILTER:  
DEC\_UPCA\_ENABLE: true  
DEC\_WINDOW\_RIGHT: 50  
DPR\_SUFFIX:  
IMG\_UPLOAD\_GOOD\_READ\_IMAGE: false  
DPR\_LAUNCH\_EZ\_CONFIG: true  
DEC\_QR\_MAX\_LENGTH: 7089  
DEC\_EAN8\_ADDENDA\_REQUIRED: false  
DEC\_CODE11\_MAX\_LENGTH: 80  
DPR\_DATA\_INTENT\_CATEGORY:  
TRIG\_CONTROL\_MODE: autoControl  
IMG\_REJECTION\_LIMIT: 5  
DEC\_AZTEC\_MAX\_LENGTH: 3832  
DEC\_TELEPEN\_ENABLED: false  
IMG\_MAX\_GAIN: 1024  
DEC\_TELEPEN\_MAX\_LENGTH: 60  
DEC\_HK25\_ENABLED: false  
DEC\_MSI\_ENABLED: false  
TRIG\_SCAN\_MODE: oneShot  
[/SPOILER]  
  
**Please note:**  
If your scanner does not support some properties, the library **WILL NOT** return the property information requested.  
  
  
**Enjoy…**