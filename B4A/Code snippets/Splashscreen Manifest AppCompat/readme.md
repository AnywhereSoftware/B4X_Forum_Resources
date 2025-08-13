### Splashscreen Manifest AppCompat by Mike1970
### 10/02/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143274/)

Hi everyone,  
I had to fix the ugly white page that shows for a bit before the app starts (using B4XPages).  
  
There is this tutorial by Erel in the forum: <https://www.b4x.com/android/forum/threads/b4x-b4xpages-splash-screen.120851/>  
that explains how to do everything, with a beautiful video by[USER=118312] ADeveloper[/USER] at the end of post.  
  
However Erel's project does not use AppCompat as theme, so this is my manifest to solve the white page still using AppCompat as a theme (ignore the color things, you can remove or change them)  
  
  

```B4X
SetActivityAttribute(Main, android:theme, "@style/MyAppTheme")  
CreateResource(values, theme.xml,  
<resources>  
    <style name="MyAppTheme" parent="@style/Theme.AppCompat.Light.NoActionBar">  
        <item name="colorPrimary">#213e45</item>  
        <item name="colorPrimaryDark">#213e45</item>  
        <item name="colorAccent">#a4c13c</item>  
         <item name="android:windowBackground">@color/window</item>  
    </style>  
</resources>  
)  
CreateResource(values, colors.xml,  
<resources>  
    <color name="window">#FF213E45</color>  
</resources>  
)
```