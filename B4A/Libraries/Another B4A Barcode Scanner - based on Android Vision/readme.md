### Another B4A Barcode Scanner - based on Android Vision by Johan Schoeman
### 06/07/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/118768/)

Sure you will figure it out - check the B4A log when scanning a barcode  
  
Copy the .jar and .xml files to your B4A additional libs folder.  
  
B4A code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: jhsScanOnly  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
'    #MultiDex: True  
  
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
  
    Private bs1 As BillScanner  
    Private Button1 As Button  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
      
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main")  
      
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
      
      bs1.stopScanning  
        
End Sub  
  
Sub bs1_scan_value(val As String, rawbyte() As Byte, barcodetype As Int)  
      
    Log("Value = " & val)  
    Log("type = " & barcodetype)  
    Log(" ")  
      
End Sub  
  
Sub Button1_Click  
      
    bs1.startScanning  
      
End Sub
```

  
  
I guess you know how to make this "RuntimePermissions" compliant.  
  
Take note of this in the B4A Manifest file:  
  

```B4X
AddApplicationText(<meta-data  
            android:name="com.google.android.gms.version"  
            android:value="@integer/google_play_services_version" />  
        <meta-data  
            android:name="com.google.android.gms.vision.DEPENDENCIES"  
            android:value="barcode" />)
```

  
  
This is the scanner that I am using here…..  
  
<https://www.b4x.com/android/forum/threads/solved-need-assistance-with-rsa-decryption.118756/>  
  
Zxing does not work - this scanner (based on Android Vision) does the job.  
  
Enjoy…..;)