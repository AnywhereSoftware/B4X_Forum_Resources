### Google Vision/Play Services OCR example by KMatle
### 03/25/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/129067/)

1. Take Erel's QR/Barcode-Reader example: [QR](https://www.b4x.com/android/forum/threads/barcode-reader-based-on-google-play-services-vision.89705/#content)  
2. Change/add the following:  
  
In the manifest change the last line to "android:value="barcode,,**ocr**,,face""  

```B4X
'************ Google Play Services Base ************  
AddApplicationText(  
   <activity android:name="com.google.android.gms.common.api.GoogleApiActivity"  
  android:theme="@android:style/Theme.Translucent.NoTitleBar"  
  android:exported="false"/>  
    <meta-data  
  android:name="com.google.android.gms.version"  
  android:value="@integer/google_play_services_version" />  
)  
'************ Google Play Services Base (end) ************  
AddApplicationText(<meta-data  
    android:name="com.google.android.gms.vision.DEPENDENCIES"  
    android:value="barcode,,ocr,,face" />  
)
```

  
  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("1")  
    If FirstTime Then  
        CreateTextDetector  
    End If  
    cvs.Initialize(pnlDrawing)  
End Sub
```

  
  

```B4X
Private Sub CreateTextDetector  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    Dim builder As JavaObject  
    builder.InitializeNewInstance("com.google.android.gms.vision.text/TextRecognizer.Builder".Replace("/", "."), Array(ctxt))  
    Dim TextRecognizerClass As String = "com.google.android.gms.vision.text.TextRecognizer".Replace("/", ".")  
    Dim TextRecognizerStatic As JavaObject  
    TextRecognizerStatic.InitializeStatic(TextRecognizerClass)  
    textdetector = builder.RunMethod("build", Null)  
    Dim operational As Boolean = textdetector.RunMethod("isOperational", Null)  
    Log("Is detector operational: " & operational)  
End Sub
```

  
  

```B4X
Sub Camera1_Preview (data() As Byte)  
      
    If DateTime.Now > LastPreview + IntervalBetweenPreviewsMs Then  
        'Dim n As Long = DateTime.Now  
        cvs.ClearRect(cvs.TargetRect)  
        Dim frameBuildertext As JavaObject  
        frameBuildertext.InitializeNewInstance("com/google/android/gms/vision/Frame.Builder".Replace("/", "."), Null)  
        Dim cs As CameraSize = camEx.GetPreviewSize  
                  
        Dim bbtext As JavaObject  
        bbtext = bbtext.InitializeStatic("java.nio.ByteBuffer").RunMethod("wrap", Array(data))  
        frameBuildertext.RunMethod("setImageData", Array(bbtext, cs.Width, cs.Height,  17))  
                  
        Dim frametext As JavaObject = frameBuildertext.RunMethod("build", Null)  
          
        Dim SparseArrayText As JavaObject = textdetector.RunMethod("detect", Array(frametext))  
        LastPreview = DateTime.Now  
          
        Dim MatchesText As Int = SparseArrayText.RunMethod("size", Null)  
        For i = 0 To MatchesText - 1  
            Dim TextBlock As JavaObject = SparseArrayText.RunMethod("valueAt", Array(i))  
            Log(TextBlock.RunMethod("getValue", Null))  
        Next  
        Log("…")  
    End If  
      
End Sub
```

  
  
Scan-results (better if charset is not too big, I scanned the B4A forum's page (numbers are from the B4A window next to the browser window):  
  
> 381  
> 282  
> 103  
> Android Question Inserting anchors in a layout in Tabstrips  
> Makumbi Today at 628 AM  
> 184  
> e5  
> 06  
> 207  
> Android Question Split string - wierd behaviour (at least for me)  
> 108  
> mmanso Today at 8:19 AM  
> 109  
> Android Question FirebaseAuth - Error No Network Connection  
> Robert Valentino- Yesterday at 4:35 PM  
> 130  
> 111  
> 112  
> G Android Questieb java.lang.StringindexoutofBounds Exception: length=0; index=1  
> giagia-44 minutes ago  
> 113  
> 114  
> 115  
> Android Question Geocoder crashed B4A app [solved]  
> sChef Yesterday at 3:25 AM  
> Debug  
> Tipp: Ander  
> Android Question Don't understand the event flow of a widget