### [Class] CameraEx - Extends the camera library functionality by Erel
### 12/29/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/23801/)

Example based on B4XPages: <https://www.b4x.com/android/forum/threads/b4x-b4xpages-barcode-reader.120417/#content>  
  
CameraEx class wraps the Camera object and using reflection and other code it extends its functionality.  
  
CameraEx class requires Android 2.3+ and depends on [Camera library v2.20](http://www.b4x.com/forum/additional-libraries-classes-official-updates/23799-camera-library-v2-00-a.html#post137747)+  
CameraEx features:  

- Easily open the back or front camera
- Preview images and saved images orientation will match the device orientation (all orientations are supported)
- Gives access to Camera.Parameters native class (flashmode, picture size, effects and other settings)
- Includes methods to convert preview images to JPEG and to save the taken pictures.
- It should be simple to add more methods to this class

  
![](http://www.b4x.com/basic4android/images/SS-2012-11-28_12.18.31.png)  
  
See this page for the constant values and other possible methods:  
<https://developer.android.com/reference/android/hardware/Camera.Parameters.html>  
  
Note that you should call CommitParameters after changing one or more parameters.  
  
CameraExClass module is included in the attached example.  
  
V1.30 is attached - Includes various new methods.  
  
v1.20 - Includes all the various posts in this thread as well as AutoFocusAndTakePicture method which first calls AutoFocus and then takes a picture (if AutoFocus was successful).  
  
**Edit (06/2018):** A new version was uploaded with targetSdkVersion set to 26.