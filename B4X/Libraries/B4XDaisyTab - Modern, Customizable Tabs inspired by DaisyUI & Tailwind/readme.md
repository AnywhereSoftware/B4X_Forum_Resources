###  B4XDaisyTab - Modern, Customizable Tabs inspired by DaisyUI & Tailwind by Mashiane
### 04/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170750/)

Hi Fam!  
  
Tired of the standard tab look? Meet **B4XDaisyTab**, a highly customizable tab component for the B4X ecosystem, heavily inspired by the clean aesthetics of DaisyUI and the flexibility of Tailwind CSS.  
  
Whether you need a simple bottom-line indicator or a sophisticated "lifted" tab with rounded corners, B4XDaisyTab has you covered.  
  
![](https://www.b4x.com/android/forum/attachments/171009) ![](https://www.b4x.com/android/forum/attachments/171010) ![](https://www.b4x.com/android/forum/attachments/171011) ![](https://www.b4x.com/android/forum/attachments/171012) ![](https://www.b4x.com/android/forum/attachments/171013)  
  
**Key Features:**  

- **4 Unique Styles:** Choose between default, border, lift, and box variants to match your app's aesthetic.
- **5 Sizes:** From XS for dense data to XL for bold navigation, the component scales perfectly.
- **Fully Responsive:** Built-in support for **scrollable tabs** ensures your navigation stays usable even when you have many categories.
- **Icon Support:** Seamlessly integrate text or **SVG icons** into your tab labels.
- **Flexible Placement:** Position your tab bar at the top or bottom of the screen with a single property.
- **Theming Ready:** Supports standard variant colors like primary, secondary, accent, success, and error.

This component makes managing content panels a breeze, allowing you to link specific B4XViews to each tab index effortlessly.  
**Simple Usage Example:  
  

```B4X
' Initialize the component  
DaisyTab1.Initialize(Me, "DaisyTab1")  
DaisyTab1.AddToParent(Root, 0, 0, Root.Width, 60dip)  
  
' Add some tabs with icons  
DaisyTab1.AddTab("Home")  
DaisyTab1.AddTabWithIcon("Settings", "settings.svg")  
DaisyTab1.AddTab("Profile")  
  
' Set content for a specific tab  
Dim pnlHome As B4XView = xui.CreatePanel("")  
'… add your views to pnlHome here …  
DaisyTab1.SetTabContent(0, pnlHome)  
  
' Customize the style (e.g., Lift style)  
DaisyTab1.Style = "lift"  
DaisyTab1.ActiveColor = "primary"  
  
' Refresh to apply all changes  
DaisyTab1.Refresh
```

  
  
Enjoy building more modern interfaces!  
  
  
[MEDIA=youtube]SqUwMXD6LFM[/MEDIA]  
  
  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**