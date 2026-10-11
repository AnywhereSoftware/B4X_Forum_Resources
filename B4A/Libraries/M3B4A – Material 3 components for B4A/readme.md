### M3B4A – Material 3 components for B4A by Jerryk
### 10/07/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/172219/)

[HEADING=2]M3B4A – Material 3 components for B4A (40+ custom views, light/dark, 19 colour schemes)[/HEADING]  
some of them  
![](https://www.b4x.com/android/forum/attachments/173946)![](https://www.b4x.com/android/forum/attachments/173948)![](https://www.b4x.com/android/forum/attachments/173955)![](https://www.b4x.com/android/forum/attachments/173956)  
  
![](https://www.b4x.com/android/forum/attachments/173950)![](https://www.b4x.com/android/forum/attachments/173957)![](https://www.b4x.com/android/forum/attachments/173952)![](https://www.b4x.com/android/forum/attachments/173954)  
Hi everyone,  
  
I would like to share **M3B4A**, a Material 3 component library for B4A. It is a set of custom views that look and behave like the Material 3 components in Jetpack Compose. You can use them from the Visual Designer or create them from code, and they work in B4XPages and classic Activity projects.  
  

---

  
[HEADING=2]Highlights[/HEADING]  

- **40 component families plus helpers**, covering roughly 50 Material 3 components: buttons, FABs, chips, text fields, pickers, dialogs, menus, sheets, app bars, navigation, lists, carousel and more.
- **Real Material 3 values.** Elevation, shapes, the type scale, state-layer opacities and button sizes come from the official androidx.compose.material3 token files. They are not numbers read off a spec page.
- **Light and dark mode**, with one call to switch.
- **19 brand colour schemes** (DeepPurple, Red, Green, Blue, Teal, Orange…). Each component can follow the app-wide scheme or have its own Scheme.
- **One class per family, variants as properties.** One M3Button covers Filled, Elevated, Tonal, Outlined and Text. One M3Chip covers Assist, Filter, Input and Suggestion.
- **Material Symbols icons built in.** Set an icon by its name, for example "favorite", "settings" or "dark\_mode". No image files are needed.
- **Motion and ripples**: state layers, ripples clipped to each component's shape, and spring animations where Material uses them (switch thumb, time-picker handle, bottom sheet, button press morph).
- **Accessibility**: 48dip minimum touch targets, roles and content descriptions for TalkBack, and RTL layouts. The components were checked with TalkBack on a real phone.
- **Material 3 Expressive** (the parts Compose ships as stable): button size tiers, the medium FAB, split button, button groups, floating toolbar, FAB menu, wavy progress indicator, vertical slider, docked search bar and flexible top app bars.

---

  
[HEADING=2]Components[/HEADING]  
**Basic**  

- M3IconView
- M3Text (any of the 15 type-scale roles)

**Actions**  

- M3Button (Filled, Elevated, Tonal, Outlined, Text; sizes XSmall–XLarge, press morph)
- M3ButtonGroup (standard with overflow, connected)
- M3FAB (Default, Small, Medium, Large, Extended)
- M3FloatingActionButtonMenu
- M3FloatingToolBar (horizontal, vertical, standard, vibrant)
- M3IconButton (Standard, Filled, Tonal, Outlined; checkable/toggle)
- M3SegmentedButton (single and multi choice)
- M3SplitButton

**Input and selection**  

- M3Checkbox
- M3Chip (Assist, Filter, Input, Suggestion, elevated)
- M3DatePicker (calendar or typed entry)
- M3DateRangePicker
- M3Menu
- M3RadioButton
- M3RangeSlider
- M3SearchBar
- M3Slider
- M3Switch
- M3TextField (Filled, Outlined; label, supporting text, error, counter, leading/trailing icon, prefix/suffix, password)
- M3TimePicker

**Containment & Surfaces**  

- M3BottomSheet (drag to dismiss, can be pulled up to full height)
- M3Card (Filled, Elevated, Outlined)
- M3Carousel (MultiBrowse, Uncontained, Hero)
- M3Dialog
- M3Divider
- M3ListItem (one/two/three lines, selectable)
- M3Overlay: a modal layer for your own content, with scrim, Back and tap-outside handling
- M3Scaffold
- M3SideSheet (modal and docked)
- M3Surface

**Navigation and bars**  

- M3BottomAppBar
- M3NavigationBar
- M3NavigationDrawer (modal and standard)
- M3NavigationRail
- M3Tabs (Primary, Secondary, scrollable)
- M3TopAppBar (Small, CenterAligned, Medium, Large; collapses on scroll)

**State and feedback**  

- M3Badge
- M3ProgressIndicator (linear, circular, wavy)
- M3Snackbar
- M3Tooltip (Plain, Rich; position, caret)

**Derived components**  

- M3CheckboxItem
- M3ChipGroup: one scrolling row or wrapped rows of chips, with single or required selection and "Show all"
- M3RadioButtonItem
- M3SwitchItem

---

  
[HEADING=2]How it is built[/HEADING]  
**It is not a wrapper around a Java library.** There is no Java or Kotlin component library, no AAR and no Material Components for Android behind it. Every component is written in **B4X**, as a normal B4A custom view class, on top of ordinary views (Panel, Label, ImageView, ScrollView) and B4XCanvas drawing. The layout, state handling, animation, colour and type-scale logic, and the event model are all B4X code, compiled into the two jars the library ships as.  
  
The Material 3 values are not copied by hand. Elevations, shapes, the type scale and the state-layer opacities are **generated from the official androidx.compose.material3 token files** by PowerShell scripts that ship with the project.  
  
The only Java is a small amount of **inline Java that B4X cannot do without**, about 220 lines in a single module (M3Platform), out of roughly 30,000 lines of library code. It is an accessibility delegate, so TalkBack gets proper roles (button, checkbox, switch, slider), custom click and long-click actions and range values, plus a helper that copies the icon font out of the library. Other platform details (ripples, shadows, soft keyboard, view flags) are reached from B4X through JavaObject. All of it sits behind M3Platform, so none of it appears in the public API of a component.  
  
[HEADING=2]Getting started[/HEADING]  
The library is distributed as **two compiled jars**, each with its .xml file:  

- M3B4A.jar + M3B4A.xml: the foundation (M3Theme, M3Views, typography, shapes, motion, icons, M3Overlay) and the components M3Button, M3IconButton, M3IconView, M3Text, M3TextField, M3Checkbox, M3RadioButton, M3Switch, M3Slider, M3ProgressIndicator, M3Card, M3Surface, M3Divider, M3ListItem, M3Tabs, M3TopAppBar, M3NavigationBar, M3TimePicker and M3Tooltip.
- M3B4Aext.jar + M3B4Aext.xml: all the other components: M3Chip, M3ChipGroup, M3Badge, M3Dialog, M3Menu, M3Snackbar, M3BottomSheet, M3SideSheet, M3FAB, M3FloatingActionButtonMenu, M3FloatingToolbar, M3SplitButton, M3ButtonGroup, M3SegmentedButton, M3RangeSlider, M3SearchBar, M3DatePicker, M3DateRangePicker, M3BottomAppBar, M3NavigationRail, M3NavigationDrawer, M3Scaffold, M3Carousel and the list rows M3SwitchItem, M3CheckboxItem and M3RadioButtonItem. It depends on M3B4A.jar.

1. Copy all four files into your **Additional Libraries** folder.
2. In the IDE, refresh the Libraries Manager and tick **M3B4A** and **M3B4Aext**. They need XUI, JavaObject, Accessibility and IME.
3. Optionally pick a theme at start-up. **You do not have to:** if you never call M3Theme.Init, the library uses the **DeepPurple** scheme in **light** mode, and everything works. Call it only when you want a different scheme or dark mode:

```B4X
M3Theme.Init("Green")        ' any of the 19 schemes; default is "DeepPurple"  
M3Theme.IsDark = True        ' default is False (light)
```

  
  
An unknown scheme name is logged and falls back to DeepPurple. A single component can also ignore the app-wide scheme and use its own Scheme property.  
  
[HEADING=3]From the Designer[/HEADING]  
Add an M3Button custom view to a layout and declare a variable with the same name:  

```B4X
Sub Class_Globals  
    Private SaveButton As M3Button  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root1.LoadLayout("main")  
    SaveButton.Text = "Save"  
    SaveButton.Style = "Filled"  
End Sub  
  
Private Sub SaveButton_Click  
    Log("clicked")  
End Sub
```

  
  
[HEADING=3]From code[/HEADING]  

```B4X
Dim btn As M3Button  
btn.Initialize(Me, "CancelButton")  
M3Views.Create(btn, Root, 16dip, 100dip, 200dip, 48dip, _  
    CreateMap("Style": "Outlined", "Text": "Cancel", "Icon": "close"))
```

  
  
M3Views.Create goes through the same path as the Designer, so the same property names work in both places.  
  
**Tip:** place components at the **48dip touch-target height**, not at their visual height. A chip is drawn 32dip tall, but its view is 48dip, and the component centres itself inside it.  
  
[HEADING=3]Colours and text follow roles[/HEADING]  
Components read colours by Material role (Primary, Surface, OnSurfaceVariant…) and text by type-scale role (BodyLarge, TitleMedium…), so switching light/dark or the scheme restyles everything:  
  

```B4X
Root.Color = M3Theme.GetColor("Surface")
```

  

---

  
[HEADING=2]Examples app[/HEADING]  
The library comes with an **examples app**: one page per component, grouped like the Material 3 catalogue. Most pages follow the official Compose Material 3 samples (ButtonSamples.kt, ChipSamples.kt, TextFieldSamples.kt, TooltipSamples.kt, DatePickerSamples.kt…), so you can compare the B4A version with the original side by side. Every page has a light/dark switch, and the top line shows the last event raised.  
  
A full help file (Help.html) lists every property, method and event, with a short example for each component.  
  

---

  
[HEADING=2]What it is not[/HEADING]  

- **Not a Compose port.** There is no recomposition, Modifier or slot API. These are ordinary B4A custom views with properties and events.
- **No measure pass.** Components use the size you give them. There is no wrap\_content for custom views, and text that is longer than its box is clipped. A few components that need it, such as the Rich tooltip, measure their own text.
- **No dynamic colour (Material You)** in this version. The colour schemes are fixed palettes.
- M3Carousel is a simplified version: fixed item sizes with the Material keyline strategy, not Compose's full layout engine.
- Not affiliated with or endorsed by Google.

---

  
[HEADING=2]Requirements[/HEADING]  
[TABLE]  
[TR]  
[TH][/TH]  
  
[TH][/TH]  
[/TR]  
[TR]  
[TD]B4A[/TD]  
[TD]14.0[/TD]  
[/TR]  
[TR]  
[TD]Android[/TD]  
[TD]API 21+ (tested on a current emulator and on a OnePlus 8 Pro; older versions are built for but not tested)[/TD]  
[/TR]  
[TR]  
[TD]Libraries[/TD]  
[TD]XUI, JavaObject, Accessibility, IME (all ship with B4A)[/TD]  
[/TR]  
[TR]  
[TD]Project type[/TD]  
[TD]B4XPages recommended; classic Activity works too[/TD]  
[/TR]  
[/TABLE]  
The icon font (Material Symbols) travels inside M3B4A.jar: you do not add any font files to your project, the library copies the font to the app's internal storage the first time an icon is used. The .xml files are trimmed, so IntelliSense offers the components and not the hundred or so generated token modules behind them.  
  

---

  
[HEADING=2]Licence[/HEADING]  
Apache License 2.0. Material 3 token values and the Error colours come from AndroidX (Apache 2.0), the icon font is Material Symbols (Apache 2.0)  
  

---

  
[HEADING=2]Download[/HEADING]  
[Part 1](https://www.dropbox.com/scl/fi/3s02e06m7ymyywrchlliz/M3B4A.zip?rlkey=f1hwvxt02c72wsoai5rxet86l&st=5u7cmfh2&dl=1) (M3B4A.jar, M3B4A.xml, M3B4Aexamples.apk, M3B4Ahelp.html)  
[Part 2](https://ko-fi.com/s/53aac13d02) (M3B4A.jar, M3B4A.xml, (M3B4Aext.jar, M3B4Aext.xml, M3B4Aexamples.apk, M3B4Aexamples.zip, M3B4Ahelp.html)  
Since I spent a loooooot of time, drank hectoliters of coffee, and burned through millions of tokens—the second part is paid.  
  
Feedback, bug reports and screenshots of your apps are very welcome. If something looks different from Material 3 or from the Compose samples, please post a screenshot and the component name, and I will look into it.