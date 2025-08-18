### Adaptive Icons - simple instructions and tips by Erel
### 12/23/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/123843/)

All apps should have an adaptive icon. If you are not familiar with these icons then start here: [Adaptive Icons](https://www.b4x.com/android/forum/threads/95244/#content)   
  
Instruction steps:  

1. Create a new folder in the root project folder named icon.
2. Create two folders inside that folder with the following files:

1. mipmap:

1. ic\_launcher.png - non-adaptive icon for Android 7- devices. There is no specific size. Should be 128x128 or or more.
2. background.png - 108x108 - the solid background layer.
3. foreground.png - 108x108 - the foreground layer.

2. mipmap-xxxhdpi (high resolution images):

1. background.png - 432x432 - solid background layer
2. foreground.png - 432x432 - foreground layer

3. Add to main module:

```B4X
#AdditionalRes: ../icon
```

4. Add to manifest editor:

```B4X
SetApplicationAttribute(android:icon, "@mipmap/ic_launcher")  
CreateResource(mipmap-anydpi-v26, ic_launcher.xml,  
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">  
<background android:drawable="@mipmap/background"/>  
<foreground android:drawable="@mipmap/foreground"/>  
</adaptive-icon>  
)
```


No need to set any file to be read-only.  
  
Example: <https://github.com/AnywhereSoftware/B4X-Pleroma/tree/master/B4A>