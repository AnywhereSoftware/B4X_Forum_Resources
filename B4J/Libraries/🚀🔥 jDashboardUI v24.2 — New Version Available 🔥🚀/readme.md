### 🚀🔥 jDashboardUI v24.2 — New Version Available 🔥🚀 by fernando1987
### 10/27/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172381/)

Hi everyone,  
  
**jDashboardUI v24.2 is now available.** 🎉  
  
This release introduces new functionality and several improvements to existing components, especially around visual customization, toolbars, charts, navigation and status bars.  
  
[HEADING=2]🎨 JDashboardThemes — 15 themes and live switching[/HEADING]  
One of the main additions in this release is **JDashboardThemes**.  
  
It includes **15 ready-to-use CSS themes**, including:  
  

- Fluent Light / Dark
- Fluent Ocean
- Fluent Forest
- Fluent Lilac
- Dracula
- Catppuccin Mocha
- Nord
- Gruvbox
- Solarized Light / Dark
- Rose Pine
- Tokyo Night
- One Dark
- Monokai

An important feature is that themes can be changed **immediately while the application is running**.  
  
There is no need to restart the application, recreate the Form or reload the layout.  
  

```B4X
JDashboardThemes.ApplyToForm( _  
MainForm, _  
JDashboardThemes.THEME_FLUENT_DARK)
```

  
  
And later:  
  

```B4X
JDashboardThemes.ApplyToForm( _  
MainForm, _  
JDashboardThemes.THEME_TOKYO_NIGHT)
```

  
  
The visual change is applied immediately.  
  
A theme can also be applied only to a specific <span>Pane</span>.  
  

```B4X
JDashboardThemes.ApplyToPane( _  
pnlEditor, _  
JDashboardThemes.THEME_DRACULA)
```

  
  

---

  
[HEADING=2]🧰 New JToolBar[/HEADING]  
  
![](https://www.b4x.com/android/forum/attachments/174491)  
  
This release introduces **JToolBar**, a flexible toolbar that can host different types of Views.  
  
Among other things, it can contain:  
  

- buttons;
- icons;
- images;
- separators;
- TextFields;
- ComboBoxes;
- standard B4J Views;
- compatible CustomViews.

It also supports **automatic multi-row wrapping** when the available horizontal space is exhausted.  
  

```B4X
Actions.Wrap = True  
Actions.RowHeight = 32dip  
Actions.Spacing = 3dip
```

  
  
This makes it possible to build much more flexible toolbars that adapt to the available space.  
  

---

  
[HEADING=2]📊 Chart improvements — rolling and real-time data[/HEADING]  
Several charts can now append values incrementally without rebuilding the complete dataset.  
  

```B4X
JLineChart1.AddPoint( _  
DateTime.Time(DateTime.Now), _  
Rnd(20, 100), _  
24)
```

  
  
<span>MaxPoints</span> can be used to keep only the latest values and automatically remove the oldest one.  
  
This functionality is available in several compatible chart components.  
  
For <span>JBarChart</span> using bars and a line together:  
  

```B4X
JBarChart1.AddCombinedPoint( _  
DateTime.Time(DateTime.Now), _  
Rnd(20, 100), _  
Rnd(20, 100), _  
24)
```

  
  
The label, bar value and line value remain synchronized.  
  

---

  
[HEADING=2]🟢 JStatusBarView — Char or image before the text[/HEADING]  
![](https://www.b4x.com/android/forum/attachments/174492)  
  
JStatusBarView can now optionally display an independent **Char before the message text**.  
  
The Char can have its own:  
  

- Font;
- size;
- color.

```B4X
JStatusBarView1.SetIndicator( _  
"●", _  
xui.Color_Green)  
  
JStatusBarView1.ShowMessage("Ready")
```

  
  
FontAwesome, Material Icons or another Font can also be used:  
  

```B4X
JStatusBarView1.SetIndicator( _  
Chr(0xF00C), _  
xui.Color_Green, _  
fx.CreateFontAwesome(16))  
  
JStatusBarView1.ShowMessage("Saved")
```

  
  
It is also possible to display a **16×16 image before the text**, using <span>JImageView</span>:  
  

```B4X
JStatusBarView1.SetIndicatorImage( _  
File.DirAssets, _  
"Document-save.png")  
  
JStatusBarView1.ShowMessage("Document saved")
```

  
  
The Char or image remains vertically centered and can be changed dynamically while the application is running.  
  

---

  
[HEADING=2]🔘 JTabBar[/HEADING]  
JTabBar now directly exposes:  
  

```B4X
JTabBar1.Visible = False  
JTabBar1.Enabled = False
```

  
  
When hidden or disabled, it also stops processing user interaction.  
  

---

  
[HEADING=2]🖼 jMenuItem — simplified image handling[/HEADING]  
Image handling in jMenuItem has also been simplified.  
  
An item can now be initialized normally and the image assigned afterwards:  
  

```B4X
Dim itemSave As jMenuItem  
itemSave.Initialize("SaveFile", "Save")  
itemSave.Tooltip = "Save the active document"  
itemSave.SetImageIcon(File.DirAssets, "Document-save.png")  
itemSave.Shortcut = "Ctrl+S"  
  
fileTab.AddItem(itemSave)
```

  
  

---

  
[HEADING=2]📚 Updated documentation[/HEADING]  
The official documentation has been updated and **already includes all changes in this release, APIs, properties and usage examples**.  
  
👉 **Official documentation:**  
  
<https://b4xapp.com/en/docs/jdashboardui>  
  
I recommend checking the documentation, as there are more changes and implementation details than would be practical to include in a single forum post.  
  

---

  
[HEADING=2]🔄 Updating[/HEADING]  
If you are already using an earlier version of jDashboardUI, replace:  
  

```B4X
jdashboardUI.b4xlib
```

  
  
with the new **v24.2** version.  
  

---

  
[HEADING=2]⚠️ Testing note[/HEADING]  
Some of the new functionality has **not yet been tested under every possible combination** of controls, sizes, layouts, themes and application configurations.  
  
The implemented features have been reviewed and tested in the currently available scenarios and **should work as expected**, but there may still be edge cases that have not yet been discovered.  
  
If you encounter unexpected behavior, I would appreciate it if you could post the exact scenario and, if possible, a small example that allows the issue to be reproduced and fixed.  
  
Thank you very much for all the feedback, testing and suggestions. 👍  
  
**jDashboardUI v24.2 is available now.** 🚀