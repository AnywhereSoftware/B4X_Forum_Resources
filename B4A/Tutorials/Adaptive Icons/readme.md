### Adaptive Icons by Erel
### 10/25/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/95244/)

Updated instructions are available here: <https://www.b4x.com/android/forum/threads/adaptive-icons-simple-instructions-and-tips.123843/>  
  
Starting from Android 8 apps should include an adaptive icon. Without it the icon will appear as a small icon inside the larger template:  
  
![](https://www.b4x.com/basic4android/images/SS-2018-07-18_11.09.51.png)  
  
(B4A designer still uses an older targetSdkVersion so it is not affected.)  
  
Adaptive icons are explained here: [MEDIA=medium]515af294c783[/MEDIA]  
  
The steps required are:  
  
1. Create a folder under Objects\res named mipmap. It should include three files:  
  
![](https://www.b4x.com/basic4android/images/SS-2018-07-18_11.13.06.png)  
  
The two adaptive icon layers and a file named ic\_launcher.png with the old icon. The old icon will be used on Android 7- devices.  
  
2. Make sure that all three files are read-only. Otherwise they will be deleted during compilation.  
  
3. Add to the manifest editor:  
  

```B4X
SetApplicationAttribute(android:icon, "@mipmap/ic_launcher")  
CreateResource(mipmap-anydpi-v26, ic_launcher.xml,  
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">  
    <background android:drawable="@mipmap/background"/>  
    <foreground android:drawable="@mipmap/foreground"/>  
</adaptive-icon>  
)
```

  
  
4. Delete this line from the manifest editor:  

```B4X
SetApplicationAttribute(android:icon, "@drawable/icon") 'delete
```