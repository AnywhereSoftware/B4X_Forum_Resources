### jSD: Bluetooth Printer by Star-Dust
### 09/14/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/103258/)

**BT\_Printer** library allows you to print text and image to a bluetooth thermal printers  
It is similar to the **[BT\_Printer](https://www.b4x.com/android/forum/threads/sd-bluetooth-printer.85750/#content)** library for Android (**[BLE\_Printer](https://www.b4x.com/android/forum/threads/isd-ble-printer.103574/)** for iOS), and implementations, events and methods are almost identical.  
We are working to have the same library for all platforms. On iOS it will be different because it uses BLE, but we will try to standardize the use.  
  
This version requires an activation code. If you do not have a code then it will work in DEMO mode and you will only be able to print every 4 minutes.  
  
Dependence: **[jBluetooth](https://www.b4x.com/android/forum/threads/jbluetooth-library.60184/)  
  
jSD\_BT\_Printer  
  
Author:** Star-Dust  
**Version:** 0.08  

- **BT\_Printer**

- **Events:**

- **BluetoothIsDisabled**
- **ConnectedToPrint** (Success As Boolean)
- **DataReceived** (Buffer() As Byte)
- **DiscoveryComplete** (Printers As Map)
- **DiscoveryFinished**
- **DiscoveryNewPrinter** (Name As String, MacAdress As String)
- **DiscoveryNoDeviceFound**
- **ErrorDiscovery**
- **SendingError** (Mac As String)

- **Functions:**

- **AddBuffer\_ArrayByte** (B As Byte()) As String
- **AddBuffer\_BarCode** (Code As String) As String
- **AddBuffer\_Bitmap** (Bmp As Image, ShiftLeft As Int) As String
- **AddBuffer\_List\_Write** (list As List) As String
- **AddBuffer\_List\_WriteLine** (list As List) As String
- **AddBuffer\_Tab** (ArrayTab As Int()) As String
- **AddBuffer\_Write** (Text As String) As String
- **AddBuffer\_WriteLine** (Text As String) As String
- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As String
- **ClearBuffer** As String
- **Close** As String
- **Connected** As Boolean
- **flushAllAndClose** As String
- **Initialize** (CallBack As Object, EventName As String, EncodingType As String, CodeActivation As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **RightJustify** As String
 *after this command calls SendBufferToPrinter*- **SearchNewPrinter** As String
- **SelectFromMac** (Mac As String) As String
- **SendBufferToPrinter**

- **Properties:**

- **Spacing**
 *after setSpacing command calls SendBufferToPrinter*
- **ESC\_POS**

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

  
  
  
****![](https://www.b4x.com/android/forum/attachments/78257)![](https://www.b4x.com/android/forum/attachments/78311)****