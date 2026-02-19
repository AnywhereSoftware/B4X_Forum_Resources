###  B4XDashboard - Native Responsive Launcher & Grid Menu by Mashiane
### 02/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170344/)

Hi Fam  
  
I am pleased to present **B4XDashboard**, a nativecross-platform component part of the **B4X Daisy UI Kit** series.  
  
Inspired by the clean utility of the Tailwind CSS / DaisyUIframework, this component provides a fully responsive, paged "Launcher" style interface for your apps. It is perfect for main menus, app drawers, or tool grids. It is built purely with native B4X views (Canvas/Panels) for maximum performance—no WebViews required.  
   
![](https://www.b4x.com/android/forum/attachments/169971) ![](https://www.b4x.com/android/forum/attachments/169972)  
  
  
**The "Glue": B4XDaisyVariants** Like all components in this series, B4XDashboard relies on **B4XDaisyVariants**. Thisshared code module acts as the styling engine, handling color palettes, shape normalization, and utility sizes to ensure your dashboard looks consistent with other Daisy UI Kit components.  
   
  
🌟 Key Features  
  
• **Auto-Grid Layout:** Automatically calculates theoptimal number of rows and columns based on the available screen size and your defined MinCellWidth / MinCellHeight.  
  
• **Pagination:** Built-in horizontal swipe navigationwith customizable page indicator dots.  
  
• **Notification Badges:** Supports native-style badges(counters) on icons. It automatically handles "99+" truncation for large numbers.  
  
• **Flexible Content:** Supports Bitmaps, SVGs (viabitmap conversion), Labels, and Background Wallpapers.  
  
• **Dynamic Updates:** Update labels, icons, or badges atruntime without flickering.  
  
🛠 Dependencies  
  
1. **B4XDaisyVariants.bas** (Static Code Module) - *Includedin the attachment*  
  
💻 Usage Example  
  
**1. Designer Configuration:** Add the B4XDashboard toyour layout.  
  
• **Auto Grid:** Checked (Recommended)  
  
• **Min Cell Width/Height:** 72 (default)  
  
• **Active/Inactive Dot Color:** Customize to match yourtheme.  
  
🎨 Designer Properties  
  
• **AutoGrid:** If true, ignores explicit row/columncounts and calculates them based on the view size.  
  
• **RowsPerPage / ColumnsPerPage:** Used if AutoGrid isdisabled.  
  
• **PagePadding / CellSpacing:** Control the density ofthe grid.  
  
• **BackgroundImage:** Set a wallpaper behind the icons.  
  
• **ActiveIndicatorColor:** Color of the dot for thecurrent page.  
  

```B4X
Sub Globals  
    Private Dashboard As B4XDashboard  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("MainLayout")  
      
    ' Add items dynamically  
    ' Parameters: ID, Label, ImageFileName, SvgFileName (Empty string if unused)  
    Dashboard.AddButton("btn_profile", "My Profile", "user.png", "")  
    Dashboard.AddButton("btn_settings", "Settings", "gear.png", "")  
    Dashboard.AddButton("btn_messages", "Messages", "mail.png", "")  
      
    ' Or add using specific path helper  
    Dashboard.AddButtonWithImagePath("btn_camera", "Camera", File.Combine(File.DirAssets, "cam.jpg"))  
  
    ' Update a badge at runtime (e.g., incoming message)  
    Dashboard.UpdateButtonBadge("btn_messages", 5)  
      
    ' Update to "99+" automatically  
    Dashboard.UpdateButtonBadge("btn_settings", 120)  
End Sub  
  
' Handle Clicks  
Sub Dashboard_ButtonClick(ButtonId As String, ButtonDef As Map)  
    Log("User clicked: " & ButtonId)  
      
    Select Case ButtonId  
        Case "btn_messages"  
            ' Clear badge on click  
            Dashboard.UpdateButtonBadge(ButtonId, 0)  
    End Select  
End Sub  
  
' Optional: Monitor Page Changes  
Sub Dashboard_PageChanged(PageIndex As Int, PageCount As Int)  
    Log($"Scrolled to page ${PageIndex} of ${PageCount}"$)  
End Sub
```

  
  
…. a continuing story…  
  
**Related Content:**  
  
[MEDIA=youtube]8Mq0yQQpqmY[/MEDIA]  
  
  
[MEDIA=youtube]YeYM-MgizI8[/MEDIA]