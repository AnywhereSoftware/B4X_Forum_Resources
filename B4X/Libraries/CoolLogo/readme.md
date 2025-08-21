###  CoolLogo by Erel
### 01/27/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/109011/)

![](https://www.b4x.com/basic4android/images/YCWm9FM15I.gif)  
(It is much smoother than in the above animated gif)  
  
A cross platform custom view based on XUI and BitmapCreator. It draws a moving line over the non-transparent parts of the image.  
  
It is done using a feature of BitmapCreator that builds a data structure with the information about non-transparent parts of the image.  
  
The custom view should be added with the designer. You then need to call SetBitmap to set the image.  
  
A B4J project is attached. The class is cross platform.  
Depends on: XUI and BitmapCreator libraries.  
  
Notes:  
  
In B4A you need to add this code in Activity\_Resume or the animation will not be resumed when the activity is resumed:  

```B4X
CoolLogo1.Visible = CoolLogo1.Visible
```

  
  
Another example:  
![](https://www.b4x.com/basic4android/images/HAAj2poujL.gif)  
<https://www.b4x.com/android/forum/threads/facebook-shimmer-effect-for-android.113390/#post-707425>