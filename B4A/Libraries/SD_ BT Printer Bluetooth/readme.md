### SD: BT Printer Bluetooth by Star-Dust
### 10/16/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/85750/)

**[SIZE=6]ANNOUNCEMENT[/SIZE]**  
[SIZE=5]Starting today, this library will be abandoned and will **no longer be distributed**.  
A new, more comprehensive Android library for ESC/POS thermal printers will be released. *(BT, BLE, LAN, USB) (*[***here***](https://www.b4x.com/android/forum/threads/sd-escpos-printer-lan-usb-bluetooth-spp-ble.142512/)[/SIZE]*[SIZE=5])[/SIZE]*  
  

---

  
  
**(No WRAP, No Java Only B4A)   
BT\_Printer** library allows you to print text and image to a  
 thermal printers (Bluetooth and BLE) with **ESC/POS** language  
(For B4J versione see **[Here](https://www.b4x.com/android/forum/threads/sd-bluetooth-printer.103258/),** for B4i versione see **[Here](https://www.b4x.com/android/forum/threads/isd-ble-printer.103574/),**  for ZEBRA printer [**Here**](https://www.b4x.com/android/forum/threads/b4x-sd-zebra-printer.142094/))  
  
To print the QR CODES with your BT thermal printer you can create an image containing the QR code with the help of the [USER=1]@Erel[/USER] library ([**here**](https://www.b4x.com/android/forum/threads/b4x-qrgenerator-cross-platform-qr-code-generator.93092/)) or can use library of [USER=47104]@Johan Schoeman[/USER] (**[here](https://www.b4x.com/android/forum/threads/barcodes-qr-codes-pdf417-aztec-codes-code11-code39-code93-ean8-ean13-and-code128.57248/#post-360371)**)  
  
*WARNING:* *Make sure the library meets all your needs, is **compatible** with the printer you need to use.*  
**To try print with the demo version (rel. 0.21) you can only use the FlushAndClose command which lasts 14 days and then disables.  
The full version of the library will be issued to those making a donation *(Contact me in private before making a donation)*. In the donation indicate the library you want and your NickName. Those requesting the full version will receive updates for 3 months.**  
  
  
![](https://www.b4x.com/android/forum/attachments/71755) ![](https://www.b4x.com/android/forum/attachments/71781)  
  
  
**SD\_BT\_Printer  
  
Author:** Star-Dust  
**Version:** 0.21  

- **BLE\_Printer**

- **Events:**

- **Connected** (services As List)
- **Disconnected**
- **ImageWriteComplete**
- **PrinterFound** (Name As String, ID As String)
- **StateChanged** (msg As String)
- **WriteComplete** (Characteristic As String, Success As Boolean)

- **Fields:**

- **CharatteristicName** As String
- **currentState** As Int
- **ServiceName** As String

- **Functions:**

- **AddTab** (ArrayTab As Int()) As String
 *Add Tab  
 eg. PrinterBLE.AddTab(Array As Byte(100,150,121))*- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As String
- **Connect** (ID As String) As String
- **Initialize** (CallBack As Object, EventName As String, EncodingType As String) As String
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
- **WriteLine** (Text As String) As String
 *Write (Print) a Text + CHLF*- **WriteList** (list As List) As String
 *Write (Print) a List*
- **Properties:**

- **CodeTable**
 *es. printer.setCodeTable(Ecoding.Code\_WPC1252)  
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
- **AddBuffer\_Bitmap** (Bmp As Bitmap, ShiftLeft As Int) As String
- **AddBuffer\_BitmapAlternativeCoding** (Bmp As Bitmap) As String
- **AddBuffer\_List\_Write** (list As List) As String
- **AddBuffer\_List\_WriteLine** (list As List) As String
- **AddBuffer\_Tab** (ArrayTab As Int()) As String
- **AddBuffer\_Write** (Text As String) As String
- **AddBuffer\_WriteLine** (Text As String) As String
- **AddPrintDefineImage** As String
- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **ChangeEncoding** (EncodingType As String) As String
- **Class\_Globals** As String
- **ClearBuffer** As String
- **Close** As String
- **Connected** As Boolean
- **DefineImage** (Image As Bitmap)
- **flushAllAndClose**
- **Initialize** (CallBack As Object, EventName As String, EncodingType As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **InitializePrinter** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **Preview** As Bitmap
- **ResetPreViewWidth** (NewWidth As Int) As String
- **RightJustify** As String
 *after this command calls SendBufferToPrinter*- **SearchNewPrinter** As String
 *select ——————————————–*- **SelectFromAssociatedPrinter** As String
- **SelectFromMac** (Mac As String) As String
- **SendBufferToPrinter**
- **SetCodePage** (Code As Byte) As String
 *es. Printer.SetCodePage(06) for umlauts char*
- **Properties:**

- **CodeTable**
 *es. printer.setCodeTable(Ecoding.Code\_WPC1252)  
 aftet this command calls SendBufferToPrinter*- **Spacing**
 *after setSpacing command calls SendBufferToPrinter*
- **ESC\_POS**
*Code module  
 Subs in this code module will be accessible from all modules.*

- **Fields:**

- **BoldOff** As String
- **BoldOn** As String
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

- **Process\_Globals** As String

- **Encoding**
*Code module  
 Subs in this code module will be accessible from all modules.*

- **Fields:**

- **Chinese** As String
- **ChineseS** As String
- **Code\_PC437** As Int
- **Code\_PC850** As Int
- **Code\_PC857** As Int
- **Code\_PC858** As Int
- **Code\_PC860** As Int
- **Code\_PC863** As Int
- **Code\_WPC1252** As Int
- **DOS\_Latin\_1** As String
- **IBM\_PC** As String
- **ISO8859** As String
- **UTF8** As String
- **Windows1252** As String

- **Functions:**

- **Process\_Globals** As String