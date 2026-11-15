###  ThemeManager / ThemeCreator by Erel
### 11/11/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/172525/)

![](https://www.b4x.com/android/forum/attachments/174742) ![](https://www.b4x.com/android/forum/attachments/174743)  
  
ThemeManager + ThemeCreator are components that help create applications with multiple themes, such as light and dark themes.  
There are several components involved and it is important to understand the role of each one. Once configured the process is simple to use and flexible.  
  
colors.json - json file that describes the theme colors. Example (created with ChatGPT):  

```B4X
{  
  "mapping": {  
    "FF000001": "background",  
    "FF000002": "surface",  
    "FF000003": "text",  
    "FF000004": "textSecondary",  
    "FF000005": "primary",  
    "FF000006": "onPrimary",  
    "FF000007": "border",  
    "FF000008": "error"  
  },  
  "light": {  
    "background": "#FFFFFF",  
    "surface": "#F3F4F6",  
    "text": "#111827",  
    "textSecondary": "#4B5563",  
    "primary": "#2563EB",  
    "onPrimary": "#FFFFFF",  
    "border": "#D1D5DB",  
    "error": "#B91C1C"  
  },  
  "dark": {  
    "background": "#111827",  
    "surface": "#1F2937",  
    "text": "#F9FAFB",  
    "textSecondary": "#D1D5DB",  
    "primary": "#93C5FD",  
    "onPrimary": "#111827",  
    "border": "#4B5563",  
    "error": "#FCA5A5"  
  }  
}
```

  
The first "mapping" object lists the various (arbitrary) keys. Each named key has a dummy color value - FF000001. The dummy color value is used in the designer:  
  
![](https://www.b4x.com/android/forum/attachments/174744)  
  
  
ThemeCreator.jar - B4J command line tool that is activated during compilation with #CustomBuildAction. It uses the new LayoutUtils library to read the layouts in the Files folder and create a themed version for each layout file. It replaces color properties with values from the "mapping" ids with the specific theme colors. Unmatched colors are not replaced.  
Note that it only processes layout files that are newer than the previously generated layouts.  
  
![](https://www.b4x.com/android/forum/attachments/174745)  
  
Do not edit the generated layouts as they will be overwritten when their "parent" layout is modified.  
  
ThemeManager is a class (for now) that is added to the project and manages the theme changes. It also includes utility methods to replace the bars and other features colors.  
Pages are registered in B4XPage\_Created:  

```B4X
Themes.RegisterPage(Me)
```

  
This will lead to ResetLayout being called. This sub will also be called when the theme changes. The simplest implementation is to remove all views and load a new layout:  

```B4X
Root.RemoveAllViews  
Root.LoadLayout(Themes.LayoutName("MainPage")) 'load layouts with Theme.LayoutName  
Themes.SetTitle(Me, "onPrimary", "Themes Example") 'should be called from each page
```

  
Note that the actual layout loaded will not be MainPage but rather \_mainpage\_dark/light.  
  
For a real app with more complex layout you can build the layout with multiple layout files and panels and keep some of the panels instead of wiping the views which resets the UI state.  
Another option is to store the previous state and set it back:  

```B4X
Public Sub ResetLayout  
    Dim text As String = IIf(Initialized(EditText1), EditText1.Text, "")  
    Root.RemoveAllViews   
    If False Then Root.LoadLayout("Page2")  
    Root.LoadLayout(Themes.LayoutName("Page2"))  
    Themes.SetTitle(Me, "onPrimary", "Page 2")  
    Themes.SetBackgroundTintList(EditText1, "primary", "border") 'EditText line color isn't set by the designer.  
    EditText1.Text = text  
End Sub
```

  
Note the trick with If False Then Root.LoadLayout("Page2"). It removes the warning about uninitialized views and also makes it easier to Ctrl + Click on the layout name.  
  
Please try. ThemeCreator.jar should be copied to the B4X additional folder. It is activated during compliation with this command:  

```B4X
#CustomBuildAction: folders ready, %ADDITIONAL%\..\B4X\ThemeCreator.jar, %PROJECT%\Files
```

  
  
Tips:  
- Don't keep the generated layouts open in the designer while generating new ones.  
- You can create multiple themes with any names you like.  
- Click on Files tab - Sync Files. The layouts will not be fully functional if not listed in the Files tab.