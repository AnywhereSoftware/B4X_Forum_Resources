### Firebase ML-Vision (OnDevice Text-, Barcode-,  Face-, Contour-Recognition and Imagelabeling) by DonManfred
### 12/27/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/105501/)

This is a wrap for the Firebase ML-Vision live detection of  
- Text  
- Barcodes  
- Faces  
- Facontour  
- and Imagelabeling.  
  
New in V0.8  
- Support for Cloudregocnition  
  
**FirebaseML  
Author:** DonManfred  
**Version:** 0.8  

- **CameraSourcePreview**

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (base As Panel, lw As Label, props As Map)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As android.graphics.Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized** As Boolean
- **release**
- **RemoveView**
- **RequestFocus** As Boolean
- **SendToBack**
- **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **start** (cameraSource As com.google.firebase.samples.mlkit.common.CameraSource)
- **start2** (cameraSource As com.google.firebase.samples.mlkit.common.CameraSource, overlay As com.google.firebase.samples.mlkit.common.GraphicOverlay)
- **stop**

- **Properties:**

- **Background** As android.graphics.drawable.Drawable
- **Color** As Int [write only]
- **Enabled** As Boolean
- **Height** As Int
- **Left** As Int
- **Padding** As Int()
- **Parent** As Object [read only]
- **Tag** As Object
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

- **FirebaseVisionImage**

- **Events:**

- **BarcodeDetected** (success As Boolean, Barcodes As List)
- **FaceContourDetected** (success As Boolean, contours As List)
- **FaceDetected** (success As Boolean, faces As List)
- **ImageLabeled** (success As Boolean, labels As List)
- **TextDetected** (success As Boolean, textlist As List)

- **Fields:**

- **BARCODE\_DETECTION** As String
- **CLASSIFICATION\_FLOAT** As String
- **CLASSIFICATION\_QUANT** As String
- **FACE\_CONTOUR** As String
- **FACE\_DETECTION** As String
- **IMAGE\_LABEL\_DETECTION** As String
- **TEXT\_DETECTION** As String

- **Functions:**

- **CreateMetadata** (width As Int, height As Int, format As Int, rotation As Int) As com.google.firebase.ml.vision.common.FirebaseVisionImageMetadata
*480x360 is typically sufficient for image recognition*- **Initialize** (EventName As String, camsrcpreview As com.google.firebase.samples.mlkit.common.CameraSourcePreview, overlay As com.google.firebase.samples.mlkit.common.GraphicOverlay, overlayBitmappathName As String, selectedModel As String)
- **onPause**
- **onResume**
- **start**
- **stop**
- **switchRecognizer** (recognizer As String)
*One of FACE\_DETECTION, FACE\_CONTOUR, TEXT\_DETECTION,  
 BARCODE\_DETECTION or IMAGE\_LABEL\_DETECTION*
- **Properties:**

- **CameraFacing** As Int [read only]
- **Facing** As Int [write only]
- **Img** As com.google.firebase.ml.vision.common.FirebaseVisionImage [read only]
- **ImgFormatNV21** As Int [read only]
- **ImgFormatYV12** As Int [read only]

- **GraphicOverlay**

- **Functions:**

- **add** (graphic As com.google.firebase.samples.mlkit.common.GraphicOverlay.Graphic)
*Adds a graphic to the overlay.*- **BringToFront**
- **clear**
*Removes all graphics from the overlay.*- **DesignerCreateView** (base As Panel, lw As Label, props As Map)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As android.graphics.Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized** As Boolean
- **remove** (graphic As com.google.firebase.samples.mlkit.common.GraphicOverlay.Graphic)
*Removes a graphic from the overlay.*- **RemoveView**
- **RequestFocus** As Boolean
- **SendToBack**
- **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
- **setCameraInfo** (previewWidth As Int, previewHeight As Int, facing As Int)
*Sets the camera attributes for size and facing direction, which informs how to transform image  
 coordinates later.*- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)

- **Properties:**

- **Background** As android.graphics.drawable.Drawable
- **Color** As Int [write only]
- **Enabled** As Boolean
- **Height** As Int
- **Left** As Int
- **Padding** As Int()
- **Parent** As Object [read only]
- **Tag** As Object
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

  
  
Setup:  
- Start the B4A SDKManager and update all recommended items. The Manager should download all Firebase-ML-Items…  
- Follow the Firebaseintegration tutorial for the needed Manifestentries.  
- Add this lines to your Mainmodule  

```B4X
#AdditionalJar: com.google.android.gms:play-services-base  
#AdditionalJar: com.google.android.gms:play-services-tasks  
#AdditionalJar: com.google.firebase:firebase-ml-vision  
#AdditionalJar: com.google.firebase:firebase-ml-vision-face-model  
#AdditionalJar: com.google.firebase:firebase-ml-vision-image-label-model  
#AdditionalJar: com.google.firebase:firebase-ml-common  
#AdditionalJar: com.google.firebase:firebase-ml-model-interpreter
```

  
- Create a layout with a CameraSourcePreview and a GraphicOverlay  
  
Example code  

