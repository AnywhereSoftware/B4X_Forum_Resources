### jOpenCV Tutorial 2 - Image & Video (with VideoCapture) acquisition, and conversions to/from Mat objects. by JordiCP
### 03/21/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/128934/)

[SPOILER=Some notes about the tutorials]  
From time to time, jOpenCV examples will be referenced in this tutorial. You can find the donwload link in the first post of the [**jOpenCV library**](https://www.b4x.com/android/forum/threads/jopencv-library-computer-vision-with-b4j.128902/#post-808720) thread  
Syntax: when referencing classes, sometimes we'll use by their native OpenCV syntax, or their jOpenCV counterpart (with OCV prefix), since what is explained is general and applies to both. In those cases where it only applies to one of both worlds, I'll do my best so that the context is clear enough .  
[/SPOILER]  
In this 2nd tutorial we'll learn some basic concepts that will be needed in most image processing projects.  
  
  
Since OpenCV deals with image processing, we need to start knowing how to 'translate' input images, videos or streams to the OpenCV world, do something with them, and if needed, save the results, converting them back to images or videos.  
  
The container for all them (being 'them' images or video frames) as Mats (OCVMat in jOpenCV). Somehow, OCVMats are the basic and most important objects around which most of the algorithms, from the most basic algebraic operations to Deep Neural Networks, need to 'store' information. Of course, there's a lot more than this.  
  
In order to do the basic conversions, there are a couple of simple routines in the Utils module in the examples (will be integrated as helper subs in next library versions)  
[SPOILER=Helper conversion Subs in Utils module (see examples)]  

```B4X
Sub MatToBitmap( myMat As OCVMat) As Image  
    Dim J As JavaObject = Me  
    Dim im1 As Object = J.RunMethod("convertBufferedToFX", Array(mHighGui.toBufferedImage(myMat)))  
    Return im1  
End Sub  
  
Sub BitmapToMat( img As B4XBitmap) As OCVMat  
    Dim J As JavaObject = Me  
    Dim im1 As Object = J.RunMethod("img2Mat", Array(img))  
    Return im1  
End Sub
```

  
[/SPOILER]  
  
  
**Images**  

```B4X
    Dim img as Image = LoadBitmap( File.DirAssets, "myimg.png")  
    Dim imgMat as OCVMat = Utils.BitmapToMat(img)               ' <– Now we have a Mat with the same number of rows, cols and planes as img, containing its pixel info.  
  
    Log( imgMat.toString )                                       ' Will get imgMat's basic info: rows, cols, type. For instance: 480,640, 8UC3  
    Log( imgMat.dump )                                           ' Will show numeric contents of imagMat  
  
    mImgProc.cvtColor1(imgMat, imgMat, mImgProc.COLOR_RGB2HSV)      ' Make an in-place color space conversion  
  
    ' For instance, we want to convert it back to an Image, to show or save it  
    Dim img2 as Image = Utils.MatToBitmap( img2 )
```

  
  
  
**Video**: VideoCapture class makes all the work to capture webcam, saved videos or URL streams, and serve ready-to-process OCVMats.  
Its usage is really simple:  

```B4X
    Dim mVideoCapture as OCVVideoCapture  
  
    ' VideoCapture allows several initialization options, depending on what we want to open  
    mVideoCapture.Initialize2( 0 )                             '<– Select webCam. Usually, 0 will be you laptop's integrated cam. If you have other USB-connected UVC cams, their index can be 1, 2,…  
    mVideoCapture.Initialize1( myVideoPath )         '<– open a saved video.  
    mVideoCapture.Initialize1( myStreamingURL )  '<– myStreamingURL can be any IPCam public IP address, or a movie's streaming URL, ..  
  
    ' In order to know if it has been able to open the stream…  
    if Not(mVideoCapture.isOpened) Then  
        Log("Could not open VideoCapture")  
       return  
    End if  
  
    ' Now we want to acquire frames to do "something" with them. Take into acocunt that the speed at which frames are delivered will depend on their source and nature.  
    Dim vcMat as OCVMat  
    If mVideoCapture.read(vcMat) Then  
        Dim vc2 as OCVMat  
       mCore.bitwise_not1( vcMat, vcMat2)  
       Imageview1.SetImage( Utils.MatToBitmap(vcMat2) )  
    End if  
  
    mVideoCapture.release        ' When we are done, just release the resources
```