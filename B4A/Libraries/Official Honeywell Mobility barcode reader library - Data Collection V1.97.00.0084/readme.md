### Official Honeywell Mobility barcode reader library - Data Collection V1.97.00.0084 by Peter Simpson
### 09/11/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/168447/)

**If this library works for you, let other B4A developers know by posting the Honeywell device model details below.**  
  
Hello everyone,  
Here is a library that I wrapped for using with Honeywell Mobility mobile computers (barcode readers). This library uses the official Honeywell Data Collection Java API V1.97.00.0084.  
  
Obviously you don't need a library to view data from 1D/2D (QR) scan engines, you can just use an intent via a B4A Receiver Module. This library allows you to add more functionality to your Honeywell barcode reader apps.  
  
The original Honeywell library for Android Studio only has a hand full of methods exposed just to get their barcode readers up and running. After reading the Honeywell SDK documentation, I decided to develop an enhanced library for B4A, thus the name.  
  
**Take note:**  
This library **does not work** with normal mobile phones built-in cameras, it's for **Honeywell Mobility** Android devices that are compatible with Data Collector V1.97.00.0084. Look at the supported mobile computers list further down this post, or the more comprehensive list in post #2.  
  
**B4A library tab**  
![](https://www.b4x.com/android/forum/attachments/166406)  
  
**Important:**  
There are 3 separate files in the attached library zip file, place all 3 files in your B4A additional libraries folder.  
  
**B4A test app screenshot:**   
![](https://www.b4x.com/android/forum/attachments/166567)  
  
![](https://www.b4x.com/android/forum/attachments/166409)  
**I have created a more comprehensive Honeywell compatible devices list in post #2 below. Look for your device in that list. If your Honeywell device is not listed below, you can still try testing this library on your Honeywell device.  
  
SS\_HoneywellMobilityEnhanced  
  
Author:** Peter Simpson  
**Version:** 1.03  

- **HoneywellMobilityEnhanced**
*B4A SDK Wrapper for Honeywell Barcode Readers (Aidc SDK)  
 Based on Android Data Collection Java API V1.97.00.0084*

- **Events:**

- **BarcodeScanned** (Data As String)
- **OnFailureEvent** (Message As String)
- **OnImageCaptured** (Image() As Byte)
- **OnImageCaptureFailed** (Message As String)
- **ScannerConnectionChanged** (IsConnected As Boolean)
- **ScannerStatusChanged** (Status As String)
- **ScannerUnavailable** (Message As String)
- **TriggerChanged** (Pressed As Boolean)

- **Fields:**

- **QROpenBrowser** As Boolean
*Automatically open the brower if the scanned QR image is a URL.*
- **Functions:**

- **CaptureLastScannedImage**
*Captures and returns the last scanned bitmap image.  
 This method raises the OnImageCaptured event with the captured image  
 or OnImageCaptureFailed if the capture is unsuccessful.*- **ClaimScanner**
*Claims control of the barcode reader, allowing the application to use it.  
 This is automatically handled internally but can be called manually if needed.*- **ClearScanHistory**
*Clears the locally stored history of scanned barcodes.  
 This will reset the list of the last 50 scanned barcodes  
 that is maintained by the wrapper.*- **ConnectToScanner** (scannerName As String)
*Connects to a specific barcode scanner by its technical name.  
 Use the name returned from ListScanners().  
 ScannerName: The name of the scanner device to connect to.  
 e.g., "DW-Scanner", "imager", etc.*- **EnableLogging** (enabled As Boolean)
*Enables or disables library logging for debugging purposes.  
 Enabled true to enable logging, false to disable.*- **GetAllProperties** As Map
*Retrieves a Map of all properties currently set on the claimed BarcodeReader.  
 Return all properties, or an empty Map on error.*- **GetBarcodeReaderInfo** As Map
*This method retrieves information about the last connected barcode reader and returns its properties as a Map.*- **GetConnectedScannerName** As String
*Gets the friendly name of the currently connected barcode scanner.  
 Returns the scanner's name as a string, or an empty string if none is connected.*- **GetConnectionStatus** As String
*Retrieves a formatted connection status of the barcode.  
 Return Connected if the scanner is connected, Disconnected if disconnected, or Unknown if the status is unknown.*- **GetProperty** (propertyName As String) As Object
*Retrieves the value of a single scanner property.  
 e.g. "PROPERTY\_EAN\_13\_ENABLED", "PROPERTY\_DECODER\_TIMEOUT", "PROPERTY\_ILLUMINATION\_MODE".  
 CHECK THE SCANNER MANUAL FOR THE FULL LIST OF PROPERTIES.  
   
 propertyName: The name of the property to retrieve.  
 Return the value of the property as an Object, or null if the property is not found*- **GetScanHistory** As String()
*Retrieves the locally stored history of scanned barcodes.  
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
*Initializes the Honeywell Mobility library for barcode scanners.  
 This will automatically claims a barcode scanner if one is availiable.*- **IsClaimed** As Boolean
*Checks if the barcode reader is currently claimed by this application.  
 Returns true if the scanner is claimes, false otherwise.*- **IsInitialized** As Boolean
*Checks if the library is fully initialized and able to communicate with the device.   
 True if ready for use, false otherwise.*- **IsScannerReady** As Boolean
*Checks if the scanner is ready for use, including being connected and available.  
 This is a more robust check than simply verifying the barcodeReader object is not null.  
 True if the scanner is ready for use, false otherwise.*- **ListAvailableScanners** As List
*Return a list of friendly names for all available barcode scanners.*- **ListScanners** As List
*Lists the technical names of all connected barcode scanners.  
 These names are unique identifiers required for the `createBarcodeReaderConnection` method.  
 Return A list of strings containing the technical names of connected scanners.*- **ManageTrigger** (ManageTrigger As Boolean)
*Enable or disable manually controlling the trigger and how it works, default is false.  
 True if you the developer wants to manage the trigger, false if not (leave automatic).  
 When true, the TriggerChanged event will be triggered*- **Notify** (NotificationType As String)
*Triggers a pre-configured notification for the user.  
 You must have a BarcodeReader instance that is claimed and available.  
 NotificationType The type of notification to trigger.  
 Accepted values are: "GOOD\_READ\_NOTIFICATION" or "BAD\_READ\_NOTIFICATION".*- **OnDestroy**
*Cleans up and releases all resources associated with the scanner.  
 Use this method when your application is about to be shut down.*- **OnPause**
*Releases the scanner claim when the application is paused.*- **OnResume**
*Reclaims the scanner when the application resumes from the background.*- **ReleaseScanner**
*Releases the barcode reader, allowing other applications to claim it.*- **ResetScannerToDefaults**
*Resets the barcode scanner's properties back to their default initialization values.*- **SelectScannerByFriendlyName** (FriendlyName As String)
*Selects a specific barcode scanner to use by its friendly name.  
 It searches for a connected scanner with a matching friendly name  
 and then establishes a new connection to it.  
 friendlyName: The friendly name of the scanner to select,  
 e.g., "imager", "scanner", "hf\_rfid\_reader".  
 This is case-sensitive.*- **SetAimerEnabled** (Enabled As Boolean)
*Enables or disables the scanner aimer.  
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
*Sets the value of a single scanner property,   
 e.g. "PROPERTY\_EAN\_13\_ENABLED", "PROPERTY\_DECODER\_TIMEOUT", "PROPERTY\_ILLUMINATION\_MODE".  
 CHECK THE SCANNER MANUAL FOR THE FULL LIST OF PROPERTIES.  
   
 propertyName: The name of the property to retrieve.  
 propertyValue: Sets the property value, Boolean, Int, String.*- **SetSoftwareTriggerState** (state As Boolean)
*Programmatically triggers the scanner.  
 True to start a scan, False to stop it.*- **SetSymbologyEnabled** (Symbology As String, Enabled As Boolean)
*Enables or disables a specific symbology for the barcode reader.  
 Symbology: The name of the symbology (e.g., BarcodeReader.PROPERTY\_CODE\_128\_ENABLED).  
 Enabled: True to enable the symbology, false to disable.*- **SetTriggerScanMode** (Mode As String)
*Sets the scan mode of the trigger.  
 This allows you to configure the desired scan mode as a string.  
 Accepted values are: "continuous", "oneShot", "readOnRelease".*- **StartScan**
*Initiates a software trigger to start a scan.*- **StopScan**
*Stops the software trigger, ending an active scan.*- **Symbologies** As Symbology
*Use this symbology list with SetSymbologyEnabled > Symbology As String.  
   
 1D Symbologies:  
 UPC A, UPC E, EAN 8, EAN 13, CODE 39, CODE 128, GS1 128, INTERLEAVED 25, CODABAR, MSI, RSS  
   
 2D Symbologies:  
 QR CODE, DATAMATRIX, PDF 417, AZTEC, MAXICODE*
- **Symbology**

- **Fields:**

- **AZTEC\_ENABLED** As String
*Enabled/Disable state of AZTEC symbology.*- **CODABAR\_ENABLED** As String
*Enabled/Disable state of CODABAR symbology.*- **CODE11\_ENABLED** As String
*Enabled/Disable state of Code 11 symbology.*- **CODE128\_ENABLED** As String
*Enabled/Disable state of CODE128 symbology.*- **CODE39\_ENABLED** As String
*Enabled/Disable state of CODE39 symbology.*- **CODE93\_ENABLED** As String
*Enabled/Disable state of Code 93 symbology.*- **DATAMATRIX\_ENABLED** As String
*Enabled/Disable state of DATAMATRIX symbology.*- **EAN13\_ENABLED** As String
*Enabled/Disable state of EAN13 symbology.*- **EAN8\_ENABLED** As String
*Enabled/Disable state of EAN-8 symbology.*- **GS1\_128\_ENABLED** As String
*Enabled/Disable state of GS1 128 symbology.*- **MAXICODE\_ENABLED** As String
*Enabled/Disable state of MaxiCode symbology.*- **PDF417\_ENABLED** As String
*Enabled/Disable state of PDF417 symbology.*- **QR\_ENABLED** As String
*Enabled/Disable state of QR code symbology.*- **UPCA\_ENABLED** As String
*Enabled/Disable state of UPCA symbology.*- **UPCE\_ENABLED** As String
*Enabled/Disable state of UPC-E symbology.*
  
[SPOILER="My barcode reader properties"]  
**A list of my barcode reader properties that this library generated using the GetAllProperties method.**  
  
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
  
**Take note:**  
This library will **ONLY DISPLAY PROPERTIES** that are available on your device.  
  
**Update: V1.01**  

- Updated some of the previous library methods
- Removed GetAllProperties2 method (it was for testing)
- Updated the test app (attached)

**Update: V1.02**  

- Cleaned up the JavaDoc comments
- Added OnDestroy method
- Added ClearScanHistory method
- Added ManageTrigger method (to manage the \_TriggerChanged event)
- Removed OnGuidanceFeedback event (it wasn't being used)
- Tidied up some previously created code
- Updated the test app (attached)

**Update: V1.03**  

- Cleaned up the JavaDoc comments (Made comments shorter)
- Added ConnectToScanner method (For manual connections)
- Added SetSymbologyEnabled method
- Added SymbologyList Field (As a list)
- Added QROpenBrowser variable
- Expanded the symbologies in the default properties list.
- Expanded the symbologies in the GetSymbologyStates method
- Set EAN8 transmit check digit by default to True
- Set EAN13 transmit check digit by default to True
- Set DEC\_UPCA\_CHECK\_DIGIT\_TRANSMIT transmit check digit by default to True
- Set DEC\_UPCA\_CHECK\_DIGIT\_TRANSMIT transmit check digit by default to True
- Tidied up some previously created code
- Updated the test app (attached)

  
D = 7+7, 11+12, 4+8  
  
  
**Enjoy…**