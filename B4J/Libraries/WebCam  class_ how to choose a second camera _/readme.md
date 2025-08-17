### WebCam  class: how to choose a second camera ? by peacemaker
### 01/30/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/143376/)

Hi, All  
  
Thanks to the developer of SarxosWebCam wrapper !  
SarxosWebCam lib was updated to "[webcam-capture-0.3.12](https://github.com/sarxos/webcam-capture/blob/e61932d19b08dee1254ed987cd3d89dfe6fda0fe/webcam-capture/src/main/java/com/github/sarxos/webcam/Webcam.java#L839)", so i was trying and got success in updating the webcam class - we can choose any camera by the name.  
  
Extra .JARS (sorry, no store for files, they were googled one by one on the net):  
> #AdditionalJar : webcam-capture-0.3.12  
>  #AdditionalJar : slf4j-api-2.0.0.jar  
>  #AdditionalJar : bridj-0.6.2  
>  #PackagerProperty: AdditionalModuleInfoString = exports org.bridj;  
>  #PackagerProperty: AdditionalModuleInfoString = exports org.bridj.cpp;

  
  

```B4X
'v.0.3.12.3 by Peacemaker  
'Class module  
Private Sub Class_Globals  
    Private fx As JFX  
    Private WebCam,ImageIO,BufferedImage,FileIO,Dimension As JavaObject  
    Private lstWebCams As List  
    Type WebCamDeviceDimension (width As Int, height As Int)  
    Public CameraIsOpened As Boolean  
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
  
Public Sub setDimension(Cam As JavaObject,width As Int,height As Int)  
    Cam.RunMethod("setViewSize",Array(Dimension.InitializeNewInstance("java.awt.Dimension",Array(width,height))))  
End Sub  
  
Public Sub OpenCam(Cam As JavaObject)  
    Cam.RunMethod("open",Null)  
    CameraIsOpened = True  
End Sub  
  
Public Sub TakePicture(Cam As JavaObject,filename As String)  
    FileIO = FileIO.InitializeNewInstance("java.io.File",Array(filename))  
    BufferedImage=Cam.RunMethod("getImage",Null)  
    
    ImageIO.RunMethod("write",Array(BufferedImage, "PNG", FileIO))  
    
    Cam.RunMethod("close",Null)  
  
End Sub  
  
Public Sub TakePicture2(cam As JavaObject) As Image  
    Dim fxutils As JavaObject  
    fxutils.initializestatic("javafx.embed.swing.SwingFXUtils")  
    Dim im As Image = fxutils.runmethod("toFXImage", Array(cam.RunMethod("getImage", Null), Null))  
    Return im  
End Sub  
  
Public Sub CloseCam(cam As JavaObject)  
    cam.RunMethod("close",Null)  
    CameraIsOpened = False  
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
  
Public Sub getViewSize As JavaObject  
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
  
'set custom dimension  
Public Sub setDimension3(cam As JavaObject, width As Int, height As Int)  
    Dim Dims As JavaObject  
    Dims.InitializeArray("java.awt.Dimension", Array(Dimension.InitializeNewInstance("java.awt.Dimension",Array(width,height))))  
    cam.RunMethod("setCustomViewSizes", Array(Dims))    'add custom resolution into the list  
    setDimension(cam, width, height)    'set it  
End Sub
```