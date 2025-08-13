### iSD BLE Printer by Star-Dust
### 05/07/2023
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/103574/)

I am happy to present my library to print with Iphone (and iPad) with Bluetooh (BLE). Now I can print the images. If you want to have the activation code (Freeing all the functions) contact me in private.  
(For B4J versione see **[Here](https://www.b4x.com/android/forum/threads/sd-bluetooth-printer.103258/),** for B4A versione see **[Here](https://www.b4x.com/android/forum/threads/sd-bluetooth-printer.85750/)**, for ZEBRA printer [**Here**](https://www.b4x.com/android/forum/threads/b4x-sd-zebra-printer.142094/))  
  
This version requires an activation code. If you don't have a code, it will work in DEMO mode and you can print for just one minute every 4 minutes.  
  
  
**iSD\_BLE\_Printer  
  
Author:** Star-Dust  
**Version:** 0.25  

- **BLE\_Printer**

- **Events:**

- **Connected** (services As List)
- **Disconnected**
- **ImagePrintingCompleted**
- **PrinterFound** (Name As String, ID As String)
- **WriteComplete** (Characteristic As String, Success As Boolean)

- **Fields:**

- **CharatteristicName** As NSString\*
- **ServiceName** As NSString\*

- **Functions:**

- **AddTab** (ArrayTab As Int()) As NSString\*
 *Add Tab  
 eg. PrinterBLE.AddTab(Array As Byte(100,150,121))*- **CenterJustify** As NSString\*
 *after this command calls SendBufferToPrinter*- **Class\_Globals** As NSString\*
- **Connect** (ID As NSString\*) As NSString\*
- **Initialize** (ba As B4I\*, CallBack As NSObject\*, EventName As NSString\*, EncodingType As NSString\*, CodeActivation As NSString\*) As NSString\*
*Initializes the object. You can add parameters to this method if needed.*- **InitializePrinter** As NSString\*
- **IsInitialized** As BOOL
*Verifica se l'oggetto sia stato inizializzato.*- **LeftJustify** As NSString\*
 *after this command calls SendBufferToPrinter*- **PrintBitmap** (bmp As B4IBitmap\*)
- **RightJustify** As NSString\*
 *after this command calls SendBufferToPrinter*- **ScanPrinter** As NSString\*
- **SetCodePage** (Code As Unsigned char) As NSString\*
 *es. Printer.SetCodePage(06) for umlauts char*- **Write** (Text As NSString\*) As NSString\*
 *Write (Print) a Text*- **Write\_ArrayByte** (B As Unsigned char()) As NSString\*
 *Write (Send to Printer) a Array of Byte  
 eg. PrinterBLE.Write\_ArrayByte(Array As Byte(0x1D,150,23))  
 eg. PrinterBLE.Write\_ArrayByte("Text".GetBytes("UTF8"))*- **WriteBarCode** (Code As NSString\*) As NSString\*
- **WriteLine** (Text As NSString\*) As NSString\*
 *Write (Print) a Text + CHLF*- **WriteList** (list As B4IList\*) As NSString\*
 *Write (Print) a List*
- **Properties:**

- **CodeTable**
 *es. printer.setCodeTable(Ecoding.Code\_WPC1252)  
 aftet this command calls SendBufferToPrinter*- **isConnect** As BOOL [read only]
- **Spacing**
 *after setSpacing command calls SendBufferToPrinter*
- **ESC\_POS**

- **Fields:**

- **BoldOff** As NSString\*
- **BoldOn** As NSString\*
- **DoubleOff** As NSString\*
- **DoubleOn** As NSString\*
- **FontA\_Bold** As NSString\*
- **FontA\_DoubleHight** As NSString\*
- **FontA\_DoubleWide** As NSString\*
- **FontA\_DoubleWideHeight** As NSString\*
- **FontA\_Normal** As NSString\*
- **FontB\_Bold** As NSString\*
- **FontB\_DoubleHeight** As NSString\*
- **FontB\_DoubleWide** As NSString\*
- **FontB\_DoubleWideHeight** As NSString\*
- **FontB\_Normal** As NSString\*
- **Horizzontal** As NSString\*
- **InitializePrinter** As NSString\*
- **NoUnderline** As NSString\*
- **QueryErrorCauses** As NSString\*
- **QueryOfflineCauses** As NSString\*
- **QueryPaperStatus** As NSString\*
- **QueryPrinterStatus** As NSString\*
- **Underline1** As NSString\*
- **Underline2** As NSString\*
- **Vertical** As NSString\*

- **Functions:**

- **Process\_Globals** As NSString\*
*Code module  
 Subs in this code module will be accessible from all modules.*
- **Encoding**

- **Fields:**

- **Chinese** As NSString\*
- **ChineseS** As NSString\*
- **Code\_PC437** As Int
- **Code\_PC850** As Int
- **Code\_PC857** As Int
- **Code\_PC858** As Int
- **Code\_PC860** As Int
- **Code\_PC863** As Int
- **Code\_WPC1252** As Int
- **DOS\_Latin\_1** As NSString\*
- **IBM\_PC** As NSString\*
- **ISO8859** As NSString\*
- **UTF8** As NSString\*
- **Windows1252** As NSString\*

- **Functions:**

- **Process\_Globals** As NSString\*
*Code module  
 Subs in this code module will be accessible from all modules.*