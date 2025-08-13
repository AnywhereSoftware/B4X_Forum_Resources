### SD EscPos Printer (Lan,USB, Bluetooth SPP, BLE) by Star-Dust
### 04/20/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/142512/)

This library allows you to print with thermal printers compatible with the ESC POS language in 4 different communication channels (USB, Bluetooth SPP, BLE, LAN)  
you can download the ble3 library from [**here**](https://www.b4x.com/android/forum/threads/ble2-library-additional-functions.133296/post-846002)  
  
***The DEMO version prints one minute every 2.*** The full version of the library will be issued to those making a donation *(Contact me in private before making a donation)*  
  
**WARNING**: Make sure the library meets all your needs, is **compatible** with the printer you need to use.  
  
For ESC/POS B4J version see [**Here**](https://www.b4x.com/android/forum/threads/jsd_escposprinter.162668/)  
For ESC/POS B4i version see **[Here](https://www.b4x.com/android/forum/threads/isd-ble-printer.103574/)**  
For ZEBRA printer see [**Here**](https://www.b4x.com/android/forum/threads/b4x-sd-zebra-printer.142094/)  
  
  

***Those who want a different version, such as LAN, USB, NFC please contact me privately.***

  
[TABLE]  
[TR]  
[TD]**OS**[/TD]  
[TD]**Bluetooth SPP**[/TD]  
[TD]**BLE (Beacon)**[/TD]  
[TD]**USB** [/TD]  
[TD]**LAN / WIFI** [/TD]  
[TD]**RS 232** [/TD]  
[TD]**NFC** [/TD]  
[/TR]  
[TR]  
[TD]Android[/TD]  
[TD]x[/TD]  
[TD]x[/TD]  
[TD]x[/TD]  
[TD]x[/TD]  
[TD][/TD]  
  
[TD][/TD]  
[/TR]  
[TR]  
[TD]iOs[/TD]  
[TD][/TD]  
  
[TD]x[/TD]  
[TD][/TD]  
  
[TD]x (on request)[/TD]  
[TD][/TD]  
  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Window[/TD]  
[TD]x[/TD]  
[TD][/TD]  
  
[TD]x (on request)[/TD]  
[TD]x (on request)[/TD]  
[TD][/TD]  
  
[TD][/TD]  
[/TR]  
[/TABLE]  
  
***To print a PDF with ESC/POS see***  
<https://www.b4x.com/android/forum/threads/b4x-b4xpages-pdf-to-image-b4xbitmap.142404/>  
  

---

  
  
**SD\_EscPosPrinter  
  
Author:** Star-Dust   
**Version:** 1.09  

- **BLE\_Printer**

- **Events:**

- **BLEoff**
- **Connected** (services As List)
- **Disconnected**
- **ImageWriteComplete**
- **PrinterFound** (Name As String, ID As String)
- **StateChanged** (msg As String)
- **WriteComplete** (Characteristic As String, Success As Boolean)

- **Fields:**

- **CharatteristicName** As String
- **Charset** As String
- **currentState** As Int
- **ServiceName** As String

- **Functions:**

- **AddTab** (ArrayTab As Int()) As String
 *Add Tab  
 eg. PrinterBLE.AddTab(Array As Byte(100,150,121))*- **Beep** (Times As Byte, SecondsDurate As Byte) As String
 *.Printer.Beep(1..9,1..9)*- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As String
- **Connect** (ID As String) As String
- **Disconnect** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **InitializePrinter** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **PrintBitmap** (bmp As Bitmap)
- **RightJustify** As String
 *after this command calls SendBufferToPrinter*- **ScanPrinter** As String
- **SetCodePage** (Code As Byte) As String
 *es. Printer.SetCodePage(06) for umlauts char*- **Write** (Text As String) As String
 *Write (Print) a Text*- **Write\_ArrayByte** (B As Byte()) As String
 *Write (Send to Printer) a Array of Byte  
 eg. PrinterBLE.Write\_ArrayByte(Array As Byte(0x1D,150,23))  
 eg. PrinterBLE.Write\_ArrayByte("Text".GetBytes("UTF8"))*- **WriteBarCode** (Code As String) As String
- **WriteBarCode2D** (Code As String) As String
- **WriteLine** (Text As String) As String
 *Write (Print) a Text + CHLF*- **WriteList** (list As List) As String
 *Write (Print) a List*
- **Properties:**

- **CodeTable**
 *es. printer.setCodeTable(Encoding.Code\_WPC1252)  
 aftet this command calls SendBufferToPrinter*- **isConnect** As Boolean [read only]
- **isScanning** As Boolean [read only]
- **Spacing**
 *after setSpacing command calls SendBufferToPrinter*
- **BT\_Printer**
*Note: AddPermission(android.permission.ACCESS\_COARSE\_LOCATION)*

- **Events:**

- **BluetoothIsDisabled**
- **ConnectedToPrint** (Success As Boolean)
- **DataReceived** (Buffer() As Byte)
- **DisconnectToPrint** (Mac As String)
- **DiscoveryComplete** (Printers As Map)
- **DiscoveryFinished**
- **DiscoveryNewPrinter** (PrintedFound As Map, DeviceClass As Int)
- **DiscoveryNoDeviceFound**
- **ErrorDiscovery**
- **ListPrinterAssociated** (ListNameAndMac As Map)
- **SendingError** (Mac As String)
- **SendTerminated**

- **Fields:**

- **Charset** As String
- **Const\_AUDIO\_VIDEO** As Int
- **Const\_COMPUTER** As Int
- **Const\_HEALTH** As Int
- **Const\_IMAGING** As Int
- **Const\_MISC** As Int
- **Const\_NETWORKING** As Int
- **Const\_PERIPHERAL** As Int
- **Const\_PHONE** As Int
- **Const\_TOY** As Int
- **Const\_UNCATEGORIZED** As Int
- **Const\_WEARABLE** As Int

- **Functions:**

- **AddBuffer\_ArrayByte** (B As Byte()) As String
- **AddBuffer\_BarCode** (Code As String) As String
- **AddBuffer\_BarCode2D** (Code As String) As String
- **AddBuffer\_Bitmap** (Bmp As Bitmap, ShiftLeft As Int) As String
- **AddBuffer\_BitmapAlternativeCoding** (Bmp As Bitmap) As String
- **AddBuffer\_List\_Write** (list As List) As String
- **AddBuffer\_List\_WriteLine** (list As List) As String
- **AddBuffer\_Tab** (ArrayTab As Int()) As String
- **AddBuffer\_Write** (Text As String) As String
- **AddBuffer\_WriteLine** (Text As String) As String
- **AddPrintDefineImage** As String
- **Beep** (Times As Byte, SecondsDurate As Byte) As String
 *.Printer.Beep(1..9,1..9)*- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As String
- **ClearBuffer** As String
- **Connected** As Boolean
- **ConnectFromMac** (Mac As String) As String
- **DefineImage** (Image As Bitmap)
- **Disconnect** As String
- **flushAllAndClose**
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **InitializePrinter** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **Preview** As Bitmap
- **ResetPreViewWidth** (NewWidth As Int) As String
- **RightJustify** As String
 *after this command calls SendBufferToPrinter*- **SearchFromAssociatedPrinter** As String
- **SearchNewPrinter** As String
 *select ——————————————–*- **SendBufferToPrinter**
- **SetCodePage** (Code As Byte) As String
 *es. Printer.SetCodePage(06) for umlauts char*- **WriteBarCode** (Code As String) As String
 *send to print immediately, do not preview - Not available in the demo version*- **WriteBarCode2D** (Code As String) As String
 *send to print immediately, do not preview - Not available in the demo version*- **WriteBitmap** (Bmp As Bitmap) As String
*send to print immediately, do not preview - Not available in the demo version*- **WriteByte** (Data As Byte()) As String
 *send to print immediately, do not preview - Not available in the demo version*- **WriteText** (Text As String) As String
 *send to print immediately, do not preview - Not available in the demo version*
- **Properties:**

- **CodeTable**
 *es. printer.setCodeTable(Encoding.Code\_WPC1252)  
 aftet this command calls SendBufferToPrinter*- **Spacing**
 *after setSpacing command calls SendBufferToPrinter*
- **ESC\_POS**
*Code module  
 Subs in this code module will be accessible from all modules.*

- **Fields:**

- **BoldOff** As String
- **BoldOn** As String
- **cn\_PDF417** As String
- **cn\_QRcode** As String
- **CutPaper** As String
- **CutPartialPaper** As String
- **CutTotalPaper** As String
- **Demo** As Boolean
- **DoubleOff** As String
- **DoubleOn** As String
- **FontA\_Bold** As String
- **FontA\_DoubleHight** As String
- **FontA\_DoubleWide** As String
- **FontA\_DoubleWideHeight** As String
- **FontA\_Normal** As String
- **FontB\_Bold** As String
- **FontB\_DoubleHeight** As String
- **FontB\_DoubleWide** As String
- **FontB\_DoubleWideHeight** As String
- **FontB\_Normal** As String
- **Horizzontal** As String
- **InitializePrinter** As String
- **ItalicFontOff** As String
- **ItalicFontOn** As String
- **NoUnderline** As String
- **QueryErrorCauses** As String
- **QueryOfflineCauses** As String
- **QueryPaperStatus** As String
- **QueryPrinterStatus** As String
- **Underline1** As String
- **Underline2** As String
- **Vertical** As String

- **Functions:**

- **feed** (lines As Int) As String
- **Process\_Globals** As String

- **Encoding**
*Code module  
 Subs in this code module will be accessible from all modules.*

- **Fields:**

- **CharSet\_Chinese** As String
- **CharSet\_ChineseS** As String
- **CharSet\_DOS\_Latin\_1** As String
- **CharSet\_IBM\_PC** As String
- **CharSet\_ISO8859** As String
- **CharSet\_UTF8** As String
- **CharSet\_Windows1252** As String
- **Code\_PC437** As Int
- **Code\_PC850** As Int
- **Code\_PC857** As Int
- **Code\_PC858** As Int
- **Code\_PC860** As Int
- **Code\_PC863** As Int
- **Code\_PC865** As Int
- **Code\_PC866** As Int
- **Code\_WPC1252** As Int

- **Functions:**

- **Process\_Globals** As String

- **LAN\_Printer**

- **Events:**

- **Connected** (Success As Boolean)
- **DataReceived** (Data() As Byte)
- **Diconnected**
- **ErrorTrasmission**

- **Fields:**

- **Charset** As String

- **Functions:**

- **AddTab** (ArrayTab As Int()) As String
 *Add Tab  
 eg. PrinterBLE.AddTab(Array As Byte(100,150,121))*- **Beep** (Times As Byte, SecondsDurate As Byte) As String
 *.Printer.Beep(1..9,1..9)*- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As String
- **Connect** (Host As String, Port As Int) As String
- **Disconnect** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **InitializePrinter** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LanConnection\_Connected** (Successful As Boolean) As String
- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **PrintBitmap** (bmp As Bitmap) As String
- **RightJustify** As String
 *after this command calls SendBufferToPrinter*- **SetCodePage** (Code As Byte) As String
 *es. Printer.SetCodePage(06) for umlauts char*- **Write** (Text As String) As String
 *Write (Print) a Text*- **Write\_ArrayByte** (B As Byte()) As String
 *Write (Send to Printer) a Array of Byte  
 eg. PrinterBLE.Write\_ArrayByte(Array As Byte(0x1D,150,23))  
 eg. PrinterBLE.Write\_ArrayByte("Text".GetBytes("UTF8"))*- **WriteBarCode** (Code As String) As String
- **WriteBarCode2D** (Code As String) As String
- **WriteLine** (Text As String) As String
 *Write (Print) a Text + CHLF*- **WriteList** (list As List) As String
 *Write (Print) a List*
- **Properties:**

- **CodeTable**
 *es. printer.setCodeTable(Encoding.Code\_WPC1252)  
 aftet this command calls SendBufferToPrinter*- **Spacing**
 *after setSpacing command calls SendBufferToPrinter*
- **RS\_Printer**

- **Fields:**

- **Charset** As String

- **Functions:**

- **AddTab** (ArrayTab As Int()) As String
 *Add Tab  
 eg. PrinterBLE.AddTab(Array As Byte(100,150,121))*- **Beep** (Times As Byte, SecondsDurate As Byte) As String
 *.Printer.Beep(1..9,1..9)*- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As String
- **Connect** (SerialDevOutput As String) As String
 *es. Connect("/dev/ttyAMA1")  
 es. Connect("/dev/ttyS0")*- **Disconnect** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **InitializePrinter** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **PrintBitmap** (bmp As Bitmap) As String
- **RightJustify** As String
 *after this command calls SendBufferToPrinter*- **SetCodePage** (Code As Byte) As String
 *es. Printer.SetCodePage(06) for umlauts char*- **Write** (Text As String) As String
 *Write (Print) a Text*- **Write\_ArrayByte** (B As Byte()) As String
 *Write (Send to Printer) a Array of Byte  
 eg. PrinterBLE.Write\_ArrayByte(Array As Byte(0x1D,150,23))  
 eg. PrinterBLE.Write\_ArrayByte("Text".GetBytes("UTF8"))*- **WriteBarCode** (Code As String) As String
- **WriteBarCode2D** (Code As String) As String
- **WriteLine** (Text As String) As String
 *Write (Print) a Text + CHLF*- **WriteList** (list As List) As String
 *Write (Print) a List*
- **Properties:**

- **CodeTable**
 *es. printer.setCodeTable(Encoding.Code\_WPC1252)  
 aftet this command calls SendBufferToPrinter*- **Spacing**
 *after setSpacing command calls SendBufferToPrinter*
- **USB\_Printer**

- **Events:**

- **WriteComplete**

- **Fields:**

- **Charset** As String

- **Functions:**

- **AddTab** (ArrayTab As Int()) As String
 *Add Tab  
 eg. PrinterBLE.AddTab(Array As Byte(100,150,121))*- **Beep** (Times As Byte, SecondsDurate As Byte) As String
 *.Printer.Beep(1..9,1..9)*- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As String
- **CloseConnection** As String
- **FindAdbDevice** As Boolean
- **HasPermission** As Boolean
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **InitializePrinter** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **OpenConnection** As String
- **PrintBitmap** (bmp As Bitmap) As String
- **RequestPermission** As String
- **RightJustify** As String
 *after this command calls SendBufferToPrinter*- **SetCodePage** (Code As Byte) As String
 *es. Printer.SetCodePage(06) for umlauts char*- **Write** (Text As String) As String
 *Write (Print) a Text*- **Write\_ArrayByte** (D As Byte()) As String
 *Write (Send to Printer) a Array of Byte  
 eg. PrinterBLE.Write\_ArrayByte(Array As Byte(0x1D,150,23))  
 eg. PrinterBLE.Write\_ArrayByte("Text".GetBytes("UTF8"))*- **WriteBarCode** (Code As String) As String
- **WriteBarCode2D** (Code As String) As String
- **WriteLine** (Text As String) As String
 *Write (Print) a Text + CHLF*- **WriteList** (list As List) As String
 *Write (Print) a List*
- **Properties:**

- **CodeTable**
 *es. printer.setCodeTable(Enoding.Code\_WPC1252)  
 aftet this command calls SendBufferToPrinter*- **Spacing**
 *after setSpacing command calls SendBufferToPrinter*
  

---

  
log release  

- 1.04

- Added **CutPartialPaper,** **CutTotalPaper** and **feed**(lines As Int) in esc\_pos.
- Added **WriteBitmap WriteByte WriteText -** send to print immediately

- 1.05

- Added conversions of color images to black and white for printing

- 1.06

- fixed LAN classbug

- 1.07

- Added **Beep** method

- 1.08

- Added **WriteBarCode, WriteBarCode2D** and for Printer\_BT also added **AddBarCode2d.** Other commands to print 2D barcodes compatible with some POS ESCs

- 1.09

- Disconnect method now flushes before closing