### Immersive Mode - Hide system bars by Claude Obiri Amadu
### 06/19/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/161680/)

Based on: <https://www.b4x.com/android/forum/threads/immersive-mode-hide-the-navigation-bar.90882/#content>  
  
  

```B4X
Sub Globals  
    Dim immersive As ImmersiveMode  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    immersive.Initialize(Activity)  
    Activity.LoadLayout("Layout")  
End Sub  
  
Sub Activity_WindowFocusChanged(HasFocus As Boolean)  
    If HasFocus Then  
        immersive.SetMode(immersive.SYSTEM_UI_FLAG_FULLSCREEN)  
    End If  
End Sub
```

  
  

```B4X
SetApplicationAttribute(android:theme, "@style/CustomTheme")  
  
CreateResource(values, theme.xml,  
<resources>  
    <style name="CustomTheme" parent="@android:style/Theme.Holo.Light">  
        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>  
    </style>  
</resources>)
```

  
  

```B4X
SetApplicationAttribute(android:theme, "@style/MyAppTheme")  
CreateResource(values, theme.xml,  
<resources>  
    <style name="MyAppTheme" parent="@style/Theme.AppCompat.Light.DarkActionBar">  
        <item name="colorPrimary">#20A39B</item>  
        <item name="colorPrimaryDark">#20A39B</item>  
        <item name="colorAccent">#20A39B</item>  
        <item name="windowNoTitle">true</item>  
        <item name="windowActionBar">false</item>  
        <item name="windowActionModeOverlay">true</item>  
        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>  
    </style>  
</resources>  
)
```

  

- **v1.10**

- Implemented <https://www.b4x.com/android/forum/threads/immersive-mode-with-notch-area-support.100636/>