###  [XUI] AS LiquidGlass - Cross Platform Liquid Glass Panel by Alexander Stolte
### 11/11/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/172530/)

This is a cross platform (B4A, B4i and B4J) custom view for adding a liquid glass effect to your layouts.  
You can use it for cards, floating buttons, toolbars or your own navigation. Just add your content to the ContentPanel, the glass effect is drawn behind it.  
  
![](https://www.b4x.com/android/forum/attachments/174763)  
  
Inspired by [Liquid-Glass-Android](https://github.com/QWEA0/Liquid-Glass-Android). The view is written in B4X and uses a shared CPU renderer, so no Android AAR is required.  
  
**Features**  

- Background blur
- Refraction at the rounded edges
- Color dispersion
- Glass tint and saturation
- Directional edge highlights
- Designer support and CreateViewPerCode
- ContentPanel for your own layouts

**Example**  
The background must be a separate panel behind the glass view. Add the images or views you want to blur to this panel.  

```B4X
Private AS_LiquidGlass1 As AS_LiquidGlass  
Private xpnl_Background As B4XView  
  
xpnl_Background = xui.CreatePanel("")  
Root.AddView(xpnl_Background,0,0,Root.Width,Root.Height)  
'Add your background content here  
  
AS_LiquidGlass1.Initialize(Me,"AS_LiquidGlass1")  
AS_LiquidGlass1.CreateViewPerCode(Root,20dip,100dip,280dip,96dip)  
AS_LiquidGlass1.CornerRadius = 32dip  
AS_LiquidGlass1.SetBackdropView(xpnl_Background,20dip,100dip)  
AS_LiquidGlass1.ContentPanel.LoadLayout("frm_GlassContent")
```

  
**Designer**  
Add the custom view to your layout and set the background source after loading the layout.  
The following example assumes the background panel and glass view have the same parent and the background starts at 0,0.  

```B4X
AS_LiquidGlass1.SetBackdropView(xpnl_Background,AS_LiquidGlass1.mBase.Left,AS_LiquidGlass1.mBase.Top)
```

  
**Important**  
The background source must not contain the glass view itself. Use a separate background panel, not Root or the parent containing the glass.  
Use a background with some details, the refraction is difficult to see on a single flat color.  
  
**Clear glass**  
For less blur and more visible refraction:  

```B4X
AS_LiquidGlass1.BlurRadius = 1dip  
AS_LiquidGlass1.GlassTint = 0x10FFFFFF  
AS_LiquidGlass1.RefractionHeight = 18dip  
AS_LiquidGlass1.DispersionStrength = 0.12
```

  
**Refresh**  
Call Refresh when the background changes:  

```B4X
AS_LiquidGlass1.Refresh
```

  
Or refresh automatically, for example every 100ms:  

```B4X
AS_LiquidGlass1.StartAutoRefresh(100)  
  
'Stop when the page disappears  
AS_LiquidGlass1.StopAutoRefresh
```

  
After moving the glass view, update the position relative to the background source:  

```B4X
AS_LiquidGlass1.SetBackdropOffset(AS_LiquidGlass1.mBase.Left,AS_LiquidGlass1.mBase.Top)
```

  
**Light direction**  

```B4X
'Highlight from the top left  
AS_LiquidGlass1.SetLightDirection(-1,-1)
```

  
**AS\_LiquidGlass**  
Author: Alexander Stolte  
Version: 1.00  
  
[SPOILER="Properties, Functions, Events, etc."]  
**AS\_LiquidGlass  
  
Author:** Alexander Stolte  
**Version:** 1.00  

- **AS\_LiquidGlass**

- **Events:**

- **Click**
- **Rendered**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **CreateViewPerCode** (Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float) As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
- **Dispose** As String
*Stops polling and releases the stored backdrop. Create a new instance to reuse.*- **Initialize** (Callback As Object, EventName As String) As String
- **Refresh** As String
*Captures only the separate source view. Does not hide the glass or its content.*- **Resize** (Width As Float, Height As Float) As String
*Use after resizing from code (B4A does not raise Base\_Resize automatically).*- **SetBackdrop** (Bitmap As B4XBitmap, Left As Float, Top As Float, Width As Float, Height As Float) As String
*Bitmap must be aligned to the backdrop coordinate space. Region is in bitmap pixels.  
 Call again after moving/resizing the glass when using bitmap mode.*- **SetBackdropOffset** (Left As Float, Top As Float) As String
*Update offsets after moving the glass relative to the source view.*- **SetBackdropView** (Source As B4XView, Left As Float, Top As Float) As String
*Source must NOT contain this glass or any other glass sampling the same source.  
 Left/Top are explicit offsets in Source view coordinates; width/height follow mBase.  
 Use a separate background panel behind the glass, never its common parent.*- **SetLightDirection** (X As Float, Y As Float) As String
*Light direction, e.g. (-1,-1) for top-left. Can be driven by pointer or sensors.*- **StartAutoRefresh** (IntervalMs As Int) As String
*Opt-in polling; CPU rendering is not a 60 fps GPU replacement. Stop on page disappear.*- **StopAutoRefresh** As String

- **Properties:**

- **BevelWidth** As Float
- **BlurRadius** As Float
- **ContentPanel** As B4XView [read only]
*Content is drawn above the glass. Keep child views within the rounded silhouette.*- **CornerRadius** As Float
*Distances use B4X layout units: pass dip values from code.*- **DispersionStrength** As Float
- **GlassTint** As Int
- **HighlightOpacity** As Float
- **RefractionHeight** As Float
- **RenderScale** As Float
- **Saturation** As Float

- **AS\_LiquidGlassRenderer**

- **Functions:**

- **Initialize** As String
- **Render** (Backdrop As B4XBitmap, Width As Int, Height As Int, Radius As Float, Blur As Int, Refraction As Float, Bevel As Float, Dispersion As Float, Saturation As Float, Tint As Int, Highlight As Float, LightX As Float, LightY As Float) As B4XBitmap
*All distances in render pixels. Input is an already aligned backdrop crop.*
[/SPOILER]  
**Dependencies**  
B4A: XUI, BitmapCreator  
B4i: iXUI, iBitmapCreator  
B4J: jXUI, jBitmapCreator, JavaObject  
The example projects also use B4XPages.  
  
**Notes**  
This version is intended for small glass surfaces. Rendering runs on the UI thread, so start with manual refresh or a moderate refresh interval. It is not a replacement for the Android GPU shader pipeline and does not include shape merging, automatic sensor tracking or elastic press effects.  
Only the glass image is rounded. Keep your content inside the rounded area, the ContentPanel itself does not clip its child views.  
  
**Changelog**  

- 1.00

- Initial version

- 1.01

- Batched updates; native Android renderer avoids B4X pixel loops
- Independent rim lighting and glass visibility for composed menu triggers
- Fix: check Android parent type before wrapping, including debug builds
- Fix: stop ancestor traversal at Android's non-view window parent

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)