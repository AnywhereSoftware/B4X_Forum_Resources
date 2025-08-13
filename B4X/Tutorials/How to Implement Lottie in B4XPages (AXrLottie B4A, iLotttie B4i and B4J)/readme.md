### How to Implement Lottie in B4XPages (AXrLottie B4A, iLotttie B4i and B4J) by mcqueccu
### 02/16/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/160639/)

**[SIZE=6]This is B4XPages example for LOTTIE implementation on Android (B4A), iOS (B4I) and Desktop (B4J)[/SIZE]  
  
[SIZE=5]B4A Implementation[/SIZE]**  
Uses AXrLottie. Download the library and dependencies here: <https://www.b4x.com/android/forum/threads/axrlottie.126248/>  
  
**1. Libraries to Add:**  
AxrLottie  
Appcompat  
  
**2. Add this to MAIN**  

```B4X
    #Extends :  androidx.appcompat.app.AppCompatActivity
```

  
  
And this  
  

```B4X
#If java  
 static {  
     // load native rlottie library  
    System.loadLibrary("jlottie");  
 }  
#End If
```

  
  
**3. Add Appcompat Theme in Manifest**  
  

```B4X
SetApplicationAttribute(android:theme,"@style/AppTheme")  
CreateResource(values,styles.xml,  
<resources>  
    <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">  
        <item name="colorPrimary">#3F51B5</item>  
        <item name="colorPrimaryDark">#303F9F</item>  
        <item name="colorAccent">#FF4081</item>  
    </style>  
</resources>)
```

  
  
**4. Declare your Lottie and LottieView and Initialise**  

```B4X
    Dim AXrLottie As AXrLottie  
    Dim LottieView As AXrLottieImageView
```

  
  
**5. Initialise the lottieview and add it to Root or any panel you like and Display**  

```B4X
    LottieView.Initialize("")  
    pnlLottie.AddView(LottieView,0,0,pnlLottie.Width,pnlLottie.Height)  
    Dim Drawable As AXrLottieDrawableBuilder  
    Drawable.InitializeFromFile(File.DirInternal,"emoji_simple.json") _  
                .SetAutoRepeat(Drawable.AUTO_REPEAT_INFINITE) _  
                .SetAutoStart(True) _  
                .SetCacheEnabled(False)  
    LottieView.SetLottieDrawable(Drawable.Build)
```

  
  
  
**NOTE: Make sure to copy the lottie files (json) to Directory internal before you can use. It does not work form DirAssets**