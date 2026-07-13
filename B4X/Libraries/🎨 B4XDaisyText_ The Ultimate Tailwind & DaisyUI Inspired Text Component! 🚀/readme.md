###  🎨 B4XDaisyText: The Ultimate Tailwind & DaisyUI Inspired Text Component! 🚀 by Mashiane
### 07/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171472/)

Hello Fam!👋  
  
Are you looking for a fast, modern, and beautiful way to display text in your cross-platform apps? I'm excited to introduce **B4XDaisyText**—a powerful new custom view designed to bring the elegance of Tailwind CSS and DaisyUI straight into the B4X ecosystem!  
  
![](https://www.b4x.com/android/forum/attachments/172219) ![](https://www.b4x.com/android/forum/attachments/172220) ![](https://www.b4x.com/android/forum/attachments/172221)   
  
This component isn't just another label; it is a fully-featured typography powerhouse. Here is a quick look at what **B4XDaisyText** can do for your UI:  

- **Semantic Color Variants:** Instantly apply DaisyUI-inspired colors like primary, secondary, success, warning, and error without hardcoding hex values.
- **Smart Auto-Sizing:** Forget about text clipping! When set to AutoResize = True, the component dynamically calculates native font metrics and line heights to perfectly fit multiline paragraphs.
- **Rich Styling & Effects:** Easily add *elegant drop shadows*, **neon glow effects**, strikethroughs, and customized letter spacing (kerning).
- **Casing Transformations:** Automatically capitalize, uppercase, or lowercase your text on the fly.
- **Skeleton Loading States:** Built-in skeleton modes to show beautiful placeholder states while your data loads.

🛠️ Getting Started (Beginner Friendly Example!)  
You can add B4XDaisyText directly from the visual designer, but initializing it programmatically is also incredibly easy. Here is a simple snippet showing how to create the component, style it, and trap a click event:  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
     
    ' 1. Declare the component  
    Private myWelcomeText As B4XDaisyText  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_White  
     
    ' 2. Initialize the component (Pass the callback module and Event Name)  
    ' The event name here is "WelcomeText"  
    myWelcomeText.Initialize(Me, "WelcomeText")  
     
    ' 3. Add it to your layout (Parent, Left, Top, Width, Height)  
    myWelcomeText.AddToParent(Root, 20dip, 50dip, Root.Width - 40dip, 60dip)  
     
    ' 4. Set awesome properties!  
    myWelcomeText.Text = "Hello B4X Developers! Click Me."  
    myWelcomeText.TextSize = "text-2xl" ' Tailwind size token  
    myWelcomeText.FontBold = True  
    myWelcomeText.setVariant("primary") ' Uses the Primary semantic color  
    myWelcomeText.AutoResize = True ' Automatically grows height if text wraps  
     
    ' 5. Add a cool shadow (X, Y, Radius, Color)  
    myWelcomeText.ShadowDx = 2  
    myWelcomeText.ShadowDy = 2  
    myWelcomeText.ShadowRadius = 4  
    myWelcomeText.ShadowColor = xui.Color_LightGray  
End Sub  
  
' 6. Trap the Click Event!  
' Matches the EventName "WelcomeText" we defined during Initialize  
Private Sub WelcomeText_Click  
    xui.MsgboxAsync("You clicked the B4XDaisyText component! 🚀", "Success")  
End Sub
```

  
  
*Note: Make sure your component is set to Clickable = True (it is by default!) for the event to fire.*  
  
Let me know what you think of the component in the replies below. Happy coding!  
  
[MEDIA=youtube]2A2zpz0xX3M[/MEDIA]