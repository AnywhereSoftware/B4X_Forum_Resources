### Barcode Scanner - 100% embedded within B4A (15 Feb 2016 : New library files in Post #105) by Johan Schoeman
### 06/26/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/60155/)

The attached project wraps [this Github project](https://github.com/LivotovLabs/CamView). It is a barcode scanner based on the ZXING project. I have successfully scanned the following 1D and 2D barcodes:  
1. Code 39  
2. Code 93  
3. Code 128  
4. Two-of-Five Interleaved (TFI)  
5. EAN13  
6. EAN8  
7. PDF417  
8. QR Code  
9. Aztec Code  
10. Codabar  
  
It is 100% embedded within the B4A project via a CustomView. Thus, you can add buttons, background images, background colors, labels, textviews, or whatever you like to the activity via the designer or via code. It does not have all the bells and whistles that the ZXING project offers (i.e ability to set the laser color etc) but it works 100% within B4A. It does not take over control of the B4A activity - set the size (width / height / left / top) of the CustomView in the B4A code and that will be the size of your barcode View Finder. Add buttons to start and stop the scanner. It is as simple as that.  
  
For as long as what the scanner is active it will scan 1D/2D barcodes i.e no need to stop and start the scanner to start scanning a new barcode. Just point the scanner at the next barcode to scan.  
  
I have added the following events to the B4A project:  
1. scanresult - here you can get the decoded string/text result when a successful scan occurred  
2. scanner\_started - this event is raised when the scanner is activated via B4A code  
3. scan\_error - sorry, but have not seen this event in action yet as I have had no miss scans thus far  
4. scanner\_stopped - this event is raised when the scanner is stopped.  
  
There are a number of files in the B4A project's Object/res/….. folders that are set to read only. Keep them like that.  
  
There are permissions added to the B4A manifest - make sure you take note of it should you start a new B4A project.  
  
You will need core-3.1.0.jar and android-support-v4.jar to be in your additional library folder. I have zipped them together - you can download them from [**HERE**](https://www.dropbox.com/s/43x0vuci19fx258/addToAdditionalLibrary.zip?dl=0). Extract them from the zipped file and copy them to your additional library folder.  
  
![](https://www.b4x.com/android/forum/attachments/38742)  
  
![](https://www.b4x.com/android/forum/attachments/38743)  
  
Some sample code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: zxScannerLiveView  
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
  
    Private zxslv As zxScannerLiveView  
    Private b1 As Button  
    Private b2 As Button  
    Private l1 As Label  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main")  
  
    zxslv.Initialize("zxslv")  
  
    Activity.AddView(zxslv, 50%x - 45%y, 5%y, 90%y, 90%y)  
  
    zxslv.HudVisible = True  
    zxslv.PlaySound = True  
    zxslv.Visible = False  
  
End Sub  
  
Sub Activity_Resume  
  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
    zxslv.Visible = False  
    zxslv.stopScanner  
  
End Sub  
  
Sub b1_Click  
  
    zxslv.Visible = True  
    zxslv.startScanner  
  
End Sub  
Sub b2_Click  
  
    zxslv.Visible = False  
    zxslv.stopScanner  
    l1.Text = ""  
  
End Sub  
  
Sub zxslv_scanresult  
  
    Log(zxslv.ScanResult)  
    l1.Text = zxslv.ScanResult  
  
End Sub  
  
Sub zxslv_scanner_started  
  
    Log("Scanner Started")  
  
End Sub  
  
Sub zxslv_scan_error  
  
    Log("Scan Error")  
  
End Sub  
  
Sub zxslv_scanner_stopped  
  
    Log("Scanner stopped")  
  
End Sub
```

  
  
  
And this will add a coloured frame around the view finder - making use of panels via B4A code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: zxScannerLiveView  
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
  
    Private zxslv As zxScannerLiveView  
    Private b1 As Button  
    Private b2 As Button  
    Private l1 As Label  
    Private l2, l3, l4, l5 As Label  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main")  
  
    zxslv.Initialize("zxslv")  
    Dim framecolor As Int = Colors.Red  
  
    l2.Initialize("")  
    l3.Initialize("")  
    l4.Initialize("")  
    l5.Initialize("")  
  
    Activity.AddView(zxslv, 50%x - 45%y, 5%y, 90%y, 90%y)  
    Activity.AddView(l2, 50%x - 45%y - 1%y, 4%y, 1%y, 92%y)  
    Activity.AddView(l3, 50%x + 45%y, 4%y, 1%y, 92%y)  
    Activity.AddView(l4, 50%x - 45%y - 1%y, 4%y, 91%y, 1%y)  
    Activity.AddView(l5, 50%x - 45%y - 1%y, 5%y + 90%y, 91%y, 1%y)  
  
  
    l2.Color = framecolor  
    l2.Visible = False  
  
    l3.Color = framecolor  
    l3.Visible = False  
  
    l4.Color = framecolor  
    l4.Visible = False  
  
    l5.Color = framecolor  
    l5.Visible = False  
  
    zxslv.HudVisible = True  
    zxslv.PlaySound = True  
    zxslv.Visible = False  
  
  
End Sub  
  
Sub Activity_Resume  
  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
    zxslv.Visible = False  
    zxslv.stopScanner  
  
    l2.Visible = False  
    l3.Visible = False  
    l4.Visible = False  
    l5.Visible = False  
  
End Sub  
  
Sub b1_Click  
  
    zxslv.Visible = True  
    zxslv.startScanner  
  
    l2.Visible = True  
    l3.Visible = True  
    l4.Visible = True  
    l5.Visible = True  
  
End Sub  
Sub b2_Click  
  
    zxslv.Visible = False  
    zxslv.stopScanner  
    l1.Text = ""  
  
    l2.Visible = False  
    l3.Visible = False  
    l4.Visible = False  
    l5.Visible = False  
  
  
  
End Sub  
  
Sub zxslv_scanresult  
  
    Log(zxslv.ScanResult)  
    l1.Text = zxslv.ScanResult  
  
End Sub  
  
Sub zxslv_scanner_started  
  
    Log("Scanner Started")  
  
End Sub  
  
Sub zxslv_scan_error  
  
    Log("Scan Error")  
  
End Sub  
  
Sub zxslv_scanner_stopped  
  
    Log("Scanner stopped")  
  
End Sub
```

  
  
It will look like this:  
  
![](https://www.b4x.com/android/forum/attachments/38748)  
  
****zxScannerLiveView  
Author:** Github: Dmitri Livotov, Wrapper: Johan Schoeman  
**Version:** 1  
  
  
  
**zxScannerLiveView  
Events:****   

- **scan\_error** ( )
- **scanner\_started** ( )
- **scanner\_stopped** ( )
- **scanresult** ( )

****Fields:****   

- **BACK As String**
- **FRONT As String**
- **ba As BA**
- **mfrontOrBack As String**

****Methods:****   

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
- **startScanner**
*Starts scanner, using device default camera*- **stopScanner**
*Stops currently running scanner*- **toggleFlash**

****Properties:****   

- **BackgroudImage As String** *[write only]*
- **Background As Drawable**
- **CameraToUse As String** *[write only]*
- **Color As Int** *[write only]*
- **Enabled As Boolean**
- **Height As Int**
- **HudVisible As Boolean** *[write only]*
- **Left As Int**
- **PlaySound As Boolean** *[write only]*
- **SameCodeRescanProtectionTime As Long** *[write only]*
- **ScanResult As String** *[read only]*
- **Tag As Object**
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**