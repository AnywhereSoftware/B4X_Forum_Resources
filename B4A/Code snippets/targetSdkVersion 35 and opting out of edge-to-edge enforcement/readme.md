### targetSdkVersion 35 and opting out of edge-to-edge enforcement by Erel
### 05/22/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167109/)

The recommended targetSdkVersion is presently 34, however if you like to experiment with v35 then your app will be enforced to become [edge-to-edge](https://developer.android.com/develop/ui/views/layout/edge-to-edge). This is a feature that will be mandatory at some point in the future (maybe 2 years from now) and it goes together with other upcoming requirements of handling content resizes. For now I recommend opting out of this enforcement.  
  
This is done by:  
1. Download "android sdk platform 35" with B4A Sdk Manager.  
2. Configure the IDE to use android.jar from platforms\android-35.  
3. Add to manifest editor:  

```B4X
CreateResource(values, theme.xml,  
<resources>  
    <style  
        name="LightTheme" parent="@android:style/Theme.Material.Light">  
       <item name="android:actionMenuTextAppearance">@style/LowerCaseMenu</item>  
       <item name="android:windowOptOutEdgeToEdgeEnforcement">true</item>  
    </style>  
     <style name="LowerCaseMenu" parent="android:TextAppearance.Material.Widget.ActionBar.Menu">  
        <item name="android:textAllCaps">false</item>  
    </style>  
</resources>  
)
```

  
This replaces the default Theme.LightTheme with a similar theme that includes the option to opt out of the edge to edge enforcement.