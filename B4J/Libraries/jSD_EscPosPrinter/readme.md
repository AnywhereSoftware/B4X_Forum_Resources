### jSD_EscPosPrinter by Star-Dust
### 04/11/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/162668/)

This library allows you to print text and image to a bluetooth thermal printers  
Works with Bluetooth and USB. For USB thermal printers you need the driver  
Dependence: **[jBluetooth](https://www.b4x.com/android/forum/threads/jbluetooth-library.60184/)**  
  
This version requires an activation code, to get an activation code ask privately.   
If you do not have a code, it will work in DEMO mode and you will be able to print only every 4 minutes.  
version requires an activation code.   
  
  
**jSD\_EscPosPrinter  
  
Author:** Star-Dust  
**Version:** 1.30  

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
- **CutPaper** As String
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
- **Connect** (Addr As String, Port As Int) As String
- **Disconnect** As String
- **Initialize** (CallBack As Object, EventName As String, CodeActivation As String) As String
*Initializes the object. You can add parameters to this method if needed.  
 Initilize("192.168.1.100",9100,"YourCode")*- **InitializePrinter** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LanConnection\_Connected** (Successful As Boolean) As String
- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **PrintBitmap** (bmp As Image) As String
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
- **USB\_Printer**

- **Fields:**

- **Constant** As Int

- **Functions:**

- **AddTab** (ArrayTab As Int()) As String
 *Add Tab  
 eg. PrinterBLE.AddTab(Array As Byte(100,150,121))*- **Beep** (Times As Byte, SecondsDurate As Byte) As String
 *.Printer.Beep(1..9,1..9)*- **CenterJustify** As String
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As String
- **Initialize** (printerName As String, CodeActivation As String) As String
 *Initilize("Printer","YourCode")*- **InitializePrinter** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LeftJustify** As String
 *after this command calls SendBufferToPrinter*- **PrintBitmap** (bmp As Image) As String
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
  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
**1.30** Add lan/wifi connection