### ashImageZoom library by a n g l o
### 07/12/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/132478/)

this is the first time for me to upload a library, hope i'm doing it in the right section of the complex..  
i spent some time here looking (and testing) for a zoomable ImageView that behaves like an image in a WebView and like image display in samsung (and others) default gallery applications.  
i checked the first 2 i've found (there's more) and was disappointed to find that they don't follow that behavior.  
the problem is not in the zoom function. it's the behavior in the dragging. in the libs i've tested, the image can be dragged beyond its borders and can almost leave the container…  
  
so i wrote what i needed. i'm sure it's not perfect, but at least, as for the above dragging issue it behaves **exactly** as an image in a WebView and as in my samsung default gallery app.  
  
i've tried to upload with the demo, 2 huge 5184x3456 pixels images to demonstrate the coping with big images. well, i've learned that's such upload is not possible here.  
  
the library depends on [Informatix's Gesture Detector Library](https://www.b4x.com/android/forum/threads/lib-gesture-detector.21502/) .  
  
i want to thank Erel for the [following insight](https://www.b4x.com/android/forum/threads/b4x-bitmapsasync.119589/#post-748442) i've found.