```B4X
#AdditionalJar: com.google.android.gms:play-services-base  
#AdditionalJar: com.google.android.gms:play-services-tasks  
#AdditionalJar: com.google.firebase:firebase-ml-vision  
#AdditionalJar: com.google.firebase:firebase-ml-vision-face-model  
#AdditionalJar: com.google.firebase:firebase-ml-vision-image-label-model  
#AdditionalJar: com.google.firebase:firebase-ml-common  
#AdditionalJar: com.google.firebase:firebase-ml-model-interpreter  
  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private auth As FirebaseAuth  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Dim detector As FirebaseVisionImage  
    Private CameraSourcePreview1 As CameraSourcePreview  
    Private GraphicOverlay1 As GraphicOverlay  
    Private Button1 As Button  
    Private btnStop As Button  
    Private btnStart As Button  
    Private spRegognizers As Spinner  
    Private btnFacing As Button  
    Private camFacing As Int = 0  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    If FirstTime Then  
        auth.Initialize("auth")  
    End If  
    Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_CAMERA)  
    Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
    If Result = False Then  
        ToastMessageShow("No permission for Camera!", True)  
        'Return  
    End If  
    Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_WRITE_EXTERNAL_STORAGE)  
    Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
    If Result = False Then  
        ToastMessageShow("No permission for External Storage!", True)  
        'Return  
    End If  
  
    Activity.LoadLayout("Layout1")  
    spRegognizers.Clear  
    spRegognizers.Add(detector.BARCODE_DETECTION)  
    spRegognizers.Add(detector.TEXT_DETECTION)  
    spRegognizers.Add(detector.IMAGE_LABEL_DETECTION)  
    spRegognizers.Add(detector.FACE_DETECTION)  
    spRegognizers.Add(detector.FACE_CONTOUR)  
    detector.Initialize("MLVision",CameraSourcePreview1,GraphicOverlay1,File.Combine(File.DirAssets,"clown_nose.png"),detector.FACE_DETECTION)  
    detector.Facing = 0  
  
    If auth.CurrentUser.IsInitialized Then Auth_SignedIn(auth.CurrentUser)  
End Sub  
Sub MLVision_TextDetected(success As Boolean, texts As List)  
    If texts.IsInitialized And texts.Size > 0 Then  
        Log($"MLVision_TextDetected(${success}, ${texts.Size})"$)  
        For i=0 To texts.Size-1  
            Log(texts.Get(i))  
        Next  
    End If  
  
End Sub  
Sub MLVision_ImageLabeled(success As Boolean, labels As List)  
    If success And labels.IsInitialized And labels.Size > 0 Then  
        Log($"MLVision_ImageLabeled(${success}, ${labels.Size})"$)  
        For i=0 To labels.Size-1  
            Log(labels.Get(i))  
        Next  
    End If  
End Sub  
Sub MLVision_FaceDetected(success As Boolean, faces As List)  
    If faces.IsInitialized And faces.Size > 0 Then  
        Log($"MLVision_FaceDetected(${success}, ${faces.Size})"$)  
        For i=0 To faces.Size-1  
            Log(faces.Get(i))  
        Next  
    End If  
  
End Sub  
Sub MLVision_FaceContourDetected(success As Boolean, contours As List)  
    If contours.IsInitialized And contours.Size > 0 Then  
        Log($"MLVision_FaceContourDetected(${success}, ${contours.Size})"$)  
        For i=0 To contours.Size-1  
            'Log(contours.Get(i))  
        Next  
    End If  
End Sub  
Sub MLVision_BarcodeDetected(success As Boolean, Barcodes As List)  
    If success And Barcodes.IsInitialized And Barcodes.Size > 0 Then  
        Log($"MLVision_BarcodeDetected(${success}, ${Barcodes.Size})"$)  
        For i=0 To Barcodes.Size-1  
            Log(Barcodes.Get(i))  
        Next  
    End If  
End Sub  
Sub MLVision_DetectText(success As Boolean, info As String)  
    Log($"MLVision_DetectText(${success}, ${info})"$)  
End Sub  
Sub ReadFile(Dir As String, FileName As String) As Byte()  
    Dim out As OutputStream  
    out.InitializeToBytesArray(100) 'size not really important  
    File.Copy2(File.OpenInput(Dir, FileName), out)  
    Return out.ToBytesArray  
End Sub  
  
Sub Auth_SignedIn (User As FirebaseUser)  
    Log("SignedIn: " & User.DisplayName)  
End Sub  
Sub Activity_Resume  
    detector.onResume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    detector.onPause  
End Sub  
  
  
Sub Button1_Click  
    'Dim bytes() As Byte = ReadFile(File.DirAssets, "ilovecats.png")  
End Sub  
  
Sub btnStop_Click  
    detector.stop  
End Sub  
  
Sub btnStart_Click  
    detector.start  
End Sub  
  
Sub spRegognizers_ItemClick(Position As Int, Value As Object)  
    Log($"spRegognizers_ItemClick(${Position}, ${Value})"$)  
    detector.stop  
    detector.switchRecognizer(Value)  
    detector.start  
End Sub  
  
Sub btnFacing_Click  
    detector.stop  
    If camFacing = 0 Then  
        detector.Facing = 1  
        camFacing = 1  
    Else  
        detector.Facing = 0  
        camFacing = 0  
    End If  
    detector.start
```

  
  
Known issues:  
- I was not able to setup a detector for detecting an Image as of now. For now only the live detection is included.  
  
Notes:  
- The Included methods are ALL using "OnDevice-Recognition". For the ondevice-recognition a Free Firebase account should be OK.  
- I can implement also the Cloud-Methods i guess.But you need to have a PAID plan to use them. As of now no Cloudmethods are implemented/supported.  
  
Please create a new Thread in the Questionsforum for any Issue/Question you have.