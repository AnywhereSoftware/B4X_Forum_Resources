### Disabling system darkmode in your app by Marvel
### 02/07/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/127411/)

I added this code to the code below to my apps manifest to disable forced dark mode by the system in my app. I thought it might be useful for someone, especially on Android phones like Xiaomi that forces your app to use dark mode irrespective of the theme in the manifest. There is an option to turn off forced dark mode per app in Xiaomi, the problem is that users don't even know they can, so your app will look bad if not optimized for dar mode. By adding this to the manifest, it will prevent the system from enforcing dark mode in your app (till you optimize your app for it anyway, which is actually the better choice.  
  

```B4X
<item name="android:forceDarkAllowed">false</item>
```

  
  
The theme manifest looks like this:  

```B4X
SetApplicationAttribute(android:theme, "@style/Custom")  
CreateResource(values-v20, theme.xml,  
<resources>  
  <style  
  name="Custom" parent="@android:style/Theme.Material.Light.NoActionBar">  
     <item name="android:windowTranslucentNavigation">false</item>  
     <item name="android:windowTranslucentStatus">true</item>  
     <item name="android:forceDarkAllowed">false</item>  
  </style>  
</resources>  
)
```