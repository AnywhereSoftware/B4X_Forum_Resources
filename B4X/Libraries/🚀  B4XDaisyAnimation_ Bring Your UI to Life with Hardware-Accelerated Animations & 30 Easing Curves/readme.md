### 🚀  B4XDaisyAnimation: Bring Your UI to Life with Hardware-Accelerated Animations & 30 Easing Curves! by Mashiane
### 08/03/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171717/)

Hello B4X Developers! 👋  
  
Are you looking to take your user interface to the next level? I'm excited to introduce the **B4XDaisyAnimation** class module, a comprehensive toolkit designed to make adding professional, hardware-accelerated animations to your views easier than ever before!  
Whether you need a simple fade, a dynamic slide, or a bouncy attention-grabber, this module has you covered. Best of all? It includes a stunning **Interactive Easing Playground** so you can visually test your animations!  
  
![](https://www.b4x.com/android/forum/attachments/172755) ![](https://www.b4x.com/android/forum/attachments/172756)  
  
**🌟 Key Features:**  

- **Hardware-Accelerated Performance:** Under the hood (for B4A), it utilizes ViewPropertyAnimator to ensure your translation, scale, rotation, and alpha animations run incredibly smoothly without bogging down the UI thread.
- **30 Robert Penner Easing Equations:** Access a massive library of mathematical easing curves directly by name (e.g., "easeOutBounce", "easeInElastic", "easeInOutSine") to give your views realistic physics and momentum.
- **Pre-built Complex Animations:** Easily implement popular UI effects like *Tada, Shake, Flash, RubberBand, Wave, Hinge*, and *Pulse* with a single line of code.
- **Interactive Playground:** Comes with a demo page featuring an Interactive Easing Playground. You can select curves like EaseOutBounce or EaseInElastic from a clean UI and watch the trajectory plot in real-time on a live graph.

**🛠️ Beginner-Friendly Quick Start Guide**  
  
Adding these animations to your app is incredibly simple. Here is a quick example showing how to initialize the class, configure a view, and trigger a few different animations using a button click event.  
  

```B4X
#Region  Project Attributes   
    #ApplicationLabel: Easing Playground  
    #VersionCode: 1  
    #VersionName: 1.0  
#End Region  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private pageScroll As B4XDaisyPageScroll  
    Private pnlHost As B4XView  
      
    ' The animation component and graph tracking  
    Private animObj As B4XDaisyAnimation  
    Private graphX As List  
    Private graphY As List  
      
    ' Variables for the manual animation loop  
    Private tAnim As Timer  
    Private isAnimating As Boolean  
    Private startTime As Long  
    Private currentDuration As Int = 1000 ' 1 second default  
      
    ' UI Elements  
    Private lblEasingName As B4XView  
    Private selectedEasing As String = "EaseOutBounce"  
End Sub  
  
Public Sub Initialize As Object  
    ' 1. Initialize the animation object and graph lists  
    animObj.Initialize  
    graphX.Initialize  
    graphY.Initialize  
    Return Me  
End Sub  
  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Root = Root1  
    ' Set the background color  
    Root.Color = B4XDaisyVariants.GetTokenColor("–color-base-200", xui.Color_RGB(245, 247, 250))  
    Root.LoadLayout("PlaygroundLayout")  
End Sub  
  
' 2. Trap the Play button click to start the animation with the currently selected curve  
Private Sub btnPlay_Click  
    StartAnimation(selectedEasing)  
End Sub  
  
' 3. Trap clicks from the various Easing Curve buttons (e.g., "EaseOutBounce", "EaseInElastic")  
Private Sub btnEase_Click (Value As Object)  
    Dim btn As B4XDaisyButton = Sender  
    If btn.IsInitialized Then  
        ' Update the selected easing based on the button's Tag  
        selectedEasing = btn.Tag  
        lblEasingName.Text = "Selected: " & selectedEasing  
          
        ' Immediately preview the newly selected curve  
        StartAnimation(selectedEasing)  
    Else If Value <> Null Then  
        selectedEasing = Value  
        lblEasingName.Text = "Selected: " & selectedEasing  
        StartAnimation(selectedEasing)  
    End If  
End Sub  
  
' 4. Prepare for the animation by clearing old graph data  
Private Sub StartAnimation(EaseName As String)  
    StopAnimation  
    graphX.Clear  
    graphY.Clear  
    DrawGraphBackground  
      
    ' Start the timer to begin evaluating the easing curve  
    startTime = DateTime.Now  
    isAnimating = True  
    tAnim.Enabled = True  
End Sub  
  
Private Sub StopAnimation  
    If tAnim.IsInitialized Then  
        tAnim.Enabled = False  
        isAnimating = False  
    End Sub  
End Sub  
  
' 5. The Animation Loop: Calculates progress and plots the trajectory  
Private Sub tAnim_Tick  
    If isAnimating = False Then Return  
      
    Try  
        Dim elapsed As Long = DateTime.Now - startTime  
          
        ' Cap the elapsed time at the total duration to finish the animation  
        If elapsed >= currentDuration Then  
            elapsed = currentDuration  
            StopAnimation  
        End If  
          
        ' ———————————————————  
        ' NOTE: Here you would call animObj.EvaluateEasing()   
        ' passing the selectedEasing, elapsed time, start value,   
        ' change in value, and currentDuration to manually   
        ' plot or update your UI step-by-step!  
        ' ———————————————————  
    Catch  
        Log(LastException)  
    End Try  
End Sub
```

  
  
[MEDIA=youtube]urUBAyu43YM[/MEDIA]