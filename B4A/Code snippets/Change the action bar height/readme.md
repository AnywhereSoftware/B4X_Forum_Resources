### Change the action bar height by Erel
### 09/17/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/122448/)

**![](https://www.b4x.com/android/forum/attachments/100182)**  
  
Add to manifest editor:  

```B4X
SetApplicationAttribute(android:theme, "@style/LightTheme")  
CreateResource(values, theme.xml,  
<resources>  
    <style name="LightTheme" parent="@android:style/Theme.Material.Light">  
         <item name="android:actionBarSize">40dp</item>  
    </style>  
</resources>  
)
```

  
  
Remove:  

```B4X
CreateResourceFromFile(Macro, Themes.DarkTheme) 'or LightTheme
```