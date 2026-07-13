###  🎨 B4XDaisyColorWheel: A Sleek, Fully Customizable Color Picker for Your Apps! by Mashiane
### 07/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171470/)

Hello Fam! 👋  
  
I'm excited to share a brand-new custom UI component for your cross-platform projects: the **B4XDaisyColorWheel**. If you've been looking for an elegant, modern, and highly flexible color picker for your next B4A, B4i, or B4J app, this is exactly what you need!  
Visually, the component features a beautiful hue donut ring alongside an intuitive inner square for adjusting saturation and value. It can easily act as an inline controller or be presented elegantly inside a popup modal.  
  
![](https://www.b4x.com/android/forum/attachments/172211) ![](https://www.b4x.com/android/forum/attachments/172212)  
  
**🌟 Key Features:**  

- **Designer Friendly:** Customize the InitialColor, WheelThickness, HandleSize, and even drop shadows right from the Visual Designer.
- **Dynamic Visuals:** Optionally enable WheelReflectsSaturation so the outer hue ring dynamically reacts to the saturation selected in the inner square.
- **Comprehensive APIs:** Forget about writing your own color conversion math! The wheel has built-in helper methods to easily get and set colors using **RGB, Hex, HSV, and HSL**.
- **Highly Responsive:** Includes optimized touch handlers for smooth dragging.

**🛠️ Quick Start & Usage Example:** We designed this to be incredibly beginner-friendly. Once you've added the B4XDaisyColorWheel to your layout via the Visual Designer, here is all you need to start interacting with it and trapping user selections!  
  

```B4X
#Region  Project Attributes   
    #MainFormWidth: 600  
    #MainFormHeight: 600   
#End Region  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' 1. Declare the component matching the name you gave it in the Designer  
    Private cwBasic As B4XDaisyColorWheel  
      
    ' A simple panel to preview the color  
    Private pnlPreview As B4XView   
End Sub  
  
Public Sub Initialize  
    ' Initialization logic  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    ' 2. Load your layout containing the Color Wheel and Preview Panel  
    Root.LoadLayout("MainLayout")   
      
    ' 3. (Optional) Programmatically change properties on the fly!  
    cwBasic.setWheelThickness(16dip) ' Make it a medium-thin donut [11]  
      
    ' Let's programmatically set the starting color to a nice Blue [12]  
    cwBasic.setColor(xui.Color_RGB(59, 130, 246))   
End Sub  
  
' 4. The Magic Event!   
' This fires automatically whenever the user drags the handles on the wheel.  
Private Sub cwBasic_ColorChanged(Color As Int)  
    ' Instantly update our preview panel to show the chosen color [13]  
    If pnlPreview.IsInitialized Then  
        pnlPreview.Color = Color  
    End Sub  
      
    ' Bonus: Log the Hex value of the color they just picked!  
    Log("User selected Hex: " & cwBasic.getHex) ' [8]  
End Sub
```

  
  
Feel free to try it out, and let me know how it works in your projects! Happy coding! 🚀  
  
[MEDIA=youtube]ssS8MZFT9M0[/MEDIA]