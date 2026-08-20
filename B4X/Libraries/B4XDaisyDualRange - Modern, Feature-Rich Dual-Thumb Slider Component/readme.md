###  B4XDaisyDualRange - Modern, Feature-Rich Dual-Thumb Slider Component by Mashiane
### 08/18/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171831/)

Hi there..  
  
Say hello to **B4XDaisyDualRange**, a highly customizable, modern, and beautiful dual-thumb slider component built ground-up for cross-platform **B4A** applications! Inspired by DaisyUI and Tailwind CSS design principles, this component provides stunning color variants, responsive sizing scales, interactive tooltips, live value readouts, and native validation capabilities.  
  
Whether you need a **Price Range Filter** with snap-to-steps, a **Temperature Selector** with interactive fade-in tooltips, or a **Sound Frequency Range** slider with permanently open numeric bubbles, this library has you covered!  
  
![](https://www.b4x.com/android/forum/attachments/172978) ![](https://www.b4x.com/android/forum/attachments/172979) ![](https://www.b4x.com/android/forum/attachments/172980)  
  
  

---

  
🚀 Key Features  

- **Tailwind/DaisyUI Variant Colors**: Native styling support for primary, secondary, accent, info, success, warning, error, neutral, and none variants.
- **Proportional Sizing**: Standardized sizes ranging from xs (extra small) to xl (extra large) to fit any UI design perfectly.
- **Dynamic Tooltips**: Configure dual tooltips to show transiently on drag or to remain permanently open. Choose relative positions: top, bottom, left, or right.
- **Smart Value Readouts**: Built-in, right-aligned live values above the slider with custom prefixes (e.g. $), suffixes (e.g. RPM, Hz, deg C), and separators. [2, 16, 17, Image: dualrange1.png]
- **Native Event Callback & Validation**: Trap real-time value changes or focus shifts, and utilize built-in required field validation and error styling.
- **RTL & Scroll Safety**: Includes native support for Right-to-Left layouts and prevents parent scroll containers from stealing touch gestures on Android (DisallowParentIntercept).

---

  
💻 Quick Start & Code Example  
Using B4XDaisyDualRange is incredibly straightforward. While you can configure **every single setting** directly within the B4X Designer's property grid, you also have full control over the component programmatically!  
Here is a clean, beginner-friendly example of how to declare the view, load it from your layout, configure its properties programmatically, and handle its real-time event callbacks:  
  

```B4X
' Class_Globals of your B4XPage (e.g., B4XPageMyDemo)  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' Declare the B4XDaisyDualRange view variable  
    Private drLive As B4XDaisyDualRange [2]  
      
    ' Visual feedback label to output changed values  
    Private txtFeedback As Label [13]  
End Sub  
  
Public Sub Initialize As Object  
    Return Me [2]  
End Sub  
  
' This is called when the page layout is initialized  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.RemoveAllViews ' Clear previous skeletons [2]  
      
    ' Load the layout containing your B4XDaisyDualRange custom view  
    Root.LoadLayout("MainLayout")  
      
    ' Configure the dual-range component programmatically  
    ConfigureDualRange  
End Sub  
  
Private Sub ConfigureDualRange  
    ' 1. Set Range Boundaries and Values  
    drLive.MinValue = 0                         ' Set the minimum slider range boundary [3, 12]  
    drLive.MaxValue = 500                       ' Set the maximum slider range boundary [3, 14]  
    drLive.setValues(20, 350)                   ' Simultaneously update lower and upper values [15]  
      
    ' 2. Define Increments & Distance Constraints  
    drLive.StepValue = 10                       ' Increment by 10 per tick (0 for continuous) [3, 16]  
    drLive.MinDistance = 50                     ' Enforce a minimum gap of 50 units between thumbs [3, 8]  
      
    ' 3. Sizing & Styling (Using DaisyUI Presets!)  
    drLive.Size = "lg"                          ' Set size to Large (options: xs, sm, md, lg, xl) [3, 8]  
    drLive.Variant = "success"                  ' Set color variant to green (success) [3, 7]  
      
    ' 4. Header Labels and Formatting Rules  
    drLive.LabelAbove = "Live Dynamic Slider"   ' Display primary header text [3, 17]  
    drLive.LabelVisible = True                  ' Ensure the label is visible [3, 18]  
    drLive.ShowValue = True                     ' Show the right-aligned value readout [3, 18]  
    drLive.ValuePrefix = "k"                    ' Prefix for values (e.g., k20) [3, 19]  
    drLive.ValueSuffix = " RPM"                 ' Suffix for values (e.g., RPM) [3, 19]  
    drLive.ValueSeparator = " - "               ' Separator (e.g., "k20 RPM - k350 RPM") [3, 19]  
      
    ' 5. Rich Tooltip Configuration  
    drLive.ShowTooltip = True                   ' Show drag-tooltips above thumbs [4, 9]  
    drLive.TooltipPosition = "top"              ' Place tooltips above the slider [4, 9]  
    drLive.TooltipOpen = False                  ' False = show transiently on drag, True = always open [4, 9, 20]  
      
    ' 6. Optional Form Validation Settings  
    drLive.Required = True                      ' Mark the range slider as a required selection [3, 21]  
End Sub  
  
' — Event Handlers —  
  
' Traps when the thumbs are dragged or the range changes  
Private Sub drLive_Changed (LowerValue As Int, UpperValue As Int) [1]  
    If txtFeedback.IsInitialized Then  
        ' Update feedback label matching the live demo experience [13]  
        txtFeedback.Text = "Event Callback: Lower = " & LowerValue & " RPM, Upper = " & UpperValue & " RPM" [13]  
    End If  
End Sub  
  
' Traps when the component gains or loses focus  
Private Sub drLive_FocusChanged (HasFocus As Boolean) [1, 21]  
    Log("Slider has focus: " & HasFocus)  
End Sub
```

  
  
Enjoy modernizing your B4X application inputs! Post your questions or design setups below!  
  
  
[MEDIA=youtube]G7b2uS3F09I[/MEDIA]