### 1D and 2D Barcode Scanner with ZBAR - another Barcode Scanner that is 100% embedded in B4A by Johan Schoeman
### 12/14/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/63794/)

The attached project wraps the ZBAR part of [**this Github project**](https://github.com/dm77/barcodescanner). It looks very much the same as the project that I have [**posted here**](https://www.b4x.com/android/forum/threads/1d-and-2d-barcode-scanner-with-zxing-another-barcode-scanner-that-is-100-embedded-in-b4a.63764/). Both projects use the same ViewFinder but they use different decoding engines (ZXING and ZBAR respectively).  
  
I have not tested all the barcode formats but it should scan the following types:  
  
BarcodeFormat.PARTIAL  
BarcodeFormat.EAN8  
BarcodeFormat.UPCE  
BarcodeFormat.ISBN10  
BarcodeFormat.UPCA  
BarcodeFormat.EAN13  
BarcodeFormat.ISBN13  
BarcodeFormat.I25  
BarcodeFormat.DATABAR  
BarcodeFormat.DATABAR\_EXP  
BarcodeFormat.CODABAR  
BarcodeFormat.CODE39  
BarcodeFormat.PDF417  
BarcodeFormat.QRCODE  
BarcodeFormat.CODE93  
BarcodeFormat.CODE128  
  
There seems to be an issue with the scanning of PDF417 codes. I have emailed the author of the Github project (Dushyanth Maguluru) and brought it to his attention. Will update and post new library files once the issue with PDF417 codes has been resolved.  
  
EDIT 26 Feb 2016: See this post as far as scanning of PDF417 is concerned  
<https://sourceforge.net/p/zbar/support-requests/76/>  
  
 **Please take note of the xml files in the /Objects/res/layout and Objects/res/values folders of the B4A project should you start a new project from scratch.**  
  
Posting the following:  
1. B4A project demonstrating the Barcode Scanner using the ZBAR decoder  
2. Library files - you need to download them from [**this link**](https://www.dropbox.com/s/8kfyg5jkt51q4js/ZbarBarcodeScannerLibFiles.zip?dl=0) (too big to upload to this post) - unzip them and copy them to your additional library folder  
  
  
  
![](https://www.b4x.com/android/forum/attachments/41746)  
  
Sample code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: ZbarBarcodeScanner  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: landscape  
    #CanInstallToExternalStorage: False  
  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private zb1 As ZbarBarcodeScanner  
    Private b1 As Button  
    Private b2 As Button  
    Private b3 As Button  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main")  
  
    zb1.LaserColor = Colors.Yellow  
    zb1.MaskColor = Colors.ARGB(150, 0, 0, 200)  
    zb1.BorderColor = Colors.Magenta  
    zb1.BorderStrokeWidth = 5  
    zb1.BorderLineLength = 40  
    zb1.Visible = False  
  
End Sub  
  
Sub Activity_Resume  
  
'   zb1.startScanner  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
    zb1.stopScanner  
    zb1.Visible = False  
  
End Sub  
  
Sub b1_Click  
  
    zb1.toggleFlash  
  
End Sub  
  
Sub b2_Click  
    zb1.Visible = True  
    zb1.startScanner  
  
End Sub  
  
Sub b3_Click  
    zb1.Visible = False  
    zb1.stopScanner  
  
End Sub  
  
  
  
Sub zb1_scan_result(scantext As String, scanformat As String)  
  
    Log("B4A scantext = " & scantext)  
    Log("B4A scanformat = " & scanformat)  
  
End Sub
```

  
  
  
The library:  
  
**ZbarBarcodeScanner  
Author:** Github: Dushyanth Maguluru, Wrapped by: Johan Schoeman  
**Version:** 1  

- **ZbarBarcodeScanner**
Events:

- **scan\_result** (scantext As String, scanformat As String)

**Fields:**

- **ba As BA**

**Methods:**

- **BringToFront**
- **DesignerCreateView** (base As PanelWrapper, lw As LabelWrapper, props As Map)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized As Boolean**
- **RemoveView**
- **RequestFocus As Boolean**
- **SendToBack**
- **SetBackgroundImage** (arg0 As Bitmap)
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **handleResult** (rawResult As Result)
- **startScanner**
- **stopScanner**
- **toggleFlash**

**Permissions:**

- android.permission.CAMERA
- android.permission.FLASHLIGHT

**Properties:**

- **Background As Drawable**
- **BorderColor As Int** *[write only]*
- **BorderLineLength As Int** *[write only]*
- **BorderStrokeWidth As Int** *[write only]*
- **Color As Int** *[write only]*
- **Enabled As Boolean**
- **Height As Int**
- **LaserColor As Int** *[write only]*
- **Left As Int**
- **MaskColor As Int** *[write only]*
- **Tag As Object**
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**

  
  
  
You can use it in portrait mode and landscape mode by changing the B4A project's attribute and the code in the Designer:  
#SupportedOrientations: portrait