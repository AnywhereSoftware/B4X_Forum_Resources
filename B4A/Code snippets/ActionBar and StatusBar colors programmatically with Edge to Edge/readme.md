### ActionBar and StatusBar colors programmatically with Edge to Edge by Erel
### 08/13/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171763/)

Code to add a panel behind the status bar and action bar.  
  
![](https://www.b4x.com/android/forum/attachments/172848)  
  
1. Make the action bar transparent by adding this to the manifest editor (keep the CreateResourceFromFile(Macro, Themes.LightTheme) line):  
  

```B4X
'change windowLightStatusBar to true for dark text in the status bar  
CreateResource(values-v20, theme.xml,  
<resources>  
    <style  
        name="LightTheme" parent="@android:style/Theme.Material.Light">  
               <item name="android:actionMenuTextAppearance">@style/LowerCaseMenu</item>  
            <item name="android:windowLightStatusBar">false</item>  
            <item name="android:colorPrimary">@color/actionbar</item>  
    </style>  
     <style name="LowerCaseMenu" parent="android:TextAppearance.Material.Widget.ActionBar.Menu">  
        <item name="android:textAllCaps">false</item>  
    </style>  
</resources>  
)  
CreateResource(values, colors.xml,  
<resources>  
    <color name="actionbar">@android:color/transparent</color>  
</resources>  
)
```

  
  

```B4X
Private Sub SetTopBarColorAndTitle(BackgroundColor As Int, TitleColor As String, Title As String)  
    Dim top As B4XView = xui.CreatePanel("")  
    top.Color = BackgroundColor  
    Dim act As Activity = B4XPages.GetNativeParent(Me) 'Activity with non-B4XPages  
    Dim r As Rect = ime.GetContentRect  
    act.AddView(top, 0, 0, act.Width, r.Top)  
    Dim cs As CSBuilder  
    cs.Initialize.Color(TitleColor).Append(Title).Pop  
    B4XPages.SetTitle(Me, cs) 'Activity.Title = cs with non-B4XPages  
End Sub
```

  
  
Usage example:  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    ime.Initialize("")  
    SetTopBarColorAndTitle(0xFF005CE2, xui.Color_White, "title here")  
    Root.LoadLayout("MainPage")  
End Sub
```