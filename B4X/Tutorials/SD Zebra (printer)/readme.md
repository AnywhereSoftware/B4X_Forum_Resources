###  SD Zebra (printer) by Star-Dust
### 04/09/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/142094/)

This library is the result of my first approach with Zebra printers. I started by connecting via LAN (or Wi-Fi) ZPL language.  
I plan to connect via BLE and perhaps also via USB. Have a good time. **Preview** only works if you have an *internet connection*  
For ESC/POS Printer see [***here***](https://www.b4x.com/android/forum/threads/sd-escpos-printer-lan-usb-bluetooth-spp-ble.142512/)  
***The Demo version does not print images, barcodes, raw commands*  
  
NB**: This is a demo version, each print will show the SD symbol. Contact me privately for a full version.  
***Some Honeywell printers support the ZPL II language to make them compatible with Zebra and facilitate replacement. So this library might work on Honeywell as well***  
  
  

**Anyone who wants a different version from those distributed (such as Bluetooth SPP, USB, RS) can contact me privately.**

  
[TABLE]  
[TR]  
[TD]

**OS**

[/TD]  
  
[TD]

**Bluetooth SPP**

[/TD]  
  
[TD]

**BLE (Beacon)**

[/TD]  
  
[TD]

**USB**

[/TD]  
  
[TD]

**LAN / WIFI**

[/TD]  
  
[TD]

**RS 232**

[/TD]  
  
[TD]

**NFC**

[/TD]  
[/TR]  
[TR]  
[TD]

Android

[/TD]  
  
[TD]

x (On request)

[/TD]  
  
[TD]

x

[/TD]  
  
[TD]

x

[/TD]  
  
[TD]

x

[/TD]  
  
[TD][/TD]  
  
[TD][/TD]  
[/TR]  
[TR]  
[TD]

iOs

[/TD]  
  
[TD][/TD]  
  
[TD]

x

[/TD]  
  
[TD][/TD]  
  
[TD]

x

[/TD]  
  
[TD][/TD]  
  
[TD][/TD]  
[/TR]  
[TR]  
[TD]

Window

[/TD]  
  
[TD]

x (On request)

[/TD]  
  
[TD][/TD]  
  
[TD]

x

[/TD]  
  
[TD]

x

[/TD]  
  
[TD][/TD]  
  
[TD][/TD]  
[/TR]  
[/TABLE]  
  

---

  
  
**aSD\_Zebra  
  
Author:** Star-Dust  
**Version:** 1.12  

- **BLEZebraPrinter**

- **Events:**

- **BLEisOFF**
- **Connected** (services As List)
- **Disconnected**
- **ImageWriteComplete**
- **PrinterFound** (Name As String, ID As String)
- **StateChanged** (msg As String)
- **WriteComplete** (Characteristic As String, Success As Boolean)

- **Fields:**

- **CharatteristicName** As String
- **currentState** As Int
- **Encoding** As String
- **Rotate180** As String
- **Rotate270** As String
- **Rotate90** As String
- **RotateNormal** As String
- **ServiceName** As String

- **Functions:**

- **Active** (CodeActivation As String) As String
- **AddBarCode** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
*CODE 128  
 Zebra.AddBarCode(50,50,"1234567890",5)*- **AddBarCodeEAN13** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
*EAN13  
 Zebra.AddBarCodeEAN13(50,50,"1234567890",5)*- **AddCircle** (X As Int, Y As Int, radius As Int, StrokeWidth As Int, Filled As Boolean) As String
 *Zebra.AddCircle(50,50,25,3,false)*- **AddHorizLine** (X As Int, Y As Int, Width As Int, StrokeWidth As Int) As String
 *Zebra.AddHorizLine(50,50,700,3)*- **AddImage** (X As Int, Y As Int, bmp As B4XBitmap) As String
 *Zebra.AddImage() ' not active*- **AddLogoSD** (X As Int, Y As Int)
Add logo SD to coordinate- **AddQRcode** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
 *Zebra.AddQRcode(50,50,"1234567890",5)*- **AddRaw** (Text As String) As String
- **AddRectangle** (X As Int, Y As Int, Width As Int, Height As Int, StrokeWidth As Int, Filled As Boolean, InvertBrush As Boolean) As String
 *Zebra.AddRectangle(50,50,100,100,3,false,false)*- **AddRectangleRounded** (X As Int, Y As Int, Width As Int, Height As Int, StrokeWidth As Int, Filled As Boolean, Rounded As Int) As String
 *Zebra.AddRectangleRounded(50,50,100,100,3,false,5)*- **AddText** (X As Int, Y As Int, Text As String, TextSize As Int, Bold As Boolean) As String
 *Zebra.AddText(50,50,"Text",50, false)*- **AddTextRotate** (X As Int, Y As Int, Text As String, TextSize As Int, Bold As Boolean, Rotation As String) As String
 *Zebra.AddTextRotate(50,50,"Text",50, false,Zebra.RotateNormal)  
 Zebra.AddTextRotate(50,50,"Text",50, false,Zebra.Rotate90)*- **AddVertLine** (X As Int, Y As Int, Height As Int, StrokeWidth As Int) As String
 *Zebra.AddVertLine(400,100,300,3)*- **Class\_Globals** As String
- **Connect** (ID As String) As String
*CharatteristicName = "2AF0" or "2AF1"*- **Disconnect** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Preview** As String
 *Evito di usare okHttpUtils*- **Print** As String
- **ScanPrinter** As String
- **StopScanning** As String

- **Properties:**

- **isConnect** As Boolean [read only]
- **isScanning** As Boolean [read only]
- **LabelWidth**
- **Raw** As String [read only]
- **BlackRange**

- **LanZebraPrinter**

- **Events:**

- **Opened** (Success As Boolean)
- **Preview** (Success As Boolean, bmp As B4XBitmap)

- **Fields:**

- **desktop** As Int
- **Encoding** As String
- **Mobile** As Int
- **Rotate180** As String
- **Rotate270** As String
- **Rotate90** As String
- **RotateNormal** As String

- **Functions:**

- **Active** (CodeActivation As String) As String
- **AddBarCode** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
 *Code 128  
 Zebra.AddBarCode(50,50,"1234567890",5)*- **AddBarCodeEAN13** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
*EAN13  
 Zebra.AddBarCodeEAN13(50,50,"1234567890",5)*- **AddBarCodeEAN8** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
*EAN8  
 Zebra.AddBarCodeEAN8(50,50,"1234567890",5)*- **AddCircle** (X As Int, Y As Int, radius As Int, StrokeWidth As Int, Filled As Boolean) As String
 *Zebra.AddCircle(50,50,25,3,false)*- **AddHorizLine** (X As Int, Y As Int, Width As Int, StrokeWidth As Int) As String
 *Zebra.AddHorizLine(50,50,700,3)*- **AddImage** (X As Int, Y As Int, bmp As B4XBitmap) As String
 *Zebra.AddImage() ' not active*- **AddLogoSD** (X As Int, Y As Int)
Add logo SD to coordinate- **AddQRcode** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
 *Zebra.AddQRcode(50,50,"1234567890",5)*- **AddRaw** (Text As String) As String
- **AddRectangle** (X As Int, Y As Int, Width As Int, Height As Int, StrokeWidth As Int, Filled As Boolean, InvertBrush As Boolean) As String
 *Zebra.AddRectangle(50,50,100,100,3,false,false)*- **AddRectangleRounded** (X As Int, Y As Int, Width As Int, Height As Int, StrokeWidth As Int, Filled As Boolean, Rounded As Int) As String
 *Zebra.AddRectangleRounded(50,50,100,100,3,false,5)*- **AddText** (X As Int, Y As Int, Text As String, TextSize As Int, Bold As Boolean) As String
 *Zebra.AddText(50,50,"Text",50, false)*- **AddTextRotate** (X As Int, Y As Int, Text As String, TextSize As Int, Bold As Boolean, Rotation As String) As String
 *Zebra.AddTextRotate(50,50,"Text",50, false,Zebra.RotateNormal)  
 Zebra.AddTextRotate(50,50,"Text",50, false,Zebra.Rotate90)*- **AddVertLine** (X As Int, Y As Int, Height As Int, StrokeWidth As Int) As String
 *Zebra.AddVertLine(400,100,300,3)*- **Class\_Globals** As String
- **Clear** As String
- **Close** As String
- **Initialize** (Callback As Object, Event As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Open** (Host As String, TypePrinter As Int) As String
 *Zebra.Open("192.168.1.202",Zebra.desktop)*- **Preview** As String
 *Evito di usare okHttpUtils*- **Print** As String
- **PrintAndClose**

- **Properties:**

- **LabelWidth**
- **Raw** As String [read only]
- **BlackRange**

- **UsbZebraPrinter**

- **Events:**

- **Opened** (Success As Boolean)
- **Preview** (Success As Boolean, bmp As B4XBitmap)

- **Fields:**

- **desktop** As Int
- **Encoding** As String
- **Mobile** As Int
- **Rotate180** As String
- **Rotate270** As String
- **Rotate90** As String
- **RotateNormal** As String

- **Functions:**

- **Active** (CodeActivation As String) As String
- **AddBarCode** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
 *Code 128  
 Zebra.AddBarCode(50,50,"1234567890",5)*- **AddBarCodeEAN13** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
*EAN13  
 Zebra.AddBarCodeEAN13(50,50,"1234567890",5)*- **AddBarCodeEAN8** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
*EAN8  
 Zebra.AddBarCodeEAN8(50,50,"1234567890",5)*- **AddCircle** (X As Int, Y As Int, radius As Int, StrokeWidth As Int, Filled As Boolean) As String
 *Zebra.AddCircle(50,50,25,3,false)*- **AddHorizLine** (X As Int, Y As Int, Width As Int, StrokeWidth As Int) As String
 *Zebra.AddHorizLine(50,50,700,3)*- **AddImage** (X As Int, Y As Int, bmp As B4XBitmap) As String
 *Zebra.AddImage() ' not active*- **AddLogoSD** (X As Int, Y As Int)
Add logo SD to coordinate- **AddQRcode** (X As Int, Y As Int, Height As Int, Code As String, Size As Int) As String
 *Zebra.AddQRcode(50,50,"1234567890",5)*- **AddRaw** (Text As String) As String
- **AddRectangle** (X As Int, Y As Int, Width As Int, Height As Int, StrokeWidth As Int, Filled As Boolean, InvertBrush As Boolean) As String
 *Zebra.AddRectangle(50,50,100,100,3,false,false)*- **AddRectangleRounded** (X As Int, Y As Int, Width As Int, Height As Int, StrokeWidth As Int, Filled As Boolean, Rounded As Int) As String
 *Zebra.AddRectangleRounded(50,50,100,100,3,false,5)*- **AddText** (X As Int, Y As Int, Text As String, TextSize As Int, Bold As Boolean) As String
 *Zebra.AddText(50,50,"Text",50, false)*- **AddTextRotate** (X As Int, Y As Int, Text As String, TextSize As Int, Bold As Boolean, Rotation As String) As String
 *Zebra.AddTextRotate(50,50,"Text",50, false,Zebra.RotateNormal)  
 Zebra.AddTextRotate(50,50,"Text",50, false,Zebra.Rotate90)*- **AddVertLine** (X As Int, Y As Int, Height As Int, StrokeWidth As Int) As String
 *Zebra.AddVertLine(400,100,300,3)*- **Class\_Globals** As String
- **Clear** As String
- **getRaw** As String
- **Initialize** (Callback As Object, Event As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Preview** As String
 *Evito di usare okHttpUtils*- **Print** (printer As String) As String
- **PrintAndClose** (printer As String) As String
- **setLabelWidth** (Width As Int) As String

- **Properties:**

- **LabelWidth**
- **Raw** As String [read only]
- **BlackRange**

  
  

---

  
Update log  

- **1.01**

- Added printer type parameter on the **Open** method. It can be desktop or mobile printer
- Added **AddTextRotate** command. Enter constants to pass as parameter (RotateNormal, Rotate90, Rotate180, Rotate270)

- **1.02** Added method AddImage
- **1.03** Fix bugs
- **1.05** Added class for printing with BLE (BLE Not available for B4J)
- **1.06** Fix bugs
- **1.07** Added **AddBarCodeEAN13** method
- **1.08** Added **AddBarCodeEAN8** method and Fix Bug
- **1.09** Fix Bugs on authentication and streaming channel
- **1.10** Added USB communication in **B4J** version, Fix bugs QR code
- **1.11** Added **AddLogoSD** and **BlackRange** (Limit for the transformation between color and black and white images))
- **1.12** Added **UsbZebraPrinter** for Android