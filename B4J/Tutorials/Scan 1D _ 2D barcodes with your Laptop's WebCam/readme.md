### Scan 1D / 2D barcodes with your Laptop's WebCam by Johan Schoeman
### 05/21/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/148079/)

[**Go here**](https://www.b4x.com/android/forum/threads/webcam-class-how-to-choose-a-second-camera.143376/post-938499)……  
  
[**Take note of this in case you want to compile it to a standalone package.**](https://www.b4x.com/android/forum/threads/solved-module-b4j-does-not-declare-uses.148077/post-938527)  
  
Sample Code  

```B4X
#Region  Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
    '#MergeLibraries:True  
      
    #AdditionalJar : webcam-capture-0.3.12  
    #AdditionalJar: core-3.2.1  
    #AdditionalJar: javase-2.2  
    #AdditionalJar : slf4j-api-2.0.3.jar  
    #AdditionalJar : bridj-0.7.0  
    #PackagerProperty: AdditionalModuleInfoString = exports org.bridj;  
    #PackagerProperty: AdditionalModuleInfoString = exports org.bridj.cpp;  
    #PackagerProperty: AdditionalModuleInfoString = uses org.slf4j.spi.SLF4JServiceProvider;  
    #PackagerProperty: ExeName = ScanBarcode  
    #PackagerProperty: IconFile = ..\Files\qrcode.ico  
      
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Dim cam As SarxosWebCam  
    Private ImageView1 As ImageView  
    Dim timCamera As Timer  
    Dim defCamera As JavaObject  
    Dim nativeMe As JavaObject  
      
    Private Button1 As Button  
    Private Button2 As Button  
    Private Label1 As Label  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("MainLayout") 'Load the layout file.  
    MainForm.Show  
    cam.Initialize  
    nativeMe = Me  
      
    'Dim defCamera As JavaObject = cam.DefaultCam    'this was before, only one default camera is accesible !  
    'now we can get the cameras name list and choose  
    Dim L As List = cam.WebCam_Names  
  
    defCamera = cam.getWebcamByName(L.Get(0))    'let it be … again the first single webcam for text  
    Dim ViewSizes As List = cam.ViewSizes  
    Log(ViewSizes)  
      
    cam.setDimension2(defCamera, ViewSizes.Get(ViewSizes.Size - 1))    'set biggest    'cam.setDimension(defCamera, 640, 480)  
      
'    cam.OpenCam(defCamera)  
    'cam.TakePicture(def,"test2.png")     
    timCamera.Initialize("timCamera", 100)  
'    timCamera.Enabled = True  
End Sub  
  
  
Sub timCamera_Tick  
  
    ImageView1.SetImage(cam.TakePicture2(defCamera))  
    Try  
          
        Dim res As String = nativeMe.RunMethod("decode", Array(defCamera))  
        If res <> Null Then  
            Label1.Text = res  
              
        End If  
    Catch  
            LastException  
    End Try  
      
End Sub  
  
Private Sub Button1_Click  
      
    cam.OpenCam(defCamera)  
    timCamera.Enabled = True  
    Label1.Text = ""  
      
End Sub  
  
Private Sub Button2_Click  
      
    cam.CloseCam(defCamera)  
    timCamera.Enabled = False  
      
End Sub  
  
Private Sub Label1_MouseClicked (EventData As MouseEvent)  
      
    Label1.Text = ""  
      
End Sub  
  
  
#if Java  
  
import com.google.zxing.BinaryBitmap;  
import com.google.zxing.LuminanceSource;  
import com.google.zxing.MultiFormatReader;  
import com.google.zxing.Result;  
import com.google.zxing.NotFoundException;  
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;  
import com.google.zxing.common.HybridBinarizer;  
  
import javax.swing.*;  
import java.awt.*;  
import java.awt.image.BufferedImage;  
  
static Result result;  
public static String decode(com.github.sarxos.webcam.Webcam webcam) {  
            try {  
                BufferedImage image = webcam.getImage();  
                LuminanceSource source = new BufferedImageLuminanceSource(image);  
                BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));  
                result = null;  
                result = new MultiFormatReader().decode(bitmap);  
                if(result.getText() != null) {  
                    //BA.Log(result.getText());  
                }  
  
            }catch (NotFoundException e ) {  
                  
            }  
              
            return result.getText();         
}     
      
#End If
```

  
  

```B4X
'Class module  
Private Sub Class_Globals  
    Private fx As JFX  
    Private WebCam,ImageIO,BufferedImage,FileIO,Dimension As JavaObject  
    Private lstWebCams As List  
    Type WebCamDeviceDimension (width As Int, height As Int)  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
    ImageIO.InitializeStatic("javax.imageio.ImageIO")  
    WebCam.InitializeStatic("com.github.sarxos.webcam.Webcam")  
    BufferedImage.InitializeStatic("java.awt.image.BufferedImage")  
End Sub  
  
Public Sub getDefaultCam As JavaObject  
    WebCam=WebCam.RunMethod("getDefault",Null)  
    Return WebCam  
End Sub  
  
Public Sub setDimension(cam As JavaObject,width As Int,height As Int)  
    cam.RunMethod("setViewSize",Array(Dimension.InitializeNewInstance("java.awt.Dimension",Array(width,height))))  
End Sub  
  
Public Sub OpenCam(cam As JavaObject)  
    cam.RunMethod("open",Null)  
End Sub  
  
Public Sub TakePicture(cam As JavaObject,filename As String)  
    FileIO = FileIO.InitializeNewInstance("java.io.File",Array(filename))  
    BufferedImage=cam.RunMethod("getImage",Null)  
      
    ImageIO.RunMethod("write",Array(BufferedImage, "PNG", FileIO))  
      
    cam.RunMethod("close",Null)  
  
End Sub  
  
Public Sub TakePicture2(cam As JavaObject) As Image  
Try  
    Dim fxutils As JavaObject  
    fxutils.initializestatic("javafx.embed.swing.SwingFXUtils")  
    Dim im As Image = fxutils.runmethod("toFXImage", Array(cam.RunMethod("getImage", Null), Null))  
    Return im  
Catch  
    Log(LastException)  
    Return Null  
End Try         
      
End Sub  
  
Public Sub CloseCam(cam As JavaObject)  
    cam.RunMethod("close",Null)  
End Sub  
  
Sub getWebcams As List  
    Return WebCam.RunMethod("getWebcams",Null)  
End Sub  
  
Public Sub WebCam_Names() As List  
    lstWebCams = getWebcams  
    Dim names As List  
    names.Initialize  
    For i = 0 To lstWebCams.Size - 1  
        Dim newcam As JavaObject = lstWebCams.Get(i)  
        Dim name As String = getName(newcam)  
        names.Add(name)  
    Next  
    Return names  
End Sub  
      
Public Sub getWebcamByName(name As String) As JavaObject  
    WebCam = WebCam.RunMethodJO("getWebcamByName", Array As String(name))  
    Return WebCam  
End Sub  
  
Public Sub getName(cam As JavaObject) As String  
    Return cam.RunMethod("getName",Null)  
End Sub  
  
Private Sub getDevice(cam As JavaObject) As JavaObject  
    Return cam.RunMethod("getDevice",Null)  
End Sub  
  
Public Sub getViewSize() As JavaObject  
    Dim device As JavaObject = getDevice(WebCam)  
    Return device.RunMethodJO("getResolution",Null)  
End Sub  
  
Sub getViewSizes As List  
    Dim device As JavaObject = getDevice(WebCam)  
    Dim Dimensions() As Object = device.RunMethod("getResolutions",Null)  
    Dim L As List  
    L.Initialize  
    For i = 0 To Dimensions.Length - 1  
        Dim d As JavaObject  
        d.InitializeNewInstance("java.awt.Dimension", Array(0, 0))  
        d = Dimensions(i)  
        Dim dd As WebCamDeviceDimension  
        dd.Initialize  
        dd.width = d.GetField("width")  
        dd.height = d.GetField("height")  
        L.Add(dd)  
    Next  
    Return L  
End Sub  
  
Public Sub setDimension2(cam As JavaObject, NewDimension As WebCamDeviceDimension)  
    setDimension(cam, NewDimension.width, NewDimension.height)  
End Sub
```