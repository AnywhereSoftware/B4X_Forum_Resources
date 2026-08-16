### Themes manifest macros - fix for light navigation bar by Erel
### 08/13/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171792/)

This is not a library. This jar holds the two theme snippets:  

```B4X
CreateResourceFromFile(Macro, Themes.LightTheme) 'or DarkTheme
```

  
  
With Edge to Edge + light theme (default) and when the navigation mode is set to navigation bar, the buttons appear with light color on white background, and are invisible.  
  
This jar fixes the issue by adding: <item name="android:windowLightNavigationBar">true</item>  
The updated light theme, which is the one affected is:  

```B4X
SetApplicationAttribute(android:theme, "@style/LightTheme")  
CreateResource(values-v20, theme.xml,  
<resources>  
    <style  
        name="LightTheme" parent="@android:style/Theme.Material.Light">  
       <item name="android:actionMenuTextAppearance">@style/LowerCaseMenu</item>  
        <item name="android:windowLightStatusBar">true</item>  
        <item name="android:windowLightNavigationBar">true</item>  
    </style>  
     <style name="LowerCaseMenu" parent="android:TextAppearance.Material.Widget.ActionBar.Menu">  
        <item name="android:textAllCaps">false</item>  
    </style>  
</resources>  
)  
CreateResource(values-v14, theme.xml,  
<resources>  
    <style  
        name="LightTheme" parent="@android:style/Theme.Holo.Light">  
    </style>  
</resources>  
)
```

  
  
Instructions - copy Themes.jar to internal libraries folder.