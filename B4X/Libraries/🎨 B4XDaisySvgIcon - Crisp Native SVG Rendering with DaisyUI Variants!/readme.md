###  🎨 B4XDaisySvgIcon - Crisp Native SVG Rendering with DaisyUI Variants! by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170421/)

Hi Fam  
  
Are you looking for a fast, reliable, and visually stunning way to implement SVG icons in your B4A projects without relying on WebViews? Allow me to introduce **B4XDaisySvgIcon**.  
This custom class module parses and renders SVG files natively into a B4XBitmap using native Android canvas APIs. It guarantees crisp scaling at any resolution while taking full advantage of the DaisyUI semantic color system.  
  
![](https://www.b4x.com/android/forum/attachments/170241)  
  
**✨ Key Features:**  
• **100% Native Rendering:** Parses SVG paths (M, L, C, Z, etc.) internally and draws them natively.  
• **DaisyUI Color Variants:** Automatically tint your icons using semantic states like primary, secondary, accent, success, warning, or error.  
• **Preserve Original Colors:** Have a complex, multi-colored SVG? Simply set PreserveOriginalColors to True.  
• **Tailwind/CSS Sizing:** Set width and height using familiar string tokens like "24px" or "6".  
• **Indicators & Badges:** Seamlessly attach custom notification dots and numerical counter badges to your icons using GetContentView to anchor them perfectly.  
**👨‍💻 Simple Usage Example:** Here is a quick snippet demonstrating how to initialize the icon, add it to your panel, load an SVG asset, and apply a DaisyUI variant color:  
  

```B4X
' 1. Declare the component  
Dim mySvgIcon As B4XDaisySvgIcon  
mySvgIcon.Initialize(Me, "mySvgIcon")  
  
' 2. Add it to a parent view (e.g., pnlHost) and store the returned B4XView  
' AddToParent parameters: Parent, Left, Top, Width, Height  
Dim iconView As B4XView = mySvgIcon.AddToParent(pnlHost, 20dip, 20dip, 56dip, 56dip)  
  
' 3. Configure the SVG icon properties  
mySvgIcon.setSvgAsset("book-open-solid.svg")    ' Load from the Assets folder  
mySvgIcon.setPreserveOriginalColors(False)      ' Set to True to keep native colors  
mySvgIcon.setColorVariant("primary")            ' Apply a DaisyUI color variant   
mySvgIcon.setSize("32px")                       ' Set the rendered size token  
mySvgIcon.ResizeToParent(iconView)              ' Fit the render to the parent bounds
```

  
  
  
[MEDIA=youtube]p02Vpij3vrs[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>