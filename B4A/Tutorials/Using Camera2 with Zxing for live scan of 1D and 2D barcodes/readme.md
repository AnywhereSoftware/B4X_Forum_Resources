### Using Camera2 with Zxing for live scan of 1D and 2D barcodes by Johan Schoeman
### 04/19/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/116227/)

I have used [USER=1]@Erel[/USER]'s sample project from here:  
  
<https://www.b4x.com/android/forum/threads/camera2-still-images-and-videos.83920/>  
  
Have added a timer to get the preview bitmap every 300ms while the preview is active. Then used a bit of inline Java to decode the barcode image (1D and 2D) from preview frame. Preview frame is displayed in the imageview at the right top of the display. Also added a label to show the "text" extracted from the barcode(s).  
  
Just start the camera and point it to a barcode. No need to take a picture.  
  
Note this in the code:  

```B4X
#AdditionalJar: core-3.3.2.jar
```

  
  
Change it to your liking…..  
It will decode:  
UPC\_A  
UPC\_E  
EAN\_13  
EAN\_8  
CODABAR  
CODE\_39  
CODE\_93  
CODE\_128  
ITF  
RSS\_14  
RSS\_EXPANDED  
QR\_CODE  
DATA\_MATRIX  
AZTEC  
PDF417  
MAXICODE  
  
Extract the jar from core-3.3.2.zip and copy the jar to your additional libs folder.  
B4A sample project attached  
![](https://www.b4x.com/android/forum/attachments/91640)  
  
  
![](https://www.b4x.com/android/forum/attachments/91641)  
  
Sample code (Main):  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Camera2 Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalJar: core-3.3.2.jar  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: False  
#End Region  
#BridgeLogger: true  
  
Sub Process_Globals  
    Private frontCamera As Boolean = False  
    Private VideoMode As Boolean = False  
    Private VideoFileDir, VideoFileName As String  
    Private MyTaskIndex As Int  
    Private rp As RuntimePermissions  
     
    Dim nativeMe As JavaObject  
     
    Dim t As Timer  
     
End Sub  
  
Sub Globals  
    Private cam As CamEx2  
    Private pnlCamera As Panel  
    Private pnlPicture As Panel  
    Private pnlBackground As Panel  
    Private btnEffects As Button  
    Private btnScene As Button  
    Private buttons As List  
    Private btnAutoExposure As Button  
    Private btnFocus As Button  
    Private ProgressBar1 As ProgressBar  
    Private openstate, busystate As Boolean  
    Private btnRecord As Button  
    Private btnMode As Button  
    Private btnCamera As Button  
    Private barZoom As SeekBar  
    Private ImageView1 As ImageView  
    Private Label1 As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    nativeMe.InitializeContext  
    t.Initialize("t", 300)  
    VideoFileDir = rp.GetSafeDirDefaultExternal("")  
    VideoFileName = "1.mp4"  
    Activity.LoadLayout("1")  
    Activity.LoadLayout("StillPicture")  
    cam.Initialize(pnlCamera)  
    Log(cam.SupportedHardwareLevel)  
    buttons = Array(btnScene, btnAutoExposure, btnEffects, btnFocus, btnMode)  
    SetState(False, False, VideoMode)  
End Sub  
  
Sub Activity_Resume  
    OpenCamera(frontCamera)  
End Sub  
  
  
Sub OpenCamera (front As Boolean)  
    rp.CheckAndRequest(rp.PERMISSION_CAMERA)  
    Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
    If Result = False Then  
        ToastMessageShow("No permission!", True)  
        Return  
    End If  
     
    SetState(False, False, VideoMode)  
    Wait For (cam.OpenCamera(front)) Complete (TaskIndex As Int)  
    If TaskIndex > 0 Then  
        MyTaskIndex = TaskIndex 'hold this index. It will be required in later calls.  
        Wait For(PrepareSurface) Complete (Success As Boolean)  
        t.Enabled = True  
    End If  
    Log("Start success: " & Success)  
    SetState(Success, False, VideoMode)  
    If Success = False Then  
        ToastMessageShow("Failed to open camera", True)  
    End If  
End Sub  
  
Sub PrepareSurface As ResumableSub  
    SetState(False, busystate, VideoMode)  
    'sizes can be modified here  
    If VideoMode Then  
        cam.PreviewSize.Initialize(640, 480)  
        'Using a temporary file to store the video.  
        Wait For (cam.PrepareSurfaceForVideo(MyTaskIndex, VideoFileDir, "temp-" & VideoFileName)) Complete (Success As Boolean)  
    Else  
        cam.PreviewSize.Initialize(1920, 1080)  
        Wait For (cam.PrepareSurface(MyTaskIndex)) Complete (Success As Boolean)  
    End If  
    If Success Then cam.StartPreview(MyTaskIndex, VideoMode)  
    SetState(Success, busystate, VideoMode)  
    Return Success  
End Sub  
  
Sub btnCamera_Click  
    frontCamera = Not(frontCamera)  
    OpenCamera(frontCamera)  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    t.Enabled = False  
    cam.Stop  
     
End Sub  
  
Sub btnMode_Click  
    VideoMode = Not(VideoMode)  
    If VideoMode Then  
        rp.CheckAndRequest(rp.PERMISSION_RECORD_AUDIO)  
        Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
        If Result = False Then  
            ToastMessageShow("No permission!", True)  
            VideoMode = False  
        End If  
    End If  
    SetState(openstate, busystate, VideoMode)  
    PrepareSurface  
End Sub  
  
Sub btnRecord_Click  
    If VideoMode Then  
        CaptureVideo  
    Else  
        TakePicture  
    End If  
End Sub  
  
Sub CaptureVideo  
    Try  
        SetState(openstate, True, VideoMode)  
        If cam.RecordingVideo = False Then  
            cam.StartVideoRecording (MyTaskIndex)  
        Else  
            cam.StopVideoRecording (MyTaskIndex)  
            File.Copy(VideoFileDir, "temp-" & VideoFileName, VideoFileDir, VideoFileName)  
            ToastMessageShow($"Video file saved: $1.2{File.Size(VideoFileDir, VideoFileName) / 1024 / 1024} MB"$, True)  
            Wait For (PrepareSurface) Complete (Success As Boolean)  
            SetState(openstate, False, VideoMode)  
             
        End If  
    Catch  
        HandleError(LastException)  
    End Try  
End Sub  
  
Sub HandleError (Error As Exception)  
    Log("Error: " & Error)  
    ToastMessageShow(Error, True)  
    OpenCamera(frontCamera)  
End Sub  
  
Sub TakePicture  
    Try  
        SetState(openstate, True, VideoMode)  
        Wait For(cam.FocusAndTakePicture(MyTaskIndex)) Complete (Data() As Byte)  
        SetState(openstate, False, VideoMode)  
        cam.DataToFile(Data, VideoFileDir, "1.jpg")  
        Dim bmp As Bitmap = cam.DataToBitmap(Data)  
        Log("Picture taken: " & bmp) 'ignore  
        pnlBackground.SetVisibleAnimated(100, True)  
        pnlPicture.SetBackgroundImage(bmp.Resize(pnlPicture.Width, pnlPicture.Height, True)).Gravity = Gravity.CENTER  
        Sleep(4000)  
        pnlBackground.SetVisibleAnimated(500, False)  
    Catch  
        HandleError(LastException)  
    End Try  
     
End Sub  
  
Sub pnlPicture_Click  
    pnlBackground.Visible = False  
End Sub  
  
Sub btnEffects_Click  
    Dim effects As List = cam.SupportedEffectModes  
    Dim i As Int = effects.IndexOf(cam.EffectMode)  
    i = (i + 1) Mod effects.Size  
    cam.EffectMode = effects.Get(i)  
    btnEffects.Text = effects.Get(i)  
    cam.StartPreview(MyTaskIndex, VideoMode)  
End Sub  
  
Sub btnScene_Click  
    Dim scenes As List = cam.SupportedSceneModes  
    Dim i As Int = scenes.IndexOf(cam.SceneMode)  
    i = (i + 1) Mod scenes.Size  
    cam.SceneMode = scenes.Get(i)  
    btnScene.Text = scenes.Get(i)  
    cam.StartPreview(MyTaskIndex, VideoMode)  
End Sub  
  
Sub btnAutoExposure_Click  
    Dim flashes As List = cam.SupportedAutoExposureModes  
    Dim i As Int = flashes.IndexOf(cam.AutoExposureMode)  
    i = (i + 1) Mod flashes.Size  
    cam.AutoExposureMode = flashes.Get(i)  
    btnAutoExposure.Text = flashes.Get(i)  
    cam.StartPreview(MyTaskIndex, VideoMode)  
End Sub  
  
Sub btnFocus_Click  
    Dim focuses As List = cam.SupportedFocusModes  
    Dim i As Int = focuses.IndexOf(cam.FocusMode)  
    i = (i + 1) Mod focuses.Size  
    cam.FocusMode = focuses.Get(i)  
    btnFocus.Text = focuses.Get(i)  
    cam.StartPreview(MyTaskIndex, VideoMode)  
End Sub  
  
'This sub enables or disables the various UI elements based on the current state.  
Sub SetState(Open As Boolean, Busy As Boolean, Video As Boolean)  
    For Each b As Button In buttons  
        b.Visible = Open And Not(Busy)  
    Next  
    btnCamera.Visible = Not(Busy)  
    btnRecord.Visible = Open And (Video Or Not(Busy))  
    openstate = Open  
    ProgressBar1.Visible = Busy  
    busystate = Busy  
    VideoMode = Video  
    barZoom.Visible = Open  
    Dim btnRecordText As String  
    If VideoMode Then  
        If Busy Then  
            btnRecordText = Chr(0xF04D)  
        Else  
            btnRecordText = Chr(0xF03D)  
        End If  
    Else  
        btnRecordText = Chr(0xF030)  
    End If  
    btnRecord.Text = btnRecordText  
End Sub  
  
Sub barZoom_ValueChanged (Value As Int, UserChanged As Boolean)  
    Dim OriginalSize As Rect = cam.ActiveArraySize  
    Dim Zoom As Float = 1 + Value / 100 * (cam.MaxDigitalZoom - 1)  
    Dim Crop As Rect  
    Dim NewWidth As Int = OriginalSize.Width / Zoom  
    Dim NewHeight As Int = OriginalSize.Height / Zoom  
    Crop.Initialize(OriginalSize.CenterX - NewWidth / 2, OriginalSize.CenterY - NewHeight / 2, _  
        OriginalSize.CenterX + NewWidth / 2, OriginalSize.CenterY + NewHeight / 2)  
    cam.PreviewCropRegion = Crop  
    cam.StartPreview(MyTaskIndex, VideoMode)  
End Sub  
  
Sub t_tick  
     
    Dim mbm As Bitmap = cam.GetPreviewBitmap(480, 640)  
    ImageView1.Bitmap = mbm  
    Dim s As String = nativeMe.RunMethod("decodeQRImage", Array(mbm))  
    Label1.Text = s  
    Log("S = " & s)  
     
     
End Sub  
  
#if Java  
  
import com.google.zxing.MultiFormatWriter;  
import android.graphics.Bitmap;  
import com.google.zxing.common.BitMatrix;  
import com.google.zxing.BarcodeFormat;  
import com.google.zxing.WriterException;  
import com.google.zxing.qrcode.decoder.Version;  
  
import android.graphics.BitmapFactory;  
  
import com.google.zxing.BinaryBitmap;  
import com.google.zxing.ChecksumException;  
import com.google.zxing.FormatException;  
import com.google.zxing.LuminanceSource;  
import com.google.zxing.NotFoundException;  
import com.google.zxing.RGBLuminanceSource;  
import com.google.zxing.Reader;  
import com.google.zxing.Result;  
import com.google.zxing.common.HybridBinarizer;  
import com.google.zxing.qrcode.QRCodeReader;  
import com.google.zxing.MultiFormatReader;  
  
  
import android.util.Base64;  
import java.io.ByteArrayOutputStream;  
  
  
public String decodeQRImage(Bitmap bMap) {  
  
    String decoded = "";  
  
    int[] intArray = new int[bMap.getWidth() * bMap.getHeight()];  
    bMap.getPixels(intArray, 0, bMap.getWidth(), 0, 0, bMap.getWidth(),  
            bMap.getHeight());  
    LuminanceSource source = new RGBLuminanceSource(bMap.getWidth(),  
            bMap.getHeight(), intArray);  
    BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));  
  
     
    Reader reader = new MultiFormatReader();  
    try {  
     
        Result result = reader.decode(bitmap);  
        decoded = result.getText();  
        BA.Log("HERE");  
         
  
    } catch (NotFoundException e) {  
         BA.Log("NotFoundException: " + e.getMessage());  
    } catch (ChecksumException e) {  
        BA.Log("ChecksumException: " + e.getMessage());  
    } catch (FormatException e) {  
        BA.Log("FormatException: " + e.getMessage());  
    }  
    return decoded;  
}  
  
#End If
```