###  B4XDaisyDrawer - Beautiful, Responsive Tailwind/DaisyUI-Inspired Sliding Menus with Dual-Sidebars & Edge Swipe Gesture Controls! by Mashiane
### 08/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171825/)

Hey gang!  
  
Meet **B4XDaisyDrawer**! This library is a powerful custom view wrapper that brings the beautiful UI/UX of modern design frameworks (like Tailwind CSS and DaisyUI) directly into your B4X cross-platform applications.  
  
With **B4XDaisyDrawer**, you can design sleek sidebar menus that feature customizable shadow elevations, responsive padding sizes, rounded corner tokens, dual-sidebar options, and highly responsive edge swipe gesture controls!  
  
 ![](https://www.b4x.com/android/forum/attachments/172955) ![](https://www.b4x.com/android/forum/attachments/172956)  
  
  
  

---

  
  
✨ Key Features  

- **🔄 Dual-Side Support:** Configure the drawer sidebar to slide from the "left", the "right", or deploy dual sidebars on "both" sides.
- **🎨 Semantic DaisyUI-Inspired Styling:** Customize your sidebar backgrounds using semantic tokens (e.g., base-100, base-200, base-300, primary, accent, neutral).
- **🎛️ Rounded Corner & Drop Shadow Customization:** Control border roundedness (e.g., rounded-box, rounded-lg) and elevations/depths (e.g., none, sm, md, lg, xl, 2xl) natively.
- **🌗 Backdrop Overlay Engine:** Smoothly dims the main page content panel based on custom backdrop overlay colors and opacities.
- **🖐️ Robust Edge Swipe & Gesture Interception:** Features gesture tracking with parent view intercept prevention under Android (meaning it won't clash with your nested vertical scroll containers).
- **🛠️ Developer Friendly:** Fully integrates with the standard B4X Page lifecycle.

---

  
🚀 Quick Start & Code Example  
  
Here is a factual, complete, and beginner-friendly snippet demonstrating how to programmatically initialize, configure, and capture events with the **B4XDaisyDrawer** component.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
     
    ' 1. Declare the B4XDaisyDrawer component  
    Private mainDrawer As B4XDaisyDrawer  
End Sub  
  
Public Sub Initialize As Object  
    Return Me  
End Sub  
  
' This is called when the B4XPage is created  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
     
    ' Set page background color  
    Root.Color = B4XDaisyVariants.GetTokenColor("–color-base-200", xui.Color_RGB(245, 247, 250)) [6]  
    B4XPages.SetTitle(Me, "B4XDaisyDrawer Demo") [6]  
     
    ' 2. Initialize the drawer component programmatically (Callback: Me, EventName: mainDrawer)  
    mainDrawer.Initialize(Me, "mainDrawer") [20]  
     
    ' 3. Create the view hierarchy and attach it to the Page Root Panel  
    mainDrawer.CreateView(Root, "drawer_sample_tag") [14, 15]  
     
    ' 4. Configure visual and functional properties [1, 26]  
    mainDrawer.Side = "left"                         ' Options: left, right, both [1, 2]  
    mainDrawer.LeftSideWidth = "300dip"              ' Set width of left sidebar [1, 7]  
    mainDrawer.LeftSideBackgroundColor = "base-200"  ' Use DaisyUI style theme [1, 2]  
    mainDrawer.GestureEnabled = True                 ' Enable edge swipe detection [1, 4]  
    mainDrawer.Rounded = "rounded-box"               ' Apply stylish corner radius [1, 3]  
    mainDrawer.Shadow = "lg"                         ' Set elegant elevation shadow [1, 3]  
    mainDrawer.Padding = "p-4"                       ' Define sidebar panel content padding [1, 3]  
    mainDrawer.Animated = True                       ' Enable smooth sliding transitions [1, 11]  
    mainDrawer.Duration = 300                        ' Animation duration in ms [1, 11]  
     
    ' 5. Add custom UI content into the panels [23, 25]  
    BuildMainContent  
    BuildSidebarContent  
End Sub  
  
' Set up elements on the central content panel  
Private Sub BuildMainContent  
    ' Get reference to Center Panel  
    Dim center As B4XView = mainDrawer.CenterPanel [23]  
     
    ' Add a Title Label to the center of the application  
    Dim lblTitle As Label  
    lblTitle.Initialize("")  
    Dim xlblTitle As B4XView = lblTitle  
    xlblTitle.Text = "Welcome to B4XDaisyDrawer!"  
    xlblTitle.TextColor = xui.Color_Black  
    xlblTitle.TextSize = 18  
     
    ' Place the view on the central panel  
    mainDrawer.AddToCenter(xlblTitle, 20dip, 80dip, 280dip, 50dip) [25]  
     
    ' Add a button to toggle/open the sidebar  
    Dim btnToggle As Button  
    btnToggle.Initialize("btnToggleDrawer")  
    Dim xbtnToggle As B4XView = btnToggle  
    xbtnToggle.Text = "Toggle Menu"  
    mainDrawer.AddToCenter(xbtnToggle, 20dip, 150dip, 150dip, 50dip) [25]  
End Sub  
  
' Set up elements inside the sliding sidebar menu panel  
Private Sub BuildSidebarContent  
    ' Get reference to the Left Panel  
    Dim sidebar As B4XView = mainDrawer.LeftPanel [23]  
     
    ' Add a Header Label to the sliding menu  
    Dim lblMenuTitle As Label  
    lblMenuTitle.Initialize("")  
    Dim xlblMenuTitle As B4XView = lblMenuTitle  
    xlblMenuTitle.Text = "Main Navigation"  
    xlblMenuTitle.TextColor = xui.Color_DarkGray  
    xlblMenuTitle.TextSize = 16  
     
    ' Place the view on the left sidebar panel  
    mainDrawer.AddToLeft(xlblMenuTitle, 15dip, 20dip, 250dip, 40dip) [25]  
End Sub  
  
' 6. Handle Sizing during Page Resize Events  
Private Sub B4XPage_Resize(Width As Int, Height As Int)  
    If mainDrawer.IsInitialized Then  
        ' Update the drawer constraints on screen rotation or desktop window resize  
        mainDrawer.Resize(Width, Height) [21, 22]  
    End If  
End Sub  
  
' 7. Trapping Interactive Events  
Private Sub btnToggleDrawer_Click  
    ' Easily toggle open state [13, 27]  
    mainDrawer.Toggle [27]  
End Sub  
  
' Event fires when the drawer becomes fully opened  
Private Sub mainDrawer_Opened  
    Log("Event: Drawer has opened!") [1, 13]  
End Sub  
  
' Event fires when the drawer becomes fully closed  
Private Sub mainDrawer_Closed  
    Log("Event: Drawer has closed!") [1, 13]  
End Sub  
  
' Event fires when the backdrop dimming overlay is clicked  
Private Sub mainDrawer_CloseClick (Tag As Object)  
    Log("Event: User tapped backdrop to close! Payload Tag: " & Tag) [1, 17]  
End Sub  
  
' Event fires whenever open/closed state changes  
Private Sub mainDrawer_StateChanged (Open As Boolean)  
    Log("Event: Drawer state changed! IsOpen = " & Open) [1]  
End Sub
```

  
  

---

  
We hope you enjoy using **B4XDaisyDrawer** to build your next gorgeous B4X user interface! Let us know if you have any questions or feedback in the thread below. Happy coding!  
  
🔍 Want me to generate some custom mockup layouts or help write sidebar menu-populating subs for your B4XDaisyDrawer project?  
  
  
[MEDIA=youtube]gdggqB-HpI4[/MEDIA]