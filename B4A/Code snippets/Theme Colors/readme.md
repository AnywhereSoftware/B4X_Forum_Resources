### Theme Colors by Erel
### 01/29/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/87716/)

Changing the action bar, status bar and navigation bar colors is done with resources set in the manifest editor.  
The following code is fully supported by Android 5+ devices but it will also work properly on Android 4 devices.  
  
![](https://www.b4x.com/basic4android/images/SS-2017-12-28_11.21.22.png)  
  
The manifest code:  

```B4X
SetApplicationAttribute(android:theme, "@style/LightTheme")  
CreateResource(values, colors.xml,  
<resources>  
    <color name="actionbar">#ff039be5</color>  
   <color name="statusbar">#ff006db3</color>  
   <color name="textColorPrimary">#ffffffff</color>  
   <color name="navigationBar">#ff006db3</color>  
</resources>  
)  
CreateResource(values, theme.xml,  
<resources>  
    <style name="LightTheme" parent="@android:style/Theme.Material.Light">  
        <item name="android:colorPrimary">@color/actionbar</item>  
        <item name="android:colorPrimaryDark">@color/statusbar</item>  
        <item name="android:textColorPrimary">@color/textColorPrimary</item>  
        <item name="android:navigationBarColor">@color/navigationBar</item>  
    </style>  
</resources>  
)
```

  
  
The colors are set in the first resources block. You can use the built-in color picker to get the values. Just change 0x to #.  
  
The project is attached.