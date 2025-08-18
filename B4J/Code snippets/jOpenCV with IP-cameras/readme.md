### jOpenCV with IP-cameras by peacemaker
### 11/10/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/135903/)

Hi, All  
  
After long trying and googling i have found that OpenCV with IP-cameras must work by special way.  
Regular way is to use "mVideoCapture.read(vcMat)", as recommended by the lib author (again ton of Thanks to him !), it's OK for stable stream of USB-camera:  
  
> **Video**: VideoCapture class makes all the work to capture webcam, saved videos or URL streams, and serve ready-to-process OCVMats.  
> Its usage is really simple:  
>
> ```B4X
>     Dim mVideoCapture as OCVVideoCapture  
>   
>     ' VideoCapture allows several initialization options, depending on what we want to open  
>     mVideoCapture.Initialize2( 0 )                             '<– Select webCam. Usually, 0 will be you laptop's integrated cam. If you have other USB-connected UVC cams, their index can be 1, 2,…  
>     mVideoCapture.Initialize1( myVideoPath )         '<– open a saved video.  
>     mVideoCapture.Initialize1( myStreamingURL )  '<– myStreamingURL can be any IPCam public IP address, or a movie's streaming URL, ..  
>   
>     ' In order to know if it has been able to open the stream…  
>     if Not(mVideoCapture.isOpened) Then  
>         Log("Could not open VideoCapture")  
>        return  
>     End if  
>   
>     ' Now we want to acquire frames to do "something" with them. Take into acocunt that the speed at which frames are delivered will depend on their source and nature.  
>     Dim vcMat as OCVMat  
>     If mVideoCapture.read(vcMat) Then  
>         Dim vc2 as OCVMat  
>        mCore.bitwise_not1( vcMat, vcMat2)  
>        Imageview1.SetImage( Utils.MatToBitmap(vcMat2) )  
>     End if  
>   
>     mVideoCapture.release        ' When we are done, just release the resources
> ```

  
But IP-camera frames may be with various delays due to the network latency, so the real way is always to get the very latest video frame at the current moment, after previous frame processing.  
And this can be done (if without the Threading lib, that i [could not make to work](https://www.b4x.com/android/forum/threads/135887/#content)) by the loop that makes the buffer empty:  

```B4X
    'instead of: Dim Captured As Boolean = mVideoCapture.read(vcMat)  
    'use:  
    For i = 0 To 30 'it's qty of the FPS of the IP-camera stream setting  
        mVideoCapture.grab    'grab all frames from buffer first without the decoding  
    Next  
    Dim Captured As Boolean = mVideoCapture.retrieve1(vcMat)    'decode the latest frame only
```

  
  
And such code will help to make video processing almost realtime, depending on the time of each frame processing.  
But all this is done in the main thread, so for several IP-cameras - only the threading lib should help to grab several stream frames ASAP (help for this is needed).