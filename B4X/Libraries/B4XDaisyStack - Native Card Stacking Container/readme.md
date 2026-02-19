###  B4XDaisyStack - Native Card Stacking Container by Mashiane
### 02/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170346/)

Hi Fam  
  
I am pleased to introduce **B4XDaisyStack**, another component in the **B4X Daisy UI Kit** series.  
  
Inspired by the visual utility of the DaisyUI stack component, this view allows you to stack elements on top of each other with automatic offset calculations, creating a "depth" effect perfect for image galleries, notification toasts, or card decks.  
  
![](https://www.b4x.com/android/forum/attachments/169974) ![](https://www.b4x.com/android/forum/attachments/169975)  
  
**The "Glue": B4XDaisyVariants** B4XDaisyStack relies on **B4XDaisyVariants** to interpret size tokens and handle consistent property parsing. This ensures that your stack's dimensions and behavior align perfectly with other components like B4XDashboard or B4XDaisyAvatar.  
  
🌟 Key Features  
• **Directional Stacking:** Supports stacking in four directions: bottom (default), top, start, and end.  
• **Automatic Depth:** The component automatically calculates positions for the top, middle, and bottom layers using your defined StepPrimary and StepSecondary offsets.  
• **Auto-Fill:** When AutoFillLayers is enabled, child views are automatically resized to fit their specific layer frame—no manual sizing required.  
• **Layout Animation:** Built-in LayoutAnimationMs support for smooth transitions when adding/removing layers or resizing the stack.  
  
  
🛠 Dependencies  
1. **B4XDaisyVariants.bas** (Static Code Module) - *Included in the attachment*  
**1. Designer Configuration:** Add B4XDaisyStack to your layout.  
• **Direction:** bottom  
• **StepPrimary:** 7 (Offset for the bottom-most card)  
• **StepSecondary:** 3 (Offset for the middle card)  
  
  

```B4X
Sub Globals  
    Private Stack As B4XDaisyStack  
    Private xui As XUI  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("MainLayout")  
     
    ' Add simple colored panels to the stack  
    For i = 1 To 3  
        Dim p As B4XView = xui.CreatePanel("")  
        p.SetColorAndBorder(xui.Color_ARGB(255, Rnd(50, 200), Rnd(50, 200), Rnd(50, 200)), 0, 0, 8dip)  
         
        Dim lbl As Label  
        lbl.Initialize("")  
        lbl.Text = "Card " & i  
        lbl.Gravity = Gravity.CENTER  
        p.AddView(lbl, 0, 0, 100dip, 50dip) ' Size will be overridden by AutoFillLayers  
         
        Stack.AddLayer(p)  
    Next  
     
    ' Or use the convenience helper for quick cards  
    Stack.AddColorLayer(xui.Color_Blue, "Top Card", xui.Color_White, 8dip)  
End Sub  
  
' Change direction at runtime  
Sub btnChangeDirection_Click  
    Stack.Direction = "top"  
    ' The stack will animate to the new layout if LayoutAnimationMs > 0  
End Sub
```

  
  
🎨 Designer Properties  
• **Direction:** Controls the visual flow of the stack (bottom, top, start, end).  
• **StepPrimary:** The offset distance (in dip) for the furthest back layer.  
• **StepSecondary:** The offset distance (in dip) for the middle layer.  
• **AutoFillLayers:** If true, child views are resized to fill the calculated layer bounds.  
• **LayoutAnimationMs:** Duration in milliseconds for layout updates.  
• **RoundedBox:** Applies a standard 8dip corner radius to the stack container itself.  
  
**Related Content:**  
  
[MEDIA=youtube]HtiF2VZu43c[/MEDIA